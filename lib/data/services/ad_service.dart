import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import 'analytics_service.dart';

/// Ad unit IDs configuration
class AdConfig {
  // Test IDs (for development)
  static const String testBannerId = 'ca-app-pub-3940256099942544/6300978111';
  static const String testInterstitialId =
      'ca-app-pub-3940256099942544/1033173712';
  static const String testRewardedId = 'ca-app-pub-3940256099942544/5224354917';

  // Use test ads in debug mode
  static bool get isTestMode => kDebugMode;

  static String get bannerId {
    if (isTestMode) return testBannerId;
    if (defaultTargetPlatform == TargetPlatform.android)
      return AppConstants.admobBannerIdAndroid;
    if (defaultTargetPlatform == TargetPlatform.iOS)
      return AppConstants.admobBannerIdIos;
    return testBannerId;
  }

  static String get interstitialId {
    if (isTestMode) return testInterstitialId;
    if (defaultTargetPlatform == TargetPlatform.android)
      return AppConstants.admobInterstitialIdAndroid;
    if (defaultTargetPlatform == TargetPlatform.iOS)
      return AppConstants.admobInterstitialIdIos;
    return testInterstitialId;
  }

  static String get rewardedId {
    if (isTestMode) return testRewardedId;
    if (defaultTargetPlatform == TargetPlatform.android)
      return AppConstants.admobRewardedIdAndroid;
    if (defaultTargetPlatform == TargetPlatform.iOS)
      return AppConstants.admobRewardedIdIos;
    return testRewardedId;
  }
}

/// Ad placement types for tracking
enum AdPlacement {
  horoscopeResult,
  birthChartResult,
  tarotResult,
  numerologyResult,
  compatibilityResult,
  auraResult,
  postAnalysis,
  premiumUnlock,
  homeScreen,
  settingsScreen,
}

/// AdService manages all ad operations
class AdService {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _isInterstitialReady = false;
  bool _isRewardedReady = false;
  int _analysisCount = 0;
  bool _isInitialized = false;

  // Show interstitial every N analyses
  static const int _interstitialFrequency = 3;

  // Premium status
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  // Analytics
  AnalyticsService? _analytics;

