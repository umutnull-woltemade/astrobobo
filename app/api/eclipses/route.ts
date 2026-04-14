import { NextRequest, NextResponse } from 'next/server';
export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];

/**
 * GET /api/eclipses?year=2026&lang=tr
 * Finds solar and lunar eclipses by checking new/full moons near nodes
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const year = parseInt(searchParams.get('year') || String(new Date().getFullYear()));
  const lang = searchParams.get('lang') || 'en';

  try {
    const sw = getSweph();
    const eclipses: any[] = [];

    // Scan each day — check Sun-Moon angular distance at new/full moons
    // Eclipse happens when new/full moon is close to the lunar nodes
    for (let doy = 0; doy <= 365; doy++) {
      const jd = sw.julday(year, 1, 1 + doy, 12, 1);
      const sun = sw.calc_ut(jd, 0, 256).data[0];
      const moon = sw.calc_ut(jd, 1, 256).data[0];
      const node = sw.calc_ut(jd, 11, 256).data[0]; // North Node

      let diff = Math.abs(sun - moon);
      if (diff > 180) diff = 360 - diff;

      // New Moon (conjunction) — potential solar eclipse
      if (diff < 5) {
        let nodeDist = Math.abs(sun - node);
        if (nodeDist > 180) nodeDist = 360 - nodeDist;
        if (nodeDist < 18) { // Within eclipse range of node
          const date = new Date((jd - 2440587.5) * 86400000);
          const si = Math.floor(sun / 30);
          // Check we haven't already added one within 5 days
          const dateStr = date.toISOString().slice(0, 10);
          if (!eclipses.some(e => Math.abs(new Date(e.date).getTime() - date.getTime()) < 5 * 86400000)) {
            eclipses.push({
              type: lang === 'tr' ? 'Güneş Tutulması' : 'Solar Eclipse',
              emoji: '🌑',
              date: dateStr,
              sign: SIGNS[si],
              degree: Math.round((sun % 30) * 10) / 10,
              nodeDist: Math.round(nodeDist * 10) / 10,
              total: nodeDist < 10,
            });
          }
        }
      }

      // Full Moon (opposition) — potential lunar eclipse
      let oppDiff = Math.abs(diff - 180);
      if (diff > 170 && diff < 190) {
        let nodeDist = Math.abs(moon - node);
        if (nodeDist > 180) nodeDist = 360 - nodeDist;
        // Also check opposite node
        let nodeDist2 = Math.abs(moon - ((node + 180) % 360));
        if (nodeDist2 > 180) nodeDist2 = 360 - nodeDist2;
        const minNodeDist = Math.min(nodeDist, nodeDist2);

        if (minNodeDist < 12) {
          const date = new Date((jd - 2440587.5) * 86400000);
          const si = Math.floor(moon / 30);
          const dateStr = date.toISOString().slice(0, 10);
          if (!eclipses.some(e => Math.abs(new Date(e.date).getTime() - date.getTime()) < 5 * 86400000)) {
            eclipses.push({
              type: lang === 'tr' ? 'Ay Tutulması' : 'Lunar Eclipse',
              emoji: '🌕',
              date: dateStr,
              sign: SIGNS[si],
              degree: Math.round((moon % 30) * 10) / 10,
              nodeDist: Math.round(minNodeDist * 10) / 10,
              total: minNodeDist < 5,
            });
          }
        }
      }
    }

    eclipses.sort((a, b) => a.date.localeCompare(b.date));

    return NextResponse.json({ year, eclipses }, {
      headers: { 'Cache-Control': 'public, max-age=86400, s-maxage=604800' },
    });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
