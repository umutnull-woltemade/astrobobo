import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import MoonSignClient from "./moon-sign-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Moon Sign Calculator — What Is My Moon Sign?" : "Ay Burcu Hesaplama — Ay Burcum Ne?",
    description: isEn ? "Calculate your natal Moon sign with Swiss Ephemeris. Your emotional core, instincts, and inner self." : "Swiss Ephemeris ile doğum Ay burcunuzu hesaplayın. Duygusal çekirdeğiniz, içgüdüleriniz ve iç benliğiniz.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Moon Sign Calculator' : 'Ay Burcu Hesaplama')}`, width: 1200, height: 630 }] },
  };
}
export default async function MoonSignPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Moon Sign" : "Ay Burcu"} toolSlug="moon-sign-calculator" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🌙 Moon Sign Calculator' : '🌙 Ay Burcu Hesaplama'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Your Moon sign reveals your emotional nature — how you feel, what you need, your instinctive self." : "Ay burcun duygusal doğanı ortaya koyar — nasıl hissedersin, neye ihtiyacın var, içgüdüsel benliğin."}</p>
    </div>
    <MoonSignClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="moon-sign-calculator" locale={locale as string} localePath={localePath} />
  </div>);
}
