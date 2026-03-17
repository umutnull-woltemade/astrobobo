import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/wellness_score_service.dart';

void main() {
  group('WellnessBreakdown', () {
    test('constructs correctly', () {
      const b = WellnessBreakdown(category: 'journal', score: 80, weight: 0.4);
      expect(b.category, 'journal');
      expect(b.score, 80);
      expect(b.weight, 0.4);
    });

    test('weightedScore calculates correctly', () {
      const b = WellnessBreakdown(category: 'journal', score: 80, weight: 0.4);
      expect(b.weightedScore, closeTo(32.0, 0.01));
    });

    test('weightedScore with zero score', () {
      const b = WellnessBreakdown(category: 'sleep', score: 0, weight: 0.15);
      expect(b.weightedScore, 0);
    });

    test('weightedScore with max score', () {
      const b = WellnessBreakdown(category: 'gratitude', score: 100, weight: 0.15);
      expect(b.weightedScore, closeTo(15.0, 0.01));
    });

    test('all weights sum to 1.0', () {
      const weights = [0.40, 0.15, 0.15, 0.15, 0.15];
      final sum = weights.fold<double>(0, (s, w) => s + w);
      expect(sum, closeTo(1.0, 0.001));
    });
  });

  group('WellnessScore', () {
    test('constructs with required fields', () {
      final now = DateTime.now();
      final score = WellnessScore(
        dateKey: '2026-03-17',
        score: 75,
        breakdown: [],
        calculatedAt: now,
      );
      expect(score.dateKey, '2026-03-17');
      expect(score.score, 75);
      expect(score.breakdown, isEmpty);
      expect(score.calculatedAt, now);
    });

    test('toJson produces correct map', () {
      final score = WellnessScore(
        dateKey: '2026-03-17',
        score: 82,
        breakdown: [
          const WellnessBreakdown(category: 'journal', score: 90, weight: 0.4),
          const WellnessBreakdown(category: 'gratitude', score: 70, weight: 0.15),
        ],
        calculatedAt: DateTime(2026, 3, 17, 12, 0),
      );
      final json = score.toJson();
      expect(json['dateKey'], '2026-03-17');
      expect(json['score'], 82);
      expect((json['breakdown'] as List).length, 2);
      expect(json['calculatedAt'], contains('2026-03-17'));
    });

    test('fromJson parses correctly', () {
      final score = WellnessScore.fromJson({
        'dateKey': '2026-03-17',
        'score': 65,
        'breakdown': [
          {'category': 'journal', 'score': 80.0, 'weight': 0.4},
          {'category': 'sleep', 'score': 50.0, 'weight': 0.15},
        ],
        'calculatedAt': '2026-03-17T12:00:00.000',
      });
      expect(score.dateKey, '2026-03-17');
      expect(score.score, 65);
      expect(score.breakdown.length, 2);
      expect(score.breakdown[0].category, 'journal');
      expect(score.breakdown[0].score, 80.0);
      expect(score.breakdown[1].weight, 0.15);
    });

    test('fromJson handles missing fields', () {
      final score = WellnessScore.fromJson({});
      expect(score.dateKey, '');
      expect(score.score, 0);
      expect(score.breakdown, isEmpty);
    });

    test('toJson/fromJson roundtrip', () {
      final original = WellnessScore(
        dateKey: '2026-06-15',
        score: 88,
        breakdown: [
          const WellnessBreakdown(category: 'journal', score: 95, weight: 0.4),
          const WellnessBreakdown(category: 'gratitude', score: 80, weight: 0.15),
          const WellnessBreakdown(category: 'ritual', score: 70, weight: 0.15),
          const WellnessBreakdown(category: 'streak', score: 100, weight: 0.15),
          const WellnessBreakdown(category: 'sleep', score: 60, weight: 0.15),
        ],
        calculatedAt: DateTime(2026, 6, 15, 10, 0),
      );
      final restored = WellnessScore.fromJson(original.toJson());
      expect(restored.dateKey, original.dateKey);
      expect(restored.score, original.score);
      expect(restored.breakdown.length, 5);
      expect(restored.breakdown[0].category, 'journal');
      expect(restored.breakdown[0].score, 95);
      expect(restored.breakdown[4].weight, 0.15);
    });
  });
}
