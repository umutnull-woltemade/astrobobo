import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/zodiac_sign.dart' as zodiac;
import 'constellation_widget.dart';

class ZodiacCard extends StatelessWidget {
  final zodiac.ZodiacSign sign;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showDetails;

  const ZodiacCard({
    super.key,
    required this.sign,
    this.isSelected = false,
    this.onTap,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [sign.color.withAlpha(76), sign.color.withAlpha(25)]
                : [AppColors.surfaceLight, AppColors.surfaceDark],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? sign.color : Colors.white.withAlpha(25),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: sign.color.withAlpha(76),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstellationWidget(
              sign: sign,
              size: showDetails ? 48 : 32,
              color: isSelected ? sign.color : AppColors.textPrimary,
              showGlow: isSelected,
            ),
            const SizedBox(height: 8),
            Text(
              sign.nameTr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected ? sign.color : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (showDetails) ...[
              const SizedBox(height: 4),
              Text(
                sign.dateRange,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              _ElementBadge(element: sign.element),
            ],
          ],
        ),
      ),
    );
  }
}

class _ElementBadge extends StatelessWidget {
  final zodiac.Element element;

  const _ElementBadge({required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: element.color.withAlpha(51),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: element.color.withAlpha(127)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(element.symbol, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            element.nameTr,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: element.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ZodiacGridCard extends StatelessWidget {
  final zodiac.ZodiacSign sign;
  final VoidCallback? onTap;

  const ZodiacGridCard({super.key, required this.sign, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  sign.color.withAlpha(isDark ? 30 : 20),
                  isDark ? AppColors.surfaceDark : AppColors.lightSurface,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: sign.color.withAlpha(isDark ? 60 : 40),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: sign.color.withAlpha(isDark ? 20 : 10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Constellation + İsim - Büyük header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstellationWidget(
                        sign: sign,
                        size: 28,
                        color: sign.color,
                        showGlow: true,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        sign.nameTr,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Tarih
                  Text(
                    sign.dateRange,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Element ve Modalite
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      _MiniTag(
                        text: sign.element.nameTr,
                        color: sign.element.color,
                        icon: sign.element.symbol,
                      ),
                      _MiniTag(
                        text: sign.modality.nameTr,
                        color: isDark
                            ? AppColors.moonSilver
                            : AppColors.lightTextSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Yönetici Gezegen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_outline, size: 14, color: sign.color),
                      const SizedBox(width: 4),
                      Text(
                        sign.rulingPlanet,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: sign.color,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // İlk 2 özellik
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    runSpacing: 2,
                    children: sign.traits
                        .take(2)
                        .map(
                          (trait) => Text(
                            trait,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary,
                                  fontSize: 12,
                                ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

/// Etiket widget'ı - büyük font
class _MiniTag extends StatelessWidget {
  final String text;
  final Color color;
  final String? icon;

  const _MiniTag({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(50), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Text(icon!, style: TextStyle(fontSize: 12, color: color)),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
