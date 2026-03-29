import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getZodiacSigns } from "@/content/zodiac";

interface PageProps {
  params: Promise<{ locale: string; sign: string }>;
}

export async function generateStaticParams() {
  const signs = getZodiacSigns("en");
  return locales.flatMap((locale) =>
    signs.map((s) => ({ locale, sign: s.slug }))
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale, sign: slug } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const signs = getZodiacSigns(locale as Locale);
  const sign = signs.find((s) => s.slug === slug);
  if (!sign) return {};
  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";

  return {
    title: `${sign.name} (${sign.symbol}) - ${dict.zodiac.personality}`,
    description: sign.overview.slice(0, 155) + "...",
    openGraph: {
      title: `${sign.name} | Astrobobo`,
      description: sign.overview.slice(0, 155) + "...",
      url: isEn ? `/zodiac/${sign.slug}` : `/${locale}/zodiac/${sign.slug}`,
      images: [{ url: `/images/zodiac/${sign.slug}-og.png`, width: 1200, height: 630 }],
    },
    alternates: {
      canonical: isEn ? `/zodiac/${sign.slug}` : `/${locale}/zodiac/${sign.slug}`,
    },
  };
}

export default async function ZodiacSignPage({ params }: PageProps) {
  const { locale, sign: slug } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const signs = getZodiacSigns(locale as Locale);
  const sign = signs.find((s) => s.slug === slug);
  if (!sign) notFound();

  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: `${sign.name} - ${dict.zodiac.personality}`,
    description: sign.overview,
    author: { "@type": "Organization", name: "Astrobobo" },
    publisher: { "@type": "Organization", name: "Astrobobo" },
    inLanguage: locale,
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": `https://astrobobo.com${localePath}/zodiac/${sign.slug}`,
    },
  };

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <article className="max-w-4xl mx-auto px-4 py-12">
        {/* Header */}
        <header className="text-center mb-12">
          <div className="text-7xl mb-4" role="img" aria-label={sign.name}>{sign.symbol}</div>
          <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-2">
            {sign.name}
          </h1>
          <p className="text-cosmic-muted text-lg">{sign.dateRange}</p>
          <div className="flex justify-center gap-3 mt-4">
            <span className={`zodiac-${sign.element.toLowerCase()} zodiac-badge`}>
              {dict.elements[sign.element]}
            </span>
            <span className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted">
              {dict.modalities[sign.modality]}
            </span>
            <span className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted">
              {sign.rulingPlanet}
            </span>
          </div>
          <div className="flex flex-wrap justify-center gap-2 mt-4">
            {sign.keywords.map((kw) => (
              <span key={kw} className="text-xs bg-cosmic-card px-3 py-1 rounded-full text-cosmic-muted">
                {kw}
              </span>
            ))}
          </div>
        </header>

        {/* Overview */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.overview}</h2>
          <p className="text-cosmic-text/90 leading-relaxed">{sign.overview}</p>
        </section>

        {/* Personality */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.personality}</h2>
          <p className="text-cosmic-text/90 leading-relaxed">{sign.personality}</p>
        </section>

        {/* Strengths */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.strengths}</h2>
          <ul className="grid md:grid-cols-2 gap-3">
            {sign.strengths.map((s) => (
              <li key={s} className="flex items-start gap-3 text-cosmic-text/90">
                <span className="text-cosmic-accent mt-1">&#x2726;</span>
                <span>{s}</span>
              </li>
            ))}
          </ul>
        </section>

        {/* Growth Themes */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.growthThemes}</h2>
          <ul className="space-y-3">
            {sign.growthThemes.map((g) => (
              <li key={g} className="flex items-start gap-3 text-cosmic-text/90">
                <span className="text-cosmic-purple mt-1">&#x27A4;</span>
                <span>{g}</span>
              </li>
            ))}
          </ul>
        </section>

        {/* Reflection Prompts */}
        <section className="cosmic-card mb-8 bg-gradient-to-br from-cosmic-card to-cosmic-purple/5">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.reflectionPrompts}</h2>
          <ol className="space-y-4">
            {sign.reflectionPrompts.map((p, i) => (
              <li key={p} className="flex items-start gap-4">
                <span className="text-cosmic-accent font-display text-lg min-w-[2rem]">
                  {i + 1}.
                </span>
                <p className="text-cosmic-text/90 italic">{p}</p>
              </li>
            ))}
          </ol>
        </section>

        {/* Compatibility */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.compatibility}</h2>
          <p className="text-cosmic-text/90 leading-relaxed">{sign.compatibilityNotes}</p>
        </section>

        {/* Daily Inspiration */}
        <section className="cosmic-card mb-8">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.dailyInspiration}</h2>
          <div className="space-y-3">
            {sign.dailyInspiration.map((d) => (
              <blockquote
                key={d}
                className="border-l-4 border-cosmic-accent/50 pl-4 text-cosmic-text/80 italic"
              >
                {d}
              </blockquote>
            ))}
          </div>
        </section>

        {/* Cosmic Explanation */}
        <section className="cosmic-card">
          <h2 className="cosmic-heading text-2xl mb-4">{dict.zodiac.cosmicContext}</h2>
          <p className="text-cosmic-text/90 leading-relaxed">{sign.cosmicExplanation}</p>
        </section>

        {/* Navigation - Circular */}
        <nav className="mt-12 flex justify-between text-sm">
          {signs.map((s, i) => {
            if (s.slug === sign.slug) {
              const prev = signs[(i - 1 + signs.length) % signs.length];
              const next = signs[(i + 1) % signs.length];
              return (
                <div key={s.slug} className="flex justify-between w-full">
                  <a href={`${localePath}/zodiac/${prev.slug}`} className="text-cosmic-accent hover:underline">
                    &larr; {prev.name}
                  </a>
                  <a href={`${localePath}/zodiac`} className="text-cosmic-muted hover:text-cosmic-text">
                    {dict.zodiac.all}
                  </a>
                  <a href={`${localePath}/zodiac/${next.slug}`} className="text-cosmic-accent hover:underline">
                    {next.name} &rarr;
                  </a>
                </div>
              );
            }
            return null;
          })}
        </nav>
      </article>
    </>
  );
}
