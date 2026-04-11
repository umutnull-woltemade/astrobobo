import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/zodiac_sign.dart';
import '../../data/models/constellation_data.dart';
import '../../data/content/constellation_patterns.dart';

/// A widget that renders a zodiac constellation pattern
/// Designed to replace Text(sign.symbol) usage across the app
class ConstellationWidget extends StatelessWidget {
  final ZodiacSign sign;
  final double size;
  final Color? color; // Override element color
  final bool showGlow; // Glow on brightest star
  final bool showLines; // Connection lines
  final bool animate; // Twinkle animation
  final double lineOpacity; // Line visibility (0.0 - 1.0)
  final double starBrightness; // Overall star brightness multiplier

  const ConstellationWidget({
    super.key,
    required this.sign,
    this.size = 48,
    this.color,
    this.showGlow = true,
    this.showLines = true,
    this.animate = false,
    this.lineOpacity = 0.4,
    this.starBrightness = 1.0,
  });

  /// Factory for icon-sized usage (replacing symbol in lists)
  factory ConstellationWidget.icon({required ZodiacSign sign, Color? color}) {
    return ConstellationWidget(
      sign: sign,
      size: 24,
      color: color,
      showGlow: false,
      showLines: true,
      lineOpacity: 0.3,
    );
  }

  /// Factory for medium display (cards, headers)
  factory ConstellationWidget.medium({required ZodiacSign sign, Color? color}) {
    return ConstellationWidget(
      sign: sign,
      size: 48,
      color: color,
      showGlow: true,
      showLines: true,
    );
  }

  /// Factory for large hero display
  factory ConstellationWidget.hero({
    required ZodiacSign sign,
    Color? color,
    bool animate = true,
  }) {
    return ConstellationWidget(
      sign: sign,
      size: 120,
      color: color,
      showGlow: true,
      showLines: true,
      animate: animate,
      lineOpacity: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pattern = ConstellationPatterns.getPattern(sign);
    final displayColor = color ?? sign.color;

    Widget constellation = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ConstellationPainter(
          pattern: pattern,
          color: displayColor,
          showGlow: showGlow,
          showLines: showLines,
          lineOpacity: lineOpacity,
          starBrightness: starBrightness,
        ),
      ),
    );

    if (animate) {
      constellation = _AnimatedConstellation(
        pattern: pattern,
        size: size,
        color: displayColor,
        showLines: showLines,
        lineOpacity: lineOpacity,
      );
    }

    return constellation;
  }
}

class _ConstellationPainter extends CustomPainter {
  final ConstellationPattern pattern;
  final Color color;
  final bool showGlow;
  final bool showLines;
  final double lineOpacity;
  final double starBrightness;

  _ConstellationPainter({
    required this.pattern,
    required this.color,
    required this.showGlow,
    required this.showLines,
    required this.lineOpacity,
    required this.starBrightness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final stars = pattern.stars;
    final connections = pattern.connections;

    // Draw connection lines first (behind stars)
    if (showLines) {
      _drawConnections(canvas, size, stars, connections);
    }

    // Draw all stars
    for (int i = 0; i < stars.length; i++) {
      final star = stars[i];
      final isBrightest = i == pattern.brightestStarIndex;
      _drawStar(canvas, size, star, isBrightest);
    }
  }

  void _drawConnections(
    Canvas canvas,
    Size size,
    List<ConstellationStar> stars,
    List<StarConnection> connections,
  ) {
    final linePaint = Paint()
      ..color = color.withOpacity(lineOpacity * starBrightness)
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          size.width *
          0.015 // Thin lines, scalable
      ..strokeCap = StrokeCap.round;

    for (final connection in connections) {
      final from = stars[connection.from];
      final to = stars[connection.to];

      final start = Offset(from.x * size.width, from.y * size.height);
      final end = Offset(to.x * size.width, to.y * size.height);

      canvas.drawLine(start, end, linePaint);
    }
  }

  void _drawStar(
    Canvas canvas,
    Size size,
    ConstellationStar star,
    bool isBrightest,
  ) {
    final center = Offset(star.x * size.width, star.y * size.height);
    final radius = star.getRadius(size.width) * starBrightness;

    // Draw glow effect for brightest star
    if (isBrightest && showGlow) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3 * starBrightness)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 2);

      canvas.drawCircle(center, radius * 3, glowPaint);
    }

    // Draw star core
    final starPaint = Paint()
      ..color = color.withOpacity(0.9 * starBrightness)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, starPaint);

    // Draw bright center for larger stars
    if (radius > 2) {
      final corePaint = Paint()
        ..color = Colors.white.withOpacity(0.7 * starBrightness)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(center, radius * 0.4, corePaint);
    }
  }

  @override
  bool shouldRepaint(_ConstellationPainter oldDelegate) {
    return pattern != oldDelegate.pattern ||
        color != oldDelegate.color ||
        showGlow != oldDelegate.showGlow ||
        starBrightness != oldDelegate.starBrightness;
  }
}

/// Animated wrapper for twinkle effect
class _AnimatedConstellation extends StatefulWidget {
  final ConstellationPattern pattern;
  final double size;
  final Color color;
  final bool showLines;
  final double lineOpacity;

  const _AnimatedConstellation({
    required this.pattern,
    required this.size,
    required this.color,
    required this.showLines,
    required this.lineOpacity,
  });

  @override
  State<_AnimatedConstellation> createState() => _AnimatedConstellationState();
}

class _AnimatedConstellationState extends State<_AnimatedConstellation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Subtle pulse on the glow
        final glowIntensity = 0.8 + (_controller.value * 0.2);
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ConstellationPainter(
              pattern: widget.pattern,
              color: widget.color,
              showGlow: true,
              showLines: widget.showLines,
              lineOpacity: widget.lineOpacity,
              starBrightness: glowIntensity,
            ),
          ),
        );
      },
    );
  }
}

/// Extension to easily get constellation widget from ZodiacSign
extension ZodiacSignConstellationExtension on ZodiacSign {
  /// Get an icon-sized constellation (24px)
  Widget get constellationIcon => ConstellationWidget.icon(sign: this);

  /// Get a medium constellation (48px)
  Widget get constellationMedium => ConstellationWidget.medium(sign: this);

  /// Get a hero constellation (120px, animated)
  Widget get constellationHero => ConstellationWidget.hero(sign: this);

  /// Get constellation with custom size
  Widget constellation({
    double size = 48,
    Color? color,
    bool showGlow = true,
    bool showLines = true,
    bool animate = false,
  }) {
    return ConstellationWidget(
      sign: this,
      size: size,
      color: color,
      showGlow: showGlow,
      showLines: showLines,
      animate: animate,
    );
  }
}
