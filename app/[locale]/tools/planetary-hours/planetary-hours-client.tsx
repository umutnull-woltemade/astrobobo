"use client";
import { useMemo } from "react";

// Chaldean order: Saturn, Jupiter, Mars, Sun, Venus, Mercury, Moon
const CHALDEAN = [
  { en: "Saturn",  tr: "Satürn",  symbol: "♄", color: "#8D6E63", theme_en: "Discipline, limits, patience",     theme_tr: "Disiplin, sınırlar, sabır" },
  { en: "Jupiter", tr: "Jüpiter", symbol: "♃", color: "#FFA726", theme_en: "Expansion, luck, abundance",       theme_tr: "Genişleme, şans, bolluk" },
  { en: "Mars",    tr: "Mars",    symbol: "♂", color: "#FF6B6B", theme_en: "Action, courage, energy",           theme_tr: "Aksiyon, cesaret, enerji" },
  { en: "Sun",     tr: "Güneş",   symbol: "☉", color: "#FFD93D", theme_en: "Vitality, leadership, visibility", theme_tr: "Canlılık, liderlik, görünürlük" },
  { en: "Venus",   tr: "Venüs",   symbol: "♀", color: "#F06292", theme_en: "Love, beauty, harmony",            theme_tr: "Aşk, güzellik, uyum" },
  { en: "Mercury", tr: "Merkür",  symbol: "☿", color: "#42A5F5", theme_en: "Communication, trade, travel",     theme_tr: "İletişim, ticaret, yolculuk" },
  { en: "Moon",    tr: "Ay",      symbol: "☽", color: "#B0BEC5", theme_en: "Intuition, emotions, dreams",      theme_tr: "Sezgi, duygular, rüyalar" },
];

// Day rulers: Sun=0, Mon=1, ..., Sat=6 → index into Chaldean
const DAY_RULER_INDEX = [3, 6, 2, 5, 1, 4, 0]; // Sun, Moon, Mars, Mercury, Jupiter, Venus, Saturn

function getSunTimes() {
  // Approximate sunrise/sunset for Istanbul-ish latitude
  const now = new Date();
  const month = now.getMonth();
  // Hours of daylight roughly by month (Istanbul ~41°N)
  const daylight = [9.5, 10.5, 12, 13.3, 14.5, 15, 14.8, 14, 12.5, 11, 10, 9.3];
  const dh = daylight[month];
  const sunrise = 12 - dh / 2;
  const sunset = 12 + dh / 2;
  return { sunrise, sunset, dayHourLen: dh / 12, nightHourLen: (24 - dh) / 12 };
}

export default function PlanetaryHoursClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";

  const { hours, currentIndex } = useMemo(() => {
    const now = new Date();
    const dow = now.getDay();
    const { sunrise, dayHourLen, nightHourLen, sunset } = getSunTimes();
    const dayRuler = DAY_RULER_INDEX[dow];

    const hrs: { planet: typeof CHALDEAN[0]; start: string; end: string; isDay: boolean }[] = [];
    let chIdx = dayRuler;

    // 12 day hours
    for (let i = 0; i < 12; i++) {
      const startH = sunrise + i * dayHourLen;
      const endH = startH + dayHourLen;
      hrs.push({
        planet: CHALDEAN[chIdx % 7],
        start: fmtTime(startH),
        end: fmtTime(endH),
        isDay: true,
      });
      chIdx++;
    }
    // 12 night hours
    for (let i = 0; i < 12; i++) {
      const startH = sunset + i * nightHourLen;
      const endH = startH + nightHourLen;
      hrs.push({
        planet: CHALDEAN[chIdx % 7],
        start: fmtTime(startH),
        end: fmtTime(endH),
        isDay: false,
      });
      chIdx++;
    }

    // Find current hour
    const currentH = now.getHours() + now.getMinutes() / 60;
    let ci = -1;
    for (let i = 0; i < 24; i++) {
      const s = i < 12 ? sunrise + i * dayHourLen : sunset + (i - 12) * nightHourLen;
      const len = i < 12 ? dayHourLen : nightHourLen;
      if (currentH >= s && currentH < s + len) { ci = i; break; }
    }

    return { hours: hrs, currentIndex: ci };
  }, []);

  const current = currentIndex >= 0 ? hours[currentIndex] : null;

  return (
    <div className="space-y-6 max-w-lg mx-auto">
      {current && (
        <div className="cosmic-card text-center" style={{ borderColor: `${current.planet.color}40` }}>
          <div className="text-xs uppercase tracking-wider text-cosmic-muted">{isEn ? "Current Planetary Hour" : "Şu Anki Gezegen Saati"}</div>
          <div className="text-5xl mt-2" style={{ color: current.planet.color }}>{current.planet.symbol}</div>
          <div className="text-2xl font-display text-cosmic-accent mt-1">{isEn ? current.planet.en : current.planet.tr}</div>
          <div className="text-sm text-cosmic-muted mt-1">{current.start} – {current.end}</div>
          <div className="text-xs text-cosmic-text/70 mt-2">{isEn ? current.planet.theme_en : current.planet.theme_tr}</div>
        </div>
      )}

      <div className="cosmic-card">
        <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">{isEn ? "Today's 24 Hours" : "Bugünün 24 Saati"}</h3>
        <div className="space-y-1">
          {hours.map((h, i) => (
            <div key={i} className={`flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm ${i === currentIndex ? 'bg-white/[0.08] border border-white/[0.15]' : ''}`}>
              <span style={{ color: h.planet.color }}>{h.planet.symbol}</span>
              <span className="text-xs text-cosmic-muted w-24">{h.start} – {h.end}</span>
              <span className={`flex-1 ${i === currentIndex ? 'text-white font-semibold' : 'text-cosmic-muted'}`}>{isEn ? h.planet.en : h.planet.tr}</span>
              <span className="text-[10px] text-cosmic-muted">{h.isDay ? (isEn ? 'day' : 'gün') : (isEn ? 'night' : 'gece')}</span>
            </div>
          ))}
        </div>
      </div>
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Chaldean planetary hours. Sunrise/sunset approximated for ~41°N latitude." : "Keldani gezegen saatleri. Gündoğumu/batımı ~41°K enlemi için yaklaşık."}</p>
    </div>
  );
}

function fmtTime(h: number): string {
  const hh = Math.floor(h) % 24;
  const mm = Math.round((h - Math.floor(h)) * 60);
  return `${String(hh).padStart(2, '0')}:${String(mm).padStart(2, '0')}`;
}
