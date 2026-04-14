import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import ProgressionsClient from "./progressions-client";

interface PageProps { params: Promise<{ locale: string }> }
export async function generateStaticParams() { return locales.map(locale => ({ locale })); }

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const isEn = locale === "en";
  return {
    title: isEn ? "Secondary Progressions — Inner Evolution" : "İkincil Progresyonlar — İçsel Evrim",
    description: isEn
      ? "See how your natal planets have progressed. 1 day = 1 year of inner evolution."
      : "Doğum gezegenlerinizin nasıl ilerlediğini görün. 1 gün = 1 yıl içsel evrim.",
    openGraph: { images: [{ url: `/api/og?title=${encodeURIComponent(isEn ? 'Progressions' : 'Progresyonlar')}`, width: 1200, height: 630 }] },
  };
}

export default async function ProgressionsPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();
  const isEn = locale === "en";
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? '🌀 Secondary Progressions' : '🌀 İkincil Progresyonlar'}
        </h1>
        <p className="text-cosmic-muted max-w-xl mx-auto">
          {isEn ? "Track your inner evolution. 1 day after birth = 1 year of psychological growth." : "İçsel evriminizi takip edin. Doğumdan 1 gün sonrası = 1 yıllık psikolojik büyüme."}
        </p>
      </div>
      <ProgressionsClient locale={isEn ? "en" : "tr"} />
    </div>
  );
}
