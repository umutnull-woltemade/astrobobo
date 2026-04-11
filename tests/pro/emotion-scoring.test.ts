import { describe, expect, it } from "vitest";
import {
  neutralEmotion,
  stepEmotion,
  type BehaviorSample,
  type EmotionState,
} from "@/lib/pro/emotion-scoring";

const empty: BehaviorSample = {
  pointerVelocity: 0,
  scrollVelocity: 0,
  recentClicks: 0,
  directionFlips: 0,
  idleMs: 0,
  dwellMs: 0,
};

const hot: BehaviorSample = {
  pointerVelocity: 2200,
  scrollVelocity: 1500,
  recentClicks: 5,
  directionFlips: 1,
  idleMs: 50,
  dwellMs: 2000,
};

const rage: BehaviorSample = {
  pointerVelocity: 1600,
  scrollVelocity: 0,
  recentClicks: 7,
  directionFlips: 6,
  idleMs: 0,
  dwellMs: 400,
};

function simulate(
  sample: BehaviorSample,
  ticks: number,
  dtMs = 33,
  start: EmotionState = neutralEmotion
) {
  let state = start;
  for (let i = 0; i < ticks; i++) state = stepEmotion(state, sample, dtMs);
  return state;
}

describe("stepEmotion", () => {
  it("keeps all scores in [0, 1] under sustained heat", () => {
    const state = simulate(hot, 240);
    for (const v of [
      state.excitement,
      state.confusion,
      state.curiosity,
      state.engagement,
    ]) {
      expect(v).toBeGreaterThanOrEqual(0);
      expect(v).toBeLessThanOrEqual(1);
    }
  });

  it("excitement rises with sustained hot input", () => {
    const after = simulate(hot, 90);
    expect(after.excitement).toBeGreaterThan(neutralEmotion.excitement);
  });

  it("idle decays excitement back down", () => {
    const hotState = simulate(hot, 90);
    const cooled = simulate(empty, 300, 33, hotState);
    expect(cooled.excitement).toBeLessThan(hotState.excitement);
  });

  it("rage pattern pushes confusion up", () => {
    const state = simulate(rage, 120);
    expect(state.confusion).toBeGreaterThan(0.2);
  });

  it("idle session keeps confusion near zero", () => {
    const state = simulate(empty, 120);
    expect(state.confusion).toBeLessThan(0.05);
  });

  it("slow curious exploration builds curiosity", () => {
    const slow: BehaviorSample = {
      pointerVelocity: 120,
      scrollVelocity: 80,
      recentClicks: 0,
      directionFlips: 0,
      idleMs: 200,
      dwellMs: 9000,
    };
    const state = simulate(slow, 180);
    expect(state.curiosity).toBeGreaterThan(0.3);
  });
});
