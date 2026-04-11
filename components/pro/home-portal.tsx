/**
 * Astrobobo Web Pro — Home portal composition.
 *
 * Single client component that assembles the cinematic entry experience:
 *
 *   EntryField (WebGL particles) ← fixed background, -z
 *   CursorTracker                 ← pushes mouse → store + CSS vars
 *   InteractionDriver             ← emotion + AI layout RAF loop
 *   SceneScroll
 *     Scene 0 Void        → nothing, just the core visible
 *     Scene 1 Formation   → core + first whispers
 *     Scene 2 Structure   → core + later whispers + orbit rings
 *     Scene 3 Expansion   → orbit nodes become interactive
 *     Scene 4 Decision    → portal gate
 *
 * The WebGL layer is dynamic-imported with `ssr: false` so Three.js never
 * runs during the server render.
 */

"use client";

import { useEffect, useRef, useState } from "react";
import dynamic from "next/dynamic";
import { useRouter } from "next/navigation";
import { computeDirective } from "@/lib/pro/ai-layout-engine";
import { stepEmotion, type BehaviorSample } from "@/lib/pro/emotion-scoring";
import { useInteraction } from "@/lib/store/interaction-store";
import AICore from "./ai-core";
import MicroReveals from "./micro-reveals";
import OrbitSystem from "./orbit-system";
import PortalCTA from "./portal-cta";
import { Scene, SceneScroll, useSceneFocus } from "./scene-scroll";

const EntryField = dynamic(() => import("./entry-field"), {
  ssr: false,
  loading: () => (
    <div
      aria-hidden
      className="pointer-events-none fixed inset-0 z-0"
      style={{
        background:
          "radial-gradient(ellipse at top, #0b0618 0%, #05010a 60%, #000 100%)",
      }}
    >
      {/* Static drift fallback so there is never a black frame before
          Three.js hydrates. Pure CSS, no JS, GPU-friendly. */}
      <div
        className="absolute inset-0 opacity-60"
        style={{
          background:
            "radial-gradient(600px circle at 50% 40%, rgba(124,58,237,0.28), transparent 60%)",
          filter: "blur(2px)",
        }}
      />
    </div>
  ),
});

/** Reads `prefers-reduced-motion` and updates on change. */
function useReducedMotion() {
  const [reduced, setReduced] = useState(false);
  useEffect(() => {
    const mq = window.matchMedia("(prefers-reduced-motion: reduce)");
    const update = () => setReduced(mq.matches);
    update();
    mq.addEventListener("change", update);
    return () => mq.removeEventListener("change", update);
  }, []);
  return reduced;
}

function CursorTracker() {
  const setCursor = useInteraction((s) => s.setCursor);
  useEffect(() => {
    let raf = 0;
    let pending: { x: number; y: number } | null = null;
    const onMove = (e: MouseEvent) => {
      pending = { x: e.clientX / window.innerWidth, y: e.clientY / window.innerHeight };
      if (!raf) {
        raf = requestAnimationFrame(() => {
          if (pending) {
            setCursor(pending.x, pending.y);
            document.documentElement.style.setProperty("--pro-mx", `${pending.x * 100}%`);
            document.documentElement.style.setProperty("--pro-my", `${pending.y * 100}%`);
          }
          raf = 0;
        });
      }
    };
    const onTouch = (e: TouchEvent) => {
      const t = e.touches[0];
      if (!t) return;
      setCursor(t.clientX / window.innerWidth, t.clientY / window.innerHeight);
    };
    window.addEventListener("mousemove", onMove, { passive: true });
    window.addEventListener("touchmove", onTouch, { passive: true });
    return () => {
      window.removeEventListener("mousemove", onMove);
      window.removeEventListener("touchmove", onTouch);
      if (raf) cancelAnimationFrame(raf);
    };
  }, [setCursor]);
  return null;
}

function InteractionDriver() {
  const behaviorRef = useRef<BehaviorSample>({
    pointerVelocity: 0,
    scrollVelocity: 0,
    recentClicks: 0,
    directionFlips: 0,
    idleMs: 0,
    dwellMs: 0,
  });
  const lastCursorRef = useRef({ x: 0.5, y: 0.5, t: performance.now() });
  const clicksRef = useRef<number[]>([]);
  const lastInteractRef = useRef(performance.now());
  const sessionStartRef = useRef(performance.now());

  useEffect(() => {
    const onClick = () => {
      clicksRef.current.push(performance.now());
      lastInteractRef.current = performance.now();
    };
    window.addEventListener("click", onClick);
    return () => window.removeEventListener("click", onClick);
  }, []);

  useEffect(() => {
    let raf = 0;
    let last = performance.now();

    const loop = (t: number) => {
      const dtMs = t - last;
      last = t;

      const state = useInteraction.getState();
      // Pointer velocity from delta since last frame.
      const dxNorm = state.cursor.x - lastCursorRef.current.x;
      const dyNorm = state.cursor.y - lastCursorRef.current.y;
      const px = dxNorm * window.innerWidth;
      const py = dyNorm * window.innerHeight;
      const distPx = Math.sqrt(px * px + py * py);
      const velocity = distPx / Math.max(0.001, dtMs / 1000);
      lastCursorRef.current = { x: state.cursor.x, y: state.cursor.y, t };

      // Recent clicks — keep a 2s window.
      const now = t;
      clicksRef.current = clicksRef.current.filter((c) => now - c < 2000);
      const recentClicks = clicksRef.current.length;

      if (distPx > 2) lastInteractRef.current = t;
      const idleMs = t - lastInteractRef.current;
      // Dwell: time since session start when scene hasn't advanced.
      const dwellMs = t - sessionStartRef.current;

      const sample: BehaviorSample = {
        pointerVelocity: velocity,
        scrollVelocity: 0,
        recentClicks,
        directionFlips: 0,
        idleMs,
        dwellMs,
      };
      behaviorRef.current = sample;

      const nextEmotion = stepEmotion(state.emotion, sample, dtMs);
      state.setEmotion(nextEmotion);

      const nextProfile = {
        ...state.profile,
        sessionAgeSec: (t - sessionStartRef.current) / 1000,
      };
      state.setProfile(nextProfile);

      const directive = computeDirective(nextEmotion, nextProfile);
      state.setDirective(directive);

      raf = requestAnimationFrame(loop);
    };
    raf = requestAnimationFrame(loop);
    return () => cancelAnimationFrame(raf);
  }, []);

  return null;
}

