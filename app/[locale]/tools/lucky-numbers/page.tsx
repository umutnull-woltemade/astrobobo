import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import LuckyNumbersClient from "./lucky-numbers-client";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return { title: isEn ? "Lucky Numbers Generator" : "Şanslı Sayılar",
    description: isEn ? "Personal lucky numbers from numerology + today's date. Life path, personal year, 5 daily picks." : "Numeroloji + bugünün tarihine göre kişisel şanslı sayılar. Yaşam yolu, kişisel yıl, 5 günlük seçim.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Lucky Numbers' : 'Şanslı Sayılar')}`, width: 1200, height: 630 }] } };
}
export default async function LuckyNumbersPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Lucky Numbers" : "Şanslı Sayılar"} toolSlug="lucky-numbers" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🎰 Lucky Numbers' : '🎰 Şanslı Sayılar'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Your personal lucky numbers based on numerology + today's date." : "Numeroloji + bugünün tarihine dayalı kişisel şanslı sayıların."}</p>
    </div>
    <LuckyNumbersClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="lucky-numbers" locale={locale as string} localePath={localePath} />
  </div>);
}
