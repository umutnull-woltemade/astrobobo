import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import VoidOfCourseClient from "./void-of-course-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Void of Course Moon — Today" : "Yörüngesiz Ay — Bugün",
    description: isEn ? "Check if the Moon is void of course right now — when to rest and when to act." : "Ay'ın şu anda yörüngesiz olup olmadığını kontrol edin — ne zaman dinlenip ne zaman hareket edilmeli.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Void of Course Moon' : 'Yörüngesiz Ay')}`, width: 1200, height: 630 }] },
  };
}
export default async function VoidOfCoursePage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Void of Course Moon" : "Yörüngesiz Ay"} toolSlug="void-of-course" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🌙 Void of Course Moon' : '🌙 Yörüngesiz Ay'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "When the Moon makes no more major aspects before changing sign — traditionally a rest window." : "Ay burç değiştirmeden önce artık büyük açı yapmadığında — geleneksel dinlenme penceresi."}</p>
    </div>
    <VoidOfCourseClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="void-of-course" locale={locale as string} localePath={localePath} />
  </div>);
}
