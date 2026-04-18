"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";

interface TransitPlanet {
  name: string; symbol: string; sign: string; signSymbol: string;
  degree: number; longitude: number; retrograde: boolean;
}

interface NatalPlanet { name: string; symbol: string; longitude: number; sign: string; signSymbol: string; degree: number }

interface Aspect { transit: TransitPlanet; natal: NatalPlanet; kind: string; symbol: string; orb: number; nature: "harmonious" | "challenging" | "neutral" }

const ELEMENT_COLORS: Record<string, string> = {
  Aries: '#FF6B6B', Taurus: '#A8C66C', Gemini: '#FFD93D', Cancer: '#80DEEA',
  Leo: '#FFA726', Virgo: '#9CCC65', Libra: '#F06292', Scorpio: '#7E57C2',
  Sagittarius: '#FF7043', Capricorn: '#8D6E63', Aquarius: '#42A5F5', Pisces: '#26C6DA',
  Koç: '#FF6B6B', Boğa: '#A8C66C', İkizler: '#FFD93D', Yengeç: '#80DEEA',
  Aslan: '#FFA726', Başak: '#9CCC65', Terazi: '#F06292', Akrep: '#7E57C2',
  Yay: '#FF7043', Oğlak: '#8D6E63', Kova: '#42A5F5', Balık: '#26C6DA',
};

const ASPECTS = [
  { angle: 0,   symbol: "☌", name_en: "Conjunction", name_tr: "Kavuşum", nature: "neutral" as const, orb: 6 },
  { angle: 60,  symbol: "⚹", name_en: "Sextile",     name_tr: "Sekstil",  nature: "harmonious" as const, orb: 4 },
  { angle: 90,  symbol: "□", name_en: "Square",      name_tr: "Kare",     nature: "challenging" as const, orb: 5 },
  { angle: 120, symbol: "△", name_en: "Trine",       name_tr: "Üçgen",    nature: "harmonious" as const, orb: 6 },
  { angle: 180, symbol: "☍", name_en: "Opposition",  name_tr: "Karşıt",   nature: "challenging" as const, orb: 6 },
];

function findAspects(transits: TransitPlanet[], natal: NatalPlanet[], isEn: boolean): Aspect[] {
  const out: Aspect[] = [];
  for (const t of transits) {
    for (const n of natal) {
      let diff = Math.abs(t.longitude - n.longitude) % 360;
      if (diff > 180) diff = 360 - diff;
      for (const a of ASPECTS) {
        const orb = Math.abs(diff - a.angle);
        if (orb <= a.orb) {
          out.push({ transit: t, natal: n, kind: isEn ? a.name_en : a.name_tr, symbol: a.symbol, orb: Math.round(orb * 10) / 10, nature: a.nature });
        }
      }
    }
  }
  return out.sort((a, b) => a.orb - b.orb).slice(0, 12);
}

export default function TransitsClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [planets, setPlanets] = useState<TransitPlanet[]>([]);
  const [natal, setNatal] = useState<NatalPlanet[] | null>(null);
  const [timestamp, setTimestamp] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const live = fetch(`/api/transits?lang=${locale}`).then(r => r.json());
    const nat = saved ? fetch(`/api/chart?${birthDataQuery(saved, locale)}`).then(r => r.json()) : Promise.resolve(null);
    Promise.all([live, nat])
      .then(([t, n]) => {
        setPlanets(t.planets || []);
        setTimestamp(t.timestamp || '');
        if (n?.planets) setNatal(n.planets);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [locale, saved]);

  if (loading) {
    return <div className="text-center text-cosmic-muted py-12">{isEn ? "Loading sky..." : "Gökyüzü yükleniyor..."}</div>;
  }

  const aspects = natal ? findAspects(planets, natal, isEn) : [];

  return (
    <div className="space-y-6">
      <div className="text-center text-xs text-cosmic-muted">
        {timestamp && new Date(timestamp).toLocaleString(isEn ? 'en-US' : 'tr-TR')}
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3">
        {planets.map(p => (
          <div key={p.name} className="cosmic-card text-center relative overflow-hidden" style={{ borderColor: `${ELEMENT_COLORS[p.sign] || '#a78bfa'}40` }}>
            {p.retrograde && <div className="absolute top-2 right-2 text-red-400 text-xs font-bold">℞</div>}
            <div className="text-3xl mb-2">{p.symbol}</div>
            <div className="text-sm font-display text-white mb-1">{p.name}</div>
            <div className="text-lg" style={{ color: ELEMENT_COLORS[p.sign] }}>{p.signSymbol}</div>
            <div className="text-xs text-cosmic-muted">{p.sign}</div>
            <div className="text-xs text-cosmic-muted mt-1">{p.degree.toFixed(1)}°</div>
          </div>
        ))}
      </div>

      {saved && natal && aspects.length > 0 && (
        <div className="cosmic-card max-w-2xl mx-auto">
          <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">
            {isEn ? "🔔 Transits to Your Natal Chart" : "🔔 Doğum Haritanıza Transitler"}
          </h3>
          <div className="space-y-1.5 text-sm">
            {aspects.map((a, i) => (
              <div key={i} className="flex items-center gap-2 py-1.5 border-t border-white/[0.04] first:border-0">
                <span className="w-6">{a.transit.symbol}</span>
                <span className="text-xs text-cosmic-muted flex-1">{a.transit.name}</span>
                <span className={a.nature === 'harmonious' ? 'text-green-400' : a.nature === 'challenging' ? 'text-orange-400' : 'text-cosmic-muted'}>{a.symbol}</span>
                <span className="w-6 text-right">{a.natal.symbol}</span>
                <span className="text-xs text-cosmic-muted flex-1">{isEn ? 'natal' : 'natal'} {a.natal.name}</span>
                <span className="text-xs text-cosmic-muted">{a.orb}°</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {!saved && (
        <div className="cosmic-card text-center max-w-md mx-auto bg-gradient-to-r from-purple-900/20 to-indigo-900/20 border-purple-500/20">
          <p className="text-sm text-cosmic-text/80">
            {isEn ? "💡 Add your birth data on the homepage to see transits to your natal chart." : "💡 Ana sayfada doğum verilerini ekle, doğum haritana gelen transitleri gör."}
          </p>
        </div>
      )}

      <p className="text-xs text-cosmic-muted text-center">
        {isEn ? "Positions calculated in real-time with Swiss Ephemeris." : "Swiss Ephemeris ile gerçek zamanlı hesaplanır."}
      </p>
    </div>
  );
}
