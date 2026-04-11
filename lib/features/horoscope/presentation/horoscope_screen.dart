import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/zodiac_card.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

class HoroscopeScreen extends ConsumerStatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  ConsumerState<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends ConsumerState<HoroscopeScreen> {
  bool _hasAutoNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasAutoNavigated) {
        _hasAutoNavigated = true;
        final userProfile = ref.read(userProfileProvider);
        if (userProfile?.sunSign != null && context.mounted) {
          context.pushReplacement(
            '${Routes.horoscope}/${userProfile!.sunSign.name.toLowerCase()}',
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Responsive crossAxisCount - masaüstünde 6, tablette 4, mobilde 3
    int crossAxisCount;
    double childAspectRatio;
    double spacing;

    if (screenWidth > 1200) {
      // Geniş masaüstü - 6 sütun, 2 satırda 12 burç (tek ekranda tümü)
      crossAxisCount = 6;
      childAspectRatio = 0.72;
      spacing = 14;
    } else if (screenWidth > 900) {
      // Masaüstü - 4 sütun
      crossAxisCount = 4;
      childAspectRatio = 0.70;
      spacing = 12;
    } else if (screenWidth > 600) {
      // Tablet - 3 sütun
      crossAxisCount = 3;
      childAspectRatio = 0.68;
      spacing = 10;
    } else {
      // Mobil - 2 sütun
      crossAxisCount = 2;
      childAspectRatio = 0.65;
      spacing = 10;
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Kompakt
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingLg,
                  vertical: AppConstants.spacingMd,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                      onPressed: () => context.pop(),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bugün burcun ne diyor?',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.starGold
                                      : AppColors.lightStarGold,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Burcunu seç, kozmik enerjini keşfet',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Grid
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth > 900
                              ? 24
                              : AppConstants.spacingLg,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemCount: ZodiacSign.values.length,
                          itemBuilder: (context, index) {
                            final sign = ZodiacSign.values[index];
                            return ZodiacGridCard(
                              sign: sign,
                              onTap: () => context.push(
                                '${Routes.horoscope}/${sign.name.toLowerCase()}',
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Quiz CTA - Google Discover Funnel
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth > 900
                              ? 24
                              : AppConstants.spacingLg,
                        ),
                        child: QuizCTACard.astrology(compact: true),
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Back-Button-Free Navigation
                      const PageBottomNavigation(currentRoute: '/horoscope'),
                      const SizedBox(height: AppConstants.spacingLg),
                      // Footer with branding
                      const PageFooterWithDisclaimer(
                        brandText: 'Burç Yorumları — Venus One',
                        disclaimerText: DisclaimerTexts.astrology,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
