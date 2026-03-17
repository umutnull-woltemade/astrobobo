import { NextResponse } from "next/server";
import { zodiacSigns } from "@/content/zodiac/signs";
import { articles } from "@/content/articles";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q")?.toLowerCase();
  const limit = parseInt(searchParams.get("limit") || "20", 10);

  if (!q || q.length < 2) {
    return NextResponse.json({ error: "Query must be at least 2 characters" }, { status: 400 });
  }

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
      url: `/zodiac/${s.slug}`,
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
      url: `/articles/${a.slug}`,
    }));

  const results = [...signResults, ...articleResults].slice(0, limit);

  return NextResponse.json({
    query: q,
    total: results.length,
    results,
  });
}
