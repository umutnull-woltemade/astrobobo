"use client";
import { useEffect, useState } from "react";
import { useBirthData, birthDataQuery } from "@/lib/birth-data/store";

const MOON_PHASES = [
  { emoji: "🌑", en: "New Moon", tr: "Yeni Ay", energy_en: "Plant seeds of intention. A time for fresh starts, quiet planning, and setting goals.", energy_tr: "Niyet tohumları ek. Taze başlangıçlar, sessiz planlama ve hedef belirleme zamanı.", ritual_en: "Write down 3 intentions for this cycle. Light a candle and visualize.", ritual_tr: "Bu döngü için 3 niyet yaz. Bir mum yak ve görselleştir." },
  { emoji: "🌒", en: "Waxing Crescent", tr: "Hilal (Büyüyen)", energy_en: "Momentum builds. Take the first small steps toward your intentions.", energy_tr: "Momentum artıyor. Niyetlerine doğru ilk küçük adımları at.", ritual_en: "Create a simple action plan. Start one small habit today.", ritual_tr: "Basit bir eylem planı oluştur. Bugün küçük bir alışkanlığa başla." },
  { emoji: "🌓", en: "First Quarter", tr: "İlk Dördün", energy_en: "Decision time. Challenges test your commitment. Push through resistance.", energy_tr: "Karar zamanı. Zorluklar bağlılığını test eder. Dirence karşı ilerle.", ritual_en: "Identify one obstacle and create a plan to overcome it.", ritual_tr: "Bir engeli belirle ve onu aşmak için plan yap." },
  { emoji: "🌔", en: "Waxing Gibbous", tr: "Şişkin Ay (Büyüyen)", energy_en: "Refine and adjust. Your efforts are taking shape — fine-tune the details.", energy_tr: "İncele ve ayarla. Çabaların şekilleniyor — detayları ince ayar yap.", ritual_en: "Review your progress. What needs adjustment?", ritual_tr: "İlerlemenizi gözden geçir. Neyin ayarlanması gerekiyor?" },
  { emoji: "🌕", en: "Full Moon", tr: "Dolunay", energy_en: "Culmination and illumination. Emotions peak. Celebrate what you've manifested.", energy_tr: "Doruk ve aydınlanma. Duygular zirveye ulaşır. Tezahür ettirdiklerini kutla.", ritual_en: "Express gratitude. Release what no longer serves you. Moon bathe.", ritual_tr: "Şükranını ifade et. Artık sana hizmet etmeyeni bırak." },
  { emoji: "🌖", en: "Waning Gibbous", tr: "Şişkin Ay (Küçülen)", energy_en: "Gratitude and sharing. Share your wisdom with others.", energy_tr: "Şükran ve paylaşım. Bilgeliğini başkalarıyla paylaş.", ritual_en: "Teach someone something. Write a gratitude list.", ritual_tr: "Birine bir şey öğret. Bir şükran listesi yaz." },
  { emoji: "🌗", en: "Last Quarter", tr: "Son Dördün", energy_en: "Release and forgive. Let go of old patterns and beliefs.", energy_tr: "Bırakma ve affetme. Eski kalıpları ve inançları bırak.", ritual_en: "Write what you're releasing on paper. Tear it up or burn it safely.", ritual_tr: "Bıraktıklarını kağıda yaz. Yırt veya güvenle yak." },
  { emoji: "🌘", en: "Waning Crescent", tr: "Hilal (Küçülen)", energy_en: "Rest and reflect. The cycle nears completion. Recharge before the next new moon.", energy_tr: "Dinlen ve düşün. Döngü tamamlanmaya yaklaşıyor. Yeni aydan önce şarj ol.", ritual_en: "Meditate. Take a long bath. Sleep early. Dream.", ritual_tr: "Meditasyon yap. Uzun bir banyo al. Erken uyu. Rüya gör." },
];

function getMoonPhase(): number {
  const now = new Date();
  // Synodic month ≈ 29.53059 days. Reference new moon: Jan 6, 2000 18:14 UTC
  const ref = new Date(2000, 0, 6, 18, 14, 0).getTime();
  const diff = now.getTime() - ref;
  const synodicMonth = 29.53059 * 24 * 60 * 60 * 1000;
  const phase = ((diff % synodicMonth) / synodicMonth) * 8;
  return Math.floor(phase) % 8;
}

