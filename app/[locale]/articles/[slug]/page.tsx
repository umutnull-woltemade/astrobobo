import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import { getArticles } from "@/content/articles";
import { getZodiacSigns } from "@/content/zodiac";
import { CinematicEntryLink } from "@/components/pro/CinematicEntryLink";

interface PageProps {
  params: Promise<{ locale: string; slug: string }>;
}

export async function generateStaticParams() {
  const enArticles = getArticles("en");
  return locales.flatMap((locale) =>
    enArticles.map((a) => ({ locale, slug: a.slug }))
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale, slug } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const articlesList = getArticles(locale as Locale);
  const article = articlesList.find((a) => a.slug === slug);
  if (!article) return {};
  const isEn = locale === "en";

  return {
    title: article.title,
    description: article.description,
    openGraph: {
      title: `${article.title} | Astrobobo`,
      description: article.description,
      type: "article",
      url: isEn ? `/articles/${article.slug}` : `/${locale}/articles/${article.slug}`,
      publishedTime: article.publishedAt,
      images: [{
        url: `/api/og?title=${encodeURIComponent(article.title)}&subtitle=${encodeURIComponent(article.description.slice(0, 100))}`,
        width: 1200,
        height: 630,
      }],
    },
    twitter: {
      card: "summary_large_image",
      title: article.title,
      description: article.description,
      images: [`/api/og?title=${encodeURIComponent(article.title)}`],
    },
    alternates: {
      canonical: isEn ? `/articles/${article.slug}` : `/${locale}/articles/${article.slug}`,
    },
  };
}

export default async function ArticlePage({ params }: PageProps) {
  const { locale, slug } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const articlesList = getArticles(locale as Locale);
  const article = articlesList.find((a) => a.slug === slug);
  if (!article) notFound();

  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;
  const signs = getZodiacSigns(locale as Locale);
  const signNameMap = Object.fromEntries(signs.map((s) => [s.slug, s.name]));

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: article.title,
    description: article.description,
    author: { "@type": "Organization", name: "Astrobobo" },
    publisher: { "@type": "Organization", name: "Astrobobo" },
    datePublished: article.publishedAt,
    inLanguage: locale,
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": `https://astrobobo.com${localePath}/articles/${article.slug}`,
    },
  };

  // Simple markdown-to-sections converter
  const sections = article.content.split("\n\n").map((block, i) => {
    const key = `block-${i}`;
    if (block.startsWith("### ")) {
      return <h3 key={key} className="text-cosmic-text font-display text-xl mt-6 mb-3">{block.slice(4)}</h3>;
    }
    if (block.startsWith("## ")) {
      return <h2 key={key} className="text-cosmic-accent font-display text-2xl mt-8 mb-4">{block.slice(3)}</h2>;
    }
    if (block.startsWith("- ")) {
      const items = block.split("\n").filter((l) => l.startsWith("- "));
      return (
        <ul key={key} className="list-disc list-inside mb-4 space-y-1">
          {items.map((item) => (
            <li key={item}>{item.slice(2)}</li>
          ))}
        </ul>
      );
    }
    if (block.startsWith("> ")) {
      return (
        <blockquote key={key} className="border-l-4 border-cosmic-accent/50 pl-4 italic text-cosmic-muted my-4">
          {block.slice(2)}
        </blockquote>
      );
    }
    return <p key={key} className="mb-4">{block}</p>;
  });

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <article className="max-w-3xl mx-auto px-4 py-12">
        <header className="mb-10">
          <span className="zodiac-badge bg-cosmic-surface border-cosmic-border text-cosmic-muted text-xs capitalize mb-4 inline-block">
            {(dict.articles.categories as Record<string, string>)[article.category] ?? article.category}
          </span>
          <h1 className="text-3xl md:text-4xl font-display text-cosmic-accent mb-4">
            {article.title}
          </h1>
          <div className="flex items-center gap-4 text-sm text-cosmic-muted">
            <span>{article.readingTime} {dict.articles.minRead}</span>
            <span>{new Date(article.publishedAt).toLocaleDateString(locale)}</span>
          </div>
          <div className="flex flex-wrap gap-2 mt-4">
            {article.tags.map((tag) => (
              <span
                key={tag}
                className="text-xs bg-cosmic-card px-2 py-1 rounded-md text-cosmic-muted"
              >
                {tag}
              </span>
            ))}
          </div>
          {/* Opt-in entry into the Pro cinematic reader. Canonical stays
              pointing at the cosmic route so SEO is preserved. Prefetches
              the Three.js scene chunk on hover so first-click is instant. */}
          <CinematicEntryLink href={`${localePath}/articles/${article.slug}/pro`} />
        </header>

        <div className="article-prose">{sections}</div>

        {article.relatedSigns && article.relatedSigns.length > 0 && (
          <aside className="mt-12 cosmic-card">
            <h3 className="cosmic-heading text-lg mb-3">{dict.zodiac.relatedSigns}</h3>
            <div className="flex flex-wrap gap-3">
              {article.relatedSigns.map((sign) => (
                <a
                  key={sign}
                  href={`${localePath}/zodiac/${sign}`}
                  className="text-cosmic-accent hover:underline capitalize"
                >
                  {signNameMap[sign] ?? sign}
                </a>
              ))}
            </div>
          </aside>
        )}
      </article>
    </>
  );
}
