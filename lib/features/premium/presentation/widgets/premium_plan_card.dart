import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/liquid_glass/glass_panel.dart';
import '../../../../data/providers/app_providers.dart';
import '../../../../data/services/l10n_service.dart';
import '../../../../data/services/premium_service.dart';

class PremiumPlanCard extends StatelessWidget {
  final PremiumTier tier;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isBestValue;
  final String? priceOverride;
  final AppLanguage language;

  const PremiumPlanCard({
    super.key,
    required this.tier,
    required this.isSelected,
    required this.onTap,
    this.isBestValue = false,
    this.priceOverride,
    this.language = AppLanguage.en,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlassPanel(
          elevation: isSelected ? GlassElevation.g3 : GlassElevation.g2,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          padding: EdgeInsets.zero,
          glowColor: isSelected
              ? AppColors.starGold.withValues(alpha: 0.2)
              : null,
          child: Semantics(
            label:
                '${tier.localizedDisplayName(language)}${isSelected ? ' ${L10nService.get('common.selected', language)}' : ''}',
            button: true,
            selected: isSelected,
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
                            Text(
                              tier.localizedDisplayName(language),
                              style: AppTypography.modernAccent(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? AppColors.starGold
                                    : AppColors.textPrimary,
                              ),
                            ),
                            if (tier.savings.isNotEmpty)
                              Text(
                                tier.savings,
                                style: AppTypography.subtitle(
                                  fontSize: 12,
                                  color: AppColors.success,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            priceOverride ?? tier.price,
                            style: AppTypography.modernAccent(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.starGold
                                  : AppColors.textPrimary,
                            ),
                          ),
                          if (tier == PremiumTier.yearly)
                            Text(
                              tier.monthlyEquivalent,
                              style: AppTypography.subtitle(
                                fontSize: 11,
                                color: AppColors.starGold.withValues(alpha: 0.7),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isBestValue)
          Positioned(top: -10, right: 16, child: PremiumBestValueBadge()),
      ],
    );
  }
}

class PremiumBestValueBadge extends ConsumerWidget {
  const PremiumBestValueBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.starGold, AppColors.chartOrange],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        L10nService.get('premium.best_value', language),
        style: AppTypography.elegantAccent(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class PremiumFeatureItem extends StatelessWidget {
  final String feature;

  const PremiumFeatureItem({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.starGold.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.starGold, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: AppTypography.decorativeScript(
                fontSize: 15,
                color: AppColors.textPrimary,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroCountdownDigit extends StatelessWidget {
  final String value;
  final Color color;

  const IntroCountdownDigit(this.value, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        value,
        style: AppTypography.displayFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
