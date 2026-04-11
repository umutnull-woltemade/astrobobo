import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Shimmer loading effect widget for skeleton screens
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isCircle;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = 8,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark
        ? AppColors.surfaceLight.withOpacity(0.1)
        : Colors.grey.shade200;
    final highlightColor = isDark
        ? AppColors.surfaceLight.withOpacity(0.2)
        : Colors.grey.shade100;

    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: highlightColor);
  }
}

/// Skeleton card for loading states
class SkeletonCard extends StatelessWidget {
  final double? width;
  final double height;

  const SkeletonCard({super.key, this.width, this.height = 120});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.5)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerLoading(width: 40, height: 40, isCircle: true),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(width: 120, height: 16, borderRadius: 4),
                    const SizedBox(height: 8),
                    ShimmerLoading(width: 80, height: 12, borderRadius: 4),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          ShimmerLoading(height: 12, borderRadius: 4),
          const SizedBox(height: 8),
          ShimmerLoading(width: 200, height: 12, borderRadius: 4),
        ],
      ),
    );
  }
}

/// Skeleton list for loading states
class SkeletonList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const SkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index < itemCount - 1 ? spacing : 0),
          child: SkeletonListItem(height: itemHeight),
        );
      }),
    );
  }
}

/// Skeleton list item
class SkeletonListItem extends StatelessWidget {
  final double height;

  const SkeletonListItem({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: height,
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.5)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          ShimmerLoading(
            width: height - 32,
            height: height - 32,
            borderRadius: 8,
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerLoading(width: 150, height: 14, borderRadius: 4),
                const SizedBox(height: 8),
                ShimmerLoading(width: 100, height: 10, borderRadius: 4),
                const SizedBox(height: 6),
                ShimmerLoading(width: 200, height: 10, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton grid for card layouts
class SkeletonGrid extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double childAspectRatio;
  final double spacing;

  const SkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 6,
    this.childAspectRatio = 1.0,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const SkeletonGridItem(),
    );
  }
}

/// Skeleton grid item
class SkeletonGridItem extends StatelessWidget {
  const SkeletonGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.5)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ShimmerLoading(width: 48, height: 48, isCircle: true),
          const SizedBox(height: AppConstants.spacingMd),
          ShimmerLoading(width: 80, height: 14, borderRadius: 4),
          const SizedBox(height: 8),
          ShimmerLoading(width: 60, height: 10, borderRadius: 4),
        ],
      ),
    );
  }
}

/// Horoscope card skeleton
class HoroscopeCardSkeleton extends StatelessWidget {
  const HoroscopeCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.surfaceDark.withOpacity(0.8),
                  AppColors.surfaceDark.withOpacity(0.5),
                ]
              : [AppColors.lightCard, AppColors.lightSurfaceVariant],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerLoading(width: 56, height: 56, isCircle: true),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(width: 100, height: 20, borderRadius: 4),
                    const SizedBox(height: 8),
                    ShimmerLoading(width: 150, height: 14, borderRadius: 4),
                  ],
                ),
              ),
              const ShimmerLoading(width: 40, height: 40, borderRadius: 20),
            ],
          ),
          const SizedBox(height: AppConstants.spacingXl),
          ShimmerLoading(height: 14, borderRadius: 4),
          const SizedBox(height: 10),
          ShimmerLoading(height: 14, borderRadius: 4),
          const SizedBox(height: 10),
          ShimmerLoading(width: 250, height: 14, borderRadius: 4),
          const SizedBox(height: AppConstants.spacingXl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return Column(
                children: [
                  const ShimmerLoading(width: 36, height: 36, isCircle: true),
                  const SizedBox(height: 8),
                  ShimmerLoading(width: 50, height: 10, borderRadius: 4),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Cosmic loading animation
class CosmicLoadingIndicator extends StatelessWidget {
  final double size;
  final String? message;

  const CosmicLoadingIndicator({super.key, this.size = 60, this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.starGold.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .rotate(duration: 3000.ms, curve: Curves.linear),
              // Middle ring
              Container(
                    width: size * 0.7,
                    height: size * 0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.cosmicPurple.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .rotate(duration: 2000.ms, curve: Curves.linear, begin: 1),
              // Center dot
              Container(
                    width: size * 0.3,
                    height: size * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.starGold,
                          AppColors.starGold.withOpacity(0.5),
                        ],
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.2, 1.2),
                    duration: 1000.ms,
                  ),
              // Stars
              ...List.generate(4, (index) {
                final angle = index * 90.0;
                return Positioned(
                  left: size / 2 + (size / 2 - 4) * _cos(angle) - 4,
                  top: size / 2 + (size / 2 - 4) * _sin(angle) - 4,
                  child:
                      Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.starGold,
                              shape: BoxShape.circle,
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .fadeIn(delay: (index * 200).ms, duration: 500.ms)
                          .then()
                          .fadeOut(duration: 500.ms),
                );
              }),
            ],
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 20),
          Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                ),
                textAlign: TextAlign.center,
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(duration: 1000.ms)
              .then()
              .fadeOut(duration: 1000.ms),
        ],
      ],
    );
  }

  double _cos(double degrees) => math.cos(degrees * math.pi / 180);
  double _sin(double degrees) => math.sin(degrees * math.pi / 180);
}

/// Pulsating dot indicator
class PulsatingDot extends StatelessWidget {
  final Color color;
  final double size;

  const PulsatingDot({
    super.key,
    this.color = AppColors.success,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.5), blurRadius: 4),
            ],
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.3, 1.3),
          duration: 800.ms,
          curve: Curves.easeInOut,
        );
  }
}
