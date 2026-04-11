/**
 * Dashboard — the returning-user state of /universe/home.
 *
 * Shows a personalized cosmic dashboard:
 *   - Greeting + sun sign hero
 *   - Primary transit (most impactful slow-planet movement through user's chart)
 *   - Secondary transits (up to 3 more)
 *   - Daily reflection question
 *   - Daily affirmation (preferring sign-aligned entries)
 *   - Archetype anchor (link into /universe/archetype/[slug])
 *
 * Everything is content, not tools. The "go deeper" block at the bottom
 * is the only link-out — and it leads into more content (archetype page
 * and a hand-picked article), not to a menu of tools.
 */

"use client";

import { motion } from "framer-motion";
import Link from "next/link";
import { useMemo } from "react";
import {
  getPersonalTransits,
  type PersonalTransit,
  type ZodiacSlug,
} from "@/content/transits";
import { getZodiacSign, type ZodiacSign } from "@/content/zodiac";
import { reflections, type Reflection } from "@/content/reflections";
import { affirmations, type Affirmation } from "@/content/affirmations";
import { QuantumCard } from "@/components/pro/QuantumCard";
import { NebulaButton } from "@/components/pro/NebulaButton";
import { GravityScroll } from "@/components/pro/GravityScroll";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";
import type { UserProfile } from "@/lib/pro/user-profile";

type Props = {
  profile: UserProfile;
  onEditProfile: () => void;
  locale?: "en" | "tr";
};

const SIGN_SYMBOL: Record<ZodiacSlug, string> = {
  aries: "\u2648",
  taurus: "\u2649",
  gemini: "\u264A",
  cancer: "\u264B",
  leo: "\u264C",
  virgo: "\u264D",
  libra: "\u264E",
  scorpio: "\u264F",
  sagittarius: "\u2650",
  capricorn: "\u2651",
  aquarius: "\u2652",
  pisces: "\u2653",
};

const PLANET_SYMBOL: Record<string, string> = {
  saturn: "♄",
  jupiter: "♃",
  mars: "♂",
  venus: "♀",
  mercury: "☿",
  sun: "☉",
  moon: "☽",
  uranus: "♅",
  neptune: "♆",
  pluto: "♇",
};

const COPY = {
  tr: {
    eyebrow: "senin göğün",
    hello: (name: string) =>
      name ? `Merhaba ${name}, göğün bugün seninle konuşuyor.` : "Göğün bugün seninle konuşuyor.",
    todayLabel: "bugün",
    primary: "Seni en çok etkileyen gelişme",
    secondary: "Çevreden gelen diğer sesler",
    noTransits:
      "Bugün gök sessiz — büyük geçişler yok. Bu, içe dönmek için sana verilen bir alan olabilir.",
    reflection: "Günün sorusu",
    affirmation: "Bugün kendine söyleyebileceğin",
    archetypeTitle: (name: string) => `${name} arketipinden bir ses`,
    deeperHeading: "Daha derine inmek ister misin?",
    deeperSub: "Sadece senin için seçilmiş iki kapı.",
    goArchetype: "Arketipimi keşfet",
    goRead: "Bu haftaya dair bir yazı",
    edit: "Bilgilerimi düzenle",
  },
  en: {
    eyebrow: "your sky",
    hello: (name: string) =>
      name ? `Hello ${name}, the sky is speaking to you today.` : "The sky is speaking to you today.",
    todayLabel: "today",
    primary: "What's affecting you most",
    secondary: "Other voices in the background",
    noTransits:
      "The sky is quiet today — no major transits. This is space given to you for turning inward.",
    reflection: "Today's question",
    affirmation: "Something to tell yourself today",
    archetypeTitle: (name: string) => `A voice from the ${name} archetype`,
    deeperHeading: "Want to go deeper?",
    deeperSub: "Two doors, both picked for you.",
    goArchetype: "Explore my archetype",
    goRead: "A piece for this week",
    edit: "Edit my info",
  },
};

function pickDaily<T>(list: T[], seed: number): T {
  if (list.length === 0) return list[0];
  const idx = Math.abs(seed) % list.length;
  return list[idx];
}

