/**
 * Astrobobo Web Pro — Orbit system.
 *
 * Features are not listed in a grid; they orbit the central AI Core as
 * living nodes. Each node expands into a cinematic preview on hover, and
 * clicking one "zooms" (scales + flattens the others) so the scene
 * becomes a momentary focus space for that concept. The orbit is driven
 * by a single rotation motion value so every node stays coherent; each
 * node reads its own angular offset off the shared rotation.
 */

"use client";

import { motion, useAnimationFrame, useMotionValue, useTransform } from "framer-motion";
import { useState } from "react";
import { useInteraction } from "@/lib/store/interaction-store";
import { proEase, proSpring } from "@/lib/pro/motion-config";

type Node = {
  id: string;
  label: { en: string; tr: string };
  detail: { en: string; tr: string };
  color: string;
  radius: number;
  /** Offset in degrees along the orbit. */
  angle: number;
  /** Relative orbit speed multiplier. */
  speed: number;
};

const NODES: Node[] = [
  {
    id: "archetypes",
    label: { en: "Archetypes", tr: "Arketipler" },
    detail: {
      en: "Twelve living symbols reflecting the psyche.",
      tr: "Ruhu yansıtan on iki canlı sembol.",
    },
    color: "#a78bfa",
    radius: 260,
    angle: 0,
    speed: 1,
  },
  {
    id: "transits",
    label: { en: "Transits", tr: "Transitler" },
    detail: {
      en: "The sky, alive — mapped to your orbit.",
      tr: "Gökyüzü, canlı — yörüngenize çizilmiş.",
    },
    color: "#67e8f9",
    radius: 260,
    angle: 72,
    speed: 1,
  },
  {
    id: "reflections",
    label: { en: "Reflections", tr: "Yansımalar" },
    detail: {
      en: "Daily mirrors tuned to what you're feeling.",
      tr: "Hissettiklerinize göre ayarlanmış günlük aynalar.",
    },
    color: "#f5f3ff",
    radius: 260,
    angle: 144,
    speed: 1,
  },
  {
    id: "chart",
    label: { en: "Birth Chart", tr: "Doğum Haritası" },
    detail: {
      en: "The shape of your arrival, drawn in constellations.",
      tr: "Gelişinizin şekli, burçlarla çizilmiş.",
    },
    color: "#c4b5fd",
    radius: 260,
    angle: 216,
    speed: 1,
  },
  {
    id: "guide",
    label: { en: "Living Guide", tr: "Canlı Rehber" },
    detail: {
      en: "An ever-listening companion, not an answer machine.",
      tr: "Sürekli dinleyen bir yoldaş, cevap makinesi değil.",
    },
    color: "#22d3ee",
    radius: 260,
    angle: 288,
    speed: 1,
  },
];

export default function OrbitSystem({ locale }: { locale: "en" | "tr" }) {
  const rotation = useMotionValue(0);
  const revealLevel = useInteraction((s) => s.revealLevel);
  const setHoveredNodeId = useInteraction((s) => s.setHoveredNodeId);
  const bumpInteraction = useInteraction((s) => s.bumpInteraction);
  const directive = useInteraction((s) => s.directive);
  const [focused, setFocused] = useState<string | null>(null);

  // AI directive → orbit speed. Calm sessions drift at 3 deg/sec; charged
  // sessions accelerate up to ~12. Density compresses the visible radii.
  const speed =
    directive.motionIntensity === "charged"
      ? 12
      : directive.motionIntensity === "calm"
        ? 3
        : 6;

  useAnimationFrame((_, delta) => {
    rotation.set(rotation.get() + (delta / 1000) * speed);
  });

  const unlocked = revealLevel >= 2;

  // Density compresses radii: airy for new users, tight for power users.
  const densityT = Math.min(1, Math.max(0, (directive.density - 0.42) / 0.46));
  const radiusScale = 1.08 + (0.88 - 1.08) * densityT;
  const rx = 285 * radiusScale;
  const ry = 170 * radiusScale;

  return (
    <motion.div
      className="relative w-full max-w-[720px] h-[620px] mx-auto"
      initial={{ opacity: 0, scale: 0.9, filter: "blur(20px)" }}
      animate={{
        opacity: unlocked ? 1 : 0,
        scale: unlocked ? 1 : 0.9,
        filter: unlocked ? "blur(0px)" : "blur(20px)",
      }}
      transition={{ duration: 1.6, ease: proEase }}
    >
      {/* Orbit paths */}
      <svg
        className="absolute inset-0 w-full h-full pointer-events-none"
        viewBox="-400 -320 800 640"
        aria-hidden
      >
        <defs>
          <linearGradient id="orbitStroke" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0" stopColor="rgba(167,139,250,0.35)" />
            <stop offset="1" stopColor="rgba(34,211,238,0.35)" />
          </linearGradient>
        </defs>
        <ellipse
          cx="0"
          cy="0"
          rx={rx}
          ry={ry}
          fill="none"
          stroke="url(#orbitStroke)"
          strokeDasharray="1 5"
          strokeWidth="1"
          opacity="0.6"
        />
        <ellipse
          cx="0"
          cy="0"
          rx={rx * 0.77}
          ry={ry * 0.76}
          fill="none"
          stroke="url(#orbitStroke)"
          strokeDasharray="1 8"
          strokeWidth="1"
          opacity="0.35"
        />
      </svg>

      {NODES.map((node) => (
        <OrbitNode
          key={node.id}
          node={node}
          rotation={rotation}
          rx={rx}
          ry={ry}
          locale={locale}
          focused={focused}
          onHover={(id) => {
            setHoveredNodeId(id);
            bumpInteraction();
          }}
          onFocus={(id) => {
            setFocused((curr) => (curr === id ? null : id));
            bumpInteraction();
          }}
        />
      ))}
    </motion.div>
  );
}

