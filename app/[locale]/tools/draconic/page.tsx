import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import DraconicClient from "./draconic-client";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return { title: isEn ? "Draconic Chart — Soul-Level Blueprint" : "Drakonik Harita — Ruh Düzeyi Planı",
    description: isEn ? "Your draconic chart reveals soul patterns. Based on the North Node." : "Drakonik haritanız ruh kalıplarını ortaya çıkarır. Kuzey Düğümüne dayanır.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Draconic Chart' : 'Drakonik Harita')}`, width: 1200, height: 630 }] } };
}
export default async function DraconicPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Draconic Chart" : "Drakonik Harita"} toolSlug="draconic" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🐉 Draconic Chart' : '🐉 Drakonik Harita'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Subtract the North Node from each planet to reveal soul-level positions." : "Her gezegenden Kuzey Düğümünü çıkararak ruh düzeyi pozisyonlarını ortaya çıkarın."}</p>
    </div>
    <DraconicClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="draconic" locale={locale as string} localePath={localePath} />
  </div>);
}
