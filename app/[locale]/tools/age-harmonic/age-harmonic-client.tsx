"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

const SIGNS = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
const SIGNS_TR = ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
const SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];

function yearsSince(date: string): number {
  const [y, m, d] = date.split('-').map(Number);
  const now = new Date();
  let age = now.getFullYear() - y;
  if (now.getMonth() + 1 < m || (now.getMonth() + 1 === m && now.getDate() < d)) age--;
  return Math.max(1, age);
}

interface HarmonicPlanet { name: string; symbol: string; natalLon: number; harmonicLon: number; sign: string; signSymbol: string; degree: number }

export default function AgeHarmonicClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [age, setAge] = useState(saved ? String(yearsSince(saved.date)) : "30");
  const [planets, setPlanets] = useState<HarmonicPlanet[] | null>(null);
  const [conjunctions, setConjunctions] = useState<string[]>([]);

  const calc = useCallback(async (d: BirthData, ageOverride?: string) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/chart?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      const a = parseInt(ageOverride ?? age) || 30;

      const harmonic: HarmonicPlanet[] = (data.planets || []).map((p: any) => {
        const hLon = (p.longitude * a) % 360;
        const si = Math.floor(hLon / 30);
        return {
          name: p.name, symbol: p.symbol,
          natalLon: p.longitude,
          harmonicLon: Math.round(hLon * 100) / 100,
          sign: isEn ? SIGNS[si] : SIGNS_TR[si],
          signSymbol: SYMBOLS[si],
          degree: Math.round((hLon % 30) * 100) / 100,
        };
      });

      // Find conjunctions (within 8°) between harmonic planets
      const conj: string[] = [];
      for (let i = 0; i < harmonic.length; i++) {
        for (let j = i + 1; j < harmonic.length; j++) {
          let diff = Math.abs(harmonic[i].harmonicLon - harmonic[j].harmonicLon) % 360;
          if (diff > 180) diff = 360 - diff;
          if (diff < 8) {
            conj.push(`${harmonic[i].symbol} ${harmonic[i].name} ☌ ${harmonic[j].symbol} ${harmonic[j].name} (${diff.toFixed(1)}°)`);
          }
        }
      }

      setPlanets(harmonic);
      setConjunctions(conj);
    } catch {} finally { setLoading(false); }
  }, [age, locale, isEn]);

  useEffect(() => {
    if (saved && !planets) {
      const a = String(yearsSince(saved.date));
      setAge(a);
      calc(saved, a);
    }
    // eslint-disable-next-line
  }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={(d) => calc(d)} submitLabel={isEn ? "Use Birth Data" : "Doğum Verilerini Kullan"} />
      <div className="cosmic-card max-w-xs mx-auto">
        <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Harmonic (Age)" : "Harmonik (Yaş)"}</label>
        <input type="number" value={age} onChange={(e) => setAge(e.target.value)} min="1" max="120"
          className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm" />
        <button onClick={() => saved && calc(saved)} disabled={!saved || loading}
          className="w-full mt-3 px-6 py-2.5 rounded-xl bg-gradient-to-r from-purple-600 to-indigo-700 text-white text-sm font-semibold disabled:opacity-40 transition-all">
          {loading ? "..." : (isEn ? "Recalculate" : "Yeniden Hesapla")}
        </button>
      </div>

      {planets && (
        <div className="max-w-lg mx-auto space-y-4 animate-in fade-in">
          <div className="text-center text-sm text-cosmic-muted">{isEn ? `Harmonic ${age} — each natal degree × ${age}` : `Harmonik ${age} — her natal derece × ${age}`}</div>

          {conjunctions.length > 0 && (
            <div className="cosmic-card bg-gradient-to-r from-purple-900/20 to-amber-900/20 border-purple-500/20">
              <h3 className="text-xs uppercase tracking-widest text-cosmic-accent mb-2">{isEn ? "Activated Conjunctions" : "Aktif Kavuşumlar"}</h3>
              <div className="space-y-1">
                {conjunctions.map((c, i) => (
                  <div key={i} className="text-sm text-white">{c}</div>
                ))}
              </div>
              <p className="text-[10px] text-cosmic-muted mt-2">{isEn ? "Conjunctions in harmonic charts indicate themes activated this year." : "Harmonik haritadaki kavuşumlar bu yıl aktif olan temaları gösterir."}</p>
            </div>
          )}

          <div className="cosmic-card">
            <table className="w-full text-sm">
              <thead><tr className="text-cosmic-muted text-xs"><th className="text-left pb-2">{isEn ? "Planet" : "Gezegen"}</th><th className="text-left pb-2">{isEn ? "Harmonic Sign" : "Harmonik Burç"}</th><th className="text-right pb-2">°</th></tr></thead>
              <tbody>
                {planets.map(p => (
                  <tr key={p.name} className="border-t border-white/[0.06]">
                    <td className="py-2">{p.symbol} {p.name}</td>
                    <td className="py-2">{p.signSymbol} {p.sign}</td>
                    <td className="py-2 text-right text-cosmic-muted">{p.degree.toFixed(1)}°</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Age harmonics: natal longitude × age. Swiss Ephemeris." : "Yaş harmonikleri: natal boylam × yaş. Swiss Ephemeris."}</p>
    </div>
  );
}
