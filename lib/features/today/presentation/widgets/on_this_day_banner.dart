import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../data/services/network_retry.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/liquid_glass/glass_animations.dart';
import '../../../../data/providers/app_providers.dart';
import '../../../../shared/widgets/premium_card.dart';
import '../../../../shared/widgets/tap_scale.dart';
import '../../../../shared/widgets/share_card_sheet.dart';
import '../../../../shared/widgets/share_nudge_chip.dart';
import '../../../../data/content/share_card_templates.dart';
import '../../../../data/services/l10n_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnThisDayBanner extends ConsumerStatefulWidget {
  final AppLanguage language;
  final bool isDark;

  const OnThisDayBanner({
    super.key,
    required this.language,
    required this.isDark,
  });

  @override
  ConsumerState<OnThisDayBanner> createState() => _OnThisDayBannerState();
}

class _OnThisDayBannerState extends ConsumerState<OnThisDayBanner> {
  String? _aiReflection;

  AppLanguage get language => widget.language;

  @override
  void initState() {
    super.initState();
    _loadAIReflection();
  }

  Future<void> _loadAIReflection() async {
    try {
      final journalAsync = ref.read(journalServiceProvider);
      final service = journalAsync.valueOrNull;
      if (service == null) return;

      final allEntries = service.getAllEntries();
      final now = DateTime.now();
      final onThisDayEntries = allEntries.where((e) {
        return e.date.month == now.month &&
            e.date.day == now.day &&
            e.date.year < now.year;
      }).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      if (onThisDayEntries.isEmpty) return;

      final entry = onThisDayEntries.first;
      final yearsAgo = now.year - entry.date.year;
      final langCode = widget.language == AppLanguage.en ? 'en' : 'tr';

      // Get current focus trend from pattern engine
      String currentFocus = '';
      String currentTrend = '';
      try {
        final engineAsync = ref.read(patternEngineServiceProvider);
        final engine = engineAsync.valueOrNull;
        if (engine != null) {
          final monthSummary = engine.getMonthSummary(now.year, now.month);
          currentFocus = monthSummary.weakestArea?.name ?? '';
          final trends = engine.detectTrends();
          if (trends.isNotEmpty) {
            currentTrend = trends.first.direction.name;
          }
        }
      } catch (_) {}

      final client = Supabase.instance.client;
      final response = await retryWithBackoff(
        () => client.functions.invoke(
          'on-this-day-reflection',
          body: {
            'pastNote': entry.note ?? '',
            'pastFocusArea': entry.focusArea.name,
            'pastRating': entry.overallRating,
            'yearsAgo': yearsAgo,
            'currentFocusArea': currentFocus,
            'currentMoodTrend': currentTrend,
            'language': langCode,
          },
        ),
        maxAttempts: 2,
        timeout: const Duration(seconds: 15),
      ).timeout(const Duration(seconds: 5));

      if (response.status == 200 && mounted) {
        final data = response.data is String
            ? json.decode(response.data as String) as Map<String, dynamic>
            : response.data as Map<String, dynamic>;
        final reflection = data['reflection'] as String?;
        if (reflection != null && reflection.isNotEmpty) {
          setState(() => _aiReflection = reflection);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('AI On This Day reflection best-effort: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.language == AppLanguage.en;
    final journalAsync = ref.watch(journalServiceProvider);
    return journalAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (service) {
        final allEntries = service.getAllEntries();
        final now = DateTime.now();
        final onThisDayEntries = allEntries.where((e) {
          return e.date.month == now.month &&
              e.date.day == now.day &&
              e.date.year < now.year;
        }).toList()
          ..sort((a, b) => b.date.compareTo(a.date));

        if (onThisDayEntries.isEmpty) return const SizedBox.shrink();

        final yearsAgo = now.year - onThisDayEntries.first.date.year;
        final entry = onThisDayEntries.first;
        final areaLabel = entry.focusArea.localizedName(language);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Semantics(
            button: true,
            label: L10nService.get('today.on_this_day.view_memories_from_this_day', language),
            child: TapScale(
              onTap: () => context.push(Routes.memories),
              child: PremiumCard(
                style: PremiumCardStyle.amethyst,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.amethyst.withValues(alpha: 0.15),
                            border: Border.all(
                              color: AppColors.amethyst.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${entry.overallRating}',
                              style: AppTypography.displayFont.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.amethyst,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEn
                                    ? 'On This Day — $yearsAgo year${yearsAgo == 1 ? '' : 's'} ago'
                                    : 'Bugün Geçmişte — $yearsAgo yıl önce',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.displayFont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: widget.isDark
                                      ? AppColors.textPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                entry.note != null && entry.note!.isNotEmpty
                                    ? entry.note!
                                    : areaLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.decorativeScript(
                                  fontSize: 13,
                                  color: widget.isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                              if (onThisDayEntries.length > 1) ...[
                                const SizedBox(height: 2),
                                Text(
                                  isEn
                                      ? '+${onThisDayEntries.length - 1} more memories'
                                      : '+${onThisDayEntries.length - 1} anı daha',
                                  style: AppTypography.elegantAccent(
                                    fontSize: 12,
                                    color: AppColors.amethyst,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: widget.isDark
                              ? AppColors.textMuted
                              : AppColors.lightTextMuted,
                        ),
                      ],
                    ),
                    // AI theme recall
                    if (_aiReflection != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.amethyst.withValues(alpha: widget.isDark ? 0.08 : 0.06),
                          border: Border.all(
                            color: AppColors.amethyst.withValues(alpha: 0.12),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 14,
                              color: AppColors.amethyst.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _aiReflection!,
                                style: AppTypography.decorativeScript(
                                  fontSize: 13,
                                  color: widget.isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                    ],
                    // Share nudge
                    const SizedBox(height: 8),
                    ShareNudgeChip(
                      label: isEn ? 'Share Memory' : 'Anıyı Paylaş',
                      isDark: widget.isDark,
                      delay: 500.ms,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        final noteSnippet =
                            entry.note != null && entry.note!.isNotEmpty
                                ? '"${entry.note!.length > 80 ? '${entry.note!.substring(0, 80)}...' : entry.note!}"'
                                : areaLabel;
                        final reflectionForCard = _aiReflection ?? noteSnippet;
                        final template = ShareCardTemplates.onThisDayMemory;
                        final cardData = ShareCardTemplates.buildData(
                          template: template,
                          language: language,
                          reflectionText: reflectionForCard,
                        );
                        ShareCardSheet.show(
                          context,
                          template: template,
                          data: cardData,
                          language: language,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).glassEntrance(context: context);
      },
    );
  }
}
