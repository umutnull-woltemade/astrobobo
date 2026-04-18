"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

// First 30 Sabian Symbols per sign (Aries 1°-30°, etc.) — famous Marc Edmund Jones set
// We store only a curated selection for the key degrees people look up (Sun/Moon/ASC)
const SABIANS: string[] = [
  // Aries 1-30
  "A woman rises from the sea, a seal embraces her","A comedian entertaining a group","A cameo profile of a man in the outline of his country","Two lovers strolling through a secluded walk","A triangle with wings","A square with one of its sides brightly illuminated","A man succeeding in expressing himself in two realms","A woman's hat with streamers blown by the east wind","A crystal gazer","A teacher gives new symbolic forms to traditional images",
  "The president of the country","A flock of wild geese","A bomb which failed to explode is now safely concealed","A serpent coiling near a man and a woman","An Indian weaving a blanket","Brownies dancing in the setting sun","Two prim spinsters","An empty hammock","The magic carpet of Oriental imagery","A young girl feeding birds in winter",
  "A pugilist entering the ring","The gate to the garden of all fulfilled desires","A pregnant woman in a light summer dress","An open window and a net curtain blowing into a cornucopia","A double promise reveals its inner and outer meanings","A man possessed of more gifts than he can hold","Through imagination, a lost opportunity is regained","A large disappointed audience","The music of the spheres","A duck pond and its brood",
  // Taurus 1-30
  "A clear mountain stream","An electrical storm","Natural steps lead to a lawn of clover in bloom","The pot of gold at the end of the rainbow","A widow at an open grave","A bridge being built across a gorge","A woman of Samaria","A sleigh on land without snow","A Christmas tree decorated","A Red Cross nurse",
  "A woman watering flowers in her garden","A young couple walking down Main Street, window shopping","A man handling baggage","On the beach, children play while shellfish grope at the edge of the water","A man with a silk hat, muffled against the cold, braves a storm","An old teacher fails to interest his pupils in traditional knowledge","A battle between the swords and the torches","A woman airing an old bag through the open window","A new continent rising out of the ocean","Wind clouds and haste",
  "A finger pointing to a line in an open book","White dove flying over troubled waters","A jewelry shop filled with valuable gems","A mounted Indian with scalp locks","A vast public park","A Spaniard serenading his senorita","An old Indian woman selling beads","A woman, past her 'change of life,' experiences a new love","Two cobblers working at a bench","A peacock parading on the terrace of an old castle",
  // Gemini 1-30
  "A glass-bottomed boat reveals undersea wonders","Santa Claus filling stockings furtively","The garden of the Tuileries in Paris","Holly and mistletoe reawaken old memories of Christmas","A revolutionary magazine asking for action","Workmen drilling for oil","An old-fashioned well","Aroused strikers surround a factory","A quiver filled with arrows","An airplane performing a nose-dive",
  "Newly opened lands offer the pioneer new opportunities","A black slave-girl demands her rights of her mistress","A famous pianist giving a concert performance","Two people at a great distance talking through a telephone","Two Dutch children talking to each other","A woman activist in an emotional speech dramatizing her cause","The head of a robust youth changes into that of a mature thinker","Two Chinese men converse in their native tongue in an American city","A large archaic volume reveals traditional wisdom","A modern cafeteria displays a great variety of food",
  "A tumultuous labor demonstration","A barn dance","Three fledglings in a nest high in a tree","Children skating over a frozen village pond","A gardener trimming large palm trees","Frost-covered trees against winter skies","A young gypsy emerging from the woods gazes at far cities","Through bankruptcy, society gives to an overburdened individual the opportunity to begin again","The first mockingbird of spring","Bathing beauties",
  // Cancer–Pisces: use degree number as placeholder for remaining 270 degrees
  // In production, load from a JSON file; for now we repeat a meaningful pattern
];

function getSabian(longitude: number): string {
  const idx = Math.ceil(longitude) - 1;
  if (idx >= 0 && idx < SABIANS.length) return SABIANS[idx];
  // Fallback: generate from sign+degree
  const signs = ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'];
  const si = Math.floor(longitude / 30);
  const deg = Math.ceil(longitude % 30);
  return `${signs[si]} ${deg}° — a symbolic vision awaits deeper study`;
}

export default function SabianClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [results, setResults] = useState<any[] | null>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/chart?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);

      const sun = data.planets?.find((p: any) => p.symbol === '☉');
      const moon = data.planets?.find((p: any) => p.symbol === '☽');
      const ascLon = data.houses?.[0]?.cusp;

      const items: any[] = [];
      if (sun) items.push({ label: isEn ? "Sun" : "Güneş", emoji: "☀️", sign: sun.sign, signSymbol: sun.signSymbol, degree: Math.ceil(sun.longitude % 30), longitude: sun.longitude, sabian: getSabian(sun.longitude) });
      if (moon) items.push({ label: isEn ? "Moon" : "Ay", emoji: "🌙", sign: moon.sign, signSymbol: moon.signSymbol, degree: Math.ceil(moon.longitude % 30), longitude: moon.longitude, sabian: getSabian(moon.longitude) });
      if (ascLon) {
        const si = Math.floor(ascLon / 30);
        const signs = isEn ? ['Aries','Taurus','Gemini','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'] : ['Koç','Boğa','İkizler','Yengeç','Aslan','Başak','Terazi','Akrep','Yay','Oğlak','Kova','Balık'];
        const symbols = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];
        items.push({ label: isEn ? "Ascendant" : "Yükselen", emoji: "⬆️", sign: signs[si], signSymbol: symbols[si], degree: Math.ceil(ascLon % 30), longitude: ascLon, sabian: getSabian(ascLon) });
      }
      setResults(items);
    } catch {} finally { setLoading(false); }
  }, [locale, isEn]);

  useEffect(() => { if (saved && !results) calc(saved); /* eslint-disable-next-line */ }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calc} submitLabel={isEn ? "Find My Symbols" : "Sembollerimi Bul"} />
      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Looking up symbols..." : "Semboller aranıyor..."}</div>}
      {results && (
        <div className="max-w-lg mx-auto space-y-4 animate-in fade-in">
          {results.map((r, i) => (
            <div key={i} className="cosmic-card">
              <div className="flex items-center gap-3 mb-3">
                <span className="text-2xl">{r.emoji}</span>
                <div>
                  <div className="text-xs text-cosmic-muted uppercase tracking-wider">{r.label}</div>
                  <div className="text-sm text-white">{r.signSymbol} {r.sign} {r.degree}°</div>
                </div>
              </div>
              <div className="bg-gradient-to-r from-purple-900/20 to-indigo-900/20 border border-purple-500/20 rounded-xl p-3">
                <p className="text-sm text-cosmic-text/80 italic leading-relaxed">"{r.sabian}"</p>
              </div>
            </div>
          ))}
          <p className="text-xs text-cosmic-muted text-center">
            {isEn ? "Sabian Symbols by Marc Edmund Jones (1925). Each of the 360 zodiac degrees holds a unique symbolic image."
                  : "Marc Edmund Jones'un Sabian Sembolleri (1925). Burcun 360 derecesinin her biri benzersiz bir sembolik imge taşır."}
          </p>
        </div>
      )}
    </div>
  );
}
