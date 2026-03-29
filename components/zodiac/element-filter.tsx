"use client";

import { useState } from "react";

interface Sign {
  slug: string;
  name: string;
  symbol: string;
  dateRange: string;
  element: string;
  modality: string;
  overview: string;
  keywords: string[];
}

interface ElementFilterProps {
  signs: Sign[];
  localePath: string;
  dict: {
    all: string;
    elements: Record<string, string>;
    modalities: Record<string, string>;
  };
}

export default function ElementFilter({ signs, localePath, dict }: ElementFilterProps) {
  const [activeElement, setActiveElement] = useState<string>("All");

  const filtered = activeElement === "All"
    ? signs
    : signs.filter((s) => s.element === activeElement);

  const elementKeys = ["All", "Fire", "Earth", "Air", "Water"] as const;

  return (
    <>
      {/* Element Filter */}
      <div className="flex justify-center gap-4 mb-12 flex-wrap">
        {elementKeys.map((el) => (
          <button
            key={el}
            onClick={() => setActiveElement(el)}
            className={`zodiac-badge cursor-pointer transition-all ${
              activeElement === el
                ? el === "All"
                  ? "bg-cosmic-accent/20 text-cosmic-accent border-cosmic-accent/50 ring-2 ring-cosmic-accent/20"
                  : `zodiac-${el.toLowerCase()} ring-2 ring-current/20`
                : el === "All"
                  ? "bg-cosmic-accent/5 text-cosmic-accent/60 border-cosmic-accent/20 hover:bg-cosmic-accent/10"
                  : `zodiac-${el.toLowerCase()} opacity-50 hover:opacity-80`
            }`}
          >
            {el === "All" ? dict.all : dict.elements[el]}
          </button>
        ))}
      </div>

      {/* Signs Grid */}
      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        {filtered.map((sign) => (
          <a
            key={sign.slug}
            href={`${localePath}/zodiac/${sign.slug}`}
            className="cosmic-card group"
          >
            <div className="flex items-start justify-between mb-4">
              <div>
                <span className="text-4xl" role="img" aria-label={sign.name}>{sign.symbol}</span>
                <h2 className="text-xl font-display text-cosmic-text group-hover:text-cosmic-accent transition-colors mt-2">
                  {sign.name}
                </h2>
                <p className="text-cosmic-muted text-sm">{sign.dateRange}</p>
              </div>
              <div className="flex flex-col gap-2 items-end">
                <span className={`zodiac-${sign.element.toLowerCase()} zodiac-badge`}>
                  {dict.elements[sign.element]}
                </span>
                <span className="text-cosmic-muted text-xs">{dict.modalities[sign.modality]}</span>
              </div>
            </div>
            <p className="text-cosmic-muted text-sm line-clamp-3">
              {sign.overview}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              {sign.keywords.slice(0, 4).map((kw) => (
                <span
                  key={kw}
                  className="text-xs bg-cosmic-surface px-2 py-1 rounded-md text-cosmic-muted"
                >
                  {kw}
                </span>
              ))}
            </div>
          </a>
        ))}
      </div>
    </>
  );
}
