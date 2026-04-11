/**
 * Astrobobo Web Pro — zustand store.
 *
 * Single source of truth for the adaptive UI:
 *   - behavior sample (written by useUserBehavior)
 *   - session profile (written by engagement tracker + counters)
 *   - emotion state + directive (written by the orchestrator)
 *   - cursor + ripples (written by pointer/click handlers, read by scene)
 *
 * Components subscribe via narrow selectors so a pointer move doesn't
 * re-render every glass card on screen.
 */

"use client";

import { create } from "zustand";
import {
  type BehaviorSample,
  type EmotionState,
  neutralEmotion,
} from "./emotion-scoring";
import {
  defaultDirective,
  type LayoutDirective,
  type SessionProfile,
  type ToneMode,
} from "./ai-layout-engine";
import type { InvariantReport } from "./invariants";
import type { Locale } from "@/lib/i18n/config";

const emptySample: BehaviorSample = {
  pointerVelocity: 0,
  scrollVelocity: 0,
  recentClicks: 0,
  directionFlips: 0,
  idleMs: 0,
  dwellMs: 0,
};

const emptyProfile: SessionProfile = {
  sessionAgeSec: 0,
  interactionCount: 0,
  mostEngagedNodeId: null,
};

/**
 * Remote signals — external directives that override the behavior-derived
 * layout. Populated by cookies, A/B cohorts, or server-injected flags.
 * The adaptation layer reads this every tick; a non-null `overrideTone`
 * forces `directive.tone` regardless of what the classifier says.
 */
export type RemoteSignals = {
  overrideTone: ToneMode | null;
  cohortCtr: number | null;
  /** Active cohort slug (e.g. "whisper", "oracle-beta"), or null. */
  cohort: string | null;
};

export const emptyRemoteSignals: RemoteSignals = {
  overrideTone: null,
  cohortCtr: null,
  cohort: null,
};

type ProState = {
  locale: Locale;
  sample: BehaviorSample;
  profile: SessionProfile;
  emotion: EmotionState;
  directive: LayoutDirective;
  cursor: { x: number; y: number };
  remoteSignals: RemoteSignals;
  /**
   * Top-N most-engaged node ids, updated by the orchestrator only when the
   * ranking changes. Components use it to reorder themselves without
   * subscribing to per-tick score changes.
   */
  engagementRanking: string[];
  /**
   * Same top-N, but with normalized scores ∈ [0,1] for HUD visualization.
   * Pushed on the same debounced cadence as `engagementRanking`.
   */
  engagementScores: { id: string; score: number }[];
  /** Last invariant-check report. Populated by useInvariants in dev. */
  invariants: InvariantReport | null;
  setSample: (s: BehaviorSample) => void;
  setProfile: (p: SessionProfile) => void;
  patchProfile: (patch: Partial<SessionProfile>) => void;
  setAdaptation: (next: { emotion: EmotionState; directive: LayoutDirective }) => void;
  setCursor: (x: number, y: number) => void;
  setEngagementRanking: (ranking: string[]) => void;
  setEngagementScores: (scores: { id: string; score: number }[]) => void;
  setLocale: (locale: Locale) => void;
  setRemoteSignals: (patch: Partial<RemoteSignals>) => void;
  setInvariants: (report: InvariantReport) => void;
};

export const useProStore = create<ProState>((set) => ({
  locale: "en",
  sample: emptySample,
  profile: emptyProfile,
  emotion: neutralEmotion,
  directive: defaultDirective,
  cursor: { x: 0.5, y: 0.5 },
  remoteSignals: emptyRemoteSignals,
  engagementRanking: [],
  engagementScores: [],
  invariants: null,
  setSample: (sample) => set({ sample }),
  setProfile: (profile) => set({ profile }),
  patchProfile: (patch) =>
    set((state) => ({ profile: { ...state.profile, ...patch } })),
  setAdaptation: ({ emotion, directive }) => set({ emotion, directive }),
  setCursor: (x, y) => set({ cursor: { x, y } }),
  setEngagementRanking: (engagementRanking) => set({ engagementRanking }),
  setEngagementScores: (engagementScores) => set({ engagementScores }),
  setLocale: (locale) => set({ locale }),
  setRemoteSignals: (patch) =>
    set((state) => ({ remoteSignals: { ...state.remoteSignals, ...patch } })),
  setInvariants: (invariants) => set({ invariants }),
}));
