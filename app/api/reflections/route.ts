import { NextResponse } from "next/server";
import { reflections } from "@/content/reflections";

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const category = searchParams.get("category");
    const sign = searchParams.get("sign");
    const random = searchParams.get("random") === "true";
    const parsedLimit = parseInt(searchParams.get("limit") || "10", 10);
    const limit = Number.isNaN(parsedLimit) ? 10 : Math.max(1, Math.min(parsedLimit, 100));

    let filtered = reflections;

    if (category) {
      filtered = filtered.filter((r) => r.category === category);
    }
    if (sign) {
      filtered = filtered.filter((r) => r.relatedSign === sign);
    }

    if (random) {
      filtered = filtered
        .map((r) => ({ r, sort: Math.random() }))
        .sort((a, b) => a.sort - b.sort)
        .map(({ r }) => r);
    }

    return NextResponse.json({
      total: filtered.length,
      reflections: filtered.slice(0, limit),
    });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
