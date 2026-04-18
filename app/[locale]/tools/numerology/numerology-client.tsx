"use client";

import { useCallback, useEffect, useState } from "react";
import { useBirthData } from "@/lib/birth-data/store";

const LIFE_PATH_MEANINGS: Record<number, { en: string; tr: string; keyword_en: string; keyword_tr: string }> = {
  1: { keyword_en: "The Leader", keyword_tr: "Lider", en: "Independent, ambitious, pioneering. You're here to forge your own path and lead by example. Trust your originality.", tr: "Bağımsız, hırslı, öncü. Kendi yolunu açmak ve örnek olarak liderlik etmek için buradasın. Özgünlüğüne güven." },
  2: { keyword_en: "The Diplomat", keyword_tr: "Diplomat", en: "Cooperative, sensitive, peacemaker. You're here to build bridges and create harmony. Your strength is in partnership.", tr: "İşbirlikçi, duyarlı, barış yapıcı. Köprüler kurmak ve uyum yaratmak için buradasın. Gücün ortaklıkta." },
  3: { keyword_en: "The Creator", keyword_tr: "Yaratıcı", en: "Expressive, creative, joyful. You're here to communicate and inspire through art, words, or presence.", tr: "İfade eden, yaratıcı, neşeli. Sanat, söz veya varlığınla iletişim kurmak ve ilham vermek için buradasın." },
  4: { keyword_en: "The Builder", keyword_tr: "İnşa Eden", en: "Practical, disciplined, stable. You're here to build lasting foundations. Your persistence creates what endures.", tr: "Pratik, disiplinli, istikrarlı. Kalıcı temeller inşa etmek için buradasın. Azmin kalıcı olanı yaratır." },
  5: { keyword_en: "The Explorer", keyword_tr: "Kaşif", en: "Adventurous, versatile, freedom-loving. You're here to experience life fully and inspire others to embrace change.", tr: "Maceracı, çok yönlü, özgürlük aşığı. Hayatı tam yaşamak ve başkalarını değişimi kucaklamaya ilham vermek için buradasın." },
  6: { keyword_en: "The Nurturer", keyword_tr: "Besleyici", en: "Responsible, loving, protective. You're here to care, heal, and create beauty in domestic and community life.", tr: "Sorumlu, sevgi dolu, koruyucu. Bakım vermek, iyileştirmek ve aile/topluluk yaşamında güzellik yaratmak için buradasın." },
  7: { keyword_en: "The Seeker", keyword_tr: "Arayan", en: "Analytical, introspective, spiritual. You're here to seek truth beneath the surface and share wisdom.", tr: "Analitik, içe dönük, spiritüel. Yüzeyin altındaki hakikati aramak ve bilgeliği paylaşmak için buradasın." },
  8: { keyword_en: "The Achiever", keyword_tr: "Başaran", en: "Powerful, ambitious, material mastery. You're here to manifest abundance and use power responsibly.", tr: "Güçlü, hırslı, maddi ustalık. Bolluğu tezahür ettirmek ve gücü sorumlu kullanmak için buradasın." },
  9: { keyword_en: "The Humanitarian", keyword_tr: "İnsansever", en: "Compassionate, wise, global thinker. You're here to serve humanity and complete karmic cycles.", tr: "Şefkatli, bilge, küresel düşünen. İnsanlığa hizmet etmek ve karmik döngüleri tamamlamak için buradasın." },
  11: { keyword_en: "The Visionary", keyword_tr: "Vizyoner", en: "Master Number. Intuitive, inspiring, illuminating. You're here to channel higher wisdom into practical form.", tr: "Ana Sayı. Sezgisel, ilham verici, aydınlatıcı. Yüksek bilgeliği pratik forma dönüştürmek için buradasın." },
  22: { keyword_en: "The Master Builder", keyword_tr: "Usta İnşa Eden", en: "Master Number. Visionary architect, practical idealist. You're here to turn grand visions into reality.", tr: "Ana Sayı. Vizyoner mimar, pratik idealist. Büyük vizyonları gerçeğe dönüştürmek için buradasın." },
  33: { keyword_en: "The Master Teacher", keyword_tr: "Usta Öğretmen", en: "Master Number. Selfless healer, cosmic love. You're here to uplift humanity through compassionate service.", tr: "Ana Sayı. Özverili şifacı, kozmik sevgi. Şefkatli hizmetle insanlığı yükseltmek için buradasın." },
};

function calculateLifePath(year: number, month: number, day: number): number {
  const reduceToDigit = (n: number): number => {
    while (n > 9 && n !== 11 && n !== 22 && n !== 33) {
      n = String(n).split('').reduce((sum, d) => sum + Number(d), 0);
    }
    return n;
  };

  const d = reduceToDigit(day);
  const m = reduceToDigit(month);
  const y = reduceToDigit(year);
  return reduceToDigit(d + m + y);
}

export default function NumerologyClient({ locale }: { locale: "en" | "tr" }) {
  const { data: saved } = useBirthData();
  const [birthDate, setBirthDate] = useState(saved?.date || "");
  const [result, setResult] = useState<number | null>(null);
  const isEn = locale === "en";

  const calculate = useCallback((d?: string) => {
    const dateToUse = d || birthDate;
    if (!dateToUse) return;
    const [year, month, day] = dateToUse.split("-").map(Number);
    if (!year || !month || !day) return;
    setResult(calculateLifePath(year, month, day));
  }, [birthDate]);

  useEffect(() => { if (saved?.date && !result) { setBirthDate(saved.date); calculate(saved.date); } /* eslint-disable-next-line */ }, []);

  const meaning = result ? LIFE_PATH_MEANINGS[result] : null;

  return (
    <div className="flex flex-col items-center gap-8">
      {/* Input */}
      <div className="w-full max-w-sm">
        <label className="block text-sm text-cosmic-muted mb-2">
          {isEn ? "Birth Date" : "Doğum Tarihi"}
        </label>
        <input
          type="date"
          value={birthDate}
          onChange={(e) => { setBirthDate(e.target.value); setResult(null); }}
          className="w-full px-4 py-3 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none transition-colors"
          max={new Date().toISOString().split("T")[0]}
        />
        <button
          onClick={() => calculate()}
          disabled={!birthDate}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 hover:from-purple-500 hover:to-purple-700 transition-all"
        >
          {isEn ? "Calculate" : "Hesapla"}
        </button>
      </div>

      {/* Result */}
      {result && meaning && (
        <div className="w-full max-w-lg text-center animate-in fade-in duration-500">
          <div
            className="mx-auto w-32 h-32 rounded-full flex items-center justify-center text-5xl font-display font-bold mb-6"
            style={{
              background: "linear-gradient(135deg, rgba(167,139,250,0.2), rgba(124,58,237,0.2))",
              border: "2px solid rgba(167,139,250,0.4)",
              boxShadow: "0 0 40px rgba(124,58,237,0.3)",
              color: "#a78bfa",
            }}
          >
            {result}
          </div>
          <h2 className="text-2xl font-display text-white mb-1">
            {isEn ? meaning.keyword_en : meaning.keyword_tr}
          </h2>
          <div className="text-sm text-purple-400 mb-4">
            {isEn ? "Life Path Number" : "Yaşam Yolu Sayısı"} {result}
            {result >= 11 && <span className="ml-2 text-xs bg-purple-500/20 px-2 py-0.5 rounded-full">Master</span>}
          </div>
          <p className="text-cosmic-text/80 leading-relaxed">
            {isEn ? meaning.en : meaning.tr}
          </p>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mt-4">
        {isEn
          ? "This is for entertainment and personal reflection only."
          : "Bu yalnızca eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
