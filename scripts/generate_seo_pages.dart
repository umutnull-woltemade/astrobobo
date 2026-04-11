// ═════════════════════════════════════════════════════════════════════════
// generate_seo_pages.dart
// Reads content/{lang}/*.md → emits web/r/{lang}/{slug}.html
// Pure-dart, no external packages needed (uses only dart:io + dart:convert)
// ═════════════════════════════════════════════════════════════════════════

import 'dart:io';
import 'dart:convert';

const siteOrigin = String.fromEnvironment('SITE_ORIGIN', defaultValue: 'https://astrobobo.com');
const brandName  = 'Astrobobo';

// Loaded once from scripts/brand_config.json
late Map<String, dynamic> brandConfig;

void main() async {
  // Load brand config (sameAs network, knowsAbout, etc.)
  final brandFile = File('scripts/brand_config.json');
  if (brandFile.existsSync()) {
    brandConfig = jsonDecode(brandFile.readAsStringSync()) as Map<String, dynamic>;
  } else {
    brandConfig = <String, dynamic>{
      'name': brandName,
      'url': siteOrigin,
      'sameAs': <String>[],
    };
    stderr.writeln('warn: scripts/brand_config.json not found, using defaults');
  }

  final contentDir = Directory('content');
  if (!contentDir.existsSync()) {
    stderr.writeln('content/ directory not found');
    exit(1);
  }

  int generated = 0;
  int skipped = 0;

  await for (final entity in contentDir.list(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.md')) continue;
    if (entity.uri.pathSegments.last.startsWith('_')) {
      skipped++;
      continue;
    }

    try {
      final result = renderPage(entity);
      if (result == null) {
        skipped++;
        continue;
      }
      final outFile = File('web/r/${result.lang}/${result.slug}.html');
      outFile.parent.createSync(recursive: true);
      outFile.writeAsStringSync(result.html);
      generated++;
    } catch (e, st) {
      stderr.writeln('FAIL ${entity.path}: $e\n$st');
    }
  }

  stdout.writeln('seo-pages: generated=$generated skipped=$skipped');
}

class RenderedPage {
  final String lang;
  final String slug;
  final String title;
  final String description;
  final String html;
  RenderedPage(this.lang, this.slug, this.title, this.description, this.html);
}

RenderedPage? renderPage(File file) {
  final raw = file.readAsStringSync();
  final fm  = parseFrontmatter(raw);
  if (fm == null) return null;

  final lang        = (fm['lang'] ?? '').toString();
  final slug        = (fm['route'] ?? '').toString();
  final title       = (fm['title'] ?? '').toString();
  final updatedAt   = (fm['updated_at'] ?? '').toString();
  final body        = fm['__body__']!.toString();

  if (lang.isEmpty || slug.isEmpty || title.isEmpty) return null;

  final canonical    = '$siteOrigin/r/$lang/$slug';
  final descriptionR = extractDescription(body);
  final bodyHtml     = mdToHtml(body);

  // hreflang siblings (if files exist for other langs with same slug)
  final hreflang = StringBuffer();
  for (final l in const ['tr','en','es','de','fr','it','pt-br','ru','ar']) {
    final sib = File('content/$l/$slug.md');
    if (sib.existsSync()) {
      hreflang.writeln('  <link rel="alternate" hreflang="$l" href="$siteOrigin/r/$l/$slug">');
    }
  }
  hreflang.writeln('  <link rel="alternate" hreflang="x-default" href="$siteOrigin/r/en/$slug">');

  // ─── Schema graph: Article + Organization + BreadcrumbList + (FAQPage) ──
  final faqPairs = extractFaqPairs(body);
  final cluster  = inferCluster(slug);

  final orgNode = <String, dynamic>{
    '@type': 'Organization',
    '@id': '$siteOrigin/#organization',
    'name': brandConfig['name'] ?? brandName,
    'url': brandConfig['url'] ?? siteOrigin,
    'logo': {
      '@type': 'ImageObject',
      'url': brandConfig['logo'] ?? '$siteOrigin/icons/Icon-512.png',
    },
    'description': brandConfig['description'],
    'sameAs': brandConfig['sameAs'] ?? <String>[],
    if (brandConfig['knowsAbout'] != null) 'knowsAbout': brandConfig['knowsAbout'],
    if (brandConfig['contactPoint'] != null) 'contactPoint': brandConfig['contactPoint'],
  };

  final websiteNode = <String, dynamic>{
    '@type': 'WebSite',
    '@id': '$siteOrigin/#website',
    'name': brandName,
    'url': siteOrigin,
    'publisher': {'@id': '$siteOrigin/#organization'},
    'inLanguage': lang,
  };

  final breadcrumbNode = <String, dynamic>{
    '@type': 'BreadcrumbList',
    '@id': '$canonical#breadcrumb',
    'itemListElement': [
      {'@type': 'ListItem', 'position': 1, 'name': brandName, 'item': siteOrigin},
      {'@type': 'ListItem', 'position': 2, 'name': lang.toUpperCase(), 'item': '$siteOrigin/r/$lang'},
      if (cluster != null)
        {'@type': 'ListItem', 'position': 3, 'name': cluster, 'item': '$siteOrigin/r/$lang/cluster-$cluster'},
      {'@type': 'ListItem', 'position': cluster != null ? 4 : 3, 'name': title, 'item': canonical},
    ],
  };

  final articleNode = <String, dynamic>{
    '@type': 'Article',
    '@id': '$canonical#article',
    'headline': title,
    'description': descriptionR,
    'datePublished': updatedAt,
    'dateModified': updatedAt,
    'inLanguage': lang,
    'isPartOf': {'@id': '$siteOrigin/#website'},
    'author': {'@id': '$siteOrigin/#organization'},
    'publisher': {'@id': '$siteOrigin/#organization'},
    'mainEntityOfPage': canonical,
    'image': '$siteOrigin/icons/Icon-512.png',
    'breadcrumb': {'@id': '$canonical#breadcrumb'},
  };

  final graph = <Map<String, dynamic>>[
    orgNode,
    websiteNode,
    breadcrumbNode,
    articleNode,
  ];

  // FAQPage only if we found at least 2 Q&A pairs
  if (faqPairs.length >= 2) {
    graph.add({
      '@type': 'FAQPage',
      '@id': '$canonical#faq',
      'mainEntity': faqPairs.map((p) => {
        '@type': 'Question',
        'name': p.question,
        'acceptedAnswer': {'@type': 'Answer', 'text': p.answer},
      }).toList(),
    });
  }

  final schema = jsonEncode({
    '@context': 'https://schema.org',
    '@graph': graph,
  });

  // Cluster-based color theme
  final theme = clusterTheme(cluster ?? 'default');
  // Reading time: ~200 wpm
  final wordCount = body.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  final readingMinutes = (wordCount / 200).ceil().clamp(1, 60);
  // Cluster label for breadcrumb / pill
  final clusterPill = cluster != null ? clusterLabel(cluster, lang) : null;
  // TOC from H2s
  final toc = extractToc(body);
  // Share URLs
  final shareUrl = Uri.encodeComponent(canonical);
  final shareTitle = Uri.encodeComponent(title);

  final html = '''
<!doctype html>
<html lang="$lang">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
  <meta name="theme-color" content="${theme.bg}">
  <title>${escapeHtml(title)} | $brandName</title>
  <meta name="description" content="${escapeHtml(descriptionR)}">
  <link rel="canonical" href="$canonical">
${hreflang.toString().trimRight()}
  <meta property="og:title" content="${escapeHtml(title)}">
  <meta property="og:description" content="${escapeHtml(descriptionR)}">
  <meta property="og:type" content="article">
  <meta property="og:url" content="$canonical">
  <meta property="og:site_name" content="$brandName">
  <meta property="og:locale" content="$lang">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${escapeHtml(title)}">
  <meta name="twitter:description" content="${escapeHtml(descriptionR)}">
  <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1">
  <link rel="icon" type="image/png" sizes="512x512" href="$siteOrigin/icons/Icon-512.png">
  <link rel="apple-touch-icon" href="$siteOrigin/icons/Icon-512.png">
  <script type="application/ld+json">$schema</script>
  <style>
    :root{
      --bg:#080612;
      --bg-elev:#13102a;
      --fg:#f5f0e6;
      --muted:#9b94aa;
      --line:rgba(255,255,255,0.08);
      --accent:${theme.accent};
      --accent-2:${theme.accent2};
      --halo:${theme.halo};
      --gradient:${theme.gradient};
      --card:rgba(255,255,255,0.04);
      --card-hover:rgba(255,255,255,0.07);
    }
    *{box-sizing:border-box;-webkit-tap-highlight-color:transparent}
    html{scroll-behavior:smooth}
    body{
      margin:0;
      font:16px/1.7 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",sans-serif;
      background:var(--bg);
      color:var(--fg);
      -webkit-font-smoothing:antialiased;
      text-rendering:optimizeLegibility;
      overflow-x:hidden;
    }
    body::before{
      content:"";
      position:fixed;inset:0;z-index:-2;
      background:radial-gradient(circle at 20% 0%,var(--halo) 0%,transparent 50%),
                 radial-gradient(circle at 80% 100%,var(--halo) 0%,transparent 60%),
                 var(--bg);
    }
    body::after{
      content:"";
      position:fixed;inset:0;z-index:-1;
      background-image:radial-gradient(rgba(255,255,255,0.06) 1px,transparent 1px);
      background-size:32px 32px;
      opacity:0.4;
      pointer-events:none;
    }
    .wrap{max-width:780px;margin:0 auto;padding:24px 20px 100px}
    /* HEADER */
    .topbar{
      display:flex;align-items:center;justify-content:space-between;
      padding:16px 0;border-bottom:1px solid var(--line);
      backdrop-filter:blur(8px);
    }
    .brand{
      color:var(--fg);text-decoration:none;font-weight:700;font-size:1.05rem;
      letter-spacing:0.02em;display:flex;align-items:center;gap:8px;
    }
    .brand-dot{
      width:10px;height:10px;border-radius:50%;
      background:var(--accent);
      box-shadow:0 0 16px var(--accent),0 0 32px var(--accent);
      animation:pulse 3s ease-in-out infinite;
    }
    @keyframes pulse{0%,100%{opacity:0.8;transform:scale(1)}50%{opacity:1;transform:scale(1.15)}}
    .lang-switch{display:flex;gap:4px;font-size:0.75rem}
    .lang-switch a{
      color:var(--muted);text-decoration:none;padding:4px 8px;
      border-radius:4px;text-transform:uppercase;letter-spacing:0.05em;
    }
    .lang-switch a.active{color:var(--accent);background:var(--card)}
    /* HERO */
    .hero{
      margin:48px 0 32px;
      animation:fadeIn 0.8s ease-out;
    }
    @keyframes fadeIn{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
    .pill{
      display:inline-block;
      padding:6px 14px;border-radius:100px;
      background:var(--card);border:1px solid var(--line);
      color:var(--accent);font-size:0.75rem;font-weight:600;
      text-transform:uppercase;letter-spacing:0.08em;
      margin-bottom:20px;
    }
    h1{
      font-size:clamp(1.75rem,4vw,2.6rem);
      line-height:1.15;
      margin:0 0 16px;
      font-weight:800;
      letter-spacing:-0.02em;
      background:linear-gradient(135deg,var(--fg) 0%,var(--accent) 100%);
      -webkit-background-clip:text;
      background-clip:text;
      -webkit-text-fill-color:transparent;
    }
    .meta-row{
      display:flex;align-items:center;gap:16px;flex-wrap:wrap;
      color:var(--muted);font-size:0.85rem;margin-bottom:24px;
    }
    .meta-row span{display:flex;align-items:center;gap:6px}
    .meta-divider{opacity:0.4}
    .lead{
      font-size:1.15rem;line-height:1.6;color:#d7d2c4;
      padding:20px 24px;border-radius:14px;
      background:var(--card);
      border:1px solid var(--line);
      border-left:3px solid var(--accent);
      margin:24px 0;
    }
    /* TOC */
    .toc{
      margin:32px 0;padding:20px 24px;
      background:var(--card);border:1px solid var(--line);
      border-radius:14px;
    }
    .toc-title{
      font-size:0.75rem;text-transform:uppercase;letter-spacing:0.1em;
      color:var(--muted);font-weight:600;margin:0 0 12px;
    }
    .toc ol{margin:0;padding:0;list-style:none;counter-reset:toc}
    .toc li{
      counter-increment:toc;margin:6px 0;padding-left:28px;position:relative;
      font-size:0.92rem;
    }
    .toc li::before{
      content:counter(toc);position:absolute;left:0;top:0;
      width:20px;height:20px;border-radius:50%;
      background:var(--accent);color:var(--bg);
      font-size:0.7rem;font-weight:700;
      display:flex;align-items:center;justify-content:center;
    }
    .toc a{color:var(--fg);text-decoration:none;border-bottom:1px solid transparent}
    .toc a:hover{color:var(--accent);border-bottom-color:var(--accent)}
    /* MAIN CONTENT */
    main{font-size:1.02rem}
    h2{
      font-size:clamp(1.3rem,2.5vw,1.65rem);
      line-height:1.3;
      margin:48px 0 16px;
      font-weight:700;
      color:var(--accent);
      scroll-margin-top:24px;
      display:flex;align-items:baseline;gap:12px;
    }
    h2::before{
      content:"";width:6px;height:24px;border-radius:3px;
      background:var(--gradient);
      flex-shrink:0;
    }
    h3{font-size:1.18rem;margin:32px 0 12px;font-weight:600;color:var(--fg)}
    p{margin:0 0 18px;color:#e7e2d4}
    p strong{color:var(--fg);font-weight:700}
    ul,ol{padding-left:24px;margin:0 0 20px}
    ul li,ol li{margin:8px 0;color:#e7e2d4}
    ul li::marker{color:var(--accent)}
    a{color:var(--accent-2);text-decoration:none;border-bottom:1px solid rgba(154,176,255,0.3);transition:border-color 0.2s}
    a:hover{border-bottom-color:var(--accent-2)}
    blockquote{
      margin:24px 0;padding:16px 20px;
      background:var(--card);border-left:3px solid var(--accent);
      border-radius:0 10px 10px 0;color:var(--fg);
    }
    /* SHARE */
    .share{
      display:flex;align-items:center;gap:12px;flex-wrap:wrap;
      margin:48px 0 32px;padding:20px;
      background:var(--card);border:1px solid var(--line);
      border-radius:14px;
    }
    .share-label{
      color:var(--muted);font-size:0.85rem;font-weight:600;
      text-transform:uppercase;letter-spacing:0.05em;margin-right:8px;
    }
    .share-btn{
      display:inline-flex;align-items:center;gap:6px;
      padding:8px 14px;border-radius:8px;
      background:var(--bg-elev);border:1px solid var(--line);
      color:var(--fg);font-size:0.85rem;text-decoration:none;
      transition:all 0.2s;
    }
    .share-btn:hover{
      background:var(--card-hover);border-color:var(--accent);
      color:var(--accent);
    }
    /* DISCLAIMER */
    .disclaimer{
      margin-top:48px;padding:18px 22px;
      background:var(--card);border:1px solid var(--line);
      border-radius:12px;
      color:var(--muted);font-size:0.85rem;line-height:1.6;font-style:italic;
    }
    /* FOOTER */
    footer{
      margin-top:80px;padding:32px 0 0;
      border-top:1px solid var(--line);
      color:var(--muted);font-size:0.85rem;
    }
    .footer-grid{
      display:grid;grid-template-columns:1fr auto;gap:24px;align-items:center;
    }
    .footer-grid .right a{
      color:var(--accent);text-decoration:none;margin-left:16px;
      border-bottom:none;
    }
    .footer-grid .right a:hover{color:var(--fg)}
    /* MOBILE */
    @media (max-width:640px){
      .wrap{padding:16px 16px 80px}
      .hero{margin:32px 0 24px}
      .lead{padding:16px 18px}
      .toc{padding:16px 18px}
      h2{margin:36px 0 14px}
      .footer-grid{grid-template-columns:1fr;gap:16px;text-align:left}
      .footer-grid .right{display:flex;flex-direction:column;gap:8px}
      .footer-grid .right a{margin-left:0}
    }
    /* PRINT */
    @media print{
      body::before,body::after{display:none}
      .topbar,.share,footer{display:none}
      a{color:#000;border:none}
      body{background:#fff;color:#000}
      h1,h2{color:#000;-webkit-text-fill-color:#000;background:none}
    }
    @media (prefers-reduced-motion:reduce){
      *{animation:none !important;transition:none !important}
    }
  </style>
</head>
<body>
  <div class="wrap">
    <nav class="topbar">
      <a class="brand" href="$siteOrigin">
        <span class="brand-dot"></span>
        $brandName
      </a>
      <div class="lang-switch">${langSwitchHtml(lang, slug, siteOrigin)}</div>
    </nav>

    <header class="hero">
      ${clusterPill != null ? '<span class="pill">${escapeHtml(clusterPill)}</span>' : ''}
      <h1>${escapeHtml(title)}</h1>
      <div class="meta-row">
        <span>📖 $readingMinutes ${lang == 'tr' ? 'dk okuma' : lang == 'en' ? 'min read' : lang == 'es' ? 'min lectura' : lang == 'de' ? 'Min. Lesezeit' : lang == 'fr' ? 'min de lecture' : lang == 'it' ? 'min di lettura' : 'min'}</span>
        <span class="meta-divider">•</span>
        <span>📅 $updatedAt</span>
        <span class="meta-divider">•</span>
        <span>✍️ $brandName</span>
      </div>
      <div class="lead">${escapeHtml(descriptionR)}</div>
    </header>

    ${toc.length >= 3 ? '''<aside class="toc">
      <p class="toc-title">${lang == 'tr' ? 'İçindekiler' : lang == 'en' ? 'Contents' : lang == 'es' ? 'Contenido' : lang == 'de' ? 'Inhalt' : lang == 'fr' ? 'Sommaire' : lang == 'it' ? 'Sommario' : 'Contents'}</p>
      <ol>
        ${toc.map((h) => '<li><a href="#${tocAnchor(h)}">${escapeHtml(h)}</a></li>').join('\n        ')}
      </ol>
    </aside>''' : ''}

    <main>
      $bodyHtml
    </main>

    <div class="share">
      <span class="share-label">${lang == 'tr' ? 'Paylaş' : lang == 'en' ? 'Share' : lang == 'es' ? 'Compartir' : lang == 'de' ? 'Teilen' : lang == 'fr' ? 'Partager' : lang == 'it' ? 'Condividi' : 'Share'}</span>
      <a class="share-btn" href="https://twitter.com/intent/tweet?text=$shareTitle&url=$shareUrl" target="_blank" rel="noopener">𝕏 / Twitter</a>
      <a class="share-btn" href="https://www.facebook.com/sharer/sharer.php?u=$shareUrl" target="_blank" rel="noopener">Facebook</a>
      <a class="share-btn" href="https://wa.me/?text=$shareTitle%20$shareUrl" target="_blank" rel="noopener">WhatsApp</a>
      <a class="share-btn" href="https://t.me/share/url?url=$shareUrl&text=$shareTitle" target="_blank" rel="noopener">Telegram</a>
      <a class="share-btn" href="mailto:?subject=$shareTitle&body=$shareUrl">Email</a>
    </div>

    <footer>
      <div class="footer-grid">
        <div class="left">
          <strong style="color:var(--fg)">$brandName</strong> — ${lang == 'tr' ? 'Astroloji ve rüya tabiri editöryel platformu' : lang == 'en' ? 'Astrology and dream interpretation editorial platform' : lang == 'es' ? 'Plataforma editorial de astrología e interpretación de sueños' : lang == 'de' ? 'Redaktionelle Plattform für Astrologie und Traumdeutung' : lang == 'fr' ? "Plateforme éditoriale d'astrologie et d'interprétation des rêves" : lang == 'it' ? 'Piattaforma editoriale di astrologia e interpretazione dei sogni' : 'Editorial platform'}
        </div>
        <div class="right">
          <a href="$siteOrigin">$siteOrigin</a>
          <a href="$siteOrigin/r/$lang/about">${lang == 'tr' ? 'Hakkımızda' : lang == 'en' ? 'About' : lang == 'es' ? 'Sobre' : lang == 'de' ? 'Über' : lang == 'fr' ? 'À propos' : lang == 'it' ? 'Chi siamo' : 'About'}</a>
          <a href="$siteOrigin/sitemap.xml">Sitemap</a>
        </div>
      </div>
    </footer>
  </div>
</body>
</html>
''';

  return RenderedPage(lang, slug, title, descriptionR, html);
}

// ─── Cluster theme tokens ────────────────────────────────────────────────
class ClusterTheme {
  final String bg;
  final String accent;
  final String accent2;
  final String halo;
  final String gradient;
  const ClusterTheme(this.bg, this.accent, this.accent2, this.halo, this.gradient);
}

ClusterTheme clusterTheme(String cluster) {
  switch (cluster) {
    case 'ruya':
      return const ClusterTheme(
        '#0a0716',
        '#a78bfa',
        '#c4a7ff',
        'rgba(167,139,250,0.10)',
        'linear-gradient(180deg,#a78bfa 0%,#7c3aed 100%)',
      );
    case 'burclar':
      return const ClusterTheme(
        '#0d0a06',
        '#fbbf24',
        '#fde68a',
        'rgba(251,191,36,0.08)',
        'linear-gradient(180deg,#fbbf24 0%,#d97706 100%)',
      );
    case 'askUyumu':
      return const ClusterTheme(
        '#100610',
        '#f472b6',
        '#fbcfe8',
        'rgba(244,114,182,0.10)',
        'linear-gradient(180deg,#f472b6 0%,#db2777 100%)',
      );
    case 'dogumHaritasi':
      return const ClusterTheme(
        '#06090f',
        '#60a5fa',
        '#bfdbfe',
        'rgba(96,165,250,0.10)',
        'linear-gradient(180deg,#60a5fa 0%,#2563eb 100%)',
      );
    case 'gunlukYorum':
      return const ClusterTheme(
        '#0a0d0a',
        '#34d399',
        '#a7f3d0',
        'rgba(52,211,153,0.08)',
        'linear-gradient(180deg,#34d399 0%,#059669 100%)',
      );
    case 'tarot':
      return const ClusterTheme(
        '#100408',
        '#fb7185',
        '#fecdd3',
        'rgba(251,113,133,0.10)',
        'linear-gradient(180deg,#fb7185 0%,#be123c 100%)',
      );
    case 'numeroloji':
      return const ClusterTheme(
        '#080a14',
        '#22d3ee',
        '#a5f3fc',
        'rgba(34,211,238,0.10)',
        'linear-gradient(180deg,#22d3ee 0%,#0891b2 100%)',
      );
    default:
      return const ClusterTheme(
        '#080612',
        '#d4af37',
        '#ffd700',
        'rgba(212,175,55,0.10)',
        'linear-gradient(180deg,#d4af37 0%,#b8860b 100%)',
      );
  }
}

String clusterLabel(String cluster, String lang) {
  const labels = <String, Map<String, String>>{
    'ruya': {
      'tr': 'Rüya Tabiri', 'en': 'Dream Interpretation', 'es': 'Interpretación',
      'de': 'Traumdeutung', 'fr': 'Interprétation', 'it': 'Sogni', 'pt-br': 'Sonhos',
    },
    'burclar': {
      'tr': 'Burçlar', 'en': 'Zodiac', 'es': 'Zodíaco',
      'de': 'Sternzeichen', 'fr': 'Zodiaque', 'it': 'Zodiaco', 'pt-br': 'Zodíaco',
    },
    'askUyumu': {
      'tr': 'Aşk Uyumu', 'en': 'Compatibility', 'es': 'Compatibilidad',
      'de': 'Kompatibilität', 'fr': 'Compatibilité', 'it': 'Compatibilità', 'pt-br': 'Compatibilidade',
    },
    'dogumHaritasi': {
      'tr': 'Doğum Haritası', 'en': 'Birth Chart', 'es': 'Carta Natal',
      'de': 'Geburtshoroskop', 'fr': 'Thème Astral', 'it': 'Tema Natale', 'pt-br': 'Mapa Astral',
    },
    'gunlukYorum': {
      'tr': 'Günlük Yorum', 'en': 'Daily Horoscope', 'es': 'Horóscopo',
      'de': 'Tageshoroskop', 'fr': 'Horoscope', 'it': 'Oroscopo', 'pt-br': 'Horóscopo',
    },
    'tarot': {
      'tr': 'Tarot', 'en': 'Tarot', 'es': 'Tarot',
      'de': 'Tarot', 'fr': 'Tarot', 'it': 'Tarocchi', 'pt-br': 'Tarô',
    },
    'numeroloji': {
      'tr': 'Numeroloji', 'en': 'Numerology', 'es': 'Numerología',
      'de': 'Numerologie', 'fr': 'Numérologie', 'it': 'Numerologia', 'pt-br': 'Numerologia',
    },
  };
  return labels[cluster]?[lang] ?? labels[cluster]?['en'] ?? cluster;
}

// ─── Table of Contents extraction ────────────────────────────────────────
List<String> extractToc(String body) {
  final headings = <String>[];
  for (final line in body.split('\n')) {
    final t = line.trim();
    if (t.startsWith('## ') && !t.startsWith('### ')) {
      headings.add(t.substring(3).trim());
    }
  }
  return headings;
}

String tocAnchor(String heading) {
  var s = heading.toLowerCase();
  // Strip diacritics by replacing common characters
  const map = {
    'ç': 'c', 'ğ': 'g', 'ı': 'i', 'ö': 'o', 'ş': 's', 'ü': 'u',
    'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u', 'ñ': 'n',
    'ä': 'a', 'ë': 'e', 'ï': 'i', 'â': 'a', 'ê': 'e', 'î': 'i', 'ô': 'o', 'û': 'u',
    'à': 'a', 'è': 'e', 'ì': 'i', 'ò': 'o', 'ù': 'u',
  };
  for (final entry in map.entries) {
    s = s.replaceAll(entry.key, entry.value);
  }
  s = s.replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');
  return s.isEmpty ? 'section' : s;
}

// ─── Language switcher ───────────────────────────────────────────────────
String langSwitchHtml(String currentLang, String slug, String origin) {
  final out = <String>[];
  for (final l in const ['tr', 'en', 'es', 'de', 'fr', 'it']) {
    final exists = File('content/$l/$slug.md').existsSync();
    if (!exists && l != currentLang) continue;
    final cls = l == currentLang ? ' class="active"' : '';
    out.add('<a href="$origin/r/$l/$slug"$cls>$l</a>');
  }
  return out.join('');
}

// ─── FAQ extraction (heuristic: **Q?** \n\n A. pattern) ──────────────────
class FaqPair {
  final String question;
  final String answer;
  FaqPair(this.question, this.answer);
}

List<FaqPair> extractFaqPairs(String body) {
  final pairs = <FaqPair>[];

  // Heuristic 1: locate FAQ section heading then parse **Q** Answer pairs
  final lines = body.split('\n');
  int? faqStart;
  for (var i = 0; i < lines.length; i++) {
    final t = lines[i].trim().toLowerCase();
    if (t.startsWith('## ') &&
        (t.contains('faq') ||
         t.contains('sık sor') ||
         t.contains('frequently') ||
         t.contains('preguntas') ||
         t.contains('häufig') ||
         t.contains('questions fréquentes') ||
         t.contains('domande') ||
         t.contains('perguntas frequentes'))) {
      faqStart = i + 1;
      break;
    }
  }

  if (faqStart == null) return pairs;

  // Walk until next H2 or EOF, collect bold-question + paragraph-answer pairs
  String? currentQ;
  final answerBuf = StringBuffer();
  void flush() {
    if (currentQ != null && answerBuf.toString().trim().isNotEmpty) {
      pairs.add(FaqPair(currentQ!, answerBuf.toString().trim()));
    }
    currentQ = null;
    answerBuf.clear();
  }

  for (var i = faqStart; i < lines.length; i++) {
    final raw = lines[i];
    final t   = raw.trim();
    if (t.startsWith('## ')) break;
    if (t.startsWith('# ')) break;

    // Bold question pattern: **Question?**
    final boldQ = RegExp(r'^\*\*(.+?)\*\*\s*$').firstMatch(t);
    if (boldQ != null) {
      flush();
      currentQ = boldQ.group(1)!.trim();
      continue;
    }

    if (currentQ != null && t.isNotEmpty) {
      if (answerBuf.isNotEmpty) answerBuf.write(' ');
      answerBuf.write(t);
    }
  }
  flush();

  return pairs;
}

// ─── Cluster inference from slug ──────────────────────────────────────────
String? inferCluster(String slug) {
  if (slug.startsWith('cluster-')) return null;
  if (slug.startsWith('ruyada-') || slug.contains('dream') || slug.contains('soñar') ||
      slug.contains('träumen') || slug.contains('rêver') || slug.contains('sognare') ||
      slug.contains('sonhar')) {
    return 'ruya';
  }
  if (slug.contains('burc') || slug.contains('zodiac') || slug.contains('horoscop') ||
      slug.contains('sign') || slug.contains('signo') || slug.contains('segno')) {
    return 'burclar';
  }
  if (slug.contains('uyum') || slug.contains('compatib')) return 'askUyumu';
  if (slug.contains('harita') || slug.contains('chart') || slug.contains('carta')) return 'dogumHaritasi';
  if (slug.contains('tarot')) return 'tarot';
  if (slug.contains('numero')) return 'numeroloji';
  return null;
}

// ─── Frontmatter parser ───────────────────────────────────────────────────
Map<String, dynamic>? parseFrontmatter(String raw) {
  if (!raw.startsWith('---')) return null;
  final end = raw.indexOf('\n---', 3);
  if (end == -1) return null;
  final fmText = raw.substring(3, end).trim();
  final body   = raw.substring(end + 4).trim();
  final map = <String, dynamic>{};
  for (final line in fmText.split('\n')) {
    final colon = line.indexOf(':');
    if (colon == -1) continue;
    final k = line.substring(0, colon).trim();
    var v = line.substring(colon + 1).trim();
    if ((v.startsWith('"') && v.endsWith('"')) || (v.startsWith("'") && v.endsWith("'"))) {
      v = v.substring(1, v.length - 1);
    }
    map[k] = v;
  }
  map['__body__'] = body;
  return map;
}

// ─── Tiny markdown → HTML (handles h1/h2/h3, **bold**, _em_, lists, paragraphs) ──
String mdToHtml(String md) {
  final lines = md.split('\n');
  final out = StringBuffer();
  bool inList = false;
  StringBuffer? para;

  void flushPara() {
    if (para != null && para!.isNotEmpty) {
      out.writeln('<p>${inlineMd(para.toString().trim())}</p>');
      para = null;
    }
  }
  void closeList() {
    if (inList) { out.writeln('</ul>'); inList = false; }
  }

  for (var line in lines) {
    if (line.startsWith('# ')) {
      flushPara(); closeList();
      out.writeln('<h1>${inlineMd(line.substring(2).trim())}</h1>');
    } else if (line.startsWith('## ')) {
      flushPara(); closeList();
      final h2Text = line.substring(3).trim();
      out.writeln('<h2 id="${tocAnchor(h2Text)}">${inlineMd(h2Text)}</h2>');
    } else if (line.startsWith('### ')) {
      flushPara(); closeList();
      out.writeln('<h3>${inlineMd(line.substring(4).trim())}</h3>');
    } else if (line.startsWith('- ')) {
      flushPara();
      if (!inList) { out.writeln('<ul>'); inList = true; }
      out.writeln('<li>${inlineMd(line.substring(2).trim())}</li>');
    } else if (line.trim().isEmpty) {
      flushPara(); closeList();
    } else {
      closeList();
      para ??= StringBuffer();
      if (para!.isNotEmpty) para!.write(' ');
      para!.write(line.trim());
    }
  }
  flushPara(); closeList();
  return out.toString();
}

String inlineMd(String s) {
  s = escapeHtml(s);
  s = s.replaceAllMapped(RegExp(r'\*\*(.+?)\*\*'), (m) => '<strong>${m[1]}</strong>');
  s = s.replaceAllMapped(RegExp(r'(?<!\w)_(.+?)_(?!\w)'), (m) => '<em>${m[1]}</em>');
  s = s.replaceAllMapped(RegExp(r'\[([^\]]+)\]\(([^)]+)\)'), (m) => '<a href="${m[2]}">${m[1]}</a>');
  return s;
}

String escapeHtml(String s) =>
    s.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');

String extractDescription(String body) {
  // First non-heading non-bullet paragraph, max 155 chars
  for (final block in body.split(RegExp(r'\n\s*\n'))) {
    final t = block.trim();
    if (t.isEmpty) continue;
    if (t.startsWith('#')) continue;
    if (t.startsWith('-')) continue;
    if (t.startsWith('*')) continue;
    final clean = t.replaceAll(RegExp(r'[*_`]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
    if (clean.length <= 155) return clean;
    return '${clean.substring(0, 152)}...';
  }
  return '';
}
