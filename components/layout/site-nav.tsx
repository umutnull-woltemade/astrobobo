/**
 * Astrobobo — site navigation.
 *
 * Client component so it can read the current pathname and switch to an
 * "immersive" variant on the cinematic homepage. On the homepage we float
 * a minimal transparent bar so the portal entry field stays unbroken; on
 * every other route we render the original solid glass nav.
 */

"use client";

import { usePathname } from "next/navigation";
import LanguageSwitcher from "@/components/language-switcher";

type Dict = {
  zodiacSigns: string;
  articles: string;
  dreams?: string;
  read?: string;
};

export default function SiteNav({
  localePath,
  isEn,
  dict,
}: {
  localePath: string;
  isEn: boolean;
  dict: Dict;
}) {
  const pathname = usePathname() ?? "";
  // Homepage = /en (EN default rendered at root) or /tr (locale root).
  // After locales.includes check upstream, the home path is either
  // "/" (EN) or "/tr" (TR). Also treat the canonical /en as home.
  const isHome = pathname === "/" || pathname === "/tr" || pathname === "/en";

  if (isHome) {
    return (
      <nav className="absolute top-0 left-0 right-0 z-40 pointer-events-none">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <a
              href={`${localePath}/`}
              className="pointer-events-auto font-display text-sm tracking-[0.22em] uppercase"
              style={{
                color: "rgba(245,243,255,0.85)",
                textShadow: "0 0 18px rgba(124,58,237,0.8)",
                fontFamily: "\"Space Grotesk\", Inter, sans-serif",
                fontWeight: 500,
              }}
            >
              Astrobobo
            </a>
            <div className="pointer-events-auto flex items-center gap-4 text-xs tracking-[0.18em] uppercase">
              <a
                href={`${localePath}/zodiac`}
                className="hidden md:inline text-[rgba(245,243,255,0.6)] hover:text-[rgba(245,243,255,0.95)] transition-colors"
              >
                {dict.zodiacSigns}
              </a>
              <a
                href={`${localePath}/articles`}
                className="hidden md:inline text-[rgba(245,243,255,0.6)] hover:text-[rgba(245,243,255,0.95)] transition-colors"
              >
                {dict.articles}
              </a>
              <LanguageSwitcher isEn={isEn} small />
            </div>
          </div>
        </div>
      </nav>
    );
  }

  return (
    <nav className="border-b border-cosmic-border bg-cosmic-surface/80 backdrop-blur-md sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <a
            href={`${localePath}/`}
            className="text-cosmic-accent font-display text-xl font-bold"
          >
            Astrobobo
          </a>

          <div className="hidden md:flex items-center space-x-8">
            <a
              href={`${localePath}/zodiac`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors"
            >
              {dict.zodiacSigns}
            </a>
            <a
              href={`${localePath}/read`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors"
            >
              {dict.articles}
</a>
            <a
              href={`/r/${isEn ? 'en' : 'tr'}`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors"
            >
              {dict.dreams ?? (isEn ? 'Dreams' : 'Rüyalar')}
            </a>
            <LanguageSwitcher isEn={isEn} />
          </div>

          <div className="flex md:hidden items-center space-x-4">
            <a
              href={`${localePath}/zodiac`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors text-sm"
            >
              {dict.zodiacSigns}
            </a>
            <a
              href={`${localePath}/articles`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors text-sm"
            >
              {dict.articles}
            </a>
            <a
              href={`/r/${isEn ? 'en' : 'tr'}`}
              className="text-cosmic-muted hover:text-cosmic-text transition-colors text-sm"
            >
              {dict.dreams ?? (isEn ? 'Dreams' : 'Rüyalar')}
            </a>
            <LanguageSwitcher isEn={isEn} small />
          </div>
        </div>
      </div>
    </nav>
  );
}
