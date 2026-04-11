import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

/// Breadcrumb Navigation Widget
/// SEO-friendly breadcrumb trail for hierarchical navigation
class BreadcrumbNavigation extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final Color? activeColor;
  final Color? inactiveColor;

  const BreadcrumbNavigation({
    super.key,
    required this.items,
    this.activeColor,
    this.inactiveColor,
  });

  /// Creates breadcrumbs for a zodiac sign page
  factory BreadcrumbNavigation.zodiacSign(String signName, String signSymbol) {
    return BreadcrumbNavigation(
      items: [
        const BreadcrumbItem(label: 'Ana Sayfa', route: '/'),
        const BreadcrumbItem(label: 'Burç Yorumları', route: '/horoscope'),
        BreadcrumbItem(label: '$signSymbol $signName', route: null),
      ],
    );
  }

  /// Creates breadcrumbs for a tool page
  factory BreadcrumbNavigation.tool(String toolName, String toolRoute) {
    return BreadcrumbNavigation(
      items: [
        const BreadcrumbItem(label: 'Ana Sayfa', route: '/'),
        BreadcrumbItem(label: toolName, route: null),
      ],
    );
  }

  /// Creates breadcrumbs for horoscope page
  factory BreadcrumbNavigation.horoscope() {
    return const BreadcrumbNavigation(
      items: [
        BreadcrumbItem(label: 'Ana Sayfa', route: '/'),
        BreadcrumbItem(label: 'Burç Yorumları', route: null),
      ],
    );
  }

  /// Creates breadcrumbs for any nested page
  factory BreadcrumbNavigation.nested({
    required String parentLabel,
    required String parentRoute,
    required String currentLabel,
  }) {
    return BreadcrumbNavigation(
      items: [
        const BreadcrumbItem(label: 'Ana Sayfa', route: '/'),
        BreadcrumbItem(label: parentLabel, route: parentRoute),
        BreadcrumbItem(label: currentLabel, route: null),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultActiveColor = isDark
        ? AppColors.textPrimary
        : AppColors.lightTextPrimary;
    final defaultInactiveColor = isDark
        ? AppColors.textSecondary.withOpacity(0.7)
        : AppColors.lightTextSecondary.withOpacity(0.8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;
          final isClickable = item.route != null && !isLast;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Breadcrumb item
              GestureDetector(
                onTap: isClickable ? () => context.push(item.route!) : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: isClickable
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.03),
                        )
                      : null,
                  child: Text(
                    item.label,
                    style: GoogleFonts.raleway(
                      fontSize: 12,
                      fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
                      color: isLast
                          ? (activeColor ?? defaultActiveColor)
                          : (inactiveColor ?? defaultInactiveColor),
                      decoration: isClickable ? TextDecoration.none : null,
                    ),
                  ),
                ),
              ),
              // Separator
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: inactiveColor ?? defaultInactiveColor,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// Single breadcrumb item
class BreadcrumbItem {
  final String label;
  final String? route;

  const BreadcrumbItem({required this.label, this.route});
}

/// Compact breadcrumb for mobile views
class BreadcrumbNavigationCompact extends StatelessWidget {
  final String parentLabel;
  final String parentRoute;

  const BreadcrumbNavigationCompact({
    super.key,
    required this.parentLabel,
    required this.parentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push(parentRoute),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark
              ? AppColors.surfaceLight.withOpacity(0.1)
              : AppColors.lightSurfaceVariant,
          border: Border.all(
            color: isDark
                ? AppColors.textMuted.withOpacity(0.1)
                : AppColors.lightTextMuted.withOpacity(0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 12,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              parentLabel,
              style: GoogleFonts.raleway(
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
