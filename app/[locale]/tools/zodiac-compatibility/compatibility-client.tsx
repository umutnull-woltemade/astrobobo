"use client";

import { useEffect, useState } from "react";
import { useBirthData } from "@/lib/birth-data/store";

const SIGN_RANGES: { slug: string; start: [number, number]; end: [number, number] }[] = [
  { slug: "aries", start: [3, 21], end: [4, 19] },
  { slug: "taurus", start: [4, 20], end: [5, 20] },
  { slug: "gemini", start: [5, 21], end: [6, 20] },
  { slug: "cancer", start: [6, 21], end: [7, 22] },
  { slug: "leo", start: [7, 23], end: [8, 22] },
  { slug: "virgo", start: [8, 23], end: [9, 22] },
  { slug: "libra", start: [9, 23], end: [10, 22] },
  { slug: "scorpio", start: [10, 23], end: [11, 21] },
  { slug: "sagittarius", start: [11, 22], end: [12, 21] },
  { slug: "capricorn", start: [12, 22], end: [1, 19] },
  { slug: "aquarius", start: [1, 20], end: [2, 18] },
  { slug: "pisces", start: [2, 19], end: [3, 20] },
];

function signForDate(date: string): string | null {
  const [, m, d] = date.split("-").map(Number);
  if (!m || !d) return null;
  for (const s of SIGN_RANGES) {
    const [sm, sd] = s.start; const [em, ed] = s.end;
    if (sm === em) { if (m === sm && d >= sd && d <= ed) return s.slug; }
    else if ((m === sm && d >= sd) || (m === em && d <= ed)) return s.slug;
  }
  return null;
}

const SIGNS = [
  { slug: "aries", en: "Aries", tr: "Koç", symbol: "♈", element: "fire" },
  { slug: "taurus", en: "Taurus", tr: "Boğa", symbol: "♉", element: "earth" },
  { slug: "gemini", en: "Gemini", tr: "İkizler", symbol: "♊", element: "air" },
  { slug: "cancer", en: "Cancer", tr: "Yengeç", symbol: "♋", element: "water" },
  { slug: "leo", en: "Leo", tr: "Aslan", symbol: "♌", element: "fire" },
  { slug: "virgo", en: "Virgo", tr: "Başak", symbol: "♍", element: "earth" },
  { slug: "libra", en: "Libra", tr: "Terazi", symbol: "♎", element: "air" },
  { slug: "scorpio", en: "Scorpio", tr: "Akrep", symbol: "♏", element: "water" },
  { slug: "sagittarius", en: "Sagittarius", tr: "Yay", symbol: "♐", element: "fire" },
  { slug: "capricorn", en: "Capricorn", tr: "Oğlak", symbol: "♑", element: "earth" },
  { slug: "aquarius", en: "Aquarius", tr: "Kova", symbol: "♒", element: "air" },
  { slug: "pisces", en: "Pisces", tr: "Balık", symbol: "♓", element: "water" },
];

const ELEMENT_COMPAT: Record<string, Record<string, { score: number; en: string; tr: string }>> = {
  fire: {
    fire: { score: 85, en: "Passionate and dynamic — two flames that inspire each other but must avoid burnout.", tr: "Tutkulu ve dinamik — birbirini ateşleyen iki alev, ama tükenmekten kaçınmalı." },
    earth: { score: 55, en: "Complementary but challenging — fire brings vision, earth brings grounding. Balance is key.", tr: "Tamamlayıcı ama zorlu — ateş vizyon, toprak ayakları yere basar. Denge şart." },
    air: { score: 90, en: "Natural allies — air feeds fire, creating inspiration and momentum. An energizing match.", tr: "Doğal müttefikler — hava ateşi besler, ilham ve ivme yaratır. Enerjik bir eşleşme." },
    water: { score: 45, en: "Steam or extinction — emotional depth meets impulsive energy. Requires mutual respect.", tr: "Buhar veya sönme — duygusal derinlik dürtüsel enerjiyle buluşur. Karşılıklı saygı gerekir." },
  },
  earth: {
    fire: { score: 55, en: "Complementary but challenging — earth grounds fire's impulses while fire inspires earth to act.", tr: "Tamamlayıcı ama zorlu — toprak ateşin dürtülerini temellendirir, ateş toprağı harekete geçirir." },
    earth: { score: 80, en: "Stable and reliable — two builders creating something lasting. Watch for stagnation.", tr: "İstikrarlı ve güvenilir — kalıcı bir şey inşa eden iki yapıcı. Durgunluğa dikkat." },
    air: { score: 50, en: "Different worlds meeting — air brings ideas, earth demands practicality. Growth through friction.", tr: "Farklı dünyalar buluşur — hava fikir, toprak pratiklik ister. Sürtünmeyle büyüme." },
    water: { score: 85, en: "Nurturing harmony — water nourishes earth, earth provides structure. A natural pairing.", tr: "Besleyici uyum — su toprağı besler, toprak yapı sağlar. Doğal bir eşleşme." },
  },
  air: {
    fire: { score: 90, en: "Natural allies — air fans fire's flames, creating passion and ideas. An exciting partnership.", tr: "Doğal müttefikler — hava ateşin alevlerini yelpazeler, tutku ve fikirler yaratır." },
    earth: { score: 50, en: "Contrasting energies — air seeks freedom, earth seeks stability. Can learn from each other.", tr: "Zıt enerjiler — hava özgürlük, toprak istikrar arar. Birbirinden öğrenebilir." },
    air: { score: 75, en: "Intellectual connection — stimulating conversations and shared curiosity. Ground your ideas together.", tr: "Entelektüel bağ — uyarıcı sohbetler ve paylaşılan merak. Fikirlerinizi birlikte temellendirin." },
    water: { score: 60, en: "Mind meets heart — air intellectualizes, water feels. Understanding requires patience.", tr: "Zihin kalple buluşur — hava düşünür, su hisseder. Anlayış sabır gerektirir." },
  },
  water: {
    fire: { score: 45, en: "Intense chemistry — passion meets depth. Can transform each other or clash deeply.", tr: "Yoğun kimya — tutku derinlikle buluşur. Birbirini dönüştürebilir veya derin çatışma yaşar." },
    earth: { score: 85, en: "Nurturing harmony — water nourishes earth's growth, earth gives water stability.", tr: "Besleyici uyum — su toprağın büyümesini besler, toprak suya istikrar verir." },
    air: { score: 60, en: "Emotional meets intellectual — different languages of the heart. Bridge-building required.", tr: "Duygusal entelektüelle buluşur — kalbin farklı dilleri. Köprü kurmak şart." },
    water: { score: 70, en: "Deep emotional bond — intuitive understanding but risk of drowning in feelings together.", tr: "Derin duygusal bağ — sezgisel anlayış ama birlikte duygularda boğulma riski." },
  },
};

