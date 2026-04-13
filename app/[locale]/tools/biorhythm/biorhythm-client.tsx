"use client";

import { useState, useCallback } from "react";

const CYCLES = [
  { key: "physical", period: 23, color: "#FF6B6B", en: "Physical", tr: "Fiziksel", desc_en: "Energy, strength, endurance, coordination", desc_tr: "Enerji, güç, dayanıklılık, koordinasyon" },
  { key: "emotional", period: 28, color: "#A78BFA", en: "Emotional", tr: "Duygusal", desc_en: "Mood, sensitivity, creativity, intuition", desc_tr: "Ruh hali, duyarlılık, yaratıcılık, sezgi" },
  { key: "intellectual", period: 33, color: "#22D3EE", en: "Intellectual", tr: "Entelektüel", desc_en: "Logic, memory, concentration, analysis", desc_tr: "Mantık, hafıza, konsantrasyon, analiz" },
];

function daysSinceBirth(birthDate: string): number {
  const birth = new Date(birthDate);
  const now = new Date();
  return Math.floor((now.getTime() - birth.getTime()) / (1000 * 60 * 60 * 24));
}

function biorhythmValue(days: number, period: number): number {
  return Math.round(Math.sin((2 * Math.PI * days) / period) * 100);
}

function getAdvice(val: number, isEn: boolean): string {
  if (val > 60) return isEn ? "Peak performance — seize the day!" : "Zirve performans — günü yakala!";
  if (val > 20) return isEn ? "Above average — good energy." : "Ortalamanın üstünde — iyi enerji.";
  if (val > -20) return isEn ? "Neutral — steady and balanced." : "Nötr — dengeli ve istikrarlı.";
  if (val > -60) return isEn ? "Below average — take it easy." : "Ortalamanın altında — sakin ol.";
  return isEn ? "Low point — rest and recharge." : "Düşük nokta — dinlen ve şarj ol.";
}

export default function BiorhythmClient({ locale }: { locale: "en" | "tr" }) {
  const [birthDate, setBirthDate] = useState("");
  const [results, setResults] = useState<{ key: string; value: number }[] | null>(null);
  const isEn = locale === "en";

  const calculate = useCallback(() => {
    if (!birthDate) return;
    const days = daysSinceBirth(birthDate);
    if (days < 0) return;
    setResults(CYCLES.map(c => ({ key: c.key, value: biorhythmValue(days, c.period) })));
  }, [birthDate]);

  return (
    <div className="flex flex-col items-center gap-8">
      <div className="w-full max-w-sm">
        <label className="block text-sm text-cosmic-muted mb-2">
          {isEn ? "Birth Date" : "Doğum Tarihi"}
        </label>
        <input
          type="date"
          value={birthDate}
          onChange={(e) => { setBirthDate(e.target.value); setResults(null); }}
          className="w-full px-4 py-3 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none"
          max={new Date().toISOString().split("T")[0]}
        />
        <button
          onClick={calculate}
          disabled={!birthDate}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 hover:from-purple-500 hover:to-purple-700 transition-all"
        >
          {isEn ? "Calculate" : "Hesapla"}
        </button>
      </div>

      {results && (
        <div className="w-full max-w-lg space-y-4">
          {CYCLES.map((cycle, i) => {
            const val = results[i].value;
            const barWidth = Math.abs(val);
            const isPositive = val >= 0;
            return (
              <div key={cycle.key} className="cosmic-card">
                <div className="flex items-center justify-between mb-2">
                  <h3 className="font-display text-white">
                    {isEn ? cycle.en : cycle.tr}
                  </h3>
                  <span
                    className="text-2xl font-bold font-display"
                    style={{ color: cycle.color }}
                  >
                    {val > 0 ? "+" : ""}{val}%
                  </span>
                </div>
                <div className="text-xs text-cosmic-muted mb-3">
                  {isEn ? cycle.desc_en : cycle.desc_tr}
                </div>
                {/* Bar */}
                <div className="relative h-3 bg-white/[0.06] rounded-full overflow-hidden">
                  <div className="absolute inset-y-0 left-1/2 w-px bg-white/20" />
                  <div
                    className="absolute inset-y-0 rounded-full transition-all duration-500"
                    style={{
                      background: cycle.color,
                      width: `${barWidth / 2}%`,
                      left: isPositive ? "50%" : `${50 - barWidth / 2}%`,
                      opacity: 0.8,
                    }}
                  />
                </div>
                <div className="text-xs text-cosmic-muted mt-2">
                  {getAdvice(val, isEn)}
                </div>
              </div>
            );
          })}
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md">
        {isEn
          ? "Biorhythm theory is not scientifically validated. Use for entertainment and self-reflection."
          : "Biyoritm teorisi bilimsel olarak doğrulanmamıştır. Eğlence ve kişisel keşif için kullanın."}
      </p>
    </div>
  );
}
