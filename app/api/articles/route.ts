import { NextResponse } from "next/server";
import { articles } from "@/content/articles";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const category = searchParams.get("category");
  const tag = searchParams.get("tag");
  const limit = parseInt(searchParams.get("limit") || "20", 10);
  const offset = parseInt(searchParams.get("offset") || "0", 10);

  let filtered = articles;

  if (category) {
    filtered = filtered.filter((a) => a.category === category);
  }
  if (tag) {
    filtered = filtered.filter((a) =>
      a.tags.some((t) => t.toLowerCase() === tag.toLowerCase())
    );
  }

  const sorted = filtered.sort(
    (a, b) =>
      new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  const paginated = sorted.slice(offset, offset + limit);

  return NextResponse.json({
    total: filtered.length,
    limit,
    offset,
    articles: paginated.map((a) => ({
      slug: a.slug,
      title: a.title,
      description: a.description,
      category: a.category,
      tags: a.tags,
      readingTime: a.readingTime,
      publishedAt: a.publishedAt,
    })),
  });
}
