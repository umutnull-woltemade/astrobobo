import { NextRequest, NextResponse } from 'next/server';
import { getTzOffsetHours } from '@/lib/ephemeris/tz';

export const runtime = 'nodejs';

let sweph: any = null;
function getSweph() { if (!sweph) sweph = require('sweph'); return sweph; }

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

const MOON_MEANINGS: Record<string, { en: string; tr: string }> = {
  Aries: { en: "Emotionally bold, impulsive, needs independence. You process feelings through action.", tr: "Duygusal olarak cesur, dürtüsel, bağımsızlığa ihtiyacı var. Duyguları harekete geçerek işler." },
  Taurus: { en: "Emotionally steady, comfort-seeking, loyal. Security and sensory pleasure ground you.", tr: "Duygusal olarak istikrarlı, konfor arayan, sadık. Güvenlik ve duyusal haz seni topraklar." },
  Gemini: { en: "Emotionally curious, talkative, adaptable. You process feelings through words and ideas.", tr: "Duygusal olarak meraklı, konuşkan, uyumlu. Duyguları kelimeler ve fikirlerle işler." },
  Cancer: { en: "Deeply emotional, intuitive, nurturing. Home and family are your emotional anchor.", tr: "Derinden duygusal, sezgisel, besleyici. Ev ve aile duygusal çapandır." },
  Leo: { en: "Emotionally expressive, generous, dramatic. You need to be seen and appreciated.", tr: "Duygusal olarak ifade edici, cömert, dramatik. Görülmeye ve takdir edilmeye ihtiyacın var." },
  Virgo: { en: "Emotionally analytical, service-oriented, modest. You show love through practical care.", tr: "Duygusal olarak analitik, hizmet odaklı, mütevazı. Sevgiyi pratik bakımla gösterir." },
  Libra: { en: "Emotionally balanced, harmony-seeking, relationship-oriented. Peace is your priority.", tr: "Duygusal olarak dengeli, uyum arayan, ilişki odaklı. Huzur önceliğindir." },
  Scorpio: { en: "Emotionally intense, private, transformative. You feel everything deeply and never forget.", tr: "Duygusal olarak yoğun, mahrem, dönüştürücü. Her şeyi derinden hisseder, asla unutmaz." },
  Sagittarius: { en: "Emotionally optimistic, freedom-loving, philosophical. Adventure feeds your soul.", tr: "Duygusal olarak iyimser, özgürlük aşığı, felsefi. Macera ruhunu besler." },
  Capricorn: { en: "Emotionally reserved, responsible, ambitious. You process feelings through structure.", tr: "Duygusal olarak ketum, sorumlu, hırslı. Duyguları yapı üzerinden işler." },
  Aquarius: { en: "Emotionally detached, humanitarian, unconventional. You need mental space to feel.", tr: "Duygusal olarak mesafeli, insansever, alışılmadık. Hissetmek için zihinsel alana ihtiyacın var." },
  Pisces: { en: "Emotionally porous, imaginative, compassionate. You absorb the feelings of others.", tr: "Duygusal olarak geçirgen, hayalperest, şefkatli. Başkalarının duygularını emer." },
};

/**
 * GET /api/moon-sign?date=1990-06-15&time=14:30&tz=Europe/Istanbul&lang=tr
 */
export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const dateStr = searchParams.get('date');
  const timeStr = searchParams.get('time') || '12:00';
  const tz = searchParams.get('tz') || '';
  const lang = searchParams.get('lang') || 'en';

  if (!dateStr) {
    return NextResponse.json({ error: 'Need date' }, { status: 400 });
  }

  try {
    const sw = getSweph();
    const [y, m, d] = dateStr.split('-').map(Number);
    const [h, mi] = timeStr.split(':').map(Number);
    const offset = tz ? getTzOffsetHours(tz, y, m, d, h, mi) : 0;
    const jd = sw.julday(y, m, d, h + mi / 60 - offset, 1);

    const result = sw.calc_ut(jd, 1, 256); // Moon
    const lon = result.data[0];
    const si = Math.floor(lon / 30);
    const signEn = SIGNS[si];

    return NextResponse.json({
      moon: {
        longitude: Math.round(lon * 100) / 100,
        sign: lang === 'tr' ? SIGNS_TR[si] : signEn,
        signEn,
        symbol: SYMBOLS[si],
        degree: Math.round((lon % 30) * 100) / 100,
      },
      meaning: lang === 'tr' ? MOON_MEANINGS[signEn].tr : MOON_MEANINGS[signEn].en,
    }, { headers: { 'Cache-Control': 'public, max-age=3600, s-maxage=86400' } });
  } catch (e: unknown) {
    return NextResponse.json({ error: e instanceof Error ? e.message : 'Failed' }, { status: 500 });
  }
}
