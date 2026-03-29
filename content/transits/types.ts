// ════════════════════════════════════════════════════════════════════════════
// TRANSIT SYSTEM TYPES
// ════════════════════════════════════════════════════════════════════════════

export type Planet =
  | "saturn"
  | "jupiter"
  | "mars"
  | "venus"
  | "mercury"
  | "sun"
  | "moon"
  | "uranus"
  | "neptune"
  | "pluto";

export type ZodiacSlug =
  | "aries"
  | "taurus"
  | "gemini"
  | "cancer"
  | "leo"
  | "virgo"
  | "libra"
  | "scorpio"
  | "sagittarius"
  | "capricorn"
  | "aquarius"
  | "pisces";

export type HouseNumber = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12;

export interface TransitEvent {
  id: string;
  planet: Planet;
  sign: ZodiacSlug;
  /** When this transit started */
  startDate: string;
  /** When this transit ends */
  endDate: string;
  /** Is this a major slow-moving transit worth highlighting? */
  isMajor: boolean;
  /** Optional: aspect to another planet (conjunction, square, etc.) */
  aspect?: {
    type: "conjunction" | "opposition" | "square" | "trine" | "sextile";
    targetPlanet: Planet;
    targetSign: ZodiacSlug;
  };
}

export interface HouseTheme {
  en: string;
  tr: string;
}

export interface TransitInterpretation {
  /** Short title */
  titleEn: string;
  titleTr: string;
  /** Detailed interpretation paragraph */
  bodyEn: string;
  bodyTr: string;
  /** Keywords/tags */
  keywordsEn: string[];
  keywordsTr: string[];
  /** Duration hint */
  durationEn: string;
  durationTr: string;
}

export interface PersonalTransit {
  transit: TransitEvent;
  house: HouseNumber;
  houseTheme: HouseTheme;
  interpretation: TransitInterpretation;
}
