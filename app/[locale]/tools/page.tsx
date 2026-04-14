import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { dreamHubPath } from "@/lib/dreams/constants";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Cosmic Tools — Free Astrology & Divination" : "Kozmik Araçlar — Ücretsiz Astroloji & Kehanet",
    description: isEn
      ? "Free interactive astrology tools: tarot card pull, numerology calculator, dream dictionary, and more."
      : "Ücretsiz interaktif astroloji araçları: tarot kart çekme, numeroloji hesaplama, rüya tabiri ve daha fazlası.",
    openGraph: {
      images: [{
        url: `/api/og?title=${encodeURIComponent(isEn ? 'Cosmic Tools' : 'Kozmik Araçlar')}&subtitle=${encodeURIComponent(isEn ? 'Free astrology, tarot, numerology' : 'Ücretsiz astroloji, tarot, numeroloji')}`,
        width: 1200, height: 630,
      }],
    },
  };
}

const TOOLS = [
  { slug: "tarot", icon: "🃏", en: "Daily Tarot", tr: "Günlük Tarot", desc_en: "Pull a Major Arcana card", desc_tr: "Major Arcana kartı çek" },
  { slug: "numerology", icon: "🔢", en: "Life Path Number", tr: "Yaşam Yolu Sayısı", desc_en: "Calculate from your birth date", desc_tr: "Doğum tarihinden hesapla" },
  { slug: "zodiac-compatibility", icon: "♥️", en: "Zodiac Compatibility", tr: "Burç Uyumu", desc_en: "Element-based love & friendship match", desc_tr: "Element bazlı aşk & arkadaşlık uyumu" },
  { slug: "moon-phase", icon: "🌙", en: "Moon Phase Today", tr: "Bugünün Ay Fazı", desc_en: "Lunar energy + ritual guidance", desc_tr: "Ay enerjisi + ritüel rehberliği" },
  { slug: "biorhythm", icon: "📊", en: "Biorhythm", tr: "Biyoritm", desc_en: "Physical, emotional, intellectual cycles", desc_tr: "Fiziksel, duygusal, entelektüel döngüler" },
  { slug: "birth-chart", icon: "🌐", en: "Birth Chart", tr: "Doğum Haritası", desc_en: "Swiss Ephemeris professional precision", desc_tr: "Swiss Ephemeris profesyonel hassasiyeti" },
  { slug: "synastry", icon: "💫", en: "Synastry", tr: "Synastry Analizi", desc_en: "Relationship compatibility via aspects", desc_tr: "Açılar üzerinden ilişki uyumu" },
  { slug: "transits", icon: "🌌", en: "Live Transits", tr: "Canlı Transitler", desc_en: "Real-time planetary positions", desc_tr: "Gerçek zamanlı gezegen pozisyonları" },
  { slug: "solar-return", icon: "☀️", en: "Solar Return", tr: "Solar Return", desc_en: "Your year ahead — annual chart", desc_tr: "Yılın haritası — yıllık döngü" },
  { slug: "daily-horoscope", icon: "⭐", en: "Daily Horoscope", tr: "Günlük Burç", desc_en: "Based on real planetary transits", desc_tr: "Gerçek gezegen transitelerine dayalı" },
  { slug: "progressions", icon: "🌀", en: "Progressions", tr: "Progresyonlar", desc_en: "Inner evolution — 1 day = 1 year", desc_tr: "İçsel evrim — 1 gün = 1 yıl" },
  { slug: "chakra", icon: "🔮", en: "Chakra Quiz", tr: "Chakra Testi", desc_en: "7-question energy balance", desc_tr: "7 soruluk enerji dengesi" },
  { slug: "meditation", icon: "🧘", en: "Meditation", tr: "Meditasyon", desc_en: "Cosmic breathing timer", desc_tr: "Kozmik nefes zamanlayıcı" },
  { slug: "chinese-zodiac", icon: "🐉", en: "Chinese Zodiac", tr: "Çin Burcu", desc_en: "Your animal by birth year", desc_tr: "Doğum yılına göre hayvanın" },
  { slug: "aura", icon: "✨", en: "Aura Reading", tr: "Aura Okuma", desc_en: "Discover your energy color", desc_tr: "Enerji rengini keşfet" },
  { slug: "vedic", icon: "🕉️", en: "Vedic Chart", tr: "Vedik Harita", desc_en: "Sidereal + Nakshatra (Jyotish)", desc_tr: "Sidereal + Nakshatra (Jyotish)" },
  { slug: "draconic", icon: "🐉", en: "Draconic Chart", tr: "Drakonik Harita", desc_en: "Soul-level positions", desc_tr: "Ruh düzeyi pozisyonları" },
  { slug: "composite", icon: "🔗", en: "Composite Chart", tr: "Kompozit Harita", desc_en: "Relationship midpoint chart", desc_tr: "İlişki orta nokta haritası" },
  { slug: "retrogrades", icon: "℞", en: "Retrograde Calendar", tr: "Retrograde Takvimi", desc_en: "All retrogrades this year", desc_tr: "Bu yılın tüm retrograde'leri" },
  { slug: "eclipses", icon: "🌑", en: "Eclipse Calendar", tr: "Tutulma Takvimi", desc_en: "Solar & lunar eclipses", desc_tr: "Güneş & ay tutulmaları" },
];

