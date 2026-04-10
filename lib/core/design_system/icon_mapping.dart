import 'package:flutter/material.dart';
import 'inner_cycles_icons.dart';

/// Maps feature categories to their custom InnerCycles icons.
///
/// Usage:
/// ```dart
/// Container(
///   child: IconMapping.forCategory('horoscope', size: 22, color: gold),
/// )
/// ```
///
/// Design rule: UI chrome icons (chevron, close, check, lock, etc.) stay
/// as Material Icons. Only BRAND-VISIBLE feature icons get custom treatment.
class IconMapping {
  IconMapping._();

  /// Returns the custom icon widget for a given category/feature key.
  /// Falls back to a styled Material Icon if no custom icon exists.
  static Widget forCategory(
    String key, {
    required double size,
    required Color color,
    bool filled = false,
  }) {
    switch (key) {
      // ── Tab bar categories ──
      case 'home':
        return InnerCyclesIcons.home(size: size, color: color, filled: filled);
      case 'explore':
      case 'discover':
      case 'allServices':
        return InnerCyclesIcons.explore(size: size, color: color, filled: filled);
      case 'kozmoz':
      case 'cosmic':
      case 'magic':
      case 'autoAwesome':
        return InnerCyclesIcons.kozmoz(size: size, color: color, filled: filled);
      case 'insights':
      case 'astrology':
      case 'astroCartography':
        return InnerCyclesIcons.insights(size: size, color: color, filled: filled);
      case 'profile':
      case 'person':
        return InnerCyclesIcons.profile(size: size, color: color, filled: filled);

      // ── Feature icons ──
      case 'horoscope':
      case 'dailyHoroscope':
      case 'sun':
      case 'sunny':
        return InnerCyclesIcons.dailySun(size: size, color: color, filled: filled);
      case 'dream':
      case 'dreamInterpretation':
      case 'nightlight':
      case 'nightsStay':
        return InnerCyclesIcons.dreamEye(size: size, color: color, filled: filled);
      case 'tarot':
      case 'cards':
      case 'style':
        return InnerCyclesIcons.tarotCards(size: size, color: color, filled: filled);
      case 'compatibility':
      case 'love':
      case 'favorite':
      case 'heart':
      case 'synastry':
        return InnerCyclesIcons.compatibility(size: size, color: color, filled: filled);
      case 'birthChart':
      case 'natalChart':
      case 'pieChart':
      case 'chart':
        return InnerCyclesIcons.birthChart(size: size, color: color, filled: filled);
      case 'numerology':
      case 'numbers':
      case 'lifeNumber':
        return InnerCyclesIcons.numerology(size: size, color: color, filled: filled);
      case 'chakra':
      case 'energy':
      case 'reiki':
      case 'blurCircular':
        return InnerCyclesIcons.chakra(size: size, color: color, filled: filled);
      case 'weekly':
      case 'monthly':
      case 'calendar':
      case 'moon':
        return InnerCyclesIcons.weeklyMoon(size: size, color: color, filled: filled);
      case 'share':
      case 'cosmicShare':
      case 'ritual':
        return InnerCyclesIcons.cosmicShare(size: size, color: color, filled: filled);

      // ── Fallback: return sized box (caller should handle) ──
      default:
        return SizedBox(width: size, height: size);
    }
  }

  /// Maps a Material Icons IconData to the closest custom icon.
  /// Returns null if no custom mapping exists (keep Material Icon).
  static Widget? fromMaterialIcon(
    IconData icon, {
    required double size,
    required Color color,
    bool filled = false,
  }) {
    if (icon == Icons.wb_sunny_outlined || icon == Icons.wb_sunny) {
      return InnerCyclesIcons.dailySun(size: size, color: color, filled: filled);
    }
    if (icon == Icons.nights_stay_outlined || icon == Icons.nightlight_round ||
        icon == Icons.nightlight_outlined || icon == Icons.bedtime_outlined) {
      return InnerCyclesIcons.dreamEye(size: size, color: color, filled: filled);
    }
    if (icon == Icons.style_outlined || icon == Icons.style) {
      return InnerCyclesIcons.tarotCards(size: size, color: color, filled: filled);
    }
    if (icon == Icons.favorite_border_outlined || icon == Icons.favorite_outlined ||
        icon == Icons.favorite || icon == Icons.favorite_border) {
      return InnerCyclesIcons.compatibility(size: size, color: color, filled: filled);
    }
    if (icon == Icons.pie_chart_outline || icon == Icons.pie_chart) {
      return InnerCyclesIcons.birthChart(size: size, color: color, filled: filled);
    }
    if (icon == Icons.numbers_outlined || icon == Icons.numbers) {
      return InnerCyclesIcons.numerology(size: size, color: color, filled: filled);
    }
    if (icon == Icons.blur_circular_outlined || icon == Icons.blur_circular ||
        icon == Icons.spa_outlined || icon == Icons.spa) {
      return InnerCyclesIcons.chakra(size: size, color: color, filled: filled);
    }
    if (icon == Icons.auto_awesome_outlined || icon == Icons.auto_awesome) {
      return InnerCyclesIcons.kozmoz(size: size, color: color, filled: filled);
    }
    if (icon == Icons.calendar_month_outlined || icon == Icons.calendar_month ||
        icon == Icons.calendar_today_outlined || icon == Icons.calendar_today) {
      return InnerCyclesIcons.weeklyMoon(size: size, color: color, filled: filled);
    }
    if (icon == Icons.home_outlined || icon == Icons.home) {
      return InnerCyclesIcons.home(size: size, color: color, filled: filled);
    }
    if (icon == Icons.person_outline || icon == Icons.person) {
      return InnerCyclesIcons.profile(size: size, color: color, filled: filled);
    }
    if (icon == Icons.explore_outlined || icon == Icons.explore) {
      return InnerCyclesIcons.explore(size: size, color: color, filled: filled);
    }
    if (icon == Icons.compare_arrows_outlined || icon == Icons.compare_arrows) {
      return InnerCyclesIcons.compatibility(size: size, color: color, filled: filled);
    }
    // No custom mapping — keep Material Icon
    return null;
  }
}
