/**
 * Astrobobo Web Pro — runtime invariants.
 *
 * A tiny suite of pure self-checks that run once on mount in development
 * and surface their results in the HUD. This is not a replacement for a
 * test runner — it's a cheap canary that catches drift between the pure
 * engine functions when things are edited.
 *
 * Each check is a synchronous `() => InvariantResult`. The collection
 * runs in `runInvariants()`; callers get back a structured report.
 */

import {
  neutralEmotion,
  stepEmotion,
  type BehaviorSample,
} from "./emotion-scoring";
import { computeDirective, type SessionProfile } from "./ai-layout-engine";
import { parseArticleMarkdown, parseInline } from "./markdown-lite";
import { validateToneContract } from "./tone-bridge";

export type InvariantResult = {
  name: string;
  ok: boolean;
  detail?: string;
};

export type InvariantReport = {
  ok: boolean;
  results: InvariantResult[];
  ranAt: number;
};

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

const checks: Array<() => InvariantResult> = [
  function toneContract(): InvariantResult {
    const { ok, failures } = validateToneContract();
    return {
      name: "tone contract",
      ok,
      detail: ok ? undefined : failures.join(", "),
    };
  },

  function emotionBounds(): InvariantResult {
    // Feed a hot sample for ~3s of simulated time and make sure every
    // emotion score stays in [0, 1].
    let state = neutralEmotion;
    const hot: BehaviorSample = {
      pointerVelocity: 2400,
      scrollVelocity: 1200,
      recentClicks: 5,
      directionFlips: 3,
      idleMs: 0,
      dwellMs: 2000,
    };
    for (let i = 0; i < 120; i++) {
      state = stepEmotion(state, hot, 25);
    }
    const values = [
      state.excitement,
      state.confusion,
      state.curiosity,
      state.engagement,
    ];
    const inRange = values.every((v) => v >= 0 && v <= 1);
    return {
      name: "emotion bounds",
      ok: inRange,
      detail: inRange ? undefined : `out of range: ${values.join(", ")}`,
    };
  },

  function directiveValidity(): InvariantResult {
    // computeDirective must always return a valid mode + tone, regardless
    // of the emotion it's fed.
    const samples = [
      neutralEmotion,
      { excitement: 0.9, curiosity: 0.2, confusion: 0, engagement: 0.8 },
      { excitement: 0.1, curiosity: 0.1, confusion: 0.8, engagement: 0.3 },
    ];
    for (const emotion of samples) {
      const directive = computeDirective(emotion, emptyProfile);
      const modeOk = ["new", "engaged", "lost", "power"].includes(directive.mode);
      const toneOk = ["calm", "mystical", "direct", "oracle"].includes(directive.tone);
      if (!modeOk || !toneOk) {
        return {
          name: "directive validity",
          ok: false,
          detail: `mode=${directive.mode} tone=${directive.tone}`,
        };
      }
    }
    return { name: "directive validity", ok: true };
  },

  function emptyBehaviorStable(): InvariantResult {
    // Idle session should not push confusion above zero.
    let state = neutralEmotion;
    for (let i = 0; i < 60; i++) {
      state = stepEmotion(state, emptySample, 33);
    }
    const ok = state.confusion < 0.05;
    return {
      name: "idle stability",
      ok,
      detail: ok ? undefined : `confusion=${state.confusion.toFixed(3)}`,
    };
  },

  function markdownRoundtrip(): InvariantResult {
    // Parse a canonical doc and verify every expected block type shows up.
    const input = [
      "# Heading One",
      "",
      "## Heading Two",
      "",
      "A paragraph with **bold** text.",
      "",
      "> A quote line",
      "> that spans two lines.",
      "",
      "- alpha",
      "- beta",
      "",
      "### Sub",
      "",
      "Plain tail.",
    ].join("\n");
    const blocks = parseArticleMarkdown(input);
    const types = new Set(blocks.map((b) => b.type));
    const expected = ["h1", "h2", "h3", "paragraph", "quote", "list"] as const;
    const missing = expected.filter((t) => !types.has(t));

    // Also verify inline bold parsing.
    const spans = parseInline("A paragraph with **bold** text.");
    const hasBold = spans.some((s) => s.type === "bold" && s.value === "bold");

    const ok = missing.length === 0 && hasBold;
    return {
      name: "markdown roundtrip",
      ok,
      detail: ok ? undefined : `missing: ${missing.join(",")} bold=${hasBold}`,
    };
  },
];

export function runInvariants(): InvariantReport {
  const results = checks.map((fn) => {
    try {
      return fn();
    } catch (err) {
      return {
        name: fn.name || "unknown",
        ok: false,
        detail: err instanceof Error ? err.message : String(err),
      };
    }
  });
  return {
    ok: results.every((r) => r.ok),
    results,
    ranAt: Date.now(),
  };
}
