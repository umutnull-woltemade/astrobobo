import { describe, expect, it } from "vitest";
import {
  computeDirective,
  computeTone,
  defaultDirective,
  type LayoutDirective,
  type SessionProfile,
} from "@/lib/pro/ai-layout-engine";
import { neutralEmotion, type EmotionState } from "@/lib/pro/emotion-scoring";

const emptyProfile: SessionProfile = {
  sessionAgeSec: 0,
  interactionCount: 0,
  mostEngagedNodeId: null,
};

function profile(partial: Partial<SessionProfile>): SessionProfile {
  return { ...emptyProfile, ...partial };
}

function emotion(partial: Partial<EmotionState>): EmotionState {
  return { ...neutralEmotion, ...partial };
}

describe("defaultDirective", () => {
  it("starts in new+calm mode", () => {
    expect(defaultDirective.mode).toBe("new");
    expect(defaultDirective.tone).toBe("calm");
  });
});

describe("computeDirective", () => {
  it("returns new for a fresh session", () => {
    const d: LayoutDirective = computeDirective(neutralEmotion, emptyProfile);
    expect(d.mode).toBe("new");
    expect(d.revealLevel).toBe(0);
    expect(d.collapseSecondary).toBe(false);
  });

  it("returns lost on high confusion", () => {
    const d = computeDirective(
      emotion({ confusion: 0.7, engagement: 0.5 }),
      profile({ interactionCount: 5, sessionAgeSec: 30 })
    );
    expect(d.mode).toBe("lost");
    expect(d.collapseSecondary).toBe(true);
    expect(d.motionIntensity).toBe("calm");
  });

  it("returns power for sustained engagement + many interactions", () => {
    const d = computeDirective(
      emotion({ engagement: 0.75, excitement: 0.6 }),
      profile({ interactionCount: 40, sessionAgeSec: 120 })
    );
    expect(d.mode).toBe("power");
    expect(d.revealLevel).toBe(3);
    expect(d.motionIntensity).toBe("charged");
  });

  it("returns engaged in the middle band", () => {
    const d = computeDirective(
      emotion({ engagement: 0.5, excitement: 0.3 }),
      profile({ interactionCount: 6, sessionAgeSec: 30 })
    );
    expect(d.mode).toBe("engaged");
    expect(d.gravitate).toBe(true);
    expect([1, 2]).toContain(d.revealLevel);
  });

  it("density is in [0,1] and airiness is in [0,1]", () => {
    const samples: EmotionState[] = [
      neutralEmotion,
      emotion({ engagement: 1, excitement: 1 }),
      emotion({ confusion: 1 }),
      emotion({ curiosity: 1 }),
    ];
    for (const e of samples) {
      const d = computeDirective(
        e,
        profile({ interactionCount: 10, sessionAgeSec: 60 })
      );
      expect(d.density).toBeGreaterThanOrEqual(0);
      expect(d.density).toBeLessThanOrEqual(1);
      expect(d.airiness).toBeGreaterThanOrEqual(0);
      expect(d.airiness).toBeLessThanOrEqual(1);
    }
  });

  it("propagates focusNodeId from the profile", () => {
    const d = computeDirective(
      emotion({ engagement: 0.6 }),
      profile({
        interactionCount: 10,
        sessionAgeSec: 60,
        mostEngagedNodeId: "card-3",
      })
    );
    expect(d.focusNodeId).toBe("card-3");
  });
});

describe("computeTone", () => {
  it("lost mode always maps to calm", () => {
    expect(computeTone("lost", neutralEmotion)).toBe("calm");
  });

  it("power mode always maps to oracle", () => {
    expect(computeTone("power", neutralEmotion)).toBe("oracle");
  });

  it("engaged + curious → mystical", () => {
    expect(computeTone("engaged", emotion({ curiosity: 0.7 }))).toBe("mystical");
  });

  it("engaged + task-focused → direct", () => {
    expect(computeTone("engaged", emotion({ curiosity: 0.1 }))).toBe("direct");
  });
});
