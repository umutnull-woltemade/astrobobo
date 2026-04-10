import 'dart:math' as math;
import 'package:flutter/material.dart';

/// InnerCycles Custom Icon System
///
/// Design rules:
/// - 24×24 base grid, 2px optical padding
/// - 1.8px stroke weight (premium sweet spot)
/// - Round caps + round joins (hand-crafted feel)
/// - Corner radius: 2.5px on geometric shapes
/// - Each icon has a unique silhouette recognizable at 16px
///
/// Style direction:
/// - Thin-to-medium stroke (NOT fintech-thin, NOT heavy)
/// - Slightly rounded geometry (approachable but premium)
/// - Optical balance > geometric perfection
/// - Cosmic metaphors reinterpreted, never cliché
class InnerCyclesIcons {
  InnerCyclesIcons._();

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB BAR ICONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Home — Horizon with rising celestial body
  /// Metaphor: The dawn moment, daily renewal, cosmic "now"
  /// NOT a generic house — this is YOUR cosmic home
  static Widget home({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HomePainter(color: color, filled: filled),
    );
  }

  /// Explore/Discover — Compass rose with star center
  /// Metaphor: Cosmic navigation, finding your path through the stars
  /// NOT a magnifying glass — you're not searching, you're navigating destiny
  static Widget explore({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ExplorePainter(color: color, filled: filled),
    );
  }

  /// Kozmoz — Abstract nebula spiral
  /// Metaphor: Cosmic intelligence, infinite knowledge, the universe speaking
  /// Center-elevated tab — the soul of the app
  static Widget kozmoz({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _KozmozPainter(color: color, filled: filled),
    );
  }

  /// Insights — Orbital rings with center dot
  /// Metaphor: Birth chart, planetary positions, celestial mechanics
  /// NOT a pie chart or bar graph — these are cosmic orbits
  static Widget insights({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _InsightsPainter(color: color, filled: filled),
    );
  }

