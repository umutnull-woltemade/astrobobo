/**
 * Vitest config for Astrobobo Web Pro.
 *
 * Tests only cover the pure engine modules — anything that reads from
 * the zustand store, the DOM, or next/image is out of scope and stays
 * behind the dev-only invariants. The goal is to lock the *behavior*
 * of the emotion scorer, the layout classifier, the tone bridge, and
 * the markdown parser so edits can't silently drift.
 */

import { defineConfig } from "vitest/config";
import path from "node:path";

export default defineConfig({
  test: {
    // Include only the focused test tree under `tests/pro`. This keeps
    // vitest away from app/ which would need a full React environment.
    include: ["tests/pro/**/*.test.ts"],
    environment: "node",
    globals: false,
    clearMocks: true,
    reporters: process.env.CI ? ["default"] : ["verbose"],
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "."),
      "@astrobobo/pro-tone": path.resolve(__dirname, "./packages/pro-tone"),
    },
  },
});
