/**
 * Astrobobo Web Pro — cohort engine.
 *
 * A tiny, self-contained cohort layer that can stand in for GrowthBook /
 * PostHog until one of them is wired. Resolves the active cohort from
 * (in priority order):
 *
 *   1. `?cohort=<slug>` URL param  — sticks via cookie on first hit
 *   2. `astrobobo.pro.cohort` cookie
 *   3. `NEXT_PUBLIC_PRO_COHORT` build-time env
 *
 * A `cohortConfig` map translates a cohort slug into a `RemoteSignals`
 * patch. The orchestrator will see the patch within one RAF tick and the
 * directive is updated accordingly.
 *
 * No imports from @/lib/i18n, React, or Next — this file runs in the
 * browser and on the edge. Consumers hook it up via `useCohort()`.
 */

import type { ToneMode } from "@astrobobo/pro-tone";
import type { RemoteSignals } from "./pro-store";

const COOKIE_NAME = "astrobobo.pro.cohort";
const REMOTE_CACHE_TTL_MS = 5 * 60 * 1000;

/**
 * Cohort → signal patch map. Extend this inline when a new experiment
 * launches. Keep entries small — a cohort is one knob, not a page
 * redesign. Prefer adding new keys over mutating existing ones so
 * historical cohorts remain reproducible.
 */
export const cohortConfig: Record<string, Partial<RemoteSignals>> = {
  // Forces everyone in this cohort into the mystical voice regardless of
  // behavior. Used as the tone A/B baseline.
  whisper: { overrideTone: "mystical" satisfies ToneMode },
  // Terse / task-focused voice for a "get in, get out" experiment.
  "direct-beta": { overrideTone: "direct" satisfies ToneMode },
  // Power-user unlock test — forces oracle mode even for new visitors so
  // we can measure whether depth-first onboarding beats progressive reveal.
  "oracle-first": { overrideTone: "oracle" satisfies ToneMode, cohortCtr: 0.08 },
};

/**
 * Runtime cohort map. Seeded with `cohortConfig` and mutated in place by
 * `loadRemoteCohortConfig()` so `resolveCohort()` stays synchronous. When
 * a remote source defines a cohort that also exists locally, the remote
 * definition wins — this is how you hot-flip a live experiment.
 */
let runtimeCohortConfig: Record<string, Partial<RemoteSignals>> = {
  ...cohortConfig,
};

let remoteLoadedAt = 0;
let remoteLoadPromise: Promise<void> | null = null;

/**
 * Fetch a remote cohort map from a JSON endpoint and merge it on top of
 * the static `cohortConfig`. Idempotent: concurrent calls share a single
 * in-flight promise, and the cache is valid for REMOTE_CACHE_TTL_MS so a
 * hot reload doesn't hammer the endpoint.
 *
 * Endpoint contract: the server must return a JSON object shaped like
 *
 *     {
 *       "whisper":      { "overrideTone": "mystical" },
 *       "oracle-first": { "overrideTone": "oracle", "cohortCtr": 0.08 }
 *     }
 *
 * Any field not present in `RemoteSignals` is ignored silently. Unknown
 * cohorts are added. Known cohorts are overwritten.
 *
 * GrowthBook / PostHog integration:
 * -----------------------------------------------------
 * Neither provider returns this shape directly — each uses its own
 * feature-flag schema. The clean integration is a tiny server route that
 * proxies the upstream response into the JSON contract above:
 *
 *     // app/api/pro-cohorts/route.ts
 *     import { growthbook } from "@/lib/growthbook";
 *     export async function GET() {
 *       const features = await growthbook.fetchFeatures();
 *       return Response.json(translateFeaturesToCohortMap(features));
 *     }
 *
 * Then point NEXT_PUBLIC_PRO_COHORT_URL at `/api/pro-cohorts`. Swapping
 * providers becomes a server-side concern — this file never changes.
 */
