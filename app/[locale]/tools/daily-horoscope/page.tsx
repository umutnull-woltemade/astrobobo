import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import DailyHoroscopeClient from "./daily-horoscope-client";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Daily Horoscope — Today's Cosmic Energy" : "Günlük Burç Yorumu — Bugünün Kozmik Enerjisi",
    description: isEn
      ? "Select your sign and see today's horoscope based on real planetary transits."
      : "Burcunuzu seçin ve gerçek gezegen transitelerine dayalı günlük yorumunuzu görün.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Daily Horoscope' : 'Günlük Burç Yorumu')}`, width: 1200, height: 630 }] },
  };
}

export default async function DailyHoroscopePage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Daily Horoscope" : "Günlük Burç Yorumu"} toolSlug="daily-horoscope" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '⭐ Daily Horoscope' : '⭐ Günlük Burç Yorumu'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? "Select your sign. Today's reading is based on real planetary positions." : "Burcunuzu seçin. Bugünkü yorum gerçek gezegen pozisyonlarına dayanır."}
        </p>
      </div>
      <DailyHoroscopeClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="daily-horoscope" locale={locale as string} localePath={localePath} />
    </div>
  );
}
