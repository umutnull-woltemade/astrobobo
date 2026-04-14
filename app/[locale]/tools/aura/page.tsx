import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import AuraClient from "./aura-client";
import MoreTools from "@/components/tools/more-tools";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return {
    title: isEn ? "Aura Color Reading — Discover Your Energy Color" : "Aura Rengi — Enerji Rengini Keşfet",
    description: isEn ? "Answer 5 questions to discover your dominant aura color." : "Baskın aura rengini keşfetmek için 5 soruyu yanıtla.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Aura Reading' : 'Aura Okuma')}`, width: 1200, height: 630 }] },
  };
}
export default async function AuraPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '✨ Aura Reading' : '✨ Aura Okuma'}</h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Choose what resonates with you to reveal your aura color." : "Sana en yakın hissettiren seçenekleri seç, aura rengini ortaya çıkar."}</p>
      </div>
      <AuraClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="aura" locale={locale as string} localePath={localePath} />
    </div>
  );
}
