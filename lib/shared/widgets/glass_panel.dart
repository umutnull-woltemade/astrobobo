import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// GlassPanel — translucent frosted-glass surface used by cinematic UI.
///
/// Use as a wrapper around any content that needs the glass-morphism look:
/// rounded corners, subtle border, soft shadow, and a backdrop blur on
/// platforms that support it.
///
/// Web-safe: backdrop blur is automatically disabled on Flutter web because
/// `BackdropFilter` ships large CanvasKit shaders and historically caused
/// frame drops + black-screen issues. On web we fall back to a non-blurred
/// translucent surface that preserves the visual language.
///
/// Example:
/// ```dart
/// GlassPanel(
///   padding: const EdgeInsets.all(20),
///   child: Text('Hello cosmos'),
/// )
/// ```
class GlassPanel extends StatelessWidget {
  /// Child widget rendered inside the glass surface.
  final Widget child;

  /// Internal padding around [child].
  final EdgeInsetsGeometry? padding;

  /// Border radius of the panel. Defaults to 20.
  final double borderRadius;

  /// Backdrop blur sigma (mobile/desktop only). Defaults to 18.
  final double blurSigma;

  /// Background color overlay (sits above the blur).
  final Color? color;

  /// Border color. Defaults to a subtle white tint.
  final Color? borderColor;

  /// Border width. Defaults to 1.
  final double borderWidth;

  /// Whether to render a soft shadow underneath the panel.
  final bool elevated;

  const GlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.blurSigma = 18,
    this.color,
    this.borderColor,
    this.borderWidth = 1,
    this.elevated = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final fillColor = color ?? Colors.white.withValues(alpha: 0.06);
    final stroke = borderColor ?? Colors.white.withValues(alpha: 0.12);

    final inner = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: radius,
        border: Border.all(color: stroke, width: borderWidth),
      ),
      child: child,
    );

    final clipped = ClipRRect(
      borderRadius: radius,
      child: kIsWeb
          // Web fallback: translucent fill, no BackdropFilter (perf + safety).
          ? inner
          : BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: inner,
            ),
    );

    if (!elevated) return clipped;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 32,
            spreadRadius: -8,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: clipped,
    );
  }
}

/// GlassPill — compact pill-shaped variant of [GlassPanel] for chips,
/// status indicators, language switchers, etc.
class GlassPill extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const GlassPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final panel = GlassPanel(
      borderRadius: 100,
      padding: padding,
      elevated: false,
      child: child,
    );
    if (onTap == null) return panel;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: panel,
    );
  }
}
