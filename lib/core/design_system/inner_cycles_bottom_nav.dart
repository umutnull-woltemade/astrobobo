import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import 'inner_cycles_icons.dart';

/// InnerCycles Premium Bottom Navigation Bar
///
/// Design concept: Floating pill with frosted glass backdrop
///
/// Architecture decisions:
/// - Floating above content (not docked) — signals intentionality
/// - Frosted glass backdrop — depth without heaviness
/// - Kozmoz (center) is slightly elevated — the soul of the app
/// - Active state: filled icon + label + indicator dot
/// - Inactive state: stroke icon only, reduced opacity
/// - Micro-interactions: scale bounce on tap, smooth crossfade
///
/// Why NOT the other options:
/// - Option B (minimal bar with micro-indicator): Too subtle for an app
///   with 48+ features — users need clear wayfinding
/// - Option C (full glassmorphism): Risks looking tacky on lower-end
///   Android devices where backdrop filter is expensive
/// - THIS (Option A hybrid): Floating pill reads as premium without
///   performance cost. Glass is used sparingly (background only).
class InnerCyclesBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const InnerCyclesBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          bottomPadding > 0 ? bottomPadding : 12,
        ),
        child: _FloatingNavBar(
          currentIndex: currentIndex,
          onTap: onTap,
          isDark: isDark,
        ),
      ),
    );
  }
}

