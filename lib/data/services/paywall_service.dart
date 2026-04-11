import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import '../../core/constants/app_constants.dart';
import 'analytics_service.dart';
import 'premium_service.dart';

/// Service for managing RevenueCat Paywalls
/// Provides methods to present paywalls, handle results, and track events
class PaywallService {
  final Ref _ref;

  PaywallService(this._ref);

  AnalyticsService get _analytics => _ref.read(analyticsServiceProvider);
  PremiumNotifier get _premiumNotifier => _ref.read(premiumProvider.notifier);

  /// Present the RevenueCat Paywall
  /// Returns the result of the paywall interaction
  Future<PaywallResult> presentPaywall({
    BuildContext? context,
    Offering? offering,
  }) async {
    if (kIsWeb) {
      if (kDebugMode) {
        debugPrint('PaywallService: Paywalls not supported on web');
      }
      return PaywallResult.cancelled;
    }

    if (!_premiumNotifier.isRevenueCatInitialized) {
      if (kDebugMode) {
        debugPrint('PaywallService: RevenueCat not initialized');
      }
      return PaywallResult.error;
    }

    try {
      _analytics.logEvent('paywall_opened', {
        'offering_id': offering?.identifier ?? 'default',
      });

      final result = await RevenueCatUI.presentPaywall(offering: offering);

      _handlePaywallResult(result);
      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PaywallService: Error presenting paywall: $e');
      }
      _analytics.logEvent('paywall_error', {'error': e.toString()});
      return PaywallResult.error;
    }
  }

  /// Present paywall only if user doesn't have the required entitlement
  /// More efficient as it checks entitlement before showing
  Future<PaywallResult> presentPaywallIfNeeded({
    String? requiredEntitlementIdentifier,
    Offering? offering,
  }) async {
    if (kIsWeb) {
      if (kDebugMode) {
        debugPrint('PaywallService: Paywalls not supported on web');
      }
      return PaywallResult.cancelled;
    }

    if (!_premiumNotifier.isRevenueCatInitialized) {
      if (kDebugMode) {
        debugPrint('PaywallService: RevenueCat not initialized');
      }
      return PaywallResult.error;
    }

    final entitlementId =
        requiredEntitlementIdentifier ?? AppConstants.entitlementId;

    try {
      _analytics.logEvent('paywall_if_needed_triggered', {
        'entitlement_id': entitlementId,
        'offering_id': offering?.identifier ?? 'default',
      });

      final result = await RevenueCatUI.presentPaywallIfNeeded(
        entitlementId,
        offering: offering,
      );

      _handlePaywallResult(result);
      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PaywallService: Error presenting paywall if needed: $e');
      }
      _analytics.logEvent('paywall_if_needed_error', {'error': e.toString()});
      return PaywallResult.error;
    }
  }

  /// Present the Customer Center for subscription management
  Future<void> presentCustomerCenter() async {
    if (kIsWeb) {
      if (kDebugMode) {
        debugPrint('PaywallService: Customer Center not supported on web');
      }
      return;
    }

    if (!_premiumNotifier.isRevenueCatInitialized) {
      if (kDebugMode) {
        debugPrint('PaywallService: RevenueCat not initialized');
      }
      return;
    }

    try {
      _analytics.logEvent('customer_center_opened', {});
      await RevenueCatUI.presentCustomerCenter();
      _analytics.logEvent('customer_center_closed', {});
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PaywallService: Error presenting customer center: $e');
      }
      _analytics.logEvent('customer_center_error', {'error': e.toString()});
    }
  }

  /// Get the current offering for custom paywall display
  Future<Offering?> getCurrentOffering() async {
    if (kIsWeb || !_premiumNotifier.isRevenueCatInitialized) {
      return null;
    }

    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PaywallService: Error getting offering: $e');
      }
      return null;
    }
  }

  /// Get a specific offering by identifier
  Future<Offering?> getOffering(String identifier) async {
    if (kIsWeb || !_premiumNotifier.isRevenueCatInitialized) {
      return null;
    }

    try {
      final offerings = await Purchases.getOfferings();
      return offerings.getOffering(identifier);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PaywallService: Error getting offering $identifier: $e');
      }
      return null;
    }
  }

  /// Handle paywall result and log analytics
  void _handlePaywallResult(PaywallResult result) {
    switch (result) {
      case PaywallResult.purchased:
        _analytics.logEvent('paywall_purchase_success', {});
        if (kDebugMode) {
          debugPrint('PaywallService: Purchase successful');
        }
        break;
      case PaywallResult.restored:
        _analytics.logEvent('paywall_restore_success', {});
        if (kDebugMode) {
          debugPrint('PaywallService: Restore successful');
        }
        break;
      case PaywallResult.cancelled:
        _analytics.logEvent('paywall_cancelled', {});
        if (kDebugMode) {
          debugPrint('PaywallService: Paywall cancelled by user');
        }
        break;
      case PaywallResult.error:
        _analytics.logEvent('paywall_error_result', {});
        if (kDebugMode) {
          debugPrint('PaywallService: Paywall ended with error');
        }
        break;
      case PaywallResult.notPresented:
        _analytics.logEvent('paywall_not_presented', {});
        if (kDebugMode) {
          debugPrint(
            'PaywallService: Paywall not presented (user has entitlement)',
          );
        }
        break;
    }
  }
}

/// Provider for PaywallService
final paywallServiceProvider = Provider<PaywallService>((ref) {
  return PaywallService(ref);
});

/// Extension to easily show paywall from any widget
extension PaywallExtension on WidgetRef {
  /// Quick access to present paywall
  Future<PaywallResult> showPaywall({Offering? offering}) {
    return read(paywallServiceProvider).presentPaywall(offering: offering);
  }

  /// Quick access to present paywall if user doesn't have entitlement
  Future<PaywallResult> showPaywallIfNeeded({
    String? entitlementId,
    Offering? offering,
  }) {
    return read(paywallServiceProvider).presentPaywallIfNeeded(
      requiredEntitlementIdentifier: entitlementId,
      offering: offering,
    );
  }

  /// Quick access to present customer center
  Future<void> showCustomerCenter() {
    return read(paywallServiceProvider).presentCustomerCenter();
  }
}
