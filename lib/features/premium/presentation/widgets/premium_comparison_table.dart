import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/liquid_glass/glass_panel.dart';
import '../../../../data/providers/app_providers.dart';
import '../../../../data/services/l10n_service.dart';

class PremiumComparisonTable extends ConsumerWidget {
  const PremiumComparisonTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    final rows = [
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_journal', language),
        free: L10nService.get('premium.comparison.feature_journal_free', language),
        pro: L10nService.get('premium.comparison.feature_journal_pro', language),
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_dreams', language),
        free: L10nService.get('premium.comparison.feature_dreams_free', language),
        pro: L10nService.get('premium.comparison.feature_dreams_pro', language),
        isHighlight: true,
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_patterns', language),
        free: L10nService.get('premium.comparison.feature_patterns_free', language),
        pro: L10nService.get('premium.comparison.feature_patterns_pro', language),
        isHighlight: true,
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_reports', language),
        free: L10nService.get('premium.comparison.feature_reports_free', language),
        pro: L10nService.get('premium.comparison.feature_reports_pro', language),
        isHighlight: true,
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_export', language),
        free: L10nService.get('premium.comparison.feature_export_free', language),
        pro: L10nService.get('premium.comparison.feature_export_pro', language),
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_ads', language),
        free: L10nService.get('premium.comparison.feature_ads_free', language),
        pro: L10nService.get('premium.comparison.feature_ads_pro', language),
      ),
      _ComparisonRow(
        feature: L10nService.get('premium.comparison.feature_programs', language),
        free: L10nService.get('premium.comparison.feature_programs_free', language),
        pro: L10nService.get('premium.comparison.feature_programs_pro', language),
      ),
    ];

    return GlassPanel(
      elevation: GlassElevation.g2,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          Text(
            L10nService.get('premium.comparison.title', language),
            style: AppTypography.displayFont.copyWith(
              fontSize: 20,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          // Table header
          Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                flex: 2,
                child: Text(
                  L10nService.get('premium.tiers.free.name', language),
                  textAlign: TextAlign.center,
                  style: AppTypography.elegantAccent(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.starGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'PRO',
                    textAlign: TextAlign.center,
                    style: AppTypography.elegantAccent(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.starGold,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Table rows
          ...rows.map(
            (row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      row.feature,
                      style: AppTypography.subtitle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.free,
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.pro,
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle(
                        fontSize: 11,
                        color: row.isHighlight
                            ? AppColors.starGold
                            : AppColors.textPrimary,
                      ).copyWith(
                        fontWeight:
                            row.isHighlight ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms);
  }
}

class _ComparisonRow {
  final String feature;
  final String free;
  final String pro;
  final bool isHighlight;

  const _ComparisonRow({
    required this.feature,
    required this.free,
    required this.pro,
    this.isHighlight = false,
  });
}
