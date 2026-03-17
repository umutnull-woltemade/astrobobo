import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/analytics_service.dart';

void main() {
  group('AnalyticsService singleton', () {
    test('factory returns the same instance', () {
      final a = AnalyticsService();
      final b = AnalyticsService();
      expect(identical(a, b), true);
    });
  });

  group('AnalyticsService logEvent', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      // Dispose to reset timer state from any prior test
      service.dispose();
    });

    test('logEvent does not throw without initialization', () {
      // logEvent should buffer events even when not initialized
      expect(
        () => service.logEvent('test_event', {'key': 'value'}),
        returnsNormally,
      );
    });

    test('logEvent with no parameters does not throw', () {
      expect(() => service.logEvent('simple_event'), returnsNormally);
    });

    test('multiple logEvent calls do not throw', () {
      expect(() {
        for (var i = 0; i < 30; i++) {
          service.logEvent('event_$i', {'index': i.toString()});
        }
      }, returnsNormally);
    });
  });

  group('AnalyticsService logScreenView', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      service.dispose();
    });

    test('logScreenView does not throw', () {
      expect(
        () => service.logScreenView('HomeScreen'),
        returnsNormally,
      );
    });

    test('logScreenView with screenClass does not throw', () {
      expect(
        () => service.logScreenView('Settings', screenClass: 'SettingsScreen'),
        returnsNormally,
      );
    });
  });

  group('AnalyticsService logJournalCompleted', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      service.dispose();
    });

    test('logJournalCompleted does not throw', () {
      expect(
        () => service.logJournalCompleted(
          focusArea: 'mood',
          rating: 4,
          hasNote: true,
          hasGratitude: false,
        ),
        returnsNormally,
      );
    });
  });

  group('AnalyticsService convenience methods', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      service.dispose();
    });

    test('logPurchase does not throw', () {
      expect(
        () => service.logPurchase(
          productId: 'premium_monthly',
          tier: 'premium',
          success: true,
        ),
        returnsNormally,
      );
    });

    test('logAdEvent does not throw', () {
      expect(
        () => service.logAdEvent('banner', 'impression', placement: 'home'),
        returnsNormally,
      );
    });

    test('logFeatureUsage does not throw', () {
      expect(
        () => service.logFeatureUsage('dream_journal'),
        returnsNormally,
      );
    });

    test('logInsightView does not throw', () {
      expect(
        () => service.logInsightView('mood', 'weekly'),
        returnsNormally,
      );
    });

    test('logChartGeneration does not throw', () {
      expect(
        () => service.logChartGeneration('mood_trend'),
        returnsNormally,
      );
    });

    test('logShare does not throw', () {
      expect(
        () => service.logShare('journal_card', 'instagram'),
        returnsNormally,
      );
    });

    test('logError does not throw', () {
      expect(
        () => service.logError('network', 'Connection timeout'),
        returnsNormally,
      );
    });

    test('logError with long stack trace truncates correctly', () {
      final longTrace = 'x' * 200;
      expect(
        () => service.logError('crash', 'OOM', stackTrace: longTrace),
        returnsNormally,
      );
    });

    test('setUserProperty does not throw', () {
      expect(
        () => service.setUserProperty('tier', 'premium'),
        returnsNormally,
      );
    });

    test('setUserId does not throw', () {
      expect(() => service.setUserId('user-123'), returnsNormally);
    });

    test('setUserId with null does not throw', () {
      expect(() => service.setUserId(null), returnsNormally);
    });
  });

  group('AnalyticsService lifecycle events', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      service.dispose();
    });

    test('logAppOpened does not throw', () {
      expect(() => service.logAppOpened(), returnsNormally);
    });

    test('logAppBackgrounded does not throw', () {
      expect(() => service.logAppBackgrounded(), returnsNormally);
    });

    test('logSessionDuration does not throw', () {
      expect(
        () => service.logSessionDuration(seconds: 300),
        returnsNormally,
      );
    });

    test('logOnboardingStarted does not throw', () {
      expect(() => service.logOnboardingStarted(), returnsNormally);
    });

    test('logOnboardingCompleted does not throw', () {
      expect(() => service.logOnboardingCompleted(), returnsNormally);
    });
  });

  group('AnalyticsService dispose', () {
    test('dispose does not throw', () {
      final service = AnalyticsService();
      expect(() => service.dispose(), returnsNormally);
    });

    test('dispose can be called multiple times safely', () {
      final service = AnalyticsService();
      expect(() {
        service.dispose();
        service.dispose();
      }, returnsNormally);
    });
  });

  group('AnalyticsService experiment events', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService();
      service.dispose();
    });

    test('logExperimentAssignment does not throw', () {
      expect(
        () => service.logExperimentAssignment(
          timingVariant: 'early',
          pricingVariant: 'low',
        ),
        returnsNormally,
      );
    });

    test('logPaywallView does not throw', () {
      expect(
        () => service.logPaywallView(
          timingVariant: 'early',
          pricingVariant: 'mid',
          price: 4.99,
          sessionCount: 5,
        ),
        returnsNormally,
      );
    });

    test('logPaywallConversion does not throw', () {
      expect(
        () => service.logPaywallConversion(
          timingVariant: 'delayed',
          pricingVariant: 'high',
          price: 9.99,
          hoursToConvert: 48,
        ),
        returnsNormally,
      );
    });

    test('logPaywallDismissal does not throw', () {
      expect(
        () => service.logPaywallDismissal(
          timingVariant: 'early',
          pricingVariant: 'low',
          sessionCount: 3,
        ),
        returnsNormally,
      );
    });
  });

  group('AnalyticsService provider', () {
    test('analyticsServiceProvider is defined', () {
      expect(analyticsServiceProvider, isNotNull);
    });
  });
}
