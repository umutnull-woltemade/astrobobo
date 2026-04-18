"use client";
import { useCallback, useEffect, useState } from "react";
import { useBirthData } from "@/lib/birth-data/store";

function reduceToSingle(n: number): number {
  while (n > 9 && n !== 11 && n !== 22 && n !== 33) {
    n = n.toString().split("").reduce((a, d) => a + Number(d), 0);
  }
  return n;
}

function sumDigits(s: string): number {
  return s.replace(/\D/g, "").split("").reduce((a, d) => a + Number(d), 0);
}

function mulberry32(seed: number) {
  return function () {
    let t = (seed += 0x6D2B79F5);
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

export default function LuckyNumbersClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [date, setDate] = useState(saved?.date || "");
  const [data, setData] = useState<{ lifePath: number; personalYear: number; picks: number[]; lottery: number[] } | null>(null);

  const calc = useCallback(() => {
    if (!date) return;
    const [y, m, d] = date.split("-").map(Number);
    const lifePath = reduceToSingle(sumDigits(date));
    const today = new Date();
    const personalYear = reduceToSingle(sumDigits(`${today.getFullYear()}-${String(m).padStart(2, "0")}-${String(d).padStart(2, "0")}`));
    const seed = y * 10000 + m * 100 + d + today.getFullYear() * 37;
    const rnd = mulberry32(seed);
    const picks = new Set<number>();
    while (picks.size < 5) picks.add(1 + Math.floor(rnd() * 49));
    const lottery = Array.from(picks).sort((a, b) => a - b);
    setData({ lifePath, personalYear, picks: [lifePath, personalYear, reduceToSingle(lifePath + personalYear)], lottery });
  }, [date]);

  // Auto-recalc when date changes
  useEffect(() => { if (date) calc(); }, [date, calc]);

  return (
    <div className="space-y-8">
      <div className="cosmic-card max-w-sm mx-auto">
        <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
        <input type="date" value={date} onChange={(e) => setDate(e.target.value)}
          className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-rose-500 focus:outline-none text-sm"
          max={new Date().toISOString().split("T")[0]} />
      </div>
      {data && (
        <div className="max-w-md mx-auto space-y-4 animate-in fade-in">
          <div className="grid grid-cols-3 gap-3">
            <div className="cosmic-card text-center">
              <div className="text-[10px] uppercase tracking-wider text-cosmic-muted">{isEn ? "Life Path" : "Yaşam Yolu"}</div>
              <div className="text-3xl font-display text-cosmic-accent mt-1">{data.lifePath}</div>
            </div>
            <div className="cosmic-card text-center">
              <div className="text-[10px] uppercase tracking-wider text-cosmic-muted">{isEn ? "Personal Year" : "Kişisel Yıl"}</div>
              <div className="text-3xl font-display text-cosmic-accent mt-1">{data.personalYear}</div>
            </div>
            <div className="cosmic-card text-center">
              <div className="text-[10px] uppercase tracking-wider text-cosmic-muted">{isEn ? "Harmony" : "Armoni"}</div>
              <div className="text-3xl font-display text-cosmic-accent mt-1">{data.picks[2]}</div>
            </div>
          </div>
          <div className="cosmic-card">
            <div className="text-xs text-cosmic-muted mb-2 text-center uppercase tracking-wider">{isEn ? "Today's 5 Lucky Numbers (1–49)" : "Bugünün 5 Şanslı Sayısı (1–49)"}</div>
            <div className="flex gap-2 justify-center flex-wrap">
              {data.lottery.map((n) => (
                <div key={n} className="w-12 h-12 rounded-full bg-gradient-to-br from-rose-600 to-purple-700 flex items-center justify-center text-white font-bold">{n}</div>
              ))}
            </div>
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn ? "Numerology + date seed. For entertainment only." : "Numeroloji + tarih tohumu. Yalnızca eğlence amaçlıdır."}
      </p>
    </div>
  );
}
