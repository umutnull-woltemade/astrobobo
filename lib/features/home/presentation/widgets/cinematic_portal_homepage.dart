import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../data/providers/app_providers.dart';
import 'cosmic_field_painter.dart';
import 'ai_core_widget.dart';
import 'orbit_tools_widget.dart';
import 'portal_gate_widget.dart';

/// Astrobobo — Cinematic Portal Homepage.
///
/// A replacement for `DesktopRichHomepage` that reframes the entry into
/// the 80+ kozmik tool universe as an emotional, interactive portal
/// rather than an informational page.
///
/// Scene map
///   0 Void       — only the cosmic field + pulsing AI core
///   1 Formation  — first whisper surfaces ("Something is forming…")
///   2 Structure  — second whisper + orbit tool ring fades in
///   3 Decision   — portal gate replaces the core
///
/// Scenes advance on wheel / drag / arrow keys, and also auto-unlock as
/// the user interacts with the living core.
///
/// Navigation on warp routes to [Routes.allServices] — the unified tool
/// catalog — so users who come in via the cinematic entrance still land
/// on something they can explore. The onboarding guard is preserved by
/// falling back to [Routes.onboarding] when the profile is missing.
class CinematicPortalHomepage extends ConsumerStatefulWidget {
  const CinematicPortalHomepage({super.key});

  @override
  ConsumerState<CinematicPortalHomepage> createState() =>
      _CinematicPortalHomepageState();
}

class _CinematicPortalHomepageState
    extends ConsumerState<CinematicPortalHomepage> {
  static const int _sceneCount = 4;

  Offset _cursor = const Offset(0.5, 0.5);
  double _sceneProgress = 0;
  int _revealLevel = 0;
  double _coreProximity = 0;
  DateTime _lastReveal = DateTime.fromMillisecondsSinceEpoch(0);

  final _focusNode = FocusNode();

  void _setCursorFromLocal(Offset localPosition, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    setState(() {
      _cursor = Offset(
        (localPosition.dx / size.width).clamp(0.0, 1.0),
        (localPosition.dy / size.height).clamp(0.0, 1.0),
      );
    });
  }

  void _advanceScene(double delta) {
    final next = (_sceneProgress + delta).clamp(0.0, _sceneCount - 1.0);
    setState(() {
      _sceneProgress = next;
    });
    _maybeAdvanceReveal();
  }

  void _maybeAdvanceReveal() {
    final now = DateTime.now();
    if (now.difference(_lastReveal) < const Duration(milliseconds: 450)) return;
    if (_revealLevel < 4) {
      setState(() => _revealLevel += 1);
      _lastReveal = now;
    }
  }

  void _onPointerMove(PointerMoveEvent event, Size size) {
    _setCursorFromLocal(event.localPosition, size);
    // Track proximity to the screen center where the core lives during
    // scenes 0..2. After scene 2 the portal takes over that slot.
    final cx = size.width / 2;
    final cy = size.height / 2;
    final dx = event.localPosition.dx - cx;
    final dy = event.localPosition.dy - cy;
    final dist = math.sqrt(dx * dx + dy * dy);
    setState(() {
      _coreProximity = (1 - dist / 360).clamp(0.0, 1.0);
    });
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey.keyLabel;
    if (key == 'Arrow Down' || key == 'Page Down' || key == ' ') {
      _advanceScene(1);
    } else if (key == 'Arrow Up' || key == 'Page Up') {
      _advanceScene(-1);
    }
  }

  void _onWarp() {
    if (!mounted) return;
    context.push(Routes.allServices);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Onboarding guard — match the previous DesktopRichHomepage behavior
    // so users without a profile are still funneled through onboarding.
    final profile = ref.watch(userProfileProvider);
    if (profile == null || profile.name == null || profile.name!.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.onboarding);
      });
      return const Scaffold(
        backgroundColor: Color(0xFF05010A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFA78BFA)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF05010A),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: _handleKey,
            child: Listener(
              onPointerHover: (e) => _setCursorFromLocal(e.localPosition, size),
              onPointerMove: (e) => _onPointerMove(e, size),
              onPointerSignal: (signal) {
                if (signal is PointerScrollEvent) {
                  _advanceScene(signal.scrollDelta.dy * 0.003);
                }
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragUpdate: (d) {
                  _advanceScene(-d.delta.dy * 0.006);
                  _setCursorFromLocal(d.localPosition, size);
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // LAYER 0 — Cosmic void background (always alive).
                    Positioned.fill(
                      child: CosmicUniverse(
                        particleCount: _pickParticleCount(size),
                        intensity: 0.25 + _coreProximity * 0.45,
                        cursor: _cursor,
                      ),
                    ),

                    // LAYER 1 — Scene stack.
                    Positioned.fill(child: _buildSceneStack(size)),

                    // LAYER 2 — Floating minimal nav.
                    Positioned(
                      top: 20,
                      left: 32,
                      right: 32,
                      child: _FloatingNav(
                        userName: profile.name!,
                        onOpenTools: () => context.push(Routes.allServices),
                      ),
                    ),

                    // LAYER 3 — Scene indicator.
                    Positioned(
                      right: 22,
                      top: size.height / 2 - 60,
                      child: _SceneIndicator(
                        count: _sceneCount,
                        progress: _sceneProgress,
                      ),
                    ),

                    // LAYER 4 — Skip / scroll hint.
                    if (_sceneProgress < 0.1)
                      Positioned(
                        bottom: 32,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 1200),
                            opacity: _revealLevel == 0 ? 1.0 : 0.0,
                            child: const Text(
                              'KAYDIR · HAREKET ET',
                              style: TextStyle(
                                color: Color.fromRGBO(245, 243, 255, 0.35),
                                fontSize: 10,
                                letterSpacing: 5,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  int _pickParticleCount(Size size) {
    if (size.width < 600) return 60;
    if (size.width < 1200) return 120;
    return 180;
  }

  Widget _buildSceneStack(Size size) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _sceneLayer(0, _Scene0(proximity: _coreProximity)),
        _sceneLayer(
          1,
          _Scene1(proximity: _coreProximity, revealLevel: _revealLevel),
        ),
        _sceneLayer(
          2,
          _Scene2(revealLevel: _revealLevel, visible: _sceneProgress >= 1.5),
        ),
        _sceneLayer(3, _Scene3(proximity: _coreProximity, onWarp: _onWarp)),
      ],
    );
  }

  Widget _sceneLayer(int index, Widget child) {
    final delta = _sceneProgress - index;
    final absDelta = delta.abs();
    final opacity = (1.0 - absDelta * 1.4).clamp(0.0, 1.0);
    final translateY = delta * -80;
    final scale = 1 - absDelta * 0.08;
    return IgnorePointer(
      ignoring: opacity < 0.6,
      child: Opacity(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(0, translateY),
          child: Transform.scale(scale: scale, child: child),
        ),
      ),
    );
  }
}

