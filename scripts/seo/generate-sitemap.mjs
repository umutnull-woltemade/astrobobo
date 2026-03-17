#!/usr/bin/env node

/**
 * Astrobobo Sitemap Generator
 *
 * Generates sitemap.xml from content files.
 * Also generates structured data JSON-LD snippets.
 *
 * Usage:
 *   node scripts/seo/generate-sitemap.mjs
 *   node scripts/seo/generate-sitemap.mjs --output public/sitemap.xml
 */

import { writeFile, mkdir } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || "https://astrobobo.com";
const args = process.argv.slice(2);
const outputIdx = args.indexOf("--output");
const outputPath = outputIdx !== -1 ? args[outputIdx + 1] : "public/sitemap.xml";

const ZODIAC_SIGNS = [
  "aries", "taurus", "gemini", "cancer", "leo", "virgo",
  "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces",
];

function generateSitemap() {
  const now = new Date().toISOString().split("T")[0];

  const pages = [
    { url: "/", freq: "weekly", priority: "1.0" },
    { url: "/zodiac", freq: "weekly", priority: "0.9" },
    { url: "/articles", freq: "daily", priority: "0.9" },
    { url: "/archetype", freq: "monthly", priority: "0.7" },
    { url: "/privacy", freq: "yearly", priority: "0.3" },
    { url: "/terms", freq: "yearly", priority: "0.3" },
    ...ZODIAC_SIGNS.map((s) => ({
      url: `/zodiac/${s}`,
      freq: "weekly",
      priority: "0.8",
    })),
  ];

  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
${pages
  .map(
    (p) => `  <url>
    <loc>${SITE_URL}${p.url}</loc>
    <lastmod>${now}</lastmod>
    <changefreq>${p.freq}</changefreq>
    <priority>${p.priority}</priority>
  </url>`
  )
  .join("\n")}
</urlset>`;
}

async function run() {
  console.log("=== ASTROBOBO SITEMAP GENERATOR ===\n");

  const sitemap = generateSitemap();
  const fullPath = join(ROOT, outputPath);

  await mkdir(dirname(fullPath), { recursive: true });
  await writeFile(fullPath, sitemap);

  console.log(`Sitemap generated: ${outputPath}`);
  console.log(`URL count: ${sitemap.split("<url>").length - 1}`);
  console.log(`Site URL: ${SITE_URL}`);
}

run().catch((err) => {
  console.error("Sitemap error:", err);
  process.exit(1);
});
