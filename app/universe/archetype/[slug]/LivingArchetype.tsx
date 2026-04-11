/**
 * LivingArchetype — the deep-dive client island for one zodiac sign.
 *
 * Renders every ZodiacSign field in a series of sections:
 *   - the essence (element/modality/keywords)
 *   - overview + personality
 *   - strengths + growth themes (adaptive grid)
 *   - reflection prompts (each a hoverable glass slab)
 *   - compatibility note
 *   - cosmic explanation (blockquote-style)
 *   - daily inspiration (rotating highlight)
 *
 * Uses QuantumCard, AIAdaptiveContainer, GravityScroll so the whole thing
 * reacts to the adaptation layer — density, reveal level, gravitation all
 * apply automatically.
 */

"use client";

import { motion } from "framer-motion";
import { useState, useEffect } from "react";
import type { ZodiacSign } from "@/content/zodiac";
import { QuantumCard } from "@/components/pro/QuantumCard";
import { AIAdaptiveContainer } from "@/components/pro/AIAdaptiveContainer";
import { GravityScroll } from "@/components/pro/GravityScroll";
import { NebulaButton } from "@/components/pro/NebulaButton";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

type Props = { sign: ZodiacSign };

const elementGlow = {
  Fire: "amber",
  Earth: "violet",
  Air: "cyan",
  Water: "violet",
} as const;

