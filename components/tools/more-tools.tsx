/**
 * "More Tools" cross-link component — shown at the bottom of every tool page.
 * Displays 4 random other tools (excluding current) to encourage exploration.
 */

const ALL_TOOLS = [
  { slug: "tarot", icon: "🃏", en: "Tarot", tr: "Tarot" },
  { slug: "numerology", icon: "🔢", en: "Numerology", tr: "Numeroloji" },
  { slug: "birth-chart", icon: "🌐", en: "Birth Chart", tr: "Doğum Haritası" },
  { slug: "synastry", icon: "💫", en: "Synastry", tr: "Synastry" },
  { slug: "transits", icon: "🌌", en: "Transits", tr: "Transitler" },
  { slug: "daily-horoscope", icon: "⭐", en: "Horoscope", tr: "Burç Yorumu" },
  { slug: "solar-return", icon: "☀️", en: "Solar Return", tr: "Solar Return" },
  { slug: "progressions", icon: "🌀", en: "Progressions", tr: "Progresyonlar" },
  { slug: "zodiac-compatibility", icon: "♥️", en: "Compatibility", tr: "Uyum" },
  { slug: "moon-phase", icon: "🌙", en: "Moon Phase", tr: "Ay Fazı" },
  { slug: "biorhythm", icon: "📊", en: "Biorhythm", tr: "Biyoritm" },
  { slug: "chakra", icon: "🔮", en: "Chakra", tr: "Chakra" },
  { slug: "meditation", icon: "🧘", en: "Meditation", tr: "Meditasyon" },
  { slug: "chinese-zodiac", icon: "🐉", en: "Chinese Zodiac", tr: "Çin Burcu" },
  { slug: "aura", icon: "✨", en: "Aura", tr: "Aura" },
];

// Deterministic shuffle seeded by current tool slug
function seededShuffle<T>(arr: T[], seed: string): T[] {
  const copy = [...arr];
  let h = 0;
  for (let i = 0; i < seed.length; i++) h = ((h << 5) - h + seed.charCodeAt(i)) | 0;
  for (let i = copy.length - 1; i > 0; i--) {
    h = (h * 16807 + 0) % 2147483647;
    const j = Math.abs(h) % (i + 1);
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}

export default function MoreTools({
  currentSlug,
  locale,
  localePath,
}: {
  currentSlug: string;
  locale: string;
  localePath: string;
}) {
  const isEn = locale === "en";
  const others = seededShuffle(
    ALL_TOOLS.filter(t => t.slug !== currentSlug),
    currentSlug
  ).slice(0, 4);

  return (
    <div className="mt-12 pt-8 border-t border-cosmic-border/30">
      <h3 className="text-sm uppercase tracking-widest text-cosmic-muted text-center mb-4">
        {isEn ? "More Tools" : "Diğer Araçlar"}
      </h3>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-2 max-w-lg mx-auto">
        {others.map(t => (
          <a
            key={t.slug}
            href={`${localePath}/tools/${t.slug}`}
            className="block p-3 rounded-xl bg-white/[0.03] border border-white/[0.06] hover:border-purple-500/30 hover:bg-white/[0.06] transition-all text-center"
          >
            <div className="text-xl mb-1">{t.icon}</div>
            <div className="text-[11px] text-cosmic-muted">{isEn ? t.en : t.tr}</div>
          </a>
        ))}
      </div>
      <div className="text-center mt-3">
        <a href={`${localePath}/tools`} className="text-xs text-purple-400 hover:text-purple-300">
          {isEn ? "All 15 tools →" : "Tüm 15 araç →"}
        </a>
      </div>
    </div>
  );
}