function dailySeed(profile: UserProfile, date: Date): number {
  // Stable across the day, varies by user. Not crypto — just a shuffle.
  const day = Math.floor(date.getTime() / 86_400_000);
  let hash = 0;
  const key = profile.birthDate + profile.sunSign;
  for (let i = 0; i < key.length; i++) {
    hash = (hash * 31 + key.charCodeAt(i)) | 0;
  }
  return hash + day;
}

function pickReflection(profile: UserProfile, date: Date): Reflection {
  const hour = date.getHours();
  const seed = dailySeed(profile, date);
  // Morning before noon, evening after 18:00, otherwise growth.
  const category =
    hour < 12 ? "morning" : hour >= 18 ? "evening" : "growth";
  const pool = reflections.filter((r) => r.category === category);
  return pickDaily(pool.length > 0 ? pool : reflections, seed);
}

function pickAffirmation(profile: UserProfile, date: Date): Affirmation {
  const seed = dailySeed(profile, date);
  // Prefer affirmations tied to the user's sun sign; fall back to all.
  const aligned = affirmations.filter(
    (a) => a.relatedSign === profile.sunSign
  );
  return pickDaily(aligned.length > 0 ? aligned : affirmations, seed);
}

function pickDailyInspiration(sign: ZodiacSign, seed: number): string {
  if (sign.dailyInspiration.length === 0) return sign.overview.slice(0, 140);
  return pickDaily(sign.dailyInspiration, seed);
}

function formatDateForLocale(date: Date, locale: "en" | "tr") {
  try {
    return new Intl.DateTimeFormat(locale === "tr" ? "tr-TR" : "en-US", {
      weekday: "long",
      day: "numeric",
      month: "long",
    }).format(date);
  } catch {
    return date.toDateString();
  }
}

function getSlowestRelatedArticleSlug(sign: ZodiacSlug): string {
  // Hand-picked article slugs tied to signs (from content/articles corpus).
  // Falls back to the elements article, which always exists.
  const byElement: Partial<Record<ZodiacSlug, string>> = {
    aries: "understanding-the-four-elements-in-astrology",
    leo: "understanding-the-four-elements-in-astrology",
    sagittarius: "understanding-the-four-elements-in-astrology",
    taurus: "understanding-the-four-elements-in-astrology",
    virgo: "understanding-the-four-elements-in-astrology",
    capricorn: "understanding-the-four-elements-in-astrology",
  };
  return (
    byElement[sign] ?? "what-your-sun-sign-reveals-about-your-core-identity"
  );
}

