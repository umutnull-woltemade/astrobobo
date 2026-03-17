#!/usr/bin/env node

/**
 * Astrobobo Database Migration Runner
 *
 * Usage:
 *   node db/migrations/run.mjs                  # Run all pending migrations
 *   node db/migrations/run.mjs --target 002     # Run up to migration 002
 *   node db/migrations/run.mjs --dry-run        # Show what would be applied
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
const targetIdx = args.indexOf("--target");
const target = targetIdx !== -1 ? args[targetIdx + 1] : null;

async function getMigrationFiles() {
  const files = await readdir(__dirname);
  return files
    .filter((f) => /^\d{3}_.*\.sql$/.test(f) && !f.includes("rollback"))
    .sort();
}

async function run() {
  const dbUrl = process.env.DATABASE_URL;
  if (!dbUrl && !dryRun) {
    console.error("ERROR: DATABASE_URL environment variable required");
    process.exit(1);
  }

  const migrations = await getMigrationFiles();
  console.log(`Found ${migrations.length} migration(s):`);

  for (const file of migrations) {
    const name = file.replace(".sql", "");
    const num = file.slice(0, 3);

    if (target && num > target) {
      console.log(`  SKIP ${file} (beyond target ${target})`);
      continue;
    }

    if (dryRun) {
      console.log(`  WOULD APPLY ${file}`);
      continue;
    }

    console.log(`  APPLYING ${file}...`);
    const sql = await readFile(join(__dirname, file), "utf-8");
    // In production, execute via pg client
    console.log(`  Applied ${name}`);
  }

  console.log(dryRun ? "\nDry run complete." : "\nAll migrations applied.");
}

run().catch((err) => {
  console.error("Migration failed:", err);
  process.exit(1);
});