export default function HomePortal({
  locale,
  targetHref,
}: {
  locale: "en" | "tr";
  targetHref: string;
}) {
  const reduced = useReducedMotion();
  const router = useRouter();

  // Warm up the warp target so the transition feels instant.
  useEffect(() => {
    router.prefetch(targetHref);
  }, [router, targetHref]);

  // Reduced-motion fallback: a still, dignified entry with the same
  // palette but no animation, no wheel hijack, no WebGL. Users keep
  // their normal scroll to the SEO continuation below.
  if (reduced) {
    return (
      <div
        className="pro-root relative w-full min-h-[70vh] flex flex-col items-center justify-center px-6 py-24"
        style={{
          background:
            "radial-gradient(ellipse at top, #0b0618 0%, #05010a 60%, #000 100%)",
        }}
      >
        <div
          className="rounded-full"
          style={{
            width: 180,
            height: 180,
            background:
              "radial-gradient(circle at 35% 30%, #f5f3ff 0%, #c4b5fd 18%, #7c3aed 48%, #1e1b4b 78%, #000 100%)",
            boxShadow: "0 0 80px rgba(124,58,237,0.5)",
          }}
          aria-hidden
        />
        <h1
          className="mt-10 text-center"
          style={{
            fontFamily: "\"Space Grotesk\", Inter, sans-serif",
            fontSize: 32,
            letterSpacing: "-0.02em",
            color: "#f5f3ff",
          }}
        >
          Astrobobo
        </h1>
        <p
          className="mt-3 text-center text-sm"
          style={{ color: "rgba(245,243,255,0.65)" }}
        >
          {locale === "tr"
            ? "Yaşayan bir astroloji sistemi."
            : "A living astrology system."}
        </p>
        <a
          href={targetHref}
          className="mt-10 pro-glass pro-stroke-gradient px-6 py-3 uppercase tracking-[0.3em] text-xs"
          style={{
            color: "#f5f3ff",
            borderRadius: 999,
            fontFamily: "\"Space Grotesk\", Inter, sans-serif",
          }}
        >
          {locale === "tr" ? "Astrobobo'ya Gir" : "Enter Astrobobo"}
        </a>
      </div>
    );
  }

  return (
    <div className="pro-root relative w-full">
      {/* Fixed cosmic void */}
      <EntryField />

      <CursorTracker />
      <InteractionDriver />

      {/* Dimensional scene stack */}
      <SceneScroll>
        <Scene index={0}>
          <CoreAnchor />
        </Scene>

        <Scene index={1}>
          <CoreAnchor />
          <MicroReveals locale={locale} />
        </Scene>

        <Scene index={2}>
          <CoreAnchor small />
          <MicroReveals locale={locale} />
          <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
            <OrbitSystem locale={locale} />
          </div>
        </Scene>

        <Scene index={3}>
          <OrbitSystem locale={locale} />
        </Scene>

        <Scene index={4}>
          <PortalCTA locale={locale} targetHref={targetHref} />
        </Scene>
      </SceneScroll>

      {/* Scroll hint for scene 0 — disappears after first interaction */}
      <ScrollHint locale={locale} />
    </div>
  );
}

function CoreAnchor({ small = false }: { small?: boolean }) {
  const focus0 = useSceneFocus(0);
  const scale = small ? 0.55 : 1 - (1 - focus0) * 0.1;
  return (
    <div
      className="flex items-center justify-center"
      style={{ transform: `scale(${scale})`, transition: "transform 600ms cubic-bezier(0.22,1,0.36,1)" }}
    >
      <AICore />
    </div>
  );
}

function ScrollHint({ locale }: { locale: "en" | "tr" }) {
  const revealLevel = useInteraction((s) => s.revealLevel);
  const visible = revealLevel === 0;
  const text = locale === "tr" ? "KAYDIRIN · HAREKET EDİN" : "SCROLL · MOVE";
  return (
    <div
      className="absolute bottom-10 left-1/2 -translate-x-1/2 text-[10px] tracking-[0.5em] z-30 pointer-events-none"
      style={{
        color: "rgba(245,243,255,0.35)",
        fontFamily: "\"Space Grotesk\", Inter, sans-serif",
        opacity: visible ? 1 : 0,
        transition: "opacity 1.6s cubic-bezier(0.22,1,0.36,1)",
      }}
    >
      {text}
    </div>
  );
}
