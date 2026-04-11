import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// ENERGY BAR WIDGET
///
/// Günlük enerji seviyelerini görsel bir bar ile gösterir.
/// Aşk, Kariyer, Sağlık, Genel enerji kategorileri için kullanılır.
///
/// KULLANIM:
/// ```dart
/// EnergyBar(
///   label: 'Aşk Enerjisi',
///   value: 0.85,
///   color: Colors.pink,
///   icon: Icons.favorite,
/// )
/// ```
class EnergyBar extends StatelessWidget {
  final String label;
  final double value; // 0.0 - 1.0
  final Color color;
  final IconData? icon;
  final bool showPercentage;
  final bool animate;

  const EnergyBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.icon,
    this.showPercentage = true,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final percentage = (value * 100).round();

    return Row(
      children: [
        // Icon
        if (icon != null) ...[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
        ],
        // Label and bar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  if (showPercentage)
                    Text(
                      '%$percentage',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              // Progress bar
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barWidth =
                        constraints.maxWidth * value.clamp(0.0, 1.0);
                    return Stack(
                      children: [
                        AnimatedContainer(
                          duration: animate
                              ? const Duration(milliseconds: 800)
                              : Duration.zero,
                          curve: Curves.easeOutCubic,
                          width: barWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color.withValues(alpha: 0.7), color],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// DAILY ENERGY CARD WIDGET
///
/// Günlük enerji seviyelerini gösteren kompakt kart.
/// Aşk, Kariyer, Sağlık ve Genel enerji bar'larını içerir.
class DailyEnergyCard extends StatelessWidget {
  final int loveEnergy; // 0-100
  final int careerEnergy; // 0-100
  final int healthEnergy; // 0-100
  final int overallEnergy; // 0-100
  final Color? accentColor;

  const DailyEnergyCard({
    super.key,
    required this.loveEnergy,
    required this.careerEnergy,
    required this.healthEnergy,
    required this.overallEnergy,
    this.accentColor,
  });

  /// Helper factory to create from luck/mood values
  factory DailyEnergyCard.fromLuckRating(int luckRating, {Color? accentColor}) {
    // Convert 1-5 luck rating to energy percentages
    final baseEnergy = (luckRating / 5.0);
    return DailyEnergyCard(
      loveEnergy: ((baseEnergy + 0.1) * 100).round().clamp(30, 100),
      careerEnergy: ((baseEnergy - 0.05) * 100).round().clamp(30, 100),
      healthEnergy: ((baseEnergy + 0.05) * 100).round().clamp(30, 100),
      overallEnergy: (baseEnergy * 100).round().clamp(30, 100),
      accentColor: accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = accentColor ?? AppColors.auroraStart;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.bolt, size: 16, color: accent),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Günlük Enerji',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildOverallBadge(context, isDark),
            ],
          ),
          const SizedBox(height: 16),
          // Energy bars
          EnergyBar(
            label: 'Aşk',
            value: loveEnergy / 100,
            color: AppColors.fireElement,
            icon: Icons.favorite,
          ),
          const SizedBox(height: 12),
          EnergyBar(
            label: 'Kariyer',
            value: careerEnergy / 100,
            color: AppColors.earthElement,
            icon: Icons.work,
          ),
          const SizedBox(height: 12),
          EnergyBar(
            label: 'Sağlık',
            value: healthEnergy / 100,
            color: AppColors.airElement,
            icon: Icons.spa,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildOverallBadge(BuildContext context, bool isDark) {
    Color badgeColor;
    String label;

    if (overallEnergy >= 80) {
      badgeColor = AppColors.success;
      label = 'Yüksek';
    } else if (overallEnergy >= 60) {
      badgeColor = AppColors.auroraStart;
      label = 'İyi';
    } else if (overallEnergy >= 40) {
      badgeColor = AppColors.warning;
      label = 'Orta';
    } else {
      badgeColor = AppColors.error;
      label = 'Düşük';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up, size: 12, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// COMPACT ENERGY BAR - Tek satırlık mini versiyon
class EnergyBarCompact extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const EnergyBarCompact({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final percentage = (value * 100).round();

    return Column(
      children: [
        // Circular indicator
        SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.08),
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: 4,
              ),
              Text(
                '$percentage',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}

/// HORIZONTAL ENERGY SUMMARY - Yatay kompakt özet
class EnergyBarsSummary extends StatelessWidget {
  final int loveEnergy;
  final int careerEnergy;
  final int healthEnergy;

  const EnergyBarsSummary({
    super.key,
    required this.loveEnergy,
    required this.careerEnergy,
    required this.healthEnergy,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EnergyBarCompact(
            label: 'Aşk',
            value: loveEnergy / 100,
            color: AppColors.fireElement,
          ),
          _divider(isDark),
          EnergyBarCompact(
            label: 'Kariyer',
            value: careerEnergy / 100,
            color: AppColors.earthElement,
          ),
          _divider(isDark),
          EnergyBarCompact(
            label: 'Sağlık',
            value: healthEnergy / 100,
            color: AppColors.airElement,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _divider(bool isDark) {
    return Container(
      width: 1,
      height: 40,
      color: isDark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.08),
    );
  }
}
