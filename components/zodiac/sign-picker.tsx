"use client";

import { useState, useEffect } from "react";

interface Sign {
  slug: string;
  name: string;
  symbol: string;
  dateRange: string;
  element: string;
  overview: string;
  dailyInspiration: string[];
  keywords: string[];
}

interface SignPickerProps {
  signs: Sign[];
  localePath: string;
  dict: {
    pickYourSign: string;
    yourSign: string;
    browseOthers: string;
    todayInspiration: string;
    readFullProfile: string;
    changeSign: string;
    selectBelow: string;
    elements: Record<string, string>;
  };
}

const STORAGE_KEY = "astrobobo_my_sign";

export default function SignPicker({ signs, localePath, dict }: SignPickerProps) {
  const [mySign, setMySign] = useState<string | null>(null);
  const [showPicker, setShowPicker] = useState(false);

  useEffect(() => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved && signs.some((s) => s.slug === saved)) {
      setMySign(saved);
    }
  }, [signs]);

  function selectSign(slug: string) {
    setMySign(slug);
    localStorage.setItem(STORAGE_KEY, slug);
    setShowPicker(false);
  }

  const selected = mySign ? signs.find((s) => s.slug === mySign) : null;
  const others = signs.filter((s) => s.slug !== mySign);

  // Daily inspiration based on day of year
  const dayOfYear = Math.floor(
    (Date.now() - new Date(new Date().getFullYear(), 0, 0).getTime()) / 86400000
  );

  if (!mySign || showPicker) {
    return (
      <section className="max-w-7xl mx-auto px-4 py-16">
        <div className="text-center mb-10">
          <h2 className="cosmic-heading text-3xl mb-3">{dict.pickYourSign}</h2>
          <p className="text-cosmic-muted">{dict.selectBelow}</p>
        </div>
        <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-6 gap-4">
          {signs.map((sign) => (
            <button
              key={sign.slug}
              onClick={() => selectSign(sign.slug)}
              className={`cosmic-card text-center cursor-pointer hover:border-cosmic-accent/50 transition-all ${
                mySign === sign.slug ? "border-cosmic-accent ring-2 ring-cosmic-accent/20" : ""
              }`}
            >
              <div className="text-4xl mb-2">{sign.symbol}</div>
              <div className="text-cosmic-text font-display text-sm">{sign.name}</div>
              <div className="text-cosmic-muted text-xs mt-1">{sign.dateRange}</div>
            </button>
          ))}
        </div>
      </section>
    );
  }

  return (
    <>
      {/* My Sign Section */}
      {selected && (
        <section className="max-w-7xl mx-auto px-4 py-16">
          <div className="flex items-center justify-between mb-8">
            <h2 className="cosmic-heading text-3xl">{dict.yourSign}</h2>
            <button
              onClick={() => setShowPicker(true)}
              className="text-cosmic-muted hover:text-cosmic-accent text-sm transition-colors border border-cosmic-border rounded-md px-3 py-1"
            >
              {dict.changeSign}
            </button>
          </div>

          {/* My Sign Card - Featured */}
          <div className="cosmic-card border-cosmic-accent/30 mb-8">
            <div className="flex flex-col md:flex-row gap-6">
              <div className="text-center md:text-left">
                <div className="text-6xl mb-2">{selected.symbol}</div>
                <h3 className="text-2xl font-display text-cosmic-accent">{selected.name}</h3>
                <p className="text-cosmic-muted text-sm">{selected.dateRange}</p>
                <span className={`zodiac-${selected.element.toLowerCase()} zodiac-badge mt-2 inline-block`}>
                  {dict.elements[selected.element]}
                </span>
              </div>
              <div className="flex-1">
                {/* Daily Inspiration */}
                <div className="bg-cosmic-surface rounded-xl p-4 mb-4">
                  <h4 className="text-cosmic-accent font-display text-sm mb-2">{dict.todayInspiration}</h4>
                  <blockquote className="text-cosmic-text/80 italic border-l-4 border-cosmic-accent/50 pl-3">
                    {selected.dailyInspiration[dayOfYear % selected.dailyInspiration.length]}
                  </blockquote>
                </div>
                <p className="text-cosmic-muted text-sm line-clamp-3 mb-4">{selected.overview}</p>
                <a
                  href={`${localePath}/zodiac/${selected.slug}`}
                  className="text-cosmic-accent text-sm hover:underline"
                >
                  {dict.readFullProfile} &rarr;
                </a>
              </div>
            </div>
          </div>

          {/* Browse Other Signs */}
          <h3 className="cosmic-heading text-xl mb-6">{dict.browseOthers}</h3>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
            {others.map((sign) => (
              <a
                key={sign.slug}
                href={`${localePath}/zodiac/${sign.slug}`}
                className="cosmic-card text-center group py-4"
              >
                <div className="text-3xl mb-2">{sign.symbol}</div>
                <h4 className="text-cosmic-text font-display text-sm group-hover:text-cosmic-accent transition-colors">
                  {sign.name}
                </h4>
                <p className="text-cosmic-muted text-xs mt-1">{sign.dateRange}</p>
                <span className={`zodiac-${sign.element.toLowerCase()} zodiac-badge mt-2 text-xs`}>
                  {dict.elements[sign.element]}
                </span>
              </a>
            ))}
          </div>
        </section>
      )}
    </>
  );
}
