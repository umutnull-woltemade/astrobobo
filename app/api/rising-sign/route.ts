import { NextRequest, NextResponse } from 'next/server';
import { getTzOffsetHours } from '@/lib/ephemeris/tz';

export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

/**
 * GET /api/rising-sign?date=1990-06-15&time=14:30&lat=41.01&lng=28.98&tz=Europe/Istanbul&lang=tr
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const dateStr = searchParams.get('date');
  const timeStr = searchParams.get('time');
  const latStr = searchParams.get('lat');
  const lngStr = searchParams.get('lng');
  const tz = searchParams.get('tz') || '';
  const lang = searchParams.get('lang') || 'en';

  if (!dateStr || !timeStr || !latStr || !lngStr) {
    return NextResponse.json({ error: 'Need date, time, lat, lng' }, { status: 400 });
  }

  try {
    const sw = getSweph();
    const [y, m, d] = dateStr.split('-').map(Number);
    const [h, mi] = timeStr.split(':').map(Number);
    const lat = parseFloat(latStr);
    const lng = parseFloat(lngStr);
    const offset = tz ? getTzOffsetHours(tz, y, m, d, h, mi) : 0;
    const jd = sw.julday(y, m, d, h + mi / 60 - offset, 1);

    const houseResult = sw.houses(jd, lat, lng, 'P');
    const asc = (houseResult.data.points || [])[0] || 0;
    const mc = (houseResult.data.points || [])[1] || 0;
    const ascSign = Math.floor(asc / 30);

    return NextResponse.json({
      ascendant: {
        longitude: Math.round(asc * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[ascSign] : SIGNS[ascSign],
        symbol: SYMBOLS[ascSign],
        degree: Math.round((asc % 30) * 100) / 100,
      },
      mc: Math.round(mc * 100) / 100,
    }, { headers: { 'Cache-Control': 'public, max-age=3600, s-maxage=86400' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
