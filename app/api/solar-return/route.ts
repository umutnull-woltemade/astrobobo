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
];

/**
 * GET /api/solar-return?date=1990-06-15&year=2026&lat=41.01&lng=28.97&lang=tr
 *
 * Calculates the Solar Return chart for a given birth date and return year.
 * The Solar Return is when the transiting Sun returns to its exact natal position.
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const birthDate = searchParams.get('date');
  const returnYear = parseInt(searchParams.get('year') || String(new Date().getFullYear()));
  const lat = parseFloat(searchParams.get('lat') || '41.0082');
  const lng = parseFloat(searchParams.get('lng') || '28.9784');
  const lang = searchParams.get('lang') || 'en';

  if (!birthDate) {
    return NextResponse.json({ error: 'Missing date param' }, { status: 400 });
  }

  try {
    const sw = getSweph();
    const [by, bm, bd] = birthDate.split('-').map(Number);

    // Get natal Sun position
    const natalJd = sw.julday(by, bm, bd, 12, 1);
    const natalSun = sw.calc_ut(natalJd, 0, 256).data[0];

    // Find when Sun returns to natal position in the return year
    // Start searching from birthday in return year
    let searchJd = sw.julday(returnYear, bm, bd, 0, 1);

    // Binary search for exact return (Sun longitude matches natal within 0.001°)
    for (let i = 0; i < 50; i++) {
      const currentSun = sw.calc_ut(searchJd, 0, 256).data[0];
      let diff = currentSun - natalSun;
      if (diff > 180) diff -= 360;
      if (diff < -180) diff += 360;
      if (Math.abs(diff) < 0.001) break;
      // Sun moves ~1° per day
      searchJd -= diff;
    }

    const returnJd = searchJd;

    // Calculate planet positions at solar return moment
    const planets = PLANETS.map(p => {
      const r = sw.calc_ut(returnJd, p.id, 256);
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

    // Calculate houses at solar return
    let houses: any[] = [];
    let ascendant = 0;
    try {
      const h = sw.houses(returnJd, lat, lng, 'P');
      const hArray = h.data.houses || h.data.house || [];
      houses = hArray.map((cusp: number, i: number) => {
        const si = Math.floor(cusp / 30);
        return { house: i + 1, sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si], signSymbol: SYMBOLS[si] };
      });
      ascendant = (h.data.points || [])[0] || 0;
    } catch { /* needs valid coords */ }

    const ascSign = Math.floor(ascendant / 30);

    // Convert JD back to date
    const returnDate = new Date((returnJd - 2440587.5) * 86400000);

    return NextResponse.json({
      natalSunDegree: Math.round(natalSun * 100) / 100,
      returnYear,
      returnDate: returnDate.toISOString().slice(0, 19) + 'Z',
      ascendant: ascendant > 0 ? {
        name: lang === 'tr' ? SIGNS_TR[ascSign] : SIGNS[ascSign],
        symbol: SYMBOLS[ascSign],
        degree: Math.round((ascendant % 30) * 100) / 100,
      } : null,
      planets,
      houses,
    }, {
      headers: { 'Cache-Control': 'public, max-age=86400, s-maxage=604800' },
    });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
