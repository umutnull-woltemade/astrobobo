#!/usr/bin/env node
// ═══════════════════════════════════════════════════════════════════════════
// Inject "Related Articles" section into every SEO article page.
//
// Adds a "Diğer Rüya Tabirleri" / "More Dream Interpretations" section
// before the share buttons, linking each article to every other article
// in the same language. This creates a dense internal-link mesh that
// distributes PageRank across the entire article surface.
//
// Idempotent: if the marker comment already exists, the file is skipped.
//
// Usage:  node scripts/inject-related-articles.js
// ═══════════════════════════════════════════════════════════════════════════

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', 'web', 'r');
const MARKER = '<!-- RELATED_ARTICLES_INJECTED -->';

const TITLES = {
  tr: {
    section: 'Diğer Rüya Tabirleri',
    hub: 'Tüm Rüya Tabirleri →',
    'ruyada-araba': 'Rüyada Araba Görmek',
    'ruyada-bebek': 'Rüyada Bebek Görmek',
    'ruyada-bogulmak': 'Rüyada Boğulmak',
    'ruyada-dis-dokulmesi': 'Rüyada Diş Dökülmesi',
    'ruyada-dusmek': 'Rüyada Düşmek',
    'ruyada-eski-sevgili': 'Rüyada Eski Sevgili',
    'ruyada-ev': 'Rüyada Ev Görmek',
    'ruyada-kaybolmak': 'Rüyada Kaybolmak',
    'ruyada-kopek': 'Rüyada Köpek Görmek',
    'ruyada-kovalanmak': 'Rüyada Kovalanmak',
    'ruyada-olum': 'Rüyada Ölüm Görmek',
    'ruyada-para': 'Rüyada Para Görmek',
    'ruyada-su': 'Rüyada Su Görmek',
    'ruyada-ucmak': 'Rüyada Uçmak',
    'ruyada-yilan': 'Rüyada Yılan Görmek',
  },
  en: { section: 'More Dream Interpretations', hub: 'All Dream Interpretations →' },
  de: { section: 'Weitere Traumdeutungen', hub: 'Alle Traumdeutungen →' },
  es: { section: 'Más Interpretaciones de Sueños', hub: 'Todas las Interpretaciones →' },
  fr: { section: 'Plus d\'Interprétations de Rêves', hub: 'Toutes les Interprétations →' },
  it: { section: 'Altre Interpretazioni dei Sogni', hub: 'Tutte le Interpretazioni →' },
  'pt-br': { section: 'Mais Interpretações de Sonhos', hub: 'Todas as Interpretações →' },
  ru: { section: 'Другие Толкования Снов', hub: 'Все Толкования →' },
  ar: { section: 'تفسيرات أحلام أخرى', hub: 'كل التفسيرات ←' },
};

function slugTitle(lang, slug) {
  if (TITLES[lang]?.[slug]) return TITLES[lang][slug];
  if (TITLES.tr[slug]) return TITLES.tr[slug]; // fallback to TR
  return slug.replace(/^ruyada-/, '').replace(/-/g, ' ');
}

let injected = 0;
let skipped = 0;

const langs = fs.readdirSync(ROOT).filter(d => {
  const full = path.join(ROOT, d);
  return fs.statSync(full).isDirectory();
});

for (const lang of langs) {
  const langDir = path.join(ROOT, lang);
  const files = fs.readdirSync(langDir).filter(f =>
    f.endsWith('.html') && f !== 'index.html' && !f.startsWith('cluster-') && f !== 'about.html'
  );

  for (const file of files) {
    const filePath = path.join(langDir, file);
    let html = fs.readFileSync(filePath, 'utf-8');

    // Skip if already injected
    if (html.includes(MARKER)) {
      skipped++;
      continue;
    }

    const currentSlug = file.replace('.html', '');
    const others = files
      .map(f => f.replace('.html', ''))
      .filter(s => s !== currentSlug)
      .slice(0, 8); // max 8 related links

    const sectionTitle = TITLES[lang]?.section || TITLES.en.section;
    const hubText = TITLES[lang]?.hub || TITLES.en.hub;
    const baseUrl = `https://astrobobo.com/r/${lang}`;

    const relatedHtml = `
    ${MARKER}
    <section class="related" style="margin-top:48px;padding-top:32px;border-top:1px solid rgba(255,255,255,0.08)">
      <h2 style="font-size:22px;font-weight:600;margin:0 0 20px;color:#a78bfa">${sectionTitle}</h2>
      <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:10px">
        ${others.map(s =>
          `<a href="${baseUrl}/${s}" style="display:block;padding:14px 18px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:12px;color:#f5f0e6;text-decoration:none;font-size:14px;transition:all .2s">${slugTitle(lang, s)}</a>`
        ).join('\n        ')}
      </div>
      <div style="margin-top:16px;text-align:center">
        <a href="${baseUrl}/cluster-ruya" style="color:#a78bfa;text-decoration:none;font-size:15px;font-weight:500">${hubText}</a>
      </div>
    </section>`;

    // Inject before the share div
    if (html.includes('<div class="share">')) {
      html = html.replace('<div class="share">', relatedHtml + '\n\n    <div class="share">');
    } else if (html.includes('</main>')) {
      html = html.replace('</main>', relatedHtml + '\n    </main>');
    }

    fs.writeFileSync(filePath, html);
    injected++;
  }
}

console.log(`✨ Injected related-articles into ${injected} pages (${skipped} skipped, already had it)`);
