import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Dream logging prompt card for home screen
/// Key retention mechanic - creates daily habit loop
class DreamPromptCard extends StatelessWidget {
  final VoidCallback? onTap;
  final int? currentStreak;
  final DateTime? lastDreamDate;
  final bool showExpandedView;

  const DreamPromptCard({
    super.key,
    this.onTap,
    this.currentStreak,
    this.lastDreamDate,
    this.showExpandedView = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasRecentDream =
        lastDreamDate != null &&
        DateTime.now().difference(lastDreamDate!).inHours < 24;
    final greeting = _getTimeBasedPrompt();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1A1A3E).withOpacity(0.9),
                    const Color(0xFF0D0D2A).withOpacity(0.95),
                  ]
                : [const Color(0xFFF0F0FF), Colors.white],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.mystic.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mystic.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                // Animated moon/dream icon
                _DreamIcon(hasRecentDream: hasRecentDream),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasRecentDream ? 'Ruyan Kaydedildi' : greeting,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasRecentDream
                            ? 'Ruyani incelemek icin dokun'
                            : 'Bilinçaltinin mesajlarini kesfet',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Streak badge
                if (currentStreak != null && currentStreak! > 0)
                  _StreakBadge(streak: currentStreak!),
              ],
            ),

            if (showExpandedView) ...[
              const SizedBox(height: 20),

              // Dream entry hint
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit_note, color: AppColors.mystic, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ruya Gunluuguu',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ruyalarini kaydet, oruntuleri kesfet',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.textMuted
                                  : AppColors.lightTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.mystic.withOpacity(0.7),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Quick prompts
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _QuickPromptChip(
                    emoji: '🌊',
                    label: 'Su gorduum',
                    onTap: () {}, // Pre-fill dream with water symbol
                  ),
                  _QuickPromptChip(
                    emoji: '✈️',
                    label: 'Ucuyordum',
                    onTap: () {},
                  ),
                  _QuickPromptChip(
                    emoji: '🏃',
                    label: 'Kaciyordum',
                    onTap: () {},
                  ),
                  _QuickPromptChip(emoji: '🐍', label: 'Yilan', onTap: () {}),
                ],
              ),
            ],

            const SizedBox(height: 16),

            // CTA Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: hasRecentDream
                      ? [
                          AppColors.mystic.withOpacity(0.3),
                          AppColors.mystic.withOpacity(0.1),
                        ]
                      : [AppColors.mystic, AppColors.auroraEnd],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: hasRecentDream
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.mystic.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasRecentDream ? Icons.visibility : Icons.nightlight_round,
                    size: 18,
                    color: hasRecentDream ? AppColors.mystic : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hasRecentDream ? 'Ruya Yorumunu Gor' : 'Ruyami Anlat',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: hasRecentDream ? AppColors.mystic : Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Insight teaser
            if (!hasRecentDream) ...[
              const SizedBox(height: 12),
              Center(
                child: Text(
                  '✨ AI destekli derin ruya analizi',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms);
  }

  String _getTimeBasedPrompt() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bu Gece Ne Gordun?';
    if (hour < 18) return 'Dun Gece Ruya Gordun mu?';
    return 'Ruyalarini Kaydet';
  }
}

class _DreamIcon extends StatelessWidget {
  final bool hasRecentDream;

  const _DreamIcon({required this.hasRecentDream});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: hasRecentDream
                  ? [
                      AppColors.success.withOpacity(0.3),
                      AppColors.success.withOpacity(0.1),
                    ]
                  : [
                      AppColors.mystic.withOpacity(0.3),
                      AppColors.mystic.withOpacity(0.1),
                    ],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: hasRecentDream
                  ? AppColors.success.withOpacity(0.5)
                  : AppColors.mystic.withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (hasRecentDream ? AppColors.success : AppColors.mystic)
                    .withOpacity(0.3),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              hasRecentDream ? '✓' : '🌙',
              style: TextStyle(
                fontSize: hasRecentDream ? 24 : 28,
                color: hasRecentDream ? AppColors.success : null,
              ),
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
          duration: 2000.ms,
        );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;

  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.starGold.withOpacity(0.3),
                AppColors.starGold.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.starGold.withOpacity(0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🔥', style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              Text(
                '$streak',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.starGold,
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: AppColors.starGold.withOpacity(0.3));
  }
}

class _QuickPromptChip extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _QuickPromptChip({
    required this.emoji,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.08),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact dream prompt for home header
class CompactDreamPrompt extends StatelessWidget {
  final VoidCallback? onTap;
  final int? streak;

  const CompactDreamPrompt({super.key, this.onTap, this.streak});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mystic.withOpacity(0.2),
              AppColors.mystic.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.mystic.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🌙', style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              'Ruya Kaydet',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            if (streak != null && streak! > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('🔥$streak', style: const TextStyle(fontSize: 11)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
