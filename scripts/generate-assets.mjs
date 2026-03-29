import sharp from "sharp";
import { mkdirSync, writeFileSync } from "fs";
import { join } from "path";

const PUBLIC = join(import.meta.dirname, "..", "public");

const COSMIC_BG = "#0D0D1A";
const COSMIC_SURFACE = "#1A1A2E";
const COSMIC_ACCENT = "#FFD700";
const COSMIC_PURPLE = "#7B2FBE";

const SIGNS = [
  { slug: "aries", symbol: "♈", name: "Aries", color: "#FF6B35" },
  { slug: "taurus", symbol: "♉", name: "Taurus", color: "#4A7C59" },
  { slug: "gemini", symbol: "♊", name: "Gemini", color: "#87CEEB" },
  { slug: "cancer", symbol: "♋", name: "Cancer", color: "#4169E1" },
  { slug: "leo", symbol: "♌", name: "Leo", color: "#FF6B35" },
  { slug: "virgo", symbol: "♍", name: "Virgo", color: "#4A7C59" },
  { slug: "libra", symbol: "♎", name: "Libra", color: "#87CEEB" },
  { slug: "scorpio", symbol: "♏", name: "Scorpio", color: "#4169E1" },
  { slug: "sagittarius", symbol: "♐", name: "Sagittarius", color: "#FF6B35" },
  { slug: "capricorn", symbol: "♑", name: "Capricorn", color: "#4A7C59" },
  { slug: "aquarius", symbol: "♒", name: "Aquarius", color: "#87CEEB" },
  { slug: "pisces", symbol: "♓", name: "Pisces", color: "#4169E1" },
];

function ogSvg(title, subtitle, symbol, accentColor) {
  return `<svg width="1200" height="630" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${COSMIC_BG}"/>
      <stop offset="100%" style="stop-color:${COSMIC_SURFACE}"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="630" fill="url(#bg)"/>
  <circle cx="900" cy="315" r="200" fill="${COSMIC_PURPLE}" opacity="0.08"/>
  <circle cx="900" cy="315" r="140" fill="none" stroke="${COSMIC_PURPLE}" stroke-width="2" opacity="0.2"/>
  <circle cx="900" cy="315" r="200" fill="none" stroke="${COSMIC_PURPLE}" stroke-width="1.5" opacity="0.12"/>
  ${symbol ? `<text x="900" y="360" font-size="180" text-anchor="middle" fill="${accentColor}" opacity="0.9">${symbol}</text>` : ""}
  <text x="80" y="260" font-family="Georgia, serif" font-size="64" font-weight="bold" fill="${COSMIC_ACCENT}">${escapeXml(title)}</text>
  <text x="80" y="330" font-family="Inter, Arial, sans-serif" font-size="28" fill="#A0A0B0">${escapeXml(subtitle)}</text>
  <text x="80" y="540" font-family="Georgia, serif" font-size="32" font-weight="bold" fill="${COSMIC_ACCENT}" opacity="0.8">Astrobobo</text>
  <line x1="80" y1="560" x2="300" y2="560" stroke="${accentColor}" stroke-width="2" opacity="0.5"/>
  <circle cx="150" cy="100" r="3" fill="${COSMIC_ACCENT}" opacity="0.3"/>
  <circle cx="500" cy="80" r="2" fill="#FFE066" opacity="0.25"/>
  <circle cx="700" cy="120" r="4" fill="${COSMIC_ACCENT}" opacity="0.2"/>
  <circle cx="1050" cy="80" r="3" fill="#FFE066" opacity="0.3"/>
  <circle cx="350" cy="550" r="2" fill="${COSMIC_ACCENT}" opacity="0.2"/>
</svg>`;
}

function iconSvg(size) {
  return `<svg width="${size}" height="${size}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${COSMIC_BG}"/>
      <stop offset="100%" style="stop-color:${COSMIC_SURFACE}"/>
    </linearGradient>
  </defs>
  <rect width="${size}" height="${size}" rx="${Math.round(size * 0.18)}" fill="url(#bg)"/>
  <circle cx="${size / 2}" cy="${size / 2}" r="${size * 0.27}" fill="none" stroke="${COSMIC_PURPLE}" stroke-width="${Math.max(2, size * 0.012)}" opacity="0.4"/>
  <text x="${size / 2}" y="${size * 0.6}" font-family="Georgia, serif" font-size="${size * 0.4}" font-weight="bold" fill="${COSMIC_ACCENT}" text-anchor="middle">A</text>
</svg>`;
}

function escapeXml(s) {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

async function main() {
  // Ensure directories
  for (const dir of ["images/icons", "images/og", "images/zodiac"]) {
    mkdirSync(join(PUBLIC, dir), { recursive: true });
  }

  // 1. Generate icon PNGs
  console.log("Generating icons...");
  for (const size of [180, 192, 512]) {
    const svg = iconSvg(size);
    const name = size === 180 ? "apple-touch-icon.png" : `icon-${size}.png`;
    await sharp(Buffer.from(svg)).png().toFile(join(PUBLIC, "images/icons", name));
    console.log(`  ✓ ${name}`);
  }

  // 2. Generate favicon.ico (32x32 PNG, renamed to .ico - browsers accept PNG favicons)
  const faviconSvg = iconSvg(32);
  await sharp(Buffer.from(faviconSvg)).png().toFile(join(PUBLIC, "favicon.ico"));
  console.log("  ✓ favicon.ico");

  // 3. Generate default OG image
  console.log("Generating OG images...");
  const defaultOg = ogSvg("Astrobobo", "Reflective Astrology — Cosmic Self-Discovery", "✦", COSMIC_ACCENT);
  await sharp(Buffer.from(defaultOg)).png({ quality: 90 }).toFile(join(PUBLIC, "images/og/og-default.png"));
  console.log("  ✓ og-default.png");

  // 4. Generate zodiac OG images
  console.log("Generating zodiac OG images...");
  for (const sign of SIGNS) {
    const svg = ogSvg(sign.name, `Zodiac Profile — Personality, Strengths & Insights`, sign.symbol, sign.color);
    await sharp(Buffer.from(svg)).png({ quality: 90 }).toFile(join(PUBLIC, `images/zodiac/${sign.slug}-og.png`));
    console.log(`  ✓ ${sign.slug}-og.png`);
  }

  console.log("\nAll assets generated!");
}

main().catch(console.error);
