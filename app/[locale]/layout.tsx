import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";
import "@/styles/globals.css";

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
          "astroloji", "burclar", "dogum haritasi", "burc yorumu",
          "natal harita", "burc uyumu", "astroloji egitimi",
          "kozmik kendini kesfetme", "arketip psikolojisi", "burc kisilik",
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
          url: "/images/og/og-default.png",
          width: 1200,
          height: 630,
          alt: "Astrobobo - Cosmic Self-Discovery",
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: dict.meta.siteTitle,
      description: dict.meta.ogDescription,
      images: ["/images/og/og-default.png"],
      creator: "@astrobobo",
    },
    alternates: {
      canonical: isEn ? "https://astrobobo.com" : "https://astrobobo.com/tr",
      languages: {
        "en-US": "https://astrobobo.com",
        "tr-TR": "https://astrobobo.com/tr",
      },
    },
    verification: {
      google: "GOOGLE_VERIFICATION_ID",
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
      </head>
      <body className="bg-cosmic-bg text-cosmic-text antialiased font-body min-h-screen">
        <nav className="border-b border-cosmic-border bg-cosmic-surface/80 backdrop-blur-md sticky top-0 z-50">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex items-center justify-between h-16">
              <a href={`${localePath}/`} className="text-cosmic-accent font-display text-xl font-bold">
                Astrobobo
              </a>
              <div className="hidden md:flex items-center space-x-8">
                <a href={`${localePath}/zodiac`} className="text-cosmic-muted hover:text-cosmic-text transition-colors">
                  {dict.nav.zodiacSigns}
                </a>
                <a href={`${localePath}/articles`} className="text-cosmic-muted hover:text-cosmic-text transition-colors">
                  {dict.nav.articles}
                </a>
                <a href={`${localePath}/archetype`} className="text-cosmic-muted hover:text-cosmic-text transition-colors">
                  {dict.nav.archetypes}
                </a>
                {/* Language Switcher */}
                <a
                  href={isEn ? "/tr" : "/"}
                  className="text-cosmic-muted hover:text-cosmic-accent transition-colors text-sm border border-cosmic-border rounded-md px-2 py-1"
                >
                  {isEn ? "TR" : "EN"}
                </a>
              </div>
            </div>
          </div>
        </nav>
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
                  <li><a href={`${localePath}/archetype`} className="hover:text-cosmic-text">{dict.nav.archetypes}</a></li>
                </ul>
              </div>
              <div>
                <h4 className="text-cosmic-text font-semibold mb-4">{dict.footer.legal}</h4>
                <ul className="space-y-2 text-sm text-cosmic-muted">
                  <li><a href={`${localePath}/privacy`} className="hover:text-cosmic-text">{dict.footer.privacy}</a></li>
                  <li><a href={`${localePath}/terms`} className="hover:text-cosmic-text">{dict.footer.terms}</a></li>
                  <li><a href={`${localePath}/editorial-policy`} className="hover:text-cosmic-text">{dict.footer.editorial}</a></li>
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
