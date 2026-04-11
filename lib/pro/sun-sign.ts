/**
 * Sun-sign computation from a birth date.
 *
 * Pure, deterministic, tropical zodiac cutoffs matching the Astrobobo
 * content/zodiac corpus. No ephemeris needed — sun-sign boundaries are
 * stable to within a day across decades, and we use the most common
 * cutoff dates. Edge-date users (~1 in 30) may land on the "wrong" side
 * of a cusp but it's close enough for a homepage personalization.
 */

import type { ZodiacSlug } from "@/content/zodiac";

/**
 * Each entry is [fromMonth, fromDay, slug]. A date falls into the sign
 * whose entry is the largest one that's ≤ the date (month-day only).
 * Capricorn wraps the year so it's listed twice.
 */
const CUTOFFS: Array<[number, number, ZodiacSlug]> = [
  [1, 1, "capricorn"],
  [1, 20, "aquarius"],
  [2, 19, "pisces"],
  [3, 21, "aries"],
  [4, 20, "taurus"],
  [5, 21, "gemini"],
  [6, 21, "cancer"],
  [7, 23, "leo"],
  [8, 23, "virgo"],
  [9, 23, "libra"],
  [10, 23, "scorpio"],
  [11, 22, "sagittarius"],
  [12, 22, "capricorn"],
];

/**
 * Return the sun sign for a given date. Accepts `Date` or `YYYY-MM-DD`.
 * Returns `null` if the date is invalid.
 */
export function getSunSignFromDate(
  input: Date | string
): ZodiacSlug | null {
  const date =
    typeof input === "string" ? parseISODate(input) : input;
  if (!date || Number.isNaN(date.getTime())) return null;

  const month = date.getMonth() + 1;
  const day = date.getDate();
  const key = month * 100 + day;

  let match: ZodiacSlug = "capricorn";
  for (const [cm, cd, sign] of CUTOFFS) {
    if (cm * 100 + cd <= key) match = sign;
  }
  return match;
}

/**
 * Parse a `YYYY-MM-DD` string to a local Date. Returns null on failure.
 * Not using `new Date(string)` directly because that interprets as UTC
 * and causes off-by-one days near midnight.
 */
function parseISODate(s: string): Date | null {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(s);
  if (!m) return null;
  const year = Number(m[1]);
  const month = Number(m[2]);
  const day = Number(m[3]);
  if (month < 1 || month > 12 || day < 1 || day > 31) return null;
  const d = new Date(year, month - 1, day);
  if (
    d.getFullYear() !== year ||
    d.getMonth() !== month - 1 ||
    d.getDate() !== day
  ) {
    return null;
  }
  return d;
}
