import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getArticles } from "@/content/articles";
import { FEATURED_DREAMS, dreamHubPath, dreamArticlePath } from "@/lib/dreams/constants";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Read — Articles & Dream Dictionary" : "Oku — Makaleler & Rüya Tabiri",
    description: isEn
      ? "Educational astrology articles, zodiac insights, and in-depth dream interpretation guides."
      : "Eğitici astroloji makaleleri, burç analizleri ve derinlemesine rüya tabiri rehberleri.",
    openGraph: {
      images: [{
        url: `/api/og?title=${encodeURIComponent(isEn ? 'Read & Discover' : 'Oku & Keşfet')}&subtitle=${encodeURIComponent(isEn ? 'Articles, zodiac insights, dream interpretations' : 'Makaleler, burç analizleri, rüya tabirleri')}`,
        width: 1200,
        height: 630,
      }],
    },
  };
}

export default async function ReadPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const articles = getArticles(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  const sortedArticles = [...articles]
    .sort((a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime())
    .slice(0, 6);

  return (
    <div className="max-w-7xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? 'Read & Discover' : 'Oku & Keşfet'}
        </h1>
        <p className="text-cosmic-muted max-w-2xl mx-auto text-lg">
          {isEn
            ? 'Astrology education, zodiac personality insights, and the most comprehensive dream interpretation guides.'
            : 'Astroloji eğitimi, burç kişilik analizleri ve en kapsamlı rüya tabiri rehberleri.'}
        </p>
      </div>

      {/* Articles Section */}
      <section className="mb-16">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-display text-cosmic-text">
            {dict.articles.heading}
          </h2>
          <a
            href={`${localePath}/articles`}
            className="text-cosmic-accent text-sm hover:underline"
          >
            {isEn ? 'View all →' : 'Tümünü gör →'}
          </a>
        </div>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {sortedArticles.map((article) => (
            <a
              key={article.slug}
              href={`${localePath}/articles/${article.slug}`}
              className="cosmic-card group flex flex-col"
            >
              <span className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted text-xs w-fit capitalize mb-3">
                {(dict.articles.categories as Record<string, string>)[article.category] ?? article.category}
              </span>
              <h3 className="text-lg font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors mb-2">
                {article.title}
              </h3>
              <p className="text-cosmic-muted text-sm flex-grow line-clamp-2">
                {article.description}
              </p>
              <div className="mt-3 text-xs text-cosmic-muted">
                {article.readingTime} {dict.articles.minRead}
              </div>
            </a>
          ))}
        </div>
      </section>

      {/* Dream Dictionary Section */}
      <section>
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-display text-cosmic-text">
            {dict.dreams.title}
          </h2>
          <a
            href={dreamHubPath(locale)}
            className="text-cosmic-accent text-sm hover:underline"
          >
            {dict.dreams.viewAll}
          </a>
        </div>
        <p className="text-cosmic-muted text-sm mb-6">
          {dict.dreams.subtitle}
        </p>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3">
          {FEATURED_DREAMS.map(d => (
            <a
              key={d.slug}
              href={dreamArticlePath(locale, d.slug)}
              className="block px-4 py-4 rounded-xl bg-white/[0.04] border border-white/[0.08] hover:border-purple-500/40 hover:bg-white/[0.07] transition-all text-sm text-cosmic-text text-center"
            >
              <div className="text-lg mb-1">🌙</div>
              {isEn ? d.en : d.tr}
            </a>
          ))}
        </div>
      </section>
    </div>
  );
}
