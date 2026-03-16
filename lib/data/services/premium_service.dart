import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../providers/app_providers.dart';
import 'ad_service.dart';
import 'analytics_service.dart';
import 'l10n_service.dart';
import 'notification_service.dart';
import 'referral_service.dart';
import 'storage_service.dart';

/// Premium subscription tiers
enum PremiumTier { free, monthly, yearly, lifetime }

extension PremiumTierExtension on PremiumTier {
  String get displayName => localizedDisplayName(AppLanguage.en);

  String localizedDisplayName(AppLanguage language) {
    final key = 'premium.tiers.$name.name';
    final localized = L10nService.get(key, language);
    if (localized != key) return localized;
    // Fallback
    switch (this) {
      case PremiumTier.free:
        return 'Free';
      case PremiumTier.monthly:
        return 'Monthly Premium';
      case PremiumTier.yearly:
        return 'Yearly Premium';
      case PremiumTier.lifetime:
        return 'Lifetime Premium';
    }
  }

  /// Hardcoded fallback prices (used when RevenueCat products aren't loaded)
  String get price {
    switch (this) {
      case PremiumTier.free:
        return '\$0';
      case PremiumTier.monthly:
        return '\$7.99/mo';
      case PremiumTier.yearly:
        return '\$29.99/yr';
      case PremiumTier.lifetime:
        return '\$79.99';
    }
  }

  /// Monthly equivalent price for display (e.g. "$2.50/mo" for yearly)
  String get monthlyEquivalent {
    switch (this) {
      case PremiumTier.free:
        return '\$0';
      case PremiumTier.monthly:
        return '\$7.99/mo';
      case PremiumTier.yearly:
        return '\$2.50/mo';
      case PremiumTier.lifetime:
        return '\$79.99';
    }
  }

  String get savings => localizedSavings(AppLanguage.en);

  String localizedSavings(AppLanguage language) {
    final key = 'premium.tiers.$name.savings';
    final localized = L10nService.get(key, language);
    if (localized != key) return localized;
    // Fallback
    switch (this) {
      case PremiumTier.free:
        return '';
      case PremiumTier.monthly:
        return '';
      case PremiumTier.yearly:
        return 'Save 69% — just \$2.50/mo';
      case PremiumTier.lifetime:
        return 'Pay once, yours forever';
    }
  }

  List<String> get features => localizedFeatures(AppLanguage.en);

  List<String> localizedFeatures(AppLanguage language) {
    final key = 'premium.tiers.$name.features';
    final localized = L10nService.getList(key, language);
    if (localized.isNotEmpty && localized.first != key) return localized;
    // Fallback
    switch (this) {
      case PremiumTier.free:
        return [
          'Daily reflection insights',
          'Basic journal features',
          'Dream journal',
          'Ad-supported',
        ];
      case PremiumTier.monthly:
      case PremiumTier.yearly:
      case PremiumTier.lifetime:
        return [
          'Full pattern analysis & recurrence detection',
          'All 5 dream interpretation perspectives',
          'Ad-free reflection space',
          'Monthly & yearly growth reports',
          'Unlimited export (CSV, JSON)',
          'Premium programs, challenges & tools',
        ];
    }
  }

  String get productId {
    switch (this) {
      case PremiumTier.free:
        return '';
      case PremiumTier.monthly:
        return AppConstants.monthlyProductId;
      case PremiumTier.yearly:
        return AppConstants.yearlyProductId;
      case PremiumTier.lifetime:
        return AppConstants.lifetimeProductId;
    }
  }
}

/// Premium subscription state
class PremiumState {
  final bool isPremium;
  final PremiumTier tier;
  final DateTime? expiryDate;
  final bool isLoading;
  final String? errorMessage;
  final List<StoreProduct> availableProducts;
  final CustomerInfo? customerInfo;
  final bool isLifetime;

  const PremiumState({
    this.isPremium = false,
    this.tier = PremiumTier.free,
    this.expiryDate,
    this.isLoading = false,
    this.errorMessage,
    this.availableProducts = const [],
    this.customerInfo,
    this.isLifetime = false,
  });

  PremiumState copyWith({
    bool? isPremium,
    PremiumTier? tier,
    DateTime? expiryDate,
    bool? isLoading,
    String? errorMessage,
    List<StoreProduct>? availableProducts,
    CustomerInfo? customerInfo,
    bool? isLifetime,
  }) {
    return PremiumState(
      isPremium: isPremium ?? this.isPremium,
      tier: tier ?? this.tier,
      expiryDate: expiryDate ?? this.expiryDate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      availableProducts: availableProducts ?? this.availableProducts,
      customerInfo: customerInfo ?? this.customerInfo,
      isLifetime: isLifetime ?? this.isLifetime,
    );
  }
}

