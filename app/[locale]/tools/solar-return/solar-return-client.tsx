"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

interface SolarReturnData {
  returnDate: string;
  returnYear: number;
  natalSunDegree: number;
  ascendant: { name: string; symbol: string; degree: number } | null;
  planets: { name: string; symbol: string; sign: string; signSymbol: string; degree: number; retrograde: boolean }[];
}

export default function SolarReturnClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [year, setYear] = useState(String(new Date().getFullYear()));
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<SolarReturnData | null>(null);

  const calculate = useCallback(async (d: BirthData, yr?: string) => {
    setLoading(true);
    try {
      const y = yr ?? year;
      const res = await fetch(`/api/solar-return?${birthDataQuery(d, locale)}&year=${y}`);
      const j = await res.json();
      if (j.error) throw new Error(j.error);
      setData(j);
    } catch {} finally { setLoading(false); }
  }, [year, locale]);

  useEffect(() => { if (saved && !data) calculate(saved); /* eslint-disable-next-line */ }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={(d) => calculate(d)} accent="amber" submitLabel={isEn ? "Use Birth Data" : "Doğum Verilerini Kullan"} />
      <div className="cosmic-card max-w-xs mx-auto">
        <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Return Year" : "Dönüş Yılı"}</label>
        <input type="number" value={year} onChange={e => setYear(e.target.value)} min="1900" max="2100"
          className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-amber-500 focus:outline-none text-sm" />
        <button onClick={() => saved && calculate(saved)} disabled={!saved || loading}
          className="w-full mt-3 px-6 py-2.5 rounded-xl bg-gradient-to-r from-amber-600 to-orange-700 text-white text-sm font-semibold disabled:opacity-40 transition-all">
          {loading ? "..." : (isEn ? "Calculate Solar Return" : "Solar Return Hesapla")}
        </button>
      </div>

      {data && (
        <div className="space-y-6 animate-in fade-in">
          <div className="text-center">
            <div className="text-4xl mb-4">☀️</div>
            <h2 className="text-xl font-display text-white">{isEn ? `Solar Return ${data.returnYear}` : `Solar Return ${data.returnYear}`}</h2>
            <div className="text-sm text-cosmic-muted mt-1">{new Date(data.returnDate).toLocaleDateString(isEn ? 'en-US' : 'tr-TR', { dateStyle: 'long' })}</div>
            {data.ascendant && (
              <div className="mt-3 text-sm">
                <span className="text-cosmic-muted">{isEn ? "Return Ascendant:" : "Dönüş Yükseleni:"}</span>
                <span className="ml-2 text-cosmic-accent">{data.ascendant.symbol} {data.ascendant.name} {data.ascendant.degree.toFixed(1)}°</span>
              </div>
            )}
          </div>

          <div className="cosmic-card max-w-lg mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Solar Return Planets" : "Solar Return Gezegenleri"}</h3>
            <table className="w-full text-sm">
              <tbody>
                {data.planets.map(p => (
                  <tr key={p.name} className="border-t border-white/[0.06]">
                    <td className="py-2">{p.symbol} {p.name}</td>
                    <td className="py-2">{p.signSymbol} {p.sign}</td>
                    <td className="py-2 text-right text-cosmic-muted">{p.degree.toFixed(1)}°</td>
                    <td className="py-2 text-center">{p.retrograde && <span className="text-red-400 text-xs">℞</span>}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">{isEn ? "Swiss Ephemeris precision. For entertainment and self-reflection." : "Swiss Ephemeris hassasiyeti. Eğlence ve kişisel keşif amaçlıdır."}</p>
    </div>
  );
}
