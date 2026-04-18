"use client";
import { useMemo, useState } from "react";

const ZODIAC = [
  { sign: "Aries", tr: "Koç", crystals: ["Carnelian", "Bloodstone", "Red Jasper"] },
  { sign: "Taurus", tr: "Boğa", crystals: ["Rose Quartz", "Emerald", "Malachite"] },
  { sign: "Gemini", tr: "İkizler", crystals: ["Citrine", "Agate", "Tiger's Eye"] },
  { sign: "Cancer", tr: "Yengeç", crystals: ["Moonstone", "Pearl", "Selenite"] },
  { sign: "Leo", tr: "Aslan", crystals: ["Sunstone", "Pyrite", "Amber"] },
  { sign: "Virgo", tr: "Başak", crystals: ["Amazonite", "Moss Agate", "Peridot"] },
  { sign: "Libra", tr: "Terazi", crystals: ["Lapis Lazuli", "Opal", "Jade"] },
  { sign: "Scorpio", tr: "Akrep", crystals: ["Obsidian", "Labradorite", "Malachite"] },
  { sign: "Sagittarius", tr: "Yay", crystals: ["Turquoise", "Sodalite", "Amethyst"] },
  { sign: "Capricorn", tr: "Oğlak", crystals: ["Garnet", "Onyx", "Smoky Quartz"] },
  { sign: "Aquarius", tr: "Kova", crystals: ["Aquamarine", "Amethyst", "Fluorite"] },
  { sign: "Pisces", tr: "Balık", crystals: ["Aquamarine", "Amethyst", "Moonstone"] },
];

const INTENTIONS: Record<string, { en: string; tr: string; crystals: string[] }> = {
  love:    { en: "Love",    tr: "Aşk",    crystals: ["Rose Quartz", "Rhodonite", "Pink Tourmaline"] },
  calm:    { en: "Calm",    tr: "Sükunet",crystals: ["Amethyst", "Lepidolite", "Blue Lace Agate"] },
  focus:   { en: "Focus",   tr: "Odak",   crystals: ["Fluorite", "Tiger's Eye", "Clear Quartz"] },
  courage: { en: "Courage", tr: "Cesaret",crystals: ["Carnelian", "Bloodstone", "Garnet"] },
  wealth:  { en: "Wealth",  tr: "Bolluk", crystals: ["Citrine", "Pyrite", "Green Aventurine"] },
  protect: { en: "Protect", tr: "Koruma", crystals: ["Black Tourmaline", "Obsidian", "Hematite"] },
};

export default function CrystalGuideClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const [sign, setSign] = useState("Taurus");
  const [intent, setIntent] = useState<keyof typeof INTENTIONS>("calm");

  const z = useMemo(() => ZODIAC.find(s => s.sign === sign)!, [sign]);
  const i = INTENTIONS[intent];
  const combined = useMemo(() => {
    const set = new Set<string>([...z.crystals, ...i.crystals]);
    return Array.from(set);
  }, [z, i]);

  return (
    <div className="space-y-6 max-w-xl mx-auto">
      <div className="grid grid-cols-2 gap-3">
        <div className="cosmic-card">
          <label className="block text-xs text-cosmic-muted mb-2 uppercase tracking-wider">{isEn ? "Zodiac Sign" : "Burç"}</label>
          <select value={sign} onChange={e => setSign(e.target.value)}
            className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white text-sm focus:border-teal-500 focus:outline-none">
            {ZODIAC.map(s => <option key={s.sign} value={s.sign} className="bg-slate-900">{isEn ? s.sign : s.tr}</option>)}
          </select>
        </div>
        <div className="cosmic-card">
          <label className="block text-xs text-cosmic-muted mb-2 uppercase tracking-wider">{isEn ? "Intention" : "Niyet"}</label>
          <select value={intent} onChange={e => setIntent(e.target.value as any)}
            className="w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white text-sm focus:border-teal-500 focus:outline-none">
            {Object.entries(INTENTIONS).map(([k, v]) => <option key={k} value={k} className="bg-slate-900">{isEn ? v.en : v.tr}</option>)}
          </select>
        </div>
      </div>

      <div className="cosmic-card bg-gradient-to-r from-teal-900/20 to-purple-900/20 border-teal-500/20">
        <div className="text-xs uppercase tracking-wider text-cosmic-muted text-center mb-3">
          {isEn ? "Your Stones" : "Senin Taşların"}
        </div>
        <div className="grid grid-cols-2 gap-2">
          {combined.map(c => (
            <div key={c} className="px-4 py-3 rounded-xl bg-white/[0.04] border border-white/[0.08] text-center text-sm">
              💎 {c}
            </div>
          ))}
        </div>
      </div>
      <p className="text-xs text-cosmic-muted text-center">
        {isEn ? "Crystal meanings are traditional symbolism. Not medical advice." : "Kristal anlamları geleneksel sembolizmdir. Tıbbi tavsiye değildir."}
      </p>
    </div>
  );
}
