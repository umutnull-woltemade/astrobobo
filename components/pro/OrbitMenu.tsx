/**
 * OrbitMenu — radial navigation system. Items orbit the center node at a
 * radius that breathes with `directive.revealLevel`. Gravitate=true pulls the
 * most-engaged item slightly inward.
 */

"use client";

import { motion } from "framer-motion";
import { useMemo } from "react";
import { useDirective } from "@/lib/hooks/useAIState";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

export type OrbitItem = {
  id: string;
  label: string;
  href?: string;
  onSelect?: () => void;
  icon?: React.ReactNode;
};

type OrbitMenuProps = {
  center: React.ReactNode;
  items: OrbitItem[];
  radius?: number;
  className?: string;
};

export function OrbitMenu({
  center,
  items,
  radius = 160,
  className = "",
}: OrbitMenuProps) {
  const directive = useDirective();
  const { spring } = useMotionPhysics();

  const effectiveRadius = useMemo(() => {
    const base = radius;
    const levelBonus = directive.revealLevel * 14;
    return base + levelBonus;
  }, [radius, directive.revealLevel]);

  return (
    <div
      className={`relative mx-auto flex items-center justify-center ${className}`}
      style={{ width: effectiveRadius * 2 + 140, height: effectiveRadius * 2 + 140 }}
    >
      {/* Orbit ring */}
      <div
        aria-hidden
        className="pointer-events-none absolute rounded-full border border-white/10"
        style={{ width: effectiveRadius * 2, height: effectiveRadius * 2 }}
      />
      <motion.div
        aria-hidden
        className="pointer-events-none absolute rounded-full border border-pro-violet/25"
        style={{
          width: effectiveRadius * 2 + 28,
          height: effectiveRadius * 2 + 28,
        }}
        animate={{ rotate: 360 }}
        transition={{ duration: 40, repeat: Infinity, ease: "linear" }}
      />

      {/* Center */}
      <motion.div
        className="pro-glass pro-stroke-gradient relative z-10 flex h-36 w-36 items-center justify-center rounded-full text-center text-pro-text shadow-pro-glow-violet"
        animate={{
          scale: directive.mode === "power" ? 1.05 : 1,
        }}
        transition={spring}
      >
        {center}
      </motion.div>

      {/* Orbiting items */}
      {items.map((item, i) => {
        const angle = (i / items.length) * Math.PI * 2 - Math.PI / 2;
        const isFocus = item.id === directive.focusNodeId && directive.gravitate;
        const r = isFocus ? effectiveRadius - 28 : effectiveRadius;
        const x = Math.cos(angle) * r;
        const y = Math.sin(angle) * r;

        return (
          <motion.button
            key={item.id}
            data-pro-node={item.id}
            initial={{ opacity: 0, scale: 0.6 }}
            animate={{ opacity: 1, scale: 1, x, y }}
            whileHover={{ scale: 1.08 }}
            whileTap={{ scale: 0.94 }}
            transition={{ ...spring, delay: i * 0.04 }}
            onClick={item.onSelect}
            className="pro-glass absolute left-1/2 top-1/2 flex h-20 w-20 -translate-x-1/2 -translate-y-1/2 flex-col items-center justify-center gap-1 rounded-full text-[0.7rem] uppercase tracking-wider text-pro-text/85 hover:shadow-pro-glow-cyan"
          >
            {item.icon ? (
              <span className="text-pro-cyan">{item.icon}</span>
            ) : null}
            <span>{item.label}</span>
          </motion.button>
        );
      })}
    </div>
  );
}
