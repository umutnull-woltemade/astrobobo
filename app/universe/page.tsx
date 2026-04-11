/**
 * /universe — the Astrobobo Web Pro demo scene.
 *
 * Server component for metadata; renders the ProShell client boundary and
 * a sample of the cinematic layer (OrbitMenu, QuantumCards, NebulaButtons).
 *
 * This is the entry point that proves the whole system is alive. Everything
 * below this line responds to the user's behavior automatically.
 */

import type { Metadata } from "next";
import { ProShell } from "./ProShell";
import { ToneCopy } from "./ToneCopy";
import { TonePulseInput } from "./TonePulseInput";
import { QuantumCard } from "@/components/pro/QuantumCard";
import { NebulaButton } from "@/components/pro/NebulaButton";
import { OrbitMenu } from "@/components/pro/OrbitMenu";
import { PulseInput } from "@/components/pro/PulseInput";
import { AIAdaptiveContainer } from "@/components/pro/AIAdaptiveContainer";
import { GravityScroll } from "@/components/pro/GravityScroll";

export const metadata: Metadata = {
  title: "Astrobobo — Universe",
  description:
    "An adaptive, cinematic interface. Not a website — a living digital universe.",
  robots: { index: false, follow: false },
};

export default function UniversePage() {
  return (
    <ProShell>
      <section className="relative mx-auto flex min-h-[90vh] max-w-6xl flex-col items-center justify-center px-6 pt-24 text-center">
        <ToneCopy
          id="hero.eyebrow"
          as="p"
          className="mb-5 text-xs uppercase tracking-[0.4em] text-pro-cyan"
        />
        <ToneCopy
          id="hero.title"
          as="h1"
          className="pro-heading text-5xl leading-[1.05] md:text-7xl"
        />
        <ToneCopy
          id="hero.subtitle"
          as="p"
          className="mt-6 max-w-xl text-pro-text/70"
        />
        <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
          <NebulaButton id="cta-primary">
            <ToneCopy id="hero.ctaPrimary" />
          </NebulaButton>
          <NebulaButton id="cta-secondary" variant="ghost">
            <ToneCopy id="hero.ctaSecondary" />
          </NebulaButton>
        </div>
      </section>

      <section className="relative mx-auto max-w-6xl px-6 py-24">
        <div className="mb-16 text-center">
          <ToneCopy
            id="section.orbit.title"
            as="h2"
            className="pro-heading text-3xl md:text-4xl"
          />
          <ToneCopy
            id="section.orbit.subtitle"
            as="p"
            className="mt-3 text-pro-muted"
          />
        </div>
        <OrbitMenu
          center={
            <div>
              <div className="text-[0.65rem] uppercase tracking-[0.3em] text-pro-cyan">
                core
              </div>
              <div className="pro-heading mt-1 text-lg">Astrobobo</div>
            </div>
          }
          items={[
            { id: "nav-chart", label: "Chart" },
            { id: "nav-transits", label: "Transits" },
            { id: "nav-archetypes", label: "Archetypes" },
            { id: "nav-journal", label: "Journal" },
            { id: "nav-horizon", label: "Horizon" },
            { id: "nav-void", label: "Void" },
          ]}
        />
      </section>

      <section className="relative mx-auto max-w-6xl px-6 py-24">
        <GravityScroll>
          <div className="mb-12 text-center">
            <ToneCopy
              id="section.adaptive.title"
              as="h2"
              className="pro-heading text-3xl md:text-4xl"
            />
            <ToneCopy
              id="section.adaptive.subtitle"
              as="p"
              className="mt-3 text-pro-muted"
            />
          </div>
          <AIAdaptiveContainer minColumns={1} maxColumns={3}>
            <QuantumCard id="card-1" title="Gravity field" glow="violet">
              Every card bends slightly toward your cursor. The bend amount
              scales with the current motion intensity.
            </QuantumCard>
            <QuantumCard id="card-2" title="Emotion score" glow="cyan">
              Your pointer velocity, scroll cadence, and click pattern feed a
              three-dimensional emotion score updated ~60 Hz.
            </QuantumCard>
            <QuantumCard id="card-3" title="Reveal levels" glow="amber">
              Early in the session, only the essentials render. As engagement
              grows, deeper layers unlock without a reload.
            </QuantumCard>
            <QuantumCard
              id="card-4"
              title="Confusion collapse"
              glow="violet"
              data-pro-secondary
            >
              If the system detects rage or hesitation, the layout collapses
              to a single focus and non-primary nodes fade out.
            </QuantumCard>
            <QuantumCard
              id="card-5"
              title="Power mode"
              glow="cyan"
              data-pro-secondary
            >
              Power users unlock advanced panels and denser grids.
              Everything runs at a higher motion intensity.
            </QuantumCard>
            <QuantumCard
              id="card-6"
              title="Universe runtime"
              glow="amber"
              data-pro-secondary
            >
              A 260-particle gravity simulation runs behind every Pro page,
              driven by the same store the UI reads from.
            </QuantumCard>
          </AIAdaptiveContainer>
        </GravityScroll>
      </section>

      <section className="relative mx-auto max-w-xl px-6 py-24">
        <div className="mb-8 text-center">
          <ToneCopy
            id="section.pulse.title"
            as="h2"
            className="pro-heading text-3xl md:text-4xl"
          />
          <ToneCopy
            id="section.pulse.subtitle"
            as="p"
            className="mt-3 text-pro-muted"
          />
        </div>
        <div className="space-y-5">
          <TonePulseInput copyId="input.name.label" id="input-name" placeholder="Traveler" />
          <TonePulseInput
            copyId="input.birth.label"
            id="input-birth"
            placeholder="YYYY-MM-DD"
          />
          <div className="pt-4">
            <NebulaButton id="cta-enter" variant="secondary">
              <ToneCopy id="hero.ctaPrimary" />
            </NebulaButton>
          </div>
        </div>
      </section>

      <footer className="relative mx-auto max-w-6xl px-6 pb-16 pt-32 text-center text-xs uppercase tracking-[0.3em] text-pro-muted">
        <ToneCopy id="footer.tagline" />
      </footer>
    </ProShell>
  );
}
