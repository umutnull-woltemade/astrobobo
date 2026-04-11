/**
 * /universe/zodiac — Pro cinematic viewer for real zodiac data.
 *
 * This route proves the Pro layer can consume the same `content/zodiac`
 * source the cosmic site uses, without duplicating data or replacing the
 * existing SEO routes at `/[locale]/zodiac/[sign]`.
 *
 * Server component — data is pulled statically at build time. The Pro
 * runtime lives inside ProShell. The sign selection is a client island
 * (ZodiacOrbit) so the orbital nav can swap the active sign without a
 * full navigation.
 */

import type { Metadata } from "next";
import { zodiacSigns } from "@/content/zodiac";
import { ProShell } from "../ProShell";
import { ZodiacOrbitClient } from "./ZodiacOrbitClient";

export const metadata: Metadata = {
  title: "Astrobobo — Universe · Zodiac",
  description:
    "Walk the zodiac as a living field. Each archetype is a gravity well.",
  robots: { index: false, follow: false },
};

export default function UniverseZodiacPage() {
  // Shape down to just what the client island needs. Keeps the page payload
  // small and avoids shipping the full prose prompts to the browser.
  const signs = zodiacSigns.map((s) => ({
    slug: s.slug,
    name: s.name,
    symbol: s.symbol,
    element: s.element,
    modality: s.modality,
    rulingPlanet: s.rulingPlanet,
    dateRange: s.dateRange,
    keywords: s.keywords.slice(0, 5),
    overview: truncate(s.overview, 520),
    strengths: s.strengths.slice(0, 4),
    growthThemes: s.growthThemes.slice(0, 3),
    dailyInspiration: s.dailyInspiration.slice(0, 2),
  }));

  return (
    <ProShell>
      <ZodiacOrbitClient signs={signs} />
    </ProShell>
  );
}

function truncate(text: string, max: number): string {
  if (text.length <= max) return text;
  const cut = text.slice(0, max);
  const lastStop = Math.max(cut.lastIndexOf("."), cut.lastIndexOf(" "));
  return cut.slice(0, lastStop > 0 ? lastStop : max).trim() + "…";
}