/// Premium service notifier using Notifier (Riverpod 2.0+)
class PremiumNotifier extends Notifier<PremiumState> {
  static bool _isInitialized = false;

  @override
  PremiumState build() {
    _initializeRevenueCat();
    return const PremiumState(isLoading: true);
  }

  AdService get _adService => ref.read(adServiceProvider);
  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);

  /// Check if RevenueCat is initialized
  bool get isRevenueCatInitialized => _isInitialized;

  /// Initialize RevenueCat SDK
  Future<void> _initializeRevenueCat() async {
    if (_isInitialized) {
      await _checkSubscriptionStatus();
      return;
    }

    try {
      if (kIsWeb) {
        // RevenueCat not supported on web, use local storage fallback
        await _loadLocalPremiumStatus();
        return;
      }

      String apiKey;
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        apiKey = AppConstants.revenueCatAppleApiKey;
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        apiKey = AppConstants.revenueCatGoogleApiKey;
      } else {
        await _loadLocalPremiumStatus();
        return;
      }

      // Skip if no API key configured
      if (apiKey.isEmpty) {
        if (kDebugMode) {
          debugPrint('RevenueCat: No API key configured, using local storage');
        }
        await _loadLocalPremiumStatus();
        return;
      }

      // Enable debug logging in debug builds (must be set before configure)
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      // Configure RevenueCat with modern options
      final configuration = PurchasesConfiguration(apiKey)
        ..entitlementVerificationMode = EntitlementVerificationMode.informational
        ..diagnosticsEnabled = true;
      await Purchases.configure(configuration);
      _isInitialized = true;

      if (kDebugMode) {
        final isTestKey = apiKey == 'test_DhLsHPPYcGYaPHRXHVYBczvPSgI';
        debugPrint('RevenueCat: SDK initialized (${isTestKey ? "TEST/sandbox" : "production"} key)');
      }

      // Listen for customer info updates
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        _handleCustomerInfoUpdate(customerInfo);
      });

      await _checkSubscriptionStatus();
      await _fetchAvailableProducts();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('RevenueCat initialization error: $e');
      }
      await _loadLocalPremiumStatus();
    }
  }

  /// Check current subscription status
  /// This is the core entitlement guardrail - always verifies from source
  Future<void> _checkSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      _handleCustomerInfoUpdate(customerInfo);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error checking subscription: $e');
      }
      // GUARDRAIL: On error, default to cached state but never unlock
      // If we can't verify, don't change premium status
      state = state.copyWith(isLoading: false);
    }
  }

  /// Foreground check - call when app returns from background
  /// GUARDRAIL: Re-verify entitlement when app becomes active
  Future<void> onAppResumed() async {
    if (!_isInitialized || kIsWeb) return;

    if (kDebugMode) {
      debugPrint('PremiumService: App resumed - verifying entitlement');
    }

    await _checkSubscriptionStatus();
  }

  /// Verify entitlement before granting premium features
  /// GUARDRAIL: Double-check before premium action
  Future<bool> verifyEntitlementForFeature() async {
    if (!_isInitialized || kIsWeb) {
      return state.isPremium;
    }

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final entitlement =
          customerInfo.entitlements.all[AppConstants.entitlementId];
      return entitlement?.isActive ?? false;
    } catch (e) {
      // GUARDRAIL: On verification error, use cached state
      // But log for monitoring
      if (kDebugMode) {
        debugPrint('Entitlement verification error: $e');
      }
      return state.isPremium;
    }
  }

  /// Check if subscription has expired
  /// GUARDRAIL: Handle expiry immediately
  bool _hasSubscriptionExpired() {
    if (state.isLifetime) return false;
    if (state.expiryDate == null) return false;
    return state.expiryDate!.isBefore(DateTime.now());
  }

  /// Handle subscription expiry
  /// GUARDRAIL: Revert to free mode on expiry
  Future<void> checkAndHandleExpiry() async {
    if (_hasSubscriptionExpired()) {
      if (kDebugMode) {
        debugPrint('PremiumService: Subscription expired - reverting to free');
      }

      final previousTier = state.tier.name;
      final previousExpiry = state.expiryDate?.toIso8601String();

      await _clearPremium();

      _analytics.logEvent('subscription_expired', {
        'previous_tier': previousTier,
        'expiry_date': previousExpiry,
      });
    }
  }

  /// Handle customer info updates from RevenueCat
  void _handleCustomerInfoUpdate(CustomerInfo customerInfo) {
    final entitlement =
        customerInfo.entitlements.all[AppConstants.entitlementId];
    final isPremium = entitlement?.isActive ?? false;

    PremiumTier tier = PremiumTier.free;
    DateTime? expiryDate;
    bool isLifetime = false;

    if (isPremium && entitlement != null) {
      // Determine tier based on product
      final productId = entitlement.productIdentifier;
      if (productId == AppConstants.lifetimeProductId) {
        tier = PremiumTier.lifetime;
        isLifetime = true;
        // Lifetime has no expiry
      } else if (productId == AppConstants.yearlyProductId) {
        tier = PremiumTier.yearly;
      } else if (productId == AppConstants.monthlyProductId) {
        tier = PremiumTier.monthly;
      } else {
        // Default to monthly for unknown products
        tier = PremiumTier.monthly;
      }

      // Get expiry date (null for lifetime)
      final expirationStr = entitlement.expirationDate;
      if (!isLifetime && expirationStr != null) {
        expiryDate = DateTime.tryParse(expirationStr);
      }
    }

    state = PremiumState(
      isPremium: isPremium,
      tier: tier,
      expiryDate: expiryDate,
      isLoading: false,
      availableProducts: state.availableProducts,
      customerInfo: customerInfo,
      isLifetime: isLifetime,
    );

    // Sync with AdService
    unawaited(_adService.setPremiumStatus(isPremium));

    // Save to local storage as backup
    unawaited(
      _savePremiumStatusLocally(isPremium, tier, expiryDate, isLifetime),
    );

    // Schedule pre-expiry renewal nudge notifications
    if (isPremium && expiryDate != null && !isLifetime) {
      unawaited(
        NotificationService().schedulePremiumExpiryReminders(
          expiryDate: expiryDate,
        ),
      );
    } else {
      unawaited(NotificationService().cancelPremiumExpiryReminders());
    }

    if (kDebugMode) {
      debugPrint(
        'RevenueCat: Premium status updated - isPremium: $isPremium, tier: ${tier.name}, isLifetime: $isLifetime',
      );
    }
  }

  /// Fetch available products from store
  Future<void> _fetchAvailableProducts() async {
    try {
      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.current;

      if (currentOffering != null) {
        final products = currentOffering.availablePackages
            .map((p) => p.storeProduct)
            .toList();

        state = state.copyWith(availableProducts: products);

        if (kDebugMode) {
          debugPrint('RevenueCat: Fetched ${products.length} products');
          for (final product in products) {
            debugPrint('  - ${product.identifier}: ${product.priceString}');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error fetching products: $e');
      }
    }
  }

  /// Present RevenueCat Paywall
  Future<PaywallResult> presentPaywall() async {
    if (kIsWeb || !_isInitialized) {
      if (kDebugMode) {
        debugPrint(
          'RevenueCat: Paywall not available on web or SDK not initialized',
        );
      }
      return PaywallResult.cancelled;
    }

    try {
      final result = await RevenueCatUI.presentPaywall();

      _analytics.logEvent('paywall_presented', {'result': result.name});

      // Refresh subscription status after paywall closes
      await _checkSubscriptionStatus();

      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error presenting paywall: $e');
      }
      return PaywallResult.error;
    }
  }

  /// Present RevenueCat Paywall only if user doesn't have entitlement
  Future<PaywallResult> presentPaywallIfNeeded() async {
    if (kIsWeb || !_isInitialized) {
      if (kDebugMode) {
        debugPrint(
          'RevenueCat: Paywall not available on web or SDK not initialized',
        );
      }
      return PaywallResult.cancelled;
    }

    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        AppConstants.entitlementId,
      );

      _analytics.logEvent('paywall_if_needed_presented', {
        'result': result.name,
      });

      // Refresh subscription status after paywall closes
      await _checkSubscriptionStatus();

      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error presenting paywall if needed: $e');
      }
      return PaywallResult.error;
    }
  }

  /// Present Customer Center for subscription management
  Future<void> presentCustomerCenter() async {
    if (kIsWeb || !_isInitialized) {
      if (kDebugMode) {
        debugPrint(
          'RevenueCat: Customer Center not available on web or SDK not initialized',
        );
      }
      return;
    }

    try {
      await RevenueCatUI.presentCustomerCenter();

      _analytics.logEvent('customer_center_presented', {});

      // Refresh subscription status after customer center closes
      await _checkSubscriptionStatus();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error presenting customer center: $e');
      }
    }
  }

  /// Purchase premium subscription
  Future<bool> purchasePremium(PremiumTier tier) async {
    final language = StorageService.loadLanguage();
    if (tier == PremiumTier.free) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      if (kIsWeb || !_isInitialized) {
        // Simulate purchase for web/development
        return await _simulatePurchase(tier);
      }

      // Find the product
      final offerings = await Purchases.getOfferings();
      final currentOffering = offerings.current;

      if (currentOffering == null) {
        throw Exception('No offerings available');
      }

      Package? packageToPurchase;
      for (final package in currentOffering.availablePackages) {
        if (package.storeProduct.identifier == tier.productId) {
          packageToPurchase = package;
          break;
        }
      }

      if (packageToPurchase == null) {
        throw Exception('Product not found: ${tier.productId}');
      }

      // Make purchase (v9: purchase() returns PurchaseResult with customerInfo)
      final purchaseResult = await Purchases.purchase(
        PurchaseParams.package(packageToPurchase),
      );
      _handleCustomerInfoUpdate(purchaseResult.customerInfo);

      // Log analytics
      _analytics.logPurchase(
        productId: tier.productId,
        tier: tier.name,
        success: true,
      );

      return state.isPremium;
    } on PurchasesErrorCode catch (e) {
      String errorMessage;
      switch (e) {
        case PurchasesErrorCode.purchaseCancelledError:
          errorMessage = L10nService.get('data.services.premium.purchase_cancelled', language);
          break;
        case PurchasesErrorCode.purchaseNotAllowedError:
          errorMessage = L10nService.get('data.services.premium.purchases_are_not_allowed_on_this_device', language);
          break;
        case PurchasesErrorCode.purchaseInvalidError:
          errorMessage = L10nService.get('data.services.premium.this_purchase_couldnt_be_completed', language);
          break;
        case PurchasesErrorCode.productNotAvailableForPurchaseError:
          errorMessage = L10nService.get('data.services.premium.this_product_is_not_available_right_now', language);
          break;
        case PurchasesErrorCode.networkError:
          errorMessage = L10nService.get('data.services.premium.could_not_connect_your_local_data_is_una', language);
          break;
        default:
          errorMessage = L10nService.get('data.services.premium.something_went_wrong_your_account_was_no', language);
      }

      state = state.copyWith(isLoading: false, errorMessage: errorMessage);

      _analytics.logPurchase(
        productId: tier.productId,
        tier: tier.name,
        success: false,
        error: errorMessage,
      );

      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Purchase error: $e');
      }
      final isEnFallback = StorageService.loadLanguage() == AppLanguage.en;
      state = state.copyWith(
        isLoading: false,
        errorMessage: isEnFallback
            ? 'Something went wrong. Your account was not charged.'
            : 'Bir hata oluştu. Hesabınızdan ücret alınmadı.',
      );

      _analytics.logPurchase(
        productId: tier.productId,
        tier: tier.name,
        success: false,
        error: e.toString(),
      );

      return false;
    }
  }

  /// Restore purchases
  Future<bool> restorePurchases() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      if (kIsWeb || !_isInitialized) {
        await _loadLocalPremiumStatus();
        return state.isPremium;
      }

      final customerInfo = await Purchases.restorePurchases();
      _handleCustomerInfoUpdate(customerInfo);

      _analytics.logEvent('restore_purchases', {
        'success': state.isPremium.toString(),
      });

      if (!state.isPremium) {
        final language = StorageService.loadLanguage();
        state = state.copyWith(
          errorMessage: L10nService.get('data.services.premium.no_purchases_found_to_restore', language),
        );
      }

      return state.isPremium;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Restore error: $e');
      }
      final language = StorageService.loadLanguage();
      state = state.copyWith(
        isLoading: false,
        errorMessage: L10nService.get('data.services.premium.couldnt_restore_purchases_please_try_aga', language),
      );
      return false;
    }
  }

  /// Get product price by tier
  String? getProductPrice(PremiumTier tier) {
    for (final product in state.availableProducts) {
      if (product.identifier == tier.productId) {
        return product.priceString;
      }
    }
    return null;
  }

  /// Get introductory offer price by tier
  String? getIntroPrice(PremiumTier tier) {
    for (final product in state.availableProducts) {
      if (product.identifier == tier.productId) {
        return product.introductoryPrice?.priceString;
      }
    }
    return null;
  }

  /// Get store product by tier
  StoreProduct? getStoreProduct(PremiumTier tier) {
    for (final product in state.availableProducts) {
      if (product.identifier == tier.productId) {
        return product;
      }
    }
    return null;
  }

  /// Cancel subscription (for testing)
  Future<void> cancelSubscription() async {
    await _clearPremium();
  }

  /// Log in user to RevenueCat (for user identification)
  Future<void> loginUser(String userId) async {
    if (kIsWeb || !_isInitialized) return;

    try {
      final loginResult = await Purchases.logIn(userId);
      _handleCustomerInfoUpdate(loginResult.customerInfo);

      if (kDebugMode) {
        debugPrint('RevenueCat: Logged in user $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('RevenueCat login error: $e');
      }
    }
  }

  /// Log out user from RevenueCat
  Future<void> logoutUser() async {
    if (kIsWeb || !_isInitialized) return;

    try {
      final customerInfo = await Purchases.logOut();
      _handleCustomerInfoUpdate(customerInfo);

      if (kDebugMode) {
        debugPrint('RevenueCat: Logged out user');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('RevenueCat logout error: $e');
      }
    }
  }

  // Private helper methods

  Future<void> _loadLocalPremiumStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isPremium = prefs.getBool('is_premium') ?? false;
      final tierIndex = prefs.getInt('premium_tier') ?? 0;
      final expiryTimestamp = prefs.getInt('premium_expiry');
      final isLifetime = prefs.getBool('is_lifetime') ?? false;

      DateTime? expiryDate;
      if (expiryTimestamp != null && !isLifetime) {
        expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
        if (expiryDate.isBefore(DateTime.now())) {
          await _clearPremium();
          return;
        }
      }

      state = PremiumState(
        isPremium: isPremium,
        tier: PremiumTier
            .values[tierIndex.clamp(0, PremiumTier.values.length - 1)],
        expiryDate: expiryDate,
        isLoading: false,
        isLifetime: isLifetime,
      );

      await _adService.setPremiumStatus(isPremium);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading local premium status: $e');
      }
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _savePremiumStatusLocally(
    bool isPremium,
    PremiumTier tier,
    DateTime? expiryDate,
    bool isLifetime,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', isPremium);
    await prefs.setInt('premium_tier', tier.index);
    await prefs.setBool('is_lifetime', isLifetime);
    if (expiryDate != null) {
      await prefs.setInt('premium_expiry', expiryDate.millisecondsSinceEpoch);
    } else {
      await prefs.remove('premium_expiry');
    }
  }

  Future<void> _clearPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', false);
    await prefs.setInt('premium_tier', 0);
    await prefs.setBool('is_lifetime', false);
    await prefs.remove('premium_expiry');
    await _adService.setPremiumStatus(false);

    state = const PremiumState(
      isPremium: false,
      tier: PremiumTier.free,
      isLoading: false,
      isLifetime: false,
    );
  }

  Future<bool> _simulatePurchase(PremiumTier tier) async {
    // Simulate for development/web
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    DateTime? expiryDate;
    bool isLifetime = false;

    switch (tier) {
      case PremiumTier.monthly:
        expiryDate = DateTime(now.year, now.month + 1, now.day);
        break;
      case PremiumTier.yearly:
        expiryDate = DateTime(now.year + 1, now.month, now.day);
        break;
      case PremiumTier.lifetime:
        isLifetime = true;
        // No expiry for lifetime
        break;
      case PremiumTier.free:
        return false;
    }

    await _savePremiumStatusLocally(true, tier, expiryDate, isLifetime);
    await _adService.setPremiumStatus(true);

    state = PremiumState(
      isPremium: true,
      tier: tier,
      expiryDate: expiryDate,
      isLoading: false,
      isLifetime: isLifetime,
    );

    return true;
  }
}

/// Premium state provider
final premiumProvider = NotifierProvider<PremiumNotifier, PremiumState>(() {
  return PremiumNotifier();
});

/// Quick access to premium status (RevenueCat OR referral reward)
final isPremiumUserProvider = Provider<bool>((ref) {
  final revenueCatPremium = ref.watch(premiumProvider).isPremium;
  if (revenueCatPremium) return true;

  // Check referral premium (7-day rewards from invite codes)
  final referralAsync = ref.watch(referralServiceProvider);
  final hasReferralPremium =
      referralAsync.whenOrNull(data: (s) => s.hasReferralPremium) ?? false;
  return hasReferralPremium;
});

// isLifetimeUserProvider removed (unused)
