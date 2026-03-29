import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getZodiacSigns } from "@/content/zodiac";
import { getPersonalTransits } from "@/content/transits";
import type { ZodiacSlug } from "@/content/transits/types";
import SignPicker from "@/components/zodiac/sign-picker";
import TransitBanner from "@/components/transit-banner";

const ALL_SIGNS: ZodiacSlug[] = [
  "aries", "taurus", "gemini", "cancer", "leo", "virgo",
  "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces",
];

interface PageProps {
  params: Promise<{ locale: string }>;
}

export default async function HomePage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const signs = getZodiacSigns(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  // Pre-compute transits for all signs (server-side)
  const allSignTransits: Record<string, ReturnType<typeof serializeTransits>> = {};
  for (const sign of ALL_SIGNS) {
    allSignTransits[sign] = serializeTransits(sign);
  }
  // Default to Aries for users who haven't picked a sign yet
  const defaultTransits = allSignTransits["aries"];

  // Serialize sign data for the client component
  const signsForPicker = signs.map((s) => ({
    slug: s.slug,
    name: s.name,
    symbol: s.symbol,
    dateRange: s.dateRange,
    element: s.element,
    overview: s.overview,
    dailyInspiration: s.dailyInspiration,
    keywords: s.keywords,
  }));

  return (
    <div className="min-h-screen">
      {/* Personalized Transit Banner */}
      <TransitBanner
        transits={defaultTransits}
        allSignTransits={allSignTransits}
        isEn={isEn}
      />

      {/* Hero */}
      <section className="relative py-24 px-4 text-center bg-cosmic-gradient overflow-hidden">
        <div className="absolute inset-0 opacity-20">
          <div className="absolute top-1/4 left-1/4 w-64 h-64 rounded-full bg-cosmic-purple/20 blur-3xl animate-float" />
          <div className="absolute bottom-1/3 right-1/4 w-48 h-48 rounded-full bg-cosmic-accent/10 blur-3xl animate-float" style={{ animationDelay: "2s" }} />
        </div>
        <div className="relative max-w-4xl mx-auto">
          <h1 className="text-5xl md:text-7xl font-display text-cosmic-accent mb-6">
            Astrobobo
          </h1>
          <p className="text-xl md:text-2xl text-cosmic-text/80 max-w-2xl mx-auto mb-4">
            {dict.home.heroSubtitle}
          </p>
          <p className="text-cosmic-muted max-w-xl mx-auto">
            {dict.home.heroDescription}
          </p>
        </div>
      </section>

      {/* Sign Picker - personalized zodiac section */}
      <SignPicker
        signs={signsForPicker}
        localePath={localePath}
        dict={{
          pickYourSign: dict.home.pickYourSign,
          yourSign: dict.home.yourSign,
          browseOthers: dict.home.browseOthers,
          todayInspiration: dict.home.todayInspiration,
          readFullProfile: dict.home.readFullProfile,
          changeSign: dict.home.changeSign,
          selectBelow: dict.home.selectBelow,
          elements: dict.elements,
        }}
      />

      {/* Featured Content */}
      <section className="bg-cosmic-surface py-16 px-4">
        <div className="max-w-7xl mx-auto">
          <h2 className="cosmic-heading text-3xl text-center mb-12">
            {dict.home.exploreHeading}
          </h2>
          <div className="grid md:grid-cols-3 gap-8">
            <div className="cosmic-card">
              <h3 className="text-cosmic-accent font-display text-xl mb-3">{dict.home.zodiacProfiles}</h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.zodiacProfilesDesc}
              </p>
              <a href={`${localePath}/zodiac`} className="text-cosmic-accent text-sm mt-4 inline-block hover:underline">
                {dict.home.exploreAllSigns} &rarr;
              </a>
            </div>
            <div className="cosmic-card">
              <h3 className="text-cosmic-accent font-display text-xl mb-3">{dict.home.educationalArticles}</h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.educationalArticlesDesc}
              </p>
              <a href={`${localePath}/articles`} className="text-cosmic-accent text-sm mt-4 inline-block hover:underline">
                {dict.home.readArticles} &rarr;
              </a>
            </div>
            <div className="cosmic-card">
              <h3 className="text-cosmic-accent font-display text-xl mb-3">{dict.home.dailyReflections}</h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.dailyReflectionsDesc}
              </p>
              <a href={`${localePath}/articles?category=reflections`} className="text-cosmic-accent text-sm mt-4 inline-block hover:underline">
                {dict.home.startReflecting} &rarr;
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* SEO Content Block */}
      <section className="max-w-4xl mx-auto px-4 py-16">
        <div className="article-prose">
          <h2>{dict.home.whatIsReflective}</h2>
          <p>{dict.home.whatIsReflectiveP1}</p>
          <p>{dict.home.whatIsReflectiveP2}</p>
          <h2>{dict.home.howToUse}</h2>
          <p>{dict.home.howToUseP}</p>
        </div>
      </section>
    </div>
  );
}

function serializeTransits(sign: ZodiacSlug) {
  const transits = getPersonalTransits(sign);
  return transits.map((t) => ({
    planet: t.transit.planet,
    sign: t.transit.sign,
    house: t.house,
    houseThemeEn: t.houseTheme.en,
    houseThemeTr: t.houseTheme.tr,
    titleEn: t.interpretation.titleEn,
    titleTr: t.interpretation.titleTr,
    bodyEn: t.interpretation.bodyEn,
    bodyTr: t.interpretation.bodyTr,
    keywordsEn: t.interpretation.keywordsEn,
    keywordsTr: t.interpretation.keywordsTr,
    durationEn: t.interpretation.durationEn,
    durationTr: t.interpretation.durationTr,
  }));
}
