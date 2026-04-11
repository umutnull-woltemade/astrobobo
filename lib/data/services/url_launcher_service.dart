import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import 'analytics_service.dart';

/// Service for launching external URLs and app store actions
class UrlLauncherService {
  final AnalyticsService _analytics;

  UrlLauncherService(this._analytics);

  /// Launch a URL in external browser
  Future<bool> launchUrl(String url, {String? source}) async {
    try {
      final uri = Uri.parse(url);
      final canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        final launched = await launchUrl2(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched && source != null) {
          _analytics.logEvent('url_launched', {'url': url, 'source': source});
        }

        return launched;
      }

      if (kDebugMode) {
        debugPrint('UrlLauncherService: Cannot launch URL - $url');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('UrlLauncherService: Error launching URL - $e');
      }
      return false;
    }
  }

  /// Open privacy policy
  Future<bool> openPrivacyPolicy() async {
    _analytics.logEvent('privacy_policy_opened');
    return launchUrl(AppConstants.privacyPolicyUrl, source: 'settings');
  }

  /// Open terms of service
  Future<bool> openTermsOfService() async {
    _analytics.logEvent('terms_of_service_opened');
    return launchUrl(AppConstants.termsOfServiceUrl, source: 'settings');
  }

  /// Open support email
  Future<bool> openSupportEmail({String? subject, String? body}) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.supportEmail,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    _analytics.logEvent('support_email_opened');

    try {
      return await launchUrl2(emailUri);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('UrlLauncherService: Error opening email - $e');
      }
      return false;
    }
  }

  /// Request app store review
  Future<bool> requestAppReview() async {
    try {
      final InAppReview inAppReview = InAppReview.instance;
      final isAvailable = await inAppReview.isAvailable();

      if (isAvailable) {
        await inAppReview.requestReview();
        _analytics.logEvent('in_app_review_requested');
        return true;
      } else {
        // Fall back to opening store page
        return openAppStorePage();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('UrlLauncherService: Error requesting review - $e');
      }
      return openAppStorePage();
    }
  }

  /// Open app store page directly
  Future<bool> openAppStorePage() async {
    // Web'de store yok
    if (kIsWeb) return false;

    try {
      final InAppReview inAppReview = InAppReview.instance;

      String? appStoreId;
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        appStoreId = AppConstants.appStoreId;
      }

      await inAppReview.openStoreListing(appStoreId: appStoreId);
      _analytics.logEvent('app_store_opened');
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('UrlLauncherService: Error opening store - $e');
      }

      // Fallback to URL-based store links
      return _openStoreFallback();
    }
  }

  Future<bool> _openStoreFallback() async {
    // Web doesn't have a store
    if (kIsWeb) return false;

    try {
      String storeUrl;

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        if (AppConstants.appStoreId.isNotEmpty) {
          storeUrl = 'https://apps.apple.com/app/id${AppConstants.appStoreId}';
        } else {
          return false;
        }
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        storeUrl =
            'https://play.google.com/store/apps/details?id=${AppConstants.playStoreId}';
      } else {
        return false;
      }

      return launchUrl(storeUrl, source: 'store_fallback');
    } catch (_) {
      return false;
    }
  }

  /// Share app link
  Future<String> getAppShareLink() async {
    // Web'de platform kontrolü yapamayız
    if (kIsWeb) return 'https://venusone.com';

    try {
      if (defaultTargetPlatform == TargetPlatform.iOS &&
          AppConstants.appStoreId.isNotEmpty) {
        return 'https://apps.apple.com/app/id${AppConstants.appStoreId}';
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return 'https://play.google.com/store/apps/details?id=${AppConstants.playStoreId}';
      }
    } catch (_) {
      // Platform erişimi başarısız
    }
    return 'https://venusone.com';
  }
}

// Helper to use url_launcher's launchUrl with different name
Future<bool> launchUrl2(
  Uri uri, {
  LaunchMode mode = LaunchMode.platformDefault,
}) async {
  return launchUrl(uri, mode: mode);
}

/// URL Launcher service provider
final urlLauncherServiceProvider = Provider<UrlLauncherService>((ref) {
  final analytics = ref.watch(analyticsServiceProvider);
  return UrlLauncherService(analytics);
});
