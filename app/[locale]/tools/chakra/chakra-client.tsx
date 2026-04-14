"use client";
import { useState } from "react";

const CHAKRAS = [
  { name_en: "Root", name_tr: "Kök", color: "#FF0000", symbol: "🔴", q_en: "I feel safe, grounded, and secure in my daily life.", q_tr: "Günlük hayatımda kendimi güvende ve yerleşik hissediyorum.", advice_en: "Walk barefoot, eat root vegetables, practice grounding meditation.", advice_tr: "Çıplak ayakla yürü, kök sebzeler ye, topraklama meditasyonu yap." },
  { name_en: "Sacral", name_tr: "Sakral", color: "#FF8C00", symbol: "🟠", q_en: "I embrace pleasure, creativity, and emotional flow freely.", q_tr: "Zevki, yaratıcılığı ve duygusal akışı özgürce kucaklıyorum.", advice_en: "Dance, create art, enjoy water (swimming, baths).", advice_tr: "Dans et, sanat yarat, suyla vakit geçir (yüzme, banyo)." },
  { name_en: "Solar Plexus", name_tr: "Güneş Sinir Ağı", color: "#FFD700", symbol: "🟡", q_en: "I feel confident in my personal power and decisions.", q_tr: "Kişisel gücüme ve kararlarıma güveniyorum.", advice_en: "Set boundaries, practice core exercises, spend time in sunlight.", advice_tr: "Sınırlar koy, karın egzersizleri yap, güneş ışığında vakit geçir." },
  { name_en: "Heart", name_tr: "Kalp", color: "#00FF00", symbol: "💚", q_en: "I give and receive love openly without fear.", q_tr: "Korku duymadan açıkça sevgi verip alıyorum.", advice_en: "Practice gratitude, volunteer, heart-opening yoga poses.", advice_tr: "Şükran pratik yap, gönüllü ol, kalp açan yoga pozları." },
  { name_en: "Throat", name_tr: "Boğaz", color: "#00BFFF", symbol: "🔵", q_en: "I express my truth clearly and listen to others.", q_tr: "Hakikatimi net ifade ediyorum ve başkalarını dinliyorum.", advice_en: "Sing, journal, practice conscious communication.", advice_tr: "Şarkı söyle, günlük tut, bilinçli iletişim pratik yap." },
  { name_en: "Third Eye", name_tr: "Üçüncü Göz", color: "#4B0082", symbol: "🟣", q_en: "I trust my intuition and see beyond surface appearances.", q_tr: "Sezgilerime güveniyorum ve yüzeyin ötesini görüyorum.", advice_en: "Meditate, practice visualization, reduce screen time.", advice_tr: "Meditasyon yap, görselleştirme pratik yap, ekran süresini azalt." },
  { name_en: "Crown", name_tr: "Taç", color: "#EE82EE", symbol: "👑", q_en: "I feel connected to something greater than myself.", q_tr: "Kendimden daha büyük bir şeye bağlı hissediyorum.", advice_en: "Practice silence, study philosophy, spend time in nature.", advice_tr: "Sessizlik pratik yap, felsefe oku, doğada vakit geçir." },
];

export default function ChakraClient({ locale }: { locale: "en" | "tr" }) {
  const [answers, setAnswers] = useState<number[]>(new Array(7).fill(-1));
  const [showResults, setShowResults] = useState(false);
  const isEn = locale === "en";

  const setAnswer = (idx: number, val: number) => {
    const next = [...answers]; next[idx] = val; setAnswers(next);
  };

  const allAnswered = answers.every(a => a >= 0);
  const labels = isEn
    ? ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
    : ["Kesinlikle Katılmıyorum", "Katılmıyorum", "Nötr", "Katılıyorum", "Kesinlikle Katılıyorum"];

  return (
    <div className="space-y-6 max-w-lg mx-auto">
      {!showResults ? (
        <>
          {CHAKRAS.map((c, i) => (
            <div key={c.name_en} className="cosmic-card">
              <div className="flex items-center gap-3 mb-3">
                <span className="text-2xl">{c.symbol}</span>
                <h3 className="font-display text-white">{isEn ? c.name_en : c.name_tr}</h3>
              </div>
              <p className="text-sm text-cosmic-text/80 mb-4 italic">&ldquo;{isEn ? c.q_en : c.q_tr}&rdquo;</p>
              <div className="flex gap-1">
                {[0, 1, 2, 3, 4].map(v => (
                  <button key={v} onClick={() => setAnswer(i, v)}
                    className={`flex-1 py-2 rounded-lg text-xs transition-all ${
                      answers[i] === v ? 'text-white font-semibold' : 'bg-white/[0.04] text-cosmic-muted hover:bg-white/[0.08]'
                    }`}
                    style={answers[i] === v ? { background: c.color + '40', borderColor: c.color, border: `1px solid ${c.color}` } : {}}>
                    {v + 1}
                  </button>
                ))}
              </div>
              <div className="flex justify-between text-[9px] text-cosmic-muted mt-1 px-1">
                <span>{labels[0]}</span><span>{labels[4]}</span>
              </div>
            </div>
          ))}
          <button onClick={() => setShowResults(true)} disabled={!allAnswered}
            className="w-full px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 transition-all">
            {isEn ? "See Results" : "Sonuçları Gör"}
          </button>
        </>
      ) : (
        <div className="space-y-4 animate-in fade-in">
          <h2 className="text-center text-2xl font-display text-white mb-6">{isEn ? "Your Chakra Balance" : "Chakra Dengeniz"}</h2>
          {CHAKRAS.map((c, i) => {
            const val = answers[i];
            const status = val >= 3 ? (isEn ? "Balanced" : "Dengeli") : val >= 1 ? (isEn ? "Needs Attention" : "İlgi Gerekiyor") : (isEn ? "Blocked" : "Bloke");
            return (
              <div key={c.name_en} className="cosmic-card">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-2">
                    <span className="text-xl">{c.symbol}</span>
                    <span className="font-display text-white">{isEn ? c.name_en : c.name_tr}</span>
                  </div>
                  <span className="text-xs px-2 py-1 rounded-full" style={{ background: c.color + '20', color: c.color }}>{status}</span>
                </div>
                <div className="h-2 bg-white/[0.06] rounded-full overflow-hidden mb-2">
                  <div className="h-full rounded-full transition-all" style={{ width: `${(val + 1) * 20}%`, background: c.color }} />
                </div>
                {val < 3 && <p className="text-xs text-cosmic-muted">{isEn ? c.advice_en : c.advice_tr}</p>}
              </div>
            );
          })}
          <button onClick={() => { setShowResults(false); setAnswers(new Array(7).fill(-1)); }}
            className="w-full px-6 py-3 rounded-xl bg-white/[0.06] border border-white/[0.12] text-cosmic-muted hover:text-white transition-all">
            {isEn ? "Retake Quiz" : "Testi Tekrarla"}
          </button>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "For self-reflection only. Not medical advice." : "Yalnızca kişisel keşif amaçlıdır. Tıbbi tavsiye değildir."}</p>
    </div>
  );
}
