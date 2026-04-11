import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Streak/progress ring widget for gamification
/// Creates habit formation through visual progress tracking
class ProgressRing extends StatelessWidget {
  final int current;
  final int total;
  final String label;
  final String? sublabel;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final bool showPercentage;
  final Widget? centerWidget;
  final bool animate;

  const ProgressRing({
    super.key,
    required this.current,
    required this.total,
    this.label = '',
    this.sublabel,
    this.size = 80,
    this.strokeWidth = 8,
    this.progressColor,
    this.backgroundColor,
    this.showPercentage = true,
    this.centerWidget,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
    final color = progressColor ?? _getProgressColor(progress);
    final bgColor =
        backgroundColor ??
        (isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.08));

    Widget ring = SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: 1.0,
              color: bgColor,
              strokeWidth: strokeWidth,
            ),
          ),
          // Progress ring
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: animate
                ? const Duration(milliseconds: 1000)
                : Duration.zero,
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  progress: value,
                  color: color,
                  strokeWidth: strokeWidth,
                  hasGlow: true,
                ),
              );
            },
          ),
          // Center content
          centerWidget ??
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showPercentage)
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: size * 0.2,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    )
                  else
                    Text(
                      '$current',
                      style: TextStyle(
                        fontSize: size * 0.25,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  if (label.isNotEmpty)
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: size * 0.12,
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
        ],
      ),
    );

    if (animate) {
      ring = ring
          .animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.8, 0.8), duration: 400.ms);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ring,
        if (sublabel != null) ...[
          const SizedBox(height: 8),
          Text(
            sublabel!,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return AppColors.starGold;
    if (progress >= 0.7) return AppColors.success;
    if (progress >= 0.4) return AppColors.auroraStart;
    return AppColors.mystic;
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool hasGlow;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    this.hasGlow = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (hasGlow && progress > 0) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        glowPaint,
      );
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}

/// Streak display widget with fire icon
class StreakDisplay extends StatelessWidget {
  final int streak;
  final String? label;
  final bool showFire;
  final double size;
  final Color? color;

  const StreakDisplay({
    super.key,
    required this.streak,
    this.label,
    this.showFire = true,
    this.size = 48,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayColor = color ?? _getStreakColor(streak);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            displayColor.withOpacity(0.2),
            displayColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: displayColor.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showFire) ...[
            Text(_getFireEmoji(streak), style: TextStyle(fontSize: size * 0.5))
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  duration: 1000.ms,
                ),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$streak',
                style: TextStyle(
                  fontSize: size * 0.5,
                  fontWeight: FontWeight.bold,
                  color: displayColor,
                ),
              ),
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStreakColor(int streak) {
    if (streak >= 30) return AppColors.starGold;
    if (streak >= 14) return const Color(0xFFFF6B6B);
    if (streak >= 7) return AppColors.fireElement;
    return AppColors.warning;
  }

  String _getFireEmoji(int streak) {
    if (streak >= 30) return '🌟';
    if (streak >= 14) return '🔥';
    if (streak >= 7) return '💪';
    if (streak >= 3) return '✨';
    return '🌱';
  }
}

/// Multi-stat display card
class StatsCard extends StatelessWidget {
  final List<StatItem> stats;
  final String? title;

  const StatsCard({super.key, required this.stats, this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceLight.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: stats.map((stat) => _StatColumn(stat: stat)).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final StatItem stat;

  const _StatColumn({required this.stat});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        if (stat.emoji != null)
          Text(stat.emoji!, style: const TextStyle(fontSize: 24))
        else if (stat.icon != null)
          Icon(stat.icon, color: stat.color ?? AppColors.auroraStart, size: 24),
        const SizedBox(height: 8),
        Text(
          stat.value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:
                stat.color ??
                (isDark ? AppColors.textPrimary : AppColors.lightTextPrimary),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat.label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}

class StatItem {
  final String value;
  final String label;
  final String? emoji;
  final IconData? icon;
  final Color? color;

  const StatItem({
    required this.value,
    required this.label,
    this.emoji,
    this.icon,
    this.color,
  });
}
