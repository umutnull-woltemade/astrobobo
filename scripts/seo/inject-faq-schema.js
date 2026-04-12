#!/usr/bin/env node
// ═══════════════════════════════════════════════════════════════════════════
// Inject FAQPage schema into SEO article pages for Google "People Also Ask"
//
// Each article gets 3 FAQ entries extracted from its content + generic
// dream interpretation questions. Injected as a second JSON-LD script tag.
//
// Idempotent: skips files with FAQ_SCHEMA_INJECTED marker.
// ═══════════════════════════════════════════════════════════════════════════

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', '..', 'public', 'r');
const MARKER = '<!-- FAQ_SCHEMA_INJECTED -->';

// FAQ templates per language (topic placeholder: {TOPIC})
const FAQ_TEMPLATES = {
  tr: [
    { q: '{TOPIC} ne anlama gelir?', a: '{TOPIC}, bilinçaltınızın size gönderdiği sembolik bir mesajdır. Rüya bağlamına ve kişisel yaşam durumunuza göre yorumlanmalıdır.' },
    { q: '{TOPIC} iyi mi kötü mü?', a: 'Tek başına iyi veya kötü olarak yorumlanamaz. Rüyanın duygusu, detayları ve kişisel bağlamınız yorumun yönünü belirler.' },
    { q: '{TOPIC} sıkça görülür mü?', a: 'Evet, en yaygın rüya sembollerinden biridir. Birçok kültürde benzer sembolik anlamlar taşır ve genellikle yaşam değişimleriyle bağlantılıdır.' },
  ],
  en: [
    { q: 'What does {TOPIC} mean?', a: '{TOPIC} is a symbolic message from your subconscious. Its meaning depends on the dream context and your personal life circumstances.' },
    { q: 'Is {TOPIC} a good or bad sign?', a: 'It cannot be interpreted as simply good or bad. The emotion of the dream, its details, and your personal context determine the interpretation.' },
    { q: 'Is {TOPIC} a common dream?', a: 'Yes, it is one of the most common dream symbols. It carries similar symbolic meanings across cultures and is often linked to life transitions.' },
  ],
};

const TOPIC_NAMES = {
  tr: {
    'ruyada-araba': 'rüyada araba görmek',
    'ruyada-bebek': 'rüyada bebek görmek',
    'ruyada-bogulmak': 'rüyada boğulmak',
    'ruyada-dis-dokulmesi': 'rüyada diş dökülmesi',
    'ruyada-dusmek': 'rüyada düşmek',
    'ruyada-eski-sevgili': 'rüyada eski sevgili görmek',
    'ruyada-ev': 'rüyada ev görmek',
    'ruyada-kaybolmak': 'rüyada kaybolmak',
    'ruyada-kopek': 'rüyada köpek görmek',
    'ruyada-kovalanmak': 'rüyada kovalanmak',
    'ruyada-olum': 'rüyada ölüm görmek',
    'ruyada-para': 'rüyada para görmek',
    'ruyada-su': 'rüyada su görmek',
    'ruyada-ucmak': 'rüyada uçmak',
    'ruyada-yilan': 'rüyada yılan görmek',
  },
  en: {
    'ruyada-araba': 'dreaming of a car',
    'ruyada-bebek': 'dreaming of a baby',
    'ruyada-bogulmak': 'dreaming of drowning',
    'ruyada-dis-dokulmesi': 'dreaming of teeth falling out',
    'ruyada-dusmek': 'dreaming of falling',
    'ruyada-eski-sevgili': 'dreaming of an ex',
    'ruyada-ev': 'dreaming of a house',
    'ruyada-kaybolmak': 'dreaming of being lost',
    'ruyada-kopek': 'dreaming of a dog',
    'ruyada-kovalanmak': 'dreaming of being chased',
    'ruyada-olum': 'dreaming of death',
    'ruyada-para': 'dreaming of money',
    'ruyada-su': 'dreaming of water',
    'ruyada-ucmak': 'dreaming of flying',
    'ruyada-yilan': 'dreaming of a snake',
  },
};

let injected = 0;
let skipped = 0;

const langs = fs.readdirSync(ROOT).filter(d =>
  fs.statSync(path.join(ROOT, d)).isDirectory()
);

for (const lang of langs) {
  const langDir = path.join(ROOT, lang);
  const files = fs.readdirSync(langDir).filter(f =>
    f.endsWith('.html') && f !== 'index.html' && !f.startsWith('cluster-') && f !== 'about.html'
  );

  const templates = FAQ_TEMPLATES[lang] || FAQ_TEMPLATES.en;
  const topicNames = TOPIC_NAMES[lang] || TOPIC_NAMES.en;

  for (const file of files) {
    const filePath = path.join(langDir, file);
    let html = fs.readFileSync(filePath, 'utf-8');

    if (html.includes(MARKER)) {
      skipped++;
      continue;
    }

    const slug = file.replace('.html', '');
    const topic = topicNames[slug] || slug.replace(/-/g, ' ');

    const faqItems = templates.map(t => ({
      '@type': 'Question',
      name: t.q.replace(/{TOPIC}/g, topic),
      acceptedAnswer: {
        '@type': 'Answer',
        text: t.a.replace(/{TOPIC}/g, topic),
      },
    }));

    const faqSchema = {
      '@context': 'https://schema.org',
      '@type': 'FAQPage',
      mainEntity: faqItems,
    };

    const scriptTag = `${MARKER}\n  <script type="application/ld+json">${JSON.stringify(faqSchema)}</script>`;

    // Inject before </head>
    if (html.includes('</head>')) {
      html = html.replace('</head>', `  ${scriptTag}\n</head>`);
    }

    fs.writeFileSync(filePath, html);
    injected++;
  }
}

console.log(`✨ Injected FAQ schema into ${injected} pages (${skipped} skipped)`);
