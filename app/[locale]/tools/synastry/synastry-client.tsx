"use client";

import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, type BirthData } from "@/lib/birth-data/store";

interface Aspect {
  planet1: { name: string; symbol: string };
  planet2: { name: string; symbol: string };
  aspect: string;
  symbol: string;
  nature: string;
  orb: number;
  exact: boolean;
}

interface SynastryData {
  aspects: Aspect[];
  summary: { totalAspects: number; harmonious: number; challenging: number; score: number; rating: string };
}

export default function SynastryClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [p1, setP1] = useState<BirthData | null>(saved || null);
  const [p2, setP2] = useState<BirthData | null>(null);
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<SynastryData | null>(null);

  // Keep p1 synced if user changes saved data on another tool
  useEffect(() => { if (saved && !p1) setP1(saved); }, [saved, p1]);

  const calculate = useCallback(async (a: BirthData, b: BirthData) => {
    setLoading(true);
    try {
      const q = new URLSearchParams({
        date1: a.date, time1: a.time, tz1: a.tz,
        date2: b.date, time2: b.time, tz2: b.tz,
        lang: locale,
      });
      const res = await fetch(`/api/synastry?${q.toString()}`);
      setData(await res.json());
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => {
    if (p1 && p2) calculate(p1, p2);
  }, [p1, p2, calculate]);

  return (
    <div className="space-y-8">
      <div className="grid md:grid-cols-2 gap-4 max-w-3xl mx-auto">
        <div>
          <div className="text-xs uppercase tracking-wider text-cosmic-muted text-center mb-2">{isEn ? "Person 1 — You" : "Kişi 1 — Sen"}</div>
          <BirthDataForm locale={locale} onReady={setP1} submitLabel={isEn ? "Set Person 1" : "Kişi 1 Kaydet"} />
        </div>
        <div>
          <div className="text-xs uppercase tracking-wider text-cosmic-muted text-center mb-2">{isEn ? "Person 2 — Partner" : "Kişi 2 — Partner"}</div>
          <BirthDataForm locale={locale} onReady={setP2} allowCollapsed={false} useSavedStore={false} submitLabel={isEn ? "Set Person 2" : "Kişi 2 Kaydet"} />
        </div>
      </div>

      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Analyzing..." : "Analiz ediliyor..."}</div>}

      {data && (
        <div className="space-y-6 animate-in fade-in">
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-28 h-28 rounded-full text-4xl font-bold font-display"
              style={{ background: `conic-gradient(#a78bfa ${data.summary.score}%, rgba(255,255,255,0.05) ${data.summary.score}%)`, color: data.summary.score >= 50 ? '#a78bfa' : '#f87171' }}>
              {data.summary.score}%
            </div>
            <div className="mt-2 text-sm text-cosmic-muted capitalize">{data.summary.rating}</div>
            <div className="text-xs text-cosmic-muted mt-1">
              {data.summary.harmonious} {isEn ? "harmonious" : "uyumlu"} · {data.summary.challenging} {isEn ? "challenging" : "zorlu"}
            </div>
          </div>

          <div className="cosmic-card max-w-2xl mx-auto">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-4">{isEn ? "Planetary Aspects" : "Gezegen Açıları"} ({data.aspects.length})</h3>
            <div className="space-y-2">
              {data.aspects.slice(0, 20).map((a, i) => (
                <div key={i} className={`flex items-center gap-3 p-2 rounded-lg text-sm ${a.nature === 'harmonious' ? 'bg-green-500/5' : 'bg-red-500/5'}`}>
                  <span>{a.planet1.symbol}</span>
                  <span className={a.nature === 'harmonious' ? 'text-green-400' : 'text-red-400'}>{a.symbol}</span>
                  <span>{a.planet2.symbol}</span>
                  <span className="text-cosmic-muted flex-1">{a.planet1.name} {a.aspect} {a.planet2.name}</span>
                  <span className="text-xs text-cosmic-muted">{a.orb}° orb{a.exact ? ' ✦' : ''}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mx-auto">
        {isEn ? "Swiss Ephemeris precision. For entertainment and self-reflection." : "Swiss Ephemeris hassasiyeti. Eğlence ve kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
