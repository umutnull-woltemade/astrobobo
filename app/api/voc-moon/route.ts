import { NextRequest, NextResponse } from 'next/server';

export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

// Major aspects (degrees)
const ASPECTS = [0, 60, 90, 120, 180];
const ORB = 1.0; // 1° tight orb for exact aspect moment
const OTHER_PLANETS = [0, 2, 3, 4, 5, 6, 7, 8, 9]; // Sun, Mercury..Pluto (skip Moon itself)

function sepAbs(a: number, b: number) {
  let d = Math.abs(a - b) % 360;
  if (d > 180) d = 360 - d;
  return d;
}

function jdNow() {
  const sw = getSweph();
  const n = new Date();
  return sw.julday(n.getUTCFullYear(), n.getUTCMonth() + 1, n.getUTCDate(), n.getUTCHours() + n.getUTCMinutes() / 60, 1);
}

/**
 * GET /api/voc-moon?lang=tr
 *
 * Scans forward in 6-minute steps up to ~72h to find:
 *   - next exact Moon aspect (start of void ends there, or start of void begins right after)
 *   - next Moon sign change
 *
 * Void window = from last exact aspect in current sign → sign change moment.
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const lang = searchParams.get('lang') || 'en';

  try {
    const sw = getSweph();
    const start = jdNow();
    const stepHours = 0.1; // 6 min
    const stepJd = stepHours / 24;
    const horizon = 72; // look 3 days ahead

    const moonStart = sw.calc_ut(start, 1, 0).data[0];
    const startSign = Math.floor(moonStart / 30);

    // Find Moon sign change JD
    let signChangeJd: number | null = null;
    for (let h = stepHours; h <= horizon; h += stepHours) {
      const jd = start + h / 24;
      const m = sw.calc_ut(jd, 1, 0).data[0];
      if (Math.floor(m / 30) !== startSign) { signChangeJd = jd; break; }
    }
    if (!signChangeJd) return NextResponse.json({ error: 'No sign change found in window' }, { status: 500 });

    // Scan aspects between Moon and other planets from now until sign change
    // Record the latest exact aspect (smallest orb crossing) before sign change
    type Hit = { jd: number; planet: number; aspect: number; orb: number };
    let lastHit: Hit | null = null;
    let nextHit: Hit | null = null;

    const H = Math.ceil(((signChangeJd - start) * 24) / stepHours);
    let prevDiffs: Record<string, number> = {};
    for (let i = 1; i <= H; i++) {
      const jd = start + i * stepJd;
      const moonLon = sw.calc_ut(jd, 1, 0).data[0];
      for (const pid of OTHER_PLANETS) {
        const pLon = sw.calc_ut(jd, pid, 0).data[0];
        const sep = sepAbs(moonLon, pLon);
        for (const a of ASPECTS) {
          const key = `${pid}-${a}`;
          const diff = sep - a;
          const prev = prevDiffs[key];
          if (prev !== undefined && Math.sign(prev) !== Math.sign(diff) && Math.abs(prev) < 10 && Math.abs(diff) < 10) {
            // Crossing exact aspect between prev and now
            const hit: Hit = { jd, planet: pid, aspect: a, orb: Math.abs(diff) };
            if (!nextHit) nextHit = hit;
            lastHit = hit;
          }
          prevDiffs[key] = diff;
        }
      }
    }

    const isVoidNow = !nextHit; // no aspect before sign change → already void
    const voidStartJd = lastHit ? lastHit.jd : start; // if no aspect at all, treat "now" as start
    const voidEndJd = signChangeJd;

    function jdToIso(jd: number) { return new Date((jd - 2440587.5) * 86400000).toISOString(); }

    const endSign = Math.floor(sw.calc_ut(signChangeJd + 0.01, 1, 0).data[0] / 30);

    return NextResponse.json({
      now: jdToIso(start),
      moonSign: {
        name: lang === 'tr' ? SIGNS_TR[startSign] : SIGNS[startSign],
        symbol: SYMBOLS[startSign],
      },
      nextSign: {
        name: lang === 'tr' ? SIGNS_TR[endSign] : SIGNS[endSign],
        symbol: SYMBOLS[endSign],
        changeAt: jdToIso(signChangeJd),
      },
      isVoidNow,
      voidStart: jdToIso(voidStartJd),
      voidEnd: jdToIso(voidEndJd),
      nextAspect: nextHit ? { planet: nextHit.planet, aspect: nextHit.aspect, at: jdToIso(nextHit.jd) } : null,
      lastAspect: lastHit ? { planet: lastHit.planet, aspect: lastHit.aspect, at: jdToIso(lastHit.jd) } : null,
    }, { headers: { 'Cache-Control': 'public, max-age=600, s-maxage=600' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
