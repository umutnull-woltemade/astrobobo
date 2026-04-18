#!/usr/bin/env node

/**
 * Astrobobo Sitemap Generator
 * Generates sitemap.xml with ALL pages: tools, zodiac, articles, dreams, static.
 * Usage: node scripts/seo/generate-sitemap.mjs
 */

import { writeFile, readdir, mkdir } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "../..");
const SITE_URL = "https://astrobobo.com";

const LOCALES = ["en", "tr"];

const ZODIAC = [
  "aries", "taurus", "gemini", "cancer", "leo", "virgo",
  "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces",
];

const TOOLS = [
  "tarot", "numerology", "zodiac-compatibility", "moon-phase", "biorhythm",
  "birth-chart", "synastry", "transits", "solar-return", "daily-horoscope",
  "progressions", "chakra", "meditation", "chinese-zodiac", "aura",
  "vedic", "draconic", "composite", "retrogrades", "eclipses",
  "saturn-return", "lucky-numbers", "void-of-course", "element-balance", "crystal-guide",
  "rising-sign", "moon-sign-calculator",
  "planetary-hours", "aspect-patterns", "profection-year", "my-day",
  "sabian-symbols", "age-harmonic",
];

const DREAM_LANGS = ["en", "tr", "es", "de", "fr", "it", "pt", "ru", "ar"];

async function getDreamSlugs() {
  try {
    const dirs = await readdir(join(ROOT, "content/reflections"));
    return dirs.filter(d => !d.startsWith("."));
  } catch { return []; }
}

function url(loc, opts = {}) {
  const freq = opts.freq || "weekly";
  const pri = opts.priority || "0.7";
  return `  <url>
    <loc>${SITE_URL}${loc}</loc>
    <changefreq>${freq}</changefreq>
    <priority>${pri}</priority>
  </url>`;
}

async function run() {
  const dreamSlugs = await getDreamSlugs();
  const urls = [];

  // Static pages × locales
  const statics = [
    { path: "/", freq: "daily", priority: "1.0" },
    { path: "/zodiac", freq: "weekly", priority: "0.9" },
    { path: "/articles", freq: "daily", priority: "0.9" },
    { path: "/tools", freq: "weekly", priority: "0.95" },
    { path: "/privacy", freq: "yearly", priority: "0.3" },
    { path: "/terms", freq: "yearly", priority: "0.3" },
  ];

  for (const locale of LOCALES) {
    const pre = locale === "en" ? "" : `/${locale}`;
    for (const p of statics) {
      urls.push(url(`${pre}${p.path}`, { freq: p.freq, priority: p.priority }));
    }
    // Tools
    for (const t of TOOLS) {
      urls.push(url(`${pre}/tools/${t}`, { freq: "weekly", priority: "0.8" }));
    }
    // Zodiac
    for (const z of ZODIAC) {
      urls.push(url(`${pre}/zodiac/${z}`, { freq: "weekly", priority: "0.8" }));
    }
  }

  // Dream pages: /r/{lang}/{slug} and /r/{lang}
  for (const lang of DREAM_LANGS) {
    urls.push(url(`/r/${lang}`, { freq: "weekly", priority: "0.7" }));
    for (const slug of dreamSlugs) {
      urls.push(url(`/r/${lang}/${slug}`, { freq: "monthly", priority: "0.6" }));
    }
  }

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.join("\n")}
</urlset>`;

  const outPath = join(ROOT, "public/sitemap.xml");
  await mkdir(dirname(outPath), { recursive: true });
  await writeFile(outPath, xml);

  const count = urls.length;
  console.log(`Sitemap: ${count} URLs → public/sitemap.xml`);
}

run().catch((err) => { console.error(err); process.exit(1); });
