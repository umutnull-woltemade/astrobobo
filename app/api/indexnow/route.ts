import { NextResponse } from 'next/server';

export const runtime = 'edge';

const INDEXNOW_KEY = '2286c7eceb3731030ea9b2037e46330e';
const HOST = 'https://astrobobo.com';

/**
 * IndexNow API — ping Bing/Yandex for instant indexing.
 *
 * Usage:
 *   POST /api/indexnow              → submit all SEO pages
 *   POST /api/indexnow?url=/r/tr/x  → submit single URL
 *   GET  /api/indexnow              → status
 */

// All SEO article URLs to submit
const SEO_URLS = [
  // Hubs (9 languages × 2)
  ...['tr','en','de','es','fr','it','pt-br','ru','ar'].flatMap(lang => [
    `/r/${lang}`,
    `/r/${lang}/cluster-ruya`,
  ]),
  // Sample article pages (TR)
  '/r/tr/ruyada-araba', '/r/tr/ruyada-bebek', '/r/tr/ruyada-bogulmak',
  '/r/tr/ruyada-dis-dokulmesi', '/r/tr/ruyada-dusmek', '/r/tr/ruyada-eski-sevgili',
  '/r/tr/ruyada-ev', '/r/tr/ruyada-kaybolmak', '/r/tr/ruyada-kopek',
  '/r/tr/ruyada-kovalanmak', '/r/tr/ruyada-olum', '/r/tr/ruyada-para',
  '/r/tr/ruyada-su', '/r/tr/ruyada-ucmak', '/r/tr/ruyada-yilan',
  // Core pages
  '/', '/sitemap.xml',
];

export async function GET() {
  return NextResponse.json({
    status: 'ready',
    key: INDEXNOW_KEY,
    urlCount: SEO_URLS.length,
    endpoint: 'POST /api/indexnow to submit',
  });
}

export async function POST(req: Request) {
  const { searchParams } = new URL(req.url);
  const singleUrl = searchParams.get('url');

  const urlList = singleUrl
    ? [`${HOST}${singleUrl}`]
    : SEO_URLS.map(u => `${HOST}${u}`);

  try {
    const body = {
      host: 'astrobobo.com',
      key: INDEXNOW_KEY,
      keyLocation: `${HOST}/${INDEXNOW_KEY}.txt`,
      urlList,
    };

    const res = await fetch('https://api.indexnow.org/indexnow', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: JSON.stringify(body),
    });

    return NextResponse.json({
      status: res.ok ? 'submitted' : 'error',
      httpStatus: res.status,
      urlsSubmitted: urlList.length,
      indexNowResponse: await res.text().catch(() => ''),
    });
  } catch (e: any) {
    return NextResponse.json({ status: 'error', message: e.message }, { status: 500 });
  }
}
