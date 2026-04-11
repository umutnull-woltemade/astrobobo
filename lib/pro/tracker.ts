/**
 * Astrobobo Web Pro — tracker singleton.
 *
 * One `EngagementTracker` per browser session, reused across the orchestrator
 * and DOM delegated listeners. Kept out of the zustand store because the
 * tracker is a class with methods — the store stays a pure data snapshot.
 */

import { EngagementTracker } from "@/engine/engagement-tracker";

let instance: EngagementTracker | null = null;

export function getTracker(): EngagementTracker {
  if (!instance) instance = new EngagementTracker();
  return instance;
}

/** Test hook — resets the singleton between test runs. */
export function resetTracker() {
  instance = null;
}
