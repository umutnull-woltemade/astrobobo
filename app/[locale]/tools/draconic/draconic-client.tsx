"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

export default function DraconicClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<any>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const r = await fetch(`/api/chart?${birthDataQuery(d, locale)}`);
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
  }, [locale, isEn]);

  useEffect(() => { if (saved && !data) calc(saved); /* eslint-disable-next-line */ }, []);

  return (<div className="space-y-8">
    <BirthDataForm locale={locale} onReady={calc} submitLabel={isEn ? "Calculate Draconic" : "Drakonik Hesapla"} />
    {loading && <div className="text-center text-cosmic-muted text-sm">...</div>}
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
