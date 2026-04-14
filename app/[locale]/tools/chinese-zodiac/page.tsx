import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import ChineseZodiacClient from "./chinese-zodiac-client";
import MoreTools from "@/components/tools/more-tools";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Chinese Zodiac — What's Your Animal?" : "Çin Burcu — Hayvanın Hangisi?",
    description: isEn ? "Find your Chinese zodiac animal from your birth year." : "Doğum yılınızdan Çin burcu hayvanınızı bulun.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Chinese Zodiac' : 'Çin Burcu')}`, width: 1200, height: 630 }] },
  };
}
export default async function ChineseZodiacPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🐉 Chinese Zodiac' : '🐉 Çin Burcu'}</h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Enter your birth year to discover your animal sign." : "Hayvan burcunuzu keşfetmek için doğum yılınızı girin."}</p>
      </div>
      <ChineseZodiacClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="chinese-zodiac" locale={locale as string} localePath={localePath} />
    </div>
  );
}
