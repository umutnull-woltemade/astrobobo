/**
 * useInvariants — runs the pure invariant suite once on mount (dev only)
 * and pushes the report into the Pro store so the HUD can render it.
 *
 * Noop in production. The suite is cheap (<2ms) but there's no reason to
 * run it for real users.
 */

"use client";

import { useEffect } from "react";
import { useProStore } from "@/lib/pro/pro-store";
import { runInvariants } from "@/lib/pro/invariants";

export function useInvariants() {
  const setInvariants = useProStore((s) => s.setInvariants);

  useEffect(() => {
    if (process.env.NODE_ENV !== "development") return;
    const report = runInvariants();
    setInvariants(report);
    if (!report.ok) {
      // eslint-disable-next-line no-console
      console.warn(
        "[pro-invariants] failing checks:",
        report.results.filter((r) => !r.ok)
      );
    }
  }, [setInvariants]);
}
