import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import TransitsClient from "./transits-client";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Live Transits — Today's Sky (Swiss Ephemeris)" : "Canlı Transitler — Bugünün Gökyüzü (Swiss Ephemeris)",
    description: isEn
      ? "See where every planet is right now. Real-time positions calculated with Swiss Ephemeris."
      : "Şu anda her gezegenin nerede olduğunu görün. Swiss Ephemeris ile gerçek zamanlı pozisyonlar.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Live Transits' : 'Canlı Transitler')}`, width: 1200, height: 630 }] },
  };
}

export default async function TransitsPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Live Transits" : "Canlı Transitler"} toolSlug="transits" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🌌 Live Transits' : '🌌 Canlı Transitler'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? "Real-time planetary positions. See where every planet is right now." : "Gerçek zamanlı gezegen pozisyonları. Şu anda her gezegenin yerini görün."}
        </p>
      </div>
      <TransitsClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="transits" locale={locale as string} localePath={localePath} />
    </div>
  );
}
