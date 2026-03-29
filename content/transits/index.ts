// ════════════════════════════════════════════════════════════════════════════
// TRANSIT ENGINE — Calculates personalized transits for a given sign
// ════════════════════════════════════════════════════════════════════════════

import { currentTransits } from "./current-transits";
import { houseThemes } from "./house-themes";
import { transitInterpretations } from "./interpretations";
import type {
  HouseNumber,
  PersonalTransit,
  Planet,
  ZodiacSlug,
} from "./types";

// Zodiac order for house calculation
const ZODIAC_ORDER: ZodiacSlug[] = [
  "aries",
  "taurus",
  "gemini",
  "cancer",
  "leo",
  "virgo",
  "libra",
  "scorpio",
  "sagittarius",
  "capricorn",
  "aquarius",
  "pisces",
];

/**
 * Calculate which house a transiting planet falls in,
 * based on whole-sign houses from the user's sun sign.
 *
 * Example: If user is Cancer and Saturn is in Aries,
 * Aries is the 10th sign from Cancer → 10th house.
 */
function getHouseForSign(
  userSign: ZodiacSlug,
  transitSign: ZodiacSlug
): HouseNumber {
  const userIndex = ZODIAC_ORDER.indexOf(userSign);
  const transitIndex = ZODIAC_ORDER.indexOf(transitSign);
  const house = ((transitIndex - userIndex + 12) % 12) + 1;
  return house as HouseNumber;
}

/**
 * Get all active transits personalized for a given sun sign.
 * Filters by current date and returns interpretations.
 */
export function getPersonalTransits(
  userSign: ZodiacSlug,
  date: Date = new Date()
): PersonalTransit[] {
  const now = date.getTime();

  return currentTransits
    .filter((transit) => {
      const start = new Date(transit.startDate).getTime();
      const end = new Date(transit.endDate).getTime();
      return now >= start && now <= end && transit.isMajor;
    })
    .map((transit) => {
      const house = getHouseForSign(userSign, transit.sign);
      const theme = houseThemes[house];
      const key =
        `${transit.planet}_${house}` as `${Planet}_${HouseNumber}`;
      const interpretation = transitInterpretations[key];

      return {
        transit,
        house,
        houseTheme: theme,
        interpretation: interpretation ?? null,
      };
    })
    .filter(
      (t): t is PersonalTransit => t.interpretation !== null
    )
    .sort((a, b) => {
      // Prioritize slower planets (more impactful)
      const planetOrder: Planet[] = [
        "pluto",
        "neptune",
        "uranus",
        "saturn",
        "jupiter",
      ];
      return (
        planetOrder.indexOf(a.transit.planet) -
        planetOrder.indexOf(b.transit.planet)
      );
    });
}

/**
 * Get the single most impactful transit for a sign (for the banner).
 */
export function getPrimaryTransit(
  userSign: ZodiacSlug,
  date?: Date
): PersonalTransit | null {
  const transits = getPersonalTransits(userSign, date);
  return transits[0] ?? null;
}

export type { PersonalTransit, ZodiacSlug } from "./types";
