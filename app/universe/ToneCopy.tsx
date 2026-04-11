/**
 * ToneCopy — tiny client component that renders a tone-aware string.
 *
 * Server components can import this directly. It exists so /universe/page.tsx
 * can stay a server component while individual string nodes still react to
 * the live tone mode.
 */

"use client";

import { useToneCopy } from "@/lib/hooks/useToneCopy";

type ToneCopyProps = {
  id: string;
  as?: "span" | "p" | "h1" | "h2" | "h3" | "div";
  className?: string;
};

export function ToneCopy({ id, as: Tag = "span", className }: ToneCopyProps) {
  const t = useToneCopy();
  const value = t(id);
  // Preserve explicit \n characters from the registry as real line breaks.
  if (value.includes("\n")) {
    return (
      <Tag className={className}>
        {value.split("\n").map((line, i, arr) => (
          <span key={i}>
            {line}
            {i < arr.length - 1 ? <br /> : null}
          </span>
        ))}
      </Tag>
    );
  }
  return <Tag className={className}>{value}</Tag>;
}
