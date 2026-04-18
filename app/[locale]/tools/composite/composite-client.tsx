"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, type BirthData } from "@/lib/birth-data/store";

export default function CompositeClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [p1, setP1] = useState<BirthData | null>(saved || null);
  const [p2, setP2] = useState<BirthData | null>(null);
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<any>(null);

  useEffect(() => { if (saved && !p1) setP1(saved); }, [saved, p1]);

  const calc = useCallback(async (a: BirthData, b: BirthData) => {
    setLoading(true);
    try {
      const q = new URLSearchParams({
        date1: a.date, time1: a.time, tz1: a.tz,
        date2: b.date, time2: b.time, tz2: b.tz,
        lang: locale,
      });
      const r = await fetch(`/api/composite?${q.toString()}`);
      setData(await r.json());
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (p1 && p2) calc(p1, p2); }, [p1, p2, calc]);

  return (<div className="space-y-8">
    <div className="grid md:grid-cols-2 gap-4 max-w-3xl mx-auto">
      <div>
        <div className="text-xs uppercase tracking-wider text-cosmic-muted text-center mb-2">{isEn ? "Person 1 — You" : "Kişi 1 — Sen"}</div>
        <BirthDataForm locale={locale} onReady={setP1} accent="rose" submitLabel={isEn ? "Set Person 1" : "Kişi 1 Kaydet"} />
      </div>
      <div>
        <div className="text-xs uppercase tracking-wider text-cosmic-muted text-center mb-2">{isEn ? "Person 2 — Partner" : "Kişi 2 — Partner"}</div>
        <BirthDataForm locale={locale} onReady={setP2} accent="rose" allowCollapsed={false} useSavedStore={false} submitLabel={isEn ? "Set Person 2" : "Kişi 2 Kaydet"} />
      </div>
    </div>

    {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}

    {data?.composite && (<div className="cosmic-card max-w-lg mx-auto animate-in fade-in">
      <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Composite Planets" : "Kompozit Gezegenler"}</h3>
      <table className="w-full text-sm"><tbody>{data.composite.map((p: any) => (
        <tr key={p.name} className="border-t border-white/[0.06]">
          <td className="py-2">{p.symbol} {p.name}</td>
          <td className="py-2">{p.signSymbol} {p.sign}</td>
          <td className="py-2 text-right text-cosmic-muted">{p.degree.toFixed(1)}°</td>
        </tr>
      ))}</tbody></table>
    </div>)}
    <p className="text-xs text-cosmic-muted text-center">{isEn ? "Midpoints of natal planets. Swiss Ephemeris." : "Doğum gezegenlerinin orta noktaları. Swiss Ephemeris."}</p>
  </div>);
}
