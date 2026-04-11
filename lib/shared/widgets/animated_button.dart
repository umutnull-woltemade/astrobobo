import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Animated gradient button with press effects
class AnimatedGradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final List<Color>? gradientColors;
  final double height;
  final double? width;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool hapticFeedback;

  const AnimatedGradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.gradientColors,
    this.height = 56,
    this.width,
    this.borderRadius = 16,
    this.textStyle,
    this.hapticFeedback = true,
  });

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.isDisabled || widget.isLoading) return;
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.isDisabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    if (widget.isDisabled || widget.isLoading) return;
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTap() {
    if (widget.isDisabled || widget.isLoading || widget.onPressed == null)
      return;
    if (widget.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultGradient = [AppColors.cosmicPurple, AppColors.mysticBlue];
    final colors = widget.gradientColors ?? defaultGradient;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.isDisabled ? 0.5 : 1.0,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.isDisabled
                        ? [Colors.grey, Colors.grey.shade600]
                        : colors,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: widget.isDisabled
                      ? null
                      : [
                          BoxShadow(
                            color: colors.first.withOpacity(
                              _isPressed ? 0.3 : 0.5,
                            ),
                            blurRadius: _isPressed ? 8 : 16,
                            offset: Offset(0, _isPressed ? 2 : 6),
                          ),
                        ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDark ? Colors.white : Colors.white,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.icon != null) ...[
                                Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                              ],
                              Text(
                                widget.label,
                                style:
                                    widget.textStyle ??
                                    Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Icon button with animated press effect
class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final String? tooltip;
  final bool hapticFeedback;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.size = 44,
    this.tooltip,
    this.hapticFeedback = true,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        widget.color ??
        (isDark ? AppColors.textPrimary : AppColors.lightTextPrimary);
    final bgColor =
        widget.backgroundColor ??
        (isDark
            ? AppColors.surfaceLight.withOpacity(0.1)
            : AppColors.lightSurfaceVariant);

    Widget button = GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        if (widget.onPressed != null) {
          if (widget.hapticFeedback) {
            HapticFeedback.lightImpact();
          }
          widget.onPressed!();
        }
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _isPressed ? bgColor.withOpacity(0.8) : bgColor,
            shape: BoxShape.circle,
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Icon(widget.icon, color: iconColor, size: widget.size * 0.5),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}

/// Floating action button with cosmic style
class CosmicFloatingButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final bool extended;

  const CosmicFloatingButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.extended = false,
  });

  @override
  State<CosmicFloatingButton> createState() => _CosmicFloatingButtonState();
}

class _CosmicFloatingButtonState extends State<CosmicFloatingButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () {
            HapticFeedback.mediumImpact();
            widget.onPressed?.call();
          },
          child: AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: widget.extended
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 14)
                  : const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.starGold, AppColors.cosmicPurple],
                ),
                borderRadius: BorderRadius.circular(widget.extended ? 30 : 56),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.starGold.withOpacity(0.4),
                    blurRadius: _isPressed ? 8 : 16,
                    offset: Offset(0, _isPressed ? 2 : 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: Colors.white, size: 24),
                  if (widget.extended && widget.label != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      widget.label!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -4, duration: 2000.ms, curve: Curves.easeInOut);
  }
}

/// Outlined button with animated border
class AnimatedOutlinedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? borderColor;
  final double height;

  const AnimatedOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.borderColor,
    this.height = 48,
  });

  @override
  State<AnimatedOutlinedButton> createState() => _AnimatedOutlinedButtonState();
}

class _AnimatedOutlinedButtonState extends State<AnimatedOutlinedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.borderColor ?? AppColors.starGold;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onPressed?.call();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: _isPressed ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: _isPressed ? 2 : 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: color, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chip selector with animation
class AnimatedChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? selectedColor;

  const AnimatedChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = selectedColor ?? AppColors.starGold;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
                )
              : null,
          color: isSelected
              ? null
              : (isDark
                    ? AppColors.surfaceLight.withOpacity(0.1)
                    : AppColors.lightSurfaceVariant),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? Colors.white
                    : (isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? Colors.white
                    : (isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
