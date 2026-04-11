import { describe, expect, it } from "vitest";
import { runInvariants } from "@/lib/pro/invariants";

describe("runInvariants", () => {
  it("passes all checks on a clean main branch", () => {
    const report = runInvariants();
    const failing = report.results.filter((r) => !r.ok);
    expect(failing, `failing: ${failing.map((f) => f.name).join(", ")}`).toEqual(
      []
    );
    expect(report.ok).toBe(true);
  });

  it("returns a result for every registered check", () => {
    const report = runInvariants();
    const names = report.results.map((r) => r.name);
    expect(names).toContain("tone contract");
    expect(names).toContain("emotion bounds");
    expect(names).toContain("directive validity");
    expect(names).toContain("idle stability");
    expect(names).toContain("markdown roundtrip");
  });
});