/// The floating navigation pill
class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDark;

  const _FloatingNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: isDark
                ? AppColors.cosmicPurple.withOpacity(0.75)
                : Colors.white.withOpacity(0.80),
            border: Border.all(
              color: isDark
                  ? AppColors.surfaceLight.withOpacity(0.15)
                  : Colors.black.withOpacity(0.06),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.35)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
                spreadRadius: -4,
              ),
              if (isDark)
                BoxShadow(
                  color: AppColors.auroraStart.withOpacity(0.06),
                  blurRadius: 40,
                  offset: const Offset(0, -4),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return Expanded(
                child: _NavItem(
                  index: index,
                  isActive: currentIndex == index,
                  isDark: isDark,
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Individual navigation item with animation
class _NavItem extends StatefulWidget {
  final int index;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKozmoz = widget.index == 2; // Center tab
    final config = _tabConfigs[widget.index];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        // Haptic feedback — light for normal tabs, medium for center
        HapticFeedback.selectionClick();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: child,
            ),
          );
        },
        child: SizedBox(
          height: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animated state
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.all(isKozmoz ? 8 : 4),
                decoration: isKozmoz && widget.isActive
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isDark
                            ? AppColors.auroraStart.withOpacity(0.15)
                            : AppColors.lightAuroraStart.withOpacity(0.10),
                      )
                    : null,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: config.iconBuilder(
                    key: ValueKey('${widget.index}_${widget.isActive}'),
                    size: isKozmoz ? 26.0 : 24.0,
                    color: _getIconColor(),
                    filled: widget.isActive,
                  ),
                ),
              ),

              if (!isKozmoz) ...[
                const SizedBox(height: 2),
                // Label — only visible for non-center tabs
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: widget.isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: _getLabelColor(),
                    letterSpacing: widget.isActive ? 0.3 : 0,
                  ),
                  child: Text(config.label),
                ),
              ],

              // Active indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                margin: EdgeInsets.only(top: isKozmoz ? 2 : 3),
                width: widget.isActive ? 4 : 0,
                height: widget.isActive ? 4 : 0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getIndicatorColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getIconColor() {
    if (widget.isActive) {
      if (widget.index == 2) {
        // Kozmoz — gold accent when active
        return widget.isDark
            ? AppColors.starGold
            : AppColors.lightStarGold;
      }
      return widget.isDark
          ? AppColors.textPrimary
          : AppColors.lightTextPrimary;
    }
    return widget.isDark
        ? AppColors.textMuted.withOpacity(0.55)
        : AppColors.lightTextMuted.withOpacity(0.55);
  }

  Color _getLabelColor() {
    if (widget.isActive) {
      return widget.isDark
          ? AppColors.textPrimary
          : AppColors.lightTextPrimary;
    }
    return widget.isDark
        ? AppColors.textMuted.withOpacity(0.45)
        : AppColors.lightTextMuted.withOpacity(0.45);
  }

  Color _getIndicatorColor() {
    if (widget.index == 2) {
      return widget.isDark
          ? AppColors.starGold
          : AppColors.lightStarGold;
    }
    return widget.isDark
        ? AppColors.auroraStart
        : AppColors.lightAuroraStart;
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB CONFIGURATION
// ═══════════════════════════════════════════════════════════════════════════════

class _TabConfig {
  final String label;
  final Widget Function({
    required Key key,
    required double size,
    required Color color,
    required bool filled,
  }) iconBuilder;

  const _TabConfig({required this.label, required this.iconBuilder});
}

final _tabConfigs = [
  _TabConfig(
    label: 'Ana Sayfa',
    iconBuilder: ({
      required Key key,
      required double size,
      required Color color,
      required bool filled,
    }) =>
        KeyedSubtree(
          key: key,
          child: InnerCyclesIcons.home(size: size, color: color, filled: filled),
        ),
  ),
  _TabConfig(
    label: 'Keşfet',
    iconBuilder: ({
      required Key key,
      required double size,
      required Color color,
      required bool filled,
    }) =>
        KeyedSubtree(
          key: key,
          child: InnerCyclesIcons.explore(size: size, color: color, filled: filled),
        ),
  ),
  _TabConfig(
    label: 'Kozmoz',
    iconBuilder: ({
      required Key key,
      required double size,
      required Color color,
      required bool filled,
    }) =>
        KeyedSubtree(
          key: key,
          child: InnerCyclesIcons.kozmoz(size: size, color: color, filled: filled),
        ),
  ),
  _TabConfig(
    label: 'İçgörü',
    iconBuilder: ({
      required Key key,
      required double size,
      required Color color,
      required bool filled,
    }) =>
        KeyedSubtree(
          key: key,
          child: InnerCyclesIcons.insights(size: size, color: color, filled: filled),
        ),
  ),
  _TabConfig(
    label: 'Profil',
    iconBuilder: ({
      required Key key,
      required double size,
      required Color color,
      required bool filled,
    }) =>
        KeyedSubtree(
          key: key,
          child: InnerCyclesIcons.profile(size: size, color: color, filled: filled),
        ),
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
// APP SHELL — Wraps content pages with the bottom nav
// ═══════════════════════════════════════════════════════════════════════════════

/// Route-to-tab-index mapping
const _shellTabRoutes = <String>[
  '/home',
  '/tum-cozumlemeler',
  '/kozmoz',
  '/horoscope',
  '/profile',
];

/// Resolves the active tab index from the current route path.
/// Returns -1 if the path doesn't match any tab (shouldn't happen inside shell).
int _resolveTabIndex(String path) {
  for (var i = 0; i < _shellTabRoutes.length; i++) {
    if (path == _shellTabRoutes[i] || path.startsWith('${_shellTabRoutes[i]}/')) {
      return i;
    }
  }
  return 0; // Default to home
}

/// App shell with persistent floating bottom navigation.
///
/// Usage in go_router:
/// ```dart
/// ShellRoute(
///   builder: (context, state, child) {
///     return InnerCyclesAppShell(child: child);
///   },
///   routes: [
///     GoRoute(path: '/home', ...),
///     GoRoute(path: '/tum-cozumlemeler', ...),
///     GoRoute(path: '/kozmoz', ...),
///     GoRoute(path: '/horoscope', ...),
///     GoRoute(path: '/profile', ...),
///   ],
/// )
/// ```
class InnerCyclesAppShell extends StatelessWidget {
  final Widget child;

  const InnerCyclesAppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _resolveTabIndex(location);

    return Scaffold(
      body: Stack(
        children: [
          // Page content — bottom padding so content isn't hidden behind nav
          Padding(
            padding: const EdgeInsets.only(bottom: 84),
            child: child,
          ),

          // Floating bottom nav
          InnerCyclesBottomNav(
            currentIndex: currentIndex,
            onTap: (index) {
              final targetRoute = _shellTabRoutes[index];
              if (location != targetRoute) {
                GoRouter.of(context).go(targetRoute);
              }
            },
          ),
        ],
      ),
    );
  }
}
