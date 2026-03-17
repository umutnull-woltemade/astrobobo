// ════════════════════════════════════════════════════════════════════════════
// APP ENVIRONMENT - Build-time Environment Configuration
// ════════════════════════════════════════════════════════════════════════════
// Supports dev/staging/prod environments via --dart-define flags.
// Usage:
//   flutter run --dart-define=APP_ENV=dev
//   flutter build ios --dart-define=APP_ENV=prod
//   flutter build ios --dart-define=APP_ENV=staging
// Defaults to 'dev' when no flag is provided (debug) or 'prod' (release).
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';

enum AppEnvironment {
  dev,
  staging,
  prod;

  static AppEnvironment get current {
    const envString = String.fromEnvironment('APP_ENV');
    switch (envString) {
      case 'prod':
      case 'production':
        return AppEnvironment.prod;
      case 'staging':
        return AppEnvironment.staging;
      case 'dev':
      case 'development':
        return AppEnvironment.dev;
      default:
        // Default: dev in debug, prod in release
        return kDebugMode ? AppEnvironment.dev : AppEnvironment.prod;
    }
  }

  bool get isDev => this == AppEnvironment.dev;
  bool get isStaging => this == AppEnvironment.staging;
  bool get isProd => this == AppEnvironment.prod;

  /// Display name for debug UI
  String get displayName {
    switch (this) {
      case AppEnvironment.dev:
        return 'DEV';
      case AppEnvironment.staging:
        return 'STAGING';
      case AppEnvironment.prod:
        return 'PROD';
    }
  }

  /// Supabase URL override per environment.
  /// Falls back to .env file values if no override is configured.
  String? get supabaseUrlOverride {
    const devUrl = String.fromEnvironment('SUPABASE_URL_DEV');
    const stagingUrl = String.fromEnvironment('SUPABASE_URL_STAGING');
    const prodUrl = String.fromEnvironment('SUPABASE_URL_PROD');

    switch (this) {
      case AppEnvironment.dev:
        return devUrl.isNotEmpty ? devUrl : null;
      case AppEnvironment.staging:
        return stagingUrl.isNotEmpty ? stagingUrl : null;
      case AppEnvironment.prod:
        return prodUrl.isNotEmpty ? prodUrl : null;
    }
  }

  /// Supabase anon key override per environment.
  String? get supabaseAnonKeyOverride {
    const devKey = String.fromEnvironment('SUPABASE_ANON_KEY_DEV');
    const stagingKey = String.fromEnvironment('SUPABASE_ANON_KEY_STAGING');
    const prodKey = String.fromEnvironment('SUPABASE_ANON_KEY_PROD');

    switch (this) {
      case AppEnvironment.dev:
        return devKey.isNotEmpty ? devKey : null;
      case AppEnvironment.staging:
        return stagingKey.isNotEmpty ? stagingKey : null;
      case AppEnvironment.prod:
        return prodKey.isNotEmpty ? prodKey : null;
    }
  }

  /// Whether to show debug indicators (env badge, debug menu)
  bool get showDebugIndicators => !isProd;

  /// Whether analytics events should be sent to production
  bool get enableAnalytics => isProd || isStaging;

  /// Whether ads should be shown (only prod)
  bool get enableAds => isProd;

  /// Whether to use test RevenueCat API keys
  bool get useTestPurchases => !isProd;

  /// Log level
  bool get verboseLogging => isDev;
}
