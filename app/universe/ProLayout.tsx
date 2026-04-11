/**
 * ProLayout — single-import boilerplate for any Pro route.
 *
 * Rather than duplicating `<ProShell>` + `<section>` scaffolding in each
 * new Pro page, pages can do:
 *
 *   export default function MyPage() {
 *     return (
 *       <ProLayout eyebrow="astrobobo / pro / foo" title="Foo">
 *         ...content...
 *       </ProLayout>
 *     );
 *   }
 *
 * Title and eyebrow are optional — pass empty strings to opt out. The
 * component is a client boundary because ProShell is; server components
 * can still render this directly.
 */

"use client";

import type { PropsWithChildren, ReactNode } from "react";
import { ProShell } from "./ProShell";
import type { Locale } from "@/lib/i18n/config";

type ProLayoutProps = PropsWithChildren<{
  eyebrow?: string;
  title?: ReactNode;
  subtitle?: ReactNode;
  actions?: ReactNode;
  locale?: Locale;
  showDebug?: boolean;
  /**
   * Set to false to skip the hero block entirely — useful for routes that
   * render their own custom entry (e.g. the orbital zodiac picker).
   */
  hero?: boolean;
}>;

export function ProLayout({
  children,
  eyebrow,
  title,
  subtitle,
  actions,
  locale = "en",
  showDebug = true,
  hero = true,
}: ProLayoutProps) {
  return (
    <ProShell locale={locale} showDebug={showDebug}>
      {hero && (title || eyebrow || subtitle) ? (
        <section className="relative mx-auto flex max-w-6xl flex-col items-center px-6 pt-24 text-center">
          {eyebrow ? (
            <p className="mb-5 text-xs uppercase tracking-[0.4em] text-pro-cyan">
              {eyebrow}
            </p>
          ) : null}
          {title ? (
            <h1 className="pro-heading text-4xl leading-[1.05] md:text-6xl">
              {title}
            </h1>
          ) : null}
          {subtitle ? (
            <p className="mt-6 max-w-xl text-pro-text/70">{subtitle}</p>
          ) : null}
          {actions ? (
            <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
              {actions}
            </div>
          ) : null}
        </section>
      ) : null}
      {children}
    </ProShell>
  );
}
