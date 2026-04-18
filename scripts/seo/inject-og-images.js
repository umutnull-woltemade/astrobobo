#!/usr/bin/env node
// ═══════════════════════════════════════════════════════════════════════════
// Inject dynamic og:image + twitter:image into every SEO article page.
//
// Each page gets a personalized OG image via /api/og?title=...
// Uses the page's existing og:title to build the API URL.
//
// Idempotent: skips files that already have og:image.
//
// Usage:  node scripts/inject-og-images.js
// ═══════════════════════════════════════════════════════════════════════════

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', 'web', 'r');
let injected = 0;
let skipped = 0;

const langs = fs.readdirSync(ROOT).filter(d =>
  fs.statSync(path.join(ROOT, d)).isDirectory()
);

for (const lang of langs) {
  const langDir = path.join(ROOT, lang);
  const files = fs.readdirSync(langDir).filter(f => f.endsWith('.html'));

  for (const file of files) {
    const filePath = path.join(langDir, file);
    let html = fs.readFileSync(filePath, 'utf-8');

    // Skip if og:image already exists
    if (html.includes('og:image')) {
      skipped++;
      continue;
    }

    // Extract og:title content
    const titleMatch = html.match(/og:title"\s+content="([^"]+)"/);
    const title = titleMatch ? titleMatch[1] : file.replace('.html', '');

    // Extract og:description for subtitle
    const descMatch = html.match(/og:description"\s+content="([^"]+)"/);
    const subtitle = descMatch ? descMatch[1].slice(0, 100) : '';

    const ogUrl = `https://astrobobo.com/api/og?title=${encodeURIComponent(title)}&subtitle=${encodeURIComponent(subtitle)}`;

    const ogTags = `  <meta property="og:image" content="${ogUrl}">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:image:alt" content="${title}">
  <meta name="twitter:image" content="${ogUrl}">`;

    // Inject after og:locale or og:site_name
    if (html.includes('og:locale')) {
      html = html.replace(
        /(<meta property="og:locale"[^>]*>)/,
        `$1\n${ogTags}`
      );
    } else if (html.includes('og:site_name')) {
      html = html.replace(
        /(<meta property="og:site_name"[^>]*>)/,
        `$1\n${ogTags}`
      );
    }

    html = html.replace("</head>", "  <!-- OG_IMAGE_INJECTED -->\n</head>");
    fs.writeFileSync(filePath, html);
    injected++;
  }
}

console.log(`✨ Injected og:image into ${injected} pages (${skipped} already had it)`);
