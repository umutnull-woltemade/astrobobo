// ═════════════════════════════════════════════════════════════════════════
// citation-tracker — log + query citation events
//
// Multi-mode endpoint:
//   POST {action:"log", source, query, cited_url, snippet}    → insert row
//   POST {action:"top",  days:30, limit:20}                   → top cited posts
//   POST {action:"by_source", source, days:30}                → group by source
//
// Used by:
//   - Manual hand-logging when you spot a citation in ChatGPT/Perplexity
//   - Automated webhook from a separate scraper
//   - Internal admin dashboard
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';

interface LogBody {
  action: 'log';
  source: string;
  query?: string;
  cited_url: string;
  snippet?: string;
  raw?: Record<string, unknown>;
}

interface TopBody {
  action: 'top';
  days?: number;
  limit?: number;
}

interface BySourceBody {
  action: 'by_source';
  source?: string;
  days?: number;
}

type Body = LogBody | TopBody | BySourceBody;

const VALID_SOURCES = ['chatgpt','perplexity','google_ai_overview','bing_chat','bard','claude','gemini','copilot','meta_ai','manual'];

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const sb = admin();

  switch (body.action) {
    case 'log': {
      if (!body.source || !body.cited_url) return err('source and cited_url required', 400);
      if (!VALID_SOURCES.includes(body.source)) return err(`source must be one of: ${VALID_SOURCES.join(', ')}`, 400);

      // Try to resolve URL → post_id
      let post_id: number | null = null;
      const m = body.cited_url.match(/\/r\/([a-z\-]+)\/([^/?#]+)/);
      if (m) {
        const [, lang, slug] = m;
        const { data: post } = await sb
          .from('posts')
          .select('id')
          .eq('lang', lang)
          .eq('slug', slug)
          .maybeSingle();
        if (post) post_id = post.id;
      }

      const { error } = await sb.from('citation_events').insert({
        post_id,
        source: body.source,
        query: body.query,
        cited_url: body.cited_url,
        snippet: body.snippet,
        raw: body.raw || {},
      });
      if (error) return err('insert failed', 500, { detail: error });

      // Increment cached counter on the post
      if (post_id) {
        const { error: updErr } = await sb.rpc('increment_citation_count' as never, { p_post_id: post_id }).select();
        if (updErr) {
          // Fallback: manual update
          const { data: cur } = await sb.from('posts').select('citation_count').eq('id', post_id).maybeSingle();
          await sb.from('posts').update({ citation_count: (cur?.citation_count || 0) + 1 }).eq('id', post_id);
        }
      }

      return ok({ logged: true, post_id });
    }

    case 'top': {
      const days = body.days ?? 30;
      const limit = Math.min(body.limit ?? 20, 100);
      const since = new Date(Date.now() - days * 86400 * 1000).toISOString();

      const { data, error } = await sb
        .from('citation_events')
        .select('post_id, source, count:post_id')
        .gte('detected_at', since)
        .not('post_id', 'is', null);

      if (error) return err('select failed', 500, { detail: error });

      // Aggregate manually (Supabase JS doesn't expose group by directly)
      const counts: Record<string, { post_id: number; count: number; sources: Set<string> }> = {};
      for (const row of data || []) {
        const k = String(row.post_id);
        if (!counts[k]) counts[k] = { post_id: row.post_id as number, count: 0, sources: new Set() };
        counts[k].count++;
        counts[k].sources.add(row.source as string);
      }

      const top = Object.values(counts)
        .sort((a, b) => b.count - a.count)
        .slice(0, limit);

      // Hydrate post details
      const ids = top.map((t) => t.post_id);
      const { data: posts } = await sb
        .from('posts')
        .select('id, slug, lang, title, citation_count')
        .in('id', ids);

      const postMap = new Map((posts || []).map((p) => [p.id, p]));

      return ok({
        days,
        top: top.map((t) => ({
          ...postMap.get(t.post_id),
          recent_citations: t.count,
          sources: [...t.sources],
        })),
      });
    }

    case 'by_source': {
      const days = body.days ?? 30;
      const since = new Date(Date.now() - days * 86400 * 1000).toISOString();
      let q = sb.from('citation_events').select('source, detected_at').gte('detected_at', since);
      if (body.source) q = q.eq('source', body.source);
      const { data, error } = await q;
      if (error) return err('select failed', 500, { detail: error });

      const counts: Record<string, number> = {};
      for (const row of data || []) {
        counts[row.source] = (counts[row.source] || 0) + 1;
      }
      return ok({ days, by_source: counts });
    }

    default:
      return err('unknown action — use log|top|by_source', 400);
  }
});
