#!/usr/bin/env node

/**
 * Astrobobo Duplicate Content Detector
 *
 * Calculates Jaccard similarity between all content pairs.
 * Threshold: 70% — any pair above this is flagged.
 */

import { readdir, readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");
const THRESHOLD = 0.7;

function tokenize(text) {
  return new Set(
    text
      .toLowerCase()
      .replace(/[^a-z0-9\s]/g, "")
      .split(/\s+/)
      .filter((w) => w.length > 3)
  );
}

function jaccardSimilarity(setA, setB) {
  const intersection = new Set([...setA].filter((x) => setB.has(x)));
  const union = new Set([...setA, ...setB]);
  return union.size === 0 ? 0 : intersection.size / union.size;
}

async function run() {
  console.log("=== ASTROBOBO DUPLICATE DETECTOR ===\n");
  console.log(`Threshold: ${(THRESHOLD * 100).toFixed(0)}% Jaccard similarity\n`);

  const contentDir = join(ROOT, "content");
  let files;
  try {
    const entries = await readdir(contentDir, { withFileTypes: true, recursive: true });
    files = entries
      .filter((e) => e.isFile() && /\.(ts|json)$/.test(e.name))
      .map((e) => join(e.parentPath || contentDir, e.name));
  } catch {
    console.log("No content directory found.");
    return;
  }

  console.log(`Comparing ${files.length} file(s)...\n`);

  const contentMap = [];
  for (const file of files) {
    const content = await readFile(file, "utf-8");
    contentMap.push({
      path: file.replace(ROOT + "/", ""),
      tokens: tokenize(content),
    });
  }

  let duplicateCount = 0;
  const checked = new Set();

  for (let i = 0; i < contentMap.length; i++) {
    for (let j = i + 1; j < contentMap.length; j++) {
      const key = `${i}-${j}`;
      if (checked.has(key)) continue;
      checked.add(key);

      const similarity = jaccardSimilarity(contentMap[i].tokens, contentMap[j].tokens);
      if (similarity >= THRESHOLD) {
        duplicateCount++;
        console.log(
          `  DUPLICATE (${(similarity * 100).toFixed(1)}%): ` +
            `${contentMap[i].path} <-> ${contentMap[j].path}`
        );
      }
    }
  }

  console.log("\n=== RESULTS ===");
  console.log(`Pairs checked: ${checked.size}`);
  console.log(`Duplicates found: ${duplicateCount}`);
  console.log(`Status: ${duplicateCount === 0 ? "PASS" : "FAIL"}`);

  if (duplicateCount > 0) {
    process.exit(1);
  }
}

run().catch((err) => {
  console.error("Duplicate detector error:", err);
  process.exit(1);
});
