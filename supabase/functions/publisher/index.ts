// ═════════════════════════════════════════════════════════════════════════
// publisher — commit drafts to git, mark published, chain indexer
//
// POST body: { "max": 30 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody, now } from '../_shared/supabase.ts';
import { commitFile } from '../_shared/github.ts';

interface Body {
  max?: number;
}

const FUNCTIONS_URL = Deno.env.get('SUPABASE_URL')?.replace('.supabase.co', '.functions.supabase.co') ?? '';
const SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const max = Math.min(body.max ?? 30, 50);
  const sb = admin();

  const { data: drafts, error } = await sb
    .from('posts')
    .select('id, slug, lang, title, body_md, keyword_id')
    .eq('status', 'draft')
    .order('generated_at', { ascending: true })
    .limit(max);

  if (error) return err('select drafts failed', 500, { detail: error });
  if (!drafts?.length) return ok({ published: 0, reason: 'no drafts' });

  let published = 0;
  const failed: Array<{ id: number; error: string }> = [];
  const published_slugs: string[] = [];

  for (const post of drafts) {
    try {
      const path = `content/${post.lang}/${post.slug}.md`;
      const commit = await commitFile({
        path,
        content: post.body_md,
        message: `content: publish ${post.slug} [${post.lang}]`,
      });

      await sb
        .from('posts')
        .update({
          status: 'published',
          published_at: now(),
          git_sha: commit.sha,
          commit_url: commit.html_url,
        })
        .eq('id', post.id);

      if (post.keyword_id) {
        await sb.from('keyword_queue').update({ status: 'published' }).eq('id', post.keyword_id);
      }

      published_slugs.push(`${post.lang}/${post.slug}`);
      published++;
    } catch (e) {
      const msg = (e as Error).message;
      failed.push({ id: post.id, error: msg });
      await sb.from('posts').update({ status: 'failed' }).eq('id', post.id);
    }
  }

  // Chain indexer (fire-and-forget)
  if (published > 0 && FUNCTIONS_URL && SERVICE_KEY) {
    try {
      await fetch(`${FUNCTIONS_URL}/indexer`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${SERVICE_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ slugs: published_slugs }),
      });
    } catch (e) {
      console.warn('[publisher] indexer chain failed', (e as Error).message);
    }
  }

  return ok({ published, failed: failed.length, errors: failed.slice(0, 5) });
});
