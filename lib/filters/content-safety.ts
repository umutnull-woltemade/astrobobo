/**
 * Astrobobo Content Safety Filter
 *
 * Enforces Apple-safe, non-predictive language across all content.
 * Zero tolerance for deterministic/predictive phrases.
 */

// Layer 1: Banned phrases — zero tolerance
const BANNED_PHRASES = [
  "will happen",
  "will be",
  "you will",
  "going to",
  "destined",
  "fated",
  "guaranteed",
  "promise",
  "certain to",
  "definitely will",
  "forecast",
  "prediction",
  "predict",
  "fortune",
  "your future",
  "what awaits",
  "meant to be",
  "written in the stars",
  "cosmic plan for you",
  "the stars say",
  "the planets indicate",
  "your horoscope says",
  "you are destined",
  "the universe will",
  "fate has decided",
  "stars align for",
  "planetary forces will",
  "cosmic forces will",
  "you are meant to",
  "the cosmos demands",
];

// Layer 1b: Auto-replacement map
const REPLACEMENTS: Record<string, string> = {
  "will happen": "may unfold",
  "will be": "could be",
  "you will": "you may",
  "going to": "might",
  "destined": "drawn toward",
  "fated": "naturally inclined toward",
  "guaranteed": "often associated with",
  "the stars say": "this archetype suggests",
  "the planets indicate": "this pattern reflects",
  "your horoscope says": "this archetype invites you to consider",
  "your future": "your path",
  "what awaits": "what you might explore",
  "meant to be": "something that may resonate",
  "written in the stars": "a pattern worth reflecting on",
  "cosmic plan for you": "a theme for exploration",
};

// Layer 2: Emotional dependency patterns
const DEPENDENCY_PATTERNS = [
  "you need this",
  "without this",
  "don't miss",
  "you're falling behind",
  "act now",
  "limited time",
  "running out",
  "last chance",
  "only today",
  "before it's too late",
  "you can't afford to",
  "everyone else is",
  "you're missing out",
  "urgent",
];

// Layer 3: Medical/financial claim patterns
const CLAIM_PATTERNS = [
  "cure",
  "heal your",
  "treat your",
  "diagnose",
  "medical advice",
  "financial advice",
  "invest in",
  "guaranteed return",
  "make money",
  "get rich",
  "weight loss",
  "clinical",
];

export interface ContentSafetyResult {
  passed: boolean;
  score: number; // 0-10, 0 = fully safe
  violations: ContentViolation[];
  autoFixed?: string;
}

export interface ContentViolation {
  type: "prediction" | "dependency" | "claim";
  phrase: string;
  position: number;
  severity: "critical" | "warning";
  suggestion?: string;
}

export function validateContent(text: string): ContentSafetyResult {
  const lower = text.toLowerCase();
  const violations: ContentViolation[] = [];

  // Layer 1: Prediction check
  for (const phrase of BANNED_PHRASES) {
    const idx = lower.indexOf(phrase);
    if (idx !== -1) {
      violations.push({
        type: "prediction",
        phrase,
        position: idx,
        severity: "critical",
        suggestion: REPLACEMENTS[phrase] || "Remove or rephrase",
      });
    }
  }

  // Layer 2: Dependency check
  for (const phrase of DEPENDENCY_PATTERNS) {
    const idx = lower.indexOf(phrase);
    if (idx !== -1) {
      violations.push({
        type: "dependency",
        phrase,
        position: idx,
        severity: "critical",
      });
    }
  }

  // Layer 3: Claim check
  for (const phrase of CLAIM_PATTERNS) {
    const idx = lower.indexOf(phrase);
    if (idx !== -1) {
      violations.push({
        type: "claim",
        phrase,
        position: idx,
        severity: "warning",
      });
    }
  }

  const score = Math.min(
    10,
    violations.filter((v) => v.severity === "critical").length * 3 +
      violations.filter((v) => v.severity === "warning").length
  );

  return {
    passed: violations.length === 0,
    score,
    violations,
  };
}

export function autoFixContent(text: string): { text: string; fixes: number } {
  let result = text;
  let fixes = 0;

  for (const [banned, replacement] of Object.entries(REPLACEMENTS)) {
    const regex = new RegExp(banned, "gi");
    const before = result;
    result = result.replace(regex, replacement);
    if (result !== before) fixes++;
  }

  return { text: result, fixes };
}

export function calculateDuplicationScore(a: string, b: string): number {
  const wordsA = new Set(a.toLowerCase().split(/\s+/));
  const wordsB = new Set(b.toLowerCase().split(/\s+/));
  const intersection = new Set([...wordsA].filter((w) => wordsB.has(w)));
  const union = new Set([...wordsA, ...wordsB]);
  return union.size === 0 ? 0 : intersection.size / union.size;
}
