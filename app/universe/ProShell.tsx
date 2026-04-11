/**
 * ProShell — the client boundary that owns the Pro runtime.
 *
 * Any page that wants Astrobobo Web Pro behavior wraps its tree in this.
 * It mounts:
 *   - useUserBehavior (captures events → store)
 *   - useProEngine (RAF adaptation loop)
 *   - the WebGL background scene
 *   - the AI field overlay
 *
 * Exists as a small client component so /app/universe/page.tsx can stay
 * a server component for metadata.
 */

"use client";

import { useEffect, type PropsWithChildren } from "react";
import { useUserBehavior } from "@/lib/hooks/useUserBehavior";
import { useProEngine } from "@/lib/hooks/useAIState";
import { useNodeEngagement } from "@/lib/hooks/useNodeEngagement";
import { useSessionPersistence } from "@/lib/hooks/useSessionPersistence";
import { useToneOverride } from "@/lib/hooks/useToneOverride";
import { useCohort } from "@/lib/hooks/useCohort";
import { useInvariants } from "@/lib/hooks/useInvariants";
import { useProStore } from "@/lib/pro/pro-store";
import { installTonePacks } from "@/lib/pro/tone-packs";
import type { Locale } from "@/lib/i18n/config";
import { LazyScene } from "./LazyScene";
import { AIField } from "./ai-field";

// Fire once at module load so the tone packs are ready before any
// <ToneCopy> renders. Safe on server: registerLocalePack is sync + pure.
installTonePacks();

export function ProShell({
  children,
  showDebug = true,
  locale = "en",
}: PropsWithChildren<{ showDebug?: boolean; locale?: Locale }>) {
  const setLocale = useProStore((s) => s.setLocale);

  useEffect(() => {
    setLocale(locale);
  }, [locale, setLocale]);

  useUserBehavior();
  useNodeEngagement();
  useProEngine();
  useSessionPersistence();
  useToneOverride();
  useCohort();
  useInvariants();

  return (
    <div className="pro-root relative">
      <div className="fixed inset-0 z-0">
        <LazyScene />
      </div>
      <AIField showDebug={showDebug} />
      <div className="relative z-20">{children}</div>
    </div>
  );
}
