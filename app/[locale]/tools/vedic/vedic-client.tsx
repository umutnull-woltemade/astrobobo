"use client";
import { useState, useCallback } from "react";

interface VedicPlanet { name: string; symbol: string; sign: string; signSymbol: string; degree: number; nakshatra: string; nakshatraRuler: string; pada: number }

export default function VedicClient({ locale }: { locale: "en" | "tr" }) {
  const [date, setDate] = useState(""); const [loading, setLoading] = useState(false);
  const [data, setData] = useState<{ ayanamsa: number; planets: VedicPlanet[] } | null>(null);
  const isEn = locale === "en";

  const calc = useCallback(async () => {
    if (!date) return; setLoading(true);
    try { const r = await fetch(`/api/vedic?date=${date}&lang=${locale}`); setData(await r.json()); }
    catch {} finally { setLoading(false); }
  }, [date, locale]);

  return (<div className="space-y-8">
    <div className="cosmic-card max-w-sm mx-auto">
      <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
      <input type="date" value={date} onChange={e => { setDate(e.target.value); setData(null); }} className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-orange-500 focus:outline-none text-sm" max={new Date().toISOString().split("T")[0]} />
      <button onClick={calc} disabled={!date || loading} className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-orange-600 to-amber-700 text-white font-semibold disabled:opacity-40 transition-all">{loading ? "..." : (isEn ? "Calculate Vedic Chart" : "Vedik Harita Hesapla")}</button>
    </div>
    {data && (<div className="space-y-4 animate-in fade-in max-w-2xl mx-auto">
      <div className="text-center text-xs text-cosmic-muted mb-4">Ayanamsa: {data.ayanamsa}° (Lahiri)</div>
      <div className="cosmic-card overflow-x-auto">
        <table className="w-full text-sm">
          <thead><tr className="text-cosmic-muted text-xs"><th className="text-left pb-2">{isEn ? "Planet" : "Gezegen"}</th><th className="text-left pb-2">{isEn ? "Sign" : "Rashi"}</th><th className="text-left pb-2">Nakshatra</th><th className="text-right pb-2">Pada</th></tr></thead>
          <tbody>{data.planets.map(p => (
            <tr key={p.name} className="border-t border-white/[0.06]">
              <td className="py-2">{p.symbol} {p.name}</td>
              <td className="py-2">{p.signSymbol} {p.sign} {p.degree.toFixed(1)}°</td>
              <td className="py-2 text-cosmic-accent">{p.nakshatra} <span className="text-cosmic-muted text-xs">({p.nakshatraRuler})</span></td>
              <td className="py-2 text-right text-cosmic-muted">{p.pada}</td>
            </tr>
          ))}</tbody>
        </table>
      </div>
    </div>)}
    <p className="text-xs text-cosmic-muted text-center">{isEn ? "Swiss Ephemeris + Lahiri Ayanamsa. For self-reflection." : "Swiss Ephemeris + Lahiri Ayanamsa. Kişisel keşif amaçlıdır."}</p>
  </div>);
}
