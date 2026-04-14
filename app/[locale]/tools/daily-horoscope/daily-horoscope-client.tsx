"use client";

import { useState, useEffect, useCallback } from "react";

const SIGNS = [
  { slug: "aries", symbol: "♈", en: "Aries", tr: "Koç", start: [3, 21], end: [4, 19] },
  { slug: "taurus", symbol: "♉", en: "Taurus", tr: "Boğa", start: [4, 20], end: [5, 20] },
  { slug: "gemini", symbol: "♊", en: "Gemini", tr: "İkizler", start: [5, 21], end: [6, 20] },
  { slug: "cancer", symbol: "♋", en: "Cancer", tr: "Yengeç", start: [6, 21], end: [7, 22] },
  { slug: "leo", symbol: "♌", en: "Leo", tr: "Aslan", start: [7, 23], end: [8, 22] },
  { slug: "virgo", symbol: "♍", en: "Virgo", tr: "Başak", start: [8, 23], end: [9, 22] },
  { slug: "libra", symbol: "♎", en: "Libra", tr: "Terazi", start: [9, 23], end: [10, 22] },
  { slug: "scorpio", symbol: "♏", en: "Scorpio", tr: "Akrep", start: [10, 23], end: [11, 21] },
  { slug: "sagittarius", symbol: "♐", en: "Sagittarius", tr: "Yay", start: [11, 22], end: [12, 21] },
  { slug: "capricorn", symbol: "♑", en: "Capricorn", tr: "Oğlak", start: [12, 22], end: [1, 19] },
  { slug: "aquarius", symbol: "♒", en: "Aquarius", tr: "Kova", start: [1, 20], end: [2, 18] },
  { slug: "pisces", symbol: "♓", en: "Pisces", tr: "Balık", start: [2, 19], end: [3, 20] },
];

// Daily horoscope templates — seeded by date + sign for consistency
const THEMES = {
  en: {
    love: ["Open your heart to unexpected connections today.", "A meaningful conversation deepens a relationship.", "Express your feelings — vulnerability is courage.", "Someone close needs your attention and warmth."],
    career: ["A bold move at work pays off — trust your instincts.", "Focus on long-term goals rather than quick wins.", "Collaboration brings breakthroughs you couldn't achieve alone.", "Your creative ideas are noticed by the right people."],
    wellness: ["Your body asks for rest — honor it.", "Physical activity clears mental fog today.", "Nourish yourself with something that feeds your soul.", "Find balance between giving and receiving."],
    cosmic: ["The current planetary alignment supports transformation.", "Mercury's position enhances communication — speak your truth.", "Venus invites you to appreciate beauty in small things.", "Mars energizes your ambitions — channel it wisely."],
  },
  tr: {
    love: ["Bugün beklenmedik bağlantılara kalbini aç.", "Anlamlı bir sohbet bir ilişkiyi derinleştirir.", "Duygularını ifade et — kırılganlık cesarettir.", "Yakınlarından biri ilgine ve sıcaklığına ihtiyaç duyuyor."],
    career: ["İşteki cesur bir hamle karşılığını verir — içgüdülerine güven.", "Hızlı kazanımlar yerine uzun vadeli hedeflere odaklan.", "İşbirliği tek başına başaramayacağın çığırlar açar.", "Yaratıcı fikirlerin doğru kişiler tarafından fark ediliyor."],
    wellness: ["Bedenin dinlenme istiyor — ona saygı göster.", "Fiziksel aktivite bugün zihinsel sisi temizler.", "Kendini ruhunu besleyen bir şeyle besle.", "Verme ve alma arasında denge bul."],
    cosmic: ["Mevcut gezegen dizilimi dönüşümü destekliyor.", "Merkür'ün pozisyonu iletişimi güçlendirir — hakikatini söyle.", "Venüs küçük şeylerdeki güzelliği takdir etmeye davet eder.", "Mars tutkularını enerjilendiriyor — bilgece yönlendir."],
  },
};

