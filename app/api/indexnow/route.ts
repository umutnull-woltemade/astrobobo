import { NextResponse } from 'next/server';

export const runtime = 'edge';

const INDEXNOW_KEY = process.env.INDEXNOW_KEY ?? '';
const HOST = 'https://astrobobo.com';
const LANGS = ['tr', 'en', 'de', 'es', 'fr', 'it', 'pt-br', 'ru', 'ar'];
const TR_SLUGS = [
  'ruyada-araba', 'ruyada-bebek', 'ruyada-bogulmak', 'ruyada-dis-dokulmesi',
  'ruyada-dusmek', 'ruyada-eski-sevgili', 'ruyada-ev', 'ruyada-kaybolmak',
  'ruyada-kopek', 'ruyada-kovalanmak', 'ruyada-olum', 'ruyada-para',
  'ruyada-su', 'ruyada-ucmak', 'ruyada-yilan',
];

const SEO_URLS = [
  ...LANGS.flatMap(lang => [`/r/${lang}`, `/r/${lang}/cluster-ruya`]),
  ...LANGS.flatMap(lang => TR_SLUGS.map(slug => `/r/${lang}/${slug}`)),
  '/',
];

export async function GET() {
  return NextResponse.json({
    status: INDEXNOW_KEY ? 'ready' : 'missing INDEXNOW_KEY env var',
    urlCount: SEO_URLS.length,
    endpoint: 'POST /api/indexnow to submit',
  });
}

export async function POST(req: Request) {
  if (!INDEXNOW_KEY) {
    return NextResponse.json({ status: 'error', message: 'INDEXNOW_KEY not set' }, { status: 500 });
  }

  const { searchParams } = new URL(req.url);
  const singleUrl = searchParams.get('url');
  const urlList = singleUrl ? [`${HOST}${singleUrl}`] : SEO_URLS.map(u => `${HOST}${u}`);

  try {
    const res = await fetch('https://api.indexnow.org/indexnow', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: JSON.stringify({
        host: 'astrobobo.com',
        key: INDEXNOW_KEY,
        keyLocation: `${HOST}/${INDEXNOW_KEY}.txt`,
        urlList,
      }),
    });

    return NextResponse.json({
      status: res.ok ? 'submitted' : 'error',
      httpStatus: res.status,
      urlsSubmitted: urlList.length,
    });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : 'Unknown error';
    return NextResponse.json({ status: 'error', message: msg }, { status: 500 });
  }
}
