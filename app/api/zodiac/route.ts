import { NextResponse } from "next/server";
import { getZodiacSigns } from "@/content/zodiac";
import { isValidLocale, defaultLocale } from "@/lib/i18n/config";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const element = searchParams.get("element");
  const modality = searchParams.get("modality");
  const lang = searchParams.get("lang") || defaultLocale;
  const locale = isValidLocale(lang) ? lang : defaultLocale;

  let filtered = getZodiacSigns(locale);

  if (element) {
    filtered = filtered.filter(
      (s) => s.element.toLowerCase() === element.toLowerCase()
    );
  }
  if (modality) {
    filtered = filtered.filter(
      (s) => s.modality.toLowerCase() === modality.toLowerCase()
    );
  }

  return NextResponse.json({
    count: filtered.length,
    locale,
    signs: filtered.map((s) => ({
      slug: s.slug,
      name: s.name,
      symbol: s.symbol,
      element: s.element,
      modality: s.modality,
      dateRange: s.dateRange,
      rulingPlanet: s.rulingPlanet,
      keywords: s.keywords,
    })),
  });
}
