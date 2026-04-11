// ═════════════════════════════════════════════════════════════════════════
// content-refresh — periodically rewrite stale posts to keep dateModified fresh
//
// Strategy:
//   - Pick posts where last_refreshed_at IS NULL OR < now() - 60 days
//   - Lower priority bias for: posts with declining position
//   - Send body_md + analytics summary to Claude → get refreshed body
//   - New body must preserve canonical slug, h1, schema; updated_at bumped
//   - Commit to git; content_refresh_log entry; chain indexer
//
// POST body: { "max": 5 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody, now } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';
import { commitFile } from '../_shared/github.ts';

interface Body {
  max?: number;
}

interface PostRow {
  id: number;
  slug: string;
  lang: string;
  title: string;
  meta_desc: string;
  h1: string;
  body_md: string;
  word_count: number;
  cluster: string;
  last_refreshed_at: string | null;
  published_at: string;
}

interface Refreshed {
  body_md: string;
  meta_desc: string;
  diff_summary: string;
  word_count: number;
}

const FUNCTIONS_URL = Deno.env.get('SUPABASE_URL')?.replace('.supabase.co', '.functions.supabase.co') ?? '';
const SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
const SIXTY_DAYS_AGO = () => new Date(Date.now() - 60 * 86400 * 1000).toISOString();

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const max = Math.min(body.max ?? 5, 20);
  const sb = admin();

  // Candidates: never refreshed OR older than 60 days
  const { data: candidates, error } = await sb
    .from('posts')
    .select('id,slug,lang,title,meta_desc,h1,body_md,word_count,cluster,last_refreshed_at,published_at')
    .eq('status', 'published')
    .or(`last_refreshed_at.is.null,last_refreshed_at.lt.${SIXTY_DAYS_AGO()}`)
    .order('published_at', { ascending: true })
    .limit(max);

  if (error) return err('select failed', 500, { detail: error });
  if (!candidates?.length) return ok({ refreshed: 0, reason: 'no stale posts' });

  let refreshed = 0;
  const errors: Array<{ id: number; error: string }> = [];
  const refreshed_slugs: string[] = [];

  for (const post of candidates as PostRow[]) {
    try {
      // Pull recent analytics to bias the refresh
      const { data: analytics } = await sb
        .from('analytics_daily')
        .select('impressions,clicks,ctr,avg_position')
        .eq('post_id', post.id)
        .gte('date', new Date(Date.now() - 30 * 86400 * 1000).toISOString().slice(0, 10))
        .order('date', { ascending: false })
        .limit(30);

      const aSum = (analytics || []).reduce(
        (acc, r) => ({
          impressions: acc.impressions + (r.impressions || 0),
          clicks: acc.clicks + (r.clicks || 0),
          position: acc.position + (r.avg_position || 0),
          n: acc.n + 1,
        }),
        { impressions: 0, clicks: 0, position: 0, n: 0 },
      );
      const avgPos = aSum.n ? (aSum.position / aSum.n).toFixed(1) : 'n/a';

      const refreshedDoc = await claudeJSON<Refreshed>({
        system: `You refresh existing SEO articles. Rules:
- Keep H1 exactly. Keep all H2 section headers (you may add 1 new section).
- Keep frontmatter intact.
- Update factual phrasing where stale.
- Tighten weak paragraphs. Keep length 1200-1800 words.
- Preserve internal links and disclaimer.
- Match the original language of the article.`,
        user: `Refresh this article. It currently ranks at avg position ${avgPos} with ${aSum.impressions} impressions and ${aSum.clicks} clicks (last 30 days).

ORIGINAL (markdown):
${post.body_md}

OUTPUT strict JSON:
{
  "body_md": "complete new markdown including frontmatter, H1, all sections, summary, disclaimer",
  "meta_desc": "new meta description max 155 chars (may be same if already great)",
  "diff_summary": "one sentence describing what changed",
  "word_count": 1500
}`,
        maxTokens: 7000,
        temperature: 0.5,
      });

      // Bump updated_at in frontmatter to today
      const today = new Date().toISOString().slice(0, 10);
      const newBody = refreshedDoc.body_md.replace(
        /updated_at:\s*"[^"]*"/,
        `updated_at: "${today}"`,
      );

      // Commit
      const path = `content/${post.lang}/${post.slug}.md`;
      const commit = await commitFile({
        path,
        content: newBody,
        message: `content: refresh ${post.slug} [${post.lang}] — ${refreshedDoc.diff_summary}`,
      });

      // Update DB
      await sb
        .from('posts')
        .update({
          body_md: newBody,
          meta_desc: refreshedDoc.meta_desc,
          word_count: refreshedDoc.word_count || newBody.split(/\s+/).length,
          last_refreshed_at: now(),
          git_sha: commit.sha,
          commit_url: commit.html_url,
        })
        .eq('id', post.id);

      await sb.from('content_refresh_log').insert({
        post_id: post.id,
        trigger: post.last_refreshed_at ? 'age' : 'first_refresh',
        prev_word_count: post.word_count,
        new_word_count: refreshedDoc.word_count,
        prev_position: aSum.n ? aSum.position / aSum.n : null,
        diff_summary: refreshedDoc.diff_summary,
        git_sha: commit.sha,
      });

      refreshed_slugs.push(`${post.lang}/${post.slug}`);
      refreshed++;
    } catch (e) {
      errors.push({ id: post.id, error: (e as Error).message });
    }
  }

  // Chain indexer
  if (refreshed > 0 && FUNCTIONS_URL && SERVICE_KEY) {
    try {
      await fetch(`${FUNCTIONS_URL}/indexer`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${SERVICE_KEY}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ slugs: refreshed_slugs }),
      });
    } catch (e) {
      console.warn('[content-refresh] indexer chain failed', (e as Error).message);
    }
  }

  return ok({ refreshed, failed: errors.length, errors: errors.slice(0, 5) });
});
