"use client";
import { useMemo, useState, useEffect } from "react";
import { useBirthData } from "@/lib/birth-data/store";

const HOUSE_RULERS = [
  { house: 1, ruler: "♂", en: "Mars", tr: "Mars", theme_en: "Identity, body, self-image", theme_tr: "Kimlik, beden, benlik imajı" },
  { house: 2, ruler: "♀", en: "Venus", tr: "Venüs", theme_en: "Money, values, self-worth", theme_tr: "Para, değerler, öz değer" },
  { house: 3, ruler: "☿", en: "Mercury", tr: "Merkür", theme_en: "Communication, siblings, local travel", theme_tr: "İletişim, kardeşler, kısa yolculuklar" },
  { house: 4, ruler: "☽", en: "Moon", tr: "Ay", theme_en: "Home, family, roots, emotional foundation", theme_tr: "Ev, aile, kökler, duygusal temel" },
  { house: 5, ruler: "☉", en: "Sun", tr: "Güneş", theme_en: "Creativity, romance, children, joy", theme_tr: "Yaratıcılık, romantizm, çocuklar, neşe" },
  { house: 6, ruler: "☿", en: "Mercury", tr: "Merkür", theme_en: "Health, daily routine, service, pets", theme_tr: "Sağlık, günlük rutin, hizmet, evcil hayvanlar" },
  { house: 7, ruler: "♀", en: "Venus", tr: "Venüs", theme_en: "Partnerships, marriage, contracts", theme_tr: "Ortaklıklar, evlilik, sözleşmeler" },
  { house: 8, ruler: "♂", en: "Mars/Pluto", tr: "Mars/Plüton", theme_en: "Transformation, shared resources, death/rebirth", theme_tr: "Dönüşüm, paylaşılan kaynaklar, ölüm/yeniden doğuş" },
  { house: 9, ruler: "♃", en: "Jupiter", tr: "Jüpiter", theme_en: "Higher education, travel, philosophy, beliefs", theme_tr: "Yüksek eğitim, seyahat, felsefe, inançlar" },
  { house: 10, ruler: "♄", en: "Saturn", tr: "Satürn", theme_en: "Career, reputation, public image, authority", theme_tr: "Kariyer, itibar, kamu imajı, otorite" },
  { house: 11, ruler: "♄", en: "Saturn/Uranus", tr: "Satürn/Uranüs", theme_en: "Friends, community, hopes, group projects", theme_tr: "Arkadaşlar, topluluk, umutlar, grup projeleri" },
  { house: 12, ruler: "♃", en: "Jupiter/Neptune", tr: "Jüpiter/Neptün", theme_en: "Solitude, spirituality, hidden matters, endings", theme_tr: "Yalnızlık, maneviyat, gizli meseleler, bitişler" },
];

function yearsSince(date: string): number {
  const [y, m, d] = date.split('-').map(Number);
  const now = new Date();
  let age = now.getFullYear() - y;
  if (now.getMonth() + 1 < m || (now.getMonth() + 1 === m && now.getDate() < d)) age--;
  return Math.max(0, age);
}

export default function ProfectionClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [date, setDate] = useState(saved?.date || "");

  useEffect(() => { if (saved?.date && !date) setDate(saved.date); /* eslint-disable-next-line */ }, [saved?.date]);

  const info = useMemo(() => {
    if (!date) return null;
    const age = yearsSince(date);
    const houseIndex = age % 12;
    const house = HOUSE_RULERS[houseIndex];
    const wheel = HOUSE_RULERS.map((h, i) => ({ ...h, active: i === houseIndex, age: i }));
    return { age, house, wheel };
  }, [date]);

  return (
    <div className="space-y-6 max-w-lg mx-auto">
      {!saved && (
        <div className="cosmic-card max-w-sm mx-auto">
          <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">{isEn ? "Birth Date" : "Doğum Tarihi"}</label>
          <input type="date" value={date} onChange={(e) => setDate(e.target.value)}
            className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-purple-500 focus:outline-none text-sm"
            max={new Date().toISOString().split("T")[0]} />
        </div>
      )}

      {info && (
        <div className="animate-in fade-in space-y-4">
          <div className="cosmic-card text-center">
            <div className="text-xs uppercase tracking-wider text-cosmic-muted">{isEn ? `Age ${info.age} — Profection Year` : `${info.age} Yaş — Profeksiyon Yılı`}</div>
            <div className="text-5xl font-display text-cosmic-accent mt-2">{info.house.house}</div>
            <div className="text-sm text-cosmic-muted mt-1">{isEn ? `${info.house.house}${ordinal(info.house.house)} House` : `${info.house.house}. Ev`}</div>
            <div className="text-2xl mt-2">{info.house.ruler}</div>
            <div className="text-sm text-cosmic-accent">{isEn ? info.house.en : info.house.tr}</div>
          </div>

          <div className="cosmic-card bg-gradient-to-r from-purple-900/20 to-indigo-900/20 border-purple-500/20">
            <div className="text-xs uppercase tracking-wider text-cosmic-muted mb-2">{isEn ? "Year Theme" : "Yıl Teması"}</div>
            <p className="text-sm text-cosmic-text/80">{isEn ? info.house.theme_en : info.house.theme_tr}</p>
          </div>

          <div className="cosmic-card">
            <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">{isEn ? "12-Year Cycle" : "12 Yıllık Döngü"}</h3>
            <div className="grid grid-cols-4 gap-2">
              {info.wheel.map((h) => (
                <div key={h.house} className={`text-center p-2 rounded-lg ${h.active ? 'bg-purple-500/20 border-2 border-purple-500/50 scale-105' : 'bg-white/[0.03] border border-white/[0.06]'}`}>
                  <div className={`text-lg font-display ${h.active ? 'text-cosmic-accent' : 'text-cosmic-muted'}`}>{h.house}</div>
                  <div className="text-[10px] text-cosmic-muted">{info.age - (info.age % 12) + h.age}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Annual profections — a traditional Hellenistic timing technique." : "Yıllık profeksiyonlar — geleneksel Helenistik zamanlama tekniği."}</p>
    </div>
  );
}

function ordinal(n: number): string {
  if (n % 100 >= 11 && n % 100 <= 13) return 'th';
  switch (n % 10) { case 1: return 'st'; case 2: return 'nd'; case 3: return 'rd'; default: return 'th'; }
}
