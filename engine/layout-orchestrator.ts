/**
 * Astrobobo Web Pro — layout orchestrator.
 *
 * Owns the adaptation loop. Ticks on `requestAnimationFrame`, reads the
 * shared zustand store for the current behavior sample + session profile,
 * pushes the next emotion + directive back into the store, and ticks the
 * engagement tracker decay.
 *
 * Only one instance should run per page. `useProEngine` in
 * hooks/useAIState.ts starts/stops it via React's lifecycle.
 */

import { adapt, initialAdaptation } from "./adaptation-layer";
import type { EngagementTracker } from "./engagement-tracker";
import { getTracker } from "@/lib/pro/tracker";
import type { BehaviorSample, EmotionState } from "@/lib/pro/emotion-scoring";
import type { SessionProfile, ToneMode } from "@/lib/pro/ai-layout-engine";

export type OrchestratorHandle = {
  start: () => void;
  stop: () => void;
  tracker: EngagementTracker;
};

export type OrchestratorBridge = {
  getSample: () => BehaviorSample;
  getProfile: () => SessionProfile;
  getEmotion: () => EmotionState;
  pushAdaptation: (next: ReturnType<typeof adapt>) => void;
  /** Write the currently most-engaged node id back into the profile. */
  pushMostEngaged?: (nodeId: string | null) => void;
  /** Write the top-N engagement ranking into the store. */
  pushRanking?: (ranking: string[]) => void;
  /** Write the top-N ranking with normalized scores into the store. */
  pushScores?: (scores: { id: string; score: number }[]) => void;
  /** Optional external override — forces directive.tone every tick. */
  getOverrideTone?: () => ToneMode | null;
};

export function createOrchestrator(bridge: OrchestratorBridge): OrchestratorHandle {
  const tracker = getTracker();
  let rafId: number | null = null;
  let last = 0;
  let lastRankingKey = "";
  let lastRankingPushedAt = 0;

  const tick = (now: number) => {
    const dtMs = last === 0 ? 16 : now - last;
    last = now;
    tracker.tick(now);

    const sample = bridge.getSample();
    const profile = bridge.getProfile();
    const prev = bridge.getEmotion();
    const overrideTone = bridge.getOverrideTone?.() ?? null;
    const next = adapt(prev, { sample, dtMs, profile, overrideTone });
    bridge.pushAdaptation(next);

    const top = tracker.mostEngaged();
    if (top !== profile.mostEngagedNodeId && bridge.pushMostEngaged) {
      bridge.pushMostEngaged(top);
    }

    // Rebuild + push the top-N ranking, but only when the ordering
    // actually changes and never more than twice per second. This keeps
    // the adaptive container off the fast update path.
    if (bridge.pushRanking && now - lastRankingPushedAt > 500) {
      const topEntries = tracker.top(12);
      const ranking = topEntries.map((n) => n.id);
      const key = ranking.join("|");
      if (key !== lastRankingKey) {
        lastRankingKey = key;
        lastRankingPushedAt = now;
        bridge.pushRanking(ranking);
        if (bridge.pushScores) {
          const maxScore = topEntries[0]?.score ?? 1;
          const divisor = maxScore > 0 ? maxScore : 1;
          bridge.pushScores(
            topEntries.map((n) => ({
              id: n.id,
              score: Math.min(1, n.score / divisor),
            }))
          );
        }
      }
    }

    rafId = requestAnimationFrame(tick);
  };

  return {
    tracker,
    start() {
      if (rafId !== null) return;
      last = 0;
      rafId = requestAnimationFrame(tick);
    },
    stop() {
      if (rafId !== null) cancelAnimationFrame(rafId);
      rafId = null;
    },
  };
}

export { initialAdaptation };
