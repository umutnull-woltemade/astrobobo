export type { Article } from "./types";

import type { Article } from "./types";
import type { Locale } from "@/lib/i18n/config";
import { articles01to05 } from "./articles-01-05";
import { articles06to10 } from "./articles-06-10";
import { articles11to15 } from "./articles-11-15";
import { articles16to20 } from "./articles-16-20";

export const articles: Article[] = [
  ...articles01to05,
  ...articles06to10,
  ...articles11to15,
  ...articles16to20,
];

import { articlesTr01to05 } from "./articles-01-05-tr";
import { articlesTr06to10 } from "./articles-06-10-tr";
import { articlesTr11to15 } from "./articles-11-15-tr";
import { articlesTr16to20 } from "./articles-16-20-tr";

const articlesTr: Article[] = [
  ...articlesTr01to05,
  ...articlesTr06to10,
  ...articlesTr11to15,
  ...articlesTr16to20,
];

export function getArticles(locale: Locale): Article[] {
  if (locale === "tr") {
    return articlesTr;
  }
  return articles;
}

export function getArticleBySlug(slug: string) {
  return articles.find((a) => a.slug === slug);
}

export function getArticlesByCategory(category: string) {
  return articles.filter((a) => a.category === category);
}

export function getArticlesByTag(tag: string) {
  return articles.filter((a) => a.tags.includes(tag));
}

export function getArticlesForSign(sign: string) {
  return articles.filter((a) => a.relatedSigns?.includes(sign));
}

export function getRelatedArticles(slug: string, limit = 4) {
  const article = getArticleBySlug(slug);
  if (!article) return [];

  return articles
    .filter((a) => a.slug !== slug)
    .map((a) => ({
      article: a,
      score:
        (a.category === article.category ? 3 : 0) +
        a.tags.filter((t) => article.tags.includes(t)).length * 2 +
        (a.relatedSigns?.filter((s) => article.relatedSigns?.includes(s)).length ?? 0),
    }))
    .sort((a, b) => b.score - a.score)
    .slice(0, limit)
    .map((r) => r.article);
}

export function getAllCategories() {
  return [...new Set(articles.map((a) => a.category))];
}

export function getAllTags() {
  return [...new Set(articles.flatMap((a) => a.tags))].sort();
}
