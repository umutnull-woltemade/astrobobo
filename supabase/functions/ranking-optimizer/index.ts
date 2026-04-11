// ═════════════════════════════════════════════════════════════════════════
// ranking-optimizer — detect low-CTR pages and rewrite title/meta via A/B
//
// Strategy:
//   - Find posts with impressions > 100 AND ctr < 1% in last 14 days
//   - For each, generate a B variant with Claude
//   - Store in ab_variants; next GSC sync decides winner
//   - After 14 days active: winner decided → write title/meta to posts,
//     mark loser variant with winner=false
//
// POST body: {}  (no args — scans whole table)
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';

interface Opportunity {
  post_id: number;
  slug: string;
  lang: string;
  title: string;
  meta_desc: string;
  h1: string;
  impressions: number;
  ctr: number;
  avg_position: number;
}

interface Variant {
  title: string;
  meta_desc: string;
  reason: string;
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const sb = admin();

  // 1. find opportunities (aggregate last 14 days analytics per post)
  const { data: opps, error } = await sb.rpc('find_ctr_opportunities' as never, {}).select();

  // Fallback if the RPC doesn't exist: raw query
  let rows: Opportunity[];
  if (error) {
    const { data: raw } = await sb
      .from('analytics_daily')
      .select('post_id, slug, lang, impressions, clicks, ctr, avg_position, posts(title,meta_desc,h1)')
      .gte('date', new Date(Date.now() - 14 * 86400 * 1000).toISOString().slice(0, 10))
      .gt('impressions', 100)
      .lt('ctr', 0.01)
      .order('impressions', { ascending: false })
      .limit(20);
    rows = (raw || []).map((r: Record<string, unknown>) => ({
      post_id: r.post_id as number,
      slug: r.slug as string,
      lang: r.lang as string,
      title: ((r.posts as Record<string, unknown>)?.title as string) || '',
      meta_desc: ((r.posts as Record<string, unknown>)?.meta_desc as string) || '',
      h1: ((r.posts as Record<string, unknown>)?.h1 as string) || '',
      impressions: r.impressions as number,
      ctr: r.ctr as number,
      avg_position: r.avg_position as number,
    }));
  } else {
    rows = (opps as unknown) as Opportunity[];
  }

  if (!rows?.length) return ok({ optimized: 0, reason: 'no opportunities' });

  // 2. skip posts already being A/B tested
  const { data: active } = await sb
    .from('ab_variants')
    .select('post_id')
    .is('winner', null)
    .gte('active_from', new Date(Date.now() - 14 * 86400 * 1000).toISOString());

  const activeSet = new Set((active || []).map((a) => a.post_id));
  const candidates = rows.filter((r) => !activeSet.has(r.post_id)).slice(0, 10);

  let optimized = 0;
  const errors: Array<{ post_id: number; error: string }> = [];

  for (const row of candidates) {
    try {
      const variant = await claudeJSON<Variant>({
        system: `You are a CTR optimization expert. Rewrite titles and meta descriptions
to maximize click-through-rate without clickbait. Keep the main keyword.
Match the language of the original.`,
        user: `Original title: "${row.title}"
Original meta: "${row.meta_desc}"
Current CTR: ${(row.ctr * 100).toFixed(2)}% over ${row.impressions} impressions
Avg position: ${row.avg_position}

OUTPUT strict JSON:
{"title":"new title max 60 chars","meta_desc":"new meta max 155 chars","reason":"one-line why"}`,
        maxTokens: 500,
        temperature: 0.8,
      });

      // store A (original) + B (new)
      await sb.from('ab_variants').insert([
        {
          post_id: row.post_id,
          variant: 'A',
          title: row.title,
          meta_desc: row.meta_desc,
          active_from: new Date().toISOString(),
        },
        {
          post_id: row.post_id,
          variant: 'B',
          title: variant.title,
          meta_desc: variant.meta_desc,
          active_from: new Date().toISOString(),
        },
      ]);

      optimized++;
    } catch (e) {
      errors.push({ post_id: row.post_id, error: (e as Error).message });
    }
  }

  return ok({ optimized, candidates: candidates.length, errors: errors.slice(0, 5) });
});