const COMING_SOON: typeof TOOLS = [];

export default async function ToolsPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  return (
    <div className="max-w-5xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '✨ Cosmic Tools' : '✨ Kozmik Araçlar'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn
            ? 'Free interactive tools for astrology, divination, and self-discovery.'
            : 'Astroloji, kehanet ve kendini keşif için ücretsiz interaktif araçlar.'}
        </p>
      </div>

      {/* Active Tools */}
      <section className="mb-16">
        <h2 className="text-sm uppercase tracking-widest text-cosmic-accent mb-6">
          {isEn ? 'Available Now' : 'Şimdi Kullanılabilir'}
        </h2>
        <div className="grid md:grid-cols-2 gap-4">
          {TOOLS.map(t => (
            <a
              key={t.slug}
              href={`${localePath}/tools/${t.slug}`}
              className="cosmic-card group flex items-center gap-5 hover:border-purple-500/40 transition-all"
            >
              <div className="text-4xl">{t.icon}</div>
              <div>
                <h3 className="text-lg font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors">
                  {isEn ? t.en : t.tr}
                </h3>
                <p className="text-sm text-cosmic-muted">{isEn ? t.desc_en : t.desc_tr}</p>
              </div>
            </a>
          ))}
          <a
            href={dreamHubPath(locale as string)}
            className="cosmic-card group flex items-center gap-5 hover:border-purple-500/40 transition-all"
          >
            <div className="text-4xl">🌙</div>
            <div>
              <h3 className="text-lg font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors">
                {isEn ? 'Dream Dictionary' : 'Rüya Tabiri Sözlüğü'}
              </h3>
              <p className="text-sm text-cosmic-muted">
                {isEn ? '15 in-depth guides, 9 languages' : '15 derinlemesine rehber, 9 dil'}
              </p>
            </div>
          </a>
        </div>
      </section>

      {/* Coming Soon */}
      <section>
        <h2 className="text-sm uppercase tracking-widest text-cosmic-muted mb-6">
          {isEn ? 'Coming Soon' : 'Yakında'}
        </h2>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-3">
          {COMING_SOON.map(t => (
            <div
              key={t.en}
              className="px-4 py-4 rounded-xl bg-white/[0.02] border border-white/[0.06] flex items-center gap-4 opacity-60"
            >
              <div className="text-2xl">{t.icon}</div>
              <div>
                <div className="text-sm text-cosmic-text">{isEn ? t.en : t.tr}</div>
                <div className="text-xs text-cosmic-muted">{isEn ? t.desc_en : t.desc_tr}</div>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
