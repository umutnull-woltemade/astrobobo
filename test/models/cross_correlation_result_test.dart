import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/cross_correlation_result.dart';

void main() {
  group('CrossCorrelation', () {
    test('constructs correctly', () {
      const c = CrossCorrelation(
        dimensionA: 'Sleep', dimensionB: 'Mood',
        coefficient: 0.72, sampleSize: 30,
        insightTextEn: 'Sleep and mood are strongly connected',
        insightTextTr: 'Uyku ve ruh hali güçlü bağlantılı',
        isSignificant: true,
      );
      expect(c.dimensionA, 'Sleep');
      expect(c.coefficient, 0.72);
      expect(c.isSignificant, true);
    });

    test('strengthEn returns correct labels', () {
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: 0.8, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).strengthEn,
        'Strongly connected',
      );
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: 0.5, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).strengthEn,
        'Moderately connected',
      );
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: 0.3, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).strengthEn,
        'Weakly connected',
      );
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: 0.1, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: false).strengthEn,
        'No clear connection',
      );
    });

    test('strengthEn works with negative coefficients', () {
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: -0.75, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).strengthEn,
        'Strongly connected',
      );
    });

    test('directionEn returns correct labels', () {
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: 0.5, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).directionEn,
        'positively correlated',
      );
      expect(
        const CrossCorrelation(dimensionA: '', dimensionB: '', coefficient: -0.5, sampleSize: 10, insightTextEn: '', insightTextTr: '', isSignificant: true).directionEn,
        'negatively correlated',
      );
    });

    test('shortDisplayEn formats correctly', () {
      const c = CrossCorrelation(
        dimensionA: 'Sleep', dimensionB: 'Energy',
        coefficient: 0.72, sampleSize: 20,
        insightTextEn: '', insightTextTr: '', isSignificant: true,
      );
      expect(c.shortDisplayEn(), 'Sleep & Energy: Strongly connected (r=0.72)');
    });

    test('shortDisplayTr formats correctly', () {
      const c = CrossCorrelation(
        dimensionA: 'Uyku', dimensionB: 'Enerji',
        coefficient: 0.35, sampleSize: 15,
        insightTextEn: '', insightTextTr: '', isSignificant: true,
      );
      expect(c.shortDisplayTr(), contains('Zayıf bağlantı'));
    });
  });
}
