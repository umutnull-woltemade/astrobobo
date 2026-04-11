/**
 * ZodiacOrbitClient — the interactive island.
 *
 * Holds the selected sign in local state, renders the OrbitMenu with 12
 * archetypes orbiting the active one, and swaps the detail panel via
 * framer-motion's AnimatePresence so transitions feel like dimensional
 * shifts rather than flat prop updates.
 */

"use client";

import { AnimatePresence, motion } from "framer-motion";
import { useMemo, useState } from "react";
import { OrbitMenu } from "@/components/pro/OrbitMenu";
import { QuantumCard } from "@/components/pro/QuantumCard";
import { NebulaButton } from "@/components/pro/NebulaButton";
import { GravityScroll } from "@/components/pro/GravityScroll";
import { AIAdaptiveContainer } from "@/components/pro/AIAdaptiveContainer";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";
import { useToneCopy } from "@/lib/hooks/useToneCopy";
import { registerCopy } from "@/lib/pro/copy-registry";

type SignLite = {
  slug: string;
  name: string;
  symbol: string;
  element: "Fire" | "Earth" | "Air" | "Water";
  modality: "Cardinal" | "Fixed" | "Mutable";
  rulingPlanet: string;
  dateRange: string;
  keywords: string[];
  overview: string;
  strengths: string[];
  growthThemes: string[];
  dailyInspiration: string[];
};

// Tone-aware section headings for this route.
registerCopy("zodiac.title", {
  default: "The zodiac, as a field",
  calm: "Twelve gentle paths",
  mystical: "Twelve gates in one circle",
  direct: "The twelve archetypes",
  oracle: "12 archetypal vectors",
});
registerCopy("zodiac.subtitle", {
  default: "Each archetype is a gravity well. Enter any of them.",
  calm: "Take your time choosing. Any door is the right one.",
  mystical: "What you are drawn to is already drawn to you.",
  direct: "Click a sign to load its detail.",
  oracle: "Tap node → directive.focusNodeId := sign.slug.",
});
registerCopy("zodiac.overview.heading", {
  default: "Overview",
  calm: "About this archetype",
  mystical: "The pattern beneath",
  direct: "Overview",
  oracle: "Overview",
});
registerCopy("zodiac.strengths.heading", {
  default: "Strengths",
  calm: "Gentle strengths",
  mystical: "What the field offers",
  direct: "Strengths",
  oracle: "Strengths",
});
registerCopy("zodiac.growth.heading", {
  default: "Growth edges",
  calm: "Invitations to grow",
  mystical: "The unfolding edges",
  direct: "Growth",
  oracle: "Growth edges",
});
registerCopy("zodiac.inspire.heading", {
  default: "For today",
  calm: "A soft reminder",
  mystical: "The field whispers",
  direct: "Today",
  oracle: "Daily vector",
});

const elementGlow: Record<SignLite["element"], "violet" | "cyan" | "amber"> = {
  Fire: "amber",
  Earth: "violet",
  Air: "cyan",
  Water: "violet",
};

type Props = {
  signs: SignLite[];
};