export function Dashboard({ profile, onEditProfile, locale = "tr" }: Props) {
  const t = COPY[locale];
  const { spring } = useMotionPhysics();

  const now = useMemo(() => new Date(), []);
  const transits = useMemo<PersonalTransit[]>(
    () => getPersonalTransits(profile.sunSign, now),
    [profile.sunSign, now]
  );
  const primary = transits[0] ?? null;
  const secondaries = transits.slice(1, 4);

  const sign = useMemo(
    () => getZodiacSign(profile.sunSign),
    [profile.sunSign]
  );

  const reflection = useMemo(
    () => pickReflection(profile, now),
    [profile, now]
  );
  const affirmation = useMemo(
    () => pickAffirmation(profile, now),
    [profile, now]
  );

  const seed = useMemo(() => dailySeed(profile, now), [profile, now]);
  const dailyLine = useMemo(
    () => (sign ? pickDailyInspiration(sign, seed) : ""),
    [sign, seed]
  );

  const formattedDate = formatDateForLocale(now, locale);
  const articleSlug = getSlowestRelatedArticleSlug(profile.sunSign);

  return (
    <>
      {/* ─── Hero: greeting + sun-sign glyph ─── */}
      <section className="relative mx-auto flex max-w-5xl flex-col items-center px-6 pt-24 text-center">
        <motion.p
          initial={{ opacity: 0, y: 8 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ ...spring, delay: 0.05 }}
          className="mb-3 text-[0.65rem] uppercase tracking-[0.4em] text-pro-cyan"
        >
          {t.eyebrow} · {formattedDate}
        </motion.p>

        <motion.div
          initial={{ opacity: 0, scale: 0.7 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ ...spring, delay: 0.15 }}
          className="relative mb-6 inline-block"
        >
          <span
            aria-hidden
            className="absolute inset-0 -m-8 rounded-full bg-pro-violet/30 blur-3xl animate-pro-breathe"
          />
          <span className="relative text-[5rem] leading-none md:text-[7rem]">
            {SIGN_SYMBOL[profile.sunSign]}
          </span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 22, filter: "blur(8px)" }}
          animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
          transition={{ ...spring, delay: 0.3 }}
          className="pro-heading text-3xl leading-[1.12] md:text-5xl"
        >
          {t.hello(profile.name)}
        </motion.h1>

        {dailyLine ? (
          <motion.p
            initial={{ opacity: 0, y: 14 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ ...spring, delay: 0.45 }}
            className="mt-6 max-w-2xl font-pro text-lg italic leading-relaxed text-pro-text/85 md:text-xl"
          >
            &ldquo;{dailyLine}&rdquo;
          </motion.p>
        ) : null}
      </section>

      {/* ─── Primary transit ─── */}
      <section className="relative mx-auto max-w-4xl px-6 pt-20">
        <GravityScroll depth={40}>
          <div className="mb-6 text-center">
            <p className="text-xs uppercase tracking-[0.3em] text-pro-cyan">
              {t.primary}
            </p>
          </div>
          {primary ? (
            <PrimaryTransitCard
              transit={primary}
              locale={locale}
            />
          ) : (
            <QuantumCard
              id="home-no-transit"
              glow="cyan"
              className="text-center"
            >
              <p className="font-pro text-lg italic leading-relaxed text-pro-text/85">
                {t.noTransits}
              </p>
            </QuantumCard>
          )}
        </GravityScroll>
      </section>

      {/* ─── Secondary transits ─── */}
      {secondaries.length > 0 ? (
        <section className="relative mx-auto max-w-5xl px-6 py-16">
          <div className="mb-8 text-center">
            <p className="text-xs uppercase tracking-[0.3em] text-pro-cyan">
              {t.secondary}
            </p>
          </div>
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {secondaries.map((tr, i) => (
              <SecondaryTransitCard
                key={tr.transit.id}
                transit={tr}
                locale={locale}
                index={i}
              />
            ))}
          </div>
        </section>
      ) : null}

      {/* ─── Reflection + Affirmation ─── */}
      <section className="relative mx-auto grid max-w-5xl gap-6 px-6 py-16 md:grid-cols-2">
        <motion.div
          initial={{ opacity: 0, y: 28 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, margin: "-40px" }}
          transition={spring}
        >
          <QuantumCard
            id="home-reflection"
            title={t.reflection}
            glow="violet"
          >
            <p className="font-pro text-base italic leading-relaxed text-pro-text/90">
              {reflection.text}
            </p>
          </QuantumCard>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 28 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, margin: "-40px" }}
          transition={{ ...spring, delay: 0.1 }}
        >
          <QuantumCard
            id="home-affirmation"
            title={t.affirmation}
            glow="amber"
          >
            <p className="font-pro text-base leading-relaxed text-pro-text/90">
              {affirmation.text}
            </p>
          </QuantumCard>
        </motion.div>
      </section>

      {/* ─── Go deeper ─── */}
      <section className="relative mx-auto max-w-5xl px-6 py-24">
        <div className="mb-12 text-center">
          <h2 className="pro-heading text-3xl md:text-4xl">
            {t.deeperHeading}
          </h2>
          <p className="mt-3 text-pro-muted">{t.deeperSub}</p>
        </div>
        <div className="grid gap-6 md:grid-cols-2">
          <DeeperLink
            id="home-go-archetype"
            href={`/universe/archetype/${profile.sunSign}`}
            eyebrow={sign?.name ?? profile.sunSign}
            title={t.goArchetype}
            glow="cyan"
          />
          <DeeperLink
            id="home-go-read"
            href={`/universe/read/${articleSlug}`}
            eyebrow={locale === "tr" ? "bu hafta" : "this week"}
            title={t.goRead}
            glow="violet"
          />
        </div>
      </section>

      {/* ─── Edit profile footer ─── */}
      <footer className="relative mx-auto max-w-5xl px-6 pb-16 pt-8 text-center">
        <NebulaButton
          id="home-edit-profile"
          variant="ghost"
          onClick={onEditProfile}
        >
          {t.edit}
        </NebulaButton>
      </footer>
    </>
  );
}