export default function CompatibilityClient({ locale }: { locale: "en" | "tr" }) {
  const { data: saved } = useBirthData();
  const [sign1, setSign1] = useState<string>("");
  const [sign2, setSign2] = useState<string>("");
  const isEn = locale === "en";

  useEffect(() => {
    if (saved?.date && !sign1) {
      const s = signForDate(saved.date);
      if (s) setSign1(s);
    }
  }, [saved?.date, sign1]);

  const s1 = SIGNS.find(s => s.slug === sign1);
  const s2 = SIGNS.find(s => s.slug === sign2);
  const result = s1 && s2 ? ELEMENT_COMPAT[s1.element][s2.element] : null;

  return (
    <div className="flex flex-col items-center gap-8">
      <div className="flex flex-col md:flex-row items-center gap-6 w-full max-w-lg">
        {/* Sign 1 */}
        <div className="flex-1 w-full">
          <label className="block text-xs text-cosmic-muted mb-2 uppercase tracking-wider">
            {isEn ? "First Sign" : "İlk Burç"}
          </label>
          <select
            value={sign1}
            onChange={e => setSign1(e.target.value)}
            className="w-full px-4 py-3 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none"
          >
            <option value="">{isEn ? "Select..." : "Seç..."}</option>
            {SIGNS.map(s => (
              <option key={s.slug} value={s.slug}>
                {s.symbol} {isEn ? s.en : s.tr}
              </option>
            ))}
          </select>
        </div>

        <div className="text-2xl text-cosmic-muted">♥</div>

        {/* Sign 2 */}
        <div className="flex-1 w-full">
          <label className="block text-xs text-cosmic-muted mb-2 uppercase tracking-wider">
            {isEn ? "Second Sign" : "İkinci Burç"}
          </label>
          <select
            value={sign2}
            onChange={e => setSign2(e.target.value)}
            className="w-full px-4 py-3 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none"
          >
            <option value="">{isEn ? "Select..." : "Seç..."}</option>
            {SIGNS.map(s => (
              <option key={s.slug} value={s.slug}>
                {s.symbol} {isEn ? s.en : s.tr}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Result */}
      {result && s1 && s2 && (
        <div className="w-full max-w-lg text-center cosmic-card">
          <div className="flex justify-center items-center gap-4 mb-6">
            <span className="text-5xl">{s1.symbol}</span>
            <div
              className="w-20 h-20 rounded-full flex items-center justify-center text-2xl font-bold"
              style={{
                background: `conic-gradient(#a78bfa ${result.score}%, rgba(255,255,255,0.05) ${result.score}%)`,
                color: result.score >= 70 ? '#a78bfa' : result.score >= 50 ? '#fbbf24' : '#f87171',
              }}
            >
              {result.score}%
            </div>
            <span className="text-5xl">{s2.symbol}</span>
          </div>
          <h3 className="text-lg font-display text-white mb-1">
            {isEn ? s1.en : s1.tr} & {isEn ? s2.en : s2.tr}
          </h3>
          <div className="text-xs text-purple-400 mb-4">
            {s1.element} × {s2.element}
          </div>
          <p className="text-cosmic-text/80 leading-relaxed">
            {isEn ? result.en : result.tr}
          </p>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md">
        {isEn
          ? "Based on elemental harmony. For a complete analysis, consider full birth chart synastry."
          : "Element uyumuna dayanır. Tam analiz için doğum haritası synastry'si düşünün."}
      </p>
    </div>
  );
}
