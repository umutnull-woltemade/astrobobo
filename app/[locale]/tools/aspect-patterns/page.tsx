import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import AspectPatternsClient from "./aspect-patterns-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Aspect Patterns — Grand Trine, T-Square, Yod" : "Açı Kalıpları — Büyük Üçgen, T-Kare, Yod",
    description: isEn ? "Detect aspect patterns in your birth chart: Grand Trine, T-Square, Yod, Grand Cross, Stellium." : "Doğum haritanızdaki açı kalıplarını tespit edin: Büyük Üçgen, T-Kare, Yod, Büyük Haç, Stellium.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Aspect Patterns' : 'Açı Kalıpları')}`, width: 1200, height: 630 }] },
  };
}
export default async function AspectPatternsPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Aspect Patterns" : "Açı Kalıpları"} toolSlug="aspect-patterns" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🔺 Aspect Patterns' : '🔺 Açı Kalıpları'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Grand Trine, T-Square, Yod, Grand Cross, Stellium — the geometric signatures in your natal chart." : "Büyük Üçgen, T-Kare, Yod, Büyük Haç, Stellium — doğum haritanızdaki geometrik imzalar."}</p>
    </div>
    <AspectPatternsClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="aspect-patterns" locale={locale as string} localePath={localePath} />
  </div>);
}
