/**
 * @astrobobo/pro-tone — shared tone engine contract.
 *
 * This file is the single source of truth for the four tone modes used by
 * Astrobobo Web Pro and Covara. It is deliberately standalone — no Next,
 * React, Zustand, Supabase, or astrobobo-web imports — so it can be
 * consumed from:
 *
 *   1. Astrobobo Web Pro (re-exported via lib/pro/tone-bridge.ts)
 *   2. Covara (Expo/RN) — import directly or copy the file into src/tone
 *   3. Any future surface that needs the same vocabulary
 *
 * Publishing plan (when the private registry is wired):
 *
 *   cd packages/pro-tone
 *   npm publish --access=restricted
 *
 * Until then, consumers either import via the workspace alias or copy the
 * file. The validateToneContract() self-check is suitable for CI to catch
 * drift between copies.
 */

// ─────────────────────────────────────────────────────────────────────────
// Tone modes

export type ToneMode = "calm" | "mystical" | "direct" | "oracle";

export const TONE_MODES: readonly ToneMode[] = [
  "calm",
  "mystical",
  "direct",
  "oracle",
] as const;

/**
 * Covara's own tone enum. Covara modes are intentionally a separate type
 * so both sides can evolve independently — the bridge mappers translate.
 *
 *   soft   ↔ calm
 *   poetic ↔ mystical
 *   crisp  ↔ direct
 *   expert ↔ oracle
 */
export type CovaraToneMode = "soft" | "poetic" | "crisp" | "expert";

export const COVARA_TONE_MODES: readonly CovaraToneMode[] = [
  "soft",
  "poetic",
  "crisp",
  "expert",
] as const;

// ─────────────────────────────────────────────────────────────────────────
// Mappers

export function covaraToAstrobobo(mode: CovaraToneMode): ToneMode {
  switch (mode) {
    case "soft":
      return "calm";
    case "poetic":
      return "mystical";
    case "crisp":
      return "direct";
    case "expert":
      return "oracle";
  }
}

export function astroboboToCovara(mode: ToneMode): CovaraToneMode {
  switch (mode) {
    case "calm":
      return "soft";
    case "mystical":
      return "poetic";
    case "direct":
      return "crisp";
    case "oracle":
      return "expert";
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Host-agnostic input shapes

/**
 * The minimal behavior vector a host app needs to supply. Any additional
 * telemetry (CTR, retention) enters via `RemoteSignals`.
 */
export type BehaviorVector = {
  /** 0..1 — how much the user is engaging right now. */
  engagement: number;
  /** 0..1 — how excited / energetic the session feels. */
  excitement: number;
  /** 0..1 — how slow/deliberate the user's exploration is. */
  curiosity: number;
  /** 0..1 — confusion / rage / hesitation. */
  confusion: number;
  /** Total meaningful interactions this session. */
  interactionCount: number;
};

/**
 * External signals pulled from analytics or a cohort assignment. Host apps
 * may leave this empty. An `overrideTone` wins over classification entirely.
 */
export type RemoteSignals = {
  /** 0..1 — aggregate CTR for the current cohort on a target surface. */
  cohortCtr?: number;
  /** Forced override from product analytics. Wins over classification. */
  overrideTone?: ToneMode;
};

// ─────────────────────────────────────────────────────────────────────────
// Classification

/**
 * Classify a behavior vector into a tone. Pure function — no hidden state.
 * Hosts that want smoothing should decay the vector before calling this.
 */
export function classifyTone(
  behavior: BehaviorVector,
  remote: RemoteSignals = {}
): ToneMode {
  if (remote.overrideTone) return remote.overrideTone;

  // Rage / hesitation → always calm down first.
  if (behavior.confusion > 0.55) return "calm";

  // Power users: a lot of meaningful interactions + sustained engagement.
  if (behavior.interactionCount > 25 && behavior.engagement > 0.6) {
    return "oracle";
  }

  // Engaged: prefer mystical for slow-curious; direct for task-focused.
  if (behavior.engagement > 0.35) {
    return behavior.curiosity > 0.55 ? "mystical" : "direct";
  }

  // New-ish: lean mystical if exploring, calm otherwise.
  return behavior.curiosity > 0.4 ? "mystical" : "calm";
}

// ─────────────────────────────────────────────────────────────────────────
// Self-check

/**
 * Tiny invariants the tests and the host can run at boot. Returns
 * `{ ok, failures }` so callers can log specifics. Intended for CI or a
 * dev-only runtime check.
 */
export function validateToneContract(): {
  ok: boolean;
  failures: string[];
} {
  const failures: string[] = [];

  // Round-trip check: mapping each way preserves identity.
  for (const mode of TONE_MODES) {
    const roundTripped = covaraToAstrobobo(astroboboToCovara(mode));
    if (roundTripped !== mode) {
      failures.push(`roundtrip ${mode} → ${roundTripped}`);
    }
  }
  for (const mode of COVARA_TONE_MODES) {
    const roundTripped = astroboboToCovara(covaraToAstrobobo(mode));
    if (roundTripped !== mode) {
      failures.push(`covara-roundtrip ${mode} → ${roundTripped}`);
    }
  }

  // Power-user classification check.
  const powerSample: BehaviorVector = {
    engagement: 0.7,
    excitement: 0.4,
    curiosity: 0.3,
    confusion: 0,
    interactionCount: 30,
  };
  if (classifyTone(powerSample) !== "oracle") {
    failures.push("power-user should classify as oracle");
  }

  // Rage check.
  const rageSample: BehaviorVector = {
    engagement: 0.5,
    excitement: 0.8,
    curiosity: 0.1,
    confusion: 0.8,
    interactionCount: 10,
  };
  if (classifyTone(rageSample) !== "calm") {
    failures.push("high-confusion should classify as calm");
  }

  // Override always wins.
  if (classifyTone(rageSample, { overrideTone: "oracle" }) !== "oracle") {
    failures.push("overrideTone should win over confusion collapse");
  }

  return { ok: failures.length === 0, failures };
}
