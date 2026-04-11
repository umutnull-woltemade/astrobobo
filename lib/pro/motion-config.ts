/**
 * Astrobobo Web Pro — motion configuration.
 *
 * Everything cinematic in the Pro layer imports easings / springs from here so
 * the "dimensional shift" feel stays coherent across components. Never use
 * linear easings — prefer `proOut` or a spring.
 */

import type { Transition } from "framer-motion";

export const proEase: [number, number, number, number] = [0.22, 1, 0.36, 1];
export const proEaseInOut: [number, number, number, number] = [0.76, 0, 0.24, 1];

export const proDurations = {
  micro: 0.18,
  quick: 0.32,
  base: 0.55,
  slow: 0.9,
  scene: 1.4,
} as const;

/**
 * Soft physical spring used for hover, tilt, and layout shifts. Tuned to feel
 * like an object with mass drifting through a gravity field rather than a UI
 * element snapping between states.
 */
export const proSpring: Transition = {
  type: "spring",
  stiffness: 160,
  damping: 22,
  mass: 0.9,
};

export const proSpringHeavy: Transition = {
  type: "spring",
  stiffness: 90,
  damping: 28,
  mass: 1.6,
};

export const proSpringSnappy: Transition = {
  type: "spring",
  stiffness: 320,
  damping: 26,
  mass: 0.6,
};

/** Default page / scene enter. Depth-forward, never a flat fade. */
export const proSceneEnter: Transition = {
  duration: proDurations.scene,
  ease: proEase,
};

/** Ratio multipliers applied to every transition when motion is simplified. */
export const proMotionScaleByIntensity: Record<MotionIntensity, number> = {
  calm: 0.55,
  normal: 1,
  charged: 1.35,
};

export type MotionIntensity = "calm" | "normal" | "charged";

export const scaleTransition = (
  t: Transition,
  intensity: MotionIntensity
): Transition => {
  const k = proMotionScaleByIntensity[intensity];
  if ("duration" in t && typeof t.duration === "number") {
    return { ...t, duration: t.duration * k };
  }
  if (t.type === "spring") {
    return {
      ...t,
      stiffness: (t.stiffness ?? 160) / k,
      damping: (t.damping ?? 22) * (intensity === "charged" ? 0.9 : 1),
    };
  }
  return t;
};
