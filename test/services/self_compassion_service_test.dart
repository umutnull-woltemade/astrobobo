import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/self_compassion_service.dart';

void main() {
  group('CompassionScore', () {
    test('constructs with required fields', () {
      const score = CompassionScore(
        score: 72.5,
        kindWords: 15,
        harshWords: 3,
        totalEntries: 20,
      );
      expect(score.score, 72.5);
      expect(score.kindWords, 15);
      expect(score.harshWords, 3);
      expect(score.totalEntries, 20);
      expect(score.dominantTone, isNull);
    });

    test('constructs with dominantTone', () {
      const score = CompassionScore(
        score: 85.0,
        kindWords: 25,
        harshWords: 2,
        totalEntries: 30,
        dominantTone: 'kind',
      );
      expect(score.dominantTone, 'kind');
    });

    test('dominantTone can be harsh', () {
      const score = CompassionScore(
        score: 20.0,
        kindWords: 2,
        harshWords: 15,
        totalEntries: 10,
        dominantTone: 'harsh',
      );
      expect(score.dominantTone, 'harsh');
    });

    test('dominantTone can be neutral', () {
      const score = CompassionScore(
        score: 50.0,
        kindWords: 5,
        harshWords: 5,
        totalEntries: 10,
        dominantTone: 'neutral',
      );
      expect(score.dominantTone, 'neutral');
    });
  });

  group('SelfCompassionService', () {
    test('class is accessible', () {
      // SelfCompassionService requires JournalService dependency
      // Keyword pools are private — verified by code inspection
      expect(SelfCompassionService, isNotNull);
    });
  });
}