export async function loadRemoteCohortConfig(
  url: string | undefined = process.env.NEXT_PUBLIC_PRO_COHORT_URL
): Promise<void> {
  if (!url) return;
  if (Date.now() - remoteLoadedAt < REMOTE_CACHE_TTL_MS) return;
  if (remoteLoadPromise) return remoteLoadPromise;

  remoteLoadPromise = (async () => {
    try {
      const res = await fetch(url, { cache: "no-store" });
      if (!res.ok) return;
      const raw = (await res.json()) as unknown;
      if (!raw || typeof raw !== "object") return;
      const merged: Record<string, Partial<RemoteSignals>> = { ...cohortConfig };
      for (const [slug, value] of Object.entries(raw as Record<string, unknown>)) {
        if (value && typeof value === "object") {
          merged[slug] = sanitizePatch(value as Record<string, unknown>);
        }
      }
      runtimeCohortConfig = merged;
      remoteLoadedAt = Date.now();
    } catch {
      // swallow — we fall back to the static map
    } finally {
      remoteLoadPromise = null;
    }
  })();
  return remoteLoadPromise;
}

function sanitizePatch(raw: Record<string, unknown>): Partial<RemoteSignals> {
  const patch: Partial<RemoteSignals> = {};
  if (
    typeof raw.overrideTone === "string" &&
    ["calm", "mystical", "direct", "oracle"].includes(raw.overrideTone)
  ) {
    patch.overrideTone = raw.overrideTone as ToneMode;
  }
  if (typeof raw.cohortCtr === "number" && Number.isFinite(raw.cohortCtr)) {
    patch.cohortCtr = raw.cohortCtr;
  }
  return patch;
}

/** Test hook — wipes the runtime cache so a test can reseed it. */
export function __resetRuntimeCohortConfig() {
  runtimeCohortConfig = { ...cohortConfig };
  remoteLoadedAt = 0;
  remoteLoadPromise = null;
}

export type CohortResolution = {
  cohort: string | null;
  source: "url" | "cookie" | "env" | "none";
  patch: Partial<RemoteSignals>;
};

function readCookie(name: string): string | null {
  if (typeof document === "undefined") return null;
  const escaped = name.replace(/[.$?*|{}()[\]\\/+^]/g, "\\$&");
  const match = document.cookie.match(
    new RegExp("(?:^|; )" + escaped + "=([^;]*)")
  );
  return match ? decodeURIComponent(match[1]) : null;
}

function writeCookie(name: string, value: string, days = 60) {
  if (typeof document === "undefined") return;
  const expires = new Date(Date.now() + days * 864e5).toUTCString();
  document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/; SameSite=Lax`;
}

function readUrlCohort(): string | null {
  if (typeof window === "undefined") return null;
  try {
    const url = new URL(window.location.href);
    const value = url.searchParams.get("cohort");
    return value?.trim() || null;
  } catch {
    return null;
  }
}

function readEnvCohort(): string | null {
  const value = process.env.NEXT_PUBLIC_PRO_COHORT;
  return value?.trim() || null;
}

/**
 * Resolve the active cohort. Side effect: when resolved from the URL,
 * persists the cohort to a cookie so subsequent navigations stick without
 * repeatedly appending the query param.
 */
export function resolveCohort(): CohortResolution {
  const map = runtimeCohortConfig;

  const fromUrl = readUrlCohort();
  if (fromUrl) {
    writeCookie(COOKIE_NAME, fromUrl);
    return {
      cohort: fromUrl,
      source: "url",
      patch: map[fromUrl] ?? {},
    };
  }

  const fromCookie = readCookie(COOKIE_NAME);
  if (fromCookie) {
    return {
      cohort: fromCookie,
      source: "cookie",
      patch: map[fromCookie] ?? {},
    };
  }

  const fromEnv = readEnvCohort();
  if (fromEnv) {
    return {
      cohort: fromEnv,
      source: "env",
      patch: map[fromEnv] ?? {},
    };
  }

  return { cohort: null, source: "none", patch: {} };
}

/** Manual override — flips the cookie, clears when passed null. */
export function setCohort(cohort: string | null) {
  if (typeof document === "undefined") return;
  if (cohort) {
    writeCookie(COOKIE_NAME, cohort);
  } else {
    document.cookie = `${COOKIE_NAME}=; Max-Age=0; path=/`;
  }
}
