/**
 * useAIState / useProEngine — React bindings for the layout orchestrator.
 *
 * `useProEngine` mounts the orchestrator once per page and runs the RAF loop.
 * `useAIState` is a thin selector that returns the current directive + emotion
 * so components don't need to know about zustand at all.
 */

"use client";

import { useEffect, useRef } from "react";
import { createOrchestrator } from "@/engine/layout-orchestrator";
import { useProStore } from "@/lib/pro/pro-store";
import type { LayoutDirective } from "@/lib/pro/ai-layout-engine";
import type { EmotionState } from "@/lib/pro/emotion-scoring";

export function useProEngine() {
  const started = useRef(false);

  useEffect(() => {
    if (started.current) return;
    started.current = true;

    const handle = createOrchestrator({
      getSample: () => useProStore.getState().sample,
      getProfile: () => useProStore.getState().profile,
      getEmotion: () => useProStore.getState().emotion,
      pushAdaptation: (next) => useProStore.getState().setAdaptation(next),
      pushMostEngaged: (nodeId) =>
        useProStore.getState().patchProfile({ mostEngagedNodeId: nodeId }),
      pushRanking: (ranking) =>
        useProStore.getState().setEngagementRanking(ranking),
      pushScores: (scores) =>
        useProStore.getState().setEngagementScores(scores),
      getOverrideTone: () =>
        useProStore.getState().remoteSignals.overrideTone,
    });
    handle.start();

    return () => {
      handle.stop();
      started.current = false;
    };
  }, []);
}

export function useDirective(): LayoutDirective {
  return useProStore((s) => s.directive);
}

export function useEmotion(): EmotionState {
  return useProStore((s) => s.emotion);
}

/**
 * Convenience hook that composes directive + emotion.
 * We call the two atom hooks separately so zustand's per-slice Object.is
 * check runs against primitives we control, instead of a fresh object.
 */
export function useAIState(): {
  directive: LayoutDirective;
  emotion: EmotionState;
} {
  const directive = useDirective();
  const emotion = useEmotion();
  return { directive, emotion };
}
