import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import ProfectionClient from "./profection-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Annual Profection Year — What House Are You In?" : "Yıllık Profeksiyon — Hangi Evdesin?",
    description: isEn ? "Calculate your annual profection year — which house and planet rule your current year of life." : "Yıllık profeksiyonunuzu hesaplayın — yaşamınızın mevcut yılına hangi ev ve gezegen hükmediyor.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Profection Year' : 'Profeksiyon Yılı')}`, width: 1200, height: 630 }] },
  };
}
export default async function ProfectionPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Profection Year" : "Profeksiyon Yılı"} toolSlug="profection-year" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🎯 Annual Profection Year' : '🎯 Yıllık Profeksiyon'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Each year of your life activates a different house. Age 0 = 1st house, age 1 = 2nd house, cycling every 12 years." : "Yaşamınızın her yılı farklı bir evi aktive eder. 0 yaş = 1. ev, 1 yaş = 2. ev, her 12 yılda döngü."}</p>
    </div>
    <ProfectionClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="profection-year" locale={locale as string} localePath={localePath} />
  </div>);
}
