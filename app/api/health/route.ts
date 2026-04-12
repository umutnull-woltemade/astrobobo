import { NextResponse } from 'next/server';

export const runtime = 'edge';

export async function GET() {
  return NextResponse.json(
    {
      status: 'ok',
      app: 'astrobobo',
      framework: 'next',
      version: '1.0.0',
      timestamp: new Date().toISOString(),
    },
    {
      headers: {
        'Cache-Control': 'public, max-age=60, s-maxage=60',
      },
    }
  );
}
