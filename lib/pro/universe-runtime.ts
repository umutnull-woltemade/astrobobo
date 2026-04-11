/**
 * Astrobobo Web Pro — Universe runtime.
 *
 * Canvas-friendly particle + gravity simulation used by the /universe scene.
 * Kept framework-agnostic so it can be driven from a <canvas> 2D context OR
 * a Three.js instanced mesh — whichever renderer we wire up. The scene file
 * instantiates a `Universe`, calls `step(dt)` each RAF, and reads `particles`
 * to push positions into the GPU.
 */

import type { EmotionState } from "./emotion-scoring";

export type Particle = {
  x: number;
  y: number;
  vx: number;
  vy: number;
  life: number;
  seed: number;
  charge: number;
};

export type UniverseConfig = {
  count: number;
  width: number;
  height: number;
  /** World-space strength of cursor attraction. */
  gravity: number;
  /** Damping coefficient per second. */
  damping: number;
};

export const defaultUniverseConfig: UniverseConfig = {
  count: 220,
  width: 1,
  height: 1,
  gravity: 0.35,
  damping: 0.9,
};

export class Universe {
  cfg: UniverseConfig;
  particles: Particle[] = [];
  cursor = { x: 0.5, y: 0.5 };
  emotion: EmotionState = {
    excitement: 0.2,
    confusion: 0,
    curiosity: 0.3,
    engagement: 0.25,
  };
  /** Ripple queue — each click spawns a transient radial impulse. */
  ripples: { x: number; y: number; age: number; power: number }[] = [];

  constructor(cfg: Partial<UniverseConfig> = {}) {
    this.cfg = { ...defaultUniverseConfig, ...cfg };
    this.seed();
  }

  seed() {
    const { count } = this.cfg;
    this.particles = Array.from({ length: count }, (_, i) => ({
      x: Math.random(),
      y: Math.random(),
      vx: (Math.random() - 0.5) * 0.02,
      vy: (Math.random() - 0.5) * 0.02,
      life: Math.random(),
      seed: i,
      charge: 0,
    }));
  }

  resize(width: number, height: number) {
    this.cfg.width = width;
    this.cfg.height = height;
  }

  setCursor(nx: number, ny: number) {
    this.cursor.x = nx;
    this.cursor.y = ny;
  }

  setEmotion(e: EmotionState) {
    this.emotion = e;
  }

  burst(nx: number, ny: number, power = 1) {
    this.ripples.push({ x: nx, y: ny, age: 0, power });
    if (this.ripples.length > 12) this.ripples.shift();
  }

  step(dtMs: number) {
    const dt = Math.min(dtMs, 48) / 1000;
    const e = this.emotion;
    const gravity =
      this.cfg.gravity * (0.6 + e.excitement * 0.9 - e.confusion * 0.3);
    const damping = Math.pow(this.cfg.damping, dt * 60);

    for (const p of this.particles) {
      // Cursor gravity
      const dx = this.cursor.x - p.x;
      const dy = this.cursor.y - p.y;
      const d2 = dx * dx + dy * dy + 0.0025;
      const force = gravity / d2;
      p.vx += dx * force * dt;
      p.vy += dy * force * dt;

      // Ripples push outward
      for (const r of this.ripples) {
        const rdx = p.x - r.x;
        const rdy = p.y - r.y;
        const rd = Math.sqrt(rdx * rdx + rdy * rdy) + 0.001;
        const ringDist = r.age * 0.9;
        const shell = Math.exp(-Math.pow((rd - ringDist) * 14, 2));
        p.vx += (rdx / rd) * shell * r.power * 0.8 * dt;
        p.vy += (rdy / rd) * shell * r.power * 0.8 * dt;
      }

      // Curiosity adds gentle orbital drift around cursor
      const tangentX = -dy;
      const tangentY = dx;
      p.vx += tangentX * e.curiosity * 0.12 * dt;
      p.vy += tangentY * e.curiosity * 0.12 * dt;

      // Integrate + damp
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.vx *= damping;
      p.vy *= damping;

      // Torus wrap — space never ends
      if (p.x < -0.05) p.x = 1.05;
      if (p.x > 1.05) p.x = -0.05;
      if (p.y < -0.05) p.y = 1.05;
      if (p.y > 1.05) p.y = -0.05;

      p.life = (p.life + dt * (0.2 + e.excitement * 0.6)) % 1;
      p.charge = Math.max(0, p.charge - dt * 0.9);
    }

    // Age ripples
    for (const r of this.ripples) r.age += dt;
    this.ripples = this.ripples.filter((r) => r.age < 1.6);
  }
}
