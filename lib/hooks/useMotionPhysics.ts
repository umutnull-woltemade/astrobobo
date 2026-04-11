/**
 * useMotionPhysics — returns framer-motion transitions tuned to the current
 * motion intensity. Components call this instead of hard-coding springs so
 * the "calm / normal / charged" bands respect the adaptive layer.
 */

"use client";

import { useMemo } from "react";
import {
  proSpring,
  proSpringHeavy,
  proSpringSnappy,
  proSceneEnter,
  scaleTransition,
} from "@/lib/pro/motion-config";
import { useDirective } from "./useAIState";

export function useMotionPhysics() {
  const directive = useDirective();
  const intensity = directive.motionIntensity;

  return useMemo(
    () => ({
      intensity,
      spring: scaleTransition(proSpring, intensity),
      springHeavy: scaleTransition(proSpringHeavy, intensity),
      springSnappy: scaleTransition(proSpringSnappy, intensity),
      scene: scaleTransition(proSceneEnter, intensity),
    }),
    [intensity]
  );
}
