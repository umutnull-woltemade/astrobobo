import { NextRequest, NextResponse } from 'next/server';

export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

const PLANETS = [
  { id: 0, en: 'Sun', tr: 'Güneş', symbol: '☉' },
  { id: 1, en: 'Moon', tr: 'Ay', symbol: '☽' },
  { id: 2, en: 'Mercury', tr: 'Merkür', symbol: '☿' },
  { id: 3, en: 'Venus', tr: 'Venüs', symbol: '♀' },
  { id: 4, en: 'Mars', tr: 'Mars', symbol: '♂' },
];

/**
 * GET /api/progressions?date=1990-06-15&time=12:00&age=35&lang=tr
 *
 * Secondary Progressions: 1 day after birth = 1 year of life.
 * Age 35 → calculate positions 35 days after birth.
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const birthDate = searchParams.get('date');
  const birthTime = searchParams.get('time') || '12:00';
  const age = parseInt(searchParams.get('age') || '30');
  const lang = searchParams.get('lang') || 'en';

  if (!birthDate) return NextResponse.json({ error: 'Missing date' }, { status: 400 });

  try {
    const sw = getSweph();
    const [y, m, d] = birthDate.split('-').map(Number);
    const [h, min] = birthTime.split(':').map(Number);

    // Natal JD
    const natalJd = sw.julday(y, m, d, h + min / 60, 1);
    // Progressed JD = natal + age days
    const progJd = natalJd + age;

    // Natal positions
    const natal = PLANETS.map(p => {
      const r = sw.calc_ut(natalJd, p.id, 256);
      const lon = r.data[0]; const si = Math.floor(lon / 30);
      return { name: lang === 'tr' ? p.tr : p.en, symbol: p.symbol, sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si], signSymbol: SYMBOLS[si], degree: Math.round((lon % 30) * 100) / 100, longitude: Math.round(lon * 100) / 100 };
    });

    // Progressed positions
    const progressed = PLANETS.map(p => {
      const r = sw.calc_ut(progJd, p.id, 256);
      const lon = r.data[0]; const si = Math.floor(lon / 30);
      return { name: lang === 'tr' ? p.tr : p.en, symbol: p.symbol, sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si], signSymbol: SYMBOLS[si], degree: Math.round((lon % 30) * 100) / 100, longitude: Math.round(lon * 100) / 100 };
    });

    // Find sign changes (most important in progressions)
    const signChanges = PLANETS.map((p, i) => {
      const n = natal[i]; const pr = progressed[i];
      if (n.sign !== pr.sign) {
        return { planet: n.name, symbol: n.symbol, from: n.sign, fromSymbol: n.signSymbol, to: pr.sign, toSymbol: pr.signSymbol };
      }
      return null;
    }).filter(Boolean);

    return NextResponse.json({
      age, natal, progressed, signChanges,
    }, { headers: { 'Cache-Control': 'public, max-age=86400, s-maxage=604800' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