  /// Profile — Crescent moon cradling a point of light
  /// Metaphor: The self as a celestial body, inner cosmos, personal identity
  /// NOT a generic person silhouette — you ARE a celestial being
  static Widget profile({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ProfilePainter(color: color, filled: filled),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // IN-APP ICONS (feature entry points)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Daily horoscope — Sun with soft rays
  static Widget dailySun({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DailySunPainter(color: color, filled: filled),
    );
  }

  /// Dream interpretation — Eye with crescent pupil
  static Widget dreamEye({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DreamEyePainter(color: color, filled: filled),
    );
  }

  /// Tarot — Layered cards with star
  static Widget tarotCards({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TarotCardsPainter(color: color, filled: filled),
    );
  }

  /// Compatibility — Two crescents facing each other
  static Widget compatibility({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CompatibilityPainter(color: color, filled: filled),
    );
  }

  /// Birth chart — Zodiac wheel segment
  static Widget birthChart({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BirthChartPainter(color: color, filled: filled),
    );
  }

  /// Numerology — Infinity with dot
  static Widget numerology({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NumerologyPainter(color: color, filled: filled),
    );
  }

  /// Chakra — Aligned dots (energy centers)
  static Widget chakra({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ChakraPainter(color: color, filled: filled),
    );
  }

  /// Calendar/Weekly — Crescent with lines
  static Widget weeklyMoon({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WeeklyMoonPainter(color: color, filled: filled),
    );
  }

  /// Share/Cosmic share — Radiating point
  static Widget cosmicShare({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CosmicSharePainter(color: color, filled: filled),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ICON PAINTERS — TAB BAR
// ═══════════════════════════════════════════════════════════════════════════════

/// Shared paint configuration for all icon painters
Paint _iconStroke(Color color, double strokeWidth) {
  return Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;
}

Paint _iconFill(Color color) {
  return Paint()
    ..color = color
    ..style = PaintingStyle.fill;
}

/// Home: Horizon line with rising celestial body above it
/// The horizon is a gentle curve (earth's curvature implied),
/// with a circle (sun/moon) rising above center.
/// Filled variant: circle is solid, horizon area gets a subtle fill.
class _HomePainter extends CustomPainter {
  final Color color;
  final bool filled;

  _HomePainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075; // 1.8 / 24
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final pad = s * 0.083; // optical padding

    // Horizon line — gentle arc
    final horizonY = s * 0.62;
    final horizonPath = Path()
      ..moveTo(pad, horizonY + s * 0.04)
      ..quadraticBezierTo(s * 0.5, horizonY - s * 0.06, s - pad, horizonY + s * 0.04);
    canvas.drawPath(horizonPath, stroke);

    // Rising body — circle above horizon center
    final bodyCenter = Offset(s * 0.5, s * 0.36);
    final bodyRadius = s * 0.14;

    if (filled) {
      canvas.drawCircle(bodyCenter, bodyRadius, fill);
      // Soft glow area below horizon
      final glowPath = Path()
        ..moveTo(pad + s * 0.05, horizonY + s * 0.04)
        ..quadraticBezierTo(s * 0.5, horizonY - s * 0.06, s - pad - s * 0.05, horizonY + s * 0.04)
        ..lineTo(s - pad - s * 0.05, horizonY + s * 0.12)
        ..quadraticBezierTo(s * 0.5, horizonY + s * 0.04, pad + s * 0.05, horizonY + s * 0.12)
        ..close();
      canvas.drawPath(glowPath, Paint()..color = color.withOpacity(0.15));
    } else {
      canvas.drawCircle(bodyCenter, bodyRadius, stroke);
    }

    // Three soft rays above the body
    final rayLength = s * 0.08;
    final rayStart = bodyCenter.dy - bodyRadius - s * 0.04;
    // Center ray
    canvas.drawLine(
      Offset(s * 0.5, rayStart),
      Offset(s * 0.5, rayStart - rayLength),
      stroke,
    );
    // Left ray
    canvas.drawLine(
      Offset(s * 0.35, rayStart + s * 0.02),
      Offset(s * 0.30, rayStart - rayLength + s * 0.03),
      stroke,
    );
    // Right ray
    canvas.drawLine(
      Offset(s * 0.65, rayStart + s * 0.02),
      Offset(s * 0.70, rayStart - rayLength + s * 0.03),
      stroke,
    );
  }

  @override
  bool shouldRepaint(_HomePainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Explore: Compass rose — four cardinal points with a star at center
/// Clean, geometric, but softened corners. Star is 4-pointed.
class _ExplorePainter extends CustomPainter {
  final Color color;
  final bool filled;

  _ExplorePainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Outer circle (compass body)
    final outerR = s * 0.40;
    if (filled) {
      canvas.drawCircle(center, outerR, Paint()..color = color.withOpacity(0.10));
    }
    canvas.drawCircle(center, outerR, stroke);

    // Cardinal tick marks
    final tickInner = s * 0.34;
    final tickOuter = s * 0.40;
    for (var angle in [0.0, math.pi / 2, math.pi, 3 * math.pi / 2]) {
      final dx = math.cos(angle);
      final dy = math.sin(angle);
      canvas.drawLine(
        Offset(center.dx + dx * tickInner, center.dy + dy * tickInner),
        Offset(center.dx + dx * tickOuter, center.dy + dy * tickOuter),
        stroke,
      );
    }

    // Center 4-pointed star
    final starSize = s * 0.14;
    final starInner = s * 0.05;
    final starPath = Path();
    for (var i = 0; i < 4; i++) {
      final angle = -math.pi / 2 + (i * math.pi / 2);
      final midAngle = angle + math.pi / 4;
      final outerX = center.dx + math.cos(angle) * starSize;
      final outerY = center.dy + math.sin(angle) * starSize;
      final innerX = center.dx + math.cos(midAngle) * starInner;
      final innerY = center.dy + math.sin(midAngle) * starInner;

      if (i == 0) {
        starPath.moveTo(outerX, outerY);
      } else {
        starPath.lineTo(outerX, outerY);
      }
      starPath.lineTo(innerX, innerY);
    }
    starPath.close();

    if (filled) {
      canvas.drawPath(starPath, fill);
    } else {
      canvas.drawPath(starPath, stroke);
    }

    // North indicator — small triangle at top
    final northPath = Path()
      ..moveTo(s * 0.5, s * 0.04)
      ..lineTo(s * 0.46, s * 0.10)
      ..lineTo(s * 0.54, s * 0.10)
      ..close();
    canvas.drawPath(northPath, filled ? fill : stroke);
  }

  @override
  bool shouldRepaint(_ExplorePainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Kozmoz: Abstract nebula spiral
/// A logarithmic spiral emanating from a center point,
/// with small dots along the spiral path suggesting stars/particles.
class _KozmozPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _KozmozPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Center dot
    final dotR = filled ? s * 0.06 : s * 0.04;
    canvas.drawCircle(center, dotR, fill);

    // Spiral path — Archimedean spiral
    final spiralPath = Path();
    final turns = 2.2;
    final maxR = s * 0.38;
    final minR = s * 0.06;
    final totalAngle = turns * 2 * math.pi;
    final steps = 80;

    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final angle = t * totalAngle - math.pi / 2;
      final r = minR + (maxR - minR) * t;
      final x = center.dx + math.cos(angle) * r;
      final y = center.dy + math.sin(angle) * r;

      if (i == 0) {
        spiralPath.moveTo(x, y);
      } else {
        spiralPath.lineTo(x, y);
      }
    }

    canvas.drawPath(spiralPath, stroke);

    if (filled) {
      // Glow background
      canvas.drawCircle(
        center,
        s * 0.35,
        Paint()..color = color.withOpacity(0.08),
      );
    }

    // Small star dots along the outer portion of the spiral
    for (var i = 0; i < 3; i++) {
      final t = 0.55 + i * 0.17;
      final angle = t * totalAngle - math.pi / 2;
      final r = minR + (maxR - minR) * t;
      final x = center.dx + math.cos(angle) * r;
      final y = center.dy + math.sin(angle) * r;
      canvas.drawCircle(Offset(x, y), s * 0.025, fill);
    }
  }

  @override
  bool shouldRepaint(_KozmozPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Insights: Concentric orbital rings with a dot at center
/// Two tilted ellipses (like an atom or birth chart orbits)
/// with a solid dot at the center representing the self.
class _InsightsPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _InsightsPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Center dot (the self)
    canvas.drawCircle(center, filled ? s * 0.06 : s * 0.04, fill);

    // Orbit 1 — tilted ~20° clockwise
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(20 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: s * 0.75, height: s * 0.35),
      stroke,
    );
    canvas.restore();

    // Orbit 2 — tilted ~-30°
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-30 * math.pi / 180);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: s * 0.70, height: s * 0.30),
      stroke,
    );
    canvas.restore();

    // Small planet dots on orbits
    if (filled) {
      // Planet on orbit 1
      final p1Angle = 45 * math.pi / 180;
      final p1Orbit = 20 * math.pi / 180;
      final rx1 = s * 0.375;
      final ry1 = s * 0.175;
      final p1x = math.cos(p1Angle) * rx1;
      final p1y = math.sin(p1Angle) * ry1;
      final rotP1x = p1x * math.cos(p1Orbit) - p1y * math.sin(p1Orbit);
      final rotP1y = p1x * math.sin(p1Orbit) + p1y * math.cos(p1Orbit);
      canvas.drawCircle(
        Offset(center.dx + rotP1x, center.dy + rotP1y),
        s * 0.035,
        fill,
      );

      // Planet on orbit 2
      final p2Angle = -60 * math.pi / 180;
      final p2Orbit = -30 * math.pi / 180;
      final rx2 = s * 0.35;
      final ry2 = s * 0.15;
      final p2x = math.cos(p2Angle) * rx2;
      final p2y = math.sin(p2Angle) * ry2;
      final rotP2x = p2x * math.cos(p2Orbit) - p2y * math.sin(p2Orbit);
      final rotP2y = p2x * math.sin(p2Orbit) + p2y * math.cos(p2Orbit);
      canvas.drawCircle(
        Offset(center.dx + rotP2x, center.dy + rotP2y),
        s * 0.035,
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(_InsightsPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Profile: Crescent moon cradling a point of light
/// A crescent (created by overlapping two circles) with
/// a small star/dot in the concavity. The crescent represents
/// the self as a celestial body — personal, introspective.
class _ProfilePainter extends CustomPainter {
  final Color color;
  final bool filled;

  _ProfilePainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final fill = _iconFill(color);

    final mainR = s * 0.30;
    final mainCenter = Offset(s * 0.45, s * 0.45);
    final cutR = s * 0.26;
    final cutCenter = Offset(s * 0.58, s * 0.38);

    // Create crescent path
    final crescentPath = Path();
    // Full circle
    crescentPath.addOval(
      Rect.fromCircle(center: mainCenter, radius: mainR),
    );
    // Cut-out circle
    final cutPath = Path()
      ..addOval(Rect.fromCircle(center: cutCenter, radius: cutR));
    final crescent = Path.combine(PathOperation.difference, crescentPath, cutPath);

    if (filled) {
      canvas.drawPath(crescent, fill);
    } else {
      canvas.drawPath(
        crescent,
        _iconStroke(color, sw)..style = PaintingStyle.stroke,
      );
      // Also draw a very thin fill for better silhouette
      canvas.drawPath(
        crescent,
        Paint()..color = color.withOpacity(0.05),
      );
    }

    // Star point in the crescent's concavity
    final starCenter = Offset(s * 0.68, s * 0.52);
    final starR = s * 0.04;
    canvas.drawCircle(starCenter, starR, fill);

    // Tiny rays from the star
    final rayLen = s * 0.05;
    final rayStroke = _iconStroke(color, sw * 0.7);
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + math.pi / 4;
      canvas.drawLine(
        Offset(
          starCenter.dx + math.cos(angle) * (starR + s * 0.015),
          starCenter.dy + math.sin(angle) * (starR + s * 0.015),
        ),
        Offset(
          starCenter.dx + math.cos(angle) * (starR + rayLen),
          starCenter.dy + math.sin(angle) * (starR + rayLen),
        ),
        rayStroke,
      );
    }
  }

  @override
  bool shouldRepaint(_ProfilePainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ICON PAINTERS — IN-APP FEATURE ICONS
// ═══════════════════════════════════════════════════════════════════════════════

/// Daily Sun: Circle with 6 soft rays, alternating lengths
class _DailySunPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _DailySunPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);
    final bodyR = s * 0.16;

    if (filled) {
      canvas.drawCircle(center, bodyR, fill);
    } else {
      canvas.drawCircle(center, bodyR, stroke);
    }

    // 8 rays alternating long/short
    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final isLong = i % 2 == 0;
      final start = bodyR + s * 0.04;
      final end = start + (isLong ? s * 0.10 : s * 0.06);
      canvas.drawLine(
        Offset(center.dx + math.cos(angle) * start, center.dy + math.sin(angle) * start),
        Offset(center.dx + math.cos(angle) * end, center.dy + math.sin(angle) * end),
        stroke,
      );
    }
  }

  @override
  bool shouldRepaint(_DailySunPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Dream Eye: Almond-shaped eye with crescent pupil
class _DreamEyePainter extends CustomPainter {
  final Color color;
  final bool filled;

  _DreamEyePainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Eye outline — two arcs meeting at points
    final eyePath = Path()
      ..moveTo(s * 0.08, center.dy)
      ..quadraticBezierTo(s * 0.5, s * 0.20, s * 0.92, center.dy)
      ..quadraticBezierTo(s * 0.5, s * 0.80, s * 0.08, center.dy);

    if (filled) {
      canvas.drawPath(eyePath, Paint()..color = color.withOpacity(0.08));
    }
    canvas.drawPath(eyePath, stroke);

    // Pupil — crescent inside the eye
    final pupilR = s * 0.12;
    final pupilCenter = Offset(s * 0.48, s * 0.5);
    if (filled) {
      canvas.drawCircle(pupilCenter, pupilR, fill);
    } else {
      canvas.drawCircle(pupilCenter, pupilR, stroke);
    }

    // Inner crescent cut (to make it dreamy)
    final innerDot = Offset(s * 0.52, s * 0.46);
    canvas.drawCircle(innerDot, s * 0.035, fill);
  }

  @override
  bool shouldRepaint(_DreamEyePainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Tarot Cards: Two overlapping rounded rectangles with a star on top card
class _TarotCardsPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _TarotCardsPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final r = s * 0.06; // corner radius

    // Back card (slightly rotated)
    canvas.save();
    canvas.translate(s * 0.5, s * 0.5);
    canvas.rotate(-8 * math.pi / 180);
    final backCard = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: s * 0.42, height: s * 0.62),
      Radius.circular(r),
    );
    if (filled) {
      canvas.drawRRect(backCard, Paint()..color = color.withOpacity(0.15));
    }
    canvas.drawRRect(backCard, stroke);
    canvas.restore();

    // Front card (slightly rotated other way)
    canvas.save();
    canvas.translate(s * 0.5, s * 0.5);
    canvas.rotate(5 * math.pi / 180);
    final frontCard = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(s * 0.04, 0), width: s * 0.42, height: s * 0.62),
      Radius.circular(r),
    );
    if (filled) {
      canvas.drawRRect(frontCard, Paint()..color = color.withOpacity(0.25));
    }
    canvas.drawRRect(frontCard, stroke);

    // Star on front card
    final starCenter = Offset(s * 0.04, -s * 0.02);
    _drawMiniStar(canvas, starCenter, s * 0.08, fill);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TarotCardsPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Compatibility: Two crescents facing each other, forming a gentle embrace
