/**
 * Astrobobo Web Pro — engagement tracker.
 *
 * Per-node engagement accounting. Components call `trackNode(id, event)` via
 * the context; the tracker keeps a decaying score per node and exposes the
 * top node for gravity / focus decisions.
 *
 * This is a deliberately small, dependency-free core — the zustand store in
 * lib/pro-store.ts hosts the singleton instance.
 */

export type EngagementEvent =
  | { type: "hover"; weight?: number }
  | { type: "click"; weight?: number }
  | { type: "dwell"; ms: number }
  | { type: "focus"; weight?: number };

type NodeEntry = {
  id: string;
  score: number;
  lastTouch: number;
};

export class EngagementTracker {
  private nodes = new Map<string, NodeEntry>();

  track(id: string, event: EngagementEvent, now = performance.now()) {
    const entry = this.nodes.get(id) ?? { id, score: 0, lastTouch: now };
    let impulse = 0;
    switch (event.type) {
      case "hover":
        impulse = event.weight ?? 0.3;
        break;
      case "click":
        impulse = event.weight ?? 2.2;
        break;
      case "dwell":
        impulse = Math.min(event.ms / 1600, 2);
        break;
      case "focus":
        impulse = event.weight ?? 1.1;
        break;
    }
    entry.score = Math.min(entry.score * decay(now - entry.lastTouch) + impulse, 24);
    entry.lastTouch = now;
    this.nodes.set(id, entry);
  }

  /** Apply time-decay to every node without touching scores. */
  tick(now = performance.now()) {
    for (const entry of this.nodes.values()) {
      entry.score *= decay(now - entry.lastTouch);
      entry.lastTouch = now;
    }
  }

  top(limit = 5): NodeEntry[] {
    return [...this.nodes.values()]
      .sort((a, b) => b.score - a.score)
      .slice(0, limit);
  }

  mostEngaged(): string | null {
    return this.top(1)[0]?.id ?? null;
  }

  totalInteractions(): number {
    let n = 0;
    for (const entry of this.nodes.values()) n += Math.round(entry.score);
    return n;
  }

  snapshot(): Record<string, number> {
    const out: Record<string, number> = {};
    for (const [id, entry] of this.nodes) out[id] = entry.score;
    return out;
  }
}

/** Half-life of roughly 6s — fresh activity dominates. */
function decay(dtMs: number) {
  return Math.pow(0.5, dtMs / 6000);
}
