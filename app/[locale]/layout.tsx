import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import "@/styles/globals.css";
import SiteNav from "@/components/layout/site-nav";
import { WebVitals } from "@/app/web-vitals";

interface LayoutProps {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}

export async function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: { params: Promise<{ locale: string }> }): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";

  return {
    metadataBase: new URL("https://astrobobo.com"),
    title: {
      default: dict.meta.siteTitle,
      template: "%s | Astrobobo",
    },
    description: dict.meta.siteDescription,
    keywords: isEn
      ? [
          "astrology", "zodiac signs", "birth chart", "horoscope",
          "natal chart", "zodiac compatibility", "astrology education",
          "cosmic self-discovery", "archetype psychology", "zodiac personality",
        ]
      : [
          "astroloji", "burçlar", "doğum haritası", "burç yorumu",
          "natal harita", "burç uyumu", "astroloji eğitimi",
          "kozmik kendini keşfetme", "arketip psikolojisi", "burç kişilik",
        ],
    authors: [{ name: "Astrobobo" }],
    creator: "Astrobobo",
    publisher: "Astrobobo",
    robots: {
      index: true,
      follow: true,
      googleBot: {
        index: true,
        follow: true,
        "max-video-preview": -1,
        "max-image-preview": "large",
        "max-snippet": -1,
      },
    },
    openGraph: {
      type: "website",
      locale: isEn ? "en_US" : "tr_TR",
      alternateLocale: isEn ? "tr_TR" : "en_US",
      url: isEn ? "https://astrobobo.com" : "https://astrobobo.com/tr",
      siteName: "Astrobobo",
      title: dict.meta.siteTitle,
      description: dict.meta.ogDescription,
      images: [
        {
          url: `/api/og?title=${encodeURIComponent(dict.meta.siteTitle)}&subtitle=${encodeURIComponent(dict.meta.ogDescription?.slice(0, 100) || '')}`,
          width: 1200,
          height: 630,
          alt: isEn ? "Astrobobo - Cosmic Self-Discovery" : "Astrobobo - Kozmik Kendini Keşfetme",
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: dict.meta.siteTitle,
      description: dict.meta.ogDescription,
      images: [`/api/og?title=${encodeURIComponent(dict.meta.siteTitle)}`],
      creator: "@astrobobo",
    },
    alternates: {
      canonical: isEn ? "https://astrobobo.com" : "https://astrobobo.com/tr",
      languages: {
        "en-US": "https://astrobobo.com",
        "tr-TR": "https://astrobobo.com/tr",
      },
    },
  };
}

export default async function LocaleLayout({ children, params }: LayoutProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";
  const localePath = isEn ? "" : `/${locale}`;

  return (
    <html lang={locale} className="dark">
      <head>
        <link rel="icon" href="/favicon.ico" sizes="any" />
        <link rel="icon" href="/images/icons/icon.svg" type="image/svg+xml" />
        <link rel="apple-touch-icon" href="/images/icons/apple-touch-icon.png" />
        <link rel="manifest" href="/manifest.json" />
        <meta name="theme-color" content="#0D0D1A" />
        {/* Plausible Analytics — cookie-free, privacy-first */}
        <script defer data-domain="astrobobo.com" src="https://plausible.io/js/script.js" />
        {/* DNS prefetch for OG image edge function */}
        <link rel="dns-prefetch" href="https://astrobobo.com" />
      </head>
      <body className="bg-cosmic-bg text-cosmic-text antialiased font-body min-h-screen">
        <WebVitals />
        <SiteNav
          localePath={localePath}
          isEn={isEn}
          dict={{
            zodiacSigns: dict.nav.zodiacSigns,
            articles: dict.nav.articles,
          }}
        />
        <main>{children}</main>
        <footer className="border-t border-cosmic-border bg-cosmic-surface mt-auto py-12">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div>
                <h3 className="text-cosmic-accent font-display text-lg mb-4">Astrobobo</h3>
                <p className="text-cosmic-muted text-sm">{dict.footer.tagline}</p>
              </div>
              <div>
                <h4 className="text-cosmic-text font-semibold mb-4">{dict.footer.explore}</h4>
                <ul className="space-y-2 text-sm text-cosmic-muted">
                  <li><a href={`${localePath}/zodiac`} className="hover:text-cosmic-text">{dict.nav.zodiacSigns}</a></li>
                  <li><a href={`${localePath}/articles`} className="hover:text-cosmic-text">{dict.nav.articles}</a></li>
                  <li><a href={`/r/${isEn ? 'en' : locale}`} className="hover:text-cosmic-text">{isEn ? 'Dream Dictionary' : 'Rüya Tabiri'}</a></li>
                </ul>
              </div>
              <div>
                <h4 className="text-cosmic-text font-semibold mb-4">{dict.footer.legal}</h4>
                <ul className="space-y-2 text-sm text-cosmic-muted">
                  <li><a href={`${localePath}/privacy`} className="hover:text-cosmic-text">{dict.footer.privacy}</a></li>
                  <li><a href={`${localePath}/terms`} className="hover:text-cosmic-text">{dict.footer.terms}</a></li>
                </ul>
              </div>
            </div>
            <div className="mt-8 pt-8 border-t border-cosmic-border text-center text-cosmic-muted text-xs">
              <p>{dict.footer.disclaimer}</p>
              <p className="mt-2">&copy; {new Date().getFullYear()} {dict.footer.copyright}</p>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
