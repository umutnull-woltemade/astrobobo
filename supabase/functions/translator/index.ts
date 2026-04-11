// ═════════════════════════════════════════════════════════════════════════
// translator — translate published posts to other languages
//
// Strategy:
//   1. Pick high-performing posts in source langs (TR/EN) without target translation
//   2. For each, translate to all configured targets via Claude
//   3. Insert as new draft posts (translated_from=source.id, status='draft')
//   4. content quality-gate + publisher pipeline picks them up
//   5. translations table tracks lineage
//
// POST body: {
//   "source_lang": "tr"|"en",
//   "target_langs": ["es","de","fr","it","pt-br"],
//   "max": 5
// }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';

interface Body {
  source_lang?: string;
  target_langs?: string[];
  max?: number;
}

interface SourcePost {
  id: number;
  slug: string;
  lang: string;
  cluster: string;
  title: string;
  meta_desc: string;
  h1: string;
  body_md: string;
  faq: unknown[];
  internal_links: string[];
}

interface Translated {
  title: string;
  meta_desc: string;
  h1: string;
  body_md: string;
  word_count: number;
}

const DEFAULT_TARGETS = ['es', 'de', 'fr', 'it', 'pt-br'];

const LANG_NAMES: Record<string, string> = {
  tr: 'Turkish', en: 'English', es: 'Spanish', de: 'German',
  fr: 'French', it: 'Italian', 'pt-br': 'Brazilian Portuguese',
  ru: 'Russian', ar: 'Arabic',
};

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const sourceLang = body.source_lang || 'tr';
  const targetLangs = body.target_langs || DEFAULT_TARGETS;
  const max = Math.min(body.max ?? 5, 20);
  const sb = admin();

  // Find candidates: published posts in sourceLang that don't have target translations yet
  const { data: candidates, error } = await sb
    .from('posts')
    .select('id, slug, lang, cluster, title, meta_desc, h1, body_md, faq, internal_links')
    .eq('status', 'published')
    .eq('lang', sourceLang)
    .order('published_at', { ascending: true })
    .limit(max * 3); // pick wider, filter

  if (error) return err('select source posts failed', 500, { detail: error });
  if (!candidates?.length) return ok({ translated: 0, reason: 'no source posts' });

  // For each, check which target langs already have a translation
  const todo: Array<{ src: SourcePost; targets: string[] }> = [];
  for (const c of candidates as SourcePost[]) {
    const { data: existing } = await sb
      .from('translations')
      .select('target_lang')
      .eq('source_post_id', c.id);
    const have = new Set((existing || []).map((e) => e.target_lang));
    const need = targetLangs.filter((l) => !have.has(l) && l !== c.lang);
    if (need.length) todo.push({ src: c, targets: need });
    if (todo.length >= max) break;
  }

  if (!todo.length) return ok({ translated: 0, reason: 'all sources already translated' });

  let translated = 0;
  const errors: Array<{ src_id: number; target: string; error: string }> = [];

  for (const { src, targets } of todo) {
    for (const target of targets) {
      try {
        const t = await claudeJSON<Translated>({
          system: `You are a senior literary translator specializing in ${LANG_NAMES[target]}.
You translate astrology and dream-interpretation articles. You preserve markdown structure
exactly: frontmatter (with lang/route updated), H1, H2, lists, bold, italics. You keep
internal links unchanged. You translate the disclaimer. You localize idioms appropriately.`,
          user: `Translate this article from ${LANG_NAMES[src.lang]} to ${LANG_NAMES[target]}.

Keep:
- Slug exactly: "${src.slug}"
- All markdown structure (## H2, lists, **bold**, links)
- Internal link slugs (don't translate URLs)
- Schema/frontmatter format
- Section count and order

Update:
- frontmatter lang to "${target}"
- updated_at to today
- All natural language

ORIGINAL:
${src.body_md}

OUTPUT strict JSON:
{
  "title": "translated title 50-65 chars",
  "meta_desc": "translated meta 100-155 chars",
  "h1": "translated H1",
  "body_md": "complete translated markdown including frontmatter",
  "word_count": 1500
}`,
          maxTokens: 7000,
          temperature: 0.4,
        });

        // Insert translated draft
        const { data: newPost, error: insErr } = await sb
          .from('posts')
          .upsert(
            {
              slug: src.slug,
              lang: target,
              cluster: src.cluster,
              title: t.title,
              meta_desc: t.meta_desc,
              h1: t.h1,
              body_md: t.body_md,
              faq: src.faq,
              internal_links: src.internal_links,
              word_count: t.word_count || t.body_md.split(/\s+/).length,
              status: 'draft',
              model_used: 'claude-opus-4-6',
              translated_from: src.id,
            },
            { onConflict: 'slug,lang' },
          )
          .select('id')
          .maybeSingle();

        if (insErr) throw new Error(`insert: ${insErr.message}`);

        // Log translation lineage
        if (newPost) {
          await sb.from('translations').insert({
            source_post_id: src.id,
            target_post_id: newPost.id,
            source_lang: src.lang,
            target_lang: target,
            model: 'claude-opus-4-6',
          });
        }

        translated++;
      } catch (e) {
        errors.push({ src_id: src.id, target, error: (e as Error).message });
      }
    }
  }

  return ok({ translated, candidates: todo.length, errors: errors.slice(0, 5) });
});
