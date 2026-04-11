/**
 * Astrobobo Web Pro — scene chunk prefetch.
 *
 * The Three.js scene chunk is lazy-loaded via next/dynamic. The tradeoff
 * is a short loading state on first Pro navigation. We fix it by kicking
 * the import on hover/focus intent so the chunk is warm by the time the
 * user clicks.
 *
 * Usage:
 *
 *   const handlers = usePrefetchScene();
 *   <Link href="/universe" {...handlers}>Enter</Link>
 *
 * or use the ProPrefetchLink wrapper for the common case.
 */

"use client";

import { useCallback, useRef } from "react";

let prefetched = false;

/**
 * Kick the dynamic import for `./scene`. Idempotent — subsequent calls
 * are no-ops. Safe to call from any event handler.
 */
export function prefetchScene() {
  if (prefetched) return;
  prefetched = true;
  // Fire-and-forget. We intentionally don't await — the browser will
  // have cached the chunk by the time the user lands on the Pro route.
  import("./scene").catch(() => {
    // Reset on failure so a retry can attempt the import again.
    prefetched = false;
  });
}

/**
 * React hook that returns event handlers ready to spread onto a link.
 * Uses a ref guard so rapid pointer events only trigger one import.
 */
export function usePrefetchScene() {
  const triggered = useRef(false);
  const handle = useCallback(() => {
    if (triggered.current) return;
    triggered.current = true;
    prefetchScene();
  }, []);
  return {
    onPointerEnter: handle,
    onFocus: handle,
    onTouchStart: handle,
  };
}
