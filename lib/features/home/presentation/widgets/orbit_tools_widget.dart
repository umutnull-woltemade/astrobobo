import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';

/// Astrobobo — Orbit Tools.
///
/// Six primary tool gateways rendered as nodes on an elliptical orbit
/// around the central AI core. The ring rotates slowly on its own
/// AnimationController, and each node computes its position off the
/// shared angle so the whole thing stays coherent. Hovering a node
/// expands a caption panel; tapping routes to the live screen.
///
/// Tool picks mirror the 80+ kozmik catalog's five highest-traffic
/// gateways plus the unified "all services" entry.
class OrbitToolsWidget extends StatefulWidget {
  const OrbitToolsWidget({
    super.key,
    required this.visible,
    this.radiusX = 260,
    this.radiusY = 150,
  });

  /// Drives fade + scale enter.
  final bool visible;
  final double radiusX;
  final double radiusY;

  @override
  State<OrbitToolsWidget> createState() => _OrbitToolsWidgetState();
}

class _OrbitNode {
  const _OrbitNode({
    required this.id,
    required this.labelTr,
    required this.detailTr,
    required this.route,
    required this.angle,
    required this.color,
  });
  final String id;
  final String labelTr;
  final String detailTr;
  final String route;
  final double angle; // degrees offset along the orbit
  final Color color;
}

const _nodes = <_OrbitNode>[
  _OrbitNode(
    id: 'tarot',
    labelTr: 'Tarot',
    detailTr: 'Anın sembollerini oku.',
    route: Routes.tarot,
    angle: 0,
    color: Color(0xFFA78BFA),
  ),
  _OrbitNode(
    id: 'horoscope',
    labelTr: 'Burç',
    detailTr: 'Gökyüzü bugün ne söylüyor?',
    route: Routes.horoscope,
    angle: 60,
    color: Color(0xFF67E8F9),
  ),
  _OrbitNode(
    id: 'birth-chart',
    labelTr: 'Doğum Haritası',
    detailTr: 'Gelişinin şekli, yıldızlarla çizilmiş.',
    route: Routes.birthChart,
    angle: 120,
    color: Color(0xFFC4B5FD),
  ),
  _OrbitNode(
    id: 'numerology',
    labelTr: 'Numeroloji',
    detailTr: 'Sayıların sessiz dilinde kendini bul.',
    route: Routes.numerology,
    angle: 180,
    color: Color(0xFFF5F3FF),
  ),
  _OrbitNode(
    id: 'dreams',
    labelTr: 'Rüya İzi',
    detailTr: 'Uyandığında taşıdıkların.',
    route: Routes.dreamInterpretation,
    angle: 240,
    color: Color(0xFF22D3EE),
  ),
  _OrbitNode(
    id: 'kozmik',
    labelTr: 'Kozmik Keşif',
    detailTr: 'Bugünün canlı teması.',
    route: Routes.allServices,
    angle: 300,
    color: Color(0xFFFFD700),
  ),
];

class _OrbitToolsWidgetState extends State<OrbitToolsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotation;
  String? _focused;

  @override
  void initState() {
    super.initState();
    _rotation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _rotation.dispose();
    super.dispose();
  }

  void _openFocused(String id) {
    setState(() {
      _focused = _focused == id ? null : id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOut,
      opacity: widget.visible ? 1.0 : 0.0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        scale: widget.visible ? 1.0 : 0.85,
        child: SizedBox(
          width: widget.radiusX * 2 + 260,
          height: widget.radiusY * 2 + 220,
          child: AnimatedBuilder(
            animation: _rotation,
            builder: (context, _) {
              final globalAngle = _rotation.value * 2 * math.pi;
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Orbit path.
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _OrbitPathPainter(
                          rx: widget.radiusX,
                          ry: widget.radiusY,
                        ),
                      ),
                    ),
                  ),
                  for (final node in _nodes)
                    _buildNode(context, node, globalAngle),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNode(BuildContext context, _OrbitNode node, double globalAngle) {
    final angle = globalAngle + (node.angle * math.pi / 180);
    final dx = math.cos(angle) * widget.radiusX;
    final dy = math.sin(angle) * widget.radiusY;
    final isFocused = _focused == node.id;
    final isDimmed = _focused != null && !isFocused;

    return Transform.translate(
      offset: Offset(dx, dy),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        scale: isFocused ? 1.3 : (isDimmed ? 0.72 : 1.0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 350),
          opacity: isDimmed ? 0.28 : 1.0,
          child: _OrbitNodeChip(
            node: node,
            focused: isFocused,
            onTap: () => _openFocused(node.id),
            onLaunch: () => context.push(node.route),
          ),
        ),
      ),
    );
  }
}

class _OrbitNodeChip extends StatelessWidget {
  const _OrbitNodeChip({
    required this.node,
    required this.focused,
    required this.onTap,
    required this.onLaunch,
  });
  final _OrbitNode node;
  final bool focused;
  final VoidCallback onTap;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glow dot.
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: node.color,
            boxShadow: [
              BoxShadow(
                color: node.color.withValues(alpha: 0.85),
                blurRadius: 22,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Label chip — tap toggles focus.
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.06),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.18),
                ),
              ),
              child: Text(
                node.labelTr.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFF5F3FF),
                  fontSize: 11,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        // Expanded detail + CTA — only when focused.
        AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          child: focused
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 220),
                    child: Column(
                      children: [
                        Text(
                          node.detailTr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(245, 243, 255, 0.82),
                            fontSize: 12,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 10),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: onLaunch,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: node.color.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: node.color.withValues(alpha: 0.6),
                                ),
                              ),
                              child: const Text(
                                'AÇ',
                                style: TextStyle(
                                  color: Color(0xFFF5F3FF),
                                  fontSize: 10,
                                  letterSpacing: 2.2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _OrbitPathPainter extends CustomPainter {
  _OrbitPathPainter({required this.rx, required this.ry});
  final double rx;
  final double ry;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final outer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..shader =
          const LinearGradient(
            colors: [
              Color.fromRGBO(167, 139, 250, 0.45),
              Color.fromRGBO(34, 211, 238, 0.45),
            ],
          ).createShader(
            Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
          );
    final path = Path()
      ..addOval(Rect.fromCenter(center: center, width: rx * 2, height: ry * 2));
    _drawDashed(canvas, path, outer, dashWidth: 1.2, dashSpace: 6);

    final inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color.fromRGBO(167, 139, 250, 0.22);
    final innerPath = Path()
      ..addOval(
        Rect.fromCenter(
          center: center,
          width: rx * 2 * 0.78,
          height: ry * 2 * 0.76,
        ),
      );
    _drawDashed(canvas, innerPath, inner, dashWidth: 1, dashSpace: 10);
  }

  void _drawDashed(
    Canvas canvas,
    Path source,
    Paint paint, {
    required double dashWidth,
    required double dashSpace,
  }) {
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_OrbitPathPainter oldDelegate) =>
      oldDelegate.rx != rx || oldDelegate.ry != ry;
}
