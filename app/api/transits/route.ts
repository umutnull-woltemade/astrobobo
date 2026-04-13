import { NextRequest, NextResponse } from 'next/server';

export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() {
  if (!sweph) sweph = require('sweph');
  return sweph;
}

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

const PLANETS = [
  { id: 0, en: 'Sun', tr: 'Güneş', symbol: '☉' },
  { id: 1, en: 'Moon', tr: 'Ay', symbol: '☽' },
  { id: 2, en: 'Mercury', tr: 'Merkür', symbol: '☿' },
  { id: 3, en: 'Venus', tr: 'Venüs', symbol: '♀' },
  { id: 4, en: 'Mars', tr: 'Mars', symbol: '♂' },
  { id: 5, en: 'Jupiter', tr: 'Jüpiter', symbol: '♃' },
  { id: 6, en: 'Saturn', tr: 'Satürn', symbol: '♄' },
  { id: 7, en: 'Uranus', tr: 'Uranüs', symbol: '♅' },
  { id: 8, en: 'Neptune', tr: 'Neptün', symbol: '♆' },
  { id: 9, en: 'Pluto', tr: 'Plüton', symbol: '♇' },
];

/**
 * GET /api/transits?lang=tr
 *
 * Returns current planet positions (today's sky).
 */
export async function GET(req: NextRequest) {
  const lang = new URL(req.url).searchParams.get('lang') || 'en';

  try {
    const sw = getSweph();
    const now = new Date();
    const jd = sw.julday(now.getUTCFullYear(), now.getUTCMonth() + 1, now.getUTCDate(),
      now.getUTCHours() + now.getUTCMinutes() / 60, 1);

    const planets = PLANETS.map(p => {
      const r = sw.calc_ut(jd, p.id, 256);
      const lon = r.data[0];
      const si = Math.floor(lon / 30);
      return {
        name: lang === 'tr' ? p.tr : p.en,
        symbol: p.symbol,
        longitude: Math.round(lon * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si],
        signSymbol: SYMBOLS[si],
        degree: Math.round((lon % 30) * 100) / 100,
        retrograde: r.data[3] < 0,
      };
    });

    return NextResponse.json({
      timestamp: now.toISOString(),
      julianDay: jd,
      planets,
    }, {
      headers: { 'Cache-Control': 'public, max-age=300, s-maxage=3600' },
    });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : 'Failed';
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
