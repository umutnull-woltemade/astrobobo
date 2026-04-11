import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/premium_service.dart';
import '../../../data/services/paywall_service.dart';
import '../../../shared/widgets/cosmic_background.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  PremiumTier _selectedTier = PremiumTier.yearly;
  bool _useRevenueCatPaywall = true; // Default to RevenueCat Paywall

  @override
  Widget build(BuildContext context) {
    final premiumState = ref.watch(premiumProvider);

    // If user is already premium, show their status
    if (premiumState.isPremium) {
      return _buildPremiumActiveScreen(context, premiumState);
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  _buildHeader(context),
                  const SizedBox(height: AppConstants.spacingXl),

                  // Premium badge
                  _buildPremiumBadge(),
                  const SizedBox(height: AppConstants.spacingXl),

                  // Paywall toggle (for testing - can be removed in production)
                  if (kDebugMode) ...[
                    _buildPaywallToggle(context),
                    const SizedBox(height: AppConstants.spacingMd),
                  ],

                  if (_useRevenueCatPaywall) ...[
                    // RevenueCat Paywall Button
                    _buildRevenueCatPaywallButton(context, premiumState),
                  ] else ...[
                    // Custom UI
                    // Features list
                    _buildFeaturesList(context),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Plan selection
                    _buildPlanSelection(context),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Purchase button
                    _buildPurchaseButton(context, premiumState),
                  ],

                  const SizedBox(height: AppConstants.spacingMd),

                  // Restore purchases
                  _buildRestoreButton(context, premiumState),
                  const SizedBox(height: AppConstants.spacingLg),

                  // Terms
                  _buildTerms(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumActiveScreen(
    BuildContext context,
    PremiumState premiumState,
  ) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              children: [
                _buildHeader(context),
                const Spacer(),
                _buildPremiumActiveBadge(premiumState),
                const SizedBox(height: AppConstants.spacingXl),
                _buildPremiumStatus(context, premiumState),
                const SizedBox(height: AppConstants.spacingXl),
                _buildManageSubscriptionButton(context),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumActiveBadge(PremiumState premiumState) {
    return Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.starGold.withOpacity(0.4),
                AppColors.auroraStart.withOpacity(0.4),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.starGold.withOpacity(0.5),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('👑', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 8),
              Text(
                premiumState.tier.displayName,
                style: const TextStyle(
                  color: AppColors.starGold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut);
  }

  Widget _buildPremiumStatus(BuildContext context, PremiumState premiumState) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            'Kozmik Güçler Aktif',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.starGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          if (premiumState.isLifetime)
            Text(
              'Ömür boyu erişiminiz var!',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            )
          else if (premiumState.expiryDate != null)
            Text(
              'Yenileme: ${_formatDate(premiumState.expiryDate!)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildManageSubscriptionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          await ref.read(paywallServiceProvider).presentCustomerCenter();
        },
        icon: const Icon(Icons.settings, color: AppColors.starGold),
        label: const Text(
          'Aboneliği Yönet',
          style: TextStyle(color: AppColors.starGold),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.starGold),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: AppColors.textPrimary),
            ),
            const Spacer(),
          ],
        ),
        Text(
          'umutnull Pro',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.starGold,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 8),
        Text(
          'Kozmik yolculuğunuzu sınırsız deneyimleyin',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.starGold.withOpacity(0.3),
                AppColors.auroraStart.withOpacity(0.3),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.starGold.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Text('✨', style: TextStyle(fontSize: 64)),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut);
  }

  Widget _buildPaywallToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.science, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'RevenueCat Paywall',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.orange),
            ),
          ),
          Switch(
            value: _useRevenueCatPaywall,
            onChanged: (value) => setState(() => _useRevenueCatPaywall = value),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCatPaywallButton(
    BuildContext context,
    PremiumState premiumState,
  ) {
    return Column(
      children: [
        // Features preview
        _buildFeaturesList(context),
        const SizedBox(height: AppConstants.spacingXl),

        // Show RevenueCat Paywall button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.starGold, Color(0xFFFFA500)],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: AppColors.starGold.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: premiumState.isLoading
                    ? null
                    : () async {
                        final result = await ref
                            .read(paywallServiceProvider)
                            .presentPaywall();
                        if (mounted && result == PaywallResult.purchased) {
                          _showSuccessDialog();
                        }
                      },
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: premiumState.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.black, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Planları Görüntüle',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = PremiumTier.yearly.features;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kozmik Güçler',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.starGold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...features.map((feature) => _FeatureItem(feature: feature)),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildPlanSelection(BuildContext context) {
    return Column(
      children: [
        // Best value - Yearly
        _PlanCard(
          tier: PremiumTier.yearly,
          isSelected: _selectedTier == PremiumTier.yearly,
          onTap: () => setState(() => _selectedTier = PremiumTier.yearly),
          isBestValue: true,
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Monthly
        _PlanCard(
          tier: PremiumTier.monthly,
          isSelected: _selectedTier == PremiumTier.monthly,
          onTap: () => setState(() => _selectedTier = PremiumTier.monthly),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Lifetime
        _PlanCard(
          tier: PremiumTier.lifetime,
          isSelected: _selectedTier == PremiumTier.lifetime,
          onTap: () => setState(() => _selectedTier = PremiumTier.lifetime),
          isLifetime: true,
        ),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildPurchaseButton(BuildContext context, PremiumState premiumState) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.starGold, Color(0xFFFFA500)],
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          boxShadow: [
            BoxShadow(
              color: AppColors.starGold.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: premiumState.isLoading
                ? null
                : () async {
                    final success = await ref
                        .read(premiumProvider.notifier)
                        .purchasePremium(_selectedTier);
                    if (success && mounted) {
                      _showSuccessDialog();
                    }
                  },
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: premiumState.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Kozmik Kapıyı Aç - ${_selectedTier.price}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  Widget _buildRestoreButton(BuildContext context, PremiumState premiumState) {
    return TextButton(
      onPressed: premiumState.isLoading
          ? null
          : () async {
              final restored = await ref
                  .read(premiumProvider.notifier)
                  .restorePurchases();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      restored
                          ? 'Satın alımlar geri yüklendi!'
                          : 'Geri yüklenecek satın alım bulunamadı.',
                    ),
                    backgroundColor: restored
                        ? AppColors.success
                        : AppColors.error,
                  ),
                );
              }
            },
      child: Text(
        'Satın Alımları Geri Yükle',
        style: TextStyle(
          color: AppColors.textSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildTerms(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      child: Text(
        'Satın alma işlemi, onaylandıktan sonra iTunes/Google Play hesabınızdan tahsil edilecektir. Abonelik, mevcut dönemin bitiminden en az 24 saat önce otomatik yenileme kapatılmadığı sürece otomatik olarak yenilenir.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textMuted,
          fontSize: 10,
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Text('🌟', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Kozmik Kapı Açıldı!',
                style: TextStyle(color: AppColors.starGold),
              ),
            ),
          ],
        ),
        content: const Text(
          'Evrenin sırlarına tam erişim artık seninle. Yıldızların rehberliğinde sınırsız keşfe hazırsın.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close premium screen
            },
            child: const Text(
              'Yolculuğa Başla',
              style: TextStyle(color: AppColors.starGold),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String feature;

  const _FeatureItem({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.starGold.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.starGold, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PremiumTier tier;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isBestValue;
  final bool isLifetime;

  const _PlanCard({
    required this.tier,
    required this.isSelected,
    required this.onTap,
    this.isBestValue = false,
    this.isLifetime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.starGold.withOpacity(0.2),
                      AppColors.auroraStart.withOpacity(0.1),
                    ],
                  )
                : AppColors.cardGradient,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(
              color: isSelected
                  ? AppColors.starGold
                  : AppColors.textMuted.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.starGold
                              : AppColors.textMuted,
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.starGold
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.black,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tier.displayName,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: isSelected
                                          ? AppColors.starGold
                                          : AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              if (isLifetime) ...[
                                const SizedBox(width: 8),
                                const Text(
                                  '♾️',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ],
                          ),
                          if (tier.savings.isNotEmpty)
                            Text(
                              tier.savings,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: isLifetime
                                        ? AppColors.auroraEnd
                                        : AppColors.success,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      tier.price,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isSelected
                            ? AppColors.starGold
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isBestValue)
          Positioned(
            top: -10,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.starGold, Color(0xFFFFA500)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'En İyi Değer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (isLifetime)
          Positioned(
            top: -10,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.auroraStart, AppColors.auroraEnd],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Ömür Boyu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
