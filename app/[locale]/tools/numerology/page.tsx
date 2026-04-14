import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import NumerologyClient from "./numerology-client";
import MoreTools from "@/components/tools/more-tools";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Life Path Number Calculator" : "Yaşam Yolu Sayısı Hesaplama",
    description: isEn
      ? "Calculate your Life Path Number from your birth date. Discover your core purpose and life theme."
      : "Doğum tarihinizden Yaşam Yolu Sayınızı hesaplayın. Temel amacınızı ve yaşam temanızı keşfedin.",
    openGraph: {
      images: [{
        url: `/api/og?title=${encodeURIComponent(isEn ? 'Life Path Number' : 'Yaşam Yolu Sayısı')}&subtitle=${encodeURIComponent(isEn ? 'Discover your core numerological blueprint' : 'Numerolojik planınızı keşfedin')}`,
        width: 1200,
        height: 630,
      }],
    },
  };
}

export default async function NumerologyPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🔢 Life Path Number' : '🔢 Yaşam Yolu Sayısı'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn
            ? 'Enter your birth date to calculate your Life Path Number — the most important number in numerology.'
            : 'Yaşam Yolu Sayınızı hesaplamak için doğum tarihinizi girin — numerolojideki en önemli sayı.'}
        </p>
      </div>
      <NumerologyClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="numerology" locale={locale as string} localePath={localePath} />
    </div>
  );
}
