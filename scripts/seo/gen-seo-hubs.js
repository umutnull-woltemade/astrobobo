#!/usr/bin/env node
// ═══════════════════════════════════════════════════════════════════════════
// SEO Hub Page Generator
//
// Creates the missing hub pages that the SEO machine commit referenced in
// breadcrumbs but never generated:
//   /r/{lang}/index.html       → language hub (lists every article in that lang)
//   /r/{lang}/cluster-ruya.html → "ruya" cluster hub (lists every dream article)
//
// Without these, the breadcrumb links from each landing page (e.g.
//   /r/tr/cluster-ruya, /r/tr) hit a 404 and Google sees broken internal
// linking, killing the page rank distribution across the 137 article pages.
//
// Usage:  node scripts/gen-seo-hubs.js
// ═══════════════════════════════════════════════════════════════════════════

const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', 'web', 'r');
const LANGS = ['tr', 'en', 'de', 'es', 'fr', 'it', 'pt-br', 'ru', 'ar'];

// Display copy per language
const COPY = {
  tr: {
    hub_title: 'Astrobobo Rüya Tabiri Sözlüğü — Tüm Makaleler',
    hub_desc: 'Astrobobo rüya tabiri sözlüğündeki tüm makaleler. Rüyada gördüklerinin sembolik anlamını keşfet.',
    cluster_title: 'Rüya Tabiri — Hayalini Kurduğun Sembollerin Anlamı',
    cluster_desc: 'Rüya tabiri sözlüğümüzdeki tüm makaleler. Rüyada gördüklerinin gizli anlamlarını derinlemesine açıklayan içerikler.',
    h1_hub: 'Astrobobo Rüya Tabiri Sözlüğü',
    h1_cluster: 'Rüya Tabiri Makaleleri',
    intro: 'Aşağıdaki rehberler, rüya sembollerinin psikolojik, kültürel ve sembolik anlamlarını derinlemesine inceler. Her makale Swiss Ephemeris hassasiyetinde astrolojik bağlamla zenginleştirilmiştir.',
    nav_back: '← Astrobobo ana sayfasına dön',
  },
  en: {
    hub_title: 'Astrobobo Dream Dictionary — All Articles',
    hub_desc: 'Every article in the Astrobobo dream-symbol dictionary. Decode what you saw last night.',
    cluster_title: 'Dream Interpretation — What Your Symbols Really Mean',
    cluster_desc: 'Every long-form dream-interpretation article on Astrobobo. Definition-first guides to what each dream symbol means.',
    h1_hub: 'Astrobobo Dream Dictionary',
    h1_cluster: 'Dream Interpretation Articles',
    intro: 'These guides go deep on the psychological, cultural and symbolic meanings of recurring dream symbols. Every article is grounded in astrological context with Swiss Ephemeris precision.',
    nav_back: '← Back to Astrobobo home',
  },
  de: {
    hub_title: 'Astrobobo Traumlexikon — Alle Artikel',
    hub_desc: 'Alle Artikel im Astrobobo Traumlexikon. Entdecke die symbolische Bedeutung deiner Träume.',
    cluster_title: 'Traumdeutung — Was deine Traumsymbole wirklich bedeuten',
    cluster_desc: 'Jeder ausführliche Traumdeutungsartikel auf Astrobobo. Definition-zuerst Anleitungen zu Traumsymbolen.',
    h1_hub: 'Astrobobo Traumlexikon',
    h1_cluster: 'Traumdeutungs-Artikel',
    intro: 'Diese Anleitungen vertiefen die psychologische, kulturelle und symbolische Bedeutung wiederkehrender Traumsymbole.',
    nav_back: '← Zurück zur Astrobobo-Startseite',
  },
  es: {
    hub_title: 'Diccionario de Sueños Astrobobo — Todos los Artículos',
    hub_desc: 'Todos los artículos del diccionario de sueños de Astrobobo. Descifra el significado de tus sueños.',
    cluster_title: 'Interpretación de Sueños — Lo que Realmente Significan tus Símbolos',
    cluster_desc: 'Cada artículo extenso sobre interpretación de sueños en Astrobobo.',
    h1_hub: 'Diccionario de Sueños Astrobobo',
    h1_cluster: 'Artículos de Interpretación de Sueños',
    intro: 'Estas guías profundizan en el significado psicológico, cultural y simbólico de los símbolos oníricos recurrentes.',
    nav_back: '← Volver al inicio de Astrobobo',
  },
  fr: {
    hub_title: 'Dictionnaire des Rêves Astrobobo — Tous les Articles',
    hub_desc: 'Tous les articles du dictionnaire des rêves Astrobobo. Décodez la signification de vos rêves.',
    cluster_title: 'Interprétation des Rêves — Ce que Vos Symboles Signifient Vraiment',
    cluster_desc: 'Tous les articles longs sur l\'interprétation des rêves sur Astrobobo.',
    h1_hub: 'Dictionnaire des Rêves Astrobobo',
    h1_cluster: 'Articles d\'Interprétation des Rêves',
    intro: 'Ces guides explorent la signification psychologique, culturelle et symbolique des symboles oniriques récurrents.',
    nav_back: '← Retour à l\'accueil Astrobobo',
  },
  it: {
    hub_title: 'Dizionario dei Sogni Astrobobo — Tutti gli Articoli',
    hub_desc: 'Tutti gli articoli del dizionario dei sogni di Astrobobo. Decodifica il significato dei tuoi sogni.',
    cluster_title: 'Interpretazione dei Sogni — Cosa Significano Davvero i Tuoi Simboli',
    cluster_desc: 'Tutti gli articoli approfonditi sull\'interpretazione dei sogni su Astrobobo.',
    h1_hub: 'Dizionario dei Sogni Astrobobo',
    h1_cluster: 'Articoli di Interpretazione dei Sogni',
    intro: 'Queste guide approfondiscono il significato psicologico, culturale e simbolico dei simboli onirici ricorrenti.',
    nav_back: '← Torna alla home di Astrobobo',
  },
  'pt-br': {
    hub_title: 'Dicionário de Sonhos Astrobobo — Todos os Artigos',
    hub_desc: 'Todos os artigos do dicionário de sonhos da Astrobobo. Decifre o significado dos seus sonhos.',
    cluster_title: 'Interpretação de Sonhos — O que Seus Símbolos Realmente Significam',
    cluster_desc: 'Todos os artigos longos sobre interpretação de sonhos na Astrobobo.',
    h1_hub: 'Dicionário de Sonhos Astrobobo',
    h1_cluster: 'Artigos de Interpretação de Sonhos',
    intro: 'Esses guias aprofundam o significado psicológico, cultural e simbólico dos símbolos oníricos recorrentes.',
    nav_back: '← Voltar para a home da Astrobobo',
  },
  ru: {
    hub_title: 'Словарь Снов Astrobobo — Все статьи',
    hub_desc: 'Все статьи в словаре снов Astrobobo. Расшифруйте значение ваших снов.',
    cluster_title: 'Толкование Снов — Что Действительно Означают Ваши Символы',
    cluster_desc: 'Все длинные статьи о толковании снов на Astrobobo.',
    h1_hub: 'Словарь Снов Astrobobo',
    h1_cluster: 'Статьи о Толковании Снов',
    intro: 'Эти руководства углубляются в психологическое, культурное и символическое значение повторяющихся снов.',
    nav_back: '← Вернуться на главную Astrobobo',
  },
  ar: {
    hub_title: 'قاموس أحلام أسترو بوبو — كل المقالات',
    hub_desc: 'كل المقالات في قاموس أحلام أسترو بوبو. اكتشف معاني رموز أحلامك.',
    cluster_title: 'تفسير الأحلام — ما تعنيه رموزك حقًا',
    cluster_desc: 'كل المقالات الطويلة عن تفسير الأحلام في أسترو بوبو.',
    h1_hub: 'قاموس أحلام أسترو بوبو',
    h1_cluster: 'مقالات تفسير الأحلام',
    intro: 'تتعمق هذه الأدلة في المعاني النفسية والثقافية والرمزية للرموز الحلمية المتكررة.',
    nav_back: '← العودة إلى الصفحة الرئيسية لأسترو بوبو',
  },
};

