import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Astrobobo — Cosmic Field Painter.
///
/// Full-screen animated "living universe" used as the portal entry
/// background. Particles respond to pointer position with a soft gravity
/// lens, drift on their own inertia, and wrap around the screen edges so
/// the field feels continuous. The simulation runs off a single Ticker
/// driven by [CosmicField] and repaints through a [Listenable].
///
/// The painter is deliberately lightweight: no dart:io, no images, only
/// Canvas + Paint + additive blend. Tunable density makes it safe on
/// mobile and on Flutter web's CanvasKit renderer.
class CosmicFieldPainter extends CustomPainter {
  CosmicFieldPainter({
    required this.particles,
    required this.cursor,
    required this.time,
    required this.intensity,
  }) : super(repaint: particles);

  final CosmicField particles;
  final Offset cursor;
  final double time;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    // Base void gradient — vignette toward the corners.
    final voidGradient = RadialGradient(
      center: Alignment.topCenter,
      radius: 1.4,
      colors: const [Color(0xFF0B0618), Color(0xFF05010A), Color(0xFF000000)],
      stops: const [0.0, 0.6, 1.0],
    );
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = voidGradient.createShader(Offset.zero & size),
    );

    // Nebula lens that tracks the cursor — a soft violet bloom.
    final cx = cursor.dx.clamp(0.0, 1.0) * size.width;
    final cy = cursor.dy.clamp(0.0, 1.0) * size.height;
    final nebulaPaint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = ui.Gradient.radial(
        Offset(cx, cy),
        math.max(size.width, size.height) * 0.55,
        [
          Color.fromRGBO(124, 58, 237, 0.30 + intensity * 0.22),
          const Color.fromRGBO(124, 58, 237, 0.08),
          const Color.fromRGBO(0, 0, 0, 0.0),
        ],
        [0.0, 0.35, 1.0],
      );
    canvas.drawRect(Offset.zero & size, nebulaPaint);

    // Secondary cyan drift — offset from cursor for depth.
    final driftOffset = Offset(
      cx + math.sin(time * 0.6) * 80,
      cy + math.cos(time * 0.5) * 60,
    );
    final driftPaint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = ui.Gradient.radial(
        driftOffset,
        math.max(size.width, size.height) * 0.40,
        [
          Color.fromRGBO(34, 211, 238, 0.18 + intensity * 0.12),
          const Color.fromRGBO(34, 211, 238, 0.0),
        ],
        [0.0, 1.0],
      );
    canvas.drawRect(Offset.zero & size, driftPaint);

    // Particles — additive, three tiers of depth/size.
    final p = Paint()
      ..blendMode = BlendMode.plus
      ..style = PaintingStyle.fill;

    for (final particle in particles.particles) {
      final px = particle.x * size.width;
      final py = particle.y * size.height;
      final life = particle.life;
      // Twinkle: modulate alpha with a per-particle phase.
      final twinkle =
          0.55 + 0.45 * (0.5 + 0.5 * math.sin(time * 1.6 + particle.seed));
      final depthAlpha = 0.45 + particle.depth * 0.55;
      final color =
          Color.lerp(
            const Color(0xFFA78BFA),
            const Color(0xFF67E8F9),
            (particle.seed % 5) / 5.0,
          )!.withValues(
            alpha: (twinkle * depthAlpha * (0.6 + life * 0.4)).clamp(0.0, 1.0),
          );
      p.color = color;
      // Draw a soft dot: core + halo.
      final radius = 0.6 + particle.depth * 1.6;
      canvas.drawCircle(Offset(px, py), radius * 1.4, p..maskFilter = null);
      p
        ..color = color.withValues(alpha: color.a * 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset(px, py), radius * 3.2, p);
    }
  }

  @override
  bool shouldRepaint(CosmicFieldPainter oldDelegate) =>
      oldDelegate.particles != particles ||
      oldDelegate.cursor != cursor ||
      oldDelegate.time != time ||
      oldDelegate.intensity != intensity;
}

