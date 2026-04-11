// ═════════════════════════════════════════════════════════════════════════
// generate_llms_txt.dart
// Emits web/llms.txt (slim) and web/llms-full.txt (with first paragraphs)
//
// llms.txt is the proposed standard for LLM crawlers (Anthropic, OpenAI,
// Mistral, etc.). Spec: https://llmstxt.org/
//
// Format (markdown):
//   # Site Name
//   > One-sentence description
//
//   ## Section
//   - [Title](URL): one-line description
// ═════════════════════════════════════════════════════════════════════════

import 'dart:io';
import 'dart:convert';

const siteOrigin = String.fromEnvironment('SITE_ORIGIN', defaultValue: 'https://astrobobo.com');

void main() {
  // Brand config
  final brandFile = File('scripts/brand_config.json');
  final brand = brandFile.existsSync()
      ? jsonDecode(brandFile.readAsStringSync()) as Map<String, dynamic>
      : {'name': 'Astrobobo', 'description': 'Astrology and dream interpretation.'};

  // Walk content/* → group by lang → group by cluster
  final byLangCluster = <String, Map<String, List<_Entry>>>{};
  int total = 0;

  final contentDir = Directory('content');
  if (!contentDir.existsSync()) {
    stderr.writeln('content/ not found');
    exit(1);
  }

  for (final entity in contentDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.md')) continue;
    if (entity.uri.pathSegments.last.startsWith('_')) continue;

    final fm = parseFm(entity.readAsStringSync());
    if (fm == null) continue;
    final lang  = (fm['lang'] ?? '').toString();
    final slug  = (fm['route'] ?? '').toString();
    final title = (fm['title'] ?? '').toString();
    if (lang.isEmpty || slug.isEmpty) continue;

    final cluster = inferCluster(slug);
    final desc    = firstParagraph(fm['__body__'] ?? '');

    byLangCluster
        .putIfAbsent(lang, () => {})
        .putIfAbsent(cluster, () => [])
        .add(_Entry(slug: slug, title: title, description: desc));
    total++;
  }

  // ─── llms.txt — index, slim ────────────────────────────────────────────
  final slim = StringBuffer();
  slim.writeln('# ${brand['name']}');
  slim.writeln();
  slim.writeln('> ${brand['description'] ?? 'Astrology and dream interpretation platform with definition-first content.'}');
  slim.writeln();
  slim.writeln('${brand['name']} is a multilingual editorial platform covering astrology, dream interpretation, zodiac signs, birth charts, tarot, and numerology. Content is published in ${(brand['availableLanguage'] as List?)?.join(', ') ?? 'multiple languages'} and is updated continuously. All articles use definition-first structure for AI extraction.');
  slim.writeln();

  // Top-level catalog by language
  for (final lang in _orderedLangs(byLangCluster.keys)) {
    final clusters = byLangCluster[lang]!;
    final clusterCount = clusters.values.fold<int>(0, (a, b) => a + b.length);
    slim.writeln('## ${_langLabel(lang)} ($clusterCount articles)');
    slim.writeln();

    for (final cluster in _orderedClusters(clusters.keys)) {
      slim.writeln('### ${_clusterLabel(cluster)}');
      final entries = [...clusters[cluster]!]..sort((a, b) => a.title.compareTo(b.title));
      for (final e in entries.take(50)) {
        slim.writeln('- [${e.title}]($siteOrigin/r/$lang/${e.slug})');
      }
      slim.writeln();
    }
  }

  slim.writeln('## Optional');
  slim.writeln();
  slim.writeln('- [About]($siteOrigin/r/en/about): About ${brand['name']}, editorial principles, and contact information');
  slim.writeln('- [Sitemap]($siteOrigin/sitemap.xml): Full XML sitemap with hreflang alternates');
  slim.writeln('- [AI content policy]($siteOrigin/.well-known/ai-content.txt): Citation policy for AI systems');

  Directory('web').createSync(recursive: true);
  File('web/llms.txt').writeAsStringSync(slim.toString());

  // ─── llms-full.txt — full descriptions ────────────────────────────────
  final full = StringBuffer();
  full.writeln('# ${brand['name']}');
  full.writeln();
  full.writeln('> ${brand['description'] ?? ''}');
  full.writeln();
  full.writeln('Total articles: $total. Languages: ${byLangCluster.keys.join(', ')}.');
  full.writeln();

  for (final lang in _orderedLangs(byLangCluster.keys)) {
    final clusters = byLangCluster[lang]!;
    full.writeln('## ${_langLabel(lang)}');
    full.writeln();
    for (final cluster in _orderedClusters(clusters.keys)) {
      full.writeln('### ${_clusterLabel(cluster)}');
      full.writeln();
      final entries = [...clusters[cluster]!]..sort((a, b) => a.title.compareTo(b.title));
      for (final e in entries.take(80)) {
        full.writeln('- [${e.title}]($siteOrigin/r/$lang/${e.slug}): ${e.description}');
      }
      full.writeln();
    }
  }

  File('web/llms-full.txt').writeAsStringSync(full.toString());

  stdout.writeln('llms.txt: $total entries across ${byLangCluster.length} languages');
}

