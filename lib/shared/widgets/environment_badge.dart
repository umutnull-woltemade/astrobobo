import 'package:flutter/material.dart';
import '../../core/config/app_environment.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Shows a small environment indicator badge in non-production builds.
/// Prevents accidental testing on production Supabase.
class EnvironmentBadge extends StatelessWidget {
  const EnvironmentBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final env = AppEnvironment.current;
    if (!env.showDebugIndicators) return const SizedBox.shrink();

    final color = env.isDev ? AppColors.success : AppColors.warning;

    return Positioned(
      top: 0,
      right: 0,
      child: IgnorePointer(
        child: Banner(
          message: env.displayName,
          location: BannerLocation.topEnd,
          color: color,
          textStyle: AppTypography.subtitle(
            fontSize: 10,
            color: Colors.white,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
