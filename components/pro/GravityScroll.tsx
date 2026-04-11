/**
 * GravityScroll — wraps a section so its scroll feel becomes "space drift".
 *
 * We don't replace the browser's native scroll (that breaks accessibility).
 * Instead we read the section's scroll progress via framer-motion's
 * `useScroll` and translate children on the Y axis with a soft spring for
 * gentle inertia. Prefers-reduced-motion gets a static render.
 */

"use client";

import { motion, useScroll, useTransform, useSpring } from "framer-motion";
import { useRef } from "react";
import type { PropsWithChildren } from "react";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

type GravityScrollProps = PropsWithChildren<{
  /** Max parallax offset in px at full progress. */
  depth?: number;
  className?: string;
}>;

export function GravityScroll({
  children,
  depth = 80,
  className = "",
}: GravityScrollProps) {
  const ref = useRef<HTMLDivElement>(null);
  const { intensity } = useMotionPhysics();
  const effective = depth * (intensity === "calm" ? 0.4 : intensity === "charged" ? 1.3 : 1);

  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start end", "end start"],
  });

  const raw = useTransform(scrollYProgress, [0, 1], [effective, -effective]);
  const y = useSpring(raw, { stiffness: 80, damping: 22, mass: 1.1 });

  return (
    <div ref={ref} className={`relative ${className}`}>
      <motion.div style={{ y }}>{children}</motion.div>
    </div>
  );
}
