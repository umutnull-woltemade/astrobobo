// ═════════════════════════════════════════════════════════════════════════
// generate_sitemap.dart
// Walks content/{lang}/*.md → emits web/sitemap.xml with hreflang alternates
// ═════════════════════════════════════════════════════════════════════════

import 'dart:io';

const siteOrigin = String.fromEnvironment('SITE_ORIGIN', defaultValue: 'https://astrobobo.com');

const langs = ['tr', 'en', 'es', 'de', 'fr', 'it', 'pt-br', 'ru', 'ar'];

// Static landing routes that should always be in sitemap
const staticRoutes = <String>[
  '',
  '/birth-chart',
  '/horoscope',
  '/synastry',
  '/dreams',
  '/tarot',
  '/numerology',
  '/about',
];

void main() {
  final urls = <_Url>[];

  // 1. static routes (default lang = TR)
  for (final r in staticRoutes) {
    urls.add(_Url(loc: '$siteOrigin$r', lastmod: today(), priority: r.isEmpty ? 1.0 : 0.8));
  }

  // 2. dynamic content
  final seenSlugs = <String>{};
  for (final lang in langs) {
    final dir = Directory('content/$lang');
    if (!dir.existsSync()) continue;
    for (final f in dir.listSync()) {
      if (f is! File) continue;
      if (!f.path.endsWith('.md')) continue;
      if (f.uri.pathSegments.last.startsWith('_')) continue;

      final fm = parseFm(f.readAsStringSync());
      if (fm == null) continue;
      final slug = (fm['route'] ?? '').toString();
      if (slug.isEmpty) continue;
      final updated = (fm['updated_at'] ?? today()).toString();

      // alternates: every other lang that has same slug
      final alts = <_Alt>[];
      for (final l in langs) {
        if (File('content/$l/$slug.md').existsSync()) {
          alts.add(_Alt(hreflang: l, href: '$siteOrigin/r/$l/$slug'));
        }
      }
      alts.add(_Alt(hreflang: 'x-default', href: '$siteOrigin/en/r/$slug'));

      urls.add(_Url(
        loc: '$siteOrigin/r/$lang/$slug',
        lastmod: updated,
        priority: 0.7,
        alternates: alts,
      ));
      seenSlugs.add('$lang/$slug');
    }
  }

  // 3. emit
  final out = StringBuffer();
  out.writeln('<?xml version="1.0" encoding="UTF-8"?>');
  out.writeln(
      '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" '
      'xmlns:xhtml="http://www.w3.org/1999/xhtml">');
  for (final u in urls) {
    out.writeln('  <url>');
    out.writeln('    <loc>${u.loc}</loc>');
    out.writeln('    <lastmod>${u.lastmod}</lastmod>');
    out.writeln('    <changefreq>weekly</changefreq>');
    out.writeln('    <priority>${u.priority.toStringAsFixed(1)}</priority>');
    for (final a in u.alternates) {
      out.writeln('    <xhtml:link rel="alternate" hreflang="${a.hreflang}" href="${a.href}"/>');
    }
    out.writeln('  </url>');
  }
  out.writeln('</urlset>');

  Directory('web').createSync(recursive: true);
  File('web/sitemap.xml').writeAsStringSync(out.toString());
  stdout.writeln('sitemap: ${urls.length} urls (${seenSlugs.length} dynamic)');
}

class _Url {
  final String loc;
  final String lastmod;
  final double priority;
  final List<_Alt> alternates;
  _Url({required this.loc, required this.lastmod, required this.priority, this.alternates = const []});
}

class _Alt {
  final String hreflang;
  final String href;
  _Alt({required this.hreflang, required this.href});
}

Map<String, String>? parseFm(String raw) {
  if (!raw.startsWith('---')) return null;
  final end = raw.indexOf('\n---', 3);
  if (end == -1) return null;
  final fmText = raw.substring(3, end).trim();
  final out = <String, String>{};
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
  return out;
}

String today() => DateTime.now().toUtc().toIso8601String().substring(0, 10);
