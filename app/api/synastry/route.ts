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

const CORE_PLANETS = [
  { id: 0, en: 'Sun', tr: 'Güneş', symbol: '☉' },
  { id: 1, en: 'Moon', tr: 'Ay', symbol: '☽' },
  { id: 2, en: 'Mercury', tr: 'Merkür', symbol: '☿' },
  { id: 3, en: 'Venus', tr: 'Venüs', symbol: '♀' },
  { id: 4, en: 'Mars', tr: 'Mars', symbol: '♂' },
  { id: 5, en: 'Jupiter', tr: 'Jüpiter', symbol: '♃' },
  { id: 6, en: 'Saturn', tr: 'Satürn', symbol: '♄' },
];

// Major aspects with orbs
const ASPECTS = [
  { name: 'Conjunction', tr: 'Kavuşum', angle: 0, orb: 8, nature: 'major', symbol: '☌' },
  { name: 'Opposition', tr: 'Karşıt', angle: 180, orb: 8, nature: 'challenging', symbol: '☍' },
  { name: 'Trine', tr: 'Üçgen', angle: 120, orb: 7, nature: 'harmonious', symbol: '△' },
  { name: 'Square', tr: 'Kare', angle: 90, orb: 7, nature: 'challenging', symbol: '□' },
  { name: 'Sextile', tr: 'Altıgen', angle: 60, orb: 5, nature: 'harmonious', symbol: '⚹' },
];

function calcPlanets(sw: any, jd: number, lang: string) {
  return CORE_PLANETS.map(p => {
    const r = sw.calc_ut(jd, p.id, 256);
    const lon = r.data[0];
    const si = Math.floor(lon / 30);
    return {
      id: p.id,
      name: lang === 'tr' ? p.tr : p.en,
      symbol: p.symbol,
      longitude: Math.round(lon * 100) / 100,
      sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si],
      signSymbol: SYMBOLS[si],
      degree: Math.round((lon % 30) * 100) / 100,
    };
  });
}

function findAspects(planets1: any[], planets2: any[], lang: string) {
  const aspects: any[] = [];
  for (const p1 of planets1) {
    for (const p2 of planets2) {
      for (const asp of ASPECTS) {
        let diff = Math.abs(p1.longitude - p2.longitude);
        if (diff > 180) diff = 360 - diff;
        const orbUsed = Math.abs(diff - asp.angle);
        if (orbUsed <= asp.orb) {
          aspects.push({
            planet1: { name: p1.name, symbol: p1.symbol },
            planet2: { name: p2.name, symbol: p2.symbol },
            aspect: lang === 'tr' ? asp.tr : asp.name,
            symbol: asp.symbol,
            nature: asp.nature,
            orb: Math.round(orbUsed * 10) / 10,
            exact: orbUsed < 1,
          });
        }
      }
    }
  }
  return aspects.sort((a, b) => a.orb - b.orb);
}

/**
 * GET /api/synastry?date1=YYYY-MM-DD&time1=HH:MM&date2=YYYY-MM-DD&time2=HH:MM&lang=tr
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const date1 = searchParams.get('date1');
  const time1 = searchParams.get('time1') || '12:00';
  const date2 = searchParams.get('date2');
  const time2 = searchParams.get('time2') || '12:00';
  const lang = searchParams.get('lang') || 'en';

  if (!date1 || !date2) {
    return NextResponse.json({ error: 'Missing date1 and date2' }, { status: 400 });
  }

  try {
    const sw = getSweph();
    const [y1, m1, d1] = date1.split('-').map(Number);
    const [h1, min1] = time1.split(':').map(Number);
    const [y2, m2, d2] = date2.split('-').map(Number);
    const [h2, min2] = time2.split(':').map(Number);

    const jd1 = sw.julday(y1, m1, d1, h1 + min1 / 60, 1);
    const jd2 = sw.julday(y2, m2, d2, h2 + min2 / 60, 1);

    const planets1 = calcPlanets(sw, jd1, lang);
    const planets2 = calcPlanets(sw, jd2, lang);
    const aspects = findAspects(planets1, planets2, lang);

    const harmonious = aspects.filter(a => a.nature === 'harmonious').length;
    const challenging = aspects.filter(a => a.nature === 'challenging').length;
    const total = aspects.length;
    const score = total > 0 ? Math.round((harmonious / total) * 100) : 50;

    return NextResponse.json({
      person1: { date: date1, planets: planets1 },
      person2: { date: date2, planets: planets2 },
      aspects,
      summary: {
        totalAspects: total,
        harmonious,
        challenging,
        score,
        rating: score >= 70 ? 'excellent' : score >= 50 ? 'good' : score >= 30 ? 'challenging' : 'difficult',
      },
    }, {
      headers: { 'Cache-Control': 'public, max-age=3600, s-maxage=86400' },
    });
  } catch (e: unknown) {
    const msg = e instanceof Error ? e.message : 'Calculation failed';
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
