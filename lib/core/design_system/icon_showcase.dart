import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'inner_cycles_icons.dart';
import 'inner_cycles_bottom_nav.dart';

/// Icon Showcase — For design review and QA
///
/// Navigate to this screen during development to verify:
/// - Icon clarity at different sizes
/// - Active/inactive state contrast
/// - Dark/light mode rendering
/// - Bottom nav integration
///
/// Add a temporary route: '/dev/icons' → IconShowcase()
class IconShowcase extends StatefulWidget {
  const IconShowcase({super.key});

  @override
  State<IconShowcase> createState() => _IconShowcaseState();
}

class _IconShowcaseState extends State<IconShowcase> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.deepSpace : AppColors.lightBackground;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final mutedColor = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
    final iconColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final goldColor = isDark ? AppColors.starGold : AppColors.lightStarGold;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Icon System',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'InnerCycles Design System',
                    style: TextStyle(fontSize: 14, color: mutedColor),
                  ),
                  const SizedBox(height: 32),

                  // ── Tab Bar Icons ──
                  Text(
                    'TAB BAR ICONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: mutedColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _IconRow(
                    label: 'Home',
                    subtitle: 'Horizon + rising body',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.home(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Explore',
                    subtitle: 'Compass rose + star',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.explore(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Kozmoz',
                    subtitle: 'Nebula spiral',
                    color: goldColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.kozmoz(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Insights',
                    subtitle: 'Orbital rings',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.insights(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Profile',
                    subtitle: 'Crescent + star',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.profile(size: size, color: color, filled: filled),
                  ),

                  const SizedBox(height: 32),
                  Divider(color: mutedColor.withOpacity(0.2)),
                  const SizedBox(height: 24),

                  // ── Feature Icons ──
                  Text(
                    'FEATURE ICONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: mutedColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _IconRow(
                    label: 'Daily Sun',
                    subtitle: 'Horoscope',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.dailySun(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Dream Eye',
                    subtitle: 'Dream interpretation',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.dreamEye(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Tarot',
                    subtitle: 'Card reading',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.tarotCards(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Compatibility',
                    subtitle: 'Relationship match',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.compatibility(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Birth Chart',
                    subtitle: 'Natal chart',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.birthChart(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Numerology',
                    subtitle: 'Number wisdom',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.numerology(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Chakra',
                    subtitle: 'Energy centers',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.chakra(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Weekly Moon',
                    subtitle: 'Weekly forecast',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.weeklyMoon(size: size, color: color, filled: filled),
                  ),
                  _IconRow(
                    label: 'Cosmic Share',
                    subtitle: 'Share content',
                    color: iconColor,
                    builder: (size, color, filled) =>
                        InnerCyclesIcons.cosmicShare(size: size, color: color, filled: filled),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          // Live bottom nav preview
          InnerCyclesBottomNav(
            currentIndex: _activeTab,
            onTap: (i) => setState(() => _activeTab = i),
          ),
        ],
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final Widget Function(double size, Color color, bool filled) builder;

  const _IconRow({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppColors.textMuted : AppColors.lightTextMuted;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: mutedColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Size variants: 16, 24, 32, 48
          _IconCell(child: builder(16, color.withOpacity(0.55), false)),
          const SizedBox(width: 16),
          _IconCell(child: builder(24, color.withOpacity(0.55), false)),
          const SizedBox(width: 16),
          _IconCell(child: builder(24, color, true)),
          const SizedBox(width: 16),
          _IconCell(child: builder(32, color, true)),
          const SizedBox(width: 16),
          _IconCell(child: builder(48, color, true)),
        ],
      ),
    );
  }
}

class _IconCell extends StatelessWidget {
  final Widget child;

  const _IconCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Center(child: child),
    );
  }
}
