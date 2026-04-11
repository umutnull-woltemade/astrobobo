import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../features/quiz/domain/quiz_models.dart';

/// Quiz CTA Card - Sayfalarda gösterilen soft quiz çağrısı
/// Google Discover → Quiz → Premium funnel için
class QuizCTACard extends StatelessWidget {
  final QuizCTA cta;
  final bool compact;
  final VoidCallback? onTap;

  const QuizCTACard({
    super.key,
    required this.cta,
    this.compact = false,
    this.onTap,
  });

  /// Rüya sayfası için hazır CTA
  factory QuizCTACard.dream({bool compact = false, VoidCallback? onTap}) {
    return QuizCTACard(cta: QuizCTA.dream, compact: compact, onTap: onTap);
  }

  /// Astroloji sayfası için hazır CTA
  factory QuizCTACard.astrology({bool compact = false, VoidCallback? onTap}) {
    return QuizCTACard(cta: QuizCTA.astrology, compact: compact, onTap: onTap);
  }

  /// Numeroloji sayfası için hazır CTA
  factory QuizCTACard.numerology({bool compact = false, VoidCallback? onTap}) {
    return QuizCTACard(cta: QuizCTA.numerology, compact: compact, onTap: onTap);
  }

  /// Genel keşif CTA
  factory QuizCTACard.general({bool compact = false, VoidCallback? onTap}) {
    return QuizCTACard(cta: QuizCTA.general, compact: compact, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (compact) {
      return _buildCompactCard(context, isDark);
    }
    return _buildFullCard(context, isDark);
  }

  Widget _buildFullCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/quiz?type=${cta.quizType}'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColors.cosmicPurple.withOpacity(0.8),
                    AppColors.nebulaPurple.withOpacity(0.9),
                  ]
                : [AppColors.lightSurfaceVariant, AppColors.lightCard],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? AppColors.auroraStart.withOpacity(0.3)
                : AppColors.lightAuroraStart.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppColors.auroraStart.withOpacity(0.15)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji ve başlık
            Row(
              children: [
                if (cta.emoji != null) ...[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.auroraStart, AppColors.auroraEnd],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.auroraStart.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        cta.emoji!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                ],
                Expanded(
                  child: Text(
                    cta.headline,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMd),

            // Alt metin
            Text(
              cta.subtext,
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppConstants.spacingLg),

            // CTA butonu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.auroraStart, AppColors.auroraEnd],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.auroraStart.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cta.buttonText,
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05);
  }

  Widget _buildCompactCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/quiz?type=${cta.quizType}'),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.auroraStart.withOpacity(isDark ? 0.2 : 0.1),
              AppColors.auroraEnd.withOpacity(isDark ? 0.15 : 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.auroraStart.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            if (cta.emoji != null) ...[
              Text(cta.emoji!, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: AppConstants.spacingSm),
            ],
            Expanded(
              child: Text(
                cta.headline,
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppConstants.spacingSm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.auroraStart, AppColors.auroraEnd],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                cta.buttonText,
                style: GoogleFonts.raleway(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

/// Inline Quiz CTA - Metin içinde kullanım için
class InlineQuizCTA extends StatelessWidget {
  final String text;
  final String quizType;
  final VoidCallback? onTap;

  const InlineQuizCTA({
    super.key,
    this.text = 'Bu sana özel mi? Kısa testle öğren →',
    this.quizType = 'general',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap ?? () => context.push('/quiz?type=$quizType'),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.auroraStart.withOpacity(0.1)
              : AppColors.lightAuroraStart.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark
                ? AppColors.auroraStart.withOpacity(0.2)
                : AppColors.lightAuroraStart.withOpacity(0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.quiz_outlined,
              size: 16,
              color: isDark
                  ? AppColors.auroraStart
                  : AppColors.lightAuroraStart,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.auroraStart
                      : AppColors.lightAuroraStart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating Quiz CTA - Ekranın altında sabit
class FloatingQuizCTA extends StatelessWidget {
  final QuizCTA cta;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const FloatingQuizCTA({
    super.key,
    required this.cta,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  AppColors.surfaceDark.withOpacity(0.95),
                  AppColors.cosmicPurple.withOpacity(0.95),
                ]
              : [
                  AppColors.lightCard.withOpacity(0.98),
                  AppColors.lightSurfaceVariant.withOpacity(0.98),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.auroraStart.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (cta.emoji != null) ...[
            Text(cta.emoji!, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: AppConstants.spacingMd),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cta.headline,
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          GestureDetector(
            onTap: onTap ?? () => context.push('/quiz?type=${cta.quizType}'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.auroraStart, AppColors.auroraEnd],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                cta.buttonText,
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                size: 20,
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}