// Pretty article slug → display title (per language)
function articleTitle(lang, slug) {
  const map = {
    tr: {
      'ruyada-araba':         'Rüyada Araba Görmek',
      'ruyada-bebek':         'Rüyada Bebek Görmek',
      'ruyada-bogulmak':      'Rüyada Boğulmak',
      'ruyada-dis-dokulmesi': 'Rüyada Diş Dökülmesi',
      'ruyada-dusmek':        'Rüyada Düşmek',
      'ruyada-eski-sevgili':  'Rüyada Eski Sevgili Görmek',
      'ruyada-ev':            'Rüyada Ev Görmek',
      'ruyada-kaybolmak':     'Rüyada Kaybolmak',
      'ruyada-kopek':         'Rüyada Köpek Görmek',
      'ruyada-kovalanmak':    'Rüyada Kovalanmak',
      'ruyada-olum':          'Rüyada Ölüm Görmek',
      'ruyada-para':          'Rüyada Para Görmek',
      'ruyada-su':            'Rüyada Su Görmek',
      'ruyada-ucmak':         'Rüyada Uçmak',
      'ruyada-yilan':         'Rüyada Yılan Görmek',
    },
  };
  if (map[lang] && map[lang][slug]) return map[lang][slug];
  // Fallback: humanize the slug
  return slug.replace(/^ruyada-/, '').replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
}

