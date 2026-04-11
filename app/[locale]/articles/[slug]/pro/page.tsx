/**
 * /[locale]/articles/[slug]/pro — cinematic overlay on the existing
 * cosmic article route.
 *
 * This is the bridge between SEO traffic and the Pro layer. Users who
 * land on `/articles/the-four-elements` can click "Enter cinematic mode"
 * to navigate to `/articles/the-four-elements/pro` — same data source,
 * same build-time params, cinematic rendering.
 *
 * SEO contract:
 *   - `robots: { index: false, follow: false }` — this route never appears
 *     in search results so we don't split indexing.
 *   - `canonical` points back at the cosmic route so any accidental
 *     inbound link from the Pro overlay funnels link equity correctly.
 */

import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getArticles } from "@/content/articles";
import { parseArticleMarkdown } from "@/lib/pro/markdown-lite";
import { ProLayout } from "@/app/universe/ProLayout";
import { ProReader } from "@/app/universe/read/[slug]/ProReader";

type PageProps = {
  params: Promise<{ locale: string; slug: string }>;
};

export function generateStaticParams() {
  const enArticles = getArticles("en");
  return locales.flatMap((locale) =>
    enArticles.map((a) => ({ locale, slug: a.slug }))
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale, slug } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const list = getArticles(locale as Locale);
  const article = list.find((a) => a.slug === slug);
  if (!article) return {};

  const isEn = locale === "en";
  const cosmicPath = isEn
    ? `/articles/${article.slug}`
    : `/${locale}/articles/${article.slug}`;

  return {
    title: `${article.title} · cinematic`,
    description: article.description,
    robots: { index: false, follow: false },
    alternates: {
      canonical: cosmicPath,
    },
  };
}

export default async function CosmicArticleProPage({ params }: PageProps) {
  const { locale, slug } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const list = getArticles(locale as Locale);
  const article = list.find((a) => a.slug === slug);
  if (!article) notFound();

  const blocks = parseArticleMarkdown(article.content);
  const isEn = locale === "en";
  const cosmicHref = isEn
    ? `/articles/${article.slug}`
    : `/${locale}/articles/${article.slug}`;

  return (
    <ProLayout locale={locale as Locale} hero={false}>
      <div className="relative mx-auto max-w-3xl px-6 pt-6">
        <Link
          href={cosmicHref}
          className="inline-flex items-center gap-2 text-xs uppercase tracking-[0.3em] text-pro-muted hover:text-pro-cyan transition-colors"
        >
          <span aria-hidden>←</span>
          <span>Back to the classic view</span>
        </Link>
      </div>
      <ProReader
        title={article.title}
        description={article.description}
        readingTime={article.readingTime}
        category={article.category}
        tags={article.tags}
        blocks={blocks}
      />
    </ProLayout>
  );
}
