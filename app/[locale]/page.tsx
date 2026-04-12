/**
 * Astrobobo homepage — cinematic entry portal.
 *
 * The visible experience is built in `<HomePortal />` (client component).
 * Beneath the portal we still render the legacy SEO content as a
 * crawlable section so search engines keep indexing the site's copy and
 * the footer navigation remains reachable. The SEO block is styled as a
 * "continuation" — the user only sees it if they scroll past the portal
 * at the final scene.
 */

import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import HomePortal from "@/components/pro/home-portal";
import { FEATURED_DREAMS, dreamHubPath, dreamArticlePath } from "@/lib/dreams/constants";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export default async function HomePage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;
  const targetHref = `${localePath}/zodiac`;

  return (
    <div className="min-h-screen">
      <HomePortal locale={isEn ? "en" : "tr"} targetHref={targetHref} />

      {/* Crawlable SEO continuation — sits below the 100dvh portal. */}
      <section className="relative bg-cosmic-bg border-t border-cosmic-border/60 py-24 px-4">
        <div className="max-w-4xl mx-auto article-prose">
          <h1 className="cosmic-heading text-3xl md:text-4xl mb-4">Astrobobo</h1>
          <p className="text-cosmic-muted mb-8">{dict.home.heroSubtitle}</p>
          <h2>{dict.home.whatIsReflective}</h2>
          <p>{dict.home.whatIsReflectiveP1}</p>
          <p>{dict.home.whatIsReflectiveP2}</p>
          <h2>{dict.home.howToUse}</h2>
          <p>{dict.home.howToUseP}</p>

          <div className="grid md:grid-cols-3 gap-6 mt-12">
            <a href={`${localePath}/zodiac`} className="cosmic-card block">
              <h3 className="text-cosmic-accent font-display text-lg mb-2">
                {dict.home.zodiacProfiles}
              </h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.zodiacProfilesDesc}
              </p>
            </a>
            <a href={`${localePath}/articles`} className="cosmic-card block">
              <h3 className="text-cosmic-accent font-display text-lg mb-2">
                {dict.home.educationalArticles}
              </h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.educationalArticlesDesc}
              </p>
            </a>
            <a
              href={`${localePath}/articles?category=reflections`}
              className="cosmic-card block"
            >
              <h3 className="text-cosmic-accent font-display text-lg mb-2">
                {dict.home.dailyReflections}
              </h3>
              <p className="text-cosmic-muted text-sm">
                {dict.home.dailyReflectionsDesc}
              </p>
            </a>
          </div>

          {/* Dream interpretation hub — links to /r/ SEO pages */}
          <div className="mt-16 pt-12 border-t border-cosmic-border/40">
            <h2 className="cosmic-heading text-2xl mb-4">
              {dict.dreams.title}
            </h2>
            <p className="text-cosmic-muted mb-6 text-sm">
              {dict.dreams.subtitle}
            </p>
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3">
              {FEATURED_DREAMS.map(d => (
                <a
                  key={d.slug}
                  href={dreamArticlePath(locale as string, d.slug)}
                  className="block px-4 py-3 rounded-xl bg-white/[0.04] border border-white/[0.08] hover:border-purple-500/40 hover:bg-white/[0.07] transition-all text-sm text-cosmic-text text-center"
                >
                  {isEn ? d.en : d.tr}
                </a>
              ))}
            </div>
            <div className="mt-4 text-center">
              <a
                href={dreamHubPath(locale as string)}
                className="text-purple-400 hover:text-purple-300 text-sm font-medium"
              >
                {dict.dreams.viewAll}
              </a>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
