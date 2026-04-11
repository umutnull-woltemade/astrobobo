/**
 * useNodeEngagement — DOM → tracker bridge.
 *
 * Walks up from each event target looking for `[data-pro-node]` and pushes
 * events into the shared tracker. Delegated listeners mean individual
 * components don't need to know the tracker exists — they just mark
 * themselves with an id.
 *
 * Dwell accounting works off a 400ms hover start threshold; shorter
 * mouse-overs don't count so incidental pointer transits don't inflate
 * scores.
 */

"use client";

import { useEffect } from "react";
import { getTracker } from "@/lib/pro/tracker";

const HOVER_DWELL_START_MS = 400;
const NODE_ATTR = "data-pro-node";

function findNodeId(target: EventTarget | null): string | null {
  if (!(target instanceof Element)) return null;
  const el = target.closest(`[${NODE_ATTR}]`);
  return el?.getAttribute(NODE_ATTR) ?? null;
}

export function useNodeEngagement() {
  useEffect(() => {
    if (typeof window === "undefined") return;

    const tracker = getTracker();
    let hoverId: string | null = null;
    let hoverStartedAt = 0;
    let focusedId: string | null = null;

    const flushHover = (now: number) => {
      if (!hoverId) return;
      const dwell = now - hoverStartedAt;
      if (dwell >= HOVER_DWELL_START_MS) {
        tracker.track(hoverId, { type: "dwell", ms: dwell }, now);
      }
      hoverId = null;
      hoverStartedAt = 0;
    };

    const onPointerOver = (e: PointerEvent) => {
      const id = findNodeId(e.target);
      const now = performance.now();
      if (id === hoverId) return;
      flushHover(now);
      if (id) {
        hoverId = id;
        hoverStartedAt = now;
        tracker.track(id, { type: "hover" }, now);
      }
    };

    const onPointerOut = (e: PointerEvent) => {
      const next = findNodeId(e.relatedTarget);
      if (next === hoverId) return;
      flushHover(performance.now());
    };

    const onClick = (e: PointerEvent) => {
      const id = findNodeId(e.target);
      if (!id) return;
      tracker.track(id, { type: "click" }, performance.now());
    };

    const onFocusIn = (e: FocusEvent) => {
      const id = findNodeId(e.target);
      if (!id || id === focusedId) return;
      focusedId = id;
      tracker.track(id, { type: "focus" }, performance.now());
    };

    window.addEventListener("pointerover", onPointerOver, { passive: true });
    window.addEventListener("pointerout", onPointerOut, { passive: true });
    window.addEventListener("pointerdown", onClick, { passive: true });
    window.addEventListener("focusin", onFocusIn, { passive: true });

    return () => {
      window.removeEventListener("pointerover", onPointerOver);
      window.removeEventListener("pointerout", onPointerOut);
      window.removeEventListener("pointerdown", onClick);
      window.removeEventListener("focusin", onFocusIn);
    };
  }, []);
}
