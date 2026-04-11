import { describe, expect, it } from "vitest";
import {
  TONE_MODES,
  COVARA_TONE_MODES,
  astroboboToCovara,
  classifyTone,
  covaraToAstrobobo,
  validateToneContract,
  type BehaviorVector,
} from "@astrobobo/pro-tone";

const base: BehaviorVector = {
  engagement: 0,
  excitement: 0,
  curiosity: 0,
  confusion: 0,
  interactionCount: 0,
};

describe("tone-bridge mappers", () => {
  it("covers all four Astrobobo modes", () => {
    expect(TONE_MODES).toEqual(["calm", "mystical", "direct", "oracle"]);
  });

  it("covers all four Covara modes", () => {
    expect(COVARA_TONE_MODES).toEqual(["soft", "poetic", "crisp", "expert"]);
  });

  it("round-trips Astrobobo → Covara → Astrobobo", () => {
    for (const mode of TONE_MODES) {
      expect(covaraToAstrobobo(astroboboToCovara(mode))).toBe(mode);
    }
  });

  it("round-trips Covara → Astrobobo → Covara", () => {
    for (const mode of COVARA_TONE_MODES) {
      expect(astroboboToCovara(covaraToAstrobobo(mode))).toBe(mode);
    }
  });
});

describe("classifyTone", () => {
  it("returns calm on high confusion", () => {
    expect(classifyTone({ ...base, confusion: 0.7, engagement: 0.8 })).toBe(
      "calm"
    );
  });

  it("returns oracle for power users", () => {
    expect(
      classifyTone({ ...base, engagement: 0.75, interactionCount: 40 })
    ).toBe("oracle");
  });

  it("returns mystical for engaged + curious users", () => {
    expect(
      classifyTone({ ...base, engagement: 0.5, curiosity: 0.7 })
    ).toBe("mystical");
  });

  it("returns direct for engaged + task-focused users", () => {
    expect(
      classifyTone({ ...base, engagement: 0.5, curiosity: 0.2 })
    ).toBe("direct");
  });

  it("returns calm for neutral new users", () => {
    expect(classifyTone(base)).toBe("calm");
  });

  it("returns mystical for curious new users", () => {
    expect(classifyTone({ ...base, curiosity: 0.5 })).toBe("mystical");
  });

  it("overrideTone wins over classification", () => {
    const rage = { ...base, confusion: 0.9, engagement: 0.9 };
    expect(classifyTone(rage, { overrideTone: "oracle" })).toBe("oracle");
  });
});

describe("validateToneContract", () => {
  it("reports ok with no failures", () => {
    const result = validateToneContract();
    expect(result.ok).toBe(true);
    expect(result.failures).toEqual([]);
  });
});
