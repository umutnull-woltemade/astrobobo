"use client";
import { useEffect, useState } from "react";
import { useBirthData } from "@/lib/birth-data/store";

const ANIMALS = [
  { emoji: "🐀", en: "Rat", tr: "Sıçan", trait_en: "Quick-witted, resourceful, adaptable", trait_tr: "Hazırcevap, becerikli, uyumlu", element: "Water" },
  { emoji: "🐂", en: "Ox", tr: "Öküz", trait_en: "Diligent, dependable, strong", trait_tr: "Çalışkan, güvenilir, güçlü", element: "Earth" },
  { emoji: "🐅", en: "Tiger", tr: "Kaplan", trait_en: "Brave, competitive, confident", trait_tr: "Cesur, rekabetçi, özgüvenli", element: "Wood" },
  { emoji: "🐇", en: "Rabbit", tr: "Tavşan", trait_en: "Gentle, elegant, compassionate", trait_tr: "Nazik, zarif, şefkatli", element: "Wood" },
  { emoji: "🐉", en: "Dragon", tr: "Ejderha", trait_en: "Confident, ambitious, charismatic", trait_tr: "Özgüvenli, hırslı, karizmatik", element: "Earth" },
  { emoji: "🐍", en: "Snake", tr: "Yılan", trait_en: "Wise, intuitive, enigmatic", trait_tr: "Bilge, sezgisel, esrarengiz", element: "Fire" },
  { emoji: "🐴", en: "Horse", tr: "At", trait_en: "Energetic, free-spirited, cheerful", trait_tr: "Enerjik, özgür ruhlu, neşeli", element: "Fire" },
  { emoji: "🐑", en: "Goat", tr: "Keçi", trait_en: "Calm, gentle, creative", trait_tr: "Sakin, nazik, yaratıcı", element: "Earth" },
  { emoji: "🐵", en: "Monkey", tr: "Maymun", trait_en: "Clever, curious, playful", trait_tr: "Zeki, meraklı, oyuncu", element: "Metal" },
  { emoji: "🐔", en: "Rooster", tr: "Horoz", trait_en: "Observant, hardworking, courageous", trait_tr: "Gözlemci, çalışkan, cesur", element: "Metal" },
  { emoji: "🐕", en: "Dog", tr: "Köpek", trait_en: "Loyal, honest, kind", trait_tr: "Sadık, dürüst, kibar", element: "Earth" },
  { emoji: "🐖", en: "Pig", tr: "Domuz", trait_en: "Generous, compassionate, diligent", trait_tr: "Cömert, şefkatli, çalışkan", element: "Water" },
];

function getAnimal(year: number) { return ANIMALS[(year - 4) % 12]; }
function getYinYang(year: number) { return year % 2 === 0 ? 'Yang' : 'Yin'; }

export default function ChineseZodiacClient({ locale }: { locale: "en" | "tr" }) {
  const { data: saved } = useBirthData();
  const [year, setYear] = useState(saved?.date ? saved.date.split("-")[0] : "");
  useEffect(() => { if (saved?.date && !year) setYear(saved.date.split("-")[0]); /* eslint-disable-next-line */ }, [saved?.date]);
  const isEn = locale === "en";
  const animal = year ? getAnimal(parseInt(year)) : null;
  const yinYang = year ? getYinYang(parseInt(year)) : null;

  return (
    <div className="flex flex-col items-center gap-8">
      <div className="w-full max-w-xs">
        <input type="number" placeholder={isEn ? "Birth year (e.g. 1990)" : "Doğum yılı (ör. 1990)"}
          value={year} onChange={e => setYear(e.target.value)} min="1900" max="2100"
          className="w-full px-4 py-3 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white focus:border-red-500 focus:outline-none text-center text-lg" />
      </div>

      {animal && (
        <div className="text-center animate-in fade-in max-w-md">
          <div className="text-8xl mb-4">{animal.emoji}</div>
          <h2 className="text-3xl font-display text-white mb-1">{isEn ? animal.en : animal.tr}</h2>
          <div className="flex justify-center gap-3 text-xs text-cosmic-muted mb-4">
            <span className="px-2 py-1 rounded-full bg-white/[0.06] border border-white/[0.08]">{yinYang}</span>
            <span className="px-2 py-1 rounded-full bg-white/[0.06] border border-white/[0.08]">{animal.element}</span>
          </div>
          <p className="text-cosmic-text/80 leading-relaxed">{isEn ? animal.trait_en : animal.trait_tr}</p>

          <div className="mt-8 grid grid-cols-4 md:grid-cols-6 gap-2">
            {ANIMALS.map((a, i) => {
              const isSelected = a.en === animal.en;
              return (
                <div key={a.en} className={`p-2 rounded-xl text-center transition-all ${isSelected ? 'bg-red-500/20 border border-red-500/40 scale-110' : 'bg-white/[0.03] border border-white/[0.06] opacity-50'}`}>
                  <div className="text-xl">{a.emoji}</div>
                  <div className="text-[9px] text-cosmic-muted mt-1">{isEn ? a.en : a.tr}</div>
                </div>
              );
            })}
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Based on traditional Chinese zodiac cycle." : "Geleneksel Çin burç döngüsüne dayanır."}</p>
    </div>
  );
}
