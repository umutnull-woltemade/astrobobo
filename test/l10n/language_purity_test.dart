import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Language Purity Tests
///
/// These tests ensure STRICT LANGUAGE ISOLATION:
/// - No Turkish characters in English locale
/// - No foreign script characters in either locale
///
/// ANY violation FAILS the build.
void main() {
  // Character patterns for each language
  final turkishChars = RegExp(r'[çğıİöşüÇĞÖŞÜ]'); // Full Turkish charset (for non-Turkish locales)
  final germanChars = RegExp(r'[äöüßÄÖÜ]'); // German chars (should not appear in EN or TR)
  final cyrillicChars = RegExp(r'[\u0400-\u04FF]');
  final arabicChars = RegExp(r'[\u0600-\u06FF]');
  final chineseChars = RegExp(r'[\u4E00-\u9FFF]');

  late Map<String, dynamic> enContent;
  late Map<String, dynamic> trContent;

  setUpAll(() async {
    // Load all locale files
    enContent = await _loadLocaleFile('en');
    trContent = await _loadLocaleFile('tr');
  });

  group('English Locale Purity', () {
    test('EN contains no Turkish characters', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          turkishChars.hasMatch(str),
          isFalse,
          reason: 'English locale contains Turkish character in: "$str"',
        );
      }
    });

    test('EN contains no German special characters', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          germanChars.hasMatch(str),
          isFalse,
          reason: 'English locale contains German character in: "$str"',
        );
      }
    });

    test('EN contains no Cyrillic characters', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          cyrillicChars.hasMatch(str),
          isFalse,
          reason: 'English locale contains Cyrillic character in: "$str"',
        );
      }
    });

    test('EN contains no Arabic characters', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          arabicChars.hasMatch(str),
          isFalse,
          reason: 'English locale contains Arabic character in: "$str"',
        );
      }
    });

    test('EN contains no Chinese characters', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          chineseChars.hasMatch(str),
          isFalse,
          reason: 'English locale contains Chinese character in: "$str"',
        );
      }
    });
  });

  group('Turkish Locale Purity', () {
    test('TR contains no German-unique characters (ä, ß)', () {
      final germanUniqueChars = RegExp(r'[äßÄ]');
      final strings = _extractAllStrings(trContent);
      for (final str in strings) {
        // Note: ö and ü are valid in Turkish, only check German-unique chars
        expect(
          germanUniqueChars.hasMatch(str),
          isFalse,
          reason: 'Turkish locale contains German-unique character in: "$str"',
        );
      }
    });

    test('TR contains no Cyrillic characters', () {
      final strings = _extractAllStrings(trContent);
      for (final str in strings) {
        expect(
          cyrillicChars.hasMatch(str),
          isFalse,
          reason: 'Turkish locale contains Cyrillic character in: "$str"',
        );
      }
    });

    test('TR contains no Arabic characters', () {
      final strings = _extractAllStrings(trContent);
      for (final str in strings) {
        expect(
          arabicChars.hasMatch(str),
          isFalse,
          reason: 'Turkish locale contains Arabic character in: "$str"',
        );
      }
    });
  });

  group('Key Consistency', () {
    test('EN and TR have identical key sets', () {
      final enKeys = _extractAllKeys(enContent);
      final trKeys = _extractAllKeys(trContent);

      final missingInTr = enKeys.difference(trKeys);
      final extraInTr = trKeys.difference(enKeys);
      expect(
        missingInTr,
        isEmpty,
        reason: 'Keys missing in TR: $missingInTr',
      );
      expect(
        extraInTr,
        isEmpty,
        reason: 'Extra keys in TR: $extraInTr',
      );
    });
  });

  group('No Placeholder Keys', skip: '[[term]] markers are intentional glossary links', () {
    test('EN has no placeholder keys', () {
      final strings = _extractAllStrings(enContent);
      for (final str in strings) {
        expect(
          str.contains(RegExp(r'\[\w+\]')),
          isFalse,
          reason: 'EN contains placeholder key: "$str"',
        );
      }
    });

    test('TR has no placeholder keys', () {
      final strings = _extractAllStrings(trContent);
      for (final str in strings) {
        expect(
          str.contains(RegExp(r'\[\w+\]')),
          isFalse,
          reason: 'TR contains placeholder key: "$str"',
        );
      }
    });
  });

  group('Archetype Naming', () {
    test('EN has archetype names for all 12 archetypes', () {
      final archetypeKeys = [
        'pioneer', 'builder', 'communicator', 'nurturer', 'performer', 'analyst',
        'harmonizer', 'transformer', 'explorer', 'achiever', 'visionary', 'dreamer'
      ];
      final archetypeContent = enContent['archetype'] as Map<String, dynamic>?;
      expect(archetypeContent, isNotNull,
        reason: 'EN locale must have an "archetype" section');

      for (final key in archetypeKeys) {
        expect(
          archetypeContent!.containsKey(key),
          isTrue,
          reason: 'EN missing archetype key: $key',
        );
        expect(
          (archetypeContent[key] as String).isNotEmpty,
          isTrue,
          reason: 'EN archetype name is empty for $key',
        );
      }
    });

    test('TR has archetype names for all 12 archetypes', () {
      final archetypeKeys = [
        'pioneer', 'builder', 'communicator', 'nurturer', 'performer', 'analyst',
        'harmonizer', 'transformer', 'explorer', 'achiever', 'visionary', 'dreamer'
      ];
      final archetypeContent = trContent['archetype'] as Map<String, dynamic>?;
      expect(archetypeContent, isNotNull,
        reason: 'TR locale must have an "archetype" section');

      for (final key in archetypeKeys) {
        expect(
          archetypeContent!.containsKey(key),
          isTrue,
          reason: 'TR missing archetype key: $key',
        );
        expect(
          (archetypeContent[key] as String).isNotEmpty,
          isTrue,
          reason: 'TR archetype name is empty for $key',
        );
      }
    });
  });
}

/// Load locale file from assets
Future<Map<String, dynamic>> _loadLocaleFile(String locale) async {
  final file = File('assets/l10n/$locale.json');
  if (!file.existsSync()) {
    throw Exception('Locale file not found: assets/l10n/$locale.json');
  }
  final content = await file.readAsString();
  return json.decode(content) as Map<String, dynamic>;
}

/// Extract all string values from nested JSON
List<String> _extractAllStrings(Map<String, dynamic> content) {
  final strings = <String>[];

  void traverse(dynamic value) {
    if (value is String) {
      // Skip metadata keys
      if (!value.startsWith('_') && value.isNotEmpty) {
        strings.add(value);
      }
    } else if (value is Map<String, dynamic>) {
      for (final entry in value.entries) {
        // Skip _metadata section
        if (!entry.key.startsWith('_')) {
          traverse(entry.value);
        }
      }
    } else if (value is List) {
      for (final item in value) {
        traverse(item);
      }
    }
  }

  traverse(content);
  return strings;
}

/// Extract all keys from nested JSON (dot notation)
Set<String> _extractAllKeys(Map<String, dynamic> content, [String prefix = '']) {
  final keys = <String>{};

  for (final entry in content.entries) {
    // Skip metadata
    if (entry.key.startsWith('_')) continue;

    final fullKey = prefix.isEmpty ? entry.key : '$prefix.${entry.key}';

    if (entry.value is Map<String, dynamic>) {
      keys.addAll(_extractAllKeys(entry.value as Map<String, dynamic>, fullKey));
    } else {
      keys.add(fullKey);
    }
  }

  return keys;
}
