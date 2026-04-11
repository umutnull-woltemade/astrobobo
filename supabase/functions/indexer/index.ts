// ═════════════════════════════════════════════════════════════════════════
// indexer — ping search engines after publish
//
// - IndexNow (Bing + Yandex + Seznam) — one POST, instant acceptance
// - Google: no push API for consumer; sitemap crawl is the path. We ping
//   sitemap URL via Search Console API if GSC_* envs present.
// - No sitemap write here — the GitHub Action rebuilds sitemap.xml from
//   content/**/*.md as part of seo-build.yml.
//
// POST body: { "slugs": ["tr/ruyada-yilan","en/dream-about-snake"] }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';

interface Body {
  slugs?: string[];
}

const SITE_ORIGIN = Deno.env.get('SITE_ORIGIN') || 'https://astrobobo.com';
const INDEXNOW_KEY = Deno.env.get('INDEXNOW_KEY') || '';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const sb = admin();

  let slugs = body.slugs;

  // If no slugs provided, use posts published in last 6 hours
  if (!slugs?.length) {
    const { data } = await sb
      .from('posts')
      .select('lang, slug')
      .eq('status', 'published')
      .gte('published_at', new Date(Date.now() - 6 * 3600 * 1000).toISOString())
      .limit(100);
    slugs = (data || []).map((p) => `${p.lang}/${p.slug}`);
  }

  if (!slugs.length) return ok({ pinged: 0, reason: 'no recent publishes' });

  const urls = slugs.map((s) => {
    const [lang, ...rest] = s.split('/');
    return `${SITE_ORIGIN}/r/${lang}/${rest.join('/')}`;
  });

  const results: Record<string, unknown> = { urls_count: urls.length };

  // ─── IndexNow ──────────────────────────────────────────────────────────
  if (INDEXNOW_KEY) {
    try {
      const host = SITE_ORIGIN.replace(/^https?:\/\//, '');
      const payload = {
        host,
        key: INDEXNOW_KEY,
        keyLocation: `${SITE_ORIGIN}/${INDEXNOW_KEY}.txt`,
        urlList: urls,
      };
      const r = await fetch('https://api.indexnow.org/IndexNow', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=utf-8' },
        body: JSON.stringify(payload),
      });
      results.indexnow_status = r.status;
    } catch (e) {
      results.indexnow_error = (e as Error).message;
    }
  } else {
    results.indexnow_status = 'skipped (no INDEXNOW_KEY)';
  }

  // ─── Google Search Console (sitemap ping) ──────────────────────────────
  // Classic sitemap ping is deprecated; GSC API requires OAuth. Skip in P1.
  // Phase 2: service account + Search Console API indexing API for job postings/livestream only.
  results.google_status = 'sitemap crawl (passive)';

  // ─── Bing Webmaster Tools — direct API submission ─────────────────────
  // SubmitUrlBatch: max 500 URLs per request, ~10K/day quota.
  // siteUrl must match the verified property in Bing Webmaster Tools.
  const BING_KEY = Deno.env.get('BING_WEBMASTER_KEY');
  if (BING_KEY) {
    const bingSiteUrl = SITE_ORIGIN.endsWith('/') ? SITE_ORIGIN : `${SITE_ORIGIN}/`;
    const batches: string[][] = [];
    for (let i = 0; i < urls.length; i += 500) batches.push(urls.slice(i, i + 500));

    const bingResults: Array<{ status: number; ok: boolean; body?: string }> = [];
    for (const batch of batches) {
      try {
        const r = await fetch(
          `https://ssl.bing.com/webmaster/api.svc/json/SubmitUrlBatch?apikey=${BING_KEY}`,
          {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=utf-8' },
            body: JSON.stringify({ siteUrl: bingSiteUrl, urlList: batch }),
          },
        );
        const text = await r.text();
        bingResults.push({ status: r.status, ok: r.ok, body: r.ok ? undefined : text.slice(0, 300) });
      } catch (e) {
        bingResults.push({ status: 0, ok: false, body: (e as Error).message });
      }
    }

    results.bing_batches = bingResults.length;
    results.bing_results = bingResults;

    // Also submit/refresh the sitemap once
    try {
      const sitemapUrl = `${SITE_ORIGIN}/sitemap.xml`;
      const r = await fetch(
        `https://ssl.bing.com/webmaster/api.svc/json/SubmitFeed?apikey=${BING_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json; charset=utf-8' },
          body: JSON.stringify({ siteUrl: bingSiteUrl, feedUrl: sitemapUrl }),
        },
      );
      results.bing_sitemap_status = r.status;
    } catch (e) {
      results.bing_sitemap_error = (e as Error).message;
    }
  } else {
    results.bing_status = 'skipped (no BING_WEBMASTER_KEY)';
  }

  return ok(results);
});
