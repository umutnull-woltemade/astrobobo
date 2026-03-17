import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/sleep_service.dart';

void main() {
  group('SleepEntry', () {
    test('constructs with required fields', () {
      final entry = SleepEntry(
        dateKey: '2026-03-17',
        quality: 4,
        createdAt: DateTime(2026, 3, 17),
      );
      expect(entry.dateKey, '2026-03-17');
      expect(entry.quality, 4);
      expect(entry.note, isNull);
    });

    test('toJson produces correct map', () {
      final entry = SleepEntry(
        dateKey: '2026-03-17',
        quality: 5,
        note: 'Slept great',
        createdAt: DateTime(2026, 3, 17, 8, 0),
      );
      final json = entry.toJson();
      expect(json['dateKey'], '2026-03-17');
      expect(json['quality'], 5);
      expect(json['note'], 'Slept great');
    });

    test('fromJson parses correctly', () {
      final entry = SleepEntry.fromJson({
        'dateKey': '2026-03-17',
        'quality': 4,
        'note': 'Good night',
        'createdAt': '2026-03-17T08:00:00.000',
      });
      expect(entry.dateKey, '2026-03-17');
      expect(entry.quality, 4);
      expect(entry.note, 'Good night');
    });

    test('fromJson clamps quality to 1-5', () {
      expect(SleepEntry.fromJson({'quality': 0}).quality, 1);
      expect(SleepEntry.fromJson({'quality': 10}).quality, 5);
      expect(SleepEntry.fromJson({'quality': -1}).quality, 1);
    });

    test('fromJson defaults quality to 3', () {
      expect(SleepEntry.fromJson({}).quality, 3);
    });

    test('toJson/fromJson roundtrip', () {
      final original = SleepEntry(
        dateKey: '2026-06-15',
        quality: 2,
        note: 'Restless',
        createdAt: DateTime(2026, 6, 15),
      );
      final restored = SleepEntry.fromJson(original.toJson());
      expect(restored.dateKey, original.dateKey);
      expect(restored.quality, original.quality);
      expect(restored.note, original.note);
    });
  });

  group('SleepSummary', () {
    test('constructs correctly', () {
      const summary = SleepSummary(
        averageQuality: 3.5,
        nightsLogged: 7,
        bestNightQuality: 5,
        worstNightQuality: 2,
        trendDirection: 'improving',
      );
      expect(summary.averageQuality, 3.5);
      expect(summary.nightsLogged, 7);
      expect(summary.bestNightQuality, 5);
      expect(summary.worstNightQuality, 2);
      expect(summary.trendDirection, 'improving');
    });

    test('trendDirection defaults to null', () {
      const summary = SleepSummary(
        averageQuality: 3.0,
        nightsLogged: 0,
        bestNightQuality: 0,
        worstNightQuality: 0,
      );
      expect(summary.trendDirection, isNull);
    });
  });
}
