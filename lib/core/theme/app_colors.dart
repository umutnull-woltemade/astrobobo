import 'package:flutter/material.dart';

/// Cosmic color palette for the astrology app
class AppColors {
  AppColors._();

  // Primary cosmic colors (dark mode)
  static const Color deepSpace = Color(0xFF0D0D1A);
  static const Color cosmicPurple = Color(0xFF1A1A2E);
  static const Color nebulaPurple = Color(0xFF16213E);
  static const Color mysticBlue = Color(0xFF0F3460);

  // Accent colors
  static const Color starGold = Color(0xFFFFD700);
  static const Color celestialGold = Color(0xFFF4C430);
  static const Color moonSilver = Color(0xFFC0C0C0);
  static const Color stardust = Color(0xFFE8E4E1);
  static const Color amethyst = Color(0xFF9B59B6);

  // Gradient colors
  static const Color auroraStart = Color(0xFF667EEA);
  static const Color auroraEnd = Color(0xFF764BA2);
  static const Color sunriseStart = Color(0xFFF093FB);
  static const Color sunriseEnd = Color(0xFFF5576C);
  static const Color twilightStart = Color(0xFF4776E6);
  static const Color twilightEnd = Color(0xFF8E54E9);

  // Zodiac element colors
  static const Color fireElement = Color(0xFFE74C3C);
  static const Color earthElement = Color(0xFF27AE60);
  static const Color airElement = Color(0xFF3498DB);
  static const Color waterElement = Color(0xFF9B59B6);

  // Text colors (dark mode)
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB8B8D1);
  static const Color textMuted = Color(0xFF8A8AA8);

  // Text colors (for theme-aware usage)
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textLight = Color(0xFF8A8AA8);

  // Cosmic accent
  static const Color cosmic = Color(0xFF667EEA);
  static const Color mystic = Color(0xFF8E54E9);
  static const Color gold = Color(0xFFFFD700);

  // Surface colors (dark mode)
  static const Color surfaceDark = Color(0xFF1E1E2E);
  static const Color surfaceLight = Color(0xFF2D2D44);
  static const Color cardBackground = Color(0xFF252540);

  // Status colors
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);

  // Planet colors
  static const Color saturnColor = Color(0xFF8B7355);
  static const Color jupiterColor = Color(0xFFD4A574);
  static const Color marsColor = Color(0xFFCD5C5C);
  static const Color venusColor = Color(0xFFFFB6C1);
  static const Color mercuryColor = Color(0xFFB8B8B8);

  // Venus brand color
  static const Color venusPink = Color(0xFFE91E8C);

  // ========== LIGHT MODE COLORS ==========

  // Light mode backgrounds
  static const Color lightBackground = Color(0xFFF8F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF0F2F8);
  static const Color lightCard = Color(0xFFFFFFFF);

  // Light mode text
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF4A4A6A);
  static const Color lightTextMuted = Color(0xFF8A8AA8);

  // Light mode accent (slightly darker for better contrast)
  static const Color lightAuroraStart = Color(0xFF5A6FD6);
  static const Color lightAuroraEnd = Color(0xFF6B4199);
  static const Color lightStarGold = Color(0xFFD4A800);

  // Common gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [auroraStart, auroraEnd],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceLight, surfaceDark],
  );

  static const LinearGradient lightCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightSurface, lightSurfaceVariant],
  );

  // ========== TANTRA COLORS ==========
  // Warm, sensual, grounding palette (non-explicit)
  static const Color tantraWarm = Color(0xFFC4A484); // Warm earth
  static const Color tantraCrimson = Color(0xFFBC544B); // Soft crimson
  static const Color tantraGold = Color(0xFFE8B4B8); // Rose gold
  static const Color tantraDeep = Color(0xFF8B5A2B); // Deep amber
  static const Color tantraIvory = Color(0xFFFDF6E3); // Cream ivory

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [starGold, celestialGold],
  );

  static const RadialGradient cosmicGlow = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [Color(0x30667EEA), Color(0x00667EEA)],
  );
}
