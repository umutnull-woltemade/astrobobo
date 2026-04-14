import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import CompositeClient from "./composite-client";
interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return { title: isEn ? "Composite Chart" : "Kompozit Harita",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Composite Chart' : 'Kompozit Harita')}`, width: 1200, height: 630 }] } };
}
export default async function CompositePage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🔗 Composite Chart' : '🔗 Kompozit Harita'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Midpoint chart of your relationship." : "İlişkinizin orta nokta haritası."}</p>
    </div>
    <CompositeClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="composite" locale={locale as string} localePath={localePath} />
  </div>);
}
