"use client";

import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import ChartWheel from "@/components/tools/chart-wheel";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";
import { getDignity, DIGNITY_LABELS, SIGN_EN, type Dignity } from "@/lib/astrology/dignities";
import { getInterpretation } from "@/lib/astrology/interpretations";
import { HOUSE_THEMES, getPlanetsInHouses } from "@/lib/astrology/house-meanings";

interface Planet {
  name: string;
  symbol: string;
  sign: string;
  signSymbol: string;
  degree: number;
  longitude: number;
  element: string;
  retrograde: boolean;
}

interface Aspect {
  planet1: { name: string; symbol: string };
  planet2: { name: string; symbol: string };
  aspect: string;
  symbol: string;
  nature: string;
  orb: number;
  exact: boolean;
}

interface ChartData {
  planets: Planet[];
  aspects: Aspect[];
  houses: { house: number; cusp: number; sign: string; signSymbol: string }[];
  summary: {
    sunSign: { name: string; symbol: string; degree: number } | null;
    moonSign: { name: string; symbol: string; degree: number } | null;
    ascendant: { name: string; symbol: string; degree: number } | null;
    dominantElement: string;
    elementBalance: Record<string, number>;
    dominantModality?: string;
    modalityBalance?: Record<string, number>;
  };
}

const ELEMENT_COLORS: Record<string, string> = { fire: '#FF6B6B', earth: '#A8C66C', air: '#FFD93D', water: '#80DEEA' };
const ELEMENT_NAMES: Record<string, Record<string, string>> = {
  fire: { en: 'Fire', tr: 'Ateş' }, earth: { en: 'Earth', tr: 'Toprak' },
  air: { en: 'Air', tr: 'Hava' }, water: { en: 'Water', tr: 'Su' },
};
const MODALITY_COLORS: Record<string, string> = { cardinal: '#F06292', fixed: '#FFB74D', mutable: '#81C784' };
const MODALITY_NAMES: Record<string, Record<string, string>> = {
  cardinal: { en: 'Cardinal', tr: 'Öncü' }, fixed: { en: 'Fixed', tr: 'Sabit' },
  mutable: { en: 'Mutable', tr: 'Değişken' },
};

