import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/core/config/app_environment.dart';

void main() {
  group('AppEnvironment', () {
    test('has three environments', () {
      expect(AppEnvironment.values.length, 3);
      expect(AppEnvironment.values, contains(AppEnvironment.dev));
      expect(AppEnvironment.values, contains(AppEnvironment.staging));
      expect(AppEnvironment.values, contains(AppEnvironment.prod));
    });

    test('isDev/isStaging/isProd are mutually exclusive', () {
      expect(AppEnvironment.dev.isDev, true);
      expect(AppEnvironment.dev.isStaging, false);
      expect(AppEnvironment.dev.isProd, false);

      expect(AppEnvironment.staging.isDev, false);
      expect(AppEnvironment.staging.isStaging, true);
      expect(AppEnvironment.staging.isProd, false);

      expect(AppEnvironment.prod.isDev, false);
      expect(AppEnvironment.prod.isStaging, false);
      expect(AppEnvironment.prod.isProd, true);
    });

    test('displayName returns correct labels', () {
      expect(AppEnvironment.dev.displayName, 'DEV');
      expect(AppEnvironment.staging.displayName, 'STAGING');
      expect(AppEnvironment.prod.displayName, 'PROD');
    });

    test('showDebugIndicators is true for non-prod', () {
      expect(AppEnvironment.dev.showDebugIndicators, true);
      expect(AppEnvironment.staging.showDebugIndicators, true);
      expect(AppEnvironment.prod.showDebugIndicators, false);
    });

    test('enableAnalytics is true for prod and staging', () {
      expect(AppEnvironment.dev.enableAnalytics, false);
      expect(AppEnvironment.staging.enableAnalytics, true);
      expect(AppEnvironment.prod.enableAnalytics, true);
    });

    test('enableAds only for prod', () {
      expect(AppEnvironment.dev.enableAds, false);
      expect(AppEnvironment.staging.enableAds, false);
      expect(AppEnvironment.prod.enableAds, true);
    });

    test('useTestPurchases for non-prod', () {
      expect(AppEnvironment.dev.useTestPurchases, true);
      expect(AppEnvironment.staging.useTestPurchases, true);
      expect(AppEnvironment.prod.useTestPurchases, false);
    });

    test('verboseLogging only for dev', () {
      expect(AppEnvironment.dev.verboseLogging, true);
      expect(AppEnvironment.staging.verboseLogging, false);
      expect(AppEnvironment.prod.verboseLogging, false);
    });

    test('supabaseUrlOverride returns null when no env var set', () {
      // Without --dart-define, all overrides should be null
      expect(AppEnvironment.dev.supabaseUrlOverride, isNull);
      expect(AppEnvironment.staging.supabaseUrlOverride, isNull);
      expect(AppEnvironment.prod.supabaseUrlOverride, isNull);
    });

    test('supabaseAnonKeyOverride returns null when no env var set', () {
      expect(AppEnvironment.dev.supabaseAnonKeyOverride, isNull);
      expect(AppEnvironment.staging.supabaseAnonKeyOverride, isNull);
      expect(AppEnvironment.prod.supabaseAnonKeyOverride, isNull);
    });
  });
}
