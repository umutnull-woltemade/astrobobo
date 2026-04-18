"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

const RISING_MEANINGS: Record<string, { en: string; tr: string }> = {
  Aries: { en: "Bold first impression. You come across as direct, energetic, and action-oriented.", tr: "Cesur ilk izlenim. Direkt, enerjik ve aksiyon odaklı görünürsün." },
  Taurus: { en: "Calm, grounded presence. You radiate stability and sensory awareness.", tr: "Sakin, topraklı varlık. İstikrar ve duyusal farkındalık yayarsın." },
  Gemini: { en: "Witty, curious energy. You appear quick-minded and socially adaptable.", tr: "Hazırcevap, meraklı enerji. Çabuk düşünen ve sosyal olarak uyumlu görünürsün." },
  Cancer: { en: "Warm, protective aura. You seem nurturing and emotionally attuned.", tr: "Sıcak, koruyucu aura. Besleyici ve duygusal olarak uyumlu görünürsün." },
  Leo: { en: "Magnetic, confident presence. You light up any room you enter.", tr: "Manyetik, özgüvenli varlık. Girdiğin her odayı aydınlatırsın." },
  Virgo: { en: "Precise, helpful demeanor. You appear organized and thoughtfully observant.", tr: "Hassas, yardımsever tavır. Organize ve düşünceli gözlemci görünürsün." },
  Libra: { en: "Graceful, charming appearance. You radiate harmony and social elegance.", tr: "Zarif, çekici görünüş. Uyum ve sosyal zarafet yayarsın." },
  Scorpio: { en: "Intense, magnetic aura. You appear powerful and mysteriously deep.", tr: "Yoğun, manyetik aura. Güçlü ve gizemli derinlikte görünürsün." },
  Sagittarius: { en: "Adventurous, optimistic vibe. You seem open, honest, and enthusiastic.", tr: "Maceracı, iyimser hava. Açık, dürüst ve coşkulu görünürsün." },
  Capricorn: { en: "Mature, authoritative presence. You appear responsible and quietly ambitious.", tr: "Olgun, otoriter varlık. Sorumlu ve sessizce hırslı görünürsün." },
  Aquarius: { en: "Unique, unconventional energy. You seem independent and intellectually stimulating.", tr: "Eşsiz, alışılmadık enerji. Bağımsız ve entelektüel olarak uyarıcı görünürsün." },
  Pisces: { en: "Dreamy, compassionate aura. You appear gentle, artistic, and empathic.", tr: "Hayalperest, şefkatli aura. Nazik, sanatsal ve empatik görünürsün." },
};

export default function RisingSignClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<any>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/rising-sign?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setResult(data);
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (saved && !result) calc(saved); /* eslint-disable-next-line */ }, []);

  const meaning = result ? RISING_MEANINGS[result.ascendant?.sign?.replace(/[^\w]/g, '') || ''] || RISING_MEANINGS[Object.keys(RISING_MEANINGS).find(k => result.ascendant?.sign?.includes(k)) || ''] : null;

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calc} submitLabel={isEn ? "Find My Rising Sign" : "Yükselenim Bul"} />
      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}
      {result?.ascendant && (
        <div className="max-w-md mx-auto animate-in fade-in text-center space-y-4">
          <div className="text-7xl">{result.ascendant.symbol}</div>
          <div>
            <div className="text-xs uppercase tracking-wider text-cosmic-muted">{isEn ? "Your Rising Sign" : "Yükselen Burcun"}</div>
            <div className="text-3xl font-display text-cosmic-accent mt-1">{result.ascendant.sign}</div>
            <div className="text-sm text-cosmic-muted">{result.ascendant.degree}°</div>
          </div>
          {meaning && (
            <div className="cosmic-card bg-gradient-to-r from-purple-900/20 to-indigo-900/20 border-purple-500/20">
              <p className="text-sm text-cosmic-text/80">{isEn ? meaning.en : meaning.tr}</p>
            </div>
          )}
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Swiss Ephemeris. Accurate rising sign requires exact birth time and place." : "Swiss Ephemeris. Doğru yükselen burç kesin doğum saati ve yeri gerektirir."}</p>
    </div>
  );
}
