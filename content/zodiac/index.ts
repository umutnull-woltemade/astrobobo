export type { ZodiacSign, Element, Modality, ZodiacSlug } from "./types";
export { isValidZodiacSlug } from "./types";
export {
  zodiacSigns,
  zodiacSignsBySlug,
  getZodiacSign,
  getAllZodiacSlugs,
} from "./signs";

import type { Locale } from "@/lib/i18n/config";
import type { ZodiacSign } from "./types";
import { zodiacSigns } from "./signs";
import { zodiacSignsTr } from "./signs-tr";

export function getZodiacSigns(locale: Locale): ZodiacSign[] {
  if (locale === "tr") {
    return zodiacSignsTr;
  }
  return zodiacSigns;
}
