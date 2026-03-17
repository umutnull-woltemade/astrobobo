import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/streak_service.dart';

void main() {
  group('streakMilestones', () {
    test('contains expected milestones', () {
      expect(streakMilestones, [3, 7, 14, 30, 60, 90, 180, 365]);
    });

    test('is sorted ascending', () {
      for (var i = 1; i < streakMilestones.length; i++) {
        expect(streakMilestones[i], greaterThan(streakMilestones[i - 1]));
      }
    });
  });

  group('StreakFreeze', () {
    test('constructs with required date', () {
      final freeze = StreakFreeze(date: DateTime(2026, 3, 17));
      expect(freeze.date.year, 2026);
      expect(freeze.wasAutomatic, false);
    });

    test('constructs with automatic flag', () {
      final freeze = StreakFreeze(date: DateTime(2026, 1, 1), wasAutomatic: true);
      expect(freeze.wasAutomatic, true);
    });

    test('toJson produces correct map', () {
      final freeze = StreakFreeze(date: DateTime(2026, 3, 17), wasAutomatic: true);
      final json = freeze.toJson();
      expect(json['wasAutomatic'], true);
      expect(json['date'], contains('2026-03-17'));
    });

    test('fromJson parses correctly', () {
      final freeze = StreakFreeze.fromJson({
        'date': '2026-03-17T00:00:00.000',
        'wasAutomatic': true,
      });
      expect(freeze.date.year, 2026);
      expect(freeze.date.month, 3);
      expect(freeze.date.day, 17);
      expect(freeze.wasAutomatic, true);
    });

    test('fromJson handles missing wasAutomatic', () {
      final freeze = StreakFreeze.fromJson({'date': '2026-01-01'});
      expect(freeze.wasAutomatic, false);
    });

    test('fromJson handles invalid date', () {
      final freeze = StreakFreeze.fromJson({'date': 'invalid'});
      expect(freeze.date.year, DateTime.now().year);
    });

    test('dateKey formats correctly', () {
      final freeze = StreakFreeze(date: DateTime(2026, 3, 5));
      expect(freeze.dateKey, '2026-03-05');
    });

    test('dateKey pads single digits', () {
      final freeze = StreakFreeze(date: DateTime(2026, 1, 9));
      expect(freeze.dateKey, '2026-01-09');
    });

    test('toJson/fromJson roundtrip', () {
      final original = StreakFreeze(date: DateTime(2026, 6, 15), wasAutomatic: true);
      final restored = StreakFreeze.fromJson(original.toJson());
      expect(restored.wasAutomatic, original.wasAutomatic);
      expect(restored.dateKey, original.dateKey);
    });
  });

  group('StreakStats', () {
    test('constructs with required fields', () {
      final stats = StreakStats(
        currentStreak: 7,
        longestStreak: 30,
        totalEntries: 100,
        freezesUsedThisWeek: 1,
        freezesAvailable: 2,
      );
      expect(stats.currentStreak, 7);
      expect(stats.longestStreak, 30);
      expect(stats.totalEntries, 100);
      expect(stats.freezesUsedThisWeek, 1);
      expect(stats.freezesAvailable, 2);
      expect(stats.lastMilestoneReached, isNull);
      expect(stats.nextMilestone, isNull);
      expect(stats.celebratedMilestones, isEmpty);
      expect(stats.graceUsedThisWeek, false);
    });

    test('constructs with all optional fields', () {
      final stats = StreakStats(
        currentStreak: 14,
        longestStreak: 90,
        totalEntries: 200,
        freezesUsedThisWeek: 0,
        freezesAvailable: 3,
        lastMilestoneReached: 14,
        nextMilestone: 30,
        celebratedMilestones: [3, 7, 14],
        graceUsedThisWeek: true,
      );
      expect(stats.lastMilestoneReached, 14);
      expect(stats.nextMilestone, 30);
      expect(stats.celebratedMilestones, [3, 7, 14]);
      expect(stats.graceUsedThisWeek, true);
    });
  });
}
