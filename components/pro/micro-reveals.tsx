/**
 * Astrobobo Web Pro — Micro reveals.
 *
 * Progressive text fragments that surface as the user interacts. Instead
 * of a hero paragraph, each reveal level unlocks a single whispered line
 * that drifts up from the orb with a spring enter. Nothing is ever
 * visible at load — the void has to be earned.
 *
 * Reveal map
 *   0 → nothing (only the void + core)
 *   1 → "Something is forming…"
 *   2 → "This is not a website."
 *   3 → "This is a living system."
 *   4 → (portal CTA handles its own label)
 */

"use client";

import { motion, AnimatePresence } from "framer-motion";
import { useInteraction } from "@/lib/store/interaction-store";
import { proEase } from "@/lib/pro/motion-config";

type Fragment = { id: string; text: string; y: number };

const fragmentsByLocale: Record<"en" | "tr", Fragment[]> = {
  en: [
    { id: "f1", text: "Something is forming…", y: 180 },
    { id: "f2", text: "This is not a website.", y: 220 },
    { id: "f3", text: "This is a living system.", y: 260 },
  ],
  tr: [
    { id: "f1", text: "Bir şey şekilleniyor…", y: 180 },
    { id: "f2", text: "Bu bir site değil.", y: 220 },
    { id: "f3", text: "Bu yaşayan bir sistem.", y: 260 },
  ],
};

export default function MicroReveals({ locale }: { locale: "en" | "tr" }) {
  const revealLevel = useInteraction((s) => s.revealLevel);
  const fragments = fragmentsByLocale[locale];
  const visible = fragments.slice(0, Math.min(revealLevel, 3));

  return (
    <div className="pointer-events-none absolute inset-0 flex items-center justify-center">
      <div className="relative w-full max-w-3xl px-6 text-center">
        <AnimatePresence>
          {visible.map((f, i) => (
            <motion.p
              key={f.id}
              initial={{ opacity: 0, y: 30, filter: "blur(16px)" }}
              animate={{ opacity: 1 - i * 0.18, y: f.y, filter: "blur(0px)" }}
              exit={{ opacity: 0, y: f.y - 30, filter: "blur(14px)" }}
              transition={{
                duration: 1.6,
                ease: proEase,
                delay: 0.15,
              }}
              className="absolute left-1/2 -translate-x-1/2 text-[15px] md:text-lg tracking-[0.22em] uppercase"
              style={{
                color: "rgba(245,243,255,0.82)",
                textShadow: "0 0 24px rgba(124,58,237,0.55)",
                fontFamily: "\"Space Grotesk\", Inter, sans-serif",
              }}
            >
              {f.text}
            </motion.p>
          ))}
        </AnimatePresence>
      </div>
    </div>
  );
}