function getIllumination(): number {
  const now = new Date();
  const ref = new Date(2000, 0, 6, 18, 14, 0).getTime();
  const diff = now.getTime() - ref;
  const synodicMonth = 29.53059 * 24 * 60 * 60 * 1000;
  const normalized = (diff % synodicMonth) / synodicMonth;
  // Illumination: 0 at new moon, 1 at full moon, 0 at next new moon
  return Math.round(Math.abs(Math.cos(normalized * Math.PI * 2 - Math.PI)) * 100);
}

export default function MoonPhaseClient({ locale }: { locale: "en" | "tr" }) {
  const phaseIndex = getMoonPhase();
  const phase = MOON_PHASES[phaseIndex];
  const illumination = getIllumination();
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [natalMoon, setNatalMoon] = useState<{ name: string; symbol: string; degree: number } | null>(null);

  useEffect(() => {
    if (!saved) { setNatalMoon(null); return; }
    fetch(`/api/chart?${birthDataQuery(saved, locale)}`)
      .then(r => r.json())
      .then(d => setNatalMoon(d.summary?.moonSign || null))
      .catch(() => {});
  }, [saved, locale]);

  return (
    <div className="flex flex-col items-center gap-8">
      {/* Moon Display */}
      <div className="text-center">
        <div
          className="text-9xl mb-6 mx-auto"
          style={{ filter: "drop-shadow(0 0 40px rgba(167, 139, 250, 0.4))" }}
        >
          {phase.emoji}
        </div>
        <h2 className="text-3xl font-display text-white mb-2">
          {isEn ? phase.en : phase.tr}
        </h2>
        <div className="text-sm text-purple-400">
          {illumination}% {isEn ? "illuminated" : "aydınlanmış"}
        </div>
      </div>

      {natalMoon && (
        <div className="cosmic-card max-w-lg w-full bg-gradient-to-r from-indigo-900/30 to-purple-900/30 border-indigo-500/30 text-center">
          <div className="text-xs uppercase tracking-wider text-cosmic-muted mb-1">{isEn ? "Your Natal Moon" : "Doğum Ay'ın"}</div>
          <div className="text-2xl">{natalMoon.symbol} <span className="font-display text-white">{natalMoon.name}</span> <span className="text-sm text-cosmic-muted">{natalMoon.degree.toFixed(1)}°</span></div>
        </div>
      )}

      {/* Energy */}
      <div className="cosmic-card max-w-lg w-full">
        <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">
          {isEn ? "Lunar Energy" : "Ay Enerjisi"}
        </h3>
        <p className="text-cosmic-text/80 leading-relaxed">
          {isEn ? phase.energy_en : phase.energy_tr}
        </p>
      </div>

      {/* Ritual */}
      <div className="cosmic-card max-w-lg w-full bg-gradient-to-r from-purple-900/20 to-cyan-900/20 border-purple-500/20">
        <h3 className="text-sm uppercase tracking-widest text-cosmic-accent mb-3">
          {isEn ? "Suggested Ritual" : "Önerilen Ritüel"}
        </h3>
        <p className="text-cosmic-text/80 leading-relaxed">
          {isEn ? phase.ritual_en : phase.ritual_tr}
        </p>
      </div>

      {/* All Phases */}
      <div className="w-full max-w-lg">
        <h3 className="text-sm uppercase tracking-widest text-cosmic-muted mb-4">
          {isEn ? "Full Lunar Cycle" : "Tam Ay Döngüsü"}
        </h3>
        <div className="grid grid-cols-4 gap-2">
          {MOON_PHASES.map((p, i) => (
            <div
              key={p.en}
              className={`text-center p-3 rounded-xl transition-all ${
                i === phaseIndex
                  ? "bg-purple-500/20 border border-purple-500/40 scale-105"
                  : "bg-white/[0.03] border border-white/[0.06] opacity-60"
              }`}
            >
              <div className="text-2xl mb-1">{p.emoji}</div>
              <div className="text-[10px] text-cosmic-muted leading-tight">
                {isEn ? p.en : p.tr}
              </div>
            </div>
          ))}
        </div>
      </div>

      <p className="text-xs text-cosmic-muted text-center max-w-md">
        {isEn
          ? "Calculated from synodic month cycle. For personal moon sign, consult your birth chart."
          : "Sinodik ay döngüsünden hesaplanır. Kişisel ay burcu için doğum haritanıza başvurun."}
      </p>
    </div>
  );
}
