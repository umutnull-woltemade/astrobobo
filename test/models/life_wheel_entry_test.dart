import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/life_wheel_entry.dart';

void main() {
  group('LifeArea', () {
    test('has 8 areas', () {
      expect(LifeArea.values.length, 8);
    });

    test('each has English label', () {
      for (final area in LifeArea.values) {
        expect(area.labelEn(), isNotEmpty);
      }
    });

    test('each has Turkish label', () {
      for (final area in LifeArea.values) {
        expect(area.labelTr(), isNotEmpty);
      }
    });

    test('each has emoji', () {
      for (final area in LifeArea.values) {
        expect(area.emoji, isNotEmpty);
      }
    });

    test('label respects language flag', () {
      expect(LifeArea.health.label(true), 'Health');
      expect(LifeArea.career.label(false), 'Kariyer');
    });

    test('specific labels are correct', () {
      expect(LifeArea.health.labelEn(), 'Health');
      expect(LifeArea.fun.labelEn(), 'Fun & Recreation');
      expect(LifeArea.growth.labelEn(), 'Personal Growth');
    });
  });
}
