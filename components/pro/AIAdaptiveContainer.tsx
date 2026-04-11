/**
 * AIAdaptiveContainer — the morphing layout container.
 *
 * Reads the current directive and reshapes its children:
 *   - density → grid gap + column count
 *   - airiness → vertical padding
 *   - revealLevel → how many children are actually mounted
 *   - collapseSecondary → hides children marked with `data-pro-secondary`
 *
 * Children must be stable `key`ed nodes so framer-motion's shared layout
 * animations can morph them between configurations.
 */

"use client";

import { LayoutGroup, motion } from "framer-motion";
import { Children, useMemo } from "react";
import type { ReactNode, ReactElement } from "react";
import { useDirective } from "@/lib/hooks/useAIState";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";
import { useProStore } from "@/lib/pro/pro-store";

type AIAdaptiveContainerProps = {
  children: ReactNode;
  minColumns?: number;
  maxColumns?: number;
  className?: string;
  /**
   * When true (default), top-engaged children float toward the front of
   * the grid while `directive.gravitate` is active. Set to false to keep
   * a stable authored order regardless of behavior.
   */
  reorder?: boolean;
};

export function AIAdaptiveContainer({
  children,
  minColumns = 1,
  maxColumns = 4,
  className = "",
  reorder = true,
}: AIAdaptiveContainerProps) {
  const directive = useDirective();
  const ranking = useProStore((s) => s.engagementRanking);
  const { spring } = useMotionPhysics();

  const columns = useMemo(() => {
    const range = maxColumns - minColumns;
    return Math.round(minColumns + range * directive.density);
  }, [directive.density, minColumns, maxColumns]);

  const gap = useMemo(() => 16 + directive.airiness * 44, [directive.airiness]);
  const paddingY = useMemo(() => 24 + directive.airiness * 64, [directive.airiness]);

  const visible = useMemo(() => {
    type ChildProps = {
      "data-pro-secondary"?: boolean;
      "data-pro-node"?: string;
      id?: string;
    };

    const nodes = Children.toArray(children).filter((child) => {
      if (!directive.collapseSecondary) return true;
      const element = child as ReactElement<ChildProps>;
      return !element?.props?.["data-pro-secondary"];
    });

    // Apply reveal-level cap first — we never want to reorder into the
    // hidden bucket, since higher-engagement children should stay mounted.
    const revealCaps = [3, 6, 10, Infinity];
    const cap = revealCaps[directive.revealLevel];

    if (!reorder || !directive.gravitate || ranking.length === 0) {
      return nodes.slice(0, cap);
    }

    // Stable reorder: build a rank map, then sort. Children without a
    // data-pro-node retain their authored position via a fallback index.
    const rankMap = new Map<string, number>();
    ranking.forEach((id, i) => rankMap.set(id, i));

    const decorated = nodes.map((child, i) => {
      const element = child as ReactElement<ChildProps>;
      const nodeId =
        element?.props?.["data-pro-node"] ?? element?.props?.id ?? null;
      const rank = nodeId && rankMap.has(nodeId)
        ? rankMap.get(nodeId)!
        : Number.POSITIVE_INFINITY;
      return { child, rank, authoredIndex: i };
    });

    decorated.sort((a, b) => {
      if (a.rank !== b.rank) return a.rank - b.rank;
      return a.authoredIndex - b.authoredIndex;
    });

    return decorated.slice(0, cap).map((d) => d.child);
  }, [
    children,
    directive.collapseSecondary,
    directive.revealLevel,
    directive.gravitate,
    ranking,
    reorder,
  ]);

  return (
    <LayoutGroup>
      <motion.div
        layout
        className={`grid ${className}`}
        style={{
          gridTemplateColumns: `repeat(${columns}, minmax(0, 1fr))`,
          gap: `${gap}px`,
          paddingTop: `${paddingY}px`,
          paddingBottom: `${paddingY}px`,
        }}
        transition={spring}
      >
        {visible.map((child, i) => (
          <motion.div
            key={(child as ReactElement).key ?? i}
            layout
            initial={{ opacity: 0, y: 24 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -16 }}
            transition={{ ...spring, delay: i * 0.035 }}
          >
            {child}
          </motion.div>
        ))}
      </motion.div>
    </LayoutGroup>
  );
}
