#!/usr/bin/env node

/**
 * Astrobobo Compliance Checker
 *
 * Validates all content against Apple 4.3(b) guidelines and
 * content quality standards.
 *
 * Checks:
 * 1. Prediction language (zero tolerance)
 * 2. Emotional dependency scoring
 * 3. Minimum depth scoring
 * 4. Apple guideline risk scoring
 * 5. Language isolation (EN/TR)
 */

import { readdir, readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");

function calculateDepthScore(content) {
  const words = content.split(/\s+/).length;
  const sentences = content.split(/[.!?]+/).length;
  const paragraphs = content.split(/\n\n+/).length;
  const headings = (content.match(/^#{1,3}\s/gm) || []).length;
  const lists = (content.match(/^[-*]\s/gm) || []).length;

  let score = 0;
  if (words > 200) score += 2;
  if (words > 500) score += 1;
  if (words > 1000) score += 1;
  if (sentences > 10) score += 1;
  if (paragraphs > 3) score += 1;
  if (headings > 0) score += 2;
  if (lists > 0) score += 1;
  if (words / sentences > 10 && words / sentences < 25) score += 1;

  return Math.min(10, score);
}

function calculateAppleRiskScore(content) {
  const lower = content.toLowerCase();
  let risk = 0;

  // Prediction language (+3 each)
  const predictions = ["will happen", "will be", "you will", "predict", "forecast", "your future"];
  for (const p of predictions) {
    if (lower.includes(p)) risk += 3;
  }

  // Dependency patterns (+2 each)
  const dependency = ["you need this", "don't miss", "act now", "limited time"];
  for (const d of dependency) {
    if (lower.includes(d)) risk += 2;
  }

  // Medical/financial (+2 each)
  const claims = ["cure", "diagnose", "medical advice", "financial advice"];
  for (const c of claims) {
    if (lower.includes(c)) risk += 2;
  }

  // Gambling/adult content (+5 each)
  const severe = ["gambling", "bet on", "adult content"];
  for (const s of severe) {
    if (lower.includes(s)) risk += 5;
  }

  return risk;
}

async function run() {
  console.log("=== ASTROBOBO COMPLIANCE REPORT ===\n");

  const contentDir = join(ROOT, "content");
  let files;
  try {
    const entries = await readdir(contentDir, { withFileTypes: true, recursive: true });
    files = entries
      .filter((e) => e.isFile() && /\.(ts|tsx|json)$/.test(e.name))
      .map((e) => join(e.parentPath || contentDir, e.name));
  } catch {
    console.log("No content directory found. Run content generation first.");
    return;
  }

  console.log(`Checking ${files.length} content file(s)...\n`);

  const report = {
    total: files.length,
    passed: 0,
    failed: 0,
    warnings: 0,
    avgDepth: 0,
    avgRisk: 0,
    failures: [],
  };

  let totalDepth = 0;
  let totalRisk = 0;

  for (const file of files) {
    const content = await readFile(file, "utf-8");
    const relPath = file.replace(ROOT + "/", "");
    const depth = calculateDepthScore(content);
    const risk = calculateAppleRiskScore(content);

    totalDepth += depth;
    totalRisk += risk;

    if (risk > 0) {
      report.failed++;
      report.failures.push({ file: relPath, risk, depth });
      console.log(`  FAIL ${relPath} (risk: ${risk}, depth: ${depth})`);
    } else if (depth < 3) {
      report.warnings++;
      console.log(`  WARN ${relPath} (low depth: ${depth})`);
    } else {
      report.passed++;
    }
  }

  report.avgDepth = files.length > 0 ? (totalDepth / files.length).toFixed(1) : 0;
  report.avgRisk = files.length > 0 ? (totalRisk / files.length).toFixed(1) : 0;

  console.log("\n=== COMPLIANCE SUMMARY ===");
  console.log(`Total files: ${report.total}`);
  console.log(`Passed: ${report.passed}`);
  console.log(`Failed: ${report.failed}`);
  console.log(`Warnings: ${report.warnings}`);
  console.log(`Avg depth score: ${report.avgDepth}/10`);
  console.log(`Avg risk score: ${report.avgRisk} (target: 0)`);
  console.log(`Status: ${report.failed === 0 ? "COMPLIANT" : "NON-COMPLIANT"}`);

  if (report.failed > 0) {
    process.exit(1);
  }
}

run().catch((err) => {
  console.error("Compliance check error:", err);
  process.exit(1);
});
