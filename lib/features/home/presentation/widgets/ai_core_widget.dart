import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Astrobobo — AI Core orb.
///
/// Central "living system" element of the portal. Renders as:
///   • a rotating conic energy ring drawn with CustomPainter,
///   • a slowly pulsing breathing core (radial gradient),
///   • a halo whose intensity scales with pointer proximity.
///
/// The widget takes a normalized [proximity] value (0..1) from its parent,
/// which is computed from the pointer position against the orb's own
/// bounding rect. Everything else animates off an internal Ticker so the
/// parent only needs to feed proximity.
class AICoreWidget extends StatefulWidget {
  const AICoreWidget({super.key, required this.proximity, this.size = 220});

  /// 0..1 — how close the user's pointer is. 1 = right on top of the orb.
  final double proximity;

  /// Outer diameter in logical pixels.
  final double size;

  @override
  State<AICoreWidget> createState() => _AICoreWidgetState();
}

class _AICoreWidgetState extends State<AICoreWidget>
    with TickerProviderStateMixin {
  late final AnimationController _ringRotation;
  late final AnimationController _breath;

  @override
  void initState() {
    super.initState();
    _ringRotation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
    _breath = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ringRotation.dispose();
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prox = widget.proximity.clamp(0.0, 1.0);
    return SizedBox(
      width: widget.size * 1.8,
      height: widget.size * 1.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer halo — intensifies with proximity.
          IgnorePointer(
            child: Container(
              width: widget.size * 1.6,
              height: widget.size * 1.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(124, 58, 237, 0.45 + prox * 0.35),
                    const Color.fromRGBO(124, 58, 237, 0.15),
                    const Color.fromRGBO(0, 0, 0, 0.0),
                  ],
                  stops: const [0.0, 0.4, 0.8],
                ),
              ),
            ),
          ),

          // Rotating conic energy ring.
          AnimatedBuilder(
            animation: _ringRotation,
            builder: (context, _) {
              return Transform.rotate(
                angle: _ringRotation.value * 2 * math.pi,
                child: CustomPaint(
                  size: Size(widget.size * 1.25, widget.size * 1.25),
                  painter: _EnergyRingPainter(intensity: 0.55 + prox * 0.45),
                ),
              );
            },
          ),

          // Breathing core.
          AnimatedBuilder(
            animation: _breath,
            builder: (context, _) {
              final t = Curves.easeInOut.transform(_breath.value);
              final scale = 1.0 + t * 0.025 + prox * 0.08;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      center: Alignment(-0.3, -0.4),
                      radius: 1.0,
                      colors: [
                        Color(0xFFF5F3FF),
                        Color(0xFFC4B5FD),
                        Color(0xFF7C3AED),
                        Color(0xFF1E1B4B),
                        Color(0xFF000000),
                      ],
                      stops: [0.0, 0.18, 0.48, 0.78, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(124, 58, 237, 0.6),
                        blurRadius: 60,
                        spreadRadius: 4,
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(124, 58, 237, 0.35),
                        blurRadius: 120,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Inner highlight — volumetric glint.
          IgnorePointer(
            child: Container(
              width: widget.size * 0.64,
              height: widget.size * 0.64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(-0.4, -0.5),
                  radius: 0.8,
                  colors: [
                    Color.fromRGBO(245, 243, 255, 0.85),
                    Color.fromRGBO(245, 243, 255, 0.1),
                    Color.fromRGBO(245, 243, 255, 0.0),
                  ],
                  stops: [0.0, 0.35, 0.6],
                ),
              ),
            ),
          ),

          // Proximity flare ring.
          IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: (prox * 1.1).clamp(0.0, 1.0),
              child: Container(
                width: widget.size * 1.12,
                height: widget.size * 1.12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(167, 139, 250, 0.55),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(34, 211, 238, 0.35),
                      blurRadius: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyRingPainter extends CustomPainter {
  _EnergyRingPainter({required this.intensity});
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final ringWidth = 10.0;
    final rect = Rect.fromCircle(center: center, radius: radius - ringWidth);

    // Conic sweep gradient.
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          const Color.fromRGBO(124, 58, 237, 0.0),
          Color.fromRGBO(124, 58, 237, 0.45 * intensity),
          Color.fromRGBO(34, 211, 238, 0.55 * intensity),
          const Color.fromRGBO(124, 58, 237, 0.0),
        ],
        stops: const [0.0, 0.22, 0.55, 1.0],
      ).createShader(rect);

    canvas.drawArc(rect, 0, 2 * math.pi, false, paint);
  }

  @override
  bool shouldRepaint(_EnergyRingPainter oldDelegate) =>
      oldDelegate.intensity != intensity;
}
