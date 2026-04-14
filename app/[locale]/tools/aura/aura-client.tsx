"use client";
import { useState } from "react";

const AURAS = [
  { color: "#FF0000", en: "Red", tr: "Kırmızı", desc_en: "Passionate, energetic, grounded. You lead with action and physical vitality.", desc_tr: "Tutkulu, enerjik, yerleşik. Hareket ve fiziksel canlılıkla liderlik edersin." },
  { color: "#FF8C00", en: "Orange", tr: "Turuncu", desc_en: "Creative, adventurous, social. You thrive on new experiences and emotional expression.", desc_tr: "Yaratıcı, maceracı, sosyal. Yeni deneyimler ve duygusal ifadeyle gelişirsin." },
  { color: "#FFD700", en: "Yellow", tr: "Sarı", desc_en: "Optimistic, intellectual, confident. Your mind is your greatest asset.", desc_tr: "İyimser, entelektüel, özgüvenli. Zihnin en büyük varlığın." },
  { color: "#00CC00", en: "Green", tr: "Yeşil", desc_en: "Healing, nurturing, growth-oriented. You bring balance wherever you go.", desc_tr: "Şifacı, besleyici, büyüme odaklı. Gittiğin her yere denge getirirsin." },
  { color: "#00BFFF", en: "Blue", tr: "Mavi", desc_en: "Calm, truthful, communicative. You express yourself with clarity and compassion.", desc_tr: "Sakin, hakikatçi, iletişimci. Netlik ve şefkatle ifade edersin." },
  { color: "#8B00FF", en: "Violet", tr: "Mor", desc_en: "Intuitive, visionary, spiritual. You sense what others cannot and guide them.", desc_tr: "Sezgisel, vizyoner, spiritüel. Başkalarının göremediğini hisseder ve yol gösterirsin." },
  { color: "#FFFFFF", en: "White", tr: "Beyaz", desc_en: "Pure, transcendent, connected. You carry a rare cosmic clarity.", desc_tr: "Saf, aşkın, bağlı. Nadir bir kozmik netlik taşırsın." },
];

const QUESTIONS = [
  { en: "When stressed, I tend to...", tr: "Stres altında...",
    opts: [
      { en: "Take physical action", tr: "Fiziksel harekete geçerim", aura: 0 },
      { en: "Create something", tr: "Bir şey yaratırım", aura: 1 },
      { en: "Analyze the problem", tr: "Problemi analiz ederim", aura: 2 },
      { en: "Care for others first", tr: "Önce başkalarıyla ilgilenirim", aura: 3 },
    ],
  },
  { en: "I feel most alive when...", tr: "En canlı hissettiğim an...",
    opts: [
      { en: "Speaking my truth", tr: "Hakikatimi söylediğimde", aura: 4 },
      { en: "Following my intuition", tr: "Sezgilerimi takip ettiğimde", aura: 5 },
      { en: "Moving my body", tr: "Bedenimi hareket ettirdiğimde", aura: 0 },
      { en: "Connecting with nature", tr: "Doğayla bağlandığımda", aura: 3 },
    ],
  },
  { en: "My friends would describe me as...", tr: "Arkadaşlarım beni şöyle tanımlar...",
    opts: [
      { en: "The dreamer", tr: "Hayalperest", aura: 5 },
      { en: "The doer", tr: "Yapan", aura: 0 },
      { en: "The thinker", tr: "Düşünen", aura: 2 },
      { en: "The healer", tr: "Şifacı", aura: 3 },
    ],
  },
  { en: "I'm drawn to colors that are...", tr: "Çektiğim renkler...",
    opts: [
      { en: "Warm (red, orange)", tr: "Sıcak (kırmızı, turuncu)", aura: 0 },
      { en: "Cool (blue, purple)", tr: "Soğuk (mavi, mor)", aura: 4 },
      { en: "Bright (yellow, white)", tr: "Parlak (sarı, beyaz)", aura: 2 },
      { en: "Natural (green)", tr: "Doğal (yeşil)", aura: 3 },
    ],
  },
  { en: "My deepest desire is...", tr: "En derin arzum...",
    opts: [
      { en: "Freedom and adventure", tr: "Özgürlük ve macera", aura: 1 },
      { en: "Wisdom and truth", tr: "Bilgelik ve hakikat", aura: 5 },
      { en: "Love and connection", tr: "Sevgi ve bağlantı", aura: 3 },
      { en: "Transcendence", tr: "Aşkınlık", aura: 6 },
    ],
  },
];

export default function AuraClient({ locale }: { locale: "en" | "tr" }) {
  const [step, setStep] = useState(0);
  const [scores, setScores] = useState<number[]>(new Array(7).fill(0));
  const isEn = locale === "en";

  const answer = (auraIdx: number) => {
    const next = [...scores]; next[auraIdx]++;
    setScores(next);
    setStep(step + 1);
  };

  if (step >= QUESTIONS.length) {
    const maxIdx = scores.indexOf(Math.max(...scores));
    const aura = AURAS[maxIdx];
    return (
      <div className="text-center animate-in fade-in max-w-md mx-auto">
        <div className="w-40 h-40 rounded-full mx-auto mb-6" style={{ background: `radial-gradient(circle, ${aura.color}60 0%, ${aura.color}10 70%)`, border: `3px solid ${aura.color}80`, boxShadow: `0 0 60px ${aura.color}40` }} />
        <h2 className="text-3xl font-display text-white mb-1">{isEn ? aura.en : aura.tr}</h2>
        <div className="text-sm mb-4" style={{ color: aura.color }}>{isEn ? "Your Aura Color" : "Aura Rengin"}</div>
        <p className="text-cosmic-text/80 leading-relaxed mb-8">{isEn ? aura.desc_en : aura.desc_tr}</p>
        <button onClick={() => { setStep(0); setScores(new Array(7).fill(0)); }}
          className="px-8 py-3 rounded-xl bg-white/[0.06] border border-white/[0.12] text-cosmic-muted hover:text-white transition-all">
          {isEn ? "Retake" : "Tekrarla"}
        </button>
      </div>
    );
  }

  const q = QUESTIONS[step];
  return (
    <div className="max-w-md mx-auto animate-in fade-in">
      <div className="text-xs text-cosmic-muted text-center mb-4">{step + 1} / {QUESTIONS.length}</div>
      <h2 className="text-xl font-display text-white text-center mb-6">{isEn ? q.en : q.tr}</h2>
      <div className="space-y-3">
        {q.opts.map((opt, i) => (
          <button key={i} onClick={() => answer(opt.aura)}
            className="w-full text-left px-5 py-4 rounded-xl bg-white/[0.04] border border-white/[0.08] text-cosmic-text hover:border-purple-500/40 hover:bg-white/[0.07] transition-all">
            {isEn ? opt.en : opt.tr}
          </button>
        ))}
      </div>
    </div>
  );
}
