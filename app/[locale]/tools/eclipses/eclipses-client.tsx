"use client";
import { useState, useEffect } from "react";
export default function EclipsesClient({ locale }: { locale: "en" | "tr" }) {
  const [data, setData] = useState<any>(null); const [year, setYear] = useState(new Date().getFullYear());
  const isEn = locale === "en";
  useEffect(() => { fetch(`/api/eclipses?year=${year}&lang=${locale}`).then(r=>r.json()).then(setData).catch(()=>{}); }, [year, locale]);
  if (!data) return <div className="text-center text-cosmic-muted py-8">{isEn ? "Loading..." : "Yükleniyor..."}</div>;
  return (<div className="space-y-6">
    <div className="flex justify-center gap-2">
      {[2025,2026,2027].map(y=>(
        <button key={y} onClick={()=>setYear(y)} className={`px-4 py-2 rounded-xl text-sm ${year===y?'bg-purple-500/20 border border-purple-500/40 text-white':'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>{y}</button>
      ))}
    </div>
    {data.eclipses?.length === 0 && <div className="text-center text-cosmic-muted">{isEn ? "No eclipses found for this year." : "Bu yıl için tutulma bulunamadı."}</div>}
    <div className="space-y-4 max-w-lg mx-auto">
      {data.eclipses?.map((e:any,i:number)=>(
        <div key={i} className="cosmic-card flex items-center gap-4">
          <div className="text-4xl">{e.emoji}</div>
          <div className="flex-1">
            <div className="text-sm text-white font-display">{e.type}</div>
            <div className="text-xs text-cosmic-muted">{new Date(e.date).toLocaleDateString(isEn?'en-US':'tr-TR',{dateStyle:'long'})}</div>
            <div className="text-xs text-cosmic-accent">{e.sign} {e.degree}° {e.total ? (isEn ? '(Total)' : '(Tam)') : (isEn ? '(Partial)' : '(Kısmi)')}</div>
          </div>
        </div>
      ))}
    </div>
  </div>);
}
