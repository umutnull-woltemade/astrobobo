import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import SaturnReturnClient from "./saturn-return-client";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return { title: isEn ? "Saturn Return Calculator — When Is Yours?" : "Satürn Dönüşü Hesaplama — Seninki Ne Zaman?",
    description: isEn ? "Calculate your Saturn Return dates — the cosmic coming-of-age at ~29 and ~58." : "Satürn Dönüşü tarihlerinizi hesaplayın — ~29 ve ~58 yaşındaki kozmik olgunlaşma.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Saturn Return' : 'Satürn Dönüşü')}`, width: 1200, height: 630 }] } };
}
export default async function SaturnReturnPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Saturn Return" : "Satürn Dönüşü"} toolSlug="saturn-return" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🪐 Saturn Return' : '🪐 Satürn Dönüşü'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Saturn takes ~29.5 years to orbit the Sun. When it returns to your natal position, a major life chapter begins." : "Satürn Güneş'in etrafında ~29.5 yılda döner. Doğum pozisyonunuza döndüğünde önemli bir yaşam bölümü başlar."}</p>
    </div>
    <SaturnReturnClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="saturn-return" locale={locale as string} localePath={localePath} />
  </div>);
}
