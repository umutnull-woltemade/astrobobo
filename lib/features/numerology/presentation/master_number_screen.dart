import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/content/numerology_content.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';

/// MASTER SAYI DETAY SAYFASI
///
/// Master sayılar (11, 22, 33) için detaylı içerik sayfası.
/// Özel ve nadir olan bu sayıların derin anlamlarını açıklar.
class MasterNumberScreen extends StatelessWidget {
  final int number;

  const MasterNumberScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final content = masterNumberContents[number];

    if (content == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Text(
              'Master sayı bulunamadı',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                snap: true,
                expandedHeight: 220,
                flexibleSpace: _buildHeader(context, content),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Master Number Badge
                    _buildMasterBadge(context, content),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Deep Meaning
                    _buildSection(
                      context,
                      'Derin Anlam',
                      content.deepMeaning,
                      Icons.auto_awesome,
                      _getColorForMaster(number),
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Soul Mission
                    _buildSection(
                      context,
                      'Ruh Misyonu',
                      content.soulMission,
                      Icons.self_improvement,
                      AppColors.starGold,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Kadim Not
                    KadimNotCard(
                      title: 'Master $number\'in Sırrı',
                      content: content.viralQuote,
                      category: KadimCategory.numerology,
                      source: 'Kadim Numeroloji',
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Challenge
                    _buildChallengeSection(context, content.challenge),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Spiritual Lesson
                    _buildSection(
                      context,
                      'Ruhsal Ders',
                      content.spiritualLesson,
                      Icons.lightbulb,
                      AppColors.moonSilver,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Keywords
                    _buildKeywordsSection(context, content.keywords),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Master Number Tip
                    _buildMasterTip(context, number),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Next Blocks
                    const NextBlocks(currentPage: 'numerology'),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Bottom Navigation
                    const PageBottomNavigation(currentRoute: '/numerology'),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MasterNumberContent content) {
    final color = _getColorForMaster(number);

    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.4),
              color.withValues(alpha: 0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Master Number with glow
            Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow effect
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.6),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    // Number circle
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color, color.withValues(alpha: 0.7)],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ),
                    // Decorative ring
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: color.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut),
            const SizedBox(height: 16),
            // Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Text(
                'MASTER SAYI',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              content.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 4),
            Text(
              content.archetype,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMasterBadge(BuildContext context, MasterNumberContent content) {
    final color = _getColorForMaster(number);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.2),
            AppColors.starGold.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Master Sayı Özelliği',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
              const SizedBox(width: 8),
              Icon(Icons.star, color: AppColors.starGold, size: 20),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.shortDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          // Element tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${content.element} Enerjisi',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.15), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildChallengeSection(BuildContext context, String challenge) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warning.withValues(alpha: 0.15),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.warning_amber,
                  color: AppColors.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Zorluklar',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            challenge.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildKeywordsSection(BuildContext context, List<String> keywords) {
    final color = _getColorForMaster(number);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tag, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Anahtar Kelimeler',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: keywords.map((keyword) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  keyword,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: color),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildMasterTip(BuildContext context, int number) {
    final tips = {
      11: 'Master 11 olarak, yüksek sezgi ve hassasiyetinizi korumak için düzenli meditasyon ve topraklanma pratiği yapın. Enerji vampirlerinden kendinizi koruyun.',
      22: 'Master 22 olarak, büyük vizyonlarınızı adım adım inşa edin. Mükemmeliyetçilik felç edebilir - "yapılmış, mükemmelden iyidir" ilkesini benimseyin.',
      33: 'Master 33 olarak, başkalarına şifa verirken kendinizi ihmal etmeyin. Sınırlar sevgisizlik değil - önce kendi maskenizi takın.',
    };

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withValues(alpha: 0.2),
            AppColors.auroraEnd.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.auroraStart.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.auroraStart.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.tips_and_updates,
                  color: AppColors.auroraStart,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Master $number İçin Pratik Tavsiye',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.auroraStart,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            tips[number] ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Color _getColorForMaster(int number) {
    switch (number) {
      case 11:
        return const Color(0xFF9C27B0); // Purple - Intuition
      case 22:
        return const Color(0xFF4CAF50); // Green - Building
      case 33:
        return const Color(0xFFFFD700); // Gold - Mastery
      default:
        return AppColors.auroraStart;
    }
  }
}
