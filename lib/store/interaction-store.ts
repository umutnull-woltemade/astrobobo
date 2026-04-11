/**
 * Astrobobo Web Pro — global interaction store.
 *
 * A single Zustand store holds everything the Pro homepage components
 * need to stay in sync: cursor position (normalized 0..1), emotion state,
 * session profile, current scene index, reveal level, hovered node, and
 * portal charge. Components subscribe only to the slices they need.
 *
 * The store is updated by a top-level `<InteractionDriver />` mounted in
 * the homepage which runs the emotion/AI-layout loop on RAF.
 */

"use client";

import { create } from "zustand";
import { neutralEmotion, type EmotionState } from "@/lib/pro/emotion-scoring";
import {
  defaultDirective,
  type LayoutDirective,
  type SessionProfile,
} from "@/lib/pro/ai-layout-engine";

export type Scene = 0 | 1 | 2 | 3 | 4;
/** 0=void, 1=awakening whispers, 2=structure, 3=orbit, 4=portal */
export const SCENE_COUNT = 5;

export type InteractionState = {
  /** Normalized cursor position (0..1 each axis). */
  cursor: { x: number; y: number };
  /** Cursor proximity (0..1) to the central AI core, sampled by AI Core. */
  coreProximity: number;
  /** Current "dimension depth" — scroll is remapped into this 0..4 value. */
  sceneProgress: number;
  /** Integer floor of sceneProgress. */
  scene: Scene;
  /** Smoothed emotion scores. */
  emotion: EmotionState;
  /** Aggregate session profile fed to the AI layout engine. */
  profile: SessionProfile;
  /** Directive from the AI layout engine. */
  directive: LayoutDirective;
  /** 0 = nothing revealed, increases as user engages. */
  revealLevel: 0 | 1 | 2 | 3 | 4;
  /** Hovered orbit-node id, if any. */
  hoveredNodeId: string | null;
  /** 0..1 charge value for the portal CTA. */
  portalCharge: number;
  /** True once the portal warp has fired. */
  portalOpened: boolean;
  /** Set by the WebGL layer once it has mounted and seeded particles. */
  universeReady: boolean;

  setCursor: (x: number, y: number) => void;
  setCoreProximity: (p: number) => void;
  setSceneProgress: (v: number) => void;
  setEmotion: (e: EmotionState) => void;
  setProfile: (p: Partial<SessionProfile>) => void;
  setDirective: (d: LayoutDirective) => void;
  setHoveredNodeId: (id: string | null) => void;
  setPortalCharge: (v: number) => void;
  openPortal: () => void;
  setUniverseReady: (v: boolean) => void;
  bumpInteraction: () => void;
  advanceReveal: () => void;
};

const clamp = (n: number, lo = 0, hi = 1) => Math.min(hi, Math.max(lo, n));

export const useInteraction = create<InteractionState>((set, get) => ({
  cursor: { x: 0.5, y: 0.5 },
  coreProximity: 0,
  sceneProgress: 0,
  scene: 0,
  emotion: neutralEmotion,
  profile: {
    sessionAgeSec: 0,
    interactionCount: 0,
    mostEngagedNodeId: null,
  },
  directive: defaultDirective,
  revealLevel: 0,
  hoveredNodeId: null,
  portalCharge: 0,
  portalOpened: false,
  universeReady: false,

  setCursor: (x, y) => set({ cursor: { x: clamp(x), y: clamp(y) } }),
  setCoreProximity: (p) => set({ coreProximity: clamp(p) }),
  setSceneProgress: (v) => {
    const sp = clamp(v, 0, SCENE_COUNT - 1);
    const scene = Math.min(SCENE_COUNT - 1, Math.floor(sp)) as Scene;
    set({ sceneProgress: sp, scene });
  },
  setEmotion: (e) => set({ emotion: e }),
  setProfile: (p) => set({ profile: { ...get().profile, ...p } }),
  setDirective: (d) => set({ directive: d }),
  setHoveredNodeId: (id) =>
    set({
      hoveredNodeId: id,
      profile: {
        ...get().profile,
        mostEngagedNodeId: id ?? get().profile.mostEngagedNodeId,
      },
    }),
  setPortalCharge: (v) => set({ portalCharge: clamp(v) }),
  openPortal: () => set({ portalOpened: true, portalCharge: 1 }),
  setUniverseReady: (v) => set({ universeReady: v }),
  bumpInteraction: () => {
    const prev = get().profile;
    set({
      profile: {
        ...prev,
        interactionCount: prev.interactionCount + 1,
      },
    });
  },
  advanceReveal: () => {
    const lvl = get().revealLevel;
    if (lvl < 4) set({ revealLevel: (lvl + 1) as InteractionState["revealLevel"] });
  },
}));
