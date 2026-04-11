/**
 * Astrobobo Web Pro — AI Core orb.
 *
 * Central living element of the entry field. Pulses on a slow breathing
 * timer, reacts to cursor proximity by scaling and intensifying its halo,
 * and emits outward ripples through the shared interaction store whenever
 * the user gets within the inner gravity well. Hovering advances the
 * reveal level so the first whisper unlocks.
 */

"use client";

import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";
import { useEffect, useRef } from "react";
import { useInteraction } from "@/lib/store/interaction-store";
import { proSpring, proSpringSnappy } from "@/lib/pro/motion-config";

const CORE_DIAMETER = 220;

export default function AICore() {
  const rootRef = useRef<HTMLDivElement>(null);

  const proximity = useMotionValue(0);
  const softProximity = useSpring(proximity, { stiffness: 180, damping: 26, mass: 0.8 });

  const scale = useTransform(softProximity, [0, 1], [1, 1.18]);
  const glowOpacity = useTransform(softProximity, [0, 1], [0.35, 0.95]);
  const ringRotation = useMotionValue(0);

  const setCoreProximity = useInteraction((s) => s.setCoreProximity);
  const advanceReveal = useInteraction((s) => s.advanceReveal);
  const bumpInteraction = useInteraction((s) => s.bumpInteraction);
  const revealLevel = useInteraction((s) => s.revealLevel);

  // Slow autonomous rotation of the outer ring.
  useEffect(() => {
    let raf = 0;
    let last = performance.now();
    const loop = (t: number) => {
      const dt = (t - last) / 1000;
      last = t;
      ringRotation.set(ringRotation.get() + dt * 12);
      raf = requestAnimationFrame(loop);
    };
    raf = requestAnimationFrame(loop);
    return () => cancelAnimationFrame(raf);
  }, [ringRotation]);

  // Track cursor proximity to the orb itself (relative to its bounding box).
  useEffect(() => {
    const unsub = useInteraction.subscribe((state) => {
      if (!rootRef.current) return;
      const rect = rootRef.current.getBoundingClientRect();
      const cx = (rect.left + rect.right) / 2;
      const cy = (rect.top + rect.bottom) / 2;
      const px = state.cursor.x * window.innerWidth;
      const py = state.cursor.y * window.innerHeight;
      const dx = px - cx;
      const dy = py - cy;
      const dist = Math.sqrt(dx * dx + dy * dy);
      const influence = Math.max(0, 1 - dist / 360);
      proximity.set(influence);
      setCoreProximity(influence);
    });
    return unsub;
  }, [proximity, setCoreProximity]);

  const handleEnter = () => {
    bumpInteraction();
    if (revealLevel < 2) advanceReveal();
  };

  const handleClick = () => {
    bumpInteraction();
    advanceReveal();
  };

  return (
    <div
      ref={rootRef}
      className="relative pointer-events-auto"
      style={{ width: CORE_DIAMETER, height: CORE_DIAMETER }}
      onMouseEnter={handleEnter}
      onClick={handleClick}
    >
      {/* Outer rotating energy ring */}
      <motion.div
        className="absolute inset-[-40px] rounded-full"
        style={{
          rotate: ringRotation,
          background:
            "conic-gradient(from 0deg, rgba(124,58,237,0) 0deg, rgba(124,58,237,0.45) 80deg, rgba(34,211,238,0.55) 200deg, rgba(124,58,237,0) 360deg)",
          maskImage:
            "radial-gradient(closest-side, transparent 62%, black 64%, black 72%, transparent 74%)",
          WebkitMaskImage:
            "radial-gradient(closest-side, transparent 62%, black 64%, black 72%, transparent 74%)",
          opacity: 0.85,
        }}
      />

      {/* Halo */}
      <motion.div
        className="absolute inset-[-80px] rounded-full"
        style={{
          background:
            "radial-gradient(closest-side, rgba(124,58,237,0.55), rgba(124,58,237,0.2) 45%, transparent 70%)",
          opacity: glowOpacity,
          filter: "blur(18px)",
        }}
      />

      {/* Breathing core */}
      <motion.div
        className="absolute inset-0 rounded-full"
        style={{
          scale,
          background:
            "radial-gradient(circle at 35% 30%, #f5f3ff 0%, #c4b5fd 18%, #7c3aed 48%, #1e1b4b 78%, #000 100%)",
          boxShadow:
            "0 0 60px rgba(124,58,237,0.6), 0 0 120px rgba(124,58,237,0.35), inset 0 0 80px rgba(167,139,250,0.25)",
        }}
        animate={{
          scale: [1, 1.015, 1],
          opacity: [0.92, 1, 0.92],
        }}
        transition={{
          duration: 5.5,
          repeat: Infinity,
          ease: "easeInOut",
        }}
      />

      {/* Soft inner highlight — gives the orb volume */}
      <motion.div
        className="absolute inset-[18%] rounded-full pointer-events-none"
        style={{
          background:
            "radial-gradient(circle at 38% 28%, rgba(245,243,255,0.85), rgba(245,243,255,0.1) 30%, transparent 55%)",
          mixBlendMode: "screen",
        }}
        transition={proSpring}
      />

      {/* Cursor-reactive flare ring, fires when you get close */}
      <motion.div
        className="absolute inset-[-14px] rounded-full pointer-events-none"
        style={{
          border: "1px solid rgba(167,139,250,0.5)",
          boxShadow:
            "0 0 24px rgba(124,58,237,0.5), inset 0 0 24px rgba(34,211,238,0.25)",
          opacity: useTransform(softProximity, [0, 0.25, 1], [0, 0.3, 0.95]),
          scale: useTransform(softProximity, [0, 1], [0.96, 1.06]),
        }}
        transition={proSpringSnappy}
      />
    </div>
  );
}
