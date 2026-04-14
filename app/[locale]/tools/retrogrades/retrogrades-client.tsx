"use client";
import { useState, useEffect } from "react";
export default function RetrogradesClient({ locale }: { locale: "en" | "tr" }) {
  const [data, setData] = useState<any>(null); const [year, setYear] = useState(new Date().getFullYear());
  const isEn = locale === "en";
  useEffect(() => { fetch(`/api/retrogrades?year=${year}&lang=${locale}`).then(r=>r.json()).then(setData).catch(()=>{}); }, [year, locale]);
  if (!data) return <div className="text-center text-cosmic-muted py-8">{isEn ? "Loading..." : "Yükleniyor..."}</div>;
  return (<div className="space-y-6">
    <div className="flex justify-center gap-2">
      {[2025,2026,2027].map(y=>(
        <button key={y} onClick={()=>setYear(y)} className={`px-4 py-2 rounded-xl text-sm ${year===y?'bg-purple-500/20 border border-purple-500/40 text-white':'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>{y}</button>
      ))}
    </div>
    {data.currentRetrogrades?.length > 0 && (<div className="cosmic-card bg-red-500/5 border-red-500/20 max-w-lg mx-auto">
      <h3 className="text-sm uppercase tracking-widest text-red-400 mb-3">{isEn ? "Currently Retrograde" : "Şu An Retrograde"}</h3>
      {data.currentRetrogrades.map((r:any,i:number)=>(<div key={i} className="flex items-center gap-2 text-sm py-1"><span>{r.symbol}</span><span className="text-white">{r.planet}</span><span className="text-cosmic-muted">→ {r.endDate}</span></div>))}
    </div>)}
    <div className="space-y-3 max-w-lg mx-auto">
      {data.retrogrades?.map((r:any,i:number)=>{
        const today = new Date().toISOString().slice(0,10);
        const isActive = r.startDate <= today && r.endDate >= today;
        return (<div key={i} className={`cosmic-card flex items-center gap-4 ${isActive ? 'border-red-500/30 bg-red-500/5' : ''}`}>
          <div className="text-2xl" style={{color:r.color}}>{r.symbol}</div>
          <div className="flex-1"><div className="text-sm text-white">{r.planet}{isActive && <span className="ml-2 text-xs text-red-400">℞ ACTIVE</span>}</div>
          <div className="text-xs text-cosmic-muted">{r.startDate} → {r.endDate} ({r.duration} {isEn?'days':'gün'})</div></div>
        </div>);
      })}
    </div>
  </div>);
}
