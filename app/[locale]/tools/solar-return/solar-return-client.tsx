"use client";

import { useState, useCallback } from "react";

interface SolarReturnData {
  returnDate: string;
  returnYear: number;
  natalSunDegree: number;
  ascendant: { name: string; symbol: string; degree: number } | null;
  planets: { name: string; symbol: string; sign: string; signSymbol: string; degree: number; retrograde: boolean }[];
}

export default function SolarReturnClient({ locale }: { locale: "en" | "tr" }) {
  const [date, setDate] = useState("");
  const [year, setYear] = useState(String(new Date().getFullYear()));
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<SolarReturnData | null>(null);
  const isEn = locale === "en";

  const calculate = useCallback(async () => {
    if (!date) return;
    setLoading(true);
    try {
      const res = await fetch(`/api/solar-return?date=${date}&year=${year}&lang=${locale}`);
      const d = await res.json();
      if (d.error) throw new Error(d.error);
      setData(d);
    } catch { /* ignore */ } finally { setLoading(false); }
  }, [date, year, locale]);

  return (
    <div className="space-y-8">
      <div className="cosmic-card max-w-md mx-auto">
        <div className="space-y-4">
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
            <input type="date" value={date} onChange={e => { setDate(e.target.value); setData(null); }}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
              max={new Date().toISOString().split("T")[0]} />
          </div>
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Return Year" : "Dönüş Yılı"}</label>
            <input type="number" value={year} onChange={e => { setYear(e.target.value); setData(null); }}
              min="1900" max="2100"
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" />
          </div>
        </div>
        <button onClick={calculate} disabled={!date || loading}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-amber-600 to-orange-700 text-white font-semibold disabled:opacity-40 transition-all">
          {loading ? "..." : (isEn ? "Calculate Solar Return" : "Solar Return Hesapla")}
        </button>
      </div>

      {data && (
        <div className="space-y-6 animate-in fade-in">
          {/* Return Info */}
          <div className="text-center">
            <div className="text-4xl mb-4">☀️</div>
            <h2 className="text-xl font-display text-white">
              {isEn ? `Solar Return ${data.returnYear}` : `Solar Return ${data.returnYear}`}
            </h2>
            <div className="text-sm text-cosmic-muted mt-1">
              {new Date(data.returnDate).toLocaleDateString(isEn ? 'en-US' : 'tr-TR', { dateStyle: 'long' })}
            </div>
            {data.ascendant && (
              <div className="mt-3 text-sm">
                <span className="text-cosmic-muted">{isEn ? "Return Ascendant:" : "Dönüş Yükseleni:"}</span>
                <span className="ml-2 text-cosmic-accent">{data.ascendant.symbol} {data.ascendant.name} {data.ascendant.degree.toFixed(1)}°</span>
              </div>
            )}
          </div>

          {/* Planet Table */}
          <div className="cosmic-card max-w-lg mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
              {isEn ? "Solar Return Planets" : "Solar Return Gezegenleri"}
            </h3>
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

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn ? "Swiss Ephemeris precision. For entertainment and self-reflection." : "Swiss Ephemeris hassasiyeti. Eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
