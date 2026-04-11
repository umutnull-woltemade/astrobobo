import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/natal_chart.dart';
import '../../../../data/models/planet.dart';
import '../../../../data/models/aspect.dart';
import '../../../../data/models/house.dart';
import '../../../../data/models/zodiac_sign.dart';

/// A circular natal chart wheel visualization
class NatalChartWheel extends StatelessWidget {
  final NatalChart chart;
  final bool showAspects;
  final bool showHouses;
  final double size;

  const NatalChartWheel({
    super.key,
    required this.chart,
    this.showAspects = true,
    this.showHouses = true,
    this.size = 320,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ChartWheelPainter(
          chart: chart,
          showAspects: showAspects,
          showHouses: showHouses,
        ),
      ),
    );
  }
}

class _ChartWheelPainter extends CustomPainter {
  final NatalChart chart;
  final bool showAspects;
  final bool showHouses;

  _ChartWheelPainter({
    required this.chart,
    required this.showAspects,
    required this.showHouses,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Define ring radii
    final outerRingRadius = radius * 0.98;
    final zodiacOuterRadius = radius * 0.92;
    final zodiacInnerRadius = radius * 0.78;
    final planetRingRadius = radius * 0.60;
    final aspectCircleRadius = radius * 0.42;

    // Get ascendant degree for chart rotation (ASC on left side = 180°)
    final ascDegree = chart.ascendant?.longitude ?? 0;

    // Draw layers from outer to inner
    _drawOuterRing(canvas, center, outerRingRadius);
    _drawZodiacRing(
      canvas,
      center,
      zodiacOuterRadius,
      zodiacInnerRadius,
      ascDegree,
    );
    _drawHouseDivisions(
      canvas,
      center,
      zodiacInnerRadius,
      aspectCircleRadius,
      ascDegree,
    );
    _drawInnerCircle(canvas, center, aspectCircleRadius);

    if (showAspects) {
      _drawAspectLines(canvas, center, aspectCircleRadius * 0.95, ascDegree);
    }

    _drawPlanets(canvas, center, planetRingRadius, ascDegree);
  }

  void _drawOuterRing(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = AppColors.surfaceLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, paint);
  }

  void _drawZodiacRing(
    Canvas canvas,
    Offset center,
    double outerRadius,
    double innerRadius,
    double ascDegree,
  ) {
    final zodiacSigns = ZodiacSign.values;

    for (int i = 0; i < 12; i++) {
      final sign = zodiacSigns[i];
      final startAngle = _degreeToRadians(i * 30 - ascDegree + 180);
      final sweepAngle = _degreeToRadians(30);

      // Draw segment background
      final segmentPaint = Paint()
        ..color = sign.color.withAlpha(40)
        ..style = PaintingStyle.fill;

      final path = Path()
        ..moveTo(
          center.dx + innerRadius * math.cos(startAngle),
          center.dy + innerRadius * math.sin(startAngle),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: innerRadius),
          startAngle,
          sweepAngle,
          false,
        )
        ..lineTo(
          center.dx + outerRadius * math.cos(startAngle + sweepAngle),
          center.dy + outerRadius * math.sin(startAngle + sweepAngle),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: outerRadius),
          startAngle + sweepAngle,
          -sweepAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, segmentPaint);

      // Draw segment border
      final borderPaint = Paint()
        ..color = sign.color.withAlpha(100)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawPath(path, borderPaint);

