"use client";
import { useState, useCallback } from "react";
export default function CompositeClient({ locale }: { locale: "en" | "tr" }) {
  const [d1, setD1] = useState(""); const [d2, setD2] = useState("");
  const [loading, setLoading] = useState(false); const [data, setData] = useState<any>(null);
  const isEn = locale === "en";
  const calc = useCallback(async () => {
    if (!d1 || !d2) return; setLoading(true);
    try { const r = await fetch(`/api/composite?date1=${d1}&date2=${d2}&lang=${locale}`); setData(await r.json()); }
    catch {} finally { setLoading(false); }
  }, [d1, d2, locale]);
  return (<div className="space-y-8">
    <div className="cosmic-card max-w-lg mx-auto">
      <div className="grid grid-cols-2 gap-4">
        <div><label className="block text-xs text-cosmic-muted mb-1">{isEn ? "Person 1" : "Kişi 1"}</label>
          <input type="date" value={d1} onChange={e=>{setD1(e.target.value);setData(null)}} className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" max={new Date().toISOString().split("T")[0]} /></div>
        <div><label className="block text-xs text-cosmic-muted mb-1">{isEn ? "Person 2" : "Kişi 2"}</label>
          <input type="date" value={d2} onChange={e=>{setD2(e.target.value);setData(null)}} className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" max={new Date().toISOString().split("T")[0]} /></div>
      </div>
      <button onClick={calc} disabled={!d1||!d2||loading} className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-pink-600 to-purple-700 text-white font-semibold disabled:opacity-40 transition-all">{loading ? "..." : (isEn ? "Calculate Composite" : "Kompozit Hesapla")}</button>
    </div>
    {data?.composite && (<div className="cosmic-card max-w-lg mx-auto animate-in fade-in">
      <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Composite Planets" : "Kompozit Gezegenler"}</h3>
      <table className="w-full text-sm"><tbody>{data.composite.map((p:any)=>(
        <tr key={p.name} className="border-t border-white/[0.06]"><td className="py-2">{p.symbol} {p.name}</td><td className="py-2">{p.signSymbol} {p.sign}</td><td className="py-2 text-right text-cosmic-muted">{p.degree.toFixed(1)}°</td></tr>
      ))}</tbody></table>
    </div>)}
    <p className="text-xs text-cosmic-muted text-center">{isEn ? "Midpoints of natal planets. Swiss Ephemeris." : "Doğum gezegenlerinin orta noktaları. Swiss Ephemeris."}</p>
  </div>);
}
