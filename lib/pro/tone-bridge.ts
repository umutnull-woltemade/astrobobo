/**
 * Astrobobo Web Pro ↔ Covara tone bridge — re-export facade.
 *
 * The actual contract lives in `packages/pro-tone/index.ts` so Covara
 * can consume it as a package (or copy the file verbatim). This file
 * exists only so existing astrobobo-web imports like
 *
 *   import { classifyTone } from "@/lib/pro/tone-bridge";
 *
 * keep resolving without churn. New consumers should reach for
 * `@astrobobo/pro-tone` (or the relative packages path during development).
 */

export {
  TONE_MODES,
  COVARA_TONE_MODES,
  covaraToAstrobobo,
  astroboboToCovara,
  classifyTone,
  validateToneContract,
} from "@astrobobo/pro-tone";

export type {
  ToneMode,
  CovaraToneMode,
  BehaviorVector,
  RemoteSignals,
} from "@astrobobo/pro-tone";
