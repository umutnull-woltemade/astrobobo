"use client";
import { useState, useCallback } from "react";

interface Planet { name: string; symbol: string; sign: string; signSymbol: string; degree: number }
interface ProgData { age: number; natal: Planet[]; progressed: Planet[]; signChanges: { planet: string; symbol: string; from: string; fromSymbol: string; to: string; toSymbol: string }[] }

export default function ProgressionsClient({ locale }: { locale: "en" | "tr" }) {
  const [date, setDate] = useState(""); const [age, setAge] = useState("30");
  const [loading, setLoading] = useState(false); const [data, setData] = useState<ProgData | null>(null);
  const isEn = locale === "en";

  const calc = useCallback(async () => {
    if (!date) return; setLoading(true);
    try { const r = await fetch(`/api/progressions?date=${date}&age=${age}&lang=${locale}`); setData(await r.json()); }
    catch {} finally { setLoading(false); }
  }, [date, age, locale]);

  return (
    <div className="space-y-8">
      <div className="cosmic-card max-w-md mx-auto">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
            <input type="date" value={date} onChange={e => { setDate(e.target.value); setData(null); }}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" max={new Date().toISOString().split("T")[0]} />
          </div>
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Current Age" : "Yaş"}</label>
            <input type="number" value={age} onChange={e => { setAge(e.target.value); setData(null); }} min="1" max="120"
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" />
          </div>
        </div>
        <button onClick={calc} disabled={!date || loading}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-indigo-700 text-white font-semibold disabled:opacity-40 transition-all">
          {loading ? "..." : (isEn ? "Calculate Progressions" : "Progresyonları Hesapla")}
        </button>
      </div>

      {data && (
        <div className="space-y-6 animate-in fade-in max-w-lg mx-auto">
          {data.signChanges.length > 0 && (
            <div className="cosmic-card bg-gradient-to-r from-purple-900/20 to-cyan-900/20 border-purple-500/20">
              <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">{isEn ? "Sign Changes" : "Burç Değişimleri"}</h3>
              {data.signChanges.map((c: any) => (
                <div key={c.planet} className="flex items-center gap-2 text-sm py-1">
                  <span>{c.symbol} {c.planet}</span>
                  <span className="text-cosmic-muted">{c.fromSymbol} {c.from}</span>
                  <span className="text-cosmic-accent">→</span>
                  <span className="text-white">{c.toSymbol} {c.to}</span>
                </div>
              ))}
            </div>
          )}

          <div className="cosmic-card">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Natal → Progressed" : "Doğum → Progrese"}</h3>
            <table className="w-full text-sm">
              <thead><tr className="text-cosmic-muted text-xs"><th className="text-left pb-2">{isEn ? "Planet" : "Gezegen"}</th><th className="text-left pb-2">{isEn ? "Natal" : "Doğum"}</th><th className="text-left pb-2">{isEn ? "Progressed" : "Progrese"}</th></tr></thead>
              <tbody>
                {data.natal.map((n: Planet, i: number) => {
                  const p = data.progressed[i];
                  const changed = n.sign !== p.sign;
                  return (
                    <tr key={n.name} className="border-t border-white/[0.06]">
                      <td className="py-2">{n.symbol} {n.name}</td>
                      <td className="py-2 text-cosmic-muted">{n.signSymbol} {n.degree.toFixed(1)}°</td>
                      <td className={`py-2 ${changed ? 'text-cosmic-accent font-semibold' : 'text-cosmic-muted'}`}>{p.signSymbol} {p.degree.toFixed(1)}°</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">{isEn ? "Swiss Ephemeris precision. For entertainment and self-reflection." : "Swiss Ephemeris hassasiyeti. Eğlence ve kişisel keşif amaçlıdır."}</p>
    </div>
  );
}
