import { NextRequest, NextResponse } from 'next/server';

// Node.js runtime required for native sweph binding
export const runtime = 'nodejs';

// Lazy-load sweph to avoid edge runtime issues
let sweph: any = null;
function getSweph() {
  if (!sweph) {
    sweph = require('sweph');
  }
  return sweph;
}

const SIGNS = [
  'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
  'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces',
];

const SIGNS_TR = [
  'Koç', 'Boğa', 'İkizler', 'Yengeç', 'Aslan', 'Başak',
  'Terazi', 'Akrep', 'Yay', 'Oğlak', 'Kova', 'Balık',
];

const SIGN_SYMBOLS = ['♈', '♉', '♊', '♋', '♌', '♍', '♎', '♏', '♐', '♑', '♒', '♓'];

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
  { id: 11, en: 'North Node', tr: 'Kuzey Düğümü', symbol: '☊' },
  { id: 15, en: 'Chiron', tr: 'Chiron', symbol: '⚷' },
];

const ELEMENTS: Record<string, string> = {
  Aries: 'fire', Taurus: 'earth', Gemini: 'air', Cancer: 'water',
  Leo: 'fire', Virgo: 'earth', Libra: 'air', Scorpio: 'water',
  Sagittarius: 'fire', Capricorn: 'earth', Aquarius: 'air', Pisces: 'water',
};

/**
 * GET /api/chart?date=1990-06-15&time=12:00&lat=41.01&lng=28.98&lang=tr
 *
 * Returns full natal chart with planet positions, signs, houses (Placidus).
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const dateStr = searchParams.get('date');    // YYYY-MM-DD
  const timeStr = searchParams.get('time');    // HH:MM
  const latStr = searchParams.get('lat');      // decimal latitude
  const lngStr = searchParams.get('lng');      // decimal longitude
  const lang = searchParams.get('lang') || 'en';

  if (!dateStr) {
    return NextResponse.json({ error: 'Missing date param (YYYY-MM-DD)' }, { status: 400 });
  }

  const [year, month, day] = dateStr.split('-').map(Number);
  const [hours, minutes] = (timeStr || '12:00').split(':').map(Number);
  const lat = latStr ? parseFloat(latStr) : 41.0082;  // default Istanbul
  const lng = lngStr ? parseFloat(lngStr) : 28.9784;
  const decimalHours = hours + minutes / 60;

  try {
    const sw = getSweph();
    const SEFLG_SPEED = 256;

    // Julian Day
    const jd = sw.julday(year, month, day, decimalHours, 1); // 1 = Gregorian

    // Calculate all planet positions
    const planets = PLANETS.map(planet => {
      try {
        const result = sw.calc_ut(jd, planet.id, SEFLG_SPEED);
        const longitude = result.data[0];
        const signIndex = Math.floor(longitude / 30);
        const degree = longitude % 30;
        const isRetrograde = result.data[3] < 0; // negative speed = retrograde

        return {
          id: planet.id,
          name: lang === 'tr' ? planet.tr : planet.en,
          symbol: planet.symbol,
          longitude: Math.round(longitude * 100) / 100,
          sign: lang === 'tr' ? SIGNS_TR[signIndex] : SIGNS[signIndex],
          signSymbol: SIGN_SYMBOLS[signIndex],
          signIndex,
          degree: Math.round(degree * 100) / 100,
          element: ELEMENTS[SIGNS[signIndex]],
          retrograde: isRetrograde,
        };
      } catch {
        return { id: planet.id, name: lang === 'tr' ? planet.tr : planet.en, symbol: planet.symbol, error: true };
      }
    });

    // Calculate houses (Placidus)
    let houses: any[] = [];
    let ascendant = 0;
    let mc = 0;
    try {
      const houseResult = sw.houses(jd, lat, lng, 'P'); // P = Placidus
      const houseArray = houseResult.data.houses || houseResult.data.house || [];
      houses = houseArray.map((cusp: number, i: number) => {
        const signIndex = Math.floor(cusp / 30);
        return {
          house: i + 1,
          cusp: Math.round(cusp * 100) / 100,
          sign: lang === 'tr' ? SIGNS_TR[signIndex] : SIGNS[signIndex],
          signSymbol: SIGN_SYMBOLS[signIndex],
        };
      });
      const points = houseResult.data.points || [];
      ascendant = points[0] || 0;
      mc = points[1] || 0;
    } catch {
      // Houses need valid lat/lng + birth time
    }

    const ascSign = Math.floor(ascendant / 30);
    const sunSign = planets.find(p => p.id === 0);
    const moonSign = planets.find(p => p.id === 1);

    // Element balance
    const elementCounts: Record<string, number> = { fire: 0, earth: 0, air: 0, water: 0 };
    planets.forEach(p => {
      if ('element' in p && p.element) elementCounts[p.element]++;
    });

    return NextResponse.json({
      input: { date: dateStr, time: timeStr || '12:00', lat, lng },
      julianDay: jd,
      planets: planets.filter(p => !('error' in p)),
      houses,
      summary: {
        sunSign: sunSign ? { name: sunSign.sign, symbol: sunSign.signSymbol, degree: sunSign.degree } : null,
        moonSign: moonSign ? { name: moonSign.sign, symbol: moonSign.signSymbol, degree: moonSign.degree } : null,
        ascendant: ascendant > 0 ? {
          name: lang === 'tr' ? SIGNS_TR[ascSign] : SIGNS[ascSign],
          symbol: SIGN_SYMBOLS[ascSign],
          degree: Math.round((ascendant % 30) * 100) / 100,
        } : null,
        mc: mc > 0 ? Math.round(mc * 100) / 100 : null,
        dominantElement: Object.entries(elementCounts).sort((a, b) => b[1] - a[1])[0][0],
        elementBalance: elementCounts,
      },
    }, {
      headers: {
        'Cache-Control': 'public, max-age=3600, s-maxage=86400',
      },
    });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : 'Calculation failed';
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
