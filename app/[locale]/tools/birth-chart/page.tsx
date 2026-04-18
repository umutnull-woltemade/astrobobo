import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import BirthChartClient from "./birth-chart-client";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";

interface PageProps { params: Promise<{ locale: string }> }

export async function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Free Birth Chart Calculator — Swiss Ephemeris Precision" : "Ücretsiz Doğum Haritası — Swiss Ephemeris Hassasiyeti",
    description: isEn
      ? "Calculate your natal chart with professional-grade Swiss Ephemeris. Sun, Moon, Rising, all planets, houses, and aspects."
      : "Swiss Ephemeris ile profesyonel doğum haritanızı hesaplayın. Güneş, Ay, Yükselen, tüm gezegenler, evler ve açılar.",
    openGraph: {
      images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Birth Chart Calculator' : 'Doğum Haritası Hesaplama')}`, width: 1200, height: 630 }],
    },
  };
}

export default async function BirthChartPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-5xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Birth Chart" : "Doğum Haritası"} toolSlug="birth-chart" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🌐 Birth Chart' : '🌐 Doğum Haritası'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn
            ? 'Enter your birth date, time, and location for a professional natal chart calculated with Swiss Ephemeris.'
            : 'Swiss Ephemeris ile profesyonel doğum haritanız için doğum tarihi, saati ve konumunuzu girin.'}
        </p>
      </div>
      <BirthChartClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="birth-chart" locale={locale as string} localePath={localePath} />
    </div>
  );
}
