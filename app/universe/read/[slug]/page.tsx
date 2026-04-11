/**
 * /universe/read/[slug] — Pro cinematic article reader.
 *
 * Reuses the same `content/articles` source the cosmic route
 * `/[locale]/articles/[slug]` renders, parsed into structured blocks at
 * build time. `generateStaticParams` prerenders every article so the
 * route is fully static.
 */

import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { articles, getArticleBySlug } from "@/content/articles";
import { parseArticleMarkdown } from "@/lib/pro/markdown-lite";
import { ProShell } from "../../ProShell";
import { ProReader } from "./ProReader";

type PageProps = {
  params: Promise<{ slug: string }>;
};

export function generateStaticParams() {
  return articles.map((a) => ({ slug: a.slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const article = getArticleBySlug(slug);
  if (!article) return {};
  return {
    title: `Astrobobo — ${article.title}`,
    description: article.description,
    robots: { index: false, follow: false },
  };
}

export default async function UniverseReadPage({ params }: PageProps) {
  const { slug } = await params;
  const article = getArticleBySlug(slug);
  if (!article) notFound();

  const blocks = parseArticleMarkdown(article.content);

  return (
    <ProShell>
      <ProReader
        title={article.title}
        description={article.description}
        readingTime={article.readingTime}
        category={article.category}
        tags={article.tags}
        blocks={blocks}
      />
    </ProShell>
  );
}
