import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'widgets/mobile_lite_homepage.dart';
import 'widgets/cinematic_portal_homepage.dart';

/// RESPONSIVE HOME SCREEN ROUTER
///
/// Detects device type and serves appropriate homepage:
/// - Mobile (<768px): MobileLiteHomepage — ultra fast, no heavy effects
/// - Desktop (>=768px): CinematicPortalHomepage — interactive cosmic portal
///   (was DesktopRichHomepage; replaced 2026-04-12 to surface the cinematic
///    Pro layer as the primary entry point)
///
/// Also considers:
/// - Platform (web, iOS, Android)
/// - User preference (force mobile mode option)
/// - Performance mode setting
class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({super.key});

  // Breakpoint for mobile vs desktop
  static const double _mobileBreakpoint = 768.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = _shouldUseMobileLayout(context, screenWidth);

        // Return appropriate homepage.
        // Desktop: CinematicPortalHomepage (interactive cosmic portal).
        // Mobile:  MobileLiteHomepage (ultra-light, fast).
        if (isMobile) {
          return const MobileLiteHomepage();
        } else {
          return const CinematicPortalHomepage();
        }
      },
    );
  }

  /// Determines if mobile layout should be used
  bool _shouldUseMobileLayout(BuildContext context, double screenWidth) {
    // 1. Check screen width
    if (screenWidth < _mobileBreakpoint) {
      return true;
    }

    // 2. On web, if not wide enough, use mobile
    if (kIsWeb && screenWidth < _mobileBreakpoint) {
      return true;
    }

    // 3. On mobile platforms (iOS/Android), always use mobile layout
    // regardless of screen size (tablets can use mobile for performance)
    if (!kIsWeb) {
      final platform = Theme.of(context).platform;
      if (platform == TargetPlatform.iOS ||
          platform == TargetPlatform.android) {
        // For tablets (width >= 768), still use desktop
        // For phones, use mobile
        return screenWidth < _mobileBreakpoint;
      }
    }

    // 4. Default to desktop for large screens
    return false;
  }
}

/// Utility class for responsive breakpoints
class ResponsiveBreakpoints {
  ResponsiveBreakpoints._();

  static const double mobile = 480.0;
  static const double tablet = 768.0;
  static const double desktop = 1024.0;
  static const double widescreen = 1440.0;

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tablet;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tablet && width < desktop;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }

  /// Check if current screen is widescreen
  static bool isWidescreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= widescreen;
  }

  /// Get responsive value based on screen size
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    T? widescreen,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ResponsiveBreakpoints.widescreen && widescreen != null) {
      return widescreen;
    }
    if (width >= ResponsiveBreakpoints.desktop && desktop != null) {
      return desktop;
    }
    if (width >= ResponsiveBreakpoints.tablet && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getPadding(BuildContext context) {
    return value(
      context: context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
      widescreen: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
    );
  }

  /// Get responsive font size multiplier
  static double getFontScale(BuildContext context) {
    return value(
      context: context,
      mobile: 1.0,
      tablet: 1.1,
      desktop: 1.15,
      widescreen: 1.2,
    );
  }
}

/// Extension for easy responsive access
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveBreakpoints.isMobile(this);
  bool get isTablet => ResponsiveBreakpoints.isTablet(this);
  bool get isDesktop => ResponsiveBreakpoints.isDesktop(this);
  bool get isWidescreen => ResponsiveBreakpoints.isWidescreen(this);

  EdgeInsets get responsivePadding => ResponsiveBreakpoints.getPadding(this);
  double get fontScale => ResponsiveBreakpoints.getFontScale(this);

  T responsive<T>({required T mobile, T? tablet, T? desktop, T? widescreen}) {
    return ResponsiveBreakpoints.value(
      context: this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      widescreen: widescreen,
    );
  }
}
