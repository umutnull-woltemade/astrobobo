export type Element = "Fire" | "Earth" | "Air" | "Water";
export type Modality = "Cardinal" | "Fixed" | "Mutable";

export interface ZodiacSign {
  slug: string;
  name: string;
  symbol: string;
  dateRange: string;
  element: Element;
  modality: Modality;
  rulingPlanet: string;
  keywords: string[];
  overview: string;
  personality: string;
  strengths: string[];
  growthThemes: string[];
  reflectionPrompts: string[];
  compatibilityNotes: string;
  dailyInspiration: string[];
  cosmicExplanation: string;
}

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

export function isValidZodiacSlug(slug: string): slug is ZodiacSlug {
  return [
    "aries", "taurus", "gemini", "cancer", "leo", "virgo",
    "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces",
  ].includes(slug);
}
