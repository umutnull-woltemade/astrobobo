import { NextRequest, NextResponse } from 'next/server';
export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const OUTER_PLANETS = [
  { id: 2, en: 'Mercury', tr: 'Merkür', symbol: '☿', color: '#FFD93D' },
  { id: 3, en: 'Venus', tr: 'Venüs', symbol: '♀', color: '#F06292' },
  { id: 4, en: 'Mars', tr: 'Mars', symbol: '♂', color: '#FF6B6B' },
  { id: 5, en: 'Jupiter', tr: 'Jüpiter', symbol: '♃', color: '#FFA726' },
  { id: 6, en: 'Saturn', tr: 'Satürn', symbol: '♄', color: '#8D6E63' },
  { id: 7, en: 'Uranus', tr: 'Uranüs', symbol: '♅', color: '#42A5F5' },
  { id: 8, en: 'Neptune', tr: 'Neptün', symbol: '♆', color: '#26C6DA' },
  { id: 9, en: 'Pluto', tr: 'Plüton', symbol: '♇', color: '#7E57C2' },
];

/**
 * GET /api/retrogrades?year=2026&lang=tr
 * Scans each day of the year, finds retrograde start/end dates
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const year = parseInt(searchParams.get('year') || String(new Date().getFullYear()));
  const lang = searchParams.get('lang') || 'en';

  try {
    const sw = getSweph();
    const retrogrades: any[] = [];

    for (const planet of OUTER_PLANETS) {
      let inRetro = false;
      let retroStart = '';

      // Scan each day of the year
      for (let doy = 0; doy <= 365; doy++) {
        const jd = sw.julday(year, 1, 1 + doy, 12, 1);
        const r = sw.calc_ut(jd, planet.id, 256);
        const speed = r.data[3];
        const isRetro = speed < 0;
        const date = new Date((jd - 2440587.5) * 86400000);
        const dateStr = date.toISOString().slice(0, 10);

        if (isRetro && !inRetro) {
          inRetro = true;
          retroStart = dateStr;
          const lon = r.data[0];
          const si = Math.floor(lon / 30);
          retrogrades.push({
            planet: lang === 'tr' ? planet.tr : planet.en,
            symbol: planet.symbol,
            color: planet.color,
            startDate: retroStart,
            endDate: '', // filled when retro ends
            startSign: SIGNS[si],
            duration: 0,
          });
        } else if (!isRetro && inRetro) {
          inRetro = false;
          const last = retrogrades[retrogrades.length - 1];
          if (last && last.endDate === '') {
            last.endDate = dateStr;
            const start = new Date(last.startDate);
            const end = new Date(dateStr);
            last.duration = Math.round((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24));
          }
        }
      }

      // Close any open retrograde at year end
      if (inRetro) {
        const last = retrogrades[retrogrades.length - 1];
        if (last && last.endDate === '') {
          last.endDate = `${year}-12-31`;
          last.duration = Math.round((new Date(`${year}-12-31`).getTime() - new Date(last.startDate).getTime()) / (1000 * 60 * 60 * 24));
        }
      }
    }

    // Sort by start date
    retrogrades.sort((a, b) => a.startDate.localeCompare(b.startDate));

    // Current retrogrades
    const today = new Date().toISOString().slice(0, 10);
    const current = retrogrades.filter(r => r.startDate <= today && r.endDate >= today);

    return NextResponse.json({
      year, retrogrades, currentRetrogrades: current,
    }, { headers: { 'Cache-Control': 'public, max-age=86400, s-maxage=604800' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
