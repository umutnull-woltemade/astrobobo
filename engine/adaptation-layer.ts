/**
 * Astrobobo Web Pro — adaptation layer.
 *
 * A thin, deterministic pipe: BehaviorSample → stepEmotion → computeDirective.
 * The layout orchestrator owns the timing; this file owns the transform.
 *
 * Keeping this stateless (aside from `prev`) means the orchestrator can be
 * tested without React and the same code can run in a worker later.
 */

import {
  type BehaviorSample,
  type EmotionState,
  neutralEmotion,
  stepEmotion,
} from "@/lib/pro/emotion-scoring";
import {
  computeDirective,
  defaultDirective,
  type LayoutDirective,
  type SessionProfile,
  type ToneMode,
} from "@/lib/pro/ai-layout-engine";

export type AdaptationInput = {
  sample: BehaviorSample;
  dtMs: number;
  profile: SessionProfile;
  /** External override — forces `directive.tone` when set. */
  overrideTone?: ToneMode | null;
};

export type AdaptationOutput = {
  emotion: EmotionState;
  directive: LayoutDirective;
};

export function adapt(
  prev: EmotionState,
  input: AdaptationInput
): AdaptationOutput {
  const emotion = stepEmotion(prev, input.sample, input.dtMs);
  const base = computeDirective(emotion, input.profile);
  const directive = input.overrideTone
    ? { ...base, tone: input.overrideTone }
    : base;
  return { emotion, directive };
}

export const initialAdaptation: AdaptationOutput = {
  emotion: neutralEmotion,
  directive: defaultDirective,
};
