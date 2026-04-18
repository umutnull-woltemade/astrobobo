import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoonPhaseClient from "./moon-client";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";

interface PageProps { params: Promise<{ locale: string }> }

export async function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Moon Phase Today — Lunar Energy Guide" : "Bugünün Ay Fazı — Ay Enerjisi Rehberi",
    description: isEn
      ? "See today's moon phase with ritual guidance and emotional energy insights."
      : "Bugünün ay fazını ritüel rehberliği ve duygusal enerji içgörüleriyle görün.",
    openGraph: {
      images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Moon Phase Today' : 'Bugünün Ay Fazı')}`, width: 1200, height: 630 }],
    },
  };
}

export default async function MoonPhasePage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Moon Phase Today" : "Bugünün Ay Fazı"} toolSlug="moon-phase" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🌙 Moon Phase Today' : '🌙 Bugünün Ay Fazı'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? 'Discover the current lunar energy and align your intentions.' : 'Mevcut ay enerjisini keşfedin ve niyetlerinizi hizalayın.'}
        </p>
      </div>
      <MoonPhaseClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="moon-phase" locale={locale as string} localePath={localePath} />
    </div>
  );
}
