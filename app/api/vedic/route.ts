import { NextRequest, NextResponse } from 'next/server';
export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const NAKSHATRAS = [
  { en: 'Ashwini', tr: 'Ashwini', ruler: 'Ketu', deity: 'Ashwini Kumaras' },
  { en: 'Bharani', tr: 'Bharani', ruler: 'Venus', deity: 'Yama' },
  { en: 'Krittika', tr: 'Krittika', ruler: 'Sun', deity: 'Agni' },
  { en: 'Rohini', tr: 'Rohini', ruler: 'Moon', deity: 'Brahma' },
  { en: 'Mrigashira', tr: 'Mrigashira', ruler: 'Mars', deity: 'Soma' },
  { en: 'Ardra', tr: 'Ardra', ruler: 'Rahu', deity: 'Rudra' },
  { en: 'Punarvasu', tr: 'Punarvasu', ruler: 'Jupiter', deity: 'Aditi' },
  { en: 'Pushya', tr: 'Pushya', ruler: 'Saturn', deity: 'Brihaspati' },
  { en: 'Ashlesha', tr: 'Ashlesha', ruler: 'Mercury', deity: 'Naga' },
  { en: 'Magha', tr: 'Magha', ruler: 'Ketu', deity: 'Pitris' },
  { en: 'Purva Phalguni', tr: 'Purva Phalguni', ruler: 'Venus', deity: 'Bhaga' },
  { en: 'Uttara Phalguni', tr: 'Uttara Phalguni', ruler: 'Sun', deity: 'Aryaman' },
  { en: 'Hasta', tr: 'Hasta', ruler: 'Moon', deity: 'Savitar' },
  { en: 'Chitra', tr: 'Chitra', ruler: 'Mars', deity: 'Vishvakarma' },
  { en: 'Swati', tr: 'Swati', ruler: 'Rahu', deity: 'Vayu' },
  { en: 'Vishakha', tr: 'Vishakha', ruler: 'Jupiter', deity: 'Indra-Agni' },
  { en: 'Anuradha', tr: 'Anuradha', ruler: 'Saturn', deity: 'Mitra' },
  { en: 'Jyeshtha', tr: 'Jyeshtha', ruler: 'Mercury', deity: 'Indra' },
  { en: 'Mula', tr: 'Mula', ruler: 'Ketu', deity: 'Nirriti' },
  { en: 'Purva Ashadha', tr: 'Purva Ashadha', ruler: 'Venus', deity: 'Apas' },
  { en: 'Uttara Ashadha', tr: 'Uttara Ashadha', ruler: 'Sun', deity: 'Vishve Devas' },
  { en: 'Shravana', tr: 'Shravana', ruler: 'Moon', deity: 'Vishnu' },
  { en: 'Dhanishta', tr: 'Dhanishta', ruler: 'Mars', deity: 'Vasus' },
  { en: 'Shatabhisha', tr: 'Shatabhisha', ruler: 'Rahu', deity: 'Varuna' },
  { en: 'Purva Bhadrapada', tr: 'Purva Bhadrapada', ruler: 'Jupiter', deity: 'Aja Ekapada' },
  { en: 'Uttara Bhadrapada', tr: 'Uttara Bhadrapada', ruler: 'Saturn', deity: 'Ahir Budhnya' },
  { en: 'Revati', tr: 'Revati', ruler: 'Mercury', deity: 'Pushan' },
];

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Mesha','Vrishabha','Mithuna','Karka','Simha','Kanya','Tula','Vrischika','Dhanu','Makara','Kumbha','Meena'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

const PLANETS = [
  { id: 0, en: 'Sun', tr: 'Surya', symbol: '☉' },
  { id: 1, en: 'Moon', tr: 'Chandra', symbol: '☽' },
  { id: 2, en: 'Mercury', tr: 'Budha', symbol: '☿' },
  { id: 3, en: 'Venus', tr: 'Shukra', symbol: '♀' },
  { id: 4, en: 'Mars', tr: 'Mangala', symbol: '♂' },
  { id: 5, en: 'Jupiter', tr: 'Guru', symbol: '♃' },
  { id: 6, en: 'Saturn', tr: 'Shani', symbol: '♄' },
  { id: 11, en: 'Rahu', tr: 'Rahu', symbol: '☊' },
];

/**
 * GET /api/vedic?date=1990-06-15&time=12:00&lang=tr
 * Sidereal zodiac with Lahiri ayanamsa + Nakshatra
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const dateStr = searchParams.get('date');
  const timeStr = searchParams.get('time') || '12:00';
  const lang = searchParams.get('lang') || 'en';

  if (!dateStr) return NextResponse.json({ error: 'Missing date' }, { status: 400 });

  try {
    const sw = getSweph();
    const [y, m, d] = dateStr.split('-').map(Number);
    const [h, min] = timeStr.split(':').map(Number);
    const jd = sw.julday(y, m, d, h + min / 60, 1);

    // Get Lahiri ayanamsa
    const ayanamsa = sw.get_ayanamsa_ut(jd);
    const SEFLG_SIDEREAL = 64 * 1024; // SEFLG_SIDEREAL
    sw.set_sid_mode(1, 0, 0); // 1 = Lahiri

    const planets = PLANETS.map(p => {
      const r = sw.calc_ut(jd, p.id, 256 | SEFLG_SIDEREAL);
      const lon = ((r.data[0] % 360) + 360) % 360;
      const si = Math.floor(lon / 30);
      const nakshatraIdx = Math.floor(lon / (360 / 27));
      const nakshatra = NAKSHATRAS[nakshatraIdx] || NAKSHATRAS[0];
      const pada = Math.floor((lon % (360 / 27)) / (360 / 108)) + 1;

      return {
        name: lang === 'tr' ? p.tr : p.en,
        symbol: p.symbol,
        longitude: Math.round(lon * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si],
        signSymbol: SYMBOLS[si],
        degree: Math.round((lon % 30) * 100) / 100,
        nakshatra: lang === 'tr' ? nakshatra.tr : nakshatra.en,
        nakshatraRuler: nakshatra.ruler,
        pada,
      };
    });

    // Ketu = opposite of Rahu
    const rahu = planets.find(p => p.symbol === '☊');
    if (rahu) {
      const ketuLon = (rahu.longitude + 180) % 360;
      const si = Math.floor(ketuLon / 30);
      const ni = Math.floor(ketuLon / (360 / 27));
      planets.push({
        name: 'Ketu',
        symbol: '☋',
        longitude: Math.round(ketuLon * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[si] : SIGNS[si],
        signSymbol: SYMBOLS[si],
        degree: Math.round((ketuLon % 30) * 100) / 100,
        nakshatra: lang === 'tr' ? NAKSHATRAS[ni].tr : NAKSHATRAS[ni].en,
        nakshatraRuler: NAKSHATRAS[ni].ruler,
        pada: Math.floor((ketuLon % (360 / 27)) / (360 / 108)) + 1,
      });
    }

    return NextResponse.json({
      system: 'Sidereal (Lahiri)',
      ayanamsa: Math.round(ayanamsa * 100) / 100,
      planets,
    }, { headers: { 'Cache-Control': 'public, max-age=3600, s-maxage=86400' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
