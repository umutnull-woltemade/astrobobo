/**
 * TonePulseInput — tiny client wrapper that feeds a tone-aware label into
 * PulseInput. Exists so the server component in /universe/page.tsx can stay
 * a server component while the label text reacts to the live tone.
 */

"use client";

import { PulseInput } from "@/components/pro/PulseInput";
import { useToneCopy } from "@/lib/hooks/useToneCopy";

type Props = {
  copyId: string;
  id: string;
  placeholder?: string;
};

export function TonePulseInput({ copyId, id, placeholder }: Props) {
  const t = useToneCopy();
  return <PulseInput id={id} label={t(copyId)} placeholder={placeholder} />;
}
