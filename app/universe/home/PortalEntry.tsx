/**
 * PortalEntry — the first-visit state of /universe/home.
 *
 * A two-field cinematic portal: optional name + birth date. Computes the
 * sun sign client-side, persists the profile, and tells the parent to
 * switch to the dashboard. No tools, no menu — just a gate between the
 * void and a personal sky.
 *
 * Intentionally minimal ask. We can layer time/place later for full chart
 * computation; a homepage should not gatekeep on a four-field form.
 */

"use client";

import { motion } from "framer-motion";
import { useState } from "react";
import { NebulaButton } from "@/components/pro/NebulaButton";
import { PulseInput } from "@/components/pro/PulseInput";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";
import { saveProfile, type UserProfile } from "@/lib/pro/user-profile";
import { getSunSignFromDate } from "@/lib/pro/sun-sign";

type Props = {
  onComplete: (profile: UserProfile) => void;
  locale?: "en" | "tr";
};

const COPY = {
  tr: {
    eyebrow: "astrobobo / senin göğün",
    title: "Sen daha önce buraya gelmedin.",
    subtitle:
      "Sadece iki şey söyle — sana ait gökyüzünü açayım.",
    nameLabel: "Adın (opsiyonel)",
    namePlaceholder: "Yolcu",
    birthLabel: "Doğum tarihin",
    birthPlaceholder: "YYYY-AA-GG",
    cta: "Göğümü aç",
    invalid: "Lütfen geçerli bir tarih gir (ör. 1988-06-14)",
    privacy:
      "Bilgilerin yalnızca bu tarayıcıda tutulur. Bir hesap oluşturmaz, bir şey göndermezsin.",
  },
  en: {
    eyebrow: "astrobobo / your sky",
    title: "You haven't been here before.",
    subtitle:
      "Tell me just two things — I'll open the sky that belongs to you.",
    nameLabel: "Your name (optional)",
    namePlaceholder: "Traveler",
    birthLabel: "Your birth date",
    birthPlaceholder: "YYYY-MM-DD",
    cta: "Open my sky",
    invalid: "Please enter a valid date (e.g. 1988-06-14)",
    privacy:
      "Your info stays in this browser only. No account, no sending.",
  },
};

export function PortalEntry({ onComplete, locale = "tr" }: Props) {
  const t = COPY[locale];
  const { spring } = useMotionPhysics();
  const [name, setName] = useState("");
  const [birth, setBirth] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const handleSubmit = () => {
    setError(null);
    const sunSign = getSunSignFromDate(birth);
    if (!sunSign) {
      setError(t.invalid);
      return;
    }
    setSubmitting(true);
    const profile = saveProfile({ name, birthDate: birth });
    if (!profile) {
      setError(t.invalid);
      setSubmitting(false);
      return;
    }
    // Let the charge animation breathe before the dashboard morph.
    window.setTimeout(() => onComplete(profile), 650);
  };

  return (
    <section className="relative mx-auto flex min-h-[100vh] max-w-3xl flex-col items-center justify-center px-6 text-center">
      <motion.p
        initial={{ opacity: 0, y: 12 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ ...spring, delay: 0.1 }}
        className="mb-5 text-xs uppercase tracking-[0.45em] text-pro-cyan"
      >
        {t.eyebrow}
      </motion.p>

      <motion.h1
        initial={{ opacity: 0, y: 28, filter: "blur(10px)" }}
        animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
        transition={{ ...spring, delay: 0.25 }}
        className="pro-heading text-4xl leading-[1.08] md:text-6xl"
      >
        {t.title}
      </motion.h1>

      <motion.p
        initial={{ opacity: 0, y: 18 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ ...spring, delay: 0.45 }}
        className="mt-6 max-w-xl text-pro-text/75"
      >
        {t.subtitle}
      </motion.p>

      <motion.form
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ ...spring, delay: 0.65 }}
        onSubmit={(e) => {
          e.preventDefault();
          handleSubmit();
        }}
        className="mt-14 w-full max-w-md space-y-5 text-left"
      >
        <PulseInput
          id="portal-name"
          label={t.nameLabel}
          placeholder={t.namePlaceholder}
          value={name}
          onChange={setName}
        />
        <PulseInput
          id="portal-birth"
          label={t.birthLabel}
          placeholder={t.birthPlaceholder}
          value={birth}
          onChange={(v) => {
            setBirth(v);
            if (error) setError(null);
          }}
        />

        {error ? (
          <motion.p
            initial={{ opacity: 0, y: -4 }}
            animate={{ opacity: 1, y: 0 }}
            className="text-center text-xs uppercase tracking-widest text-pro-amber"
          >
            {error}
          </motion.p>
        ) : null}

        <div className="pt-4 text-center">
          <NebulaButton
            id="portal-submit"
            variant="primary"
            type="submit"
            onClick={handleSubmit}
          >
            {submitting ? "…" : t.cta}
          </NebulaButton>
        </div>

        <p className="pt-6 text-center text-[0.65rem] uppercase tracking-[0.2em] text-pro-muted">
          {t.privacy}
        </p>
      </motion.form>
    </section>
  );
}
