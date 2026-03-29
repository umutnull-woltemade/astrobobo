// ════════════════════════════════════════════════════════════════════════════
// CURRENT PLANETARY TRANSITS - Updated periodically
// ════════════════════════════════════════════════════════════════════════════
// These represent real astronomical events. Update when planets change signs.
// Saturn changes signs roughly every 2.5 years, Jupiter every ~1 year.
// ════════════════════════════════════════════════════════════════════════════

import { TransitEvent } from "./types";

export const currentTransits: TransitEvent[] = [
  {
    id: "saturn-aries-2025",
    planet: "saturn",
    sign: "aries",
    startDate: "2025-05-25",
    endDate: "2028-02-14",
    isMajor: true,
  },
  {
    id: "jupiter-cancer-2025",
    planet: "jupiter",
    sign: "cancer",
    startDate: "2025-06-09",
    endDate: "2026-06-30",
    isMajor: true,
  },
  {
    id: "uranus-gemini-2025",
    planet: "uranus",
    sign: "gemini",
    startDate: "2025-07-07",
    endDate: "2032-11-07",
    isMajor: true,
  },
  {
    id: "neptune-aries-2025",
    planet: "neptune",
    sign: "aries",
    startDate: "2025-03-30",
    endDate: "2038-10-22",
    isMajor: true,
  },
  {
    id: "pluto-aquarius-2024",
    planet: "pluto",
    sign: "aquarius",
    startDate: "2024-11-19",
    endDate: "2043-03-08",
    isMajor: true,
  },
];