function getDailyReading(signIndex: number, locale: "en" | "tr") {
  // Seed: today's date + sign index → deterministic but changes daily
  const today = new Date();
  const seed = today.getFullYear() * 10000 + (today.getMonth() + 1) * 100 + today.getDate() + signIndex;
  const pick = (arr: string[], offset: number) => arr[(seed + offset) % arr.length];
  const t = THEMES[locale];
  return {
    love: pick(t.love, 0),
    career: pick(t.career, 7),
    wellness: pick(t.wellness, 13),
    cosmic: pick(t.cosmic, 23),
  };
}

interface TransitPlanet {
  name: string; symbol: string; sign: string; signSymbol: string; degree: number; retrograde: boolean;
}

export default function DailyHoroscopeClient({ locale }: { locale: "en" | "tr" }) {
  const [selected, setSelected] = useState<number | null>(null);
  const [transits, setTransits] = useState<TransitPlanet[]>([]);
  const isEn = locale === "en";

  useEffect(() => {
    fetch(`/api/transits?lang=${locale}`)
      .then(r => r.json())
      .then(d => setTransits(d.planets || []))
      .catch(() => {});
  }, [locale]);

  const reading = selected !== null ? getDailyReading(selected, locale) : null;
  const sign = selected !== null ? SIGNS[selected] : null;

  return (
    <div className="space-y-8">
      {/* Sign Selector */}
      <div className="grid grid-cols-4 md:grid-cols-6 gap-2 max-w-2xl mx-auto">
        {SIGNS.map((s, i) => (
          <button
            key={s.slug}
            onClick={() => setSelected(i)}
            className={`p-3 rounded-xl text-center transition-all ${
              selected === i
                ? 'bg-purple-500/20 border-2 border-purple-500/60 scale-105'
                : 'bg-white/[0.04] border border-white/[0.08] hover:border-purple-500/30'
            }`}
          >
            <div className="text-2xl mb-1">{s.symbol}</div>
            <div className="text-[10px] text-cosmic-muted">{isEn ? s.en : s.tr}</div>
          </button>
        ))}
      </div>

      {/* Reading */}
      {reading && sign && (
        <div className="max-w-lg mx-auto space-y-4 animate-in fade-in">
          <div className="text-center mb-6">
            <div className="text-5xl mb-3">{sign.symbol}</div>
            <h2 className="text-2xl font-display text-white">{isEn ? sign.en : sign.tr}</h2>
            <div className="text-xs text-cosmic-muted mt-1">
              {new Date().toLocaleDateString(isEn ? 'en-US' : 'tr-TR', { dateStyle: 'long' })}
            </div>
          </div>

          {[
            { icon: "💕", label: isEn ? "Love" : "Aşk", text: reading.love },
            { icon: "💼", label: isEn ? "Career" : "Kariyer", text: reading.career },
            { icon: "🧘", label: isEn ? "Wellness" : "Sağlık", text: reading.wellness },
            { icon: "🌌", label: isEn ? "Cosmic" : "Kozmik", text: reading.cosmic },
          ].map(section => (
            <div key={section.label} className="cosmic-card">
              <div className="flex items-center gap-3 mb-2">
                <span className="text-xl">{section.icon}</span>
                <h3 className="text-sm uppercase tracking-widest text-cosmic-accent">{section.label}</h3>
              </div>
              <p className="text-cosmic-text/80 text-sm leading-relaxed">{section.text}</p>
            </div>
          ))}

          {/* Current sky */}
          {transits.length > 0 && (
            <div className="text-center pt-4">
              <div className="text-xs text-cosmic-muted mb-2">{isEn ? "Today's Sky" : "Bugünün Gökyüzü"}</div>
              <div className="flex flex-wrap justify-center gap-2">
                {transits.slice(0, 7).map(t => (
                  <span key={t.name} className="text-xs px-2 py-1 rounded-full bg-white/[0.04] border border-white/[0.06] text-cosmic-muted">
                    {t.symbol} {t.signSymbol}{t.retrograde ? '℞' : ''}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn
          ? "Readings are template-based with real planetary data. For entertainment only."
          : "Yorumlar gerçek gezegen verileriyle şablon tabanlıdır. Yalnızca eğlence amaçlıdır."}
      </p>
    </div>
  );
}