/// A single particle — position is normalized [0..1] so the field resizes
/// freely without reseeding.
class CosmicParticle {
  CosmicParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.life,
    required this.seed,
    required this.depth,
  });
  double x;
  double y;
  double vx;
  double vy;
  double life;
  final int seed;
  final double depth; // 0..1, used for parallax + size + alpha
}

/// A [Listenable] particle simulation. Owned by [CosmicUniverse] so the
/// widget tree can subscribe and repaint automatically when the field
/// steps forward.
class CosmicField extends ChangeNotifier {
  CosmicField({required int count}) {
    final rng = math.Random(42);
    particles = List.generate(
      count,
      (i) => CosmicParticle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        vx: (rng.nextDouble() - 0.5) * 0.02,
        vy: (rng.nextDouble() - 0.5) * 0.02,
        life: rng.nextDouble(),
        seed: i,
        depth: rng.nextDouble(),
      ),
    );
  }

  late List<CosmicParticle> particles;

  /// Pointer position in normalized [0..1] coords.
  Offset cursor = const Offset(0.5, 0.5);

  /// 0..1 — modulates gravity pull strength, fed from emotion / hover.
  double intensity = 0.2;

  void step(double dt) {
    final gravity = 0.35 * (0.6 + intensity * 0.9);
    for (final p in particles) {
      final dx = cursor.dx - p.x;
      final dy = cursor.dy - p.y;
      final d2 = dx * dx + dy * dy + 0.0025;
      final force = gravity / d2;
      p.vx += dx * force * dt;
      p.vy += dy * force * dt;

      // Gentle tangential orbit — curiosity drift.
      final tx = -dy;
      final ty = dx;
      p.vx += tx * 0.08 * intensity * dt;
      p.vy += ty * 0.08 * intensity * dt;

      p.x += p.vx * dt;
      p.y += p.vy * dt;

      // Damping.
      final damping = math.pow(0.9, dt * 60).toDouble();
      p.vx *= damping;
      p.vy *= damping;

      // Wrap — space never ends.
      if (p.x < -0.05) p.x = 1.05;
      if (p.x > 1.05) p.x = -0.05;
      if (p.y < -0.05) p.y = 1.05;
      if (p.y > 1.05) p.y = -0.05;

      p.life = (p.life + dt * (0.2 + intensity * 0.6)) % 1.0;
    }
    notifyListeners();
  }
}

/// Stateful widget that owns the particle field + a Ticker, and hosts a
/// full-screen [CustomPaint] that renders [CosmicFieldPainter]. Consumers
/// drop this at z=0 in a Stack and overlay the rest of the portal UI.
class CosmicUniverse extends StatefulWidget {
  const CosmicUniverse({
    super.key,
    this.particleCount = 140,
    this.intensity = 0.25,
    this.cursor = const Offset(0.5, 0.5),
  });

  final int particleCount;
  final double intensity;

  /// Normalized pointer position (0..1 on each axis). Parent widgets pass
  /// this down from a MouseRegion/Listener at the root of the portal.
  final Offset cursor;

  @override
  State<CosmicUniverse> createState() => _CosmicUniverseState();
}

class _CosmicUniverseState extends State<CosmicUniverse>
    with SingleTickerProviderStateMixin {
  late final CosmicField _field;
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    _field = CosmicField(count: widget.particleCount);
    _field.cursor = widget.cursor;
    _field.intensity = widget.intensity;
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didUpdateWidget(covariant CosmicUniverse oldWidget) {
    super.didUpdateWidget(oldWidget);
    _field.cursor = widget.cursor;
    _field.intensity = widget.intensity;
  }

  void _onTick(Duration elapsed) {
    final dtMs = (elapsed - _lastTick).inMicroseconds / 1000000.0;
    _lastTick = elapsed;
    final dt = dtMs.clamp(0.001, 0.048);
    _time += dt;
    _field.step(dt);
    setState(() {}); // trigger paint for `time` progression
  }

  @override
  void dispose() {
    _ticker.dispose();
    _field.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: CosmicFieldPainter(
            particles: _field,
            cursor: widget.cursor,
            time: _time,
            intensity: widget.intensity,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}