// Render a hub or cluster page
function renderHub({ lang, slug, title, description, h1, intro, articles, isCluster }) {
  const baseUrl = 'https://astrobobo.com';
  const path = `/r/${lang}/${slug || ''}`.replace(/\/$/, '');
  const canonical = `${baseUrl}${path || `/r/${lang}/`}`;
  const c = COPY[lang];

  const breadcrumb = isCluster
    ? [
        { name: 'Astrobobo', item: baseUrl },
        { name: lang.toUpperCase(), item: `${baseUrl}/r/${lang}/` },
        { name: 'ruya', item: canonical },
      ]
    : [
        { name: 'Astrobobo', item: baseUrl },
        { name: lang.toUpperCase(), item: canonical },
      ];

  const ldJson = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'Organization',
        '@id': `${baseUrl}/#organization`,
        name: 'Astrobobo',
        url: baseUrl,
        logo: { '@type': 'ImageObject', url: `${baseUrl}/icons/Icon-512.png` },
      },
      {
        '@type': 'WebSite',
        '@id': `${baseUrl}/#website`,
        name: 'Astrobobo',
        url: baseUrl,
        publisher: { '@id': `${baseUrl}/#organization` },
        inLanguage: lang,
      },
      {
        '@type': 'BreadcrumbList',
        '@id': `${canonical}#breadcrumb`,
        itemListElement: breadcrumb.map((b, i) => ({
          '@type': 'ListItem',
          position: i + 1,
          name: b.name,
          item: b.item,
        })),
      },
      {
        '@type': 'CollectionPage',
        '@id': `${canonical}#collectionpage`,
        url: canonical,
        name: title,
        description: description,
        inLanguage: lang,
        isPartOf: { '@id': `${baseUrl}/#website` },
        breadcrumb: { '@id': `${canonical}#breadcrumb` },
        mainEntity: {
          '@type': 'ItemList',
          itemListElement: articles.map((a, i) => ({
            '@type': 'ListItem',
            position: i + 1,
            url: a.url,
            name: a.title,
          })),
        },
      },
    ],
  };

  const hreflangs = LANGS.map(
    l => `<link rel="alternate" hreflang="${l}" href="${baseUrl}/r/${l}/${slug || ''}">`
  ).join('\n  ');

  const articlesHtml = articles
    .map(
      a => `<li><a href="${a.url}">${a.title}</a></li>`
    )
    .join('\n      ');

  return `<!doctype html>
<html lang="${lang}"${lang === 'ar' ? ' dir="rtl"' : ''}>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
  <meta name="theme-color" content="#080612">
  <title>${title} | Astrobobo</title>
  <meta name="description" content="${description}">
  <link rel="canonical" href="${canonical}">
  ${hreflangs}
  <link rel="alternate" hreflang="x-default" href="${baseUrl}/r/en/${slug || ''}">
  <meta property="og:title" content="${title}">
  <meta property="og:description" content="${description}">
  <meta property="og:type" content="website">
  <meta property="og:url" content="${canonical}">
  <meta property="og:site_name" content="Astrobobo">
  <meta property="og:locale" content="${lang}">
  <meta property="og:image" content="${baseUrl}/api/og?title=${encodeURIComponent(title)}&subtitle=${encodeURIComponent(description.slice(0, 100))}">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${title}">
  <meta name="twitter:description" content="${description}">
  <meta name="twitter:image" content="${baseUrl}/api/og?title=${encodeURIComponent(title)}">
  <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1">
  <link rel="icon" type="image/png" sizes="512x512" href="${baseUrl}/icons/Icon-512.png">
  <link rel="apple-touch-icon" href="${baseUrl}/icons/Icon-512.png">
  <script defer data-domain="astrobobo.com" src="https://plausible.io/js/script.js"></script>
  <script type="application/ld+json">${JSON.stringify(ldJson)}</script>
  <style>
    *{box-sizing:border-box;-webkit-tap-highlight-color:transparent}
    html,body{margin:0;padding:0;background:#080612;color:#f5f0e6;font-family:-apple-system,BlinkMacSystemFont,sans-serif;line-height:1.6}
    .wrap{max-width:760px;margin:0 auto;padding:48px 24px}
    .crumb{font-size:13px;color:#9b94aa;margin-bottom:32px}
    .crumb a{color:#a78bfa;text-decoration:none}
    h1{font-size:42px;font-weight:700;margin:0 0 16px;background:linear-gradient(135deg,#a78bfa,#c4a7ff);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
    .intro{font-size:17px;color:#c8c2d6;margin:0 0 40px}
    ul{list-style:none;padding:0;margin:0;display:grid;gap:12px}
    ul li a{display:block;padding:18px 24px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:14px;color:#f5f0e6;text-decoration:none;font-size:16px;font-weight:500;transition:all .2s}
    ul li a:hover{background:rgba(167,139,250,0.10);border-color:rgba(167,139,250,0.4);transform:translateY(-2px)}
    .footer{margin-top:48px;padding-top:32px;border-top:1px solid rgba(255,255,255,0.08);text-align:center;font-size:14px;color:#9b94aa}
    .footer a{color:#a78bfa;text-decoration:none}
  </style>
</head>
<body>
  <div class="wrap">
    <nav class="crumb">
      ${breadcrumb.map((b, i) => i < breadcrumb.length - 1 ? `<a href="${b.item}">${b.name}</a> &rsaquo; ` : `<span>${b.name}</span>`).join('')}
    </nav>
    <h1>${h1}</h1>
    <p class="intro">${intro}</p>
    <ul>
      ${articlesHtml}
    </ul>
    <div class="footer">
      <a href="${baseUrl}">${c.nav_back}</a>
    </div>
  </div>
</body>
</html>
`;
}

