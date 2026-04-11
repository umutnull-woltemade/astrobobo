/**
 * Personal user profile — birth data + computed sun sign.
 *
 * Persisted in localStorage under a versioned key. This is a pure
 * client-side identity for the Pro homepage; no server auth yet. The
 * shape is kept minimal so migrating to Supabase/auth later requires
 * only a new adapter, not a new type.
 */

import type { ZodiacSlug } from "@/content/zodiac";
import { getSunSignFromDate } from "./sun-sign";

export type UserProfile = {
  /** Optional display name. Empty string means "no name given". */
  name: string;
  /** ISO YYYY-MM-DD. */
  birthDate: string;
  /** Computed at save time from birthDate. */
  sunSign: ZodiacSlug;
  /** ms since epoch when the record was first written. */
  createdAt: number;
  /** ms since epoch of the most recent edit. */
  updatedAt: number;
};

const STORAGE_KEY = "astrobobo.pro.profile.v1";

export function loadProfile(): UserProfile | null {
  if (typeof window === "undefined") return null;
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as UserProfile;
    if (
      !parsed ||
      typeof parsed.birthDate !== "string" ||
      typeof parsed.sunSign !== "string"
    ) {
      return null;
    }
    return parsed;
  } catch {
    return null;
  }
}

export function saveProfile(
  input: Pick<UserProfile, "name" | "birthDate">
): UserProfile | null {
  if (typeof window === "undefined") return null;
  const sunSign = getSunSignFromDate(input.birthDate);
  if (!sunSign) return null;
  const now = Date.now();
  const existing = loadProfile();
  const profile: UserProfile = {
    name: input.name.trim(),
    birthDate: input.birthDate,
    sunSign,
    createdAt: existing?.createdAt ?? now,
    updatedAt: now,
  };
  try {
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify(profile));
    return profile;
  } catch {
    return null;
  }
}

export function clearProfile() {
  if (typeof window === "undefined") return;
  try {
    window.localStorage.removeItem(STORAGE_KEY);
  } catch {
    // ignore
  }
}
