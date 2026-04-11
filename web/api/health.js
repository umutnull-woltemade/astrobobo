// ═══════════════════════════════════════════════════════════════════════════
// Health endpoint — Vercel Edge Function
// Returns simple JSON status. Cached 60s public.
// ═══════════════════════════════════════════════════════════════════════════

export const config = { runtime: 'edge' };

export default function handler() {
  return new Response(
    JSON.stringify({
      status: 'ok',
      app: 'venus-one',
      framework: 'flutter-web',
      version: '1.0.0',
      timestamp: new Date().toISOString(),
    }),
    {
      status: 200,
      headers: {
        'content-type': 'application/json; charset=utf-8',
        'cache-control': 'public, max-age=60, s-maxage=60',
      },
    }
  );
}