function OrbitNode({
  node,
  rotation,
  rx,
  ry,
  locale,
  focused,
  onHover,
  onFocus,
}: {
  node: Node;
  rotation: ReturnType<typeof useMotionValue<number>>;
  rx: number;
  ry: number;
  locale: "en" | "tr";
  focused: string | null;
  onHover: (id: string | null) => void;
  onFocus: (id: string) => void;
}) {
  const angleRad = useTransform(rotation, (r) => ((r + node.angle) * Math.PI) / 180);
  const x = useTransform(angleRad, (a) => Math.cos(a) * rx);
  const y = useTransform(angleRad, (a) => Math.sin(a) * ry);

  const isFocused = focused === node.id;
  const isDimmed = focused !== null && !isFocused;

  const handleKey = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" || e.key === " ") {
      e.preventDefault();
      onFocus(node.id);
    } else if (e.key === "Escape" && isFocused) {
      onFocus(node.id);
    }
  };

  return (
    <motion.div
      className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-auto focus-visible:outline-none"
      role="button"
      tabIndex={0}
      aria-label={node.label[locale]}
      aria-pressed={isFocused}
      style={{ x, y }}
      animate={{
        scale: isFocused ? 1.35 : isDimmed ? 0.7 : 1,
        opacity: isDimmed ? 0.25 : 1,
      }}
      transition={proSpring}
      onMouseEnter={() => onHover(node.id)}
      onMouseLeave={() => onHover(null)}
      onFocus={() => onHover(node.id)}
      onBlur={() => onHover(null)}
      onClick={() => onFocus(node.id)}
      onKeyDown={handleKey}
    >
      <div className="relative flex flex-col items-center group cursor-pointer">
        {/* Node glow */}
        <motion.div
          className="absolute inset-0 rounded-full pointer-events-none"
          style={{
            width: 18,
            height: 18,
            left: "50%",
            top: 4,
            transform: "translateX(-50%)",
            boxShadow: `0 0 30px ${node.color}, 0 0 60px ${node.color}66`,
            background: node.color,
            borderRadius: "50%",
          }}
          animate={{
            scale: [1, 1.15, 1],
            opacity: [0.8, 1, 0.8],
          }}
          transition={{
            duration: 3 + Math.random() * 1.5,
            repeat: Infinity,
            ease: "easeInOut",
          }}
        />

        <motion.div
          className="mt-8 pro-glass pro-stroke-gradient px-4 py-2 whitespace-nowrap"
          style={{
            borderRadius: 999,
            fontFamily: "\"Space Grotesk\", Inter, sans-serif",
            fontSize: 12,
            letterSpacing: "0.14em",
            textTransform: "uppercase",
            color: "#f5f3ff",
          }}
          whileHover={{ y: -3 }}
          transition={proSpring}
        >
          {node.label[locale]}
        </motion.div>

        <motion.div
          className="mt-3 pro-glass px-4 py-3 max-w-[260px] text-center"
          initial={{ opacity: 0, y: -6, scale: 0.9 }}
          animate={{
            opacity: isFocused ? 1 : 0,
            y: isFocused ? 0 : -6,
            scale: isFocused ? 1 : 0.9,
          }}
          transition={proSpring}
          style={{
            borderRadius: 18,
            fontFamily: "\"Space Grotesk\", Inter, sans-serif",
            fontSize: 13,
            color: "rgba(245,243,255,0.86)",
            lineHeight: 1.55,
            pointerEvents: isFocused ? "auto" : "none",
          }}
        >
          {node.detail[locale]}
        </motion.div>
      </div>
    </motion.div>
  );
}
