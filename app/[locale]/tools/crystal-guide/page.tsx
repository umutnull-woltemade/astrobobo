import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import CrystalGuideClient from "./crystal-guide-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Crystal Guide — Zodiac & Intention" : "Kristal Rehberi — Burç & Niyet",
    description: isEn ? "Find your stones by zodiac sign and intention — love, calm, focus, courage, wealth, protection." : "Burç ve niyete göre taşlarını bul — aşk, sükunet, odak, cesaret, bolluk, koruma.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Crystal Guide' : 'Kristal Rehberi')}`, width: 1200, height: 630 }] },
  };
}
export default async function CrystalGuidePage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Crystal Guide" : "Kristal Rehberi"} toolSlug="crystal-guide" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '💎 Crystal Guide' : '💎 Kristal Rehberi'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Stones by zodiac and intention." : "Burç ve niyet bazlı taşlar."}</p>
    </div>
    <CrystalGuideClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="crystal-guide" locale={locale as string} localePath={localePath} />
  </div>);
}
