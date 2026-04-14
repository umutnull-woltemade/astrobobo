import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import SolarReturnClient from "./solar-return-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Solar Return — Your Year Ahead (Swiss Ephemeris)" : "Solar Return — Yılın Haritası (Swiss Ephemeris)",
    description: isEn
      ? "Calculate your Solar Return chart — the moment the Sun returns to its natal position each year."
      : "Solar Return haritanızı hesaplayın — Güneş'in her yıl doğum pozisyonuna döndüğü an.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Solar Return' : 'Solar Return')}`, width: 1200, height: 630 }] },
  };
}

export default async function SolarReturnPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '☀️ Solar Return' : '☀️ Solar Return'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? "Your annual cosmic blueprint — when the Sun returns to its exact birth position." : "Yıllık kozmik planınız — Güneş doğum pozisyonuna döndüğünde."}
        </p>
      </div>
      <SolarReturnClient locale={isEn ? "en" : "tr"} />
    </div>
  );
}
