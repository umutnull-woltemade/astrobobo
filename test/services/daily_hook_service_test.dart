import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/daily_hook_service.dart';

void main() {
  group('HookCategory', () {
    test('has all expected categories', () {
      expect(HookCategory.values.length, 11);
      expect(HookCategory.values, contains(HookCategory.morning));
      expect(HookCategory.values, contains(HookCategory.reflection));
      expect(HookCategory.values, contains(HookCategory.dream));
      expect(HookCategory.values, contains(HookCategory.growth));
      expect(HookCategory.values, contains(HookCategory.archetype));
    });
  });

  group('HookTimeSlot', () {
    test('has all expected slots', () {
      expect(HookTimeSlot.values.length, 8);
      expect(HookTimeSlot.values, contains(HookTimeSlot.morning));
      expect(HookTimeSlot.values, contains(HookTimeSlot.afternoon));
      expect(HookTimeSlot.values, contains(HookTimeSlot.evening));
      expect(HookTimeSlot.values, contains(HookTimeSlot.anytime));
    });
  });

  group('DailyHook', () {
    test('constructs correctly', () {
      const hook = DailyHook(
        id: 1,
        titleEn: 'Good morning!',
        titleTr: 'Günaydın!',
        category: HookCategory.morning,
        timeSlot: HookTimeSlot.morning,
      );
      expect(hook.id, 1);
      expect(hook.titleEn, 'Good morning!');
      expect(hook.titleTr, 'Günaydın!');
      expect(hook.category, HookCategory.morning);
      expect(hook.timeSlot, HookTimeSlot.morning);
    });
  });
}
