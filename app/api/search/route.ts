import { NextResponse } from "next/server";
import { getZodiacSigns } from "@/content/zodiac";
import { getArticles } from "@/content/articles";
import { isValidLocale, type Locale } from "@/lib/i18n/config";

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const q = searchParams.get("q")?.toLowerCase();
    const lang = searchParams.get("lang") || "en";
    const locale: Locale = isValidLocale(lang) ? lang : "en";
    const parsedLimit = parseInt(searchParams.get("limit") || "20", 10);
    const limit = Number.isNaN(parsedLimit) ? 20 : Math.max(1, Math.min(parsedLimit, 100));
    const localePath = locale === "en" ? "" : `/${locale}`;

    if (!q || q.length < 2) {
      return NextResponse.json({ error: "Query must be at least 2 characters" }, { status: 400 });
    }

    const zodiacSigns = getZodiacSigns(locale);
    const articles = getArticles(locale);

    const signResults = zodiacSigns
      .filter(
        (s) =>
          s.name.toLowerCase().includes(q) ||
          s.keywords.some((k) => k.toLowerCase().includes(q)) ||
          s.element.toLowerCase().includes(q) ||
          s.overview.toLowerCase().includes(q)
      )
      .map((s) => ({
        type: "zodiac" as const,
        slug: s.slug,
        title: s.name,
        description: s.overview.slice(0, 150),
        url: `${localePath}/zodiac/${s.slug}`,
      }));

    const articleResults = articles
      .filter(
        (a) =>
          a.title.toLowerCase().includes(q) ||
          a.description.toLowerCase().includes(q) ||
          a.tags.some((t) => t.toLowerCase().includes(q))
      )
      .map((a) => ({
        type: "article" as const,
        slug: a.slug,
        title: a.title,
        description: a.description,
        url: `${localePath}/articles/${a.slug}`,
      }));

    const results = [...signResults, ...articleResults].slice(0, limit);

    return NextResponse.json({
      query: q,
      total: results.length,
      results,
    });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
