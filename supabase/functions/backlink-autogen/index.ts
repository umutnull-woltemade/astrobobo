// ═════════════════════════════════════════════════════════════════════════
// backlink-autogen — draft outreach content for each new post
//
// For each post published in last N hours, generate drafts for:
//   - medium      (full article, 600-900 words, teaser → link)
//   - reddit      (short post, conversational, links in comment)
//   - quora       (answer format, 300-500 words)
//
// Drafts go to backlink_tasks.status='pending' — human approves & posts.
// Auto-posting = spam risk. KEEP HUMAN IN THE LOOP.
//
// POST body: { "lookback_hours": 24 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';

interface Body {
  lookback_hours?: number;
}

interface Drafts {
  medium: { title: string; body_md: string };
  reddit: { title: string; subreddit: string; body_md: string };
  quora:  { question: string; answer_md: string };
}

const SITE_ORIGIN = Deno.env.get('SITE_ORIGIN') || 'https://astrobobo.com';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const hours = body.lookback_hours ?? 24;
  const sb = admin();

  const { data: posts, error } = await sb
    .from('posts')
    .select('id, slug, lang, title, meta_desc, h1, cluster')
    .eq('status', 'published')
    .gte('published_at', new Date(Date.now() - hours * 3600 * 1000).toISOString())
    .limit(20);

  if (error) return err('select posts failed', 500, { detail: error });
  if (!posts?.length) return ok({ drafts: 0, reason: 'no recent publishes' });

  // skip posts that already have backlink drafts
  const { data: existing } = await sb
    .from('backlink_tasks')
    .select('post_id')
    .in('post_id', posts.map((p) => p.id));
  const have = new Set((existing || []).map((e) => e.post_id));
  const todo = posts.filter((p) => !have.has(p.id));

  let drafts_created = 0;
  const errors: Array<{ post_id: number; error: string }> = [];

  for (const post of todo) {
    try {
      const url = `${SITE_ORIGIN}/r/${post.lang}/${post.slug}`;
      const drafts = await claudeJSON<Drafts>({
        system: `You write outreach drafts that provide value first, link second.
No spam. No clickbait. Sound like a real person sharing knowledge.
Match the language of the source post.`,
        user: `Source post: "${post.title}"
Meta: ${post.meta_desc}
URL: ${url}
Language: ${post.lang}
Topic cluster: ${post.cluster}

Generate 3 outreach drafts. Output strict JSON:
{
  "medium": {
    "title": "Medium article title (different from source, 50-70 chars)",
    "body_md": "600-900 word article that explores the topic from a personal angle, ends with a 'Further reading' link to ${url}"
  },
  "reddit": {
    "title": "Reddit post title (question or observation, 60-120 chars)",
    "subreddit": "${post.lang === 'tr' ? 'astroloji or Turkey' : 'astrology or Dreams'}",
    "body_md": "200-400 word post that starts a discussion. No link in body — add in top comment: 'I wrote more about this here: ${url}'"
  },
  "quora": {
    "question": "Natural question a user might ask about this topic",
    "answer_md": "300-500 word answer that provides real value, ends with 'For a deeper dive, I put together this guide: ${url}'"
  }
}`,
        maxTokens: 3500,
        temperature: 0.7,
      });

      await sb.from('backlink_tasks').insert([
        { post_id: post.id, channel: 'medium', title: drafts.medium.title, draft_md: drafts.medium.body_md, status: 'pending' },
        { post_id: post.id, channel: 'reddit', title: drafts.reddit.title, draft_md: drafts.reddit.body_md, target_url: `r/${drafts.reddit.subreddit}`, status: 'pending' },
        { post_id: post.id, channel: 'quora', title: drafts.quora.question, draft_md: drafts.quora.answer_md, status: 'pending' },
      ]);

      drafts_created += 3;
    } catch (e) {
      errors.push({ post_id: post.id, error: (e as Error).message });
    }
  }

  return ok({ drafts_created, posts_processed: todo.length, errors: errors.slice(0, 5) });
});
