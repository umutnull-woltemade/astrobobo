import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import ChakraClient from "./chakra-client";
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
    title: isEn ? "Chakra Balance Quiz — Energy Center Analysis" : "Chakra Denge Testi — Enerji Merkezi Analizi",
    description: isEn
      ? "Discover which of your 7 chakras are balanced, overactive, or blocked."
      : "7 chakranızdan hangilerinin dengeli, aşırı aktif veya bloke olduğunu keşfedin.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Chakra Quiz' : 'Chakra Testi')}`, width: 1200, height: 630 }] },
  };
}

export default async function ChakraPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Chakra Balance" : "Chakra Dengesi"} toolSlug="chakra" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🔮 Chakra Balance' : '🔮 Chakra Dengesi'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? "Answer 7 questions to discover your energy center balance." : "Enerji merkezi dengenizi keşfetmek için 7 soruyu yanıtlayın."}
        </p>
      </div>
      <ChakraClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="chakra" locale={locale as string} localePath={localePath} />
    </div>
  );
}
