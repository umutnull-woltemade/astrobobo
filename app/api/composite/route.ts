import { NextRequest, NextResponse } from 'next/server';
import { localToUtcDecimalHours } from '@/lib/ephemeris/tz';
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
  { id: 5, en: 'Jupiter', tr: 'Jüpiter', symbol: '♃' },
  { id: 6, en: 'Saturn', tr: 'Satürn', symbol: '♄' },
];

function midpoint(a: number, b: number): number {
  let diff = b - a;
  if (diff > 180) diff -= 360;
  if (diff < -180) diff += 360;
  return ((a + diff / 2) % 360 + 360) % 360;
}

/**
 * GET /api/composite?date1=YYYY-MM-DD&time1=HH:MM&date2=YYYY-MM-DD&time2=HH:MM&lang=tr
 * Composite chart = midpoints of each pair of planets
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const d1 = searchParams.get('date1'), t1 = searchParams.get('time1') || '12:00', tz1 = searchParams.get('tz1') || '';
  const d2 = searchParams.get('date2'), t2 = searchParams.get('time2') || '12:00', tz2 = searchParams.get('tz2') || '';
  const lang = searchParams.get('lang') || 'en';

  if (!d1 || !d2) return NextResponse.json({ error: 'Missing date1/date2' }, { status: 400 });

  try {
    const sw = getSweph();
    const L1 = localToUtcDecimalHours(d1, t1, tz1);
    const L2 = localToUtcDecimalHours(d2, t2, tz2);
    const jd1 = sw.julday(L1.year, L1.month, L1.day, L1.decimalHours, 1);
    const jd2 = sw.julday(L2.year, L2.month, L2.day, L2.decimalHours, 1);

    const composite = PLANETS.map(p => {
      const r1 = sw.calc_ut(jd1, p.id, 256).data[0];
      const r2 = sw.calc_ut(jd2, p.id, 256).data[0];
      const mid = midpoint(r1, r2);
      const si = Math.floor(mid / 30);
      return {
        name: lang === 'tr' ? p.tr : p.en,
        symbol: p.symbol,
        longitude: Math.round(mid * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si],
        signSymbol: SYMBOLS[si],
        degree: Math.round((mid % 30) * 100) / 100,
        person1: Math.round(r1 * 100) / 100,
        person2: Math.round(r2 * 100) / 100,
      };
    });

    return NextResponse.json({ composite }, {
      headers: { 'Cache-Control': 'public, max-age=3600, s-maxage=86400' },
    });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
