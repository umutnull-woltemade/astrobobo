import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import SynastryClient from "./synastry-client";
import MoreTools from "@/components/tools/more-tools";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Synastry — Relationship Compatibility (Swiss Ephemeris)" : "Synastry — İlişki Uyumu (Swiss Ephemeris)",
    description: isEn
      ? "Compare two birth charts with Swiss Ephemeris precision. See all aspects between your planets."
      : "Swiss Ephemeris hassasiyetiyle iki doğum haritasını karşılaştırın. Gezegenler arası tüm açıları görün.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Synastry Analysis' : 'Synastry Analizi')}`, width: 1200, height: 630 }] },
  };
}

export default async function SynastryPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-5xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '💫 Synastry Analysis' : '💫 Synastry Analizi'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? 'Enter two birth dates to see all planetary aspects between you. Powered by Swiss Ephemeris.' : 'İki doğum tarihi girerek gezegenler arası tüm açıları görün. Swiss Ephemeris ile.'}
        </p>
      </div>
      <SynastryClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="synastry" locale={locale as string} localePath={localePath} />
    </div>
  );
}
