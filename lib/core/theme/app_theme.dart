import 'package:flutter/material.dart';
import 'mystical_colors.dart';
import 'mystical_typography.dart';
import 'spacing.dart';

/// App theme configuration with dark and light modes
class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: MysticalColors.darkScheme,
    // Smooth page transitions with swipe-back gesture (iOS style)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
      },
    ),
    textTheme: MysticalTypography.textTheme.apply(
      bodyColor: MysticalColors.textPrimary,
      displayColor: MysticalColors.textPrimary,
    ),
    scaffoldBackgroundColor: MysticalColors.bgDeepSpace,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: MysticalColors.textPrimary),
    ),
    cardTheme: CardThemeData(
      color: MysticalColors.bgCosmic,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MysticalColors.amethyst,
        foregroundColor: MysticalColors.textPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.xl,
          vertical: Spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MysticalColors.starGold,
        side: const BorderSide(color: MysticalColors.starGold),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.xl,
          vertical: Spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MysticalColors.bgElevated,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: BorderSide(
          color: MysticalColors.textMuted.withValues(alpha: 0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: const BorderSide(color: MysticalColors.amethyst),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: MysticalColors.textMuted,
      thickness: 0.5,
    ),
    iconTheme: const IconThemeData(
      color: MysticalColors.textSecondary,
      size: Spacing.iconMd,
    ),
  );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: MysticalColors.lightScheme,
    // Smooth page transitions with swipe-back gesture (iOS style)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
      },
    ),
    textTheme: MysticalTypography.textTheme.apply(
      bodyColor: MysticalColors.textDark,
      displayColor: MysticalColors.textDark,
    ),
    scaffoldBackgroundColor: MysticalColors.bgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: MysticalColors.textDark),
    ),
    cardTheme: CardThemeData(
      color: MysticalColors.bgLightElevated,
      elevation: 2,
      shadowColor: MysticalColors.amethyst.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MysticalColors.amethyst,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.xl,
          vertical: Spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MysticalColors.amethyst,
        side: const BorderSide(color: MysticalColors.amethyst),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.xl,
          vertical: Spacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MysticalColors.bgLightElevated,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: BorderSide(
          color: MysticalColors.violetMist.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        borderSide: const BorderSide(color: MysticalColors.amethyst),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: MysticalColors.violetMist,
      thickness: 0.5,
    ),
    iconTheme: const IconThemeData(
      color: MysticalColors.textDarkSecondary,
      size: Spacing.iconMd,
    ),
  );
}
