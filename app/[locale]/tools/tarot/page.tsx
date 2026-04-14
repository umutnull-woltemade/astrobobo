import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import TarotClient from "./tarot-client";
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
    title: isEn ? "Daily Tarot Card — Pull Your Card" : "Günlük Tarot Kartı — Kartını Çek",
    description: isEn
      ? "Pull a tarot card and discover its meaning. Major Arcana interpretation with cosmic context."
      : "Bir tarot kartı çek ve anlamını keşfet. Major Arcana yorumu kozmik bağlamla.",
    openGraph: {
      images: [{
        url: `/api/og?title=${encodeURIComponent(isEn ? 'Daily Tarot' : 'Günlük Tarot')}&subtitle=${encodeURIComponent(isEn ? 'Pull a card to guide your day' : 'Gününe rehberlik edecek bir kart çek')}`,
        width: 1200,
        height: 630,
      }],
    },
  };
}

export default async function TarotPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🃏 Daily Tarot' : '🃏 Günlük Tarot'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn
            ? 'Focus on a question or simply ask "What do I need to know today?" Then pull your card.'
            : 'Bir soruya odaklan veya basitçe "Bugün ne bilmem gerekiyor?" diye sor. Sonra kartını çek.'}
        </p>
      </div>
      <TarotClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="tarot" locale={locale as string} localePath={localePath} />
    </div>
  );
}
