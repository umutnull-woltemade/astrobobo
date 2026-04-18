"use client";
import { create } from "zustand";
import { persist } from "zustand/middleware";

export interface BirthData {
  date: string;       // YYYY-MM-DD
  time: string;       // HH:MM (local to birth place)
  lat: number;
  lng: number;
  tz: string;         // IANA zone, e.g. "Europe/Istanbul"
  placeName: string;  // "Istanbul, Türkiye"
}

interface BirthDataState {
  data: BirthData | null;
  set: (d: BirthData) => void;
  clear: () => void;
  hasData: () => boolean;
}

export const useBirthData = create<BirthDataState>()(
  persist(
    (set, get) => ({
      data: null,
      set: (d) => set({ data: d }),
      clear: () => set({ data: null }),
      hasData: () => {
        const d = get().data;
        return !!(d && d.date && d.time && typeof d.lat === "number" && typeof d.lng === "number");
      },
    }),
    { name: "astrobobo-birth-data" }
  )
);

/** Build URL query string from birth data for API calls */
export function birthDataQuery(d: BirthData, lang: string = "en"): string {
  const p = new URLSearchParams({
    date: d.date,
    time: d.time,
    lat: String(d.lat),
    lng: String(d.lng),
    tz: d.tz,
    lang,
  });
  return p.toString();
}
