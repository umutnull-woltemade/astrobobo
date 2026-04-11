/**
 * /universe/home — the Personal Sky.
 *
 * The cinematic personalized entry point. Tools are intentionally absent:
 * first-visit is a two-field portal (name + birth date), returning visits
 * land in a dashboard of what the sky is doing for them today.
 *
 * Locale defaults to Turkish to match astrobobo.com's primary audience.
 * The route lives outside the [locale] tree so it's reachable at the
 * apex via the cross-project rewrite proxy.
 */

import type { Metadata } from "next";
import { ProLayout } from "../ProLayout";
import { PersonalHome } from "./PersonalHome";

export const metadata: Metadata = {
  title: "Astrobobo — Senin Göğün",
  description:
    "Kendine ait gökyüzünü gör. Senin için seçilmiş geçişler, yansımalar ve sözler.",
  robots: { index: false, follow: false },
};

export default function UniverseHomePage() {
  return (
    <ProLayout locale="tr" hero={false}>
      <PersonalHome locale="tr" />
    </ProLayout>
  );
}