  /// Initialize the ad service
  Future<void> initialize({AnalyticsService? analytics}) async {
    if (_isInitialized) return;
    if (kIsWeb) return; // Ads not supported on web

    _analytics = analytics;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;

      // Configure test devices in debug mode
      if (kDebugMode) {
        MobileAds.instance.updateRequestConfiguration(
          RequestConfiguration(
            testDeviceIds: ['YOUR_TEST_DEVICE_ID'], // Add your test device IDs
          ),
        );
      }

      // Load premium status
      final prefs = await SharedPreferences.getInstance();
      _isPremium = prefs.getBool('is_premium') ?? false;

      if (!_isPremium) {
        _loadInterstitialAd();
        _loadRewardedAd();
      }

      _logAdEvent('ads_initialized', 'init');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdService: Initialization failed - $e');
      }
    }
  }

  /// Set premium status
  Future<void> setPremiumStatus(bool isPremium) async {
    _isPremium = isPremium;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', isPremium);

    if (isPremium) {
      // Dispose ads when user becomes premium
      _interstitialAd?.dispose();
      _rewardedAd?.dispose();
      _interstitialAd = null;
      _rewardedAd = null;
      _isInterstitialReady = false;
      _isRewardedReady = false;
    } else {
      // Reload ads when premium expires
      _loadInterstitialAd();
      _loadRewardedAd();
    }
  }

  /// Create a banner ad widget
  BannerAd createBannerAd({
    required AdSize size,
    required void Function(Ad) onAdLoaded,
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
    AdPlacement placement = AdPlacement.homeScreen,
  }) {
    return BannerAd(
      adUnitId: AdConfig.bannerId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _logAdEvent('banner', 'loaded', placement: placement);
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (ad, error) {
          _logAdEvent('banner', 'failed', placement: placement);
          onAdFailedToLoad(ad, error);
        },
        onAdOpened: (ad) =>
            _logAdEvent('banner', 'opened', placement: placement),
        onAdClosed: (ad) =>
            _logAdEvent('banner', 'closed', placement: placement),
        onAdImpression: (ad) =>
            _logAdEvent('banner', 'impression', placement: placement),
        onAdClicked: (ad) =>
            _logAdEvent('banner', 'clicked', placement: placement),
      ),
    );
  }

  /// Load interstitial ad
  void _loadInterstitialAd() {
    if (_isPremium || kIsWeb) return;

    InterstitialAd.load(
      adUnitId: AdConfig.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialReady = true;
          _logAdEvent('interstitial', 'loaded');

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              _logAdEvent('interstitial', 'showed');
            },
            onAdDismissedFullScreenContent: (ad) {
              _logAdEvent('interstitial', 'dismissed');
              ad.dispose();
              _isInterstitialReady = false;
              _loadInterstitialAd(); // Preload next
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              _logAdEvent('interstitial', 'show_failed');
              ad.dispose();
              _isInterstitialReady = false;
              _loadInterstitialAd();
            },
            onAdImpression: (ad) {
              _logAdEvent('interstitial', 'impression');
            },
            onAdClicked: (ad) {
              _logAdEvent('interstitial', 'clicked');
            },
          );
        },
        onAdFailedToLoad: (error) {
          _logAdEvent('interstitial', 'load_failed');
          _isInterstitialReady = false;
          // Retry after delay with exponential backoff
          Future.delayed(const Duration(seconds: 30), _loadInterstitialAd);
        },
      ),
    );
  }

  /// Load rewarded ad
  void _loadRewardedAd() {
    if (kIsWeb) return;

    RewardedAd.load(
      adUnitId: AdConfig.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedReady = true;
          _logAdEvent('rewarded', 'loaded');

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              _logAdEvent('rewarded', 'showed');
            },
            onAdDismissedFullScreenContent: (ad) {
              _logAdEvent('rewarded', 'dismissed');
              ad.dispose();
              _isRewardedReady = false;
              _loadRewardedAd(); // Preload next
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              _logAdEvent('rewarded', 'show_failed');
              ad.dispose();
              _isRewardedReady = false;
              _loadRewardedAd();
            },
            onAdImpression: (ad) {
              _logAdEvent('rewarded', 'impression');
            },
            onAdClicked: (ad) {
              _logAdEvent('rewarded', 'clicked');
            },
          );
        },
        onAdFailedToLoad: (error) {
          _logAdEvent('rewarded', 'load_failed');
          _isRewardedReady = false;
          // Retry after delay
          Future.delayed(const Duration(seconds: 30), _loadRewardedAd);
        },
      ),
    );
  }

  /// Show interstitial ad after analysis (respects frequency)
  Future<bool> showInterstitialAfterAnalysis() async {
    if (_isPremium || kIsWeb) return false;

    _analysisCount++;

    if (_analysisCount >= _interstitialFrequency && _isInterstitialReady) {
      _analysisCount = 0;
      await _interstitialAd?.show();
      return true;
    }

    return false;
  }

  /// Force show interstitial (for specific placements)
  Future<bool> showInterstitial(AdPlacement placement) async {
    if (_isPremium || kIsWeb) return false;

    if (_isInterstitialReady) {
      _logAdEvent('interstitial', 'show_requested', placement: placement);
      await _interstitialAd?.show();
      return true;
    }

    return false;
  }

  /// Show rewarded ad for premium feature unlock
  Future<bool> showRewardedAd({
    required void Function() onRewardEarned,
    AdPlacement placement = AdPlacement.premiumUnlock,
  }) async {
    if (kIsWeb) return false;

    if (_isRewardedReady && _rewardedAd != null) {
      _logAdEvent('rewarded', 'show_requested', placement: placement);

      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          _logAdEvent('rewarded', 'reward_earned', placement: placement);
          onRewardEarned();
        },
      );
      return true;
    }

    return false;
  }

  /// Check if rewarded ad is available
  bool get isRewardedAdReady => _isRewardedReady && !kIsWeb;

  /// Check if interstitial ad is ready
  bool get isInterstitialReady => _isInterstitialReady && !kIsWeb;

  /// Get remaining analyses before next interstitial
  int get analysesUntilInterstitial => _interstitialFrequency - _analysisCount;

  /// Dispose ads
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _interstitialAd = null;
    _rewardedAd = null;
  }

  void _logAdEvent(String adType, String action, {AdPlacement? placement}) {
    if (kDebugMode) {
      debugPrint('AdService: $adType $action ${placement?.name ?? ''}');
    }
    _analytics?.logAdEvent(adType, action, placement: placement?.name);
  }
}

/// AdService provider
final adServiceProvider = Provider<AdService>((ref) {
  final analytics = ref.watch(analyticsServiceProvider);
  final service = AdService();
  service.initialize(analytics: analytics);
  ref.onDispose(() => service.dispose());
  return service;
});

/// NOTE: isPremiumProvider is defined in premium_service.dart as the
/// canonical source. Use isPremiumUserProvider from premium_service.dart
/// instead of duplicating here.
