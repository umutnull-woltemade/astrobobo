import { NextResponse } from "next/server";
import { articles } from "@/content/articles";

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const category = searchParams.get("category");
    const tag = searchParams.get("tag");
    const parsedLimit = parseInt(searchParams.get("limit") || "20", 10);
    const parsedOffset = parseInt(searchParams.get("offset") || "0", 10);
    const limit = Number.isNaN(parsedLimit) ? 20 : Math.max(1, Math.min(parsedLimit, 100));
    const offset = Number.isNaN(parsedOffset) ? 0 : Math.max(0, parsedOffset);

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
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
