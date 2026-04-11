/**
 * useCohort — resolves the active cohort on mount, applies its
 * `RemoteSignals` patch to the Pro store, and records the cohort slug so
 * the HUD (and downstream analytics) can surface it.
 *
 * Runs once per mount. Re-resolving on every navigation is intentional —
 * a `?cohort=...` on an inner page should still flip the experiment.
 */

"use client";

import { useEffect } from "react";
import { useProStore } from "@/lib/pro/pro-store";
import { loadRemoteCohortConfig, resolveCohort } from "@/lib/pro/cohorts";

export function useCohort() {
  const setRemoteSignals = useProStore((s) => s.setRemoteSignals);

  useEffect(() => {
    let cancelled = false;

    const apply = () => {
      if (cancelled) return;
      const { cohort, patch } = resolveCohort();
      if (!cohort && Object.keys(patch).length === 0) return;
      setRemoteSignals({ ...patch, cohort });
    };

    // First, apply whatever the static map says so the UI responds
    // immediately even on a slow network. Then load the remote overrides
    // and re-apply — if the cohort's patch changed, the store update
    // propagates into the orchestrator within one RAF.
    apply();

    const url = process.env.NEXT_PUBLIC_PRO_COHORT_URL;
    if (url) {
      loadRemoteCohortConfig(url)
        .then(apply)
        .catch(() => {
          // resolveCohort still works with the static map
        });
    }

    return () => {
      cancelled = true;
    };
  }, [setRemoteSignals]);
}
