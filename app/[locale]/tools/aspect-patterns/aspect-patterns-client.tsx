"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

interface Planet { name: string; symbol: string; longitude: number; sign: string; signSymbol: string }
interface Pattern { type: string; typeEn: string; typeTr: string; emoji: string; planets: string[]; desc_en: string; desc_tr: string }

function within(a: number, b: number, orb: number): boolean {
  let d = Math.abs(a - b) % 360;
  if (d > 180) d = 360 - d;
  return d <= orb;
}
function aspectMatch(a: number, b: number, angle: number, orb: number): boolean {
  let d = Math.abs(a - b) % 360;
  if (d > 180) d = 360 - d;
  return Math.abs(d - angle) <= orb;
}

function findPatterns(planets: Planet[], isEn: boolean): Pattern[] {
  const patterns: Pattern[] = [];
  const n = planets.length;

  // Grand Trine: 3 planets each ~120° apart
  for (let i = 0; i < n; i++) {
    for (let j = i + 1; j < n; j++) {
      for (let k = j + 1; k < n; k++) {
        if (aspectMatch(planets[i].longitude, planets[j].longitude, 120, 8) &&
            aspectMatch(planets[j].longitude, planets[k].longitude, 120, 8) &&
            aspectMatch(planets[i].longitude, planets[k].longitude, 120, 8)) {
          patterns.push({
            type: "grand-trine", typeEn: "Grand Trine", typeTr: "Büyük Üçgen", emoji: "△",
            planets: [planets[i], planets[j], planets[k]].map(p => `${p.symbol} ${p.name}`),
            desc_en: "A harmonious triangle of flow and natural talent. Gifts that come easily — but can lead to complacency if not actively engaged.",
            desc_tr: "Uyumlu bir akış ve doğal yetenek üçgeni. Kolay gelen yetenekler — ama aktif kullanılmazsa rehavete yol açabilir.",
          });
        }
      }
    }
  }

  // T-Square: 2 planets in opposition, both square a third
  for (let i = 0; i < n; i++) {
    for (let j = i + 1; j < n; j++) {
      if (aspectMatch(planets[i].longitude, planets[j].longitude, 180, 8)) {
        for (let k = 0; k < n; k++) {
          if (k !== i && k !== j &&
              aspectMatch(planets[i].longitude, planets[k].longitude, 90, 8) &&
              aspectMatch(planets[j].longitude, planets[k].longitude, 90, 8)) {
            patterns.push({
              type: "t-square", typeEn: "T-Square", typeTr: "T-Kare", emoji: "⊤",
              planets: [planets[i], planets[j], planets[k]].map(p => `${p.symbol} ${p.name}`),
              desc_en: "Dynamic tension that drives action. The focal planet (apex) is where the energy seeks resolution — a lifelong growth engine.",
              desc_tr: "Harekete geçiren dinamik gerilim. Odak gezegen (tepe) enerjinin çözüm aradığı yer — ömür boyu büyüme motoru.",
            });
          }
        }
      }
    }
  }

  // Yod: 2 planets sextile (60°), both quincunx (150°) a third
  for (let i = 0; i < n; i++) {
    for (let j = i + 1; j < n; j++) {
      if (aspectMatch(planets[i].longitude, planets[j].longitude, 60, 5)) {
        for (let k = 0; k < n; k++) {
          if (k !== i && k !== j &&
              aspectMatch(planets[i].longitude, planets[k].longitude, 150, 4) &&
              aspectMatch(planets[j].longitude, planets[k].longitude, 150, 4)) {
            patterns.push({
              type: "yod", typeEn: "Yod (Finger of God)", typeTr: "Yod (Tanrının Parmağı)", emoji: "☝️",
              planets: [planets[i], planets[j], planets[k]].map(p => `${p.symbol} ${p.name}`),
              desc_en: "A fated configuration pointing to a special mission. The apex planet carries an urgent, almost compulsive calling.",
              desc_tr: "Özel bir misyona işaret eden kadersel bir konfigürasyon. Tepe gezegen acil, neredeyse zorlayıcı bir çağrı taşır.",
            });
          }
        }
      }
    }
  }

  // Stellium: 3+ planets within same sign (30° span)
  const signGroups: Record<number, Planet[]> = {};
  planets.forEach(p => {
    const si = Math.floor(p.longitude / 30);
    (signGroups[si] = signGroups[si] || []).push(p);
  });
  Object.values(signGroups).forEach(group => {
    if (group.length >= 3) {
      patterns.push({
        type: "stellium", typeEn: "Stellium", typeTr: "Stellium", emoji: "✦",
        planets: group.map(p => `${p.symbol} ${p.name}`),
        desc_en: `${group.length} planets concentrated in one sign — an intense focus of energy. This area of life demands attention and expression.`,
        desc_tr: `${group.length} gezegen tek burçta yoğunlaşmış — yoğun enerji odağı. Bu yaşam alanı dikkat ve ifade talep eder.`,
      });
    }
  });

  // Deduplicate
  const seen = new Set<string>();
  return patterns.filter(p => {
    const key = p.type + p.planets.sort().join(',');
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

export default function AspectPatternsClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [patterns, setPatterns] = useState<Pattern[] | null>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/chart?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setPatterns(findPatterns(data.planets || [], isEn));
    } catch {} finally { setLoading(false); }
  }, [locale, isEn]);

  useEffect(() => { if (saved && !patterns) calc(saved); /* eslint-disable-next-line */ }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calc} submitLabel={isEn ? "Find Patterns" : "Kalıpları Bul"} />
      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Analyzing..." : "Analiz ediliyor..."}</div>}
      {patterns !== null && (
        <div className="max-w-lg mx-auto space-y-4 animate-in fade-in">
          {patterns.length === 0 && (
            <div className="cosmic-card text-center">
              <div className="text-3xl mb-2">🔍</div>
              <p className="text-cosmic-muted">{isEn ? "No major aspect patterns found. This is common — most charts don't have all patterns." : "Büyük açı kalıbı bulunamadı. Bu normaldir — çoğu haritada tüm kalıplar yoktur."}</p>
            </div>
          )}
          {patterns.map((p, i) => (
            <div key={i} className="cosmic-card">
              <div className="flex items-center gap-3 mb-3">
                <span className="text-2xl">{p.emoji}</span>
                <div>
                  <h3 className="font-display text-white">{isEn ? p.typeEn : p.typeTr}</h3>
                  <div className="text-xs text-cosmic-muted">{p.planets.join(' · ')}</div>
                </div>
              </div>
              <p className="text-sm text-cosmic-text/80 leading-relaxed">{isEn ? p.desc_en : p.desc_tr}</p>
            </div>
          ))}
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Swiss Ephemeris precision. Patterns are geometric signatures, not predictions." : "Swiss Ephemeris hassasiyeti. Kalıplar geometrik imzalardır, tahmin değildir."}</p>
    </div>
  );
}
