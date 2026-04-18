import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import MoreTools from "@/components/tools/more-tools";
import ToolBreadcrumbs from "@/components/tools/tool-breadcrumbs";
import SabianClient from "./sabian-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params; if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Sabian Symbols — Your Degree Meanings" : "Sabian Sembolleri — Derece Anlamlarınız",
    description: isEn ? "Discover the Sabian Symbol for your Sun, Moon, and Ascendant degree. Each of the 360 degrees has a unique symbolic image." : "Güneş, Ay ve Yükselen dereceniz için Sabian Sembolünü keşfedin. 360 derecenin her birinin benzersiz sembolik imgesi var.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Sabian Symbols' : 'Sabian Sembolleri')}`, width: 1200, height: 630 }] },
  };
}
export default async function SabianPage({ params }: PageProps) {
  const { locale } = await params; if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en"; const localePath = isEn ? "" : "/" + locale;
  return (<div className="max-w-4xl mx-auto px-4 py-12">
    <ToolBreadcrumbs toolName={isEn ? "Sabian Symbols" : "Sabian Sembolleri"} toolSlug="sabian-symbols" locale={locale as string} />
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">{isEn ? '🔮 Sabian Symbols' : '🔮 Sabian Sembolleri'}</h1>
      <p className="text-cosmic-muted max-w-xl mx-auto">{isEn ? "Each degree of the zodiac holds a symbolic image. Discover yours for Sun, Moon, and Ascendant." : "Burcun her derecesi sembolik bir imge taşır. Güneş, Ay ve Yükselenin için kendininkini keşfedin."}</p>
    </div>
    <SabianClient locale={isEn ? "en" : "tr"} />
    <MoreTools currentSlug="sabian-symbols" locale={locale as string} localePath={localePath} />
  </div>);
}
