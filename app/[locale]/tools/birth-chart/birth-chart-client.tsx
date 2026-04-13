"use client";

import { useState, useCallback } from "react";

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

interface ChartData {
  planets: Planet[];
  houses: { house: number; cusp: number; sign: string; signSymbol: string }[];
  summary: {
    sunSign: { name: string; symbol: string; degree: number } | null;
    moonSign: { name: string; symbol: string; degree: number } | null;
    ascendant: { name: string; symbol: string; degree: number } | null;
    dominantElement: string;
    elementBalance: Record<string, number>;
  };
}

const ELEMENT_COLORS: Record<string, string> = {
  fire: '#FF6B6B',
  earth: '#A8C66C',
  air: '#FFD93D',
  water: '#80DEEA',
};

const ELEMENT_NAMES: Record<string, Record<string, string>> = {
  fire: { en: 'Fire', tr: 'Ateş' },
  earth: { en: 'Earth', tr: 'Toprak' },
  air: { en: 'Air', tr: 'Hava' },
  water: { en: 'Water', tr: 'Su' },
};

export default function BirthChartClient({ locale }: { locale: "en" | "tr" }) {
  const [date, setDate] = useState("");
  const [time, setTime] = useState("12:00");
  const [lat, setLat] = useState("41.0082");
  const [lng, setLng] = useState("28.9784");
  const [loading, setLoading] = useState(false);
  const [chart, setChart] = useState<ChartData | null>(null);
  const [error, setError] = useState<string | null>(null);
  const isEn = locale === "en";

  const calculate = useCallback(async () => {
    if (!date) return;
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(
        `/api/chart?date=${date}&time=${time}&lat=${lat}&lng=${lng}&lang=${locale}`
      );
      if (!res.ok) throw new Error(await res.text());
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setChart(data);
    } catch (e: any) {
      setError(e.message || 'Calculation failed');
    } finally {
      setLoading(false);
    }
  }, [date, time, lat, lng, locale]);

  return (
    <div className="space-y-8">
      {/* Input Form */}
      <div className="cosmic-card max-w-lg mx-auto">
        <div className="grid grid-cols-2 gap-4">
          <div className="col-span-2 sm:col-span-1">
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
              {isEn ? "Birth Date" : "Doğum Tarihi"}
            </label>
            <input
              type="date"
              value={date}
              onChange={e => setDate(e.target.value)}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
              max={new Date().toISOString().split("T")[0]}
            />
          </div>
          <div className="col-span-2 sm:col-span-1">
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
              {isEn ? "Birth Time" : "Doğum Saati"}
            </label>
            <input
              type="time"
              value={time}
              onChange={e => setTime(e.target.value)}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
            />
          </div>
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
              {isEn ? "Latitude" : "Enlem"}
            </label>
            <input
              type="number"
              step="0.0001"
              value={lat}
              onChange={e => setLat(e.target.value)}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
            />
          </div>
          <div>
            <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
              {isEn ? "Longitude" : "Boylam"}
            </label>
            <input
              type="number"
              step="0.0001"
              value={lng}
              onChange={e => setLng(e.target.value)}
              className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
            />
          </div>
        </div>
        <button
          onClick={calculate}
          disabled={!date || loading}
          className="w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white font-semibold disabled:opacity-40 hover:from-purple-500 hover:to-purple-700 transition-all"
        >
          {loading ? (isEn ? "Calculating..." : "Hesaplanıyor...") : (isEn ? "Calculate Birth Chart" : "Doğum Haritası Hesapla")}
        </button>
        <p className="text-[10px] text-cosmic-muted mt-2 text-center">
          {isEn ? "Powered by Swiss Ephemeris — the same precision used by professional astrologers." : "Swiss Ephemeris ile hesaplanır — profesyonel astrologların kullandığı hassasiyet."}
        </p>
      </div>

      {error && (
        <div className="max-w-lg mx-auto p-4 rounded-xl bg-red-500/10 border border-red-500/30 text-red-300 text-sm text-center">
          {error}
        </div>
      )}

      {/* Chart Results */}
      {chart && (
        <div className="space-y-6 animate-in fade-in duration-500">
          {/* Big Three */}
          <div className="grid grid-cols-3 gap-4 max-w-2xl mx-auto">
            {[
              { label: isEn ? "Sun" : "Güneş", emoji: "☀️", data: chart.summary.sunSign },
              { label: isEn ? "Moon" : "Ay", emoji: "🌙", data: chart.summary.moonSign },
              { label: isEn ? "Rising" : "Yükselen", emoji: "⬆️", data: chart.summary.ascendant },
            ].map(item => (
              <div key={item.label} className="cosmic-card text-center">
                <div className="text-3xl mb-2">{item.emoji}</div>
                <div className="text-xs text-cosmic-muted uppercase tracking-wider mb-1">{item.label}</div>
                {item.data ? (
                  <>
                    <div className="text-2xl mb-1">{item.data.symbol}</div>
                    <div className="text-sm font-display text-white">{item.data.name}</div>
                    <div className="text-xs text-cosmic-muted">{item.data.degree.toFixed(1)}°</div>
                  </>
                ) : (
                  <div className="text-xs text-cosmic-muted">{isEn ? "Need birth time" : "Doğum saati gerek"}</div>
                )}
              </div>
            ))}
          </div>

          {/* Element Balance */}
          <div className="cosmic-card max-w-2xl mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
              {isEn ? "Element Balance" : "Element Dengesi"}
            </h3>
            <div className="grid grid-cols-4 gap-3">
              {Object.entries(chart.summary.elementBalance).map(([elem, count]) => (
                <div key={elem} className="text-center">
                  <div
                    className="w-12 h-12 rounded-full mx-auto mb-2 flex items-center justify-center text-lg font-bold"
                    style={{
                      background: `${ELEMENT_COLORS[elem]}20`,
                      border: `2px solid ${ELEMENT_COLORS[elem]}60`,
                      color: ELEMENT_COLORS[elem],
                    }}
                  >
                    {count}
                  </div>
                  <div className="text-xs text-cosmic-muted capitalize">
                    {ELEMENT_NAMES[elem]?.[locale] || elem}
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Planet Table */}
          <div className="cosmic-card max-w-2xl mx-auto overflow-x-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
              {isEn ? "Planet Positions" : "Gezegen Pozisyonları"}
            </h3>
            <table className="w-full text-sm">
              <thead>
                <tr className="text-cosmic-muted text-xs uppercase tracking-wider">
                  <th className="text-left pb-3">{isEn ? "Planet" : "Gezegen"}</th>
                  <th className="text-left pb-3">{isEn ? "Sign" : "Burç"}</th>
                  <th className="text-right pb-3">{isEn ? "Degree" : "Derece"}</th>
                  <th className="text-center pb-3">Rx</th>
                </tr>
              </thead>
              <tbody>
                {chart.planets.map((p: Planet) => (
                  <tr key={p.name} className="border-t border-white/[0.06]">
                    <td className="py-2.5">
                      <span className="mr-2">{p.symbol}</span>
                      {p.name}
                    </td>
                    <td className="py-2.5">
                      <span className="mr-1">{p.signSymbol}</span>
                      <span style={{ color: ELEMENT_COLORS[p.element] }}>{p.sign}</span>
                    </td>
                    <td className="py-2.5 text-right text-cosmic-muted">
                      {p.degree.toFixed(1)}°
                    </td>
                    <td className="py-2.5 text-center">
                      {p.retrograde && <span className="text-red-400 text-xs">℞</span>}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Houses */}
          {chart.houses.length > 0 && (
            <div className="cosmic-card max-w-2xl mx-auto">
              <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">
                {isEn ? "Houses (Placidus)" : "Evler (Placidus)"}
              </h3>
              <div className="grid grid-cols-3 md:grid-cols-4 gap-2">
                {chart.houses.map(h => (
                  <div key={h.house} className="text-center p-2 rounded-lg bg-white/[0.03] border border-white/[0.06]">
                    <div className="text-xs text-cosmic-muted">{isEn ? "House" : "Ev"} {h.house}</div>
                    <div className="text-lg">{h.signSymbol}</div>
                    <div className="text-xs text-cosmic-muted">{h.cusp.toFixed(1)}°</div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn
          ? "Calculated with Swiss Ephemeris. For entertainment and self-reflection only."
          : "Swiss Ephemeris ile hesaplanmıştır. Yalnızca eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
