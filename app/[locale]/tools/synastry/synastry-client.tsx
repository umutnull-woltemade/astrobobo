"use client";

import { useState, useCallback } from "react";

interface Aspect {
  planet1: { name: string; symbol: string };
  planet2: { name: string; symbol: string };
  aspect: string;
  symbol: string;
  nature: string;
  orb: number;
  exact: boolean;
}

interface SynastryData {
  aspects: Aspect[];
  summary: { totalAspects: number; harmonious: number; challenging: number; score: number; rating: string };
  person1: { planets: { name: string; symbol: string; sign: string; signSymbol: string; degree: number }[] };
  person2: { planets: { name: string; symbol: string; sign: string; signSymbol: string; degree: number }[] };
}

export default function SynastryClient({ locale }: { locale: "en" | "tr" }) {
  const [date1, setDate1] = useState("");
  const [date2, setDate2] = useState("");
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<SynastryData | null>(null);
  const isEn = locale === "en";

  const calculate = useCallback(async () => {
    if (!date1 || !date2) return;
    setLoading(true);
    try {
      const res = await fetch(`/api/synastry?date1=${date1}&date2=${date2}&lang=${locale}`);
      setData(await res.json());
    } catch { /* ignore */ } finally { setLoading(false); }
  }, [date1, date2, locale]);

  return (
    <div className="space-y-8">
      <div className="cosmic-card max-w-lg mx-auto">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Person 1" : "Kişi 1"}</label>
            <input type="date" value={date1} onChange={e => { setDate1(e.target.value); setData(null); }}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
              max={new Date().toISOString().split("T")[0]} />
          </div>
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Person 2" : "Kişi 2"}</label>
            <input type="date" value={date2} onChange={e => { setDate2(e.target.value); setData(null); }}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
              max={new Date().toISOString().split("T")[0]} />
          </div>
        </div>
        <button onClick={calculate} disabled={!date1 || !date2 || loading}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 transition-all">
          {loading ? "..." : (isEn ? "Analyze Synastry" : "Synastry Analiz Et")}
        </button>
      </div>

      {data && (
        <div className="space-y-6 animate-in fade-in">
          {/* Score */}
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-28 h-28 rounded-full text-4xl font-bold font-display"
              style={{
                background: `conic-gradient(#a78bfa ${data.summary.score}%, rgba(255,255,255,0.05) ${data.summary.score}%)`,
                color: data.summary.score >= 50 ? '#a78bfa' : '#f87171',
              }}>
              {data.summary.score}%
            </div>
            <div className="mt-2 text-sm text-cosmic-muted capitalize">{data.summary.rating}</div>
            <div className="text-xs text-cosmic-muted mt-1">
              {data.summary.harmonious} {isEn ? "harmonious" : "uyumlu"} · {data.summary.challenging} {isEn ? "challenging" : "zorlu"}
            </div>
          </div>

          {/* Aspects */}
          <div className="cosmic-card max-w-2xl mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
              {isEn ? "Planetary Aspects" : "Gezegen Açıları"} ({data.aspects.length})
            </h3>
            <div className="space-y-2">
              {data.aspects.slice(0, 20).map((a, i) => (
                <div key={i} className={`flex items-center gap-3 p-2 rounded-lg text-sm ${a.nature === 'harmonious' ? 'bg-green-500/5' : 'bg-red-500/5'}`}>
                  <span>{a.planet1.symbol}</span>
                  <span className={a.nature === 'harmonious' ? 'text-green-400' : 'text-red-400'}>{a.symbol}</span>
                  <span>{a.planet2.symbol}</span>
                  <span className="text-cosmic-muted flex-1">{a.planet1.name} {a.aspect} {a.planet2.name}</span>
                  <span className="text-xs text-cosmic-muted">{a.orb}° orb{a.exact ? ' ✦' : ''}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn ? "Swiss Ephemeris precision. For entertainment and self-reflection." : "Swiss Ephemeris hassasiyeti. Eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
