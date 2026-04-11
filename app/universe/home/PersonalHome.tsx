/**
 * PersonalHome — the client island that flips between PortalEntry and
 * Dashboard based on whether a profile exists in localStorage.
 *
 * Wrapped by the server-rendered page in a ProLayout so it gets the full
 * cinematic runtime (scene, adaptation engine, tone engine, invariants).
 *
 * Uses AnimatePresence for the state transition so switching from the
 * entry form to the dashboard feels like a dimensional shift rather than
 * a page swap.
 */

"use client";

import { AnimatePresence, motion } from "framer-motion";
import { useEffect, useState } from "react";
import { loadProfile, clearProfile, type UserProfile } from "@/lib/pro/user-profile";
import { PortalEntry } from "./PortalEntry";
import { Dashboard } from "./Dashboard";

type Props = {
  locale?: "en" | "tr";
};

export function PersonalHome({ locale = "tr" }: Props) {
  // Start with null so SSR renders the PortalEntry — most visitors don't
  // have a profile yet and this gives them instant content on first paint.
  // Returning users will flash the portal for one frame before the
  // localStorage read in useEffect swaps them into the Dashboard.
  const [profile, setProfile] = useState<UserProfile | null>(null);

  useEffect(() => {
    const loaded = loadProfile();
    if (loaded) setProfile(loaded);
  }, []);

  const handleComplete = (next: UserProfile) => {
    setProfile(next);
  };

  const handleEdit = () => {
    clearProfile();
    setProfile(null);
  };

  return (
    <AnimatePresence mode="wait">
      {profile ? (
        <motion.div
          key="dashboard"
          initial={{ opacity: 0, y: 18, filter: "blur(8px)" }}
          animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
          exit={{ opacity: 0, y: -12, filter: "blur(6px)" }}
          transition={{ duration: 0.8, ease: [0.22, 1, 0.36, 1] }}
        >
          <Dashboard
            profile={profile}
            onEditProfile={handleEdit}
            locale={locale}
          />
        </motion.div>
      ) : (
        <motion.div
          key="portal"
          initial={{ opacity: 0, filter: "blur(10px)" }}
          animate={{ opacity: 1, filter: "blur(0px)" }}
          exit={{ opacity: 0, filter: "blur(6px)" }}
          transition={{ duration: 0.7, ease: [0.22, 1, 0.36, 1] }}
        >
          <PortalEntry onComplete={handleComplete} locale={locale} />
        </motion.div>
      )}
    </AnimatePresence>
  );
}
