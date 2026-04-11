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

  final html = '''
<!doctype html>
<html lang="$lang">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>${escapeHtml(title)} | $brandName</title>
  <meta name="description" content="${escapeHtml(descriptionR)}">
  <link rel="canonical" href="$canonical">
${hreflang.toString().trimRight()}
  <meta property="og:title" content="${escapeHtml(title)}">
  <meta property="og:description" content="${escapeHtml(descriptionR)}">
  <meta property="og:type" content="article">
  <meta property="og:url" content="$canonical">
  <meta property="og:site_name" content="$brandName">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1">
  <script type="application/ld+json">$schema</script>
  <style>
    :root{--bg:#0d0a1f;--fg:#f5f0e6;--accent:#d4af37;--muted:#a89f91;--card:#1a1530}
    *{box-sizing:border-box}
    body{margin:0;font:16px/1.7 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;background:var(--bg);color:var(--fg)}
    .wrap{max-width:760px;margin:0 auto;padding:32px 20px 80px}
    header{padding:16px 0;border-bottom:1px solid #2a2440}
    header a{color:var(--accent);text-decoration:none;font-weight:600}
    h1{font-size:2rem;line-height:1.25;margin:32px 0 16px}
    h2{font-size:1.4rem;margin:32px 0 12px;color:var(--accent)}
    h3{font-size:1.15rem;margin:24px 0 10px}
    p{margin:0 0 16px}
    ul{padding-left:20px}
    li{margin:6px 0}
    a{color:#9ab0ff}
    em{color:var(--muted);display:block;margin-top:32px;font-size:.9rem}
    .breadcrumb{font-size:.85rem;color:var(--muted);margin-top:12px}
    .breadcrumb a{color:var(--muted)}
    footer{margin-top:64px;padding-top:24px;border-top:1px solid #2a2440;color:var(--muted);font-size:.9rem}
    footer a{color:var(--accent)}
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <a href="$siteOrigin">$brandName</a>
      <div class="breadcrumb"><a href="$siteOrigin/r/$lang">${lang.toUpperCase()}</a> › ${escapeHtml(title)}</div>
    </header>
    <main>
      $bodyHtml
    </main>
    <footer>
      <p>— $brandName Editöryel</p>
      <p><a href="$siteOrigin">$siteOrigin</a></p>
    </footer>
  </div>
</body>
</html>
''';

  return RenderedPage(lang, slug, title, descriptionR, html);
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
      out.writeln('<h2>${inlineMd(line.substring(3).trim())}</h2>');
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
