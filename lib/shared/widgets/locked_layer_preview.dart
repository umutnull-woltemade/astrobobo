import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Soft paywall component - shows blurred premium content preview
/// Creates desire without frustration - key monetization UX pattern
class LockedLayerPreview extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String teaserText;
  final double blurAmount;
  final VoidCallback? onUnlock;
  final String? unlockCTA;
  final bool showPriceHint;
  final String? priceText;
  final IconData? icon;
  final Color? accentColor;

  const LockedLayerPreview({
    super.key,
    required this.title,
    this.subtitle,
    required this.teaserText,
    this.blurAmount = 6.0,
    this.onUnlock,
    this.unlockCTA,
    this.showPriceHint = false,
    this.priceText,
    this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = accentColor ?? AppColors.starGold;

    return GestureDetector(
          onTap: onUnlock,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.surfaceLight.withOpacity(0.8),
                        AppColors.surfaceDark.withOpacity(0.9),
                      ]
                    : [Colors.white, AppColors.lightSurfaceVariant],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.4), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Blurred content preview
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            if (icon != null) ...[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(icon, size: 22, color: color),
                              ),
                              const SizedBox(width: 14),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.textPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                  if (subtitle != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      subtitle!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark
                                            ? AppColors.textSecondary
                                            : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            _PremiumBadge(color: color),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Blurred teaser content
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: blurAmount,
                            sigmaY: blurAmount,
                          ),
                          child: Text(
                            teaserText,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Unlock CTA
                        _UnlockButton(
                          text: unlockCTA ?? 'Kilidi Ac',
                          color: color,
                          showPrice: showPriceHint,
                          priceText: priceText,
                          onTap: onUnlock,
                        ),
                      ],
                    ),
                  ),

                  // Gradient overlay
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              (isDark ? AppColors.surfaceDark : Colors.white)
                                  .withOpacity(0.3),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  // Lock icon overlay
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lock_outline, size: 16, color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.98, 0.98), duration: 400.ms);
  }
}

class _PremiumBadge extends StatelessWidget {
  final Color color;

  const _PremiumBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                'PRO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: color.withOpacity(0.3));
  }
}

class _UnlockButton extends StatelessWidget {
  final String text;
  final Color color;
  final bool showPrice;
  final String? priceText;
  final VoidCallback? onTap;

  const _UnlockButton({
    required this.text,
    required this.color,
    this.showPrice = false,
    this.priceText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_open, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            if (showPrice && priceText != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  priceText!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Inline soft paywall for content sections
class InlineLockedSection extends StatelessWidget {
  final Widget freeContent;
  final String lockedTitle;
  final String lockedTeaser;
  final int lockedItemCount;
  final VoidCallback? onUnlock;
  final Color? accentColor;

  const InlineLockedSection({
    super.key,
    required this.freeContent,
    required this.lockedTitle,
    required this.lockedTeaser,
    this.lockedItemCount = 3,
    this.onUnlock,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = accentColor ?? AppColors.starGold;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Free content
        freeContent,

        const SizedBox(height: 16),

        // Locked section teaser
        GestureDetector(
          onTap: onUnlock,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.3),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.lock_outline, size: 20, color: color),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lockedTitle,
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
                            '+$lockedItemCount daha fazla icerik',
                            style: TextStyle(fontSize: 12, color: color),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Kilidi Ac',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Blurred preview items
                ...List.generate(
                  lockedItemCount > 2 ? 2 : lockedItemCount,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
