// ═════════════════════════════════════════════════════════════════════════
// viral-gen — short-form social drafts for each new post
//
// Channels: tiktok, instagram, x (twitter), youtube_shorts, threads
// Drafts go to viral_drafts.status='pending' for human approval.
//
// POST body: { "lookback_hours": 24 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';

interface Body {
  lookback_hours?: number;
}

interface ViralOutput {
  tiktok: { hook: string; script_md: string; hashtags: string[]; duration_s: number };
  instagram: { hook: string; script_md: string; hashtags: string[]; duration_s: number };
  x: { hook: string; script_md: string; hashtags: string[] };
  youtube_shorts: { hook: string; script_md: string; hashtags: string[]; duration_s: number };
  threads: { hook: string; script_md: string; hashtags: string[] };
}

const SITE_ORIGIN = Deno.env.get('SITE_ORIGIN') || 'https://astrobobo.com';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const hours = body.lookback_hours ?? 24;
  const sb = admin();

  const { data: posts, error } = await sb
    .from('posts')
    .select('id, slug, lang, title, meta_desc, h1, cluster, body_md')
    .eq('status', 'published')
    .gte('published_at', new Date(Date.now() - hours * 3600 * 1000).toISOString())
    .limit(20);

  if (error) return err('select posts failed', 500, { detail: error });
  if (!posts?.length) return ok({ drafts: 0, reason: 'no recent publishes' });

  // skip posts that already have viral drafts
  const { data: existing } = await sb
    .from('viral_drafts')
    .select('post_id')
    .in('post_id', posts.map((p) => p.id));
  const have = new Set((existing || []).map((e) => e.post_id));
  const todo = posts.filter((p) => !have.has(p.id));

  let drafts_created = 0;
  const errors: Array<{ post_id: number; error: string }> = [];

  for (const post of todo) {
    try {
      const url = `${SITE_ORIGIN}/r/${post.lang}/${post.slug}`;
      // First 800 chars of body for context
      const excerpt = post.body_md
        .replace(/^---[\s\S]*?---/, '')
        .replace(/[#*_>-]/g, '')
        .replace(/\s+/g, ' ')
        .trim()
        .slice(0, 800);

      const drafts = await claudeJSON<ViralOutput>({
        system: `You write short-form social content that drives traffic to a long-form article.
You write for the same language as the source. You use bold hooks but no clickbait lies.
Hashtags must be relevant and currently trending in that language's astro/spirituality space.`,
        user: `Source post: "${post.title}"
Topic cluster: ${post.cluster}
Language: ${post.lang}
URL: ${url}
Excerpt: ${excerpt}

Generate 5 social drafts. Output strict JSON:
{
  "tiktok":     {"hook":"first 3 sec hook","script_md":"30-45 second script with scene cues","hashtags":["#tag1","#tag2"],"duration_s":40},
  "instagram":  {"hook":"first line","script_md":"15-30 second reel script","hashtags":["#tag1","#tag2"],"duration_s":25},
  "x":          {"hook":"thread hook tweet","script_md":"3-5 tweet thread, separated by ---","hashtags":["#tag1"]},
  "youtube_shorts": {"hook":"first 2 sec","script_md":"55-60 second script","hashtags":["#tag1"],"duration_s":58},
  "threads":    {"hook":"first line","script_md":"4-6 thread post, separated by ---","hashtags":["#tag1"]}
}

RULES:
- Each script ends with a CTA mentioning the article (use phrases like "full read in bio" or "more on the site").
- No fake claims, no scary clickbait.
- Hashtags 4-8 per channel.`,
        maxTokens: 4000,
        temperature: 0.75,
      });

      const rows = [
        { channel: 'tiktok',         ...drafts.tiktok },
        { channel: 'instagram',      ...drafts.instagram },
        { channel: 'x',              ...drafts.x, duration_s: null },
        { channel: 'youtube_shorts', ...drafts.youtube_shorts },
        { channel: 'threads',        ...drafts.threads, duration_s: null },
      ].map((r) => ({
        post_id: post.id,
        channel: r.channel,
        hook: r.hook,
        script_md: r.script_md,
        hashtags: r.hashtags,
        cta_url: url,
        duration_s: r.duration_s ?? null,
        status: 'pending' as const,
      }));

      await sb.from('viral_drafts').insert(rows);
      drafts_created += rows.length;
    } catch (e) {
      errors.push({ post_id: post.id, error: (e as Error).message });
    }
  }

  return ok({ drafts_created, posts_processed: todo.length, errors: errors.slice(0, 5) });
});
