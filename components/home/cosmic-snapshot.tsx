"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";
import BirthDataForm from "@/components/tools/birth-data-form";

interface Planet { name: string; symbol: string; longitude: number; sign: string; signSymbol: string; degree: number }
interface Snapshot {
  planets: Planet[];
  summary: {
    sunSign: { name: string; symbol: string; degree: number } | null;
    moonSign: { name: string; symbol: string; degree: number } | null;
    ascendant: { name: string; symbol: string; degree: number } | null;
    dominantElement: string;
  };
}
interface Transit { name: string; symbol: string; longitude: number; retrograde: boolean }
interface Hit { transit: Transit; natal: Planet; aspect: string; symbol: string; orb: number; nature: "harmonious" | "challenging" | "neutral" }

const ASPECTS = [
  { angle: 0, symbol: "☌", name_en: "Conjunction", name_tr: "Kavuşum", nature: "neutral" as const, orb: 5 },
  { angle: 60, symbol: "⚹", name_en: "Sextile", name_tr: "Sekstil", nature: "harmonious" as const, orb: 3 },
  { angle: 90, symbol: "□", name_en: "Square", name_tr: "Kare", nature: "challenging" as const, orb: 4 },
  { angle: 120, symbol: "△", name_en: "Trine", name_tr: "Üçgen", nature: "harmonious" as const, orb: 5 },
  { angle: 180, symbol: "☍", name_en: "Opposition", name_tr: "Karşıt", nature: "challenging" as const, orb: 5 },
];

function topHits(transits: Transit[], natal: Planet[], isEn: boolean): Hit[] {
  const out: Hit[] = [];
  for (const t of transits) {
    for (const n of natal) {
      let diff = Math.abs(t.longitude - n.longitude) % 360;
      if (diff > 180) diff = 360 - diff;
      for (const a of ASPECTS) {
        const orb = Math.abs(diff - a.angle);
        if (orb <= a.orb) {
          out.push({ transit: t, natal: n, aspect: isEn ? a.name_en : a.name_tr, symbol: a.symbol, orb: Math.round(orb * 10) / 10, nature: a.nature });
        }
      }
    }
  }
  return out.sort((a, b) => a.orb - b.orb).slice(0, 3);
}

export default function CosmicSnapshot({ locale, localePath }: { locale: "en" | "tr"; localePath: string }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [snapshot, setSnapshot] = useState<Snapshot | null>(null);
  const [hits, setHits] = useState<Hit[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!saved) { setSnapshot(null); setHits([]); return; }
    setLoading(true);
    Promise.all([
      fetch(`/api/chart?${birthDataQuery(saved, locale)}`).then(r => r.json()),
      fetch(`/api/transits?lang=${locale}`).then(r => r.json()),
    ])
      .then(([natal, transits]: [Snapshot, { planets: Transit[] }]) => {
        setSnapshot(natal);
        if (natal.planets && transits.planets) setHits(topHits(transits.planets, natal.planets, isEn));
      })
      .catch(() => setSnapshot(null))
      .finally(() => setLoading(false));
  }, [saved, locale, isEn]);

  return (
    <div className="mt-16 pt-12 border-t border-cosmic-border/40">
      <h2 className="cosmic-heading text-2xl mb-4">{isEn ? "🔭 Your Cosmic Snapshot" : "🔭 Kozmik Anlık Görüntün"}</h2>
      <p className="text-cosmic-muted mb-6 text-sm">
        {isEn
          ? "Enter your birth data once — see it everywhere. Every tool uses it automatically."
          : "Doğum bilgilerini bir kez gir — her yerde kullanılsın. Tüm araçlar otomatik alır."}
      </p>

      {!saved && <BirthDataForm locale={locale} onReady={() => {}} submitLabel={isEn ? "See My Cosmic Snapshot" : "Kozmik Görüntümü Gör"} />}

      {saved && loading && <div className="text-center text-cosmic-muted text-sm py-6">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}

      {saved && snapshot && (
        <div className="space-y-4">
          <div className="text-center text-xs text-cosmic-muted">{saved.placeName} · {saved.date} {saved.time}</div>
          <div className="grid grid-cols-3 gap-3 max-w-xl mx-auto">
            {[
              { label: isEn ? "Sun" : "Güneş", emoji: "☀️", d: snapshot.summary.sunSign },
              { label: isEn ? "Moon" : "Ay", emoji: "🌙", d: snapshot.summary.moonSign },
              { label: isEn ? "Rising" : "Yükselen", emoji: "⬆️", d: snapshot.summary.ascendant },
            ].map(i => (
              <div key={i.label} className="cosmic-card text-center p-3">
                <div className="text-2xl">{i.emoji}</div>
                <div className="text-[10px] text-cosmic-muted uppercase tracking-wider mt-1">{i.label}</div>
                {i.d ? (
                  <>
                    <div className="text-xl mt-1">{i.d.symbol}</div>
                    <div className="text-xs text-white">{i.d.name}</div>
                    <div className="text-[10px] text-cosmic-muted">{i.d.degree.toFixed(1)}°</div>
                  </>
                ) : (
                  <div className="text-[10px] text-cosmic-muted mt-2">—</div>
                )}
              </div>
            ))}
          </div>

          {hits.length > 0 && (
            <div className="cosmic-card max-w-xl mx-auto bg-gradient-to-r from-purple-900/20 to-indigo-900/20 border-purple-500/20">
              <div className="text-xs uppercase tracking-wider text-cosmic-muted mb-2">{isEn ? "Today — Active Transits" : "Bugün — Aktif Transitler"}</div>
              <div className="space-y-1.5 text-sm">
                {hits.map((h, i) => (
                  <div key={i} className="flex items-center gap-2">
                    <span>{h.transit.symbol}</span>
                    <span className="text-xs text-cosmic-muted">{h.transit.name}</span>
                    <span className={h.nature === 'harmonious' ? 'text-green-400' : h.nature === 'challenging' ? 'text-orange-400' : 'text-cosmic-muted'}>{h.symbol}</span>
                    <span>{h.natal.symbol}</span>
                    <span className="text-xs text-cosmic-muted flex-1">{isEn ? 'natal' : 'natal'} {h.natal.name}</span>
                    <span className="text-[10px] text-cosmic-muted">{h.orb}°</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          <div className="text-center">
            <a href={`${localePath}/tools/birth-chart`} className="inline-block px-5 py-2.5 rounded-xl bg-gradient-to-r from-purple-600 to-purple-800 text-white text-sm font-semibold">
              {isEn ? "Full Birth Chart →" : "Tam Doğum Haritası →"}
            </a>
          </div>
        </div>
      )}
    </div>
  );
}
