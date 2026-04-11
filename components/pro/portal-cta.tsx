/**
 * Astrobobo Web Pro — Portal CTA.
 *
 * The final scene's "button" — a glowing circular gate with a rotating
 * energy ring that reacts to cursor proximity. Holding the cursor over
 * the gate charges a ring meter; once charge reaches 1 the portal
 * triggers a warp transition and navigates into the live app. Clicking
 * accelerates the charge.
 */

"use client";

import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";
import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useInteraction } from "@/lib/store/interaction-store";
import { proEase } from "@/lib/pro/motion-config";

const PORTAL_SIZE = 340;

export default function PortalCTA({
  locale,
  targetHref,
}: {
  locale: "en" | "tr";
  targetHref: string;
}) {
  const rootRef = useRef<HTMLDivElement>(null);
  const charge = useMotionValue(0);
  const smoothCharge = useSpring(charge, { stiffness: 120, damping: 20, mass: 0.6 });
  const [warping, setWarping] = useState(false);
  const openPortal = useInteraction((s) => s.openPortal);
  const portalCharge = useInteraction((s) => s.portalCharge);
  const setPortalCharge = useInteraction((s) => s.setPortalCharge);
  const bumpInteraction = useInteraction((s) => s.bumpInteraction);
  const router = useRouter();

  useEffect(() => {
    router.prefetch(targetHref);
  }, [router, targetHref]);

  const ringRotation = useMotionValue(0);
  const scale = useTransform(smoothCharge, [0, 1], [1, 1.12]);
  const innerOpacity = useTransform(smoothCharge, [0, 1], [0.55, 1]);
  const ringGlow = useTransform(smoothCharge, [0, 1], [0.25, 1]);

  useEffect(() => {
    let raf = 0;
    let last = performance.now();
    let hovering = false;

    const el = rootRef.current;
    if (!el) return;

    const onEnter = () => {
      hovering = true;
    };
    const onLeave = () => {
      hovering = false;
    };
    const onClick = () => {
      bumpInteraction();
      charge.set(Math.min(1, charge.get() + 0.25));
    };

    el.addEventListener("mouseenter", onEnter);
    el.addEventListener("mouseleave", onLeave);
    el.addEventListener("click", onClick);

    const loop = (t: number) => {
      const dt = (t - last) / 1000;
      last = t;
      ringRotation.set(ringRotation.get() + dt * 22);

      // Use proximity to bleed charge in when the cursor is close, bleed out otherwise.
      const { coreProximity } = useInteraction.getState();
      // Use hovering state AND direct cursor proximity via getBoundingClientRect
      if (!el) return;
      const rect = el.getBoundingClientRect();
      const cx = (rect.left + rect.right) / 2;
      const cy = (rect.top + rect.bottom) / 2;
      const { cursor } = useInteraction.getState();
      const px = cursor.x * window.innerWidth;
      const py = cursor.y * window.innerHeight;
      const dist = Math.sqrt((px - cx) ** 2 + (py - cy) ** 2);
      const near = Math.max(0, 1 - dist / 260);
      const influence = Math.max(near, hovering ? 0.55 : 0) + coreProximity * 0.05;

      const next = hovering || near > 0.35
        ? Math.min(1, charge.get() + dt * (0.35 + influence * 0.7))
        : Math.max(0, charge.get() - dt * 0.5);
      charge.set(next);
      setPortalCharge(next);

      if (next >= 0.995 && !warping) {
        setWarping(true);
        openPortal();
        // Defer client-side navigation so the warp flash has time to render.
        window.setTimeout(() => {
          router.push(targetHref);
        }, 900);
      }

      raf = requestAnimationFrame(loop);
    };
    raf = requestAnimationFrame(loop);

    return () => {
      cancelAnimationFrame(raf);
      el.removeEventListener("mouseenter", onEnter);
      el.removeEventListener("mouseleave", onLeave);
      el.removeEventListener("click", onClick);
    };
  }, [charge, ringRotation, openPortal, setPortalCharge, bumpInteraction, targetHref, warping, router]);

  const label = locale === "tr" ? "ASTROBOBO'YA GİR" : "ENTER ASTROBOBO";
  const hint =
    locale === "tr"
      ? "Kapıyı açmak için yaklaşın"
      : "Approach the gate to open";

  return (
    <div className="relative flex flex-col items-center justify-center">
      <motion.div
        ref={rootRef}
        className="relative pointer-events-auto cursor-pointer"
        style={{ width: PORTAL_SIZE, height: PORTAL_SIZE, scale }}
      >
        {/* Outer energy ring */}
        <motion.div
          className="absolute inset-[-30px] rounded-full"
          style={{
            rotate: ringRotation,
            background:
              "conic-gradient(from 0deg, rgba(34,211,238,0) 0deg, rgba(124,58,237,0.85) 80deg, rgba(34,211,238,0.95) 200deg, rgba(34,211,238,0) 360deg)",
            maskImage:
              "radial-gradient(closest-side, transparent 70%, black 72%, black 82%, transparent 84%)",
            WebkitMaskImage:
              "radial-gradient(closest-side, transparent 70%, black 72%, black 82%, transparent 84%)",
            opacity: ringGlow,
          }}
        />

        {/* Charge arc */}
        <svg
          className="absolute inset-0 -rotate-90"
          viewBox="0 0 100 100"
          aria-hidden
        >
          <circle
            cx="50"
            cy="50"
            r="47"
            fill="none"
            stroke="rgba(245,243,255,0.1)"
            strokeWidth="1"
          />
          <motion.circle
            cx="50"
            cy="50"
            r="47"
            fill="none"
            stroke="url(#portalGrad)"
            strokeWidth="1.5"
            strokeLinecap="round"
            pathLength={1}
            style={{ pathLength: smoothCharge }}
          />
          <defs>
            <linearGradient id="portalGrad" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0" stopColor="#a78bfa" />
              <stop offset="1" stopColor="#22d3ee" />
            </linearGradient>
          </defs>
        </svg>

        {/* Portal well */}
        <motion.div
          className="absolute inset-[8%] rounded-full"
          style={{
            opacity: innerOpacity,
            background:
              "radial-gradient(circle at 50% 50%, rgba(34,211,238,0.18) 0%, rgba(124,58,237,0.35) 35%, rgba(12,4,28,0.9) 70%, #000 100%)",
            boxShadow:
              "inset 0 0 80px rgba(124,58,237,0.45), 0 0 80px rgba(34,211,238,0.35)",
            backdropFilter: "blur(18px)",
            WebkitBackdropFilter: "blur(18px)",
          }}
        />

        {/* Inner label */}
        <div className="absolute inset-0 flex items-center justify-center">
          <motion.span
            className="text-center"
            style={{
              fontFamily: "\"Space Grotesk\", Inter, sans-serif",
              fontSize: 14,
              letterSpacing: "0.32em",
              color: "#f5f3ff",
              textShadow: "0 0 18px rgba(124,58,237,0.9)",
            }}
            animate={{
              opacity: [0.75, 1, 0.75],
            }}
            transition={{ duration: 3.2, repeat: Infinity, ease: "easeInOut" }}
          >
            {label}
          </motion.span>
        </div>

        {/* Pulse ring on charge threshold */}
        <motion.div
          className="absolute inset-0 rounded-full pointer-events-none"
          style={{
            border: "1px solid rgba(34,211,238,0.6)",
            opacity: useTransform(smoothCharge, [0.7, 1], [0, 0.9]),
          }}
          animate={{
            scale: [1, 1.12, 1],
          }}
          transition={{ duration: 1.4, repeat: Infinity, ease: "easeInOut" }}
        />
      </motion.div>

      <motion.p
        className="mt-12 text-xs tracking-[0.28em] uppercase"
        style={{
          fontFamily: "\"Space Grotesk\", Inter, sans-serif",
          color: "rgba(245,243,255,0.55)",
        }}
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: portalCharge < 0.2 ? 1 : 0.25, y: 0 }}
        transition={{ duration: 0.8, ease: proEase }}
      >
        {hint}
      </motion.p>

      {/* Warp overlay */}
      <motion.div
        className="fixed inset-0 z-50 pointer-events-none"
        initial={{ opacity: 0 }}
        animate={{ opacity: warping ? 1 : 0 }}
        transition={{ duration: 0.6 }}
        style={{
          background:
            "radial-gradient(circle at center, rgba(245,243,255,0.95) 0%, rgba(34,211,238,0.85) 20%, rgba(124,58,237,0.7) 40%, #000 80%)",
        }}
      />
    </div>
  );
}
