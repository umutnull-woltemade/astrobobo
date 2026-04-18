"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

export default function SaturnReturnClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<any>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const q = birthDataQuery(d, locale);
      const natal = await fetch(`/api/chart?${q}`).then(r => r.json());
      const saturn = natal.planets?.find((p: any) => p.symbol === '♄');
      if (!saturn) throw new Error('Saturn not found');

      const birthYear = parseInt(d.date.split('-')[0]);
      const returns: any[] = [];
      for (const offset of [29, 30, 58, 59]) {
        const yr = birthYear + offset;
        try {
          const sr = await fetch(`/api/solar-return?${q}&year=${yr}`).then(r => r.json());
          const srSaturn = sr.planets?.find((p: any) => p.symbol === '♄');
          if (srSaturn) {
            let diff = Math.abs(srSaturn.longitude - saturn.longitude);
            if (diff > 180) diff = 360 - diff;
            if (diff < 15) {
              returns.push({ year: yr, sign: srSaturn.sign, signSymbol: srSaturn.signSymbol, degree: srSaturn.degree, orb: Math.round(diff * 10) / 10 });
            }
          }
        } catch {}
      }
      setData({ natalSaturn: saturn, returns });
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (saved && !data) calc(saved); /* eslint-disable-next-line */ }, []);

  return (<div className="space-y-8">
    <BirthDataForm locale={locale} onReady={calc} accent="amber" submitLabel={isEn ? "Find Saturn Returns" : "Satürn Dönüşlerini Bul"} />
    {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}
    {data && (<div className="max-w-md mx-auto space-y-4 animate-in fade-in">
      <div className="text-center">
        <div className="text-4xl mb-2">🪐</div>
        <div className="text-sm text-cosmic-muted">{isEn ? "Natal Saturn:" : "Doğum Satürnü:"} {data.natalSaturn.signSymbol} {data.natalSaturn.sign} {data.natalSaturn.degree.toFixed(1)}°</div>
      </div>
      {data.returns.length === 0 && <div className="text-center text-cosmic-muted">{isEn ? "Could not find exact return dates." : "Kesin dönüş tarihleri bulunamadı."}</div>}
      {data.returns.map((r: any, i: number) => (
        <div key={i} className="cosmic-card text-center">
          <div className="text-xs text-cosmic-muted uppercase tracking-wider">{i < 2 ? (isEn ? "1st Return" : "1. Dönüş") : (isEn ? "2nd Return" : "2. Dönüş")}</div>
          <div className="text-3xl font-display text-cosmic-accent mt-2">{r.year}</div>
          <div className="text-sm text-cosmic-muted">{r.signSymbol} {r.sign} {r.degree.toFixed(1)}° ({r.orb}° orb)</div>
        </div>
      ))}
      <div className="cosmic-card bg-gradient-to-r from-amber-900/20 to-purple-900/20 border-amber-500/20 text-center">
        <p className="text-sm text-cosmic-text/80">{isEn
          ? "Saturn Return is a major life transit. Maturity, responsibility, authentic self-definition. Not punishment — initiation."
          : "Satürn Dönüşü büyük bir yaşam transiti. Olgunluk, sorumluluk, otantik kendini tanımlama. Ceza değil — inisiyasyon."}</p>
      </div>
    </div>)}
    <p className="text-xs text-cosmic-muted text-center">{isEn ? "Swiss Ephemeris. For self-reflection." : "Swiss Ephemeris. Kişisel keşif amaçlıdır."}</p>
  </div>);
}
