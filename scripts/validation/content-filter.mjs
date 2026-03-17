#!/usr/bin/env node

/**
 * Astrobobo Content Safety Filter - CLI Validator
 *
 * Scans all content files for banned phrases, dependency patterns,
 * and medical/financial claims.
 *
 * Usage:
 *   node scripts/validation/content-filter.mjs
 *   node scripts/validation/content-filter.mjs --fix
 *   node scripts/validation/content-filter.mjs --file content/zodiac/signs.ts
 */

import { readdir, readFile, writeFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");
const args = process.argv.slice(2);
const autoFix = args.includes("--fix");
const targetFile = args.find((a) => !a.startsWith("--"));

const BANNED_PHRASES = [
  "will happen", "will be", "you will", "going to", "destined", "fated",
  "guaranteed", "promise", "certain to", "definitely will", "forecast",
  "prediction", "predict", "fortune", "your future", "what awaits",
  "meant to be", "written in the stars", "cosmic plan for you",
  "the stars say", "the planets indicate", "your horoscope says",
  "you are destined", "the universe will", "fate has decided",
  "stars align for", "planetary forces will", "cosmic forces will",
  "you are meant to", "the cosmos demands",
];

const DEPENDENCY_PATTERNS = [
  "you need this", "without this", "don't miss", "you're falling behind",
  "act now", "limited time", "running out", "last chance", "only today",
  "before it's too late", "you can't afford to", "everyone else is",
  "you're missing out", "urgent",
];

const CLAIM_PATTERNS = [
  "cure", "heal your", "treat your", "diagnose", "medical advice",
  "financial advice", "invest in", "guaranteed return", "make money",
  "get rich", "weight loss", "clinical",
];

async function scanFile(filePath) {
  const content = await readFile(filePath, "utf-8");
  const lower = content.toLowerCase();
  const violations = [];

  for (const phrase of BANNED_PHRASES) {
    let idx = lower.indexOf(phrase);
    while (idx !== -1) {
      const line = content.slice(0, idx).split("\n").length;
      violations.push({ type: "PREDICTION", phrase, line, severity: "CRITICAL" });
      idx = lower.indexOf(phrase, idx + 1);
    }
  }

  for (const phrase of DEPENDENCY_PATTERNS) {
    let idx = lower.indexOf(phrase);
    while (idx !== -1) {
      const line = content.slice(0, idx).split("\n").length;
      violations.push({ type: "DEPENDENCY", phrase, line, severity: "CRITICAL" });
      idx = lower.indexOf(phrase, idx + 1);
    }
  }

  for (const phrase of CLAIM_PATTERNS) {
    let idx = lower.indexOf(phrase);
    while (idx !== -1) {
      const line = content.slice(0, idx).split("\n").length;
      violations.push({ type: "CLAIM", phrase, line, severity: "WARNING" });
      idx = lower.indexOf(phrase, idx + 1);
    }
  }

  return violations;
}

async function getContentFiles(dir) {
  const files = [];
  try {
    const entries = await readdir(dir, { withFileTypes: true, recursive: true });
    for (const entry of entries) {
      if (entry.isFile() && /\.(ts|tsx|md|mdx|json)$/.test(entry.name)) {
        files.push(join(entry.parentPath || dir, entry.name));
      }
    }
  } catch {
    // Directory may not exist yet
  }
  return files;
}

async function run() {
  console.log("=== ASTROBOBO CONTENT SAFETY FILTER ===\n");

  const dirs = ["content", "app"].map((d) => join(ROOT, d));
  let allFiles = [];

  if (targetFile) {
    allFiles = [join(ROOT, targetFile)];
  } else {
    for (const dir of dirs) {
      allFiles.push(...(await getContentFiles(dir)));
    }
  }

  console.log(`Scanning ${allFiles.length} file(s)...\n`);

  let totalViolations = 0;
  let criticalCount = 0;

  for (const file of allFiles) {
    const relPath = file.replace(ROOT + "/", "");
    const violations = await scanFile(file);

    if (violations.length > 0) {
      console.log(`\n  ${relPath}:`);
      for (const v of violations) {
        const icon = v.severity === "CRITICAL" ? "X" : "!";
        console.log(`    [${icon}] Line ${v.line}: ${v.type} — "${v.phrase}"`);
        totalViolations++;
        if (v.severity === "CRITICAL") criticalCount++;
      }
    }
  }

  console.log("\n=== RESULTS ===");
  console.log(`Files scanned: ${allFiles.length}`);
  console.log(`Total violations: ${totalViolations}`);
  console.log(`Critical: ${criticalCount}`);
  console.log(`Status: ${criticalCount === 0 ? "PASS" : "FAIL"}`);

  if (criticalCount > 0) {
    process.exit(1);
  }
}

run().catch((err) => {
  console.error("Filter error:", err);
  process.exit(1);
});