      // Draw zodiac symbol
      final midAngle = startAngle + sweepAngle / 2;
      final symbolRadius = (outerRadius + innerRadius) / 2;
      final symbolX = center.dx + symbolRadius * math.cos(midAngle);
      final symbolY = center.dy + symbolRadius * math.sin(midAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: sign.symbol,
          style: TextStyle(
            color: sign.color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          symbolX - textPainter.width / 2,
          symbolY - textPainter.height / 2,
        ),
      );
    }
  }

  void _drawHouseDivisions(
    Canvas canvas,
    Offset center,
    double outerRadius,
    double innerRadius,
    double ascDegree,
  ) {
    if (!showHouses || chart.houses.isEmpty) return;

    final housePaint = Paint()
      ..color = AppColors.textMuted.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final acsPaint = Paint()
      ..color = AppColors.fireElement
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final mcPaint = Paint()
      ..color = AppColors.auroraStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < chart.houses.length; i++) {
      final houseCusp = chart.houses[i];
      final angle = _degreeToRadians(houseCusp.longitude - ascDegree + 180);

      // Choose paint based on house
      Paint linePaint;
      if (houseCusp.house.number == 1) {
        linePaint = acsPaint;
      } else if (houseCusp.house.number == 10) {
        linePaint = mcPaint;
      } else {
        linePaint = housePaint;
      }

      final startX = center.dx + innerRadius * math.cos(angle);
      final startY = center.dy + innerRadius * math.sin(angle);
      final endX = center.dx + outerRadius * math.cos(angle);
      final endY = center.dy + outerRadius * math.sin(angle);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), linePaint);

      // Draw house number
      final numberRadius = innerRadius + (outerRadius - innerRadius) * 0.3;
      final nextHouse = chart.houses[(i + 1) % 12];
      final midCusp =
          (houseCusp.longitude + nextHouse.longitude) / 2 +
          (nextHouse.longitude < houseCusp.longitude ? 180 : 0);
      final numberAngle = _degreeToRadians(midCusp - ascDegree + 180);

      final numberX = center.dx + numberRadius * math.cos(numberAngle);
      final numberY = center.dy + numberRadius * math.sin(numberAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: houseCusp.house.number.toString(),
          style: TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          numberX - textPainter.width / 2,
          numberY - textPainter.height / 2,
        ),
      );
    }
  }

  void _drawInnerCircle(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = AppColors.surfaceLight.withAlpha(50)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);

    final borderPaint = Paint()
      ..color = AppColors.surfaceLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius, borderPaint);
  }

  void _drawAspectLines(
    Canvas canvas,
    Offset center,
    double radius,
    double ascDegree,
  ) {
    // Only draw major aspects
    final aspects = chart.majorAspects;

    for (final aspect in aspects) {
      // Find planet positions
      final planet1Pos = _findPlanetPosition(aspect.planet1);
      final planet2Pos = _findPlanetPosition(aspect.planet2);

      if (planet1Pos == null || planet2Pos == null) continue;

      final angle1 = _degreeToRadians(planet1Pos.longitude - ascDegree + 180);
      final angle2 = _degreeToRadians(planet2Pos.longitude - ascDegree + 180);

      final x1 = center.dx + radius * math.cos(angle1);
      final y1 = center.dy + radius * math.sin(angle1);
      final x2 = center.dx + radius * math.cos(angle2);
      final y2 = center.dy + radius * math.sin(angle2);

      final linePaint = Paint()
        ..color = aspect.type.color.withAlpha(aspect.type.isMajor ? 150 : 80)
        ..style = PaintingStyle.stroke
        ..strokeWidth = aspect.type.isMajor ? 1.5 : 1;

      // Dashed line for challenging aspects
      if (aspect.type.isChallenging) {
        _drawDashedLine(canvas, Offset(x1, y1), Offset(x2, y2), linePaint);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 5.0;
    const gapLength = 3.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final dashCount = (distance / (dashLength + gapLength)).floor();

    final unitX = dx / distance;
    final unitY = dy / distance;

    for (int i = 0; i < dashCount; i++) {
      final startX = start.dx + (dashLength + gapLength) * i * unitX;
      final startY = start.dy + (dashLength + gapLength) * i * unitY;
      final endX = startX + dashLength * unitX;
      final endY = startY + dashLength * unitY;

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  void _drawPlanets(
    Canvas canvas,
    Offset center,
    double radius,
    double ascDegree,
  ) {
    // Filter to main planets only (exclude angles and some points for clarity)
    final planetsToShow = chart.planets
        .where(
          (p) =>
              p.planet != Planet.ascendant &&
              p.planet != Planet.midheaven &&
              p.planet != Planet.ic &&
              p.planet != Planet.descendant,
        )
        .toList();

    // Group planets that are close together to prevent overlap
    final planetGroups = _groupClosePlanets(planetsToShow, 8);

    for (final group in planetGroups) {
      if (group.length == 1) {
        _drawSinglePlanet(canvas, center, radius, group[0], ascDegree);
      } else {
        _drawPlanetGroup(canvas, center, radius, group, ascDegree);
      }
    }
  }

  List<List<PlanetPosition>> _groupClosePlanets(
    List<PlanetPosition> planets,
    double threshold,
  ) {
    if (planets.isEmpty) return [];

    // Sort by longitude
    final sorted = List<PlanetPosition>.from(planets)
      ..sort((a, b) => a.longitude.compareTo(b.longitude));

    final groups = <List<PlanetPosition>>[];
    var currentGroup = <PlanetPosition>[sorted.first];

    for (int i = 1; i < sorted.length; i++) {
      final diff = sorted[i].longitude - sorted[i - 1].longitude;
      if (diff < threshold) {
        currentGroup.add(sorted[i]);
      } else {
        groups.add(currentGroup);
        currentGroup = [sorted[i]];
      }
    }
    groups.add(currentGroup);

    return groups;
  }

  void _drawSinglePlanet(
    Canvas canvas,
    Offset center,
    double radius,
    PlanetPosition planet,
    double ascDegree,
  ) {
    final angle = _degreeToRadians(planet.longitude - ascDegree + 180);
    final x = center.dx + radius * math.cos(angle);
    final y = center.dy + radius * math.sin(angle);

    // Draw planet background
    final bgPaint = Paint()
      ..color = planet.planet.color.withAlpha(50)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 12, bgPaint);

    // Draw planet border
    final borderPaint = Paint()
      ..color = planet.planet.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(Offset(x, y), 12, borderPaint);

    // Draw planet symbol
    final textPainter = TextPainter(
      text: TextSpan(
        text: planet.planet.symbol,
        style: TextStyle(
          color: planet.planet.color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );

    // Draw retrograde indicator
    if (planet.isRetrograde) {
      final retroPainter = TextPainter(
        text: TextSpan(
          text: 'R',
          style: TextStyle(
            color: AppColors.warning,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      retroPainter.paint(canvas, Offset(x + 8, y - 12));
    }

    // Draw degree indicator line to zodiac ring
    final lineRadius = radius * 1.25;
    final lineEndX = center.dx + lineRadius * math.cos(angle);
    final lineEndY = center.dy + lineRadius * math.sin(angle);

    final linePaint = Paint()
      ..color = planet.planet.color.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    canvas.drawLine(Offset(x, y), Offset(lineEndX, lineEndY), linePaint);
  }

  void _drawPlanetGroup(
    Canvas canvas,
    Offset center,
    double radius,
    List<PlanetPosition> group,
    double ascDegree,
  ) {
    // Calculate average position for the group
    final avgLongitude =
        group.map((p) => p.longitude).reduce((a, b) => a + b) / group.length;

    // Spread planets around the average position
    final spreadAngle = 15.0; // degrees to spread
    final startOffset = -spreadAngle * (group.length - 1) / 2;

    for (int i = 0; i < group.length; i++) {
      final planet = group[i];
      final adjustedLongitude = avgLongitude + startOffset + (i * spreadAngle);
      final adjustedPlanet = PlanetPosition(
        planet: planet.planet,
        longitude: adjustedLongitude,
        isRetrograde: planet.isRetrograde,
        house: planet.house,
      );
      _drawSinglePlanet(
        canvas,
        center,
        radius * (0.95 + i * 0.08),
        adjustedPlanet,
        ascDegree,
      );
    }
  }

  PlanetPosition? _findPlanetPosition(Planet planet) {
    try {
      return chart.planets.firstWhere((p) => p.planet == planet);
    } catch (_) {
      return null;
    }
  }

  double _degreeToRadians(double degrees) {
    // Convert degrees to radians, adjusting so 0° Aries is at the left
    return (degrees - 90) * math.pi / 180;
  }

  @override
  bool shouldRepaint(covariant _ChartWheelPainter oldDelegate) {
    return oldDelegate.chart != chart ||
        oldDelegate.showAspects != showAspects ||
        oldDelegate.showHouses != showHouses;
  }
}
