"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";

export default function RetrogradesClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [data, setData] = useState<any>(null);
  const [natalRetros, setNatalRetros] = useState<any[] | null>(null);
  const [year, setYear] = useState(new Date().getFullYear());

  useEffect(() => {
    fetch(`/api/retrogrades?year=${year}&lang=${locale}`).then(r => r.json()).then(setData).catch(() => {});
  }, [year, locale]);

  useEffect(() => {
    if (!saved) { setNatalRetros(null); return; }
    fetch(`/api/chart?${birthDataQuery(saved, locale)}`)
      .then(r => r.json())
      .then(d => setNatalRetros((d.planets || []).filter((p: any) => p.retrograde)))
      .catch(() => {});
  }, [saved, locale]);

  if (!data) return <div className="text-center text-cosmic-muted py-8">{isEn ? "Loading..." : "Yükleniyor..."}</div>;

  const today = new Date().toISOString().slice(0, 10);

  return (<div className="space-y-6">
    <div className="flex justify-center gap-2">
      {[2025, 2026, 2027].map(y => (
        <button key={y} onClick={() => setYear(y)} className={`px-4 py-2 rounded-xl text-sm ${year === y ? 'bg-purple-500/20 border border-purple-500/40 text-white' : 'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>{y}</button>
      ))}
    </div>

    {natalRetros && natalRetros.length > 0 && (
      <div className="cosmic-card bg-gradient-to-r from-indigo-900/20 to-purple-900/20 border-indigo-500/30 max-w-lg mx-auto">
        <h3 className="text-sm uppercase tracking-widest text-indigo-300 mb-3">{isEn ? "Your Natal Retrogrades" : "Doğum Retrogradelarınız"}</h3>
        <div className="flex flex-wrap gap-2">
          {natalRetros.map((p: any) => (
            <span key={p.name} className="px-3 py-1.5 rounded-full bg-white/[0.06] border border-white/[0.10] text-xs text-white">
              {p.symbol} {p.name} ℞ <span className="text-cosmic-muted">{p.signSymbol}</span>
            </span>
          ))}
        </div>
        <p className="text-xs text-cosmic-muted mt-3">
          {isEn ? "These planets were retrograde at your birth — an inward, revisiting signature." : "Doğumunuzda bu gezegenler retrograde'di — içe dönük, yeniden ziyaret imzası."}
        </p>
      </div>
    )}

    {data.currentRetrogrades?.length > 0 && (<div className="cosmic-card bg-red-500/5 border-red-500/20 max-w-lg mx-auto">
      <h3 className="text-sm uppercase tracking-widest text-red-400 mb-3">{isEn ? "Currently Retrograde" : "Şu An Retrograde"}</h3>
      {data.currentRetrogrades.map((r: any, i: number) => (
        <div key={i} className="flex items-center gap-2 text-sm py-1"><span>{r.symbol}</span><span className="text-white">{r.planet}</span><span className="text-cosmic-muted">→ {r.endDate}</span></div>
      ))}
    </div>)}

    <div className="space-y-3 max-w-lg mx-auto">
      {data.retrogrades?.map((r: any, i: number) => {
        const isActive = r.startDate <= today && r.endDate >= today;
        return (<div key={i} className={`cosmic-card flex items-center gap-4 ${isActive ? 'border-red-500/30 bg-red-500/5' : ''}`}>
          <div className="text-2xl" style={{ color: r.color }}>{r.symbol}</div>
          <div className="flex-1">
            <div className="text-sm text-white">{r.planet}{isActive && <span className="ml-2 text-xs text-red-400">℞ ACTIVE</span>}</div>
            <div className="text-xs text-cosmic-muted">{r.startDate} → {r.endDate} ({r.duration} {isEn ? 'days' : 'gün'})</div>
          </div>
        </div>);
      })}
    </div>
  </div>);
}
