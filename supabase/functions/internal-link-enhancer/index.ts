// ═════════════════════════════════════════════════════════════════════════
// internal-link-enhancer — when a new post ships, retroactively wire it
// into the link graph of related posts
//
// Strategy:
//   - For each "anchor" post published in last 7 days
//   - Find 5 sibling posts (same cluster, same lang) that have <8 internal_links
//     and don't already link to anchor
//   - Append a contextual sentence with link near a relevant H2
//   - Commit updates
//
// POST body: { "max_anchors": 10 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody, now } from '../_shared/supabase.ts';
import { commitFile } from '../_shared/github.ts';

interface Body {
  max_anchors?: number;
}

interface Post {
  id: number;
  slug: string;
  lang: string;
  cluster: string;
  title: string;
  h1: string;
  body_md: string;
  internal_links: string[];
}

const SITE_ORIGIN = Deno.env.get('SITE_ORIGIN') || 'https://astrobobo.com';
const FUNCTIONS_URL = Deno.env.get('SUPABASE_URL')?.replace('.supabase.co', '.functions.supabase.co') ?? '';
const SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const maxAnchors = Math.min(body.max_anchors ?? 10, 30);
  const sb = admin();

  const sevenDaysAgo = new Date(Date.now() - 7 * 86400 * 1000).toISOString();

  const { data: anchors, error } = await sb
    .from('posts')
    .select('id, slug, lang, cluster, title, h1, body_md, internal_links')
    .eq('status', 'published')
    .gte('published_at', sevenDaysAgo)
    .order('published_at', { ascending: false })
    .limit(maxAnchors);

  if (error) return err('select anchors failed', 500, { detail: error });
  if (!anchors?.length) return ok({ enhanced: 0, reason: 'no recent anchors' });

  let enhanced = 0;
  const failed: Array<{ id: number; error: string }> = [];
  const updated_slugs: string[] = [];

  for (const anchor of anchors as Post[]) {
    try {
      // Find candidate siblings
      const { data: siblings } = await sb
        .from('posts')
        .select('id, slug, lang, cluster, title, h1, body_md, internal_links')
        .eq('status', 'published')
        .eq('lang', anchor.lang)
        .eq('cluster', anchor.cluster)
        .neq('id', anchor.id)
        .lt('internal_link_count', 8)
        .limit(5);

      if (!siblings?.length) continue;

      for (const sib of siblings as Post[]) {
        // already links?
        if (sib.internal_links?.includes(anchor.slug)) continue;

        // Build link sentence
        const linkSentence = anchor.lang === 'tr'
          ? `> İlgili: [${anchor.title}](${SITE_ORIGIN}/r/${anchor.lang}/${anchor.slug}) — bu konuyla bağlantılı detaylı bir yazı.`
          : `> Related: [${anchor.title}](${SITE_ORIGIN}/r/${anchor.lang}/${anchor.slug}) — a deeper related read.`;

        // Insert before final disclaimer paragraph (italic line starting with *)
        const lines = sib.body_md.split('\n');
        let insertAt = -1;
        for (let i = lines.length - 1; i >= 0; i--) {
          const t = lines[i].trim();
          if (t.startsWith('*') && t.endsWith('*') && t.length > 2) {
            insertAt = i;
            break;
          }
        }
        if (insertAt === -1) {
          // append before EOF
          insertAt = lines.length;
        }
        const newLines = [...lines.slice(0, insertAt), '', linkSentence, '', ...lines.slice(insertAt)];
        const newBody = newLines.join('\n');

        // bump updated_at
        const today = new Date().toISOString().slice(0, 10);
        const newBodyWithDate = newBody.replace(/updated_at:\s*"[^"]*"/, `updated_at: "${today}"`);

        const path = `content/${sib.lang}/${sib.slug}.md`;
        const commit = await commitFile({
          path,
          content: newBodyWithDate,
          message: `content: link ${sib.slug} → ${anchor.slug} [${sib.lang}]`,
        });

        await sb
          .from('posts')
          .update({
            body_md: newBodyWithDate,
            internal_links: [...(sib.internal_links || []), anchor.slug],
            git_sha: commit.sha,
          })
          .eq('id', sib.id);

        updated_slugs.push(`${sib.lang}/${sib.slug}`);
        enhanced++;
      }
    } catch (e) {
      failed.push({ id: anchor.id, error: (e as Error).message });
    }
  }

  // Chain indexer
  if (enhanced > 0 && FUNCTIONS_URL && SERVICE_KEY) {
    try {
      await fetch(`${FUNCTIONS_URL}/indexer`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${SERVICE_KEY}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ slugs: updated_slugs }),
      });
    } catch (_) {
      // non-fatal
    }
  }

  return ok({ enhanced, anchors: anchors.length, failed: failed.length, errors: failed.slice(0, 5) });
});
