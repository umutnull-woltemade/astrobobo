/**
 * QuantumCard — floating glass slab that bends toward the cursor.
 *
 * Reads the gravity field from the Pro store (cursor normalized 0..1) and
 * tilts on hover with a spring from `useMotionPhysics`. Tracks its own
 * engagement events via the store so the orchestrator can promote it.
 */

"use client";

import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";
import { useRef } from "react";
import type { PropsWithChildren } from "react";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";
import { useDirective } from "@/lib/hooks/useAIState";

type QuantumCardProps = PropsWithChildren<{
  id?: string;
  title?: string;
  className?: string;
  glow?: "violet" | "cyan" | "amber";
  /**
   * Marks this card as non-critical so the AIAdaptiveContainer can hide it
   * when the adaptation layer triggers a confusion collapse.
   */
  "data-pro-secondary"?: boolean;
}>;

const glowMap = {
  violet: "shadow-pro-glow-violet",
  cyan: "shadow-pro-glow-cyan",
  amber: "shadow-pro-glow-amber",
} as const;

export function QuantumCard({
  id,
  title,
  children,
  className = "",
  glow = "violet",
  "data-pro-secondary": secondary,
}: QuantumCardProps) {
  const ref = useRef<HTMLDivElement>(null);
  const { spring } = useMotionPhysics();
  const directive = useDirective();

  const rx = useMotionValue(0);
  const ry = useMotionValue(0);
  const srx = useSpring(rx, { stiffness: 180, damping: 18, mass: 0.9 });
  const sry = useSpring(ry, { stiffness: 180, damping: 18, mass: 0.9 });
  const rotateX = useTransform(srx, (v) => `${v}deg`);
  const rotateY = useTransform(sry, (v) => `${v}deg`);

  const handleMove = (e: React.PointerEvent<HTMLDivElement>) => {
    const el = ref.current;
    if (!el) return;
    const rect = el.getBoundingClientRect();
    const nx = (e.clientX - rect.left) / rect.width - 0.5;
    const ny = (e.clientY - rect.top) / rect.height - 0.5;
    const tilt = directive.motionIntensity === "charged" ? 9 : 5;
    ry.set(nx * tilt);
    rx.set(-ny * tilt);
  };

  const handleLeave = () => {
    rx.set(0);
    ry.set(0);
  };

  return (
    <motion.div
      ref={ref}
      data-pro-node={id}
      data-pro-secondary={secondary || undefined}
      onPointerMove={handleMove}
      onPointerLeave={handleLeave}
      whileHover={{ y: -4, scale: 1.012 }}
      transition={spring}
      style={{ rotateX, rotateY, transformPerspective: 1100 }}
      className={`pro-glass pro-stroke-gradient relative p-7 ${glowMap[glow]} ${className}`}
    >
      {title ? (
        <h3 className="pro-heading mb-3 text-xl tracking-tight">{title}</h3>
      ) : null}
      <div className="relative z-10 text-pro-text/85">{children}</div>
    </motion.div>
  );
}
