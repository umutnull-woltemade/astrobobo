import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/experiment_config.dart';
import '../../../data/services/experiment_service.dart';
import '../../../data/services/monetization_service.dart';
import '../../../data/services/premium_service.dart';
import 'widgets/paywall_benefit_item.dart';

/// Paywall colors - calm, premium aesthetic
class PaywallColors {
  static const Color background = Color(0xFF1A1A2E);
  static const Color cardBackground = Color(0xFF252541);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color accentGoldDark = Color(0xFFB8963B);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0B0);
}

/// Premium paywall screen with calm, female-aligned design
/// Supports A/B tested pricing variants
class PremiumPaywall extends ConsumerStatefulWidget {
  final VoidCallback? onDismiss;
  final VoidCallback? onPurchaseSuccess;

  const PremiumPaywall({super.key, this.onDismiss, this.onPurchaseSuccess});

  @override
  ConsumerState<PremiumPaywall> createState() => _PremiumPaywallState();

  /// Show paywall as a modal bottom sheet
  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PremiumPaywall(),
    );
  }

  /// Show paywall as a full screen dialog
  static Future<bool?> showFullScreen(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Dialog.fullscreen(
        backgroundColor: PaywallColors.background,
        child: PremiumPaywall(),
      ),
    );
  }
}

class _PremiumPaywallState extends ConsumerState<PremiumPaywall> {
  bool _isLoading = false;
  PricingVariant? _pricingVariant;

  @override
  void initState() {
    super.initState();
    _loadPricingVariant();
    _trackPaywallShown();
  }

  Future<void> _loadPricingVariant() async {
    final variant = await ref
        .read(experimentServiceProvider)
        .getPricingVariant();
    if (mounted) {
      setState(() => _pricingVariant = variant);
    }
  }

  Future<void> _trackPaywallShown() async {
    await ref.read(monetizationServiceProvider).onPaywallPresented();
  }

  Future<void> _handlePurchase() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final premiumNotifier = ref.read(premiumProvider.notifier);
      final monetization = ref.read(monetizationServiceProvider);

      // Use RevenueCat native paywall for actual purchase
      final result = await premiumNotifier.presentPaywall();

      if (result == PaywallResult.purchased ||
          result == PaywallResult.restored) {
        await monetization.onPurchaseSuccess(
          price: _pricingVariant?.price ?? 7.99,
          productId: _pricingVariant?.productId ?? 'monthly_799',
        );
        widget.onPurchaseSuccess?.call();
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      final monetization = ref.read(monetizationServiceProvider);
      await monetization.onPurchaseFailed(
        errorCode: e.toString(),
        productId: _pricingVariant?.productId ?? 'monthly_799',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleDismiss() {
    ref.read(monetizationServiceProvider).onPaywallDismissed();
    widget.onDismiss?.call();
    Navigator.of(context).pop(false);
  }

  Future<void> _openPrivacyPolicy() async {
    final uri = Uri.parse(AppConstants.privacyPolicyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openTermsOfService() async {
    final uri = Uri.parse(AppConstants.termsOfServiceUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: PaywallColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: PaywallColors.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Close button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: IconButton(
                  onPressed: _handleDismiss,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: PaywallColors.textSecondary,
                    size: 24,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, bottomPadding + 24),
              child: Column(
                children: [
                  // Icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          PaywallColors.accentGold.withValues(alpha: 0.2),
                          PaywallColors.accentGoldDark.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: PaywallColors.accentGold,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Unlock Your Full Journey',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: PaywallColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Experience astrology without interruption',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: PaywallColors.textSecondary,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Benefits
                  const PaywallBenefitItem(text: 'Ad-free, calm experience'),
                  const PaywallBenefitItem(text: 'Unlimited personal insights'),
                  const PaywallBenefitItem(text: 'Priority cosmic guidance'),

                  const SizedBox(height: 32),

                  // Primary CTA
                  _buildPrimaryCta(),

                  const SizedBox(height: 16),

                  // Secondary CTA
                  TextButton(
                    onPressed: _handleDismiss,
                    style: TextButton.styleFrom(
                      foregroundColor: PaywallColors.textSecondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Not now, maybe later',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Legal text
                  Text(
                    'Auto-renews monthly. Cancel anytime in Settings.',
                    style: TextStyle(
                      fontSize: 11,
                      color: PaywallColors.textSecondary.withValues(alpha: 0.7),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _openPrivacyPolicy,
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 11,
                            color: PaywallColors.textSecondary.withValues(
                              alpha: 0.7,
                            ),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        '  ·  ',
                        style: TextStyle(
                          fontSize: 11,
                          color: PaywallColors.textSecondary.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openTermsOfService,
                        child: Text(
                          'Terms of Use',
                          style: TextStyle(
                            fontSize: 11,
                            color: PaywallColors.textSecondary.withValues(
                              alpha: 0.7,
                            ),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryCta() {
    final priceDisplay = _pricingVariant?.formattedPrice ?? '\$7.99/month';

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PaywallColors.accentGold, PaywallColors.accentGoldDark],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: PaywallColors.accentGold.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handlePurchase,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: PaywallColors.background,
                      strokeWidth: 2.5,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Continue with Pro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PaywallColors.background,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        priceDisplay,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: PaywallColors.background.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Retention message dialog for critical churn defense
class RetentionMessageDialog extends StatelessWidget {
  const RetentionMessageDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const RetentionMessageDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: PaywallColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: PaywallColors.accentGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: PaywallColors.accentGold,
                size: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We'll be here",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PaywallColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Take all the time you need. Your journey continues whenever you're ready.",
              style: TextStyle(
                fontSize: 14,
                color: PaywallColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: PaywallColors.accentGold.withValues(
                    alpha: 0.15,
                  ),
                  foregroundColor: PaywallColors.accentGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
