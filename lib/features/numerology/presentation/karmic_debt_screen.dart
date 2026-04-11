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

/// KARMİK BORÇ DETAY SAYFASI
///
/// 4 Karmik Borç sayısı (13, 14, 16, 19) için detaylı içerik.
/// Geçmiş yaşam kalıpları, mevcut dersler, iyileşme yolu.
class KarmicDebtScreen extends StatelessWidget {
  final int debtNumber;

  const KarmicDebtScreen({super.key, required this.debtNumber});

  @override
  Widget build(BuildContext context) {
    final content = karmicDebtContents[debtNumber];

    if (content == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Text(
              'Karmik borç bilgisi bulunamadı',
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
                expandedHeight: 260,
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
                    // Keywords
                    _buildKeywordsRow(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Deep Meaning
                    _buildDeepMeaningSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Kadim Not
                    KadimNotCard(
                      title: 'Karmik Bilgelik',
                      content: content.viralQuote.replaceAll('"', ''),
                      category: KadimCategory.numerology,
                      source: 'Karmik Döngü',
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Past Life Story
                    _buildPastLifeSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Current Life Lesson
                    _buildCurrentLessonSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Challenge & Gift
                    _buildChallengeGiftSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Healing Path
                    _buildHealingPathSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Warnings & Strengths
                    _buildWarningsStrengthsSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Life Areas
                    _buildLifeAreasSection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Affirmation
                    _buildAffirmationCard(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Other Karmic Debts
                    _buildOtherDebtsNavigation(context, debtNumber),
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

  Widget _buildHeader(BuildContext context, KarmicDebtContent content) {
    final color = _getDebtColor(debtNumber);

    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.4), Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Number with chain symbol
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      debtNumber.toString(),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                // Chain icon
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Text(
                      content.symbol,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            // Karmic Debt badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.5),
                ),
              ),
              child: const Text(
                'KARMİK BORÇ',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 8),
            // Title
            Text(
              content.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 4),
            Text(
              '${content.reducesTo} sayısına indirgenir • ${content.archetype}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordsRow(BuildContext context, KarmicDebtContent content) {
    final keywords = content.keywords.split(', ');
    final color = _getDebtColor(debtNumber);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: keywords
          .map(
            (keyword) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Text(
                keyword,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildDeepMeaningSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    final color = _getDebtColor(debtNumber);

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
              Icon(Icons.auto_awesome, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Derin Anlam',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.shortDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.deepMeaning.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildPastLifeSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history, color: Colors.purple, size: 20),
              const SizedBox(width: 8),
              Text(
                'Geçmiş Yaşam Kalıpları',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.pastLifeStory.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCurrentLessonSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school, color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              Text(
                'Bu Yaşamdaki Dersin',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.currentLifeLesson.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildChallengeGiftSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Challenge
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning, color: AppColors.error, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Zorluk',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content.challenge,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Gift
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.starGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppColors.starGold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.card_giftcard,
                      color: AppColors.starGold,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Armağan',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.starGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content.gift,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildHealingPathSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    final color = _getDebtColor(debtNumber);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withValues(alpha: 0.1),
            AppColors.auroraEnd.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.auroraStart.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.healing, color: AppColors.auroraStart, size: 20),
              const SizedBox(width: 8),
              Text(
                'İyileşme Yolu',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.auroraStart,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.healingPath.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          // Spiritual Practice
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.self_improvement, color: color, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Ruhsal Pratik',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content.spiritualPractice.trim(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildWarningsStrengthsSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    return Column(
      children: [
        // Warnings
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.do_not_disturb,
                    color: AppColors.error,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Dikkat Edilmesi Gerekenler',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...content.warnings.map(
                (warning) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(color: AppColors.error),
                      ),
                      Expanded(
                        child: Text(
                          warning,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Strengths
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.success, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Güçlü Yönler (Öğrenildiğinde)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...content.strengths.map(
                (strength) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(color: AppColors.success),
                      ),
                      Expanded(
                        child: Text(
                          strength,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildLifeAreasSection(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hayat Alanlarında Etkisi',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _buildLifeAreaCard(
          context,
          'İlişkiler',
          Icons.favorite,
          Colors.pink,
          content.relationships,
        ),
        const SizedBox(height: 8),
        _buildLifeAreaCard(
          context,
          'Kariyer',
          Icons.work,
          Colors.blue,
          content.career,
        ),
        const SizedBox(height: 8),
        _buildLifeAreaCard(
          context,
          'Sağlık',
          Icons.health_and_safety,
          Colors.green,
          content.health,
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildLifeAreaCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String content,
  ) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
      childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      leading: Icon(icon, color: color, size: 20),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
      ),
      iconColor: AppColors.textMuted,
      collapsedIconColor: AppColors.textMuted,
      backgroundColor: AppColors.surfaceLight.withValues(alpha: 0.3),
      collapsedBackgroundColor: AppColors.surfaceLight.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        Text(
          content.trim(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildAffirmationCard(
    BuildContext context,
    KarmicDebtContent content,
  ) {
    final color = _getDebtColor(debtNumber);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.2),
            AppColors.auroraEnd.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: color, size: 32),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.affirmation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Günlük Olumlama',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildOtherDebtsNavigation(BuildContext context, int currentDebt) {
    final allDebts = [13, 14, 16, 19];

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Diğer Karmik Borçlar',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: allDebts.map((debt) {
              final isCurrentDebt = debt == currentDebt;
              final color = _getDebtColor(debt);
              final title = karmicDebtContents[debt]?.title ?? '';

              return GestureDetector(
                onTap: isCurrentDebt
                    ? null
                    : () {
                        context.push('/numerology/karmic-debt/$debt');
                      },
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCurrentDebt
                            ? color
                            : color.withValues(alpha: 0.2),
                        border: Border.all(
                          color: color,
                          width: isCurrentDebt ? 3 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          debt.toString(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: isCurrentDebt ? Colors.white : color,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title.split(' ').first,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isCurrentDebt ? color : AppColors.textMuted,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Color _getDebtColor(int debt) {
    switch (debt) {
      case 13:
        return const Color(0xFF8B4513); // Brown - Work/Foundation
      case 14:
        return const Color(0xFF00BCD4); // Cyan - Freedom
      case 16:
        return const Color(0xFF9C27B0); // Purple - Ego/Tower
      case 19:
        return const Color(0xFFFFD700); // Gold - Power
      default:
        return AppColors.auroraStart;
    }
  }
}
