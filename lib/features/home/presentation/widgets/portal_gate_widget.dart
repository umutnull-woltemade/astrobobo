import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Astrobobo — Portal Gate.
///
/// The final scene's CTA. Not a button — a glowing circular gate with a
/// rotating energy halo and a charge meter that fills as the user
/// hovers (or keeps the pointer nearby). When the meter fills, a warp
/// flash fires and the parent-provided [onWarp] callback runs.
///
/// The widget owns its own Ticker and drives the rotating halo locally.
/// Charge is computed from a combination of "hovering" state and the
/// parent-provided [proximity] value, so a desktop user can fill it by
/// hovering, and a touch user by long-pressing (which sets hovering=true).
class PortalGateWidget extends StatefulWidget {
  const PortalGateWidget({
    super.key,
    required this.proximity,
    required this.onWarp,
    this.size = 320,
    this.labelTr = "ASTROBOBO'YA GİR",
    this.hintTr = 'Kapıyı açmak için yaklaş',
  });

  /// 0..1 — pointer proximity to the gate, used to charge the meter even
  /// before the cursor is technically inside the gate's bounds.
  final double proximity;
  final VoidCallback onWarp;
  final double size;
  final String labelTr;
  final String hintTr;

  @override
  State<PortalGateWidget> createState() => _PortalGateWidgetState();
}

class _PortalGateWidgetState extends State<PortalGateWidget>
    with TickerProviderStateMixin {
  late final AnimationController _ring;
  late final Ticker _charger;
  double _charge = 0;
  bool _hovering = false;
  bool _warping = false;
  Duration _lastTick = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ring = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _charger = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _lastTick).inMicroseconds / 1000000.0;
    _lastTick = elapsed;
    if (_warping) return;

    final prox = widget.proximity.clamp(0.0, 1.0);
    final shouldCharge = _hovering || prox > 0.35;
    final delta = shouldCharge
        ? dt * (0.55 + prox * 0.9)
        : -dt * 0.7;
    final next = (_charge + delta).clamp(0.0, 1.0);
    if (next != _charge) {
      setState(() => _charge = next);
    }
    if (_charge >= 0.995 && !_warping) {
      setState(() => _warping = true);
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) widget.onWarp();
      });
    }
  }

  @override
  void dispose() {
    _ring.dispose();
    _charger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: () {
              // Click accelerant — bump charge ~20%.
              setState(() => _charge = (_charge + 0.2).clamp(0.0, 1.0));
            },
            onLongPress: () => setState(() => _hovering = true),
            onLongPressUp: () => setState(() => _hovering = false),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: AnimatedBuilder(
                animation: _ring,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _PortalGatePainter(
                      rotation: _ring.value * 2 * math.pi,
                      charge: _charge,
                    ),
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: 0.75 + _charge * 0.25,
                        child: Text(
                          widget.labelTr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFF5F3FF),
                            fontSize: 14,
                            letterSpacing: 3.6,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Color.fromRGBO(124, 58, 237, 0.9),
                                blurRadius: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _charge < 0.2 ? 1.0 : 0.25,
          child: Text(
            widget.hintTr.toUpperCase(),
            style: const TextStyle(
              color: Color.fromRGBO(245, 243, 255, 0.55),
              fontSize: 11,
              letterSpacing: 3.0,
            ),
          ),
        ),
        // Warp flash overlay.
        if (_warping)
          AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 600),
            child: Container(
              width: widget.size * 2,
              height: widget.size * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(245, 243, 255, 0.95),
                    Color.fromRGBO(34, 211, 238, 0.85),
                    Color.fromRGBO(124, 58, 237, 0.7),
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PortalGatePainter extends CustomPainter {
  _PortalGatePainter({required this.rotation, required this.charge});
  final double rotation;
  final double charge;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer rotating halo.
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    final haloRect = Rect.fromCircle(center: center, radius: radius - 12);
    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          const Color.fromRGBO(34, 211, 238, 0.0),
          Color.fromRGBO(124, 58, 237, 0.85 * (0.45 + charge * 0.55)),
          Color.fromRGBO(34, 211, 238, 0.95 * (0.45 + charge * 0.55)),
          const Color.fromRGBO(34, 211, 238, 0.0),
        ],
        stops: const [0.0, 0.22, 0.55, 1.0],
      ).createShader(haloRect);
    canvas.drawArc(haloRect, 0, 2 * math.pi, false, haloPaint);
    canvas.restore();

    // Portal well — deep violet → cyan inner.
    final wellRect = Rect.fromCircle(center: center, radius: radius - 28);
    final wellPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.fromRGBO(34, 211, 238, 0.18 + charge * 0.1),
          const Color.fromRGBO(124, 58, 237, 0.35),
          const Color.fromRGBO(12, 4, 28, 0.9),
          const Color.fromRGBO(0, 0, 0, 1.0),
        ],
        stops: const [0.0, 0.35, 0.72, 1.0],
      ).createShader(wellRect);
    canvas.drawCircle(center, radius - 28, wellPaint);

    // Charge arc.
    final chargeRect = Rect.fromCircle(center: center, radius: radius - 6);
    final chargePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [Color(0xFFA78BFA), Color(0xFF22D3EE)],
      ).createShader(chargeRect);
    canvas.drawArc(
      chargeRect,
      -math.pi / 2,
      charge * 2 * math.pi,
      false,
      chargePaint,
    );

    // Track line behind the charge.
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color.fromRGBO(245, 243, 255, 0.1);
    canvas.drawArc(
      chargeRect,
      -math.pi / 2,
      2 * math.pi,
      false,
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(_PortalGatePainter oldDelegate) =>
      oldDelegate.rotation != rotation || oldDelegate.charge != charge;
}
