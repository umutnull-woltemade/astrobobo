import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/gratitude_service.dart';

void main() {
  group('GratitudeEntry', () {
    test('constructs with required fields', () {
      final entry = GratitudeEntry(
        dateKey: '2026-03-17',
        items: ['Family', 'Health', 'Nature'],
        createdAt: DateTime(2026, 3, 17),
      );
      expect(entry.dateKey, '2026-03-17');
      expect(entry.items.length, 3);
      expect(entry.items[0], 'Family');
    });

    test('toJson produces correct map', () {
      final entry = GratitudeEntry(
        dateKey: '2026-03-17',
        items: ['Sunshine'],
        createdAt: DateTime(2026, 3, 17, 10, 0),
      );
      final json = entry.toJson();
      expect(json['dateKey'], '2026-03-17');
      expect(json['items'], ['Sunshine']);
      expect(json['createdAt'], contains('2026-03-17'));
    });

    test('fromJson parses correctly', () {
      final entry = GratitudeEntry.fromJson({
        'dateKey': '2026-03-17',
        'items': ['Coffee', 'Music'],
        'createdAt': '2026-03-17T10:00:00.000',
      });
      expect(entry.dateKey, '2026-03-17');
      expect(entry.items, ['Coffee', 'Music']);
    });

    test('fromJson handles missing items', () {
      final entry = GratitudeEntry.fromJson({'dateKey': '2026-01-01'});
      expect(entry.items, isEmpty);
    });

    test('fromJson filters non-string items', () {
      final entry = GratitudeEntry.fromJson({
        'items': ['valid', 42, null, 'also valid'],
      });
      expect(entry.items, ['valid', 'also valid']);
    });

    test('toJson/fromJson roundtrip', () {
      final original = GratitudeEntry(
        dateKey: '2026-06-15',
        items: ['Peace', 'Growth', 'Friends'],
        createdAt: DateTime(2026, 6, 15),
      );
      final restored = GratitudeEntry.fromJson(original.toJson());
      expect(restored.dateKey, original.dateKey);
      expect(restored.items, original.items);
    });
  });

  group('GratitudeSummary', () {
    test('constructs correctly', () {
      const summary = GratitudeSummary(
        totalItems: 21,
        topThemes: {'health': 5, 'family': 4, 'work': 3},
        daysWithGratitude: 7,
      );
      expect(summary.totalItems, 21);
      expect(summary.topThemes.length, 3);
      expect(summary.daysWithGratitude, 7);
    });
  });
}
