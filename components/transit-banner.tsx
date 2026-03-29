"use client";

import { useState, useEffect } from "react";
import type { PersonalTransit, ZodiacSlug } from "@/content/transits";

// Planet display info
const PLANET_INFO: Record<
  string,
  { symbol: string; nameEn: string; nameTr: string }
> = {
  saturn: { symbol: "🪐", nameEn: "Saturn", nameTr: "Satürn" },
  jupiter: { symbol: "♃", nameEn: "Jupiter", nameTr: "Jüpiter" },
  uranus: { symbol: "♅", nameEn: "Uranus", nameTr: "Uranüs" },
  neptune: { symbol: "♆", nameEn: "Neptune", nameTr: "Neptün" },
  pluto: { symbol: "♇", nameEn: "Pluto", nameTr: "Plüton" },
  mars: { symbol: "♂", nameEn: "Mars", nameTr: "Mars" },
  venus: { symbol: "♀", nameEn: "Venus", nameTr: "Venüs" },
  mercury: { symbol: "☿", nameEn: "Mercury", nameTr: "Merkür" },
};

const SIGN_SYMBOLS: Record<string, string> = {
  aries: "♈",
  taurus: "♉",
  gemini: "♊",
  cancer: "♋",
  leo: "♌",
  virgo: "♍",
  libra: "♎",
  scorpio: "♏",
  sagittarius: "♐",
  capricorn: "♑",
  aquarius: "♒",
  pisces: "♓",
};

const SIGN_NAMES_TR: Record<string, string> = {
  aries: "Koç",
  taurus: "Boğa",
  gemini: "İkizler",
  cancer: "Yengeç",
  leo: "Aslan",
  virgo: "Başak",
  libra: "Terazi",
  scorpio: "Akrep",
  sagittarius: "Yay",
  capricorn: "Oğlak",
  aquarius: "Kova",
  pisces: "Balık",
};

interface TransitBannerProps {
  transits: Array<{
    planet: string;
    sign: string;
    house: number;
    houseThemeEn: string;
    houseThemeTr: string;
    titleEn: string;
    titleTr: string;
    bodyEn: string;
    bodyTr: string;
    keywordsEn: string[];
    keywordsTr: string[];
    durationEn: string;
    durationTr: string;
  }>;
  allSignTransits: Record<
    string,
    Array<{
      planet: string;
      sign: string;
      house: number;
      houseThemeEn: string;
      houseThemeTr: string;
      titleEn: string;
      titleTr: string;
      bodyEn: string;
      bodyTr: string;
      keywordsEn: string[];
      keywordsTr: string[];
      durationEn: string;
      durationTr: string;
    }>
  >;
  isEn: boolean;
}

const STORAGE_KEY = "astrobobo_my_sign";