export default function BirthChartClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [chart, setChart] = useState<ChartData | null>(null);
  const [error, setError] = useState<string | null>(null);

  const calculate = useCallback(async (d: BirthData) => {
    setLoading(true); setError(null);
    try {
      const res = await fetch(`/api/chart?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setChart(data);
    } catch (e: any) {
      setError(e.message || 'Calculation failed');
    } finally { setLoading(false); }
  }, [locale]);

  // Auto-calc on mount if we have saved data
  useEffect(() => {
    if (saved && !chart) calculate(saved);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calculate} submitLabel={isEn ? "Calculate Birth Chart" : "Doğum Haritası Hesapla"} />

      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}
      {error && (
        <div className="max-w-lg mx-auto p-4 rounded-xl bg-red-500/10 border border-red-500/30 text-red-300 text-sm text-center">{error}</div>
      )}

      {chart && (
        <div className="space-y-6 animate-in fade-in duration-500">
          <div className="grid grid-cols-3 gap-4 max-w-2xl mx-auto">
            {[
              { label: isEn ? "Sun" : "Güneş", emoji: "☀️", data: chart.summary.sunSign },
              { label: isEn ? "Moon" : "Ay", emoji: "🌙", data: chart.summary.moonSign },
              { label: isEn ? "Rising" : "Yükselen", emoji: "⬆️", data: chart.summary.ascendant },
            ].map(item => (
              <div key={item.label} className="cosmic-card text-center">
                <div className="text-3xl mb-2">{item.emoji}</div>
                <div className="text-xs text-cosmic-muted uppercase tracking-wider mb-1">{item.label}</div>
                {item.data ? (<>
                  <div className="text-2xl mb-1">{item.data.symbol}</div>
                  <div className="text-sm font-display text-white">{item.data.name}</div>
                  <div className="text-xs text-cosmic-muted">{item.data.degree.toFixed(1)}°</div>
                </>) : (<div className="text-xs text-cosmic-muted">{isEn ? "Need birth time" : "Doğum saati gerek"}</div>)}
              </div>
            ))}
          </div>

          {chart.houses.length > 0 && chart.planets.length > 0 && (
            <div className="cosmic-card max-w-2xl mx-auto">
              <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4 text-center">{isEn ? "Chart Wheel" : "Harita Çarkı"}</h3>
              <ChartWheel
                planets={chart.planets.map(p => ({ symbol: p.symbol, longitude: p.longitude, name: p.name }))}
                houses={chart.houses}
                ascendant={chart.houses[0]?.cusp || 0}
              />
            </div>
          )}

          <div className="cosmic-card max-w-2xl mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Element Balance" : "Element Dengesi"}</h3>
            <div className="grid grid-cols-4 gap-3">
              {Object.entries(chart.summary.elementBalance).map(([elem, count]) => (
                <div key={elem} className="text-center">
                  <div className="w-12 h-12 rounded-full mx-auto mb-2 flex items-center justify-center text-lg font-bold"
                    style={{ background: `${ELEMENT_COLORS[elem]}20`, border: `2px solid ${ELEMENT_COLORS[elem]}60`, color: ELEMENT_COLORS[elem] }}>
                    {count}
                  </div>
                  <div className="text-xs text-cosmic-muted capitalize">{ELEMENT_NAMES[elem]?.[locale] || elem}</div>
                </div>
              ))}
            </div>
          </div>

          {chart.summary.modalityBalance && (
            <div className="cosmic-card max-w-2xl mx-auto">
              <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Modality Balance" : "Modalite Dengesi"}</h3>
              <div className="grid grid-cols-3 gap-3">
                {Object.entries(chart.summary.modalityBalance).map(([mod, count]) => (
                  <div key={mod} className="text-center">
                    <div className="w-12 h-12 rounded-full mx-auto mb-2 flex items-center justify-center text-lg font-bold"
                      style={{ background: `${MODALITY_COLORS[mod]}20`, border: `2px solid ${MODALITY_COLORS[mod]}60`, color: MODALITY_COLORS[mod] }}>
                      {count}
                    </div>
                    <div className="text-xs text-cosmic-muted capitalize">{MODALITY_NAMES[mod]?.[locale] || mod}</div>
                  </div>
                ))}
              </div>
            </div>
          )}

          <div className="cosmic-card max-w-2xl mx-auto overflow-x-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Planet Positions" : "Gezegen Pozisyonları"}</h3>
            <table className="w-full text-sm">
              <thead><tr className="text-cosmic-muted text-xs uppercase tracking-wider">
                <th className="text-left pb-3">{isEn ? "Planet" : "Gezegen"}</th>
                <th className="text-left pb-3">{isEn ? "Sign" : "Burç"}</th>
                <th className="text-right pb-3">{isEn ? "Degree" : "Derece"}</th>
                <th className="text-center pb-3">Rx</th>
              </tr></thead>
              <tbody>
                {chart.planets.map((p: Planet) => {
                  const signEn = SIGN_EN[p.sign] || p.sign;
                  const dignity = getDignity(p.symbol, signEn);
                  const dl = DIGNITY_LABELS[dignity];
                  const interp = getInterpretation(p.symbol, signEn);
                  return (
                    <tr key={p.name} className="border-t border-white/[0.06]">
                      <td className="py-2.5"><span className="mr-2">{p.symbol}</span>{p.name}</td>
                      <td className="py-2.5">
                        <div><span className="mr-1">{p.signSymbol}</span><span style={{ color: ELEMENT_COLORS[p.element] }}>{p.sign}</span>{dl.en && <span className="ml-1.5 text-[10px] px-1.5 py-0.5 rounded-full" style={{ color: dl.color, background: `${dl.color}15`, border: `1px solid ${dl.color}30` }}>{isEn ? dl.en : dl.tr}</span>}</div>
                        {interp && <div className="text-[11px] text-cosmic-muted/70 mt-0.5 leading-tight">{isEn ? interp.en : interp.tr}</div>}
                      </td>
                      <td className="py-2.5 text-right text-cosmic-muted">{p.degree.toFixed(1)}°</td>
                      <td className="py-2.5 text-center">{p.retrograde && <span className="text-red-400 text-xs">℞</span>}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>

          {chart.houses.length > 0 && (() => {
            const pih = getPlanetsInHouses(chart.planets, chart.houses);
            return (
              <div className="cosmic-card max-w-2xl mx-auto">
                <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Houses (Placidus)" : "Evler (Placidus)"}</h3>
                <div className="space-y-2">
                  {chart.houses.map(h => {
                    const planetsHere = pih[h.house] || [];
                    const theme = HOUSE_THEMES[h.house];
                    return (
                      <div key={h.house} className={`flex items-start gap-3 p-2.5 rounded-lg ${planetsHere.length > 0 ? 'bg-white/[0.04] border border-white/[0.08]' : 'bg-white/[0.01]'}`}>
                        <div className="w-8 text-center shrink-0">
                          <div className="text-xs text-cosmic-muted">{h.house}</div>
                          <div className="text-sm">{h.signSymbol}</div>
                        </div>
                        <div className="flex-1 min-w-0">
                          {planetsHere.length > 0 && (
                            <div className="flex gap-1.5 mb-0.5 flex-wrap">
                              {planetsHere.map(p => <span key={p.name} className="text-sm" title={p.name}>{p.symbol}</span>)}
                            </div>
                          )}
                          <div className="text-[10px] text-cosmic-muted/60 leading-tight">{theme ? (isEn ? theme.en : theme.tr) : ''}</div>
                        </div>
                        <div className="text-[10px] text-cosmic-muted shrink-0">{h.cusp.toFixed(1)}°</div>
                      </div>
                    );
                  })}
                </div>
              </div>
            );
          })()}

          {chart.aspects && chart.aspects.length > 0 && (
            <div className="cosmic-card max-w-2xl mx-auto">
              <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
                {isEn ? "Natal Aspects" : "Doğum Açıları"} ({chart.aspects.length})
              </h3>
              <div className="space-y-1">
                {chart.aspects.map((a: Aspect, i: number) => (
                  <div key={i} className={`flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm ${a.nature === 'harmonious' ? 'bg-green-500/5' : a.nature === 'challenging' ? 'bg-red-500/5' : 'bg-purple-500/5'}`}>
                    <span className="w-6 text-center">{a.planet1.symbol}</span>
                    <span className={`w-4 text-center ${a.nature === 'harmonious' ? 'text-green-400' : a.nature === 'challenging' ? 'text-red-400' : 'text-purple-400'}`}>{a.symbol}</span>
                    <span className="w-6 text-center">{a.planet2.symbol}</span>
                    <span className="text-cosmic-muted flex-1 text-xs">{a.planet1.name} {a.aspect} {a.planet2.name}</span>
                    <span className="text-[10px] text-cosmic-muted">{a.orb}°{a.exact ? ' ✦' : ''}</span>
                  </div>
                ))}
              </div>
            </div>
          )}
          {/* Share-friendly summary card */}
          <div className="cosmic-card max-w-2xl mx-auto bg-gradient-to-br from-[#0d0820] via-[#1a1040] to-[#0d0820] border-purple-500/30 text-center" id="chart-summary">
            <div className="text-[10px] uppercase tracking-widest text-cosmic-muted mb-3">astrobobo.com</div>
            <div className="flex justify-center gap-6 mb-3">
              {[
                { label: "☀️", data: chart.summary.sunSign },
                { label: "🌙", data: chart.summary.moonSign },
                { label: "⬆️", data: chart.summary.ascendant },
              ].map((i, idx) => (
                <div key={idx} className="text-center">
                  <div className="text-lg">{i.label}</div>
                  {i.data && <div className="text-sm text-white">{i.data.symbol} {i.data.name}</div>}
                </div>
              ))}
            </div>
            <div className="text-xs text-cosmic-muted">
              {chart.summary.dominantElement && <span className="capitalize">{ELEMENT_NAMES[chart.summary.dominantElement]?.[locale]} {isEn ? "dominant" : "baskın"}</span>}
              {chart.summary.dominantModality && <span> · {MODALITY_NAMES[chart.summary.dominantModality]?.[locale]}</span>}
            </div>
            <div className="text-[10px] text-cosmic-muted/50 mt-2">{isEn ? "Screenshot to share" : "Paylaşmak için ekran görüntüsü al"}</div>
          </div>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn ? "Calculated with Swiss Ephemeris. For entertainment and self-reflection only."
              : "Swiss Ephemeris ile hesaplanmıştır. Yalnızca eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
