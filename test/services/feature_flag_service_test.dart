import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inner_cycles/data/services/feature_flag_service.dart';

void main() {
  group('FeatureFlag enum', () {
    test('has 10 values', () {
      expect(FeatureFlag.values.length, 10);
    });

    test('contains all expected flags', () {
      expect(FeatureFlag.values, contains(FeatureFlag.bondEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.smartPromptsEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.dreamInterpretationEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.shareCardsEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.voiceJournalEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.cycleSyncEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.shadowWorkEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.yearReviewEnabled));
      expect(FeatureFlag.values, contains(FeatureFlag.newOnboardingFlow));
      expect(FeatureFlag.values, contains(FeatureFlag.adsEnabled));
    });
  });

  group('FeatureFlagService', () {
    late FeatureFlagService service;

    setUp(() async {
      // Set up fake SharedPreferences with empty initial values
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      // Access the private constructor via init() but with mocked prefs
      // Since init() calls _fetchRemoteFlags which needs Supabase,
      // we construct via init() after seeding the prefs mock.
      // The remote fetch will fail silently in tests (no Supabase).
      service = await FeatureFlagService.init();
    });

    group('default flag values', () {
      test('bondEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.bondEnabled), true);
      });

      test('smartPromptsEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.smartPromptsEnabled), true);
      });

      test('dreamInterpretationEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.dreamInterpretationEnabled), true);
      });

      test('shareCardsEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.shareCardsEnabled), true);
      });

      test('voiceJournalEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.voiceJournalEnabled), true);
      });

      test('cycleSyncEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.cycleSyncEnabled), true);
      });

      test('shadowWorkEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.shadowWorkEnabled), true);
      });

      test('yearReviewEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.yearReviewEnabled), true);
      });

      test('newOnboardingFlow defaults to false', () {
        expect(service.isEnabled(FeatureFlag.newOnboardingFlow), false);
      });

      test('adsEnabled defaults to true', () {
        expect(service.isEnabled(FeatureFlag.adsEnabled), true);
      });
    });

    group('setFlag', () {
      test('overrides default true to false', () async {
        expect(service.isEnabled(FeatureFlag.bondEnabled), true);
        await service.setFlag(FeatureFlag.bondEnabled, false);
        expect(service.isEnabled(FeatureFlag.bondEnabled), false);
      });

      test('overrides default false to true', () async {
        expect(service.isEnabled(FeatureFlag.newOnboardingFlow), false);
        await service.setFlag(FeatureFlag.newOnboardingFlow, true);
        expect(service.isEnabled(FeatureFlag.newOnboardingFlow), true);
      });

      test('setting same value is idempotent', () async {
        await service.setFlag(FeatureFlag.adsEnabled, false);
        await service.setFlag(FeatureFlag.adsEnabled, false);
        expect(service.isEnabled(FeatureFlag.adsEnabled), false);
      });
    });

    group('resetFlag', () {
      test('restores flag to default after override', () async {
        await service.setFlag(FeatureFlag.bondEnabled, false);
        expect(service.isEnabled(FeatureFlag.bondEnabled), false);

        await service.resetFlag(FeatureFlag.bondEnabled);
        expect(service.isEnabled(FeatureFlag.bondEnabled), true);
      });

      test('restores newOnboardingFlow to default false', () async {
        await service.setFlag(FeatureFlag.newOnboardingFlow, true);
        expect(service.isEnabled(FeatureFlag.newOnboardingFlow), true);

        await service.resetFlag(FeatureFlag.newOnboardingFlow);
        expect(service.isEnabled(FeatureFlag.newOnboardingFlow), false);
      });

      test('reset on never-set flag is a no-op', () async {
        await service.resetFlag(FeatureFlag.voiceJournalEnabled);
        expect(service.isEnabled(FeatureFlag.voiceJournalEnabled), true);
      });
    });

    group('isEnabled with cached values', () {
      test('reads cached value from SharedPreferences', () async {
        // Pre-seed a flag value
        SharedPreferences.setMockInitialValues({
          'ff_bondEnabled': false,
          'ff_newOnboardingFlow': true,
        });
        final cachedService = await FeatureFlagService.init();

        expect(cachedService.isEnabled(FeatureFlag.bondEnabled), false);
        expect(cachedService.isEnabled(FeatureFlag.newOnboardingFlow), true);
      });

      test('non-cached flags fall back to defaults', () async {
        SharedPreferences.setMockInitialValues({
          'ff_bondEnabled': false,
        });
        final cachedService = await FeatureFlagService.init();

        // Cached flag uses stored value
        expect(cachedService.isEnabled(FeatureFlag.bondEnabled), false);
        // Non-cached flag uses default
        expect(cachedService.isEnabled(FeatureFlag.smartPromptsEnabled), true);
        expect(cachedService.isEnabled(FeatureFlag.newOnboardingFlow), false);
      });

      test('setFlag persists and isEnabled reads updated value', () async {
        await service.setFlag(FeatureFlag.shadowWorkEnabled, false);
        await service.setFlag(FeatureFlag.cycleSyncEnabled, false);

        expect(service.isEnabled(FeatureFlag.shadowWorkEnabled), false);
        expect(service.isEnabled(FeatureFlag.cycleSyncEnabled), false);
        // Unaffected flags still use defaults
        expect(service.isEnabled(FeatureFlag.yearReviewEnabled), true);
      });
    });
  });
}
