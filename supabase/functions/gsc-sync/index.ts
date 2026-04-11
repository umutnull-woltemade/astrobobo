// ═════════════════════════════════════════════════════════════════════════
// gsc-sync — Google Search Console → analytics_daily
//
// Setup:
//   1. GCP console → enable "Google Search Console API"
//   2. Create service account, download JSON key
//   3. In Search Console → Settings → Users and permissions, add the
//      service account email as Restricted
//   4. supabase secrets set GOOGLE_SA_JSON='<entire JSON contents>'
//      supabase secrets set GSC_SITE_URL='https://astrobobo.com/'
//
// POST body: { "days": 7 }   // how many days back from yesterday
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import { googleAccessToken } from '../_shared/google_jwt.ts';

interface Body {
  days?: number;
}

interface GSCRow {
  keys: string[];   // [page]
  clicks: number;
  impressions: number;
  ctr: number;
  position: number;
}

const SITE_URL = Deno.env.get('GSC_SITE_URL') || 'https://astrobobo.com/';
const SCOPE = 'https://www.googleapis.com/auth/webmasters.readonly';

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const days = Math.min(body.days ?? 7, 90);
  const sb = admin();

  let token: string;
  try {
    token = await googleAccessToken(SCOPE);
  } catch (e) {
    return err(`google auth failed: ${(e as Error).message}`, 500);
  }

  const yesterday = new Date(Date.now() - 86400 * 1000).toISOString().slice(0, 10);
  const startDate = new Date(Date.now() - (days + 1) * 86400 * 1000).toISOString().slice(0, 10);

  let totalRows = 0;
  let upserted = 0;
  let startRow = 0;
  const ROW_LIMIT = 25000;

  while (true) {
    const reqBody = {
      startDate,
      endDate: yesterday,
      dimensions: ['page', 'date'],
      rowLimit: ROW_LIMIT,
      startRow,
      dataState: 'final',
    };

    const url = `https://searchconsole.googleapis.com/webmasters/v3/sites/${encodeURIComponent(SITE_URL)}/searchAnalytics/query`;
    const res = await fetch(url, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(reqBody),
    });

    if (!res.ok) {
      const text = await res.text();
      return err(`GSC API ${res.status}: ${text}`, 500);
    }

    const data = await res.json();
    const rows: Array<GSCRow & { keys: [string, string] }> = data.rows || [];
    totalRows += rows.length;

    // Map page URL → post_id
    const pages = [...new Set(rows.map((r) => r.keys[0]))];
    const slugMap = new Map<string, { post_id: number; slug: string; lang: string }>();

    for (const page of pages) {
      // /r/{lang}/{slug}
      const m = page.match(/\/r\/([a-z\-]+)\/([^/?#]+)/);
      if (!m) continue;
      const [, lang, slug] = m;
      const { data: post } = await sb
        .from('posts')
        .select('id')
        .eq('lang', lang)
        .eq('slug', slug)
        .maybeSingle();
      if (post) slugMap.set(page, { post_id: post.id, slug, lang });
    }

    const inserts = rows
      .map((r) => {
        const meta = slugMap.get(r.keys[0]);
        if (!meta) return null;
        return {
          post_id: meta.post_id,
          slug: meta.slug,
          lang: meta.lang,
          date: r.keys[1],
          impressions: r.impressions,
          clicks: r.clicks,
          ctr: r.ctr,
          avg_position: r.position,
          source: 'gsc' as const,
          fetched_at: new Date().toISOString(),
        };
      })
      .filter(Boolean);

    if (inserts.length) {
      const { error: upErr } = await sb
        .from('analytics_daily')
        .upsert(inserts, { onConflict: 'post_id,date,source' });
      if (upErr) {
        console.error('[gsc-sync] upsert error', upErr);
      } else {
        upserted += inserts.length;
      }
    }

    if (rows.length < ROW_LIMIT) break;
    startRow += ROW_LIMIT;
  }

  // Refresh citation_count derived column from posts (cheap update for top movers)
  await sb.from('gsc_state').upsert({
    site_url: SITE_URL,
    last_synced_date: yesterday,
    last_sync_at: new Date().toISOString(),
    rows_synced: totalRows,
  });

  return ok({ totalRows, upserted, days, startDate, endDate: yesterday });
});
