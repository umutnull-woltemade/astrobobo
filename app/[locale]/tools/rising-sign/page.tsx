import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import RisingSignClient from "./rising-sign-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Rising Sign Calculator — What Is My Ascendant?" : "Yükselen Burç Hesaplama — Yükselenim Ne?",
    description: isEn ? "Calculate your rising sign (ascendant) with Swiss Ephemeris. Requires birth date, time, and place." : "Swiss Ephemeris ile yükselen burcunuzu hesaplayın. Doğum tarihi, saati ve yeri gerekir.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Rising Sign Calculator' : 'Yükselen Burç Hesaplama')}`, width: 1200, height: 630 }] },
  };
}
export default async function RisingSignPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Rising Sign" : "Yükselen Burç"} toolSlug="rising-sign" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '⬆️ Rising Sign Calculator' : '⬆️ Yükselen Burç Hesaplama'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Your ascendant — the mask you wear, how the world sees you. Requires exact birth time and place." : "Yükselenim — taktığın maske, dünyanın seni nasıl gördüğü. Kesin doğum saati ve yeri gerekir."}</p>
    </div>
    <RisingSignClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="rising-sign" locale={locale as string} localePath={localePath} />
  </div>);
}