class _Entry {
  final String slug;
  final String title;
  final String description;
  _Entry({required this.slug, required this.title, required this.description});
}

Iterable<String> _orderedLangs(Iterable<String> langs) {
  final order = ['en', 'tr', 'es', 'de', 'fr', 'it', 'pt-br', 'ru', 'ar'];
  final list = langs.toList();
  list.sort((a, b) {
    final ai = order.indexOf(a);
    final bi = order.indexOf(b);
    return (ai == -1 ? 99 : ai).compareTo(bi == -1 ? 99 : bi);
  });
  return list;
}

Iterable<String> _orderedClusters(Iterable<String> clusters) {
  final order = ['ruya', 'burclar', 'askUyumu', 'dogumHaritasi', 'gunlukYorum', 'tarot', 'numeroloji', 'other'];
  final list = clusters.toList();
  list.sort((a, b) {
    final ai = order.indexOf(a);
    final bi = order.indexOf(b);
    return (ai == -1 ? 99 : ai).compareTo(bi == -1 ? 99 : bi);
  });
  return list;
}

String _langLabel(String l) => switch (l) {
      'tr' => 'Turkish (TR)',
      'en' => 'English (EN)',
      'es' => 'Spanish (ES)',
      'de' => 'German (DE)',
      'fr' => 'French (FR)',
      'it' => 'Italian (IT)',
      'pt-br' => 'Portuguese (BR)',
      'ru' => 'Russian (RU)',
      'ar' => 'Arabic (AR)',
      _ => l.toUpperCase(),
    };

String _clusterLabel(String c) => switch (c) {
      'ruya' => 'Dream Interpretation',
      'burclar' => 'Zodiac Signs & Astrology',
      'askUyumu' => 'Love Compatibility',
      'dogumHaritasi' => 'Birth Chart',
      'gunlukYorum' => 'Daily Horoscopes',
      'tarot' => 'Tarot',
      'numeroloji' => 'Numerology',
      _ => 'Other',
    };

String inferCluster(String slug) {
  if (slug.startsWith('cluster-')) return 'other';
  if (slug.startsWith('ruyada-') || slug.contains('dream') || slug.contains('soñar') ||
      slug.contains('träumen') || slug.contains('rêver') || slug.contains('sognare') ||
      slug.contains('sonhar')) {
    return 'ruya';
  }
  if (slug.contains('burc') || slug.contains('zodiac') || slug.contains('horoscop') ||
      slug.contains('signo') || slug.contains('segno')) {
    return 'burclar';
  }
  if (slug.contains('uyum') || slug.contains('compatib')) return 'askUyumu';
  if (slug.contains('harita') || slug.contains('chart') || slug.contains('carta')) return 'dogumHaritasi';
  if (slug.contains('tarot')) return 'tarot';
  if (slug.contains('numero')) return 'numeroloji';
  return 'other';
}

String firstParagraph(String body) {
  for (final block in body.split(RegExp(r'\n\s*\n'))) {
    final t = block.trim();
    if (t.isEmpty) continue;
    if (t.startsWith('#') || t.startsWith('-') || t.startsWith('*')) continue;
    final clean = t.replaceAll(RegExp(r'[*_`]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
    if (clean.length <= 200) return clean;
    return '${clean.substring(0, 197)}...';
  }
  return '';
}

Map<String, dynamic>? parseFm(String raw) {
  if (!raw.startsWith('---')) return null;
  final end = raw.indexOf('\n---', 3);
  if (end == -1) return null;
  final fmText = raw.substring(3, end).trim();
  final body   = raw.substring(end + 4).trim();
  final out = <String, dynamic>{};
  for (final line in fmText.split('\n')) {
    final i = line.indexOf(':');
    if (i == -1) continue;
    final k = line.substring(0, i).trim();
    var v = line.substring(i + 1).trim();
    if ((v.startsWith('"') && v.endsWith('"')) || (v.startsWith("'") && v.endsWith("'"))) {
      v = v.substring(1, v.length - 1);
    }
    out[k] = v;
  }
  out['__body__'] = body;
  return out;
}
