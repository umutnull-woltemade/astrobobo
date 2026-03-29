import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getZodiacSigns } from "@/content/zodiac";
import ElementFilter from "@/components/zodiac/element-filter";

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

  const signsData = signs.map((s) => ({
    slug: s.slug,
    name: s.name,
    symbol: s.symbol,
    dateRange: s.dateRange,
    element: s.element,
    modality: s.modality,
    overview: s.overview,
    keywords: s.keywords,
  }));

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

      <ElementFilter
        signs={signsData}
        localePath={localePath}
        dict={{
          all: dict.zodiac.all,
          elements: dict.elements,
          modalities: dict.modalities,
        }}
      />

      {/* SEO Content */}
      <section className="mt-20 max-w-3xl mx-auto article-prose">
        <h2>{dict.zodiac.seoHeading}</h2>
        <p>{dict.zodiac.seoP1}</p>
        <p>{dict.zodiac.seoP2}</p>
      </section>
    </div>
  );
}
