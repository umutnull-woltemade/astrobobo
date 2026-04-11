/**
 * useSessionPersistence — hydrates the Pro store from a persisted session on
 * mount and throttles writes so the adaptation loop doesn't hit localStorage
 * at 60 fps.
 *
 * We write on a 1.5s leading+trailing rhythm and on visibility change so a
 * quick tab switch still captures the latest state. The hook is additive —
 * skipping it simply means the session doesn't survive reloads.
 */

"use client";

import { useEffect, useRef } from "react";
import { useProStore } from "@/lib/pro/pro-store";
import {
  getSessionAdapter,
  SESSION_VERSION,
  type PersistedSession,
  type SessionAdapter,
} from "@/lib/pro/session-store";

const SAVE_THROTTLE_MS = 1500;

export function useSessionPersistence(adapter: SessionAdapter = getSessionAdapter()) {
  const lastWrite = useRef(0);
  const pending = useRef<number | null>(null);

  useEffect(() => {
    let cancelled = false;

    (async () => {
      const session = await adapter.load();
      if (!session || cancelled) return;
      // Hydrate profile + emotion. We intentionally do NOT restore the
      // directive — it should be recomputed on first tick so the first
      // frame reflects live behavior, not frozen state.
      useProStore.setState((state) => ({
        ...state,
        emotion: session.emotion,
        profile: session.profile,
      }));
    })();

    const writeNow = async () => {
      lastWrite.current = Date.now();
      const { emotion, profile } = useProStore.getState();
      const snapshot: PersistedSession = {
        version: SESSION_VERSION,
        emotion,
        profile,
        writtenAt: Date.now(),
      };
      try {
        await adapter.save(snapshot);
      } catch {
        // adapter is expected to swallow its own errors
      }
    };

    const scheduleWrite = () => {
      const now = Date.now();
      const elapsed = now - lastWrite.current;
      if (elapsed >= SAVE_THROTTLE_MS) {
        writeNow();
        return;
      }
      if (pending.current !== null) return;
      pending.current = window.setTimeout(() => {
        pending.current = null;
        writeNow();
      }, SAVE_THROTTLE_MS - elapsed);
    };

    // Subscribe to store changes. Zustand fires on every setState, but we
    // throttle the actual adapter write.
    const unsub = useProStore.subscribe(() => {
      scheduleWrite();
    });

    const onVisibility = () => {
      if (document.visibilityState === "hidden") writeNow();
    };
    document.addEventListener("visibilitychange", onVisibility);

    return () => {
      cancelled = true;
      unsub();
      if (pending.current !== null) window.clearTimeout(pending.current);
      document.removeEventListener("visibilitychange", onVisibility);
    };
  }, [adapter]);
}
