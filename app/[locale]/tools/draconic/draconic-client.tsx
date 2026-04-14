"use client";
import { useState, useCallback } from "react";
const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

export default function DraconicClient({ locale }: { locale: "en" | "tr" }) {
  const [date, setDate] = useState(""); const [loading, setLoading] = useState(false);
  const [data, setData] = useState<any>(null);
  const isEn = locale === "en";

  const calc = useCallback(async () => {
    if (!date) return; setLoading(true);
    try {
      const r = await fetch(`/api/chart?date=${date}&lang=${locale}`);
      const chart = await r.json();
      if (chart.error) throw new Error(chart.error);
      const node = chart.planets.find((p: any) => p.symbol === '☊');
      if (!node) throw new Error('North Node not found');
      const nodeLon = node.longitude;
      const draconic = chart.planets.filter((p: any) => p.symbol !== '☊' && p.symbol !== '⚷').map((p: any) => {
        const dLon = ((p.longitude - nodeLon) % 360 + 360) % 360;
        const si = Math.floor(dLon / 30);
        return { ...p, draconicLon: Math.round(dLon * 100) / 100, draconicSign: isEn ? SIGNS[si] : SIGNS_TR[si], draconicSymbol: SYMBOLS[si], draconicDegree: Math.round((dLon % 30) * 100) / 100 };
      });
      setData({ planets: draconic, nodeLon: Math.round(nodeLon * 100) / 100 });
    } catch {} finally { setLoading(false); }
  }, [date, locale, isEn]);

  return (<div className="space-y-8">
    <div className="cosmic-card max-w-sm mx-auto">
      <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
      <input type="date" value={date} onChange={e => { setDate(e.target.value); setData(null); }} className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" max={new Date().toISOString().split("T")[0]} />
      <button onClick={calc} disabled={!date || loading} className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 transition-all">{loading ? "..." : (isEn ? "Calculate Draconic" : "Drakonik Hesapla")}</button>
    </div>
    {data && (<div className="cosmic-card max-w-lg mx-auto animate-in fade-in">
      <div className="text-xs text-cosmic-muted text-center mb-4">☊ {isEn ? "North Node" : "Kuzey Düğümü"}: {data.nodeLon}°</div>
      <table className="w-full text-sm"><thead><tr className="text-cosmic-muted text-xs"><th className="text-left pb-2">{isEn ? "Planet" : "Gezegen"}</th><th className="text-left pb-2">{isEn ? "Natal" : "Doğum"}</th><th className="text-left pb-2">{isEn ? "Draconic" : "Drakonik"}</th></tr></thead>
      <tbody>{data.planets.map((p: any) => (
        <tr key={p.name} className="border-t border-white/[0.06]">
          <td className="py-2">{p.symbol} {p.name}</td>
          <td className="py-2 text-cosmic-muted">{p.signSymbol} {p.degree.toFixed(1)}°</td>
          <td className="py-2 text-cosmic-accent">{p.draconicSymbol} {p.draconicSign} {p.draconicDegree.toFixed(1)}°</td>
        </tr>
      ))}</tbody></table>
    </div>)}
    <p className="text-xs text-cosmic-muted text-center">{isEn ? "Draconic = natal minus North Node. For soul-level reflection." : "Drakonik = doğum eksi Kuzey Düğümü. Ruh düzeyi keşfi için."}</p>
  </div>);
}
