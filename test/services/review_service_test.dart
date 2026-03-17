import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/review_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ReviewTrigger', () {
    test('has all expected trigger types', () {
      expect(ReviewTrigger.values.length, 8);
      expect(ReviewTrigger.values, contains(ReviewTrigger.streakMilestone));
      expect(ReviewTrigger.values, contains(ReviewTrigger.patternDiscovered));
      expect(ReviewTrigger.values, contains(ReviewTrigger.dreamInterpretation));
      expect(ReviewTrigger.values, contains(ReviewTrigger.quizCompleted));
      expect(ReviewTrigger.values, contains(ReviewTrigger.monthlyReport));
      expect(ReviewTrigger.values, contains(ReviewTrigger.badgeUnlocked));
      expect(ReviewTrigger.values, contains(ReviewTrigger.deepEngagement));
      expect(ReviewTrigger.values, contains(ReviewTrigger.shareCompleted));
    });

    test('trigger names are valid identifiers', () {
      for (final trigger in ReviewTrigger.values) {
        expect(trigger.name, isNotEmpty);
        expect(trigger.name, isNot(contains(' ')));
      }
    });
  });

  group('ReviewService state accessors', () {
    late ReviewService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      service = await ReviewService.init();
    });

    test('lastPromptDate is null when no prompt has been shown', () {
      expect(service.lastPromptDate, isNull);
    });

    test('totalPromptsShown is 0 initially', () {
      expect(service.totalPromptsShown, 0);
    });

    test('hasReviewed is false initially', () {
      expect(service.hasReviewed, false);
    });

    test('cooldownDaysRemaining is 0 when no prompt has been shown', () {
      expect(service.cooldownDaysRemaining, 0);
    });

    test('no triggers are used initially', () {
      for (final trigger in ReviewTrigger.values) {
        expect(service.isTriggerUsed(trigger), false);
      }
    });
  });

  group('ReviewService markAsReviewed', () {
    late ReviewService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      service = await ReviewService.init();
    });

    test('markAsReviewed sets hasReviewed to true', () async {
      expect(service.hasReviewed, false);
      await service.markAsReviewed();
      expect(service.hasReviewed, true);
    });

    test('checkAndPromptReview returns false after markAsReviewed', () async {
      await service.markAsReviewed();
      final result = await service.checkAndPromptReview(
        ReviewTrigger.quizCompleted,
      );
      expect(result, false);
    });
  });

  group('ReviewService resetAll', () {
    late ReviewService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'review_last_prompt_date': DateTime.now().millisecondsSinceEpoch,
        'review_total_prompts_shown': 3,
        'review_has_reviewed': true,
        'review_triggers_used': ['quizCompleted', 'badgeUnlocked'],
      });
      service = await ReviewService.init();
    });

    test('resetAll clears all review state', () async {
      expect(service.hasReviewed, true);
      expect(service.totalPromptsShown, 3);

      await service.resetAll();

      expect(service.hasReviewed, false);
      expect(service.totalPromptsShown, 0);
      expect(service.lastPromptDate, isNull);
      expect(service.cooldownDaysRemaining, 0);
    });
  });

  group('ReviewService cooldown logic', () {
    test('cooldown is expired when no previous prompt exists', () async {
      SharedPreferences.setMockInitialValues({});
      final service = await ReviewService.init();
      // First prompt has 0-day cooldown, so it should be allowed
      expect(service.cooldownDaysRemaining, 0);
    });

    test('cooldownDaysRemaining reflects tiered cooldown after first prompt',
        () async {
      // Simulate 1 prompt shown yesterday
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      SharedPreferences.setMockInitialValues({
        'review_last_prompt_date': yesterday.millisecondsSinceEpoch,
        'review_total_prompts_shown': 1,
      });
      final service = await ReviewService.init();

      // Second prompt has 45-day cooldown; 1 day elapsed means ~44 remaining
      expect(service.cooldownDaysRemaining, greaterThanOrEqualTo(43));
      expect(service.cooldownDaysRemaining, lessThanOrEqualTo(45));
    });

    test('cooldownDaysRemaining is 0 when cooldown has fully expired',
        () async {
      final longAgo = DateTime.now().subtract(const Duration(days: 100));
      SharedPreferences.setMockInitialValues({
        'review_last_prompt_date': longAgo.millisecondsSinceEpoch,
        'review_total_prompts_shown': 2,
      });
      final service = await ReviewService.init();

      // Third+ prompt has 90-day cooldown; 100 days elapsed means 0 remaining
      expect(service.cooldownDaysRemaining, 0);
    });

    test('tiered cooldown: 3+ prompts uses 90-day cap', () async {
      final recent = DateTime.now().subtract(const Duration(days: 10));
      SharedPreferences.setMockInitialValues({
        'review_last_prompt_date': recent.millisecondsSinceEpoch,
        'review_total_prompts_shown': 5,
      });
      final service = await ReviewService.init();

      // 90 - 10 = 80 days remaining
      expect(service.cooldownDaysRemaining, greaterThanOrEqualTo(79));
      expect(service.cooldownDaysRemaining, lessThanOrEqualTo(81));
    });
  });

  group('ReviewService trigger validation', () {
    late ReviewService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      service = await ReviewService.init();
    });

    test('streakMilestone rejected when streak below minimum', () async {
      final result = await service.checkAndPromptReview(
        ReviewTrigger.streakMilestone,
        currentStreak: 3,
      );
      expect(result, false);
    });

    test('patternDiscovered rejected when journal entries below minimum',
        () async {
      final result = await service.checkAndPromptReview(
        ReviewTrigger.patternDiscovered,
        journalEntryCount: 2,
      );
      expect(result, false);
    });

    test('dreamInterpretation rejected when dream entries below minimum',
        () async {
      final result = await service.checkAndPromptReview(
        ReviewTrigger.dreamInterpretation,
        dreamEntryCount: 1,
      );
      expect(result, false);
    });

    test('deepEngagement rejected when journal entries below 25', () async {
      final result = await service.checkAndPromptReview(
        ReviewTrigger.deepEngagement,
        journalEntryCount: 20,
      );
      expect(result, false);
    });
  });

  group('ReviewService trigger used tracking', () {
    test('isTriggerUsed returns true for previously used triggers', () async {
      SharedPreferences.setMockInitialValues({
        'review_triggers_used': ['quizCompleted', 'monthlyReport'],
      });
      final service = await ReviewService.init();

      expect(service.isTriggerUsed(ReviewTrigger.quizCompleted), true);
      expect(service.isTriggerUsed(ReviewTrigger.monthlyReport), true);
      expect(service.isTriggerUsed(ReviewTrigger.streakMilestone), false);
      expect(service.isTriggerUsed(ReviewTrigger.badgeUnlocked), false);
    });

    test('already-used trigger is rejected by checkAndPromptReview', () async {
      SharedPreferences.setMockInitialValues({
        'review_triggers_used': ['quizCompleted'],
      });
      final service = await ReviewService.init();

      final result = await service.checkAndPromptReview(
        ReviewTrigger.quizCompleted,
      );
      expect(result, false);
    });
  });

  group('ReviewService lastPromptDate persistence', () {
    test('lastPromptDate is reconstructed from stored milliseconds', () async {
      final storedDate = DateTime(2026, 3, 1, 12, 0);
      SharedPreferences.setMockInitialValues({
        'review_last_prompt_date': storedDate.millisecondsSinceEpoch,
      });
      final service = await ReviewService.init();

      final retrieved = service.lastPromptDate;
      expect(retrieved, isNotNull);
      expect(retrieved!.year, 2026);
      expect(retrieved.month, 3);
      expect(retrieved.day, 1);
    });
  });
}
