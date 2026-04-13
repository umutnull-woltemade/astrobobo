"use client";

import { useState, useEffect } from "react";

interface TransitPlanet {
  name: string; symbol: string; sign: string; signSymbol: string;
  degree: number; longitude: number; retrograde: boolean;
}

const ELEMENT_COLORS: Record<string, string> = {
  Aries: '#FF6B6B', Taurus: '#A8C66C', Gemini: '#FFD93D', Cancer: '#80DEEA',
  Leo: '#FFA726', Virgo: '#9CCC65', Libra: '#F06292', Scorpio: '#7E57C2',
  Sagittarius: '#FF7043', Capricorn: '#8D6E63', Aquarius: '#42A5F5', Pisces: '#26C6DA',
  Koç: '#FF6B6B', Boğa: '#A8C66C', İkizler: '#FFD93D', Yengeç: '#80DEEA',
  Aslan: '#FFA726', Başak: '#9CCC65', Terazi: '#F06292', Akrep: '#7E57C2',
  Yay: '#FF7043', Oğlak: '#8D6E63', Kova: '#42A5F5', Balık: '#26C6DA',
};

export default function TransitsClient({ locale }: { locale: "en" | "tr" }) {
  const [planets, setPlanets] = useState<TransitPlanet[]>([]);
  const [timestamp, setTimestamp] = useState("");
  const [loading, setLoading] = useState(true);
  const isEn = locale === "en";

  useEffect(() => {
    fetch(`/api/transits?lang=${locale}`)
      .then(r => r.json())
      .then(d => {
        setPlanets(d.planets || []);
        setTimestamp(d.timestamp || '');
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [locale]);

  if (loading) {
    return <div className="text-center text-cosmic-muted py-12">{isEn ? "Loading sky..." : "Gökyüzü yükleniyor..."}</div>;
  }

  return (
    <div className="space-y-6">
      <div className="text-center text-xs text-cosmic-muted">
        {timestamp && new Date(timestamp).toLocaleString(isEn ? 'en-US' : 'tr-TR')}
      </div>

      {/* Planet Cards */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3">
        {planets.map(p => (
          <div
            key={p.name}
            className="cosmic-card text-center relative overflow-hidden"
            style={{ borderColor: `${ELEMENT_COLORS[p.sign] || '#a78bfa'}40` }}
          >
            {p.retrograde && (
              <div className="absolute top-2 right-2 text-red-400 text-xs font-bold">℞</div>
            )}
            <div className="text-3xl mb-2">{p.symbol}</div>
            <div className="text-sm font-display text-white mb-1">{p.name}</div>
            <div className="text-lg" style={{ color: ELEMENT_COLORS[p.sign] }}>{p.signSymbol}</div>
            <div className="text-xs text-cosmic-muted">{p.sign}</div>
            <div className="text-xs text-cosmic-muted mt-1">{p.degree.toFixed(1)}°</div>
          </div>
        ))}
      </div>

      <p className="text-xs text-cosmic-muted text-center">
        {isEn
          ? "Positions calculated in real-time with Swiss Ephemeris. Updates every 5 minutes."
          : "Swiss Ephemeris ile gerçek zamanlı hesaplanır. Her 5 dakikada güncellenir."}
      </p>
    </div>
  );
}
