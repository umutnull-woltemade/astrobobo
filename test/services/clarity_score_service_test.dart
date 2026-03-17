import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/clarity_score_service.dart';

void main() {
  group('WeeklyClarity', () {
    test('constructs with required fields', () {
      final clarity = WeeklyClarity(
        weekKey: '2026-W12',
        score: 75,
        journalDays: 5,
        avgMood: 3.8,
        ritualRate: 0.7,
        sleepAvg: 3.5,
        gratitudeDays: 4,
        streak: 12,
        computedAt: DateTime(2026, 3, 17),
      );
      expect(clarity.weekKey, '2026-W12');
      expect(clarity.score, 75);
      expect(clarity.journalDays, 5);
      expect(clarity.avgMood, 3.8);
      expect(clarity.ritualRate, 0.7);
      expect(clarity.sleepAvg, 3.5);
      expect(clarity.gratitudeDays, 4);
      expect(clarity.streak, 12);
    });

    test('toJson produces correct map', () {
      final clarity = WeeklyClarity(
        weekKey: '2026-W12',
        score: 82,
        journalDays: 7,
        avgMood: 4.2,
        ritualRate: 0.85,
        sleepAvg: 4.0,
        gratitudeDays: 6,
        streak: 30,
        computedAt: DateTime(2026, 3, 17, 12, 0),
      );
      final json = clarity.toJson();
      expect(json['weekKey'], '2026-W12');
      expect(json['score'], 82);
      expect(json['journalDays'], 7);
      expect(json['avgMood'], 4.2);
      expect(json['ritualRate'], 0.85);
      expect(json['computedAt'], contains('2026-03-17'));
    });

    test('fromJson parses correctly', () {
      final clarity = WeeklyClarity.fromJson({
        'weekKey': '2026-W10',
        'score': 60,
        'journalDays': 3,
        'avgMood': 3.0,
        'ritualRate': 0.5,
        'sleepAvg': 2.5,
        'gratitudeDays': 2,
        'streak': 5,
        'computedAt': '2026-03-10T10:00:00.000',
      });
      expect(clarity.weekKey, '2026-W10');
      expect(clarity.score, 60);
      expect(clarity.avgMood, 3.0);
    });

    test('fromJson handles missing fields with defaults', () {
      final clarity = WeeklyClarity.fromJson({});
      expect(clarity.weekKey, '');
      expect(clarity.score, 0);
      expect(clarity.journalDays, 0);
      expect(clarity.avgMood, 3.0);
      expect(clarity.ritualRate, 0.0);
      expect(clarity.sleepAvg, 0.0);
      expect(clarity.gratitudeDays, 0);
      expect(clarity.streak, 0);
    });

    test('toJson/fromJson roundtrip', () {
      final original = WeeklyClarity(
        weekKey: '2026-W25',
        score: 91,
        journalDays: 7,
        avgMood: 4.5,
        ritualRate: 1.0,
        sleepAvg: 4.5,
        gratitudeDays: 7,
        streak: 90,
        computedAt: DateTime(2026, 6, 20),
      );
      final restored = WeeklyClarity.fromJson(original.toJson());
      expect(restored.weekKey, original.weekKey);
      expect(restored.score, original.score);
      expect(restored.journalDays, original.journalDays);
      expect(restored.avgMood, original.avgMood);
      expect(restored.ritualRate, original.ritualRate);
      expect(restored.sleepAvg, original.sleepAvg);
      expect(restored.gratitudeDays, original.gratitudeDays);
      expect(restored.streak, original.streak);
    });
  });
}
