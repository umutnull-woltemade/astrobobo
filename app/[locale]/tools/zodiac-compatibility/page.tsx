import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import CompatibilityClient from "./compatibility-client";
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
    title: isEn ? "Zodiac Compatibility — Love & Friendship Match" : "Burç Uyumu — Aşk & Arkadaşlık",
    description: isEn
      ? "Check zodiac compatibility between two signs. Element harmony, modality dynamics, and relationship insights."
      : "İki burç arasındaki uyumu kontrol edin. Element uyumu, modalite dinamikleri ve ilişki analizleri.",
    openGraph: {
      images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Zodiac Compatibility' : 'Burç Uyumu')}`, width: 1200, height: 630 }],
    },
  };
}

export default async function CompatibilityPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '♥️ Zodiac Compatibility' : '♥️ Burç Uyumu'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? 'Select two zodiac signs to explore their elemental harmony and relationship dynamics.' : 'İki burç seçerek element uyumunu ve ilişki dinamiklerini keşfedin.'}
        </p>
      </div>
      <CompatibilityClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="zodiac-compatibility" locale={locale as string} localePath={localePath} />
    </div>
  );
}
