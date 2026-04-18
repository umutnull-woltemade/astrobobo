"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";

const SIGNS_EN = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];

export default function EclipsesClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [data, setData] = useState<any>(null);
  const [natal, setNatal] = useState<any[] | null>(null);
  const [year, setYear] = useState(new Date().getFullYear());

  useEffect(() => {
    fetch(`/api/eclipses?year=${year}&lang=${locale}`).then(r => r.json()).then(setData).catch(() => {});
  }, [year, locale]);

  useEffect(() => {
    if (!saved) { setNatal(null); return; }
    fetch(`/api/chart?${birthDataQuery(saved, locale)}`)
      .then(r => r.json())
      .then(d => setNatal(d.planets || []))
      .catch(() => {});
  }, [saved, locale]);

  function natalHits(eclipseSign: string, eclipseDeg: number): string[] {
    if (!natal) return [];
    const signEn = SIGNS_EN.indexOf(eclipseSign) >= 0 ? eclipseSign : "";
    if (!signEn) return [];
    return natal.filter((p: any) => {
      const pSignIdx = Math.floor(p.longitude / 30);
      const eclSignIdx = SIGNS_EN.indexOf(signEn);
      if (pSignIdx !== eclSignIdx) return false;
      const diff = Math.abs((p.longitude % 30) - eclipseDeg);
      return diff < 8;
    }).map((p: any) => `${p.symbol} ${p.name}`);
  }

  if (!data) return <div className="text-center text-cosmic-muted py-8">{isEn ? "Loading..." : "Yükleniyor..."}</div>;

  return (<div className="space-y-6">
    <div className="flex justify-center gap-2">
      {[2025, 2026, 2027].map(y => (
        <button key={y} onClick={() => setYear(y)} className={`px-4 py-2 rounded-xl text-sm ${year === y ? 'bg-purple-500/20 border border-purple-500/40 text-white' : 'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>{y}</button>
      ))}
    </div>
    {data.eclipses?.length === 0 && <div className="text-center text-cosmic-muted">{isEn ? "No eclipses found for this year." : "Bu yıl için tutulma bulunamadı."}</div>}
    <div className="space-y-4 max-w-lg mx-auto">
      {data.eclipses?.map((e: any, i: number) => {
        const hits = natalHits(e.signEn || e.sign, e.degree);
        return (
          <div key={i} className={`cosmic-card flex items-start gap-4 ${hits.length > 0 ? 'border-amber-500/30 bg-amber-500/5' : ''}`}>
            <div className="text-4xl mt-1">{e.emoji}</div>
            <div className="flex-1">
              <div className="text-sm text-white font-display">{e.type}</div>
              <div className="text-xs text-cosmic-muted">{new Date(e.date).toLocaleDateString(isEn ? 'en-US' : 'tr-TR', { dateStyle: 'long' })}</div>
              <div className="text-xs text-cosmic-accent">{e.sign} {e.degree}° {e.total ? (isEn ? '(Total)' : '(Tam)') : (isEn ? '(Partial)' : '(Kısmi)')}</div>
              {hits.length > 0 && (
                <div className="mt-2 text-xs text-amber-300">
                  ⚠️ {isEn ? "Near your natal:" : "Doğum haritanıza yakın:"} {hits.join(", ")}
                </div>
              )}
            </div>
          </div>
        );
      })}
    </div>
  </div>);
}
