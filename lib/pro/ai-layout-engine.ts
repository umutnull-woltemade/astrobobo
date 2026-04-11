/**
 * Astrobobo Web Pro — AI layout engine.
 *
 * Given an `EmotionState` + a session profile, emit a `LayoutDirective` that
 * every Pro component reads (via `useAIState`). This is intentionally rules-
 * based — real ML lives downstream once we have enough session telemetry.
 *
 * The contract is:
 *   UI = f(userState) → layoutTree
 *
 * Components don't branch on raw emotion scores; they branch on the directive
 * fields (`density`, `motionIntensity`, `revealLevel`, `mode`). That indirection
 * keeps component code stable while the engine grows.
 */

import type { EmotionState } from "./emotion-scoring";
import type { MotionIntensity } from "./motion-config";

export type UserMode = "new" | "engaged" | "lost" | "power";

/**
 * Tone mode — the voice the UI speaks in.
 *
 *   calm     → gentle, welcoming, lots of breathing room (for new / lost)
 *   mystical → poetic, slightly archaic, for curious explorers
 *   direct   → terse, action-first, for engaged/task-focused users
 *   oracle   → dense, confident, reserved for power users
 */
export type ToneMode = "calm" | "mystical" | "direct" | "oracle";

export type LayoutDirective = {
  mode: UserMode;
  tone: ToneMode;
  /** 0..1 — how tightly packed the layout should be. */
  density: number;
  /** 0..1 — how much negative space to keep. */
  airiness: number;
  motionIntensity: MotionIntensity;
  /** 0..3 — how many progressive UI layers are unlocked. */
  revealLevel: 0 | 1 | 2 | 3;
  /** Collapse non-primary CTAs when true. */
  collapseSecondary: boolean;
  /** Float the most-interacted components toward center. */
  gravitate: boolean;
  /** Primary focus node id — for the orbital nav's center anchor. */
  focusNodeId: string | null;
};

export type SessionProfile = {
  /** Seconds since the session began. */
  sessionAgeSec: number;
  /** Total meaningful interactions. */
  interactionCount: number;
  /** Which node has received the most attention. */
  mostEngagedNodeId: string | null;
};

export const defaultDirective: LayoutDirective = {
  mode: "new",
  tone: "calm",
  density: 0.45,
  airiness: 0.75,
  motionIntensity: "calm",
  revealLevel: 0,
  collapseSecondary: false,
  gravitate: false,
  focusNodeId: null,
};

/**
 * Map mode + emotion → tone. Kept as a small standalone function so we can
 * unit-test it and so the tone engine can be reused without dragging the
 * whole layout engine.
 */
export function computeTone(
  mode: UserMode,
  emotion: EmotionState
): ToneMode {
  if (mode === "lost") return "calm";
  if (mode === "power") return "oracle";
  if (mode === "engaged") {
    if (emotion.curiosity > 0.55) return "mystical";
    return "direct";
  }
  // new
  return emotion.curiosity > 0.4 ? "mystical" : "calm";
}

export function computeDirective(
  emotion: EmotionState,
  profile: SessionProfile
): LayoutDirective {
  const mode = classifyMode(emotion, profile);
  const tone = computeTone(mode, emotion);

  switch (mode) {
    case "new":
      return {
        mode,
        tone,
        density: 0.42,
        airiness: 0.82,
        motionIntensity: "calm",
        revealLevel: 0,
        collapseSecondary: false,
        gravitate: false,
        focusNodeId: profile.mostEngagedNodeId,
      };

    case "engaged":
      return {
        mode,
        tone,
        density: lerp(0.55, 0.78, emotion.engagement),
        airiness: lerp(0.7, 0.45, emotion.engagement),
        motionIntensity: emotion.excitement > 0.55 ? "charged" : "normal",
        revealLevel: emotion.engagement > 0.55 ? 2 : 1,
        collapseSecondary: false,
        gravitate: true,
        focusNodeId: profile.mostEngagedNodeId,
      };

    case "lost":
      return {
        mode,
        tone,
        density: 0.32,
        airiness: 0.9,
        motionIntensity: "calm",
        revealLevel: 0,
        collapseSecondary: true,
        gravitate: false,
        focusNodeId: profile.mostEngagedNodeId,
      };

    case "power":
      return {
        mode,
        tone,
        density: 0.88,
        airiness: 0.3,
        motionIntensity: "charged",
        revealLevel: 3,
        collapseSecondary: false,
        gravitate: true,
        focusNodeId: profile.mostEngagedNodeId,
      };
  }
}

function classifyMode(
  emotion: EmotionState,
  profile: SessionProfile
): UserMode {
  if (emotion.confusion > 0.55) return "lost";
  if (profile.interactionCount > 25 && emotion.engagement > 0.6) return "power";
  if (profile.sessionAgeSec < 12 || profile.interactionCount < 3) return "new";
  if (emotion.engagement > 0.35) return "engaged";
  return "new";
}

const lerp = (a: number, b: number, t: number) => a + (b - a) * Math.min(1, Math.max(0, t));
