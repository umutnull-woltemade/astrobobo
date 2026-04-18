import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import VedicClient from "./vedic-client";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return { title: isEn ? "Vedic (Sidereal) Chart — Jyotish Astrology" : "Vedik Harita — Jyotish Astroloji",
    description: isEn ? "Sidereal zodiac with Lahiri ayanamsa and Nakshatra positions." : "Lahiri ayanamsa ve Nakshatra pozisyonlarıyla sidereal zodyak.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Vedic Chart' : 'Vedik Harita')}`, width: 1200, height: 630 }] } };
}
export default async function VedicPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Vedic Chart" : "Vedik Harita"} toolSlug="vedic" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🕉️ Vedic Chart' : '🕉️ Vedik Harita'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Sidereal zodiac (Lahiri) with Nakshatra positions — traditional Jyotish." : "Nakshatra pozisyonlarıyla sidereal zodyak (Lahiri) — geleneksel Jyotish."}</p>
    </div>
    <VedicClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="vedic" locale={locale as string} localePath={localePath} />
  </div>);
}