export function LivingArchetype({ sign }: Props) {
  const { spring } = useMotionPhysics();
  const glow = elementGlow[sign.element];

  // Rotating daily inspiration highlight. Uses an interval rather than
  // scroll so the effect is present even when the user isn't moving.
  const [dailyIdx, setDailyIdx] = useState(0);
  useEffect(() => {
    if (sign.dailyInspiration.length < 2) return;
    const id = window.setInterval(() => {
      setDailyIdx((i) => (i + 1) % sign.dailyInspiration.length);
    }, 5200);
    return () => window.clearInterval(id);
  }, [sign.dailyInspiration.length]);

  return (
    <>
      {/* essence */}
      <section className="relative mx-auto max-w-4xl px-6 pt-16">
        <div className="flex flex-wrap items-center justify-center gap-3">
          <Pill label={sign.element} tone="violet" />
          <Pill label={sign.modality} tone="cyan" />
          {sign.keywords.slice(0, 5).map((kw) => (
            <Pill key={kw} label={kw} tone="muted" />
          ))}
        </div>
      </section>

      {/* overview + personality */}
      <section className="relative mx-auto max-w-5xl px-6 py-24">
        <GravityScroll depth={50}>
          <AIAdaptiveContainer minColumns={1} maxColumns={2}>
            <QuantumCard
              id={`arch-${sign.slug}-overview`}
              title="The archetype"
              glow={glow}
            >
              <p className="text-sm leading-[1.8] text-pro-text/85">
                {sign.overview}
              </p>
            </QuantumCard>

            <QuantumCard
              id={`arch-${sign.slug}-personality`}
              title="How it shows up"
              glow="cyan"
            >
              <p className="text-sm leading-[1.8] text-pro-text/85">
                {sign.personality}
              </p>
            </QuantumCard>
          </AIAdaptiveContainer>
        </GravityScroll>
      </section>

      {/* strengths + growth themes */}
      <section className="relative mx-auto max-w-5xl px-6 py-16">
        <div className="mb-12 text-center">
          <h2 className="pro-heading text-3xl md:text-4xl">Strengths &amp; edges</h2>
          <p className="mt-2 text-pro-muted">
            What the field offers, and where it invites growth.
          </p>
        </div>
        <AIAdaptiveContainer minColumns={1} maxColumns={2}>
          <QuantumCard
            id={`arch-${sign.slug}-strengths`}
            title="Strengths"
            glow="cyan"
          >
            <ul className="space-y-2.5 text-sm text-pro-text/85">
              {sign.strengths.map((s) => (
                <li key={s} className="flex gap-3">
                  <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-pro-cyan" />
                  <span className="leading-relaxed">{s}</span>
                </li>
              ))}
            </ul>
          </QuantumCard>

          <QuantumCard
            id={`arch-${sign.slug}-growth`}
            title="Growth edges"
            glow="violet"
          >
            <ul className="space-y-2.5 text-sm text-pro-text/85">
              {sign.growthThemes.map((g) => (
                <li key={g} className="flex gap-3">
                  <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-pro-violet-soft" />
                  <span className="leading-relaxed">{g}</span>
                </li>
              ))}
            </ul>
          </QuantumCard>
        </AIAdaptiveContainer>
      </section>

      {/* reflection prompts */}
      <section className="relative mx-auto max-w-5xl px-6 py-16">
        <div className="mb-12 text-center">
          <h2 className="pro-heading text-3xl md:text-4xl">Prompts for reflection</h2>
          <p className="mt-2 text-pro-muted">
            Sit with any one of these. Move past the ones that don&rsquo;t land.
          </p>
        </div>
        <AIAdaptiveContainer minColumns={1} maxColumns={2}>
          {sign.reflectionPrompts.map((prompt, i) => (
            <QuantumCard
              key={prompt}
              id={`arch-${sign.slug}-prompt-${i}`}
              glow={i % 2 === 0 ? "cyan" : "amber"}
              data-pro-secondary={i > 2}
            >
              <p className="font-pro text-base italic leading-relaxed text-pro-text/90">
                &ldquo;{prompt}&rdquo;
              </p>
            </QuantumCard>
          ))}
        </AIAdaptiveContainer>
      </section>

      {/* compatibility */}
      <section className="relative mx-auto max-w-3xl px-6 py-16">
        <QuantumCard
          id={`arch-${sign.slug}-compat`}
          title="Compatibility notes"
          glow="violet"
        >
          <p className="text-sm leading-[1.8] text-pro-text/85">
            {sign.compatibilityNotes}
          </p>
        </QuantumCard>
      </section>

      {/* cosmic explanation */}
      <section className="relative mx-auto max-w-3xl px-6 py-16">
        <motion.blockquote
          initial={{ opacity: 0, y: 28, filter: "blur(6px)" }}
          whileInView={{ opacity: 1, y: 0, filter: "blur(0px)" }}
          viewport={{ once: true, margin: "-60px" }}
          transition={spring}
          className="pro-glass pro-stroke-gradient rounded-2xl px-8 py-10 text-center"
        >
          <p className="mx-auto max-w-2xl font-pro text-base leading-relaxed italic text-pro-text/90">
            {sign.cosmicExplanation}
          </p>
        </motion.blockquote>
      </section>

      {/* daily inspiration */}
      <section className="relative mx-auto max-w-3xl px-6 py-16 text-center">
        <p className="mb-3 text-xs uppercase tracking-[0.3em] text-pro-cyan">
          For today
        </p>
        <motion.p
          key={dailyIdx}
          initial={{ opacity: 0, y: 16, filter: "blur(6px)" }}
          animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.85, ease: [0.22, 1, 0.36, 1] }}
          className="pro-heading mx-auto max-w-xl text-2xl leading-[1.3] md:text-3xl"
        >
          {sign.dailyInspiration[dailyIdx]}
        </motion.p>
      </section>

      <section className="relative mx-auto max-w-3xl px-6 pb-24 pt-8 text-center">
        <NebulaButton
          id={`arch-${sign.slug}-return`}
          variant="ghost"
          onClick={() => {
            if (typeof window !== "undefined") {
              window.scrollTo({ top: 0, behavior: "smooth" });
            }
          }}
        >
          Return to the top
        </NebulaButton>
      </section>
    </>
  );
}

type PillProps = { label: string; tone: "violet" | "cyan" | "muted" };

function Pill({ label, tone }: PillProps) {
  const classes =
    tone === "violet"
      ? "text-pro-violet-soft border-pro-violet/40"
      : tone === "cyan"
      ? "text-pro-cyan border-pro-cyan/40"
      : "text-pro-text/75 border-white/10";
  return (
    <span
      className={`pro-glass rounded-full border px-3 py-1 text-xs uppercase tracking-wider ${classes}`}
    >
      {label}
    </span>
  );
}
