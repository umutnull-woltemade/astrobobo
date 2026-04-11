import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A widget that animates its child when it becomes visible on scroll
class ScrollFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final double triggerOffset;

  const ScrollFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = const Offset(0, 30),
    this.triggerOffset = 0.1,
  });

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        if (visible && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      triggerOffset: widget.triggerOffset,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedSlide(
          offset: _isVisible
              ? Offset.zero
              : Offset(widget.offset.dx / 100, widget.offset.dy / 100),
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Simple visibility detector using LayoutBuilder
class VisibilityDetector extends StatefulWidget {
  final Widget child;
  final Function(bool visible) onVisibilityChanged;
  final double triggerOffset;

  const VisibilityDetector({
    super.key,
    required this.child,
    required this.onVisibilityChanged,
    this.triggerOffset = 0.1,
  });

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  final GlobalKey _key = GlobalKey();
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    final isVisible =
        offset.dy < screenHeight * (1 - widget.triggerOffset) &&
        offset.dy + size.height > screenHeight * widget.triggerOffset;

    if (isVisible != _wasVisible) {
      _wasVisible = isVisible;
      widget.onVisibilityChanged(isVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: Container(key: _key, child: widget.child),
    );
  }
}

/// Parallax scroll effect for backgrounds
class ParallaxContainer extends StatefulWidget {
  final Widget child;
  final Widget background;
  final double parallaxFactor;

  const ParallaxContainer({
    super.key,
    required this.child,
    required this.background,
    this.parallaxFactor = 0.3,
  });

  @override
  State<ParallaxContainer> createState() => _ParallaxContainerState();
}

class _ParallaxContainerState extends State<ParallaxContainer> {
  double _scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            _scrollOffset = notification.metrics.pixels;
          });
        }
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, _scrollOffset * widget.parallaxFactor),
              child: widget.background,
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

/// Scale animation on scroll
class ScrollScale extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;

  const ScrollScale({
    super.key,
    required this.child,
    this.minScale = 0.8,
    this.maxScale = 1.0,
  });

  @override
  State<ScrollScale> createState() => _ScrollScaleState();
}

class _ScrollScaleState extends State<ScrollScale> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        if (visible && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: AnimatedScale(
        scale: _isVisible ? widget.maxScale : widget.minScale,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Staggered list animation helper
class StaggeredListItem extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration baseDelay;
  final Duration staggerDelay;

  const StaggeredListItem({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 100),
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(
          delay: baseDelay + (staggerDelay * index),
          duration: const Duration(milliseconds: 400),
        )
        .slideY(
          begin: 0.2,
          delay: baseDelay + (staggerDelay * index),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
  }
}

/// Hero-style card animation
class HeroCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;

  const HeroCard({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: widget.duration,
          decoration: BoxDecoration(
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Shimmer loading effect
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.isLoading = true,
    this.baseColor = const Color(0xFF1A1A2E),
    this.highlightColor = const Color(0xFF2D2D44),
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((s) => s.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

/// Glow pulse animation for highlights
class GlowPulse extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double minGlow;
  final double maxGlow;
  final Duration duration;

  const GlowPulse({
    super.key,
    required this.child,
    required this.glowColor,
    this.minGlow = 0.0,
    this.maxGlow = 12.0,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<GlowPulse> createState() => _GlowPulseState();
}

class _GlowPulseState extends State<GlowPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = Tween<double>(
      begin: widget.minGlow,
      end: widget.maxGlow,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withAlpha(100),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 4,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Floating animation (subtle up/down movement)
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double distance;
  final Duration duration;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.distance = 8.0,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = Tween<double>(
      begin: -widget.distance / 2,
      end: widget.distance / 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: widget.child,
        );
      },
    );
  }
}

/// Rotation animation
class RotatingAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool clockwise;

  const RotatingAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 20),
    this.clockwise = true,
  });

  @override
  State<RotatingAnimation> createState() => _RotatingAnimationState();
}

class _RotatingAnimationState extends State<RotatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
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
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159 * (widget.clockwise ? 1 : -1),
          child: widget.child,
        );
      },
    );
  }
}

/// Page transition helper
class SmoothPageTransition extends PageRouteBuilder {
  final Widget page;

  SmoothPageTransition({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(0.0, 0.05),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          final fadeTween = Tween(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeOut));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      );
}
