#!/usr/bin/env node
// ═══════════════════════════════════════════════════════════════════════════
// Inject "Try the App" CTA banner into SEO article pages.
//
// Adds a styled banner above the footer linking to the Flutter web app
// with relevant deep links (e.g. /dreams for dream articles).
//
// Idempotent: skips files with APP_CTA_INJECTED marker.
// ═══════════════════════════════════════════════════════════════════════════

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', 'web', 'r');
const MARKER = '<!-- APP_CTA_INJECTED -->';

const CTA = {
  tr: {
    heading: '80+ Kozmik Araç ile Keşfet',
    body: 'Doğum haritası, günlük burç yorumu, tarot, numeroloji, rüya tabiri ve daha fazlası — hepsi ücretsiz.',
    btn: 'Venus One\'ı Dene',
    sub: 'Kayıt gerektirmez · Ücretsiz',
  },
  en: {
    heading: 'Explore with 80+ Cosmic Tools',
    body: 'Birth chart, daily horoscope, tarot, numerology, dream interpretation and more — all free.',
    btn: 'Try Venus One',
    sub: 'No sign-up required · Free',
  },
  de: {
    heading: 'Entdecke 80+ Kosmische Werkzeuge',
    body: 'Geburtshoroskop, Tageshoroskop, Tarot, Numerologie, Traumdeutung und mehr — kostenlos.',
    btn: 'Venus One Testen',
    sub: 'Keine Anmeldung · Kostenlos',
  },
  es: {
    heading: 'Explora con 80+ Herramientas Cósmicas',
    body: 'Carta natal, horóscopo diario, tarot, numerología, interpretación de sueños y más — todo gratis.',
    btn: 'Probar Venus One',
    sub: 'Sin registro · Gratis',
  },
  fr: {
    heading: 'Explorez avec 80+ Outils Cosmiques',
    body: 'Carte du ciel, horoscope quotidien, tarot, numérologie, interprétation des rêves et plus — gratuit.',
    btn: 'Essayer Venus One',
    sub: 'Sans inscription · Gratuit',
  },
  it: {
    heading: 'Esplora con 80+ Strumenti Cosmici',
    body: 'Carta natale, oroscopo giornaliero, tarocchi, numerologia, interpretazione dei sogni e altro — gratis.',
    btn: 'Prova Venus One',
    sub: 'Senza registrazione · Gratis',
  },
  'pt-br': {
    heading: 'Explore com 80+ Ferramentas Cósmicas',
    body: 'Mapa astral, horóscopo diário, tarô, numerologia, interpretação de sonhos e mais — tudo grátis.',
    btn: 'Experimentar Venus One',
    sub: 'Sem cadastro · Grátis',
  },
  ru: {
    heading: 'Исследуйте 80+ Космических Инструментов',
    body: 'Натальная карта, ежедневный гороскоп, таро, нумерология, толкование снов и более — бесплатно.',
    btn: 'Попробовать Venus One',
    sub: 'Без регистрации · Бесплатно',
  },
  ar: {
    heading: 'اكتشف أكثر من 80 أداة كونية',
    body: 'خريطة الميلاد، الأبراج اليومية، التاروت، علم الأعداد، تفسير الأحلام والمزيد — مجاناً.',
    btn: 'جرب Venus One',
    sub: 'بدون تسجيل · مجاني',
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

  const c = CTA[lang] || CTA.en;

  for (const file of files) {
    const filePath = path.join(langDir, file);
    let html = fs.readFileSync(filePath, 'utf-8');

    if (html.includes(MARKER)) {
      skipped++;
      continue;
    }

    const ctaHtml = `
    ${MARKER}
    <section style="margin:48px 0;padding:32px;background:linear-gradient(135deg,rgba(102,126,234,0.12),rgba(118,75,162,0.12));border:1px solid rgba(102,126,234,0.25);border-radius:20px;text-align:center">
      <div style="font-size:28px;margin-bottom:8px">✨</div>
      <h2 style="font-size:22px;font-weight:700;margin:0 0 12px;color:#c4a7ff">${c.heading}</h2>
      <p style="font-size:15px;color:#c8c2d6;margin:0 0 24px;max-width:480px;display:inline-block">${c.body}</p>
      <div>
        <a href="https://astrobobo.com/dreams" style="display:inline-block;padding:16px 40px;background:linear-gradient(135deg,#667EEA,#764BA2);color:white;text-decoration:none;border-radius:30px;font-size:16px;font-weight:600;letter-spacing:1px;transition:all .2s;box-shadow:0 8px 24px rgba(102,126,234,0.35)">${c.btn}</a>
      </div>
      <p style="font-size:12px;color:#9b94aa;margin:12px 0 0">${c.sub}</p>
    </section>`;

    // Inject before footer
    if (html.includes('<footer>')) {
      html = html.replace('<footer>', ctaHtml + '\n\n    <footer>');
    }

    fs.writeFileSync(filePath, html);
    injected++;
  }
}

console.log(`✨ Injected app CTA into ${injected} pages (${skipped} skipped)`);
