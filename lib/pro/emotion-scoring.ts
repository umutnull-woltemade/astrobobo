/**
 * Astrobobo Web Pro — emotion scoring.
 *
 * Turns raw behavior events from `useUserBehavior` into three continuous
 * scores (0..1): excitement, confusion, curiosity. These scores feed both the
 * AI layout engine (which decides structural adaptations) and the universe
 * runtime (which drives particle + gravity field intensity).
 *
 * The math is intentionally simple — we favor smooth decay over complex ML so
 * the UI responds predictably within a single session.
 */

export type BehaviorSample = {
  /** Pointer velocity in px/sec, smoothed across ~200ms. */
  pointerVelocity: number;
  /** Pixels per second, positive down, negative up. */
  scrollVelocity: number;
  /** Clicks in the trailing 2s window. */
  recentClicks: number;
  /** Direction flips of the pointer in the trailing 1.5s. Proxy for rage. */
  directionFlips: number;
  /** Time since the last meaningful interaction, in ms. */
  idleMs: number;
  /** Dwell time on the currently-focused section, in ms. */
  dwellMs: number;
};

export type EmotionState = {
  excitement: number;
  confusion: number;
  curiosity: number;
  /** Overall engagement — a convenience aggregate used for layer unlocks. */
  engagement: number;
};

export const neutralEmotion: EmotionState = {
  excitement: 0.15,
  confusion: 0,
  curiosity: 0.2,
  engagement: 0.15,
};

const clamp = (n: number, lo = 0, hi = 1) => Math.min(hi, Math.max(lo, n));

/**
 * Pure function: given previous state + a new behavior sample + dt, return
 * the next emotion state. Decay pulls everything back toward `neutralEmotion`
 * so momentary spikes don't lock the UI into a state.
 */
export function stepEmotion(
  prev: EmotionState,
  s: BehaviorSample,
  dtMs: number
): EmotionState {
  const dt = Math.max(dtMs, 16) / 1000;

  // Excitement — rewarded by velocity and clicks, decays quickly when idle.
  const excitementImpulse =
    clamp(s.pointerVelocity / 1800) * 0.45 +
    clamp(Math.abs(s.scrollVelocity) / 2400) * 0.35 +
    clamp(s.recentClicks / 6) * 0.35;

  // Confusion — rewarded by erratic pointer flips, long idle with nonzero
  // motion, and bursts of clicks (rage clicks).
  const confusionImpulse =
    clamp(s.directionFlips / 8) * 0.55 +
    (s.recentClicks > 4 ? clamp((s.recentClicks - 4) / 6) * 0.45 : 0) +
    (s.idleMs > 4000 && s.pointerVelocity > 40 ? 0.2 : 0);

  // Curiosity — slow deliberate movement + meaningful dwell on a section.
  const curiosityImpulse =
    clamp(s.dwellMs / 9000) * 0.55 +
    (s.pointerVelocity > 20 && s.pointerVelocity < 400 ? 0.25 : 0);

  const decayTo = (current: number, target: number, halfLifeSec: number) => {
    const k = 1 - Math.pow(0.5, dt / halfLifeSec);
    return current + (target - current) * k;
  };

  const excitement = clamp(
    decayTo(prev.excitement, excitementImpulse, 0.9)
  );
  const confusion = clamp(
    decayTo(prev.confusion, confusionImpulse, 1.3)
  );
  const curiosity = clamp(
    decayTo(prev.curiosity, curiosityImpulse, 2.2)
  );

  const engagement = clamp(
    excitement * 0.55 + curiosity * 0.5 - confusion * 0.35 + 0.08
  );

  return { excitement, confusion, curiosity, engagement };
}
