// ═════════════════════════════════════════════════════════════════════════
// monetization-injector — append affiliate / sponsor blocks to posts
//
// Strategy:
//   - Pick published posts in clusters that have active monetization_links
//   - For each, inject a single contextual link block before the disclaimer
//   - Mark posts.has_monetization=true
//   - Commit updated md to git
//
// POST body: { "max": 20 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { commitFile } from '../_shared/github.ts';

interface Body {
  max?: number;
}

interface Post {
  id: number;
  slug: string;
  lang: string;
  cluster: string;
  body_md: string;
}

interface MonLink {
  id: number;
  cluster: string;
  lang: string;
  anchor: string;
  url: string;
  partner: string | null;
  rel: string;
}

const FUNCTIONS_URL = Deno.env.get('SUPABASE_URL')?.replace('.supabase.co', '.functions.supabase.co') ?? '';
const SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

const HEADER_LABELS: Record<string, string> = {
  tr: 'Devamı için',
  en: 'Continue exploring',
  es: 'Sigue explorando',
  de: 'Vertiefe das Thema',
  fr: 'Pour aller plus loin',
  it: 'Per approfondire',
  'pt-br': 'Continue explorando',
};

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const max = Math.min(body.max ?? 20, 50);
  const sb = admin();

  // Active monetization links
  const { data: links } = await sb
    .from('monetization_links')
    .select('id, cluster, lang, anchor, url, partner, rel')
    .eq('active', true);

  if (!links?.length) return ok({ injected: 0, reason: 'no active monetization links' });

  // Group links by cluster+lang
  const linkMap = new Map<string, MonLink[]>();
  for (const l of links as MonLink[]) {
    const k = `${l.cluster}|${l.lang}`;
    if (!linkMap.has(k)) linkMap.set(k, []);
    linkMap.get(k)!.push(l);
  }

  // Posts without monetization yet, only in clusters that have links
  const clusters = [...new Set(links.map((l) => l.cluster))];
  const langs = [...new Set(links.map((l) => l.lang))];

  const { data: posts, error } = await sb
    .from('posts')
    .select('id, slug, lang, cluster, body_md')
    .eq('status', 'published')
    .eq('has_monetization', false)
    .in('cluster', clusters)
    .in('lang', langs)
    .limit(max);

  if (error) return err('select posts failed', 500, { detail: error });
  if (!posts?.length) return ok({ injected: 0, reason: 'no eligible posts' });

  let injected = 0;
  const failed: Array<{ post_id: number; error: string }> = [];
  const updated_slugs: string[] = [];

  for (const post of posts as Post[]) {
    try {
      const candidates = linkMap.get(`${post.cluster}|${post.lang}`);
      if (!candidates?.length) continue;

      // Pick rotating link (slug hash → index)
      const idx = simpleHash(post.slug) % candidates.length;
      const link = candidates[idx];

      const header = HEADER_LABELS[post.lang] || HEADER_LABELS.en;
      const block = `\n## ${header}\n\n→ <a href="${link.url}" rel="${link.rel}" target="_blank">${link.anchor}</a>\n\n`;

      // Insert before final disclaimer (italic line)
      const lines = post.body_md.split('\n');
      let insertAt = -1;
      for (let i = lines.length - 1; i >= 0; i--) {
        const t = lines[i].trim();
        if (t.startsWith('*') && t.endsWith('*') && t.length > 2) {
          insertAt = i;
          break;
        }
      }
      if (insertAt === -1) insertAt = lines.length;

      const newLines = [...lines.slice(0, insertAt), block.trim(), '', ...lines.slice(insertAt)];
      const newBody = newLines.join('\n');

      // Bump updated_at
      const today = new Date().toISOString().slice(0, 10);
      const newBodyWithDate = newBody.replace(/updated_at:\s*"[^"]*"/, `updated_at: "${today}"`);

      // Commit
      const path = `content/${post.lang}/${post.slug}.md`;
      const commit = await commitFile({
        path,
        content: newBodyWithDate,
        message: `content: monetize ${post.slug} [${post.lang}] — ${link.partner || 'sponsor'}`,
      });

      // Update DB
      await sb
        .from('posts')
        .update({
          body_md: newBodyWithDate,
          has_monetization: true,
          git_sha: commit.sha,
        })
        .eq('id', post.id);

      updated_slugs.push(`${post.lang}/${post.slug}`);
      injected++;
    } catch (e) {
      failed.push({ post_id: post.id, error: (e as Error).message });
    }
  }

  // Chain indexer
  if (injected > 0 && FUNCTIONS_URL && SERVICE_KEY) {
    try {
      await fetch(`${FUNCTIONS_URL}/indexer`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${SERVICE_KEY}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ slugs: updated_slugs }),
      });
    } catch (_) { /* non-fatal */ }
  }

  return ok({ injected, failed: failed.length, errors: failed.slice(0, 5) });
});

function simpleHash(s: string): number {
  let h = 0;
  for (let i = 0; i < s.length; i++) h = ((h << 5) - h + s.charCodeAt(i)) | 0;
  return Math.abs(h);
}
