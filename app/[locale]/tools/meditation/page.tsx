import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MeditationClient from "./meditation-client";
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
    title: isEn ? "Cosmic Meditation Timer" : "Kozmik Meditasyon Zamanlayıcı",
    description: isEn ? "Timed meditation with cosmic ambient soundscape." : "Kozmik ortam sesi eşliğinde zamanlı meditasyon.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Meditation' : 'Meditasyon')}`, width: 1200, height: 630 }] },
  };
}
export default async function MeditationPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  const localePath = isEn ? "" : "/" + locale;
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <ToolBreadcrumbs toolName={isEn ? "Cosmic Meditation" : "Kozmik Meditasyon"} toolSlug="meditation" locale={locale as string} />
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🧘 Cosmic Meditation' : '🧘 Kozmik Meditasyon'}</h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Set a timer and breathe. The cosmos holds you." : "Zamanlayıcı kur ve nefes al. Kozmos seni tutuyor."}</p>
      </div>
      <MeditationClient locale={isEn ? "en" : "tr"} />
      <MoreTools currentSlug="meditation" locale={locale as string} localePath={localePath} />
    </div>
  );
}
