import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getArticles } from "@/content/articles";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const dict = await getDictionary(locale as Locale);

  return {
    title: dict.articles.pageTitle,
    description: dict.articles.pageDescription,
  };
}

export default async function ArticlesPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const articlesList = getArticles(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  const sortedArticles = [...articlesList].sort(
    (a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  const categories = [...new Set(articlesList.map((a) => a.category))];

  return (
    <div className="max-w-7xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {dict.articles.heading}
        </h1>
        <p className="text-cosmic-muted max-w-2xl mx-auto text-lg">
          {dict.articles.subtitle}
        </p>
      </div>

      {/* Category Filter */}
      <div className="flex flex-wrap justify-center gap-3 mb-12">
        {categories.map((cat) => (
          <span
            key={cat}
            className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted cursor-pointer hover:border-cosmic-accent/30 capitalize"
          >
            {(dict.articles.categories as Record<string, string>)[cat] ?? cat}
          </span>
        ))}
      </div>

      {/* Articles Grid */}
      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        {sortedArticles.map((article) => (
          <a
            key={article.slug}
            href={`${localePath}/articles/${article.slug}`}
            className="cosmic-card group flex flex-col"
          >
            <span className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted text-xs w-fit capitalize mb-3">
              {(dict.articles.categories as Record<string, string>)[article.category] ?? article.category}
            </span>
            <h2 className="text-lg font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors mb-2">
              {article.title}
            </h2>
            <p className="text-cosmic-muted text-sm flex-grow line-clamp-3">
              {article.description}
            </p>
            <div className="mt-4 flex items-center justify-between text-xs text-cosmic-muted">
              <span>{article.readingTime} {dict.articles.minRead}</span>
              <span>{new Date(article.publishedAt).toLocaleDateString(locale)}</span>
            </div>
          </a>
        ))}
      </div>

      {/* Dream Dictionary Cross-Link */}
      <div className="mt-16 pt-12 border-t border-cosmic-border/40 text-center">
        <h2 className="text-2xl font-display text-cosmic-accent mb-3">
          {isEn ? '🌙 Dream Interpretation Guide' : '🌙 Rüya Tabiri Rehberi'}
        </h2>
        <p className="text-cosmic-muted text-sm mb-6 max-w-lg mx-auto">
          {isEn
            ? 'Discover what your dreams really mean. 15 in-depth guides covering the most common dream symbols.'
            : 'Rüyalarınızın gerçek anlamını keşfedin. En yaygın 15 rüya sembolünü derinlemesine inceleyen rehberler.'}
        </p>
        <a
          href={`/r/${isEn ? 'en' : locale}`}
          className="inline-block px-8 py-3 rounded-xl bg-purple-500/20 border border-purple-500/30 text-purple-300 hover:bg-purple-500/30 transition-all font-medium"
        >
          {isEn ? 'Explore Dream Dictionary →' : 'Rüya Tabiri Sözlüğüne Git →'}
        </a>
      </div>
    </div>
  );
}
