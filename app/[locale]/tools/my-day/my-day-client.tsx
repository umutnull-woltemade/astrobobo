"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";
import BirthDataForm from "@/components/tools/birth-data-form";

interface DayData {
  chart: any;
  transits: any;
  voc: any;
  moonSign: any;
}

const ASPECTS = [
  { angle: 0, symbol: "☌", name_en: "Conjunction", name_tr: "Kavuşum", nature: "neutral" as const, orb: 5 },
  { angle: 60, symbol: "⚹", name_en: "Sextile", name_tr: "Sekstil", nature: "harmonious" as const, orb: 3 },
  { angle: 90, symbol: "□", name_en: "Square", name_tr: "Kare", nature: "challenging" as const, orb: 4 },
  { angle: 120, symbol: "△", name_en: "Trine", name_tr: "Üçgen", nature: "harmonious" as const, orb: 5 },
  { angle: 180, symbol: "☍", name_en: "Opposition", name_tr: "Karşıt", nature: "challenging" as const, orb: 5 },
];

function topTransitAspects(transits: any[], natal: any[], isEn: boolean) {
  const hits: any[] = [];
  for (const t of transits) {
    for (const n of natal) {
      let diff = Math.abs(t.longitude - n.longitude) % 360;
      if (diff > 180) diff = 360 - diff;
      for (const a of ASPECTS) {
        const orb = Math.abs(diff - a.angle);
        if (orb <= a.orb) {
          hits.push({
            transit: t, natal: n,
            aspect: isEn ? a.name_en : a.name_tr,
            symbol: a.symbol, orb: Math.round(orb * 10) / 10,
            nature: a.nature,
          });
        }
      }
    }
  }
  return hits.sort((a, b) => a.orb - b.orb).slice(0, 5);
}

export default function MyDayClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [day, setDay] = useState<DayData | null>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!saved) return;
    setLoading(true);
    const q = birthDataQuery(saved, locale);
    Promise.all([
      fetch(`/api/chart?${q}`).then(r => r.json()),
      fetch(`/api/transits?lang=${locale}`).then(r => r.json()),
      fetch(`/api/voc-moon?lang=${locale}`).then(r => r.json()),
      fetch(`/api/moon-sign?${q}`).then(r => r.json()),
    ])
      .then(([chart, transits, voc, moonSign]) => setDay({ chart, transits, voc, moonSign }))
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [saved, locale]);

  if (!saved) {
    return (
      <div className="space-y-4">
        <p className="text-center text-cosmic-muted text-sm">{isEn ? "Enter your birth data to get your personalized daily reading." : "Kişisel günlük okumanız için doğum verilerinizi girin."}</p>
        <BirthDataForm locale={locale} onReady={() => {}} submitLabel={isEn ? "Get My Cosmic Day" : "Kozmik Günümü Al"} />
      </div>
    );
  }

  if (loading) return <div className="text-center text-cosmic-muted py-12">{isEn ? "Loading your cosmic day..." : "Kozmik günün yükleniyor..."}</div>;
  if (!day) return null;

  const { chart, transits, voc, moonSign } = day;
  const aspects = topTransitAspects(transits?.planets || [], chart?.planets || [], isEn);
  const today = new Date().toLocaleDateString(isEn ? "en-US" : "tr-TR", { dateStyle: "long" });

  return (
    <div className="space-y-4 max-w-lg mx-auto">
      <div className="text-center text-xs text-cosmic-muted">{today} · {saved.placeName}</div>

      {/* Big Three */}
      <div className="grid grid-cols-3 gap-2">
        {[
          { label: isEn ? "Sun" : "Güneş", d: chart?.summary?.sunSign, emoji: "☀️" },
          { label: isEn ? "Moon" : "Ay", d: chart?.summary?.moonSign, emoji: "🌙" },
          { label: isEn ? "Rising" : "Yükselen", d: chart?.summary?.ascendant, emoji: "⬆️" },
        ].map(i => (
          <div key={i.label} className="cosmic-card text-center p-2">
            <div className="text-lg">{i.emoji}</div>
            <div className="text-[10px] text-cosmic-muted">{i.label}</div>
            {i.d && <div className="text-sm text-white">{i.d.symbol} {i.d.name}</div>}
          </div>
        ))}
      </div>

      {/* Natal Moon */}
      {moonSign?.moon && (
        <div className="cosmic-card text-center">
          <div className="text-xs text-cosmic-muted uppercase tracking-wider">{isEn ? "Your Natal Moon" : "Doğum Ay'ın"}</div>
          <div className="text-xl mt-1">{moonSign.moon.symbol} {moonSign.moon.sign}</div>
          {moonSign.meaning && <p className="text-xs text-cosmic-text/70 mt-2">{moonSign.meaning}</p>}
        </div>
      )}

      {/* Void of Course */}
      {voc && (
        <div className={`cosmic-card text-center ${voc.isVoidNow ? 'bg-gradient-to-r from-slate-900/40 to-indigo-900/40 border-indigo-500/30' : ''}`}>
          <div className="text-xs text-cosmic-muted uppercase tracking-wider">{isEn ? "Moon Status" : "Ay Durumu"}</div>
          <div className="text-sm mt-1">
            {voc.isVoidNow
              ? (isEn ? "🌑 Void of Course — rest window" : "🌑 Yörüngesiz — dinlenme penceresi")
              : `${voc.moonSign?.symbol || '🌙'} ${voc.moonSign?.name || ''} → ${voc.nextSign?.symbol || ''} ${voc.nextSign?.name || ''}`}
          </div>
        </div>
      )}

      {/* Top Transit Aspects */}
      {aspects.length > 0 && (
        <div className="cosmic-card">
          <h3 className="text-xs uppercase tracking-widest text-cosmic-accent mb-2">{isEn ? "Today's Transits to Your Chart" : "Bugünün Haritana Transitleri"}</h3>
          <div className="space-y-1 text-sm">
            {aspects.map((a, i) => (
              <div key={i} className="flex items-center gap-2 py-1">
                <span>{a.transit.symbol}</span>
                <span className={a.nature === 'harmonious' ? 'text-green-400' : a.nature === 'challenging' ? 'text-orange-400' : 'text-purple-400'}>{a.symbol}</span>
                <span>{a.natal.symbol}</span>
                <span className="text-xs text-cosmic-muted flex-1">{a.transit.name} {a.aspect} {isEn ? "natal" : "natal"} {a.natal.name}</span>
                <span className="text-[10px] text-cosmic-muted">{a.orb}°</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Current Retrogrades */}
      {transits?.planets?.filter((p: any) => p.retrograde).length > 0 && (
        <div className="cosmic-card">
          <h3 className="text-xs uppercase tracking-widest text-red-400 mb-2">{isEn ? "Currently Retrograde" : "Şu An Retrograde"}</h3>
          <div className="flex flex-wrap gap-2">
            {transits.planets.filter((p: any) => p.retrograde).map((p: any) => (
              <span key={p.name} className="text-xs px-2 py-1 rounded-full bg-red-500/10 border border-red-500/20 text-red-300">
                {p.symbol} {p.name} ℞
              </span>
            ))}
          </div>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Your personalized daily cosmic briefing. Updated in real-time." : "Kişisel günlük kozmik bilgilendirmen. Gerçek zamanlı güncellenir."}</p>
    </div>
  );
}
