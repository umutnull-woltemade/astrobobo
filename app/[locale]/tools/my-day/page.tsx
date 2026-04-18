import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import MyDayClient from "./my-day-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "My Cosmic Day — Personalized Daily Reading" : "Kozmik Günüm — Kişisel Günlük Okuma",
    description: isEn ? "Your personalized daily cosmic briefing — transits to natal, moon phase, void-of-course, planetary hour, daily card." : "Kişiselleştirilmiş günlük kozmik bilgilendirme — natal transitler, ay fazı, gezegen saati, günlük kart.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'My Cosmic Day' : 'Kozmik Günüm')}`, width: 1200, height: 630 }] },
  };
}
export default async function MyDayPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "My Cosmic Day" : "Kozmik Günüm"} toolSlug="my-day" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🌅 My Cosmic Day' : '🌅 Kozmik Günüm'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Your personalized daily briefing — all your cosmic data in one place." : "Kişisel günlük brifing — tüm kozmik verin tek yerde."}</p>
    </div>
    <MyDayClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="my-day" locale={locale as string} localePath={localePath} />
  </div>);
}