export function ZodiacOrbitClient({ signs }: Props) {
  const [activeSlug, setActiveSlug] = useState<string>(signs[0].slug);
  const { spring } = useMotionPhysics();
  const t = useToneCopy();

  const active = useMemo(
    () => signs.find((s) => s.slug === activeSlug) ?? signs[0],
    [signs, activeSlug]
  );

  return (
    <>
      <section className="relative mx-auto flex max-w-6xl flex-col items-center px-6 pt-24 text-center">
        <p className="mb-3 text-xs uppercase tracking-[0.4em] text-pro-cyan">
          astrobobo / pro / zodiac
        </p>
        <h1 className="pro-heading text-4xl md:text-6xl">{t("zodiac.title")}</h1>
        <p className="mt-4 max-w-xl text-pro-text/70">{t("zodiac.subtitle")}</p>
      </section>

      <section className="relative mx-auto flex max-w-6xl flex-col items-center px-6 py-16">
        <OrbitMenu
          radius={200}
          center={
            <div>
              <div className="text-3xl">{active.symbol}</div>
              <div className="pro-heading mt-1 text-lg">{active.name}</div>
              <div className="mt-1 text-[0.6rem] uppercase tracking-[0.25em] text-pro-cyan">
                {active.element} · {active.modality}
              </div>
            </div>
          }
          items={signs.map((s) => ({
            id: `zodiac-${s.slug}`,
            label: s.name,
            onSelect: () => setActiveSlug(s.slug),
            icon: <span className="text-base">{s.symbol}</span>,
          }))}
        />
      </section>

      <AnimatePresence mode="wait">
        <motion.section
          key={active.slug}
          initial={{ opacity: 0, y: 36, filter: "blur(8px)" }}
          animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
          exit={{ opacity: 0, y: -24, filter: "blur(6px)" }}
          transition={spring}
          className="relative mx-auto max-w-5xl px-6 pb-20"
        >
          <GravityScroll>
            <div className="mb-10 text-center">
              <h2 className="pro-heading text-3xl md:text-4xl">
                {active.name} · {active.dateRange}
              </h2>
              <p className="mt-2 text-pro-muted text-sm uppercase tracking-[0.3em]">
                Ruled by {active.rulingPlanet}
              </p>
              <div className="mt-6 flex flex-wrap justify-center gap-2">
                {active.keywords.map((kw) => (
                  <span
                    key={kw}
                    className="pro-glass rounded-full px-3 py-1 text-xs text-pro-text/80"
                  >
                    {kw}
                  </span>
                ))}
              </div>
            </div>

            <AIAdaptiveContainer minColumns={1} maxColumns={2}>
              <QuantumCard
                id={`sign-${active.slug}-overview`}
                title={t("zodiac.overview.heading")}
                glow={elementGlow[active.element]}
              >
                <p className="text-sm leading-relaxed text-pro-text/85">
                  {active.overview}
                </p>
              </QuantumCard>

              <QuantumCard
                id={`sign-${active.slug}-strengths`}
                title={t("zodiac.strengths.heading")}
                glow="cyan"
              >
                <ul className="space-y-2 text-sm text-pro-text/85">
                  {active.strengths.map((s) => (
                    <li key={s} className="flex gap-2">
                      <span className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-pro-cyan" />
                      <span>{s}</span>
                    </li>
                  ))}
                </ul>
              </QuantumCard>

              <QuantumCard
                id={`sign-${active.slug}-growth`}
                title={t("zodiac.growth.heading")}
                glow="violet"
                data-pro-secondary
              >
                <ul className="space-y-2 text-sm text-pro-text/85">
                  {active.growthThemes.map((g) => (
                    <li key={g} className="flex gap-2">
                      <span className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-pro-violet-soft" />
                      <span>{g}</span>
                    </li>
                  ))}
                </ul>
              </QuantumCard>

              <QuantumCard
                id={`sign-${active.slug}-today`}
                title={t("zodiac.inspire.heading")}
                glow="amber"
                data-pro-secondary
              >
                <div className="space-y-3 text-sm italic leading-relaxed text-pro-text/85">
                  {active.dailyInspiration.map((line) => (
                    <p key={line}>“{line}”</p>
                  ))}
                </div>
              </QuantumCard>
            </AIAdaptiveContainer>

            <div className="mt-12 flex justify-center">
              <NebulaButton
                id={`enter-sign-${active.slug}`}
                variant="secondary"
                onClick={() => {
                  // Jump back up to the orbit — feels like re-entering the field.
                  if (typeof window !== "undefined")
                    window.scrollTo({ top: 0, behavior: "smooth" });
                }}
              >
                Return to the field
              </NebulaButton>
            </div>
          </GravityScroll>
        </motion.section>
      </AnimatePresence>
    </>
  );
}
