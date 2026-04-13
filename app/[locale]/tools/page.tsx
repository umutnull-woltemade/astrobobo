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
];

const COMING_SOON = [
  { icon: "☀️", en: "Daily Horoscope", tr: "Günlük Burç", desc_en: "Personalized forecasts", desc_tr: "Kişisel tahminler" },
  { icon: "🌙", en: "Dream Interpreter", tr: "Rüya Yorumcusu", desc_en: "AI-powered analysis", desc_tr: "AI destekli analiz" },
  { icon: "🔮", en: "Chakra Analysis", tr: "Chakra Analizi", desc_en: "Energy center balance", desc_tr: "Enerji merkezi dengesi" },
];

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
