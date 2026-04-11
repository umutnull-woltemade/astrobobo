/**
 * useToneOverride — cookie-backed tone A/B testing.
 *
 * Reads the `astrobobo.pro.tone_override` cookie on mount, validates it
 * against the four known tone modes, and writes it into the Pro store's
 * `remoteSignals.overrideTone`. The orchestrator picks it up on the next
 * tick and forces `directive.tone`.
 *
 * Exports a small runtime helper `setToneOverride(mode)` so the app (or
 * a debug tool) can flip tones at runtime — useful for QA and for
 * triggering A/B cohorts from server-injected flags.
 */

"use client";

import { useEffect } from "react";
import { useProStore } from "@/lib/pro/pro-store";
import type { ToneMode } from "@/lib/pro/ai-layout-engine";

const COOKIE_NAME = "astrobobo.pro.tone_override";
const VALID: readonly ToneMode[] = ["calm", "mystical", "direct", "oracle"];

function readCookie(name: string): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(
    new RegExp("(?:^|; )" + name.replace(/[.$?*|{}()[\]\\/+^]/g, "\\$&") + "=([^;]*)")
  );
  return match ? decodeURIComponent(match[1]) : null;
}

function writeCookie(name: string, value: string, days = 30) {
  if (typeof document === "undefined") return;
  const expires = new Date(Date.now() + days * 864e5).toUTCString();
  document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/; SameSite=Lax`;
}

function parseTone(raw: string | null): ToneMode | null {
  if (!raw) return null;
  return VALID.includes(raw as ToneMode) ? (raw as ToneMode) : null;
}

export function useToneOverride() {
  const setRemoteSignals = useProStore((s) => s.setRemoteSignals);

  useEffect(() => {
    const fromCookie = parseTone(readCookie(COOKIE_NAME));
    if (fromCookie) {
      setRemoteSignals({ overrideTone: fromCookie });
    }
  }, [setRemoteSignals]);
}

/** Force a specific tone, persist it in a cookie, push into the store. */
export function setToneOverride(mode: ToneMode | null) {
  if (typeof document === "undefined") return;
  if (mode) {
    writeCookie(COOKIE_NAME, mode);
  } else {
    document.cookie = `${COOKIE_NAME}=; Max-Age=0; path=/`;
  }
  useProStore.getState().setRemoteSignals({ overrideTone: mode });
}
