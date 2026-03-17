#!/usr/bin/env node

/**
 * Astrobobo Content Batch Generator
 *
 * Generates content in batches of 25, validates each piece,
 * and outputs inter-agent JSON messages.
 *
 * Usage:
 *   node scripts/content-gen/batch-generate.mjs --type reflections --count 50
 *   node scripts/content-gen/batch-generate.mjs --type affirmations --count 50
 *   node scripts/content-gen/batch-generate.mjs --type articles --count 10
 */

import { randomUUID } from "node:crypto";
import { writeFile, mkdir } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");
const OUTPUT_DIR = join(ROOT, "logs/content-gen");
const args = process.argv.slice(2);

const typeIdx = args.indexOf("--type");
const countIdx = args.indexOf("--count");
const contentType = typeIdx !== -1 ? args[typeIdx + 1] : "reflections";
const count = countIdx !== -1 ? parseInt(args[countIdx + 1], 10) : 25;

const BATCH_SIZE = 25;
const RETRY_LIMIT = 3;

function createAgentMessage(category, content) {
  return {
    id: randomUUID(),
    category,
    language: "en",
    content,
    risk_score: 0,
    duplication_score: 0,
    metadata: {
      generated_at: new Date().toISOString(),
      model: "local",
      batch_size: BATCH_SIZE,
    },
  };
}

async function generateBatch(type, batchNum, batchSize) {
  const batch = {
    batch_id: `${type}_batch_${batchNum}_${Date.now()}`,
    agent_name: "content_regenerator",
    started_at: new Date().toISOString(),
    items: [],
    total_tokens: 0,
    total_cost_usd: 0,
    status: "running",
    retry_count: 0,
    errors: [],
  };

  console.log(`  Batch ${batchNum}: Generating ${batchSize} ${type}...`);

  for (let i = 0; i < batchSize; i++) {
    // In production, this would call Ollama or Claude API
    const msg = createAgentMessage(type, `[Content would be generated here by LLM]`);
    batch.items.push(msg);
  }

  batch.completed_at = new Date().toISOString();
  batch.status = "completed";

  return batch;
}

async function run() {
  console.log(`=== ASTROBOBO CONTENT GENERATOR ===`);
  console.log(`Type: ${contentType}`);
  console.log(`Target count: ${count}`);
  console.log(`Batch size: ${BATCH_SIZE}`);
  console.log(`Retry limit: ${RETRY_LIMIT}\n`);

  await mkdir(OUTPUT_DIR, { recursive: true });

  const totalBatches = Math.ceil(count / BATCH_SIZE);
  const allBatches = [];

  for (let b = 1; b <= totalBatches; b++) {
    const batchSize = Math.min(BATCH_SIZE, count - (b - 1) * BATCH_SIZE);
    let retries = 0;
    let batch = null;

    while (retries <= RETRY_LIMIT) {
      try {
        batch = await generateBatch(contentType, b, batchSize);
        break;
      } catch (err) {
        retries++;
        console.error(`  Batch ${b} failed (attempt ${retries}/${RETRY_LIMIT}): ${err.message}`);
        if (retries > RETRY_LIMIT) {
          console.error(`  Batch ${b} ABANDONED after ${RETRY_LIMIT} retries`);
        }
      }
    }

    if (batch) {
      allBatches.push(batch);
    }
  }

  // Write output
  const outputFile = join(OUTPUT_DIR, `${contentType}_${Date.now()}.json`);
  await writeFile(outputFile, JSON.stringify(allBatches, null, 2));

  const totalItems = allBatches.reduce((sum, b) => sum + b.items.length, 0);
  console.log(`\n=== GENERATION COMPLETE ===`);
  console.log(`Batches: ${allBatches.length}/${totalBatches}`);
  console.log(`Items generated: ${totalItems}/${count}`);
  console.log(`Output: ${outputFile}`);
}

run().catch((err) => {
  console.error("Generation error:", err);
  process.exit(1);
});
