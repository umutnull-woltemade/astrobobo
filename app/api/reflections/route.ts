import { NextResponse } from "next/server";
import { reflections } from "@/content/reflections";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const category = searchParams.get("category");
  const sign = searchParams.get("sign");
  const random = searchParams.get("random") === "true";
  const limit = parseInt(searchParams.get("limit") || "10", 10);

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
}
