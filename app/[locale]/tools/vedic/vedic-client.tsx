"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

interface VedicPlanet { name: string; symbol: string; sign: string; signSymbol: string; degree: number; nakshatra: string; nakshatraRuler: string; pada: number }

export default function VedicClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<{ ayanamsa: number; planets: VedicPlanet[] } | null>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try { const r = await fetch(`/api/vedic?${birthDataQuery(d, locale)}`); setData(await r.json()); }
    catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (saved && !data) calc(saved); /* eslint-disable-next-line */ }, []);

  return (<div className="space-y-8">
    <BirthDataForm locale={locale} onReady={calc} accent="orange" submitLabel={isEn ? "Calculate Vedic Chart" : "Vedik Harita Hesapla"} />
    {loading && <div className="text-center text-cosmic-muted text-sm">...</div>}
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
