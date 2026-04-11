/**
 * /universe/archetype/[slug] — living zodiac archetype profile.
 *
 * Where `/universe/zodiac` is the orbital picker, this route is the deep
 * dive: the full archetype in cinematic form. Pulls the real ZodiacSign
 * from content/zodiac and blends every field into the Pro layout.
 *
 * Uses the new ProLayout wrapper so the page body is almost entirely
 * content — no ProShell boilerplate.
 */

import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getAllZodiacSlugs, getZodiacSign } from "@/content/zodiac";
import { ProLayout } from "../../ProLayout";
import { LivingArchetype } from "./LivingArchetype";

type PageProps = {
  params: Promise<{ slug: string }>;
};

export function generateStaticParams() {
  return getAllZodiacSlugs().map((slug) => ({ slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const sign = getZodiacSign(slug);
  if (!sign) return {};
  return {
    title: `Astrobobo — ${sign.name} · Living archetype`,
    description: sign.overview.slice(0, 160),
    robots: { index: false, follow: false },
  };
}

export default async function UniverseArchetypePage({ params }: PageProps) {
  const { slug } = await params;
  const sign = getZodiacSign(slug);
  if (!sign) notFound();

  return (
    <ProLayout
      eyebrow={`astrobobo / pro / archetype`}
      title={
        <>
          <span className="mr-3 text-pro-cyan">{sign.symbol}</span>
          {sign.name}
        </>
      }
      subtitle={sign.dateRange + " · Ruled by " + sign.rulingPlanet}
    >
      <LivingArchetype sign={sign} />
    </ProLayout>
  );
}
