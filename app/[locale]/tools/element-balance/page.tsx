import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import ElementBalanceClient from "./element-balance-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Element Balance — Fire / Earth / Air / Water" : "Element Dengesi — Ateş / Toprak / Hava / Su",
    description: isEn ? "See how fire, earth, air and water are distributed in your birth chart." : "Ateş, toprak, hava ve suyun doğum haritanızdaki dağılımını görün.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Element Balance' : 'Element Dengesi')}`, width: 1200, height: 630 }] },
  };
}
export default async function ElementBalancePage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Element Balance" : "Element Dengesi"} toolSlug="element-balance" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🔥 Element Balance' : '🔥 Element Dengesi'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "How fire, earth, air and water live in your chart." : "Ateş, toprak, hava, suyun haritanızdaki dağılımı."}</p>
    </div>
    <ElementBalanceClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="element-balance" locale={locale as string} localePath={localePath} />
  </div>);
}