class _FloatingNav extends StatelessWidget {
  const _FloatingNav({required this.userName, required this.onOpenTools});
  final String userName;
  final VoidCallback onOpenTools;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ASTROBOBO',
            style: TextStyle(
              color: Color.fromRGBO(245, 243, 255, 0.85),
              fontSize: 13,
              letterSpacing: 4,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Color.fromRGBO(124, 58, 237, 0.8),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onOpenTools,
              child: Text(
                'TÜM ARAÇLAR  →',
                style: const TextStyle(
                  color: Color.fromRGBO(245, 243, 255, 0.6),
                  fontSize: 11,
                  letterSpacing: 2.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SceneIndicator extends StatelessWidget {
  const _SceneIndicator({required this.count, required this.progress});
  final int count;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final fill = (1 - (progress - i).abs()).clamp(0.0, 1.0);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            width: 2,
            height: 32,
            color: const Color.fromRGBO(245, 243, 255, 0.12),
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: fill,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFA78BFA), Color(0xFF22D3EE)],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// ────────────────────────────────────────────────────────────────
/// Scenes
/// ────────────────────────────────────────────────────────────────

class _Scene0 extends StatelessWidget {
  const _Scene0({required this.proximity});
  final double proximity;
  @override
  Widget build(BuildContext context) {
    return Center(child: AICoreWidget(proximity: proximity));
  }
}

class _Scene1 extends StatelessWidget {
  const _Scene1({required this.proximity, required this.revealLevel});
  final double proximity;
  final int revealLevel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AICoreWidget(proximity: proximity),
        Positioned(
          bottom: 160,
          child: _Whisper(
            text: 'Bir şey şekilleniyor…',
            visible: revealLevel >= 1,
          ),
        ),
      ],
    );
  }
}

class _Scene2 extends StatelessWidget {
  const _Scene2({required this.revealLevel, required this.visible});
  final int revealLevel;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Smaller core — makes room for the orbit.
        const _ShrunkCore(),
        OrbitToolsWidget(visible: visible),
        Positioned(
          top: 140,
          child: _Whisper(
            text: 'Bu bir site değil. Bu yaşayan bir sistem.',
            visible: revealLevel >= 2,
          ),
        ),
      ],
    );
  }
}

class _Scene3 extends StatelessWidget {
  const _Scene3({required this.proximity, required this.onWarp});
  final double proximity;
  final VoidCallback onWarp;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PortalGateWidget(proximity: proximity, onWarp: onWarp),
    );
  }
}

class _ShrunkCore extends StatelessWidget {
  const _ShrunkCore();
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.42,
      child: const AICoreWidget(proximity: 0),
    );
  }
}

class _Whisper extends StatelessWidget {
  const _Whisper({required this.text, required this.visible});
  final String text;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeOutCubic,
      opacity: visible ? 0.82 : 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFF5F3FF),
            fontSize: 16,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
            shadows: [
              Shadow(color: Color.fromRGBO(124, 58, 237, 0.65), blurRadius: 24),
            ],
          ),
        ),
      ),
    );
  }
}
