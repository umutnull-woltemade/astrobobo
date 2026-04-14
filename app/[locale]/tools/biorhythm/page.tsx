import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import BiorhythmClient from "./biorhythm-client";
import MoreTools from "@/components/tools/more-tools";

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
    title: isEn ? "Biorhythm Calculator — Physical, Emotional, Intellectual Cycles" : "Biyoritm Hesaplayıcı — Fiziksel, Duygusal, Entelektüel Döngüler",
    description: isEn
      ? "Calculate your biorhythm cycles from your birth date. See your physical, emotional, and intellectual energy levels today."
      : "Doğum tarihinizden biyoritm döngülerinizi hesaplayın. Bugünkü fiziksel, duygusal ve entelektüel enerji seviyelerinizi görün.",
    openGraph: {
      images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Biorhythm Calculator' : 'Biyoritm Hesaplayıcı')}`, width: 1200, height: 630 }],
    },
  };
}

export default async function BiorhythmPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '📊 Biorhythm' : '📊 Biyoritm'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn
            ? 'Enter your birth date to see your physical, emotional, and intellectual cycles.'
            : 'Fiziksel, duygusal ve entelektüel döngülerinizi görmek için doğum tarihinizi girin.'}
        </p>
      </div>
      <BiorhythmClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="biorhythm" locale={locale as string} localePath={localePath} />
    </div>
  );
}