class _CompatibilityPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _CompatibilityPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final fill = _iconFill(color);

    // Left crescent (opening right)
    final leftMain = Offset(s * 0.32, s * 0.5);
    final leftCut = Offset(s * 0.42, s * 0.5);
    final crescentR = s * 0.22;
    final cutR = s * 0.18;

    final leftPath = Path()
      ..addOval(Rect.fromCircle(center: leftMain, radius: crescentR));
    final leftCutPath = Path()
      ..addOval(Rect.fromCircle(center: leftCut, radius: cutR));
    final leftCrescent = Path.combine(PathOperation.difference, leftPath, leftCutPath);

    // Right crescent (opening left) — mirror
    final rightMain = Offset(s * 0.68, s * 0.5);
    final rightCut = Offset(s * 0.58, s * 0.5);

    final rightPath = Path()
      ..addOval(Rect.fromCircle(center: rightMain, radius: crescentR));
    final rightCutPath = Path()
      ..addOval(Rect.fromCircle(center: rightCut, radius: cutR));
    final rightCrescent = Path.combine(PathOperation.difference, rightPath, rightCutPath);

    if (filled) {
      canvas.drawPath(leftCrescent, fill);
      canvas.drawPath(rightCrescent, fill);
    } else {
      canvas.drawPath(leftCrescent, _iconStroke(color, sw));
      canvas.drawPath(rightCrescent, _iconStroke(color, sw));
    }

    // Center sparkle between crescents
    final sparkCenter = Offset(s * 0.5, s * 0.5);
    canvas.drawCircle(sparkCenter, s * 0.025, fill);
  }

  Paint _iconStroke(Color color, double sw) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  @override
  bool shouldRepaint(_CompatibilityPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Birth Chart: Circle with cross dividers and small dots (simplified zodiac wheel)
class _BirthChartPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _BirthChartPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);
    final outerR = s * 0.38;
    final innerR = s * 0.28;

    // Outer ring
    canvas.drawCircle(center, outerR, stroke);
    // Inner ring
    canvas.drawCircle(center, innerR, stroke);

    // Cross lines (house dividers)
    for (var angle in [0.0, math.pi / 2, math.pi, 3 * math.pi / 2]) {
      canvas.drawLine(
        Offset(center.dx + math.cos(angle) * innerR, center.dy + math.sin(angle) * innerR),
        Offset(center.dx + math.cos(angle) * outerR, center.dy + math.sin(angle) * outerR),
        stroke,
      );
    }

    // Center dot
    canvas.drawCircle(center, s * 0.035, fill);

    if (filled) {
      // Fill between rings
      final ringPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: outerR))
        ..addOval(Rect.fromCircle(center: center, radius: innerR));
      ringPath.fillType = PathFillType.evenOdd;
      canvas.drawPath(ringPath, Paint()..color = color.withOpacity(0.10));
    }
  }

  @override
  bool shouldRepaint(_BirthChartPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Numerology: Infinity symbol (lemniscate) with dot at intersection
class _NumerologyPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _NumerologyPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Lemniscate path
    final path = Path();
    final lobeW = s * 0.28;
    final lobeH = s * 0.20;
    final steps = 60;

    for (var i = 0; i <= steps; i++) {
      final t = (i / steps) * 2 * math.pi;
      final denom = 1 + math.sin(t) * math.sin(t);
      final x = center.dx + (lobeW * math.cos(t)) / denom;
      final y = center.dy + (lobeH * math.sin(t) * math.cos(t)) / denom;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    if (filled) {
      canvas.drawPath(path, Paint()..color = color.withOpacity(0.12));
    }
    canvas.drawPath(path, stroke);

    // Intersection dot
    canvas.drawCircle(center, s * 0.04, fill);
  }

  @override
  bool shouldRepaint(_NumerologyPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Chakra: Vertical line with 7 aligned dots (energy centers)
class _ChakraPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _ChakraPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);

    final topY = s * 0.10;
    final bottomY = s * 0.90;
    final centerX = s * 0.5;

    // Central axis line
    canvas.drawLine(Offset(centerX, topY), Offset(centerX, bottomY), stroke);

    // 7 chakra dots
    final count = 7;
    final spacing = (bottomY - topY) / (count - 1);
    for (var i = 0; i < count; i++) {
      final y = bottomY - i * spacing;
      // Size varies — heart center is largest
      final dist = (i - 3).abs();
      final dotR = s * (0.05 - dist * 0.005);
      if (filled) {
        canvas.drawCircle(Offset(centerX, y), dotR, fill);
      } else {
        canvas.drawCircle(Offset(centerX, y), dotR, stroke);
        canvas.drawCircle(Offset(centerX, y), dotR * 0.3, fill);
      }
    }
  }

  @override
  bool shouldRepaint(_ChakraPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Weekly Moon: Crescent with three horizontal lines (calendar + moon)
class _WeeklyMoonPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _WeeklyMoonPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);

    // Crescent on the left
    final mainCenter = Offset(s * 0.28, s * 0.5);
    final mainR = s * 0.22;
    final cutCenter = Offset(s * 0.38, s * 0.45);
    final cutR = s * 0.18;

    final mainPath = Path()..addOval(Rect.fromCircle(center: mainCenter, radius: mainR));
    final cutPath = Path()..addOval(Rect.fromCircle(center: cutCenter, radius: cutR));
    final crescent = Path.combine(PathOperation.difference, mainPath, cutPath);

    if (filled) {
      canvas.drawPath(crescent, fill);
    } else {
      canvas.drawPath(crescent, stroke);
    }

    // Three lines to the right (week days)
    final lineX1 = s * 0.52;
    final lineX2 = s * 0.88;
    for (var i = 0; i < 3; i++) {
      final y = s * 0.35 + i * s * 0.15;
      canvas.drawLine(Offset(lineX1, y), Offset(lineX2, y), stroke);
    }
  }

  @override
  bool shouldRepaint(_WeeklyMoonPainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

/// Cosmic Share: Central point with 3 radiating lines ending in dots
class _CosmicSharePainter extends CustomPainter {
  final Color color;
  final bool filled;

  _CosmicSharePainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final sw = s * 0.075;
    final stroke = _iconStroke(color, sw);
    final fill = _iconFill(color);
    final center = Offset(s * 0.5, s * 0.5);

    // Center body
    canvas.drawCircle(center, s * 0.08, filled ? fill : stroke);

    // 3 radiating connections
    final angles = [-math.pi / 3, math.pi / 6, 2 * math.pi / 3];
    final endR = s * 0.35;
    final dotR = s * 0.055;

    for (final angle in angles) {
      final endPoint = Offset(
        center.dx + math.cos(angle) * endR,
        center.dy + math.sin(angle) * endR,
      );
      canvas.drawLine(center, endPoint, stroke);
      if (filled) {
        canvas.drawCircle(endPoint, dotR, fill);
      } else {
        canvas.drawCircle(endPoint, dotR, stroke);
      }
    }
  }

  @override
  bool shouldRepaint(_CosmicSharePainter oldDelegate) =>
      color != oldDelegate.color || filled != oldDelegate.filled;
}

// ═══════════════════════════════════════════════════════════════════════════════
// UTILITY
// ═══════════════════════════════════════════════════════════════════════════════

/// Draw a small 4-pointed star at the given center
void _drawMiniStar(Canvas canvas, Offset center, double size, Paint paint) {
  final path = Path();
  for (var i = 0; i < 4; i++) {
    final outerAngle = -math.pi / 2 + i * math.pi / 2;
    final innerAngle = outerAngle + math.pi / 4;
    final ox = center.dx + math.cos(outerAngle) * size;
    final oy = center.dy + math.sin(outerAngle) * size;
    final ix = center.dx + math.cos(innerAngle) * size * 0.35;
    final iy = center.dy + math.sin(innerAngle) * size * 0.35;
    if (i == 0) {
      path.moveTo(ox, oy);
    } else {
      path.lineTo(ox, oy);
    }
    path.lineTo(ix, iy);
  }
  path.close();
  canvas.drawPath(path, paint);
}
