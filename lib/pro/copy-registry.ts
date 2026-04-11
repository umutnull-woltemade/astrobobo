/**
 * Astrobobo Web Pro — tone-aware copy registry.
 *
 * Every string in the Pro layer is keyed by id and has 4 variants — one per
 * `ToneMode`. `selectCopy(id, tone)` picks the best match and falls back
 * sensibly so a missing variant never renders an empty string.
 *
 * Keep the registry small and curated. This is not an i18n replacement; it
 * is the voice layer. For full i18n (EN/TR), the cosmic site's
 * `lib/i18n/dictionaries` remains the source of truth.
 */

import type { ToneMode } from "./ai-layout-engine";
import type { Locale } from "@/lib/i18n/config";

export type CopyVariants = Partial<Record<ToneMode, string>>;
export type CopyEntry = { default: string } & CopyVariants;

/**
 * A locale override can supply any subset of tone variants for any key.
 * Lookup falls back en-style: locale+tone → locale+default → en+tone →
 * en+default → key literal.
 */
export type LocaleOverrides = Record<string, CopyEntry>;

const localeOverrides: Partial<Record<Locale, LocaleOverrides>> = {
  tr: {},
};

const registry: Record<string, CopyEntry> = {
  "hero.eyebrow": {
    default: "Astrobobo / Pro",
    calm: "Astrobobo / Pro",
    mystical: "A field awakens",
    direct: "Astrobobo Pro",
    oracle: "Core / Pro / v0",
  },
  "hero.title": {
    default: "You didn't open a site. You entered a universe.",
    calm: "Welcome. Take your time here.",
    mystical: "You did not arrive by accident.\nThe field remembers.",
    direct: "This is a universe, not a page.",
    oracle: "Field engaged. Directive live. Move.",
  },
  "hero.subtitle": {
    default:
      "The interface is watching how you move. Stay still and it simplifies. Explore and it unfolds.",
    calm: "Everything here breathes at your pace. There is nothing to rush.",
    mystical:
      "The space bends around your attention. Each gesture is a signal; each signal is returned.",
    direct:
      "The UI adapts in real time to your motion, dwell, and clicks. Move to unlock layers.",
    oracle:
      "Emotion vector → directive → layout tree @ 60Hz. Interact to raise revealLevel.",
  },
  "hero.ctaPrimary": {
    default: "Enter the field",
    calm: "Begin gently",
    mystical: "Enter the field",
    direct: "Start",
    oracle: "Engage",
  },
  "hero.ctaSecondary": {
    default: "Observe",
    calm: "Just look around",
    mystical: "Observe the drift",
    direct: "Tour",
    oracle: "Inspect",
  },

  "section.orbit.title": {
    default: "Orbital navigation",
    calm: "Gentle navigation",
    mystical: "The orbit listens",
    direct: "Navigation",
    oracle: "Orbital graph",
  },
  "section.orbit.subtitle": {
    default: "Items gravitate toward what you touch most.",
    calm: "Your favorite paths drift a little closer each time.",
    mystical:
      "What you return to, returns to you. The ring remembers.",
    direct: "Most-used items move inward.",
    oracle: "focusNodeId drives ring offset. gravitate=true active.",
  },

  "section.adaptive.title": {
    default: "Adaptive layer",
    calm: "It adapts to you",
    mystical: "The geometry responds",
    direct: "Adaptive layer",
    oracle: "Adaptation pipeline",
  },
  "section.adaptive.subtitle": {
    default:
      "The grid density, spacing, and reveal level all shift with you.",
    calm: "The space breathes open when you relax into it.",
    mystical:
      "Density flows with your curiosity. Air blooms when you pause.",
    direct:
      "Density, spacing, and reveal level react to behavior in real time.",
    oracle:
      "Density · airiness · revealLevel ∈ directive. Updated each RAF.",
  },

  "section.pulse.title": {
    default: "Pulse input",
    calm: "Gentle input",
    mystical: "Speak to the field",
    direct: "Inputs",
    oracle: "Pulse IO",
  },
  "section.pulse.subtitle": {
    default: "Alive containers, breathing focus.",
    calm: "Take a breath before you type.",
    mystical: "The container listens before it receives.",
    direct: "Focus-reactive containers.",
    oracle: "Containers bound to focus + intensity.",
  },

  "input.name.label": {
    default: "Your name",
    calm: "What should we call you?",
    mystical: "The name you answer to",
    direct: "Name",
    oracle: "Identifier",
  },
  "input.birth.label": {
    default: "Birth date",
    calm: "When were you born?",
    mystical: "The day the sky marked you",
    direct: "Birth date",
    oracle: "DOB (ISO)",
  },

  "footer.tagline": {
    default: "astrobobo · pro universe · v0",
    calm: "astrobobo · taking it slow",
    mystical: "astrobobo · the field remembers",
    direct: "astrobobo pro · v0",
    oracle: "astrobobo::pro::v0",
  },
};

export function selectCopy(
  id: string,
  tone: ToneMode,
  locale: Locale = "en"
): string {
  const override = localeOverrides[locale]?.[id];
  if (override) {
    const hit = override[tone] ?? override.default;
    if (hit) return hit;
  }
  const base = registry[id];
  if (!base) return id;
  return base[tone] ?? base.default;
}

export function registerCopy(id: string, entry: CopyEntry) {
  registry[id] = entry;
}

export function registerLocaleCopy(
  locale: Locale,
  id: string,
  entry: CopyEntry
) {
  if (!localeOverrides[locale]) localeOverrides[locale] = {};
  localeOverrides[locale]![id] = entry;
}

/**
 * Bulk-register overrides for a locale. Useful for loading a whole tone
 * pack up-front (e.g., when wiring the Covara tone engine or hydrating
 * from a remote CMS).
 */
export function registerLocalePack(
  locale: Locale,
  entries: Record<string, CopyEntry>
) {
  for (const [id, entry] of Object.entries(entries)) {
    registerLocaleCopy(locale, id, entry);
  }
}
