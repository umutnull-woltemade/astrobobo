import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Toast notification types
enum ToastType { success, error, warning, info, cosmic }

/// Custom toast notification widget
class ToastNotification {
  static OverlayEntry? _currentOverlay;

  /// Show a toast notification
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? title,
    IconData? customIcon,
    VoidCallback? onTap,
  }) {
    _currentOverlay?.remove();

    final overlay = Overlay.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        title: title,
        customIcon: customIcon,
        onTap: onTap,
        isDark: isDark,
        onDismiss: () {
          entry.remove();
          _currentOverlay = null;
        },
      ),
    );

    _currentOverlay = entry;
    overlay.insert(entry);

    Future.delayed(duration, () {
      if (_currentOverlay == entry) {
        entry.remove();
        _currentOverlay = null;
      }
    });
  }

  /// Show success toast
  static void success(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.success, title: title);
  }

  /// Show error toast
  static void error(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.error, title: title);
  }

  /// Show warning toast
  static void warning(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.warning, title: title);
  }

  /// Show info toast
  static void info(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.info, title: title);
  }

  /// Show cosmic toast (special astrology themed)
  static void cosmic(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.cosmic, title: title);
  }

  /// Dismiss current toast
  static void dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final ToastType type;
  final String? title;
  final IconData? customIcon;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;
  final bool isDark;

  const _ToastWidget({
    required this.message,
    required this.type,
    this.title,
    this.customIcon,
    this.onTap,
    required this.onDismiss,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Align(
          alignment: Alignment.topCenter,
          child:
              Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        onTap?.call();
                        onDismiss();
                      },
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity != null &&
                            details.primaryVelocity!.abs() > 100) {
                          onDismiss();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppConstants.spacingLg),
                        decoration: BoxDecoration(
                          gradient: type == ToastType.cosmic
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.cosmicPurple.withOpacity(0.95),
                                    AppColors.mysticBlue.withOpacity(0.95),
                                  ],
                                )
                              : null,
                          color: type != ToastType.cosmic
                              ? config.backgroundColor
                              : null,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: config.borderColor,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: config.color.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: config.color.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                customIcon ?? config.icon,
                                color: config.iconColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacingMd),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (title != null)
                                    Text(
                                      title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: config.textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  Text(
                                    message,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: config.textColor.withOpacity(
                                            0.9,
                                          ),
                                        ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: onDismiss,
                              icon: Icon(
                                Icons.close,
                                color: config.textColor.withOpacity(0.6),
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .slideY(
                    begin: -0.5,
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  ),
        ),
      ),
    );
  }

  _ToastConfig _getConfig() {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          icon: Icons.check_circle_outline,
          color: AppColors.success,
          backgroundColor: isDark
              ? AppColors.success.withOpacity(0.15)
              : AppColors.success.withOpacity(0.1),
          borderColor: AppColors.success.withOpacity(0.4),
          iconColor: AppColors.success,
          textColor: isDark ? Colors.white : AppColors.success.withOpacity(0.9),
        );
      case ToastType.error:
        return _ToastConfig(
          icon: Icons.error_outline,
          color: AppColors.error,
          backgroundColor: isDark
              ? AppColors.error.withOpacity(0.15)
              : AppColors.error.withOpacity(0.1),
          borderColor: AppColors.error.withOpacity(0.4),
          iconColor: AppColors.error,
          textColor: isDark ? Colors.white : AppColors.error.withOpacity(0.9),
        );
      case ToastType.warning:
        return _ToastConfig(
          icon: Icons.warning_amber_outlined,
          color: AppColors.warning,
          backgroundColor: isDark
              ? AppColors.warning.withOpacity(0.15)
              : AppColors.warning.withOpacity(0.1),
          borderColor: AppColors.warning.withOpacity(0.4),
          iconColor: AppColors.warning,
          textColor: isDark ? Colors.white : AppColors.warning.withOpacity(0.9),
        );
      case ToastType.info:
        return _ToastConfig(
          icon: Icons.info_outline,
          color: AppColors.airElement,
          backgroundColor: isDark
              ? AppColors.airElement.withOpacity(0.15)
              : AppColors.airElement.withOpacity(0.1),
          borderColor: AppColors.airElement.withOpacity(0.4),
          iconColor: AppColors.airElement,
          textColor: isDark
              ? Colors.white
              : AppColors.airElement.withOpacity(0.9),
        );
      case ToastType.cosmic:
        return _ToastConfig(
          icon: Icons.auto_awesome,
          color: AppColors.starGold,
          backgroundColor: Colors.transparent,
          borderColor: AppColors.starGold.withOpacity(0.5),
          iconColor: AppColors.starGold,
          textColor: Colors.white,
        );
    }
  }
}

class _ToastConfig {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const _ToastConfig({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });
}

/// Snackbar helper with consistent styling
class CosmicSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final config = _getConfig(
      type,
      Theme.of(context).brightness == Brightness.dark,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(config.icon, color: config.iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: TextStyle(color: config.textColor)),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: config.borderColor),
        ),
        duration: duration,
        action: action,
      ),
    );
  }

  static _ToastConfig _getConfig(ToastType type, bool isDark) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          icon: Icons.check_circle_outline,
          color: AppColors.success,
          backgroundColor: isDark
              ? AppColors.success.withOpacity(0.2)
              : AppColors.success.withOpacity(0.15),
          borderColor: AppColors.success.withOpacity(0.4),
          iconColor: isDark ? Colors.white : AppColors.success,
          textColor: isDark ? Colors.white : Colors.black87,
        );
      case ToastType.error:
        return _ToastConfig(
          icon: Icons.error_outline,
          color: AppColors.error,
          backgroundColor: isDark
              ? AppColors.error.withOpacity(0.2)
              : AppColors.error.withOpacity(0.15),
          borderColor: AppColors.error.withOpacity(0.4),
          iconColor: isDark ? Colors.white : AppColors.error,
          textColor: isDark ? Colors.white : Colors.black87,
        );
      case ToastType.warning:
        return _ToastConfig(
          icon: Icons.warning_amber_outlined,
          color: AppColors.warning,
          backgroundColor: isDark
              ? AppColors.warning.withOpacity(0.2)
              : AppColors.warning.withOpacity(0.15),
          borderColor: AppColors.warning.withOpacity(0.4),
          iconColor: isDark ? Colors.white : AppColors.warning,
          textColor: isDark ? Colors.white : Colors.black87,
        );
      case ToastType.info:
        return _ToastConfig(
          icon: Icons.info_outline,
          color: AppColors.airElement,
          backgroundColor: isDark
              ? AppColors.airElement.withOpacity(0.2)
              : AppColors.airElement.withOpacity(0.15),
          borderColor: AppColors.airElement.withOpacity(0.4),
          iconColor: isDark ? Colors.white : AppColors.airElement,
          textColor: isDark ? Colors.white : Colors.black87,
        );
      case ToastType.cosmic:
        return _ToastConfig(
          icon: Icons.auto_awesome,
          color: AppColors.starGold,
          backgroundColor: isDark
              ? AppColors.cosmicPurple.withOpacity(0.3)
              : AppColors.cosmicPurple.withOpacity(0.2),
          borderColor: AppColors.starGold.withOpacity(0.5),
          iconColor: AppColors.starGold,
          textColor: isDark ? Colors.white : Colors.black87,
        );
    }
  }
}
