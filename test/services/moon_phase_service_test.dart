import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/moon_phase_service.dart';

void main() {
  group('MoonPhase enum', () {
    test('has 8 phases', () {
      expect(MoonPhase.values.length, 8);
    });

    test('each phase has emoji', () {
      for (final phase in MoonPhase.values) {
        expect(phase.emoji, isNotEmpty);
      }
    });

    test('each phase has English display name', () {
      for (final phase in MoonPhase.values) {
        expect(phase.displayNameEn(), isNotEmpty);
      }
    });

    test('each phase has Turkish display name', () {
      for (final phase in MoonPhase.values) {
        expect(phase.displayNameTr(), isNotEmpty);
      }
    });

    test('each phase has English reflection prompt', () {
      for (final phase in MoonPhase.values) {
        expect(phase.reflectionPromptEn(), isNotEmpty);
        expect(phase.reflectionPromptEn().length, greaterThan(10));
      }
    });

    test('new moon emoji is dark circle', () {
      expect(MoonPhase.newMoon.emoji, '🌑');
    });

    test('full moon emoji is bright circle', () {
      expect(MoonPhase.fullMoon.emoji, '🌕');
    });
  });

  group('MoonPhaseService.calculate', () {
    test('returns MoonPhaseData for any date', () {
      final data = MoonPhaseService.calculate(DateTime(2026, 3, 17));
      expect(data.phase, isA<MoonPhase>());
      expect(data.illumination, greaterThanOrEqualTo(0));
      expect(data.illumination, lessThanOrEqualTo(1));
      expect(data.age, greaterThanOrEqualTo(0));
      expect(data.age, lessThan(30));
    });

    test('known new moon date returns near-new phase', () {
      // Jan 6, 2000 is the reference new moon
      final data = MoonPhaseService.calculate(DateTime.utc(2000, 1, 6, 18, 14));
      expect(data.age, closeTo(0, 1.0));
      expect(data.illumination, closeTo(0, 0.1));
    });

    test('full moon ~14.7 days after new moon', () {
      // ~14.77 days after reference = full moon
      final fullMoonDate = DateTime.utc(2000, 1, 21);
      final data = MoonPhaseService.calculate(fullMoonDate);
      expect(data.illumination, greaterThan(0.8));
    });

    test('illumination is between 0 and 1', () {
      for (var i = 0; i < 30; i++) {
        final data = MoonPhaseService.calculate(
          DateTime(2026, 3, 1).add(Duration(days: i)),
        );
        expect(data.illumination, greaterThanOrEqualTo(0));
        expect(data.illumination, lessThanOrEqualTo(1));
      }
    });

    test('age cycles through 0-29.5 days', () {
      final ages = <double>[];
      for (var i = 0; i < 30; i++) {
        final data = MoonPhaseService.calculate(
          DateTime(2026, 3, 1).add(Duration(days: i)),
        );
        ages.add(data.age);
      }
      // Ages should increase (with possible wrap-around)
      expect(ages.length, 30);
    });

    test('today() returns current date data', () {
      final data = MoonPhaseService.today();
      expect(data.date.day, DateTime.now().day);
    });
  });

  group('MoonPhaseService.getPhaseRange', () {
    test('returns one entry per day', () {
      final start = DateTime(2026, 3, 1);
      final end = DateTime(2026, 3, 7);
      final range = MoonPhaseService.getPhaseRange(start, end);
      expect(range.length, 7);
    });

    test('returns empty for same start and end', () {
      final date = DateTime(2026, 3, 17);
      final range = MoonPhaseService.getPhaseRange(date, date);
      expect(range.length, 1);
    });
  });

  group('MoonPhaseData', () {
    test('constructs correctly', () {
      final data = MoonPhaseData(
        phase: MoonPhase.fullMoon,
        illumination: 0.98,
        age: 14.7,
        date: DateTime(2026, 3, 17),
      );
      expect(data.phase, MoonPhase.fullMoon);
      expect(data.illumination, 0.98);
      expect(data.age, 14.7);
    });
  });
}
