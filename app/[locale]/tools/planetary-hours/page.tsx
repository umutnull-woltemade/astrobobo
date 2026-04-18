import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import PlanetaryHoursClient from "./planetary-hours-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Planetary Hours Calculator — Today" : "Gezegen Saatleri Hesaplama — Bugün",
    description: isEn ? "Which planet rules the current hour? Traditional Chaldean planetary hours for today." : "Mevcut saate hangi gezegen hükmediyor? Bugün için geleneksel Keldani gezegen saatleri.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Planetary Hours' : 'Gezegen Saatleri')}`, width: 1200, height: 630 }] },
  };
}
export default async function PlanetaryHoursPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Planetary Hours" : "Gezegen Saatleri"} toolSlug="planetary-hours" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🕐 Planetary Hours' : '🕐 Gezegen Saatleri'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Traditional Chaldean planetary hours — know which planet rules each hour of today." : "Geleneksel Keldani gezegen saatleri — bugünün her saatine hangi gezegenin hükmettiğini bilin."}</p>
    </div>
    <PlanetaryHoursClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="planetary-hours" locale={locale as string} localePath={localePath} />
  </div>);
}
