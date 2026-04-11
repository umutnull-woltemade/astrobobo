/**
 * useUserBehavior — captures raw pointer / scroll / click activity and
 * condenses it into a `BehaviorSample` pushed to the Pro store ~30 Hz.
 *
 * Kept free of React state so pointer moves don't trigger renders; the store
 * is the only place where the sample lives.
 */

"use client";

import { useEffect } from "react";
import type { BehaviorSample } from "@/lib/pro/emotion-scoring";
import { useProStore } from "@/lib/pro/pro-store";

const SAMPLE_INTERVAL = 33;

export function useUserBehavior() {
  const setSample = useProStore((s) => s.setSample);
  const setCursor = useProStore((s) => s.setCursor);
  const setProfile = useProStore((s) => s.setProfile);

  useEffect(() => {
    if (typeof window === "undefined") return;

    let lastX = 0;
    let lastY = 0;
    let lastMoveTs = performance.now();
    let lastDirX = 0;
    let lastDirY = 0;
    let flipCount = 0;

    let pointerVelocity = 0;
    let scrollVelocity = 0;
    let lastScrollY = window.scrollY;
    let lastScrollTs = performance.now();

    const clickTimestamps: number[] = [];
    const flipTimestamps: number[] = [];

    let lastActivityTs = performance.now();
    let dwellStart = performance.now();

    const sessionStart = performance.now();
    let interactionCount = 0;

    const handlePointer = (e: PointerEvent) => {
      const now = performance.now();
      const dt = Math.max(now - lastMoveTs, 1);
      const dx = e.clientX - lastX;
      const dy = e.clientY - lastY;
      pointerVelocity = Math.hypot(dx, dy) / (dt / 1000);
      lastX = e.clientX;
      lastY = e.clientY;
      lastMoveTs = now;
      lastActivityTs = now;

      const dirX = Math.sign(dx);
      const dirY = Math.sign(dy);
      if (
        (dirX !== 0 && dirX !== lastDirX) ||
        (dirY !== 0 && dirY !== lastDirY)
      ) {
        flipCount++;
        flipTimestamps.push(now);
      }
      lastDirX = dirX || lastDirX;
      lastDirY = dirY || lastDirY;

      const nx = e.clientX / window.innerWidth;
      const ny = e.clientY / window.innerHeight;
      setCursor(nx, ny);
      document.documentElement.style.setProperty("--pro-mx", `${nx * 100}%`);
      document.documentElement.style.setProperty("--pro-my", `${ny * 100}%`);
    };

    const handleScroll = () => {
      const now = performance.now();
      const dt = Math.max(now - lastScrollTs, 1);
      scrollVelocity = ((window.scrollY - lastScrollY) / dt) * 1000;
      lastScrollY = window.scrollY;
      lastScrollTs = now;
      lastActivityTs = now;
    };

    const handleClick = () => {
      const now = performance.now();
      clickTimestamps.push(now);
      interactionCount++;
      lastActivityTs = now;
    };

    const handleKey = () => {
      interactionCount++;
      lastActivityTs = performance.now();
    };

    const prune = (arr: number[], window: number, now: number) => {
      while (arr.length && now - arr[0] > window) arr.shift();
    };

    const interval = window.setInterval(() => {
      const now = performance.now();
      prune(clickTimestamps, 2000, now);
      prune(flipTimestamps, 1500, now);

      // Decay pointer velocity when idle.
      if (now - lastMoveTs > 120) pointerVelocity *= 0.6;
      if (now - lastScrollTs > 120) scrollVelocity *= 0.6;

      const idleMs = now - lastActivityTs;
      if (idleMs > 1200) dwellStart = now - idleMs;
      const dwellMs = now - dwellStart;

      const sample: BehaviorSample = {
        pointerVelocity,
        scrollVelocity,
        recentClicks: clickTimestamps.length,
        directionFlips: flipTimestamps.length,
        idleMs,
        dwellMs,
      };
      setSample(sample);

      setProfile({
        sessionAgeSec: (now - sessionStart) / 1000,
        interactionCount,
        mostEngagedNodeId: null,
      });
    }, SAMPLE_INTERVAL);

    window.addEventListener("pointermove", handlePointer, { passive: true });
    window.addEventListener("scroll", handleScroll, { passive: true });
    window.addEventListener("pointerdown", handleClick, { passive: true });
    window.addEventListener("keydown", handleKey, { passive: true });

    return () => {
      window.clearInterval(interval);
      window.removeEventListener("pointermove", handlePointer);
      window.removeEventListener("scroll", handleScroll);
      window.removeEventListener("pointerdown", handleClick);
      window.removeEventListener("keydown", handleKey);
    };
  }, [setSample, setCursor, setProfile]);
}
