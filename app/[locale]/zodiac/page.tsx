import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getZodiacSigns } from "@/content/zodiac";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const dict = await getDictionary(locale as Locale);

  return {
    title: dict.zodiac.pageTitle,
    description: dict.zodiac.pageDescription,
    openGraph: {
      title: `${dict.zodiac.heading} | Astrobobo`,
      description: dict.zodiac.pageDescription,
      url: locale === "en" ? "/zodiac" : `/${locale}/zodiac`,
    },
  };
}

export default async function ZodiacIndexPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const signs = getZodiacSigns(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  const elementKeys = ["All", "Fire", "Earth", "Air", "Water"] as const;

  return (
    <div className="max-w-7xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {dict.zodiac.heading}
        </h1>
        <p className="text-cosmic-muted max-w-2xl mx-auto text-lg">
          {dict.zodiac.subtitle}
        </p>
      </div>

      {/* Element Filter */}
      <div className="flex justify-center gap-4 mb-12">
        {elementKeys.map((el) => (
          <span
            key={el}
            className={`zodiac-badge cursor-pointer ${
              el === "All"
                ? "bg-cosmic-accent/10 text-cosmic-accent border-cosmic-accent/30"
                : `zodiac-${el.toLowerCase()}`
            }`}
          >
            {el === "All" ? dict.zodiac.all : dict.elements[el]}
          </span>
        ))}
      </div>

      {/* Signs Grid */}
      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        {signs.map((sign) => (
          <a
            key={sign.slug}
            href={`${localePath}/zodiac/${sign.slug}`}
            className="cosmic-card group"
          >
            <div className="flex items-start justify-between mb-4">
              <div>
                <span className="text-4xl">{sign.symbol}</span>
                <h2 className="text-xl font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors mt-2">
                  {sign.name}
                </h2>
                <p className="text-cosmic-muted text-sm">{sign.dateRange}</p>
              </div>
              <div className="flex flex-col gap-2 items-end">
                <span className={`zodiac-${sign.element.toLowerCase()} zodiac-badge`}>
                  {dict.elements[sign.element]}
                </span>
                <span className="text-cosmic-muted text-xs">{dict.modalities[sign.modality]}</span>
              </div>
            </div>
            <p className="text-cosmic-muted text-sm line-clamp-3">
              {sign.overview}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              {sign.keywords.slice(0, 4).map((kw) => (
                <span
                  key={kw}
                  className="text-xs bg-cosmic-surface px-2 py-1 rounded-md text-cosmic-muted"
                >
                  {kw}
                </span>
              ))}
            </div>
          </a>
        ))}
      </div>

      {/* SEO Content */}
      <section className="mt-20 max-w-3xl mx-auto article-prose">
        <h2>{dict.zodiac.seoHeading}</h2>
        <p>{dict.zodiac.seoP1}</p>
        <p>{dict.zodiac.seoP2}</p>
      </section>
    </div>
  );
}
