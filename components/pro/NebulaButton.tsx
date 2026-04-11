/**
 * NebulaButton — energy-core button. Hover charges the core glow, click emits
 * a micro particle burst (DOM-level, so it works outside the /universe scene).
 *
 * Variant maps:
 *   - primary → violet core
 *   - secondary → cyan core
 *   - ghost → transparent, border-only, cyan accent
 */

"use client";

import { AnimatePresence, motion } from "framer-motion";
import { useState, useCallback } from "react";
import type { PropsWithChildren } from "react";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

type Variant = "primary" | "secondary" | "ghost";

type NebulaButtonProps = PropsWithChildren<{
  variant?: Variant;
  onClick?: () => void;
  className?: string;
  type?: "button" | "submit";
  id?: string;
}>;

const variantClasses: Record<Variant, string> = {
  primary:
    "bg-gradient-to-br from-pro-violet/80 to-pro-violet/30 text-white shadow-pro-glow-violet",
  secondary:
    "bg-gradient-to-br from-pro-cyan/80 to-pro-cyan/30 text-pro-void shadow-pro-glow-cyan",
  ghost:
    "bg-transparent text-pro-cyan border border-pro-cyan/50 hover:shadow-pro-glow-cyan",
};

type Spark = { id: number; x: number; y: number };

export function NebulaButton({
  children,
  variant = "primary",
  onClick,
  className = "",
  type = "button",
  id,
}: NebulaButtonProps) {
  const { spring } = useMotionPhysics();
  const [sparks, setSparks] = useState<Spark[]>([]);

  const handleClick = useCallback(
    (e: React.MouseEvent<HTMLButtonElement>) => {
      const rect = e.currentTarget.getBoundingClientRect();
      const cx = e.clientX - rect.left;
      const cy = e.clientY - rect.top;
      const batch = Array.from({ length: 10 }, (_, i) => ({
        id: Date.now() + i,
        x: cx + (Math.random() - 0.5) * 6,
        y: cy + (Math.random() - 0.5) * 6,
      }));
      setSparks((prev) => [...prev, ...batch]);
      window.setTimeout(() => {
        setSparks((prev) => prev.filter((s) => !batch.find((b) => b.id === s.id)));
      }, 650);
      onClick?.();
    },
    [onClick]
  );

  return (
    <motion.button
      type={type}
      data-pro-node={id}
      onClick={handleClick}
      whileHover={{ scale: 1.03, y: -1 }}
      whileTap={{ scale: 0.97 }}
      transition={spring}
      className={`relative inline-flex items-center justify-center overflow-hidden rounded-full px-6 py-3 text-sm font-medium tracking-wide uppercase backdrop-blur-pro-sm transition-shadow duration-500 ${variantClasses[variant]} ${className}`}
    >
      <span className="relative z-10">{children}</span>
      <span
        aria-hidden
        className="pointer-events-none absolute inset-0 animate-pro-breathe rounded-full"
        style={{
          background:
            "radial-gradient(circle at center, rgba(255,255,255,0.18), transparent 65%)",
        }}
      />
      <AnimatePresence>
        {sparks.map((s) => (
          <motion.span
            key={s.id}
            className="pointer-events-none absolute h-1 w-1 rounded-full bg-white"
            initial={{ x: s.x, y: s.y, opacity: 1, scale: 1 }}
            animate={{
              x: s.x + (Math.random() - 0.5) * 48,
              y: s.y + (Math.random() - 0.5) * 48,
              opacity: 0,
              scale: 0.2,
            }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.55, ease: [0.22, 1, 0.36, 1] }}
          />
        ))}
      </AnimatePresence>
    </motion.button>
  );
}