// Main
let totalCreated = 0;

for (const lang of LANGS) {
  const langDir = path.join(ROOT, lang);
  if (!fs.existsSync(langDir)) {
    console.log(`SKIP ${lang} — directory missing`);
    continue;
  }

  // Find all article files in this language
  const files = fs
    .readdirSync(langDir)
    .filter(f => f.endsWith('.html') && f !== 'index.html' && f !== 'about.html' && !f.startsWith('cluster-'));

  if (files.length === 0) {
    console.log(`SKIP ${lang} — no articles`);
    continue;
  }

  const articles = files.map(f => {
    const slug = f.replace(/\.html$/, '');
    return {
      url: `https://astrobobo.com/r/${lang}/${slug}`,
      title: articleTitle(lang, slug),
    };
  });

  const c = COPY[lang];

  // 1. Generate the language hub: /r/{lang}/index.html
  const hubHtml = renderHub({
    lang,
    slug: '',
    title: c.hub_title,
    description: c.hub_desc,
    h1: c.h1_hub,
    intro: c.intro,
    articles,
    isCluster: false,
  });
  fs.writeFileSync(path.join(langDir, 'index.html'), hubHtml);
  console.log(`✓ /r/${lang}/index.html (${articles.length} articles)`);
  totalCreated++;

  // 2. Generate the cluster hub: /r/{lang}/cluster-ruya.html
  const clusterHtml = renderHub({
    lang,
    slug: 'cluster-ruya',
    title: c.cluster_title,
    description: c.cluster_desc,
    h1: c.h1_cluster,
    intro: c.intro,
    articles,
    isCluster: true,
  });
  fs.writeFileSync(path.join(langDir, 'cluster-ruya.html'), clusterHtml);
  console.log(`✓ /r/${lang}/cluster-ruya.html (${articles.length} articles)`);
  totalCreated++;
}

console.log(`\n✨ Generated ${totalCreated} hub pages across ${LANGS.length} languages`);
