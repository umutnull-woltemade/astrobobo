/**
 * /[locale]/zodiac/[sign]/pro — locale-aware Pro overlay for the cosmic
 * zodiac sign page.
 *
 * Mirrors the pattern of /[locale]/articles/[slug]/pro — same cinematic
 * treatment as /universe/archetype/[slug] but rendered against the
 * locale-aware `getZodiacSigns(locale)` source so Turkish visitors see
 * Turkish archetype text.
 *
 * SEO contract:
 *   - `robots: { index: false, follow: false }` — cinematic route is not
 *     indexed so Google only ranks the cosmic /zodiac/[sign] route.
 *   - `alternates.canonical` points at the cosmic route so link equity
 *     stays in one place.
 */

import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getZodiacSigns } from "@/content/zodiac";
import { ProLayout } from "@/app/universe/ProLayout";
import { LivingArchetype } from "@/app/universe/archetype/[slug]/LivingArchetype";

type PageProps = {
  params: Promise<{ locale: string; sign: string }>;
};

export async function generateStaticParams() {
  const signs = getZodiacSigns("en");
  return locales.flatMap((locale) =>
    signs.map((s) => ({ locale, sign: s.slug }))
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale, sign: slug } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const signs = getZodiacSigns(locale as Locale);
  const sign = signs.find((s) => s.slug === slug);
  if (!sign) return {};

  const isEn = locale === "en";
  const cosmicPath = isEn
    ? `/zodiac/${sign.slug}`
    : `/${locale}/zodiac/${sign.slug}`;

  return {
    title: `${sign.name} · cinematic`,
    description: sign.overview.slice(0, 160),
    robots: { index: false, follow: false },
    alternates: {
      canonical: cosmicPath,
    },
  };
}

export default async function CosmicZodiacProPage({ params }: PageProps) {
  const { locale, sign: slug } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const signs = getZodiacSigns(locale as Locale);
  const sign = signs.find((s) => s.slug === slug);
  if (!sign) notFound();

  const isEn = locale === "en";
  const cosmicHref = isEn ? `/zodiac/${sign.slug}` : `/${locale}/zodiac/${sign.slug}`;

  return (
    <ProLayout
      locale={locale as Locale}
      eyebrow="astrobobo / pro / archetype"
      title={
        <>
          <span className="mr-3 text-pro-cyan">{sign.symbol}</span>
          {sign.name}
        </>
      }
      subtitle={`${sign.dateRange} · ${sign.rulingPlanet}`}
    >
      <div className="relative mx-auto max-w-4xl px-6 pt-4">
        <Link
          href={cosmicHref}
          className="inline-flex items-center gap-2 text-xs uppercase tracking-[0.3em] text-pro-muted hover:text-pro-cyan transition-colors"
        >
          <span aria-hidden>←</span>
          <span>Back to the classic view</span>
        </Link>
      </div>
      <LivingArchetype sign={sign} />
    </ProLayout>
  );
}
