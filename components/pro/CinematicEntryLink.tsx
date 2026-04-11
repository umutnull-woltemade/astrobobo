/**
 * CinematicEntryLink — a small client island for cosmic pages that want
 * to link into the Pro layer. Kicks the Three.js scene prefetch on hover
 * so first-click feels instant.
 *
 * Kept in components/pro/ (not app/universe/) so it can be imported from
 * any cosmic server component without forcing that component into a
 * client boundary.
 */

"use client";

import Link from "next/link";
import { usePrefetchScene } from "@/app/universe/prefetch";

type Props = {
  href: string;
  label?: string;
  className?: string;
};

export function CinematicEntryLink({
  href,
  label = "Enter cinematic mode",
  className,
}: Props) {
  const prefetchHandlers = usePrefetchScene();
  return (
    <Link
      href={href}
      {...prefetchHandlers}
      className={
        className ??
        "mt-6 inline-flex items-center gap-2 text-xs uppercase tracking-[0.25em] text-cosmic-accent hover:text-cosmic-accent-soft transition-colors"
      }
    >
      <span>{label}</span>
      <span aria-hidden>→</span>
    </Link>
  );
}
