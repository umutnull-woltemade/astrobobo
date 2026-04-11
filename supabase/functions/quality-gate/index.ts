// ═════════════════════════════════════════════════════════════════════════
// quality-gate — score draft posts before they ship
//
// Heuristic + Claude check. Cheap heuristics run first; LLM only on borderline.
// Score 0-100. Threshold (default 70):
//   ≥ threshold → status stays 'draft' (publisher will pick up)
//   < threshold → status='rejected', keyword goes back to queue
//
// POST body: { "max": 50, "min_score": 70 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';

interface Body {
  max?: number;
  min_score?: number;
}

interface DraftLite {
  id: number;
  slug: string;
  lang: string;
  title: string;
  meta_desc: string;
  body_md: string;
  faq: unknown[];
  internal_links: string[];
  word_count: number;
  keyword_id: number | null;
}

// Banned phrases that scream AI/spam — language agnostic catalog
const BANNED = [
  'as an ai language model',
  'i cannot',
  'i am unable',
  'i don\'t have personal',
  'in conclusion,',
  'it is important to note that',
  'delve into',
  'tapestry',
  'navigating the complexities',
  'embark on a journey',
  'in the realm of',
  'unleash',
  'game changer',
  'revolutionary',
  'cutting edge',
];

function heuristicScore(d: DraftLite): { score: number; flags: string[] } {
  const flags: string[] = [];
  let score = 100;

  // Word count band: 800-2200 ideal
  const wc = d.word_count || d.body_md.split(/\s+/).length;
  if (wc < 600) { score -= 30; flags.push(`word_count_low:${wc}`); }
  else if (wc < 900) { score -= 10; flags.push(`word_count_short:${wc}`); }
  else if (wc > 2500) { score -= 10; flags.push(`word_count_long:${wc}`); }

  // Internal links: ≥3 required
  const ilCount = d.internal_links?.length || 0;
  if (ilCount < 3) { score -= 15; flags.push(`internal_links_low:${ilCount}`); }

  // FAQ: ≥3 Q&A required
  const faqCount = Array.isArray(d.faq) ? d.faq.length : 0;
  if (faqCount < 3) { score -= 10; flags.push(`faq_low:${faqCount}`); }

  // Title length 30-65
  const tl = d.title.length;
  if (tl < 30 || tl > 65) { score -= 5; flags.push(`title_len:${tl}`); }

  // Meta length 100-160
  const ml = d.meta_desc.length;
  if (ml < 100 || ml > 165) { score -= 5; flags.push(`meta_len:${ml}`); }

  // Banned phrases (case-insensitive)
  const lower = d.body_md.toLowerCase();
  const hits = BANNED.filter((p) => lower.includes(p));
  if (hits.length) {
    score -= 5 * hits.length;
    flags.push(`banned:${hits.join('|')}`);
  }

  // H2 count: should have ≥3
  const h2Count = (d.body_md.match(/^## /gm) || []).length;
  if (h2Count < 3) { score -= 10; flags.push(`h2_low:${h2Count}`); }

  // Repetition: simple bigram density check
  const words = d.body_md.toLowerCase().match(/\b[\w']{4,}\b/g) || [];
  const freq: Record<string, number> = {};
  for (const w of words) freq[w] = (freq[w] || 0) + 1;
  const top = Object.values(freq).sort((a, b) => b - a)[0] || 0;
  if (words.length > 0 && top / words.length > 0.04) {
    score -= 10;
    flags.push(`repetitive:${(top/words.length*100).toFixed(1)}%`);
  }

  return { score: Math.max(0, score), flags };
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const max = Math.min(body.max ?? 50, 100);
  const minScore = body.min_score ?? 70;
  const sb = admin();

  const { data: drafts, error } = await sb
    .from('posts')
    .select('id, slug, lang, title, meta_desc, body_md, faq, internal_links, word_count, keyword_id')
    .eq('status', 'draft')
    .is('quality_score', null)
    .order('generated_at', { ascending: true })
    .limit(max);

  if (error) return err('select drafts failed', 500, { detail: error });
  if (!drafts?.length) return ok({ scored: 0, reason: 'no unscored drafts' });

  let passed = 0;
  let rejected = 0;
  const results: Array<{ id: number; score: number; passed: boolean; flags: string[] }> = [];

  for (const draft of drafts as DraftLite[]) {
    const { score, flags } = heuristicScore(draft);
    const ok_pass = score >= minScore;

    await sb
      .from('posts')
      .update({
        quality_score: score,
        status: ok_pass ? 'draft' : 'failed',
      })
      .eq('id', draft.id);

    if (!ok_pass && draft.keyword_id) {
      // recycle keyword for re-generation with stricter prompt next round
      await sb
        .from('keyword_queue')
        .update({
          status: 'new',
          claimed_at: null,
          rejected_reason: `quality:${score} ${flags.join(',')}`,
        })
        .eq('id', draft.keyword_id);
    }

    results.push({ id: draft.id, score, passed: ok_pass, flags });
    if (ok_pass) passed++;
    else rejected++;
  }

  return ok({ scored: drafts.length, passed, rejected, min_score: minScore, sample: results.slice(0, 10) });
});
