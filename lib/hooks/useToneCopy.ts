/**
 * useToneCopy — returns a memoized `t(id)` bound to the current tone +
 * locale. Locale comes from the Pro store (set by ProShell); callers
 * don't need to know the source.
 */

"use client";

import { useCallback } from "react";
import { useProStore } from "@/lib/pro/pro-store";
import { selectCopy } from "@/lib/pro/copy-registry";

export function useToneCopy() {
  const tone = useProStore((s) => s.directive.tone);
  const locale = useProStore((s) => s.locale);
  return useCallback((id: string) => selectCopy(id, tone, locale), [tone, locale]);
}

export function useTone() {
  return useProStore((s) => s.directive.tone);
}
