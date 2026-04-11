/**
 * Astrobobo Web Pro — Scene scroll driver.
 *
 * The homepage is NOT a scrolling document. Wheel, touchpad pans, and
 * touch drags are intercepted and accumulated into `sceneProgress` on the
 * interaction store. Each "scene" is a stacked absolute layer whose
 * visibility, depth, and parallax are driven by how close the current
 * progress is to its index.
 *
 * Scene indices
 *   0 Void         — only the particle field + core, nothing else
 *   1 Formation    — first whispers + core intensifies
 *   2 Structure    — orbit rings fade in
 *   3 Expansion    — orbit nodes are interactive, previews expand
 *   4 Decision     — portal gate replaces the orb
 */

"use client";

import { ReactNode, useEffect, useRef } from "react";
import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";
import { SCENE_COUNT, useInteraction } from "@/lib/store/interaction-store";

type SceneProps = { index: number; children: ReactNode };

export function Scene({ index, children }: SceneProps) {
  const sceneProgress = useInteraction((s) => s.sceneProgress);
  const delta = sceneProgress - index;
  const absDelta = Math.abs(delta);

  // Opacity falls off sharply beyond ±0.8 so scenes don't muddle together.
  const opacity = Math.max(0, 1 - absDelta * 1.35);
  // Depth parallax — scenes ahead rush toward the camera, scenes behind
  // retreat. Uses CSS transform so hardware acceleration stays cheap.
  const translateY = delta * -120; // earlier scenes drift up
  const translateZ = -absDelta * 280;
  const scale = 1 - absDelta * 0.08;

  return (
    <motion.div
      className="absolute inset-0 flex items-center justify-center"
      style={{
        opacity,
        transform: `translate3d(0, ${translateY}px, ${translateZ}px) scale(${scale})`,
        pointerEvents: opacity > 0.6 ? "auto" : "none",
        willChange: "transform, opacity",
      }}
    >
      {children}
    </motion.div>
  );
}

export function SceneScroll({ children }: { children: ReactNode }) {
  const containerRef = useRef<HTMLDivElement>(null);
  const target = useMotionValue(0);
  const smooth = useSpring(target, { stiffness: 80, damping: 24, mass: 1.2 });

  const setSceneProgress = useInteraction((s) => s.setSceneProgress);
  const advanceReveal = useInteraction((s) => s.advanceReveal);
  const bumpInteraction = useInteraction((s) => s.bumpInteraction);

  // Push the spring value into the store each frame.
  useEffect(() => {
    const unsub = smooth.on("change", (v) => setSceneProgress(v));
    return unsub;
  }, [smooth, setSceneProgress]);

  // Intercept wheel / touch gestures and remap to sceneProgress.
  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;

    let lastY = 0;
    let touching = false;
    let lastAdvance = 0;

    const tryAdvanceReveal = () => {
      const now = performance.now();
      if (now - lastAdvance > 600) {
        advanceReveal();
        bumpInteraction();
        lastAdvance = now;
      }
    };

    const onWheel = (e: WheelEvent) => {
      const curr = target.get();
      const goingDown = e.deltaY > 0;
      const atMax = curr >= SCENE_COUNT - 1 - 0.001;
      const atMin = curr <= 0.001;
      // Let the wheel pass through at the boundaries so users can reach
      // the SEO content below or return to the top naturally.
      if ((goingDown && atMax) || (!goingDown && atMin)) return;
      e.preventDefault();
      const next = Math.min(
        SCENE_COUNT - 1,
        Math.max(0, curr + e.deltaY * 0.0025),
      );
      target.set(next);
      if (Math.abs(e.deltaY) > 4) tryAdvanceReveal();
    };

    const onTouchStart = (e: TouchEvent) => {
      lastY = e.touches[0]!.clientY;
      touching = true;
    };
    const onTouchMove = (e: TouchEvent) => {
      if (!touching) return;
      e.preventDefault();
      const y = e.touches[0]!.clientY;
      const dy = lastY - y;
      lastY = y;
      const next = Math.min(
        SCENE_COUNT - 1,
        Math.max(0, target.get() + dy * 0.004),
      );
      target.set(next);
      if (Math.abs(dy) > 3) tryAdvanceReveal();
    };
    const onTouchEnd = () => {
      touching = false;
    };

    const onKey = (e: KeyboardEvent) => {
      if (e.key === "ArrowDown" || e.key === "PageDown") {
        target.set(Math.min(SCENE_COUNT - 1, target.get() + 1));
        tryAdvanceReveal();
      } else if (e.key === "ArrowUp" || e.key === "PageUp") {
        target.set(Math.max(0, target.get() - 1));
      }
    };

    el.addEventListener("wheel", onWheel, { passive: false });
    el.addEventListener("touchstart", onTouchStart, { passive: true });
    el.addEventListener("touchmove", onTouchMove, { passive: false });
    el.addEventListener("touchend", onTouchEnd, { passive: true });
    window.addEventListener("keydown", onKey);

    return () => {
      el.removeEventListener("wheel", onWheel);
      el.removeEventListener("touchstart", onTouchStart);
      el.removeEventListener("touchmove", onTouchMove);
      el.removeEventListener("touchend", onTouchEnd);
      window.removeEventListener("keydown", onKey);
    };
  }, [target, advanceReveal, bumpInteraction]);

  return (
    <div
      ref={containerRef}
      className="relative w-full h-[100dvh] overflow-hidden"
      style={{ perspective: 1400 }}
    >
      <div
        className="absolute inset-0"
        style={{ transformStyle: "preserve-3d" }}
      >
        {children}
      </div>
      <SceneIndicator />
    </div>
  );
}

function SceneIndicator() {
  const scene = useInteraction((s) => s.scene);
  const sceneProgress = useInteraction((s) => s.sceneProgress);
  return (
    <div className="absolute right-6 top-1/2 -translate-y-1/2 flex flex-col gap-3 z-30 pointer-events-none">
      {Array.from({ length: SCENE_COUNT }).map((_, i) => {
        const active = i === scene;
        const fill = Math.max(0, Math.min(1, 1 - Math.abs(sceneProgress - i)));
        return (
          <div
            key={i}
            className="w-[2px] h-8 rounded-full overflow-hidden"
            style={{ background: "rgba(245,243,255,0.12)" }}
          >
            <div
              style={{
                width: "100%",
                height: `${fill * 100}%`,
                background: active
                  ? "linear-gradient(180deg, #a78bfa, #22d3ee)"
                  : "rgba(167,139,250,0.6)",
                transition: "height 200ms ease-out",
              }}
            />
          </div>
        );
      })}
    </div>
  );
}

/**
 * Exported utility: read a normalized 0..1 value representing "how centered
 * on scene N we are right now". Handy for scene-local animations that want
 * to react to proximity rather than a hard on/off.
 */
export function useSceneFocus(index: number) {
  const sp = useInteraction((s) => s.sceneProgress);
  return Math.max(0, 1 - Math.abs(sp - index));
}

// Re-export for convenience.
export { useMotionValue, useSpring, useTransform };
