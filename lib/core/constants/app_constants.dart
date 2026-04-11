class AppConstants {
  AppConstants._();

  static const String appName = 'Venus One';
  static const String appTagline = 'Yıldızların Rehberliğinde Kendini Keşfet';

  // App IDs and Links
  static const String appStoreId = ''; // Add your App Store ID here
  static const String playStoreId =
      'com.venusone'; // Update with your package name
  static const String privacyPolicyUrl = 'https://venusone.com/privacy';
  static const String termsOfServiceUrl = 'https://venusone.com/terms';
  static const String supportEmail = 'support@venusone.com';

  // RevenueCat API Keys
  static const String revenueCatAppleApiKey =
      'test_FplulzHEctJYysDPRwkIMOtcuyf';
  static const String revenueCatGoogleApiKey =
      'test_FplulzHEctJYysDPRwkIMOtcuyf';

  // RevenueCat Product IDs
  static const String monthlyProductId = 'monthly';
  static const String yearlyProductId = 'yearly';
  static const String lifetimeProductId = 'lifetime';
  static const String entitlementId = 'umutnull_pro';

  // Pricing Experiment Product IDs
  static const String monthlyProductId799 = 'monthly_799';
  static const String monthlyProductId999 = 'monthly_999';
  static const String monthlyProductId1199 = 'monthly_1199';

  // Pricing Experiment Values
  static const double priceVariantA = 7.99;
  static const double priceVariantB = 9.99;
  static const double priceVariantC = 11.99;

  // Experiment Traffic Distribution
  static const double timingVariantATraffic = 0.25; // Immediate
  static const double timingVariantBTraffic = 0.50; // First Insight (default)
  static const double timingVariantCTraffic = 0.25; // Delayed

  static const double pricingVariantATraffic = 0.50; // $7.99
  static const double pricingVariantBTraffic = 0.30; // $9.99
  static const double pricingVariantCTraffic = 0.20; // $11.99

  // Churn Defense Thresholds
  static const double churnWarningThreshold = 0.07; // 7%
  static const double churnCriticalThreshold = 0.10; // 10%
  static const double mrrDropWarningThreshold = 0.05; // 5% week-over-week
  static const double refundSurgeThreshold = 0.03; // 3% in 24h

  // Paywall Cooldown (during churn defense)
  static const Duration paywallCooldown = Duration(hours: 48);

  // AdMob IDs (Production) - Replace with your actual IDs
  static const String admobAppIdAndroid =
      'ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX';
  static const String admobAppIdIos = 'ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX';
  static const String admobBannerIdAndroid =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String admobBannerIdIos =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String admobInterstitialIdAndroid =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String admobInterstitialIdIos =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String admobRewardedIdAndroid =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const String admobRewardedIdIos =
      'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

  // Storage keys
  static const String userProfileKey = 'user_profile';
  static const String savedChartsKey = 'saved_charts';
  static const String settingsKey = 'app_settings';
  static const String onboardingCompleteKey = 'onboarding_complete';

  // Animation durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Spacing
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 24;
  static const double spacingXxl = 32;
  static const double spacingHuge = 48;

  // Border radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 999;
}
