import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import AgeHarmonicClient from "./age-harmonic-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Age Harmonic Chart — Your Year in Harmonics" : "Yaş Harmonik Haritası — Harmoniklerde Yılın",
    description: isEn ? "Your harmonic chart for your current age. Multiply natal positions by your age to reveal hidden themes." : "Mevcut yaşınız için harmonik haritanız. Gizli temaları ortaya çıkarmak için natal pozisyonları yaşınızla çarpın.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Age Harmonic' : 'Yaş Harmonik')}`, width: 1200, height: 630 }] },
  };
}
export default async function AgeHarmonicPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Age Harmonic" : "Yaş Harmonik"} toolSlug="age-harmonic" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🔄 Age Harmonic Chart' : '🔄 Yaş Harmonik Haritası'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Multiply each natal position by your age — conjunctions in the harmonic chart reveal this year's activated themes." : "Her natal pozisyonu yaşınla çarp — harmonik haritadaki kavuşumlar bu yılın aktif temalarını ortaya koyar."}</p>
    </div>
    <AgeHarmonicClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="age-harmonic" locale={locale as string} localePath={localePath} />
  </div>);
}