/* ─────────────────────────────────────────────────────────────────────── */

function PrimaryTransitCard({
  transit,
  locale,
}: {
  transit: PersonalTransit;
  locale: "en" | "tr";
}) {
  const interp = transit.interpretation;
  const title = locale === "tr" ? interp.titleTr : interp.titleEn;
  const body = locale === "tr" ? interp.bodyTr : interp.bodyEn;
  const theme =
    locale === "tr" ? transit.houseTheme.tr : transit.houseTheme.en;
  const duration =
    locale === "tr" ? interp.durationTr : interp.durationEn;
  const glyph = PLANET_SYMBOL[transit.transit.planet] ?? "✦";

  return (
    <motion.div
      initial={{ opacity: 0, y: 36, filter: "blur(10px)" }}
      animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
      transition={{ duration: 0.9, ease: [0.22, 1, 0.36, 1] }}
    >
      <QuantumCard
        id={`home-primary-${transit.transit.id}`}
        glow="violet"
        className="overflow-hidden"
      >
        <div className="mb-4 flex items-center gap-4">
          <span
            aria-hidden
            className="pro-glass flex h-14 w-14 items-center justify-center rounded-full text-3xl text-pro-cyan-soft"
          >
            {glyph}
          </span>
          <div className="text-left">
            <p className="text-[0.6rem] uppercase tracking-[0.3em] text-pro-cyan">
              {locale === "tr" ? "ev" : "house"} {transit.house} · {theme}
            </p>
            <p className="pro-heading mt-1 text-xl md:text-2xl">{title}</p>
          </div>
        </div>
        <p className="text-sm leading-[1.8] text-pro-text/85">{body}</p>
        <p className="mt-4 text-[0.65rem] uppercase tracking-[0.25em] text-pro-muted">
          {duration}
        </p>
      </QuantumCard>
    </motion.div>
  );
}

function SecondaryTransitCard({
  transit,
  locale,
  index,
}: {
  transit: PersonalTransit;
  locale: "en" | "tr";
  index: number;
}) {
  const interp = transit.interpretation;
  const title = locale === "tr" ? interp.titleTr : interp.titleEn;
  const glyph = PLANET_SYMBOL[transit.transit.planet] ?? "✦";
  const theme =
    locale === "tr" ? transit.houseTheme.tr : transit.houseTheme.en;

  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-40px" }}
      transition={{ duration: 0.7, ease: [0.22, 1, 0.36, 1], delay: index * 0.08 }}
    >
      <QuantumCard
        id={`home-secondary-${transit.transit.id}`}
        glow="cyan"
        className="h-full"
      >
        <div className="mb-3 flex items-center gap-3">
          <span aria-hidden className="text-2xl text-pro-cyan-soft">
            {glyph}
          </span>
          <p className="text-[0.6rem] uppercase tracking-[0.25em] text-pro-cyan">
            {locale === "tr" ? "ev" : "house"} {transit.house} · {theme}
          </p>
        </div>
        <p className="pro-heading text-lg">{title}</p>
      </QuantumCard>
    </motion.div>
  );
}

function DeeperLink({
  id,
  href,
  eyebrow,
  title,
  glow,
}: {
  id: string;
  href: string;
  eyebrow: string;
  title: string;
  glow: "violet" | "cyan" | "amber";
}) {
  return (
    <Link href={href} className="block focus:outline-none" data-pro-node={id}>
      <QuantumCard id={`${id}-card`} glow={glow} className="h-full transition-transform">
        <p className="text-[0.65rem] uppercase tracking-[0.3em] text-pro-cyan">
          {eyebrow}
        </p>
        <p className="pro-heading mt-3 text-2xl">{title}</p>
        <p className="mt-6 text-xs uppercase tracking-[0.25em] text-pro-muted">
          → enter
        </p>
      </QuantumCard>
    </Link>
  );
}
