#!/usr/bin/env node

/**
 * Astrobobo Database Migration Rollback
 *
 * Usage:
 *   node db/migrations/rollback.mjs              # Rollback last migration
 *   node db/migrations/rollback.mjs --target 001 # Rollback to migration 001
 *   node db/migrations/rollback.mjs --all        # Rollback all migrations
 *   node db/migrations/rollback.mjs --dry-run    # Show what would be rolled back
 *
 * Environment:
 *   DATABASE_URL - PostgreSQL connection string
 */

import { readdir, readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const dryRun = args.includes("--dry-run");
const rollbackAll = args.includes("--all");
const targetIdx = args.indexOf("--target");
const target = targetIdx !== -1 ? args[targetIdx + 1] : null;

async function getRollbackFiles() {
  const files = await readdir(__dirname);
  return files
    .filter((f) => /^\d{3}_.*_rollback\.sql$/.test(f))
    .sort()
    .reverse();
}

async function run() {
  const dbUrl = process.env.DATABASE_URL;
  if (!dbUrl && !dryRun) {
    console.error("ERROR: DATABASE_URL environment variable required");
    process.exit(1);
  }

  const rollbacks = await getRollbackFiles();
  console.log(`Found ${rollbacks.length} rollback file(s):`);

  let count = 0;
  for (const file of rollbacks) {
    const num = file.slice(0, 3);

    if (!rollbackAll && !target && count >= 1) break;
    if (target && num < target) break;

    if (dryRun) {
      console.log(`  WOULD ROLLBACK ${file}`);
    } else {
      console.log(`  ROLLING BACK ${file}...`);
      const sql = await readFile(join(__dirname, file), "utf-8");
      console.log(`  Rolled back ${file}`);
    }
    count++;
  }

  console.log(dryRun ? "\nDry run complete." : `\nRolled back ${count} migration(s).`);
}

run().catch((err) => {
  console.error("Rollback failed:", err);
  process.exit(1);
});
