import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  __resetRuntimeCohortConfig,
  cohortConfig,
  loadRemoteCohortConfig,
  resolveCohort,
} from "@/lib/pro/cohorts";

describe("cohortConfig", () => {
  it("ships the three built-in cohorts", () => {
    expect(cohortConfig).toHaveProperty("whisper");
    expect(cohortConfig).toHaveProperty("direct-beta");
    expect(cohortConfig).toHaveProperty("oracle-first");
  });

  it("whisper forces mystical tone", () => {
    expect(cohortConfig.whisper.overrideTone).toBe("mystical");
  });
});

describe("loadRemoteCohortConfig", () => {
  beforeEach(() => {
    __resetRuntimeCohortConfig();
  });

  afterEach(() => {
    vi.unstubAllGlobals();
    __resetRuntimeCohortConfig();
  });

  it("merges a remote map over the static config", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          whisper: { overrideTone: "direct" },
          "new-cohort": { overrideTone: "oracle", cohortCtr: 0.12 },
        }),
      })
    );

    await loadRemoteCohortConfig("https://example.com/cohorts.json");

    vi.stubGlobal("document", { cookie: "astrobobo.pro.cohort=whisper" });

    const hit = resolveCohort();
    expect(hit.cohort).toBe("whisper");
    expect(hit.patch.overrideTone).toBe("direct");

    vi.stubGlobal("document", { cookie: "astrobobo.pro.cohort=new-cohort" });
    const second = resolveCohort();
    expect(second.patch.overrideTone).toBe("oracle");
    expect(second.patch.cohortCtr).toBe(0.12);
  });

  it("ignores invalid tone values in remote payloads", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: true,
        json: async () => ({
          whisper: { overrideTone: "garbage", cohortCtr: "nope" },
        }),
      })
    );

    await loadRemoteCohortConfig("https://example.com/cohorts.json");

    vi.stubGlobal("document", { cookie: "astrobobo.pro.cohort=whisper" });

    const hit = resolveCohort();
    expect(hit.patch.overrideTone).toBeUndefined();
    expect(hit.patch.cohortCtr).toBeUndefined();
  });

  it("returns silently when no URL is configured", async () => {
    await expect(loadRemoteCohortConfig(undefined)).resolves.toBeUndefined();
  });

  it("swallows fetch failures", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockRejectedValue(new Error("network down"))
    );
    await expect(
      loadRemoteCohortConfig("https://example.com/cohorts.json")
    ).resolves.toBeUndefined();
  });
});
