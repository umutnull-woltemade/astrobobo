import 'package:flutter/material.dart';

/// Mystical/ethereal color palette for the astrology app
class MysticalColors {
  MysticalColors._();

  // === PRIMARY PURPLES ===
  static const Color cosmicPurple = Color(0xFF2D1B4E);
  static const Color amethyst = Color(0xFF6B4C9A);
  static const Color lavender = Color(0xFF9D7EC2);
  static const Color violetMist = Color(0xFFB8A0D2);
  static const Color orchid = Color(0xFFDA70D6);

  // === CELESTIAL GOLDS ===
  static const Color starGold = Color(0xFFFFD700);
  static const Color antiqueGold = Color(0xFFD4AF37);
  static const Color champagne = Color(0xFFF7E7CE);
  static const Color amber = Color(0xFFFFBF00);
  static const Color bronzeGlow = Color(0xFFCD7F32);

  // === NIGHT SKY BLUES ===
  static const Color midnightBlue = Color(0xFF0D1B2A);
  static const Color cosmicNavy = Color(0xFF1B2838);
  static const Color nebulaTeal = Color(0xFF1A535C);
  static const Color stardustBlue = Color(0xFF4A6FA5);
  static const Color etherealCyan = Color(0xFF7FDBFF);

  // === COSMIC ACCENTS ===
  static const Color starlightWhite = Color(0xFFF8F6FF);
  static const Color moonSilver = Color(0xFFE8E4EF);
  static const Color nebulaRose = Color(0xFFE8B4BC);
  static const Color auroraGreen = Color(0xFF4FFFB0);
  static const Color solarOrange = Color(0xFFFF6B35);

  // === BACKGROUNDS ===
  static const Color bgDeepSpace = Color(0xFF0A0A14);
  static const Color bgNightSky = Color(0xFF12121C);
  static const Color bgCosmic = Color(0xFF1A1A2E);
  static const Color bgElevated = Color(0xFF252536);
  static const Color bgLight = Color(
    0xFFE8E0F0,
  ); // Softer lavender-gray background
  static const Color bgLightElevated = Color(
    0xFFF0EBF5,
  ); // Slightly darker cards

  // === TEXT COLORS ===
  static const Color textPrimary = Color(
    0xFFFFFFFF,
  ); // Pure white for maximum visibility
  static const Color textSecondary = Color(
    0xFFD4C8E8,
  ); // Lighter lavender for better contrast
  static const Color textMuted = Color(
    0xFF9A8AAF,
  ); // Lighter muted for better readability
  static const Color textGold = Color(0xFFFFD700);
  static const Color textDark = Color(
    0xFF1A1020,
  ); // Darker for light mode visibility
  static const Color textDarkSecondary = Color(
    0xFF3A3050,
  ); // Darker secondary text

  // === ZODIAC ELEMENT COLORS ===
  static const Color elementFire = Color(0xFFFF6B35);
  static const Color elementEarth = Color(0xFF4A7C59);
  static const Color elementAir = Color(0xFF7FDBFF);
  static const Color elementWater = Color(0xFF4A6FA5);

  // === PLANET COLORS ===
  static const Color planetSun = Color(0xFFFFD700);
  static const Color planetMoon = Color(0xFFE8E4EF);
  static const Color planetMercury = Color(0xFFB8B8B8);
  static const Color planetVenus = Color(0xFFE8B4BC);
  static const Color planetMars = Color(0xFFFF6B35);
  static const Color planetJupiter = Color(0xFFD4AF37);
  static const Color planetSaturn = Color(0xFF8B7355);
  static const Color planetUranus = Color(0xFF7FDBFF);
  static const Color planetNeptune = Color(0xFF4A6FA5);
  static const Color planetPluto = Color(0xFF6B4C9A);

  // === GRADIENTS ===
  static const List<Color> cosmicGradient = [
    Color(0xFF2D1B4E),
    Color(0xFF0D1B2A),
  ];

  static const List<Color> auroraGradient = [
    Color(0xFF6B4C9A),
    Color(0xFF4A6FA5),
    Color(0xFF4FFFB0),
  ];

  static const List<Color> goldGradient = [
    Color(0xFFFFD700),
    Color(0xFFD4AF37),
    Color(0xFFCD7F32),
  ];

  static const List<Color> nightSkyGradient = [
    Color(0xFF0A0A14),
    Color(0xFF1A1A2E),
    Color(0xFF2D1B4E),
  ];

  // === SHADOWS ===
  static List<BoxShadow> get glowPurple => [
    BoxShadow(
      color: amethyst.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get glowGold => [
    BoxShadow(
      color: starGold.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get shadowSm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowMd => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // === COLOR SCHEMES ===
  static ColorScheme get darkScheme => ColorScheme.dark(
    primary: amethyst,
    onPrimary: textPrimary,
    primaryContainer: cosmicPurple,
    onPrimaryContainer: lavender,
    secondary: starGold,
    onSecondary: bgDeepSpace,
    secondaryContainer: antiqueGold.withValues(alpha: 0.2),
    onSecondaryContainer: starGold,
    tertiary: nebulaTeal,
    onTertiary: textPrimary,
    error: solarOrange,
    onError: textPrimary,
    surface: bgCosmic,
    onSurface: textPrimary,
    surfaceContainerHighest: bgElevated,
    onSurfaceVariant: textSecondary,
    outline: textMuted,
    shadow: Colors.black,
  );

  static ColorScheme get lightScheme => ColorScheme.light(
    primary: cosmicPurple, // Darker primary for better contrast
    onPrimary: Colors.white,
    primaryContainer: amethyst,
    onPrimaryContainer: Colors.white,
    secondary: bronzeGlow, // Darker gold
    onSecondary: Colors.white,
    secondaryContainer: champagne,
    onSecondaryContainer: textDark,
    tertiary: nebulaTeal,
    onTertiary: Colors.white,
    error: solarOrange,
    onError: Colors.white,
    surface: bgLight,
    onSurface: textDark,
    surfaceContainerHighest: bgLightElevated,
    onSurfaceVariant: textDarkSecondary,
    outline: amethyst, // Darker outline
    shadow: cosmicPurple.withValues(alpha: 0.2),
  );
}