export default function TransitBanner({
  transits: initialTransits,
  allSignTransits,
  isEn,
}: TransitBannerProps) {
  const [mySign, setMySign] = useState<string | null>(null);
  const [expanded, setExpanded] = useState(false);
  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved) setMySign(saved);
  }, []);

  const transits = mySign
    ? allSignTransits[mySign] ?? initialTransits
    : initialTransits;

  if (!transits || transits.length === 0) return null;

  const primary = transits[activeIndex] ?? transits[0];
  const planet = PLANET_INFO[primary.planet];
  const signSymbol = SIGN_SYMBOLS[primary.sign] ?? "";
  const signName = isEn
    ? primary.sign.charAt(0).toUpperCase() + primary.sign.slice(1)
    : SIGN_NAMES_TR[primary.sign] ?? primary.sign;

  return (
    <section className="relative overflow-hidden">
      {/* Ambient glow background */}
      <div className="absolute inset-0 bg-gradient-to-r from-cosmic-purple/20 via-cosmic-card to-cosmic-purple/10" />
      <div className="absolute top-0 left-1/4 w-96 h-96 bg-cosmic-purple/10 rounded-full blur-3xl animate-pulse-slow" />
      <div
        className="absolute bottom-0 right-1/4 w-64 h-64 bg-cosmic-accent/5 rounded-full blur-3xl animate-pulse-slow"
        style={{ animationDelay: "2s" }}
      />

      <div className="relative max-w-5xl mx-auto px-4 py-8 sm:py-10">
        {/* Header line */}
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-2">
            <span className="text-cosmic-accent text-xs font-medium uppercase tracking-widest">
              {isEn ? "Current Transits" : "Güncel Transitler"}
            </span>
            {mySign && (
              <span className="text-cosmic-muted text-xs">
                {isEn ? "for" : "—"} {SIGN_SYMBOLS[mySign]}{" "}
                {isEn
                  ? mySign.charAt(0).toUpperCase() + mySign.slice(1)
                  : SIGN_NAMES_TR[mySign]}
              </span>
            )}
          </div>

          {/* Transit dots (pagination) */}
          {transits.length > 1 && (
            <div className="flex gap-1.5">
              {transits.map((_, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setActiveIndex(i);
                    setExpanded(false);
                  }}
                  className={`w-2 h-2 rounded-full transition-all ${
                    i === activeIndex
                      ? "bg-cosmic-accent w-6"
                      : "bg-cosmic-border hover:bg-cosmic-muted"
                  }`}
                  aria-label={`Transit ${i + 1}`}
                />
              ))}
            </div>
          )}
        </div>

        {/* Main transit card */}
        <div
          className="cursor-pointer group"
          onClick={() => setExpanded(!expanded)}
        >
          {/* Planet + Sign header */}
          <div className="flex items-center gap-4 mb-3">
            <div className="flex items-center gap-2 text-3xl sm:text-4xl">
              <span>{planet?.symbol}</span>
              <span className="text-cosmic-muted text-lg">→</span>
              <span>{signSymbol}</span>
            </div>
            <div>
              <h3 className="text-cosmic-text font-display text-lg sm:text-xl leading-tight">
                {isEn ? primary.titleEn : primary.titleTr}
              </h3>
              <p className="text-cosmic-muted text-xs mt-0.5">
                {planet?.symbol}{" "}
                {isEn ? planet?.nameEn : planet?.nameTr}{" "}
                {isEn ? "in" : ""} {signSymbol} {signName}{" "}
                → {isEn ? `${primary.house}${getOrdinalSuffix(primary.house)} House` : `${primary.house}. Ev`}{" "}
                · {isEn ? primary.houseThemeEn : primary.houseThemeTr}
              </p>
            </div>
          </div>

          {/* Summary line (always visible) */}
          <p
            className={`text-cosmic-text/80 text-sm leading-relaxed transition-all ${
              expanded ? "" : "line-clamp-2"
            }`}
          >
            {isEn ? primary.bodyEn : primary.bodyTr}
          </p>

          {/* Expanded details */}
          {expanded && (
            <div className="mt-4 space-y-3 animate-in fade-in duration-300">
              {/* Keywords */}
              <div className="flex flex-wrap gap-2">
                {(isEn ? primary.keywordsEn : primary.keywordsTr).map(
                  (kw: string) => (
                    <span
                      key={kw}
                      className="text-xs px-2.5 py-1 rounded-full bg-cosmic-purple/20 text-cosmic-accent-soft border border-cosmic-purple/30"
                    >
                      {kw}
                    </span>
                  )
                )}
              </div>

              {/* Duration */}
              <p className="text-cosmic-muted text-xs">
                ⏱{" "}
                {isEn ? "Duration" : "Süre"}:{" "}
                {isEn ? primary.durationEn : primary.durationTr}
              </p>
            </div>
          )}

          {/* Expand hint */}
          <div className="flex items-center justify-center mt-3">
            <span className="text-cosmic-muted text-xs group-hover:text-cosmic-accent transition-colors">
              {expanded
                ? isEn
                  ? "▲ Less"
                  : "▲ Kapat"
                : isEn
                  ? "▼ Read more"
                  : "▼ Devamını oku"}
            </span>
          </div>
        </div>
      </div>
    </section>
  );
}

function getOrdinalSuffix(n: number): string {
  if (n === 1) return "st";
  if (n === 2) return "nd";
  if (n === 3) return "rd";
  return "th";
}
