// ════════════════════════════════════════════════════════════════════════════
// FACEBOOK BIRTHDAY IMPORT SERVICE - Parse FB Data Exports
// ════════════════════════════════════════════════════════════════════════════
// Static utility that parses Facebook "Download Your Information" JSON
// exports and converts friend birthday data into BirthdayContact objects.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/birthday_contact.dart';

class FacebookBirthdayImportService {
  static const _uuid = Uuid();

  FacebookBirthdayImportService._();

  /// Parse a Facebook JSON export file (friends_v2 format).
  ///
  /// Expected format:
  /// ```json
  /// {
  ///   "friends_v2": [
  ///     {
  ///       "name": "John Doe",
  ///       "birthday": { "month": 3, "day": 15, "year": 1990 }
  ///     }
  ///   ]
  /// }
  /// ```
  static List<BirthdayContact> parseJsonExport(String jsonString) {
    try {
      final data = json.decode(jsonString);
      final List<dynamic> friends = data['friends_v2'] ?? data['friends'] ?? [];
      final contacts = <BirthdayContact>[];

      for (final friend in friends) {
        final name = friend['name'] as String?;
        final birthday = friend['birthday'] as Map<String, dynamic>?;

        if (name == null || name.isEmpty || birthday == null) continue;

        final month = (birthday['month'] as num?)?.toInt();
        final day = (birthday['day'] as num?)?.toInt();
        if (month == null || day == null) continue;
        if (month < 1 || month > 12 || day < 1 || day > 31) continue;

        final year = (birthday['year'] as num?)?.toInt();

        contacts.add(
          BirthdayContact(
            id: _uuid.v4(),
            name: _decodeFbName(name),
            birthdayMonth: month,
            birthdayDay: day,
            birthYear: year != null && year > 1900 ? year : null,
            createdAt: DateTime.now(),
            source: BirthdayContactSource.facebook,
            relationship: BirthdayRelationship.friend,
            notificationsEnabled: true,
            dayBeforeReminder: true,
          ),
        );
      }

      return contacts;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FacebookBirthdayImportService: JSON parse failed: $e');
      }
      return [];
    }
  }

  /// Parse Facebook HTML export (basic fallback).
  /// HTML format varies; this handles the common table/div structure.
  static List<BirthdayContact> parseHtmlExport(String html) {
    final contacts = <BirthdayContact>[];
    // FB HTML exports typically have entries like:
    // <div>Name</div><div>Birthday: March 15, 1990</div>
    // This is a best-effort parser for the most common format.
    final namePattern = RegExp(
      r'<div[^>]*>([^<]+)</div>\s*<div[^>]*>(?:Birthday|Dogum [Gg]unu):\s*(.+?)</div>',
      caseSensitive: false,
    );

    for (final match in namePattern.allMatches(html)) {
      final name = match.group(1)?.trim();
      final dateStr = match.group(2)?.trim();
      if (name == null || dateStr == null) continue;

      final parsed = _parseHtmlDate(dateStr);
      if (parsed == null) continue;

      contacts.add(
        BirthdayContact(
          id: _uuid.v4(),
          name: _decodeFbName(name),
          birthdayMonth: parsed.$1,
          birthdayDay: parsed.$2,
          birthYear: parsed.$3,
          createdAt: DateTime.now(),
          source: BirthdayContactSource.facebook,
          relationship: BirthdayRelationship.friend,
          notificationsEnabled: true,
          dayBeforeReminder: true,
        ),
      );
    }

    return contacts;
  }

  /// Facebook encodes non-ASCII characters as \uXXXX byte sequences
  /// interpreted as UTF-8 bytes. Decode them properly.
  static String _decodeFbName(String raw) {
    try {
      // FB JSON sometimes has mojibake from Latin-1 encoding of UTF-8 bytes
      final bytes = raw.codeUnits;
      if (bytes.any((b) => b > 127)) {
        return utf8.decode(bytes, allowMalformed: true);
      }
      return raw;
    } catch (_) {
      return raw;
    }
  }

  /// Parse common date strings from HTML export
  static (int, int, int?)? _parseHtmlDate(String dateStr) {
    // "March 15, 1990" or "March 15"
    final months = {
      'january': 1, 'february': 2, 'march': 3, 'april': 4,
      'may': 5, 'june': 6, 'july': 7, 'august': 8,
      'september': 9, 'october': 10, 'november': 11, 'december': 12,
      // Turkish month names
      'ocak': 1, '\u015fubat': 2, 'mart': 3, 'nisan': 4,
      'may\u0131s': 5, 'haziran': 6, 'temmuz': 7, 'a\u011fustos': 8,
      'eyl\u00fcl': 9, 'ekim': 10, 'kas\u0131m': 11, 'aral\u0131k': 12,
    };

    final parts = dateStr.replaceAll(',', '').split(RegExp(r'\s+'));
    if (parts.length < 2) return null;

    final month = months[parts[0].toLowerCase()];
    if (month == null) return null;

    final day = int.tryParse(parts[1]);
    if (day == null || day < 1 || day > 31) return null;

    final year = parts.length >= 3 ? int.tryParse(parts[2]) : null;
    return (month, day, year != null && year > 1900 ? year : null);
  }
}
