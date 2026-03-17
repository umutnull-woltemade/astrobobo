import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/cycle_entry.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';

void main() {
  group('CyclePhase', () {
    test('has four phases', () {
      expect(CyclePhase.values.length, 4);
    });

    test('English display names', () {
      expect(CyclePhase.menstrual.displayNameEn, 'Menstrual');
      expect(CyclePhase.follicular.displayNameEn, 'Follicular');
      expect(CyclePhase.ovulatory.displayNameEn, 'Ovulatory');
      expect(CyclePhase.luteal.displayNameEn, 'Luteal');
    });

    test('Turkish display names', () {
      expect(CyclePhase.menstrual.displayNameTr, 'Adet');
      expect(CyclePhase.ovulatory.displayNameTr, 'Yumurtlama');
    });

    test('localizedName returns correct for language', () {
      expect(CyclePhase.menstrual.localizedName(AppLanguage.en), 'Menstrual');
      expect(CyclePhase.menstrual.localizedName(AppLanguage.tr), 'Adet');
    });

    test('each phase has English description', () {
      for (final phase in CyclePhase.values) {
        expect(phase.descriptionEn, isNotEmpty);
      }
    });
  });
}
