/**
 * AIField — the gravity field overlay rendered above the WebGL canvas.
 *
 * This is a DOM-level layer that paints:
 *   - a soft cursor aura tied to excitement
 *   - concentric rings that grow/shrink with curiosity
 *   - a HUD in the corner showing the live directive (debug-friendly, can
 *     be toggled off in prod by passing `showDebug={false}`)
 */

"use client";

import { AnimatePresence, motion } from "framer-motion";
import { useEmotion, useDirective } from "@/lib/hooks/useAIState";
import { useProStore } from "@/lib/pro/pro-store";

type AIFieldProps = {
  showDebug?: boolean;
};

export function AIField({ showDebug = true }: AIFieldProps) {
  const emotion = useEmotion();
  const directive = useDirective();
  const cursor = useProStore((s) => s.cursor);
  const scores = useProStore((s) => s.engagementScores);
  const overrideTone = useProStore((s) => s.remoteSignals.overrideTone);
  const cohort = useProStore((s) => s.remoteSignals.cohort);
  const invariants = useProStore((s) => s.invariants);

  return (
    <div className="pointer-events-none fixed inset-0 z-10">
      <motion.div
        className="absolute rounded-full"
        style={{
          left: `calc(${cursor.x * 100}% - 180px)`,
          top: `calc(${cursor.y * 100}% - 180px)`,
          width: 360,
          height: 360,
          background:
            "radial-gradient(circle at 50% 50%, rgba(124,58,237,0.32), transparent 60%)",
          mixBlendMode: "screen",
          filter: "blur(14px)",
        }}
        animate={{
          scale: 0.9 + emotion.excitement * 0.35,
          opacity: 0.6 + emotion.engagement * 0.35,
        }}
        transition={{ type: "spring", stiffness: 90, damping: 18, mass: 1.2 }}
      />

      <motion.div
        className="absolute rounded-full border border-pro-cyan/20"
        style={{
          left: `calc(${cursor.x * 100}% - 120px)`,
          top: `calc(${cursor.y * 100}% - 120px)`,
          width: 240,
          height: 240,
        }}
        animate={{
          scale: 0.7 + emotion.curiosity * 0.6,
          opacity: 0.3 + emotion.curiosity * 0.5,
        }}
        transition={{ type: "spring", stiffness: 70, damping: 22 }}
      />

      {showDebug ? (
        <div className="pro-glass absolute right-6 top-6 pointer-events-none rounded-xl px-4 py-3 font-mono text-[0.7rem] leading-relaxed text-pro-text/80 min-w-[220px]">
          <div className="mb-1 text-pro-cyan">pro-directive</div>
          <div>mode · {directive.mode}</div>
          <div>
            tone · {directive.tone}
            {overrideTone ? (
              <span className="ml-1 text-pro-amber">· forced</span>
            ) : null}
          </div>
          <div>density · {directive.density.toFixed(2)}</div>
          <div>motion · {directive.motionIntensity}</div>
          <div>reveal · L{directive.revealLevel}</div>
          {cohort ? (
            <div>
              cohort · <span className="text-pro-amber">{cohort}</span>
            </div>
          ) : null}
          <div className="mt-2 text-pro-cyan">emotion</div>
          <div>exc · {emotion.excitement.toFixed(2)}</div>
          <div>cur · {emotion.curiosity.toFixed(2)}</div>
          <div>con · {emotion.confusion.toFixed(2)}</div>
          <div>eng · {emotion.engagement.toFixed(2)}</div>

          {invariants ? (
            <>
              <div className="mt-2 text-pro-cyan">
                invariants{" "}
                <span
                  className={invariants.ok ? "text-pro-cyan-soft" : "text-pro-amber"}
                >
                  {invariants.ok ? "✓" : "✗"}
                </span>
              </div>
              <div className="space-y-0.5">
                {invariants.results.map((r) => (
                  <div key={r.name} className="flex items-center gap-2">
                    <span
                      className={r.ok ? "text-pro-cyan-soft" : "text-pro-amber"}
                    >
                      {r.ok ? "✓" : "✗"}
                    </span>
                    <span className="text-pro-text/70">{r.name}</span>
                  </div>
                ))}
              </div>
            </>
          ) : null}

          <div className="mt-2 text-pro-cyan">top nodes</div>
          {scores.length === 0 ? (
            <div className="text-pro-muted">…</div>
          ) : (
            <div className="space-y-1">
              <AnimatePresence initial={false}>
                {scores.slice(0, 5).map((entry) => (
                  <motion.div
                    key={entry.id}
                    layout
                    initial={{ opacity: 0, x: 6 }}
                    animate={{ opacity: 1, x: 0 }}
                    exit={{ opacity: 0 }}
                    transition={{ duration: 0.3, ease: [0.22, 1, 0.36, 1] }}
                    className="flex items-center gap-2"
                  >
                    <span className="w-[90px] truncate text-pro-text/75">
                      {entry.id}
                    </span>
                    <div className="relative h-1.5 flex-1 overflow-hidden rounded-full bg-white/10">
                      <motion.div
                        className="absolute inset-y-0 left-0 rounded-full bg-gradient-to-r from-pro-violet to-pro-cyan"
                        initial={false}
                        animate={{ width: `${entry.score * 100}%` }}
                        transition={{
                          duration: 0.55,
                          ease: [0.22, 1, 0.36, 1],
                        }}
                      />
                    </div>
                  </motion.div>
                ))}
              </AnimatePresence>
            </div>
          )}
        </div>
      ) : null}
    </div>
  );
}
