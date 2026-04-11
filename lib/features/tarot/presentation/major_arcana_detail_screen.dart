import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/content/tarot_content.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';

/// MAJOR ARCANA DETAY SAYFASI
///
/// 22 Major Arcana kartının her biri için derin ezoterik içerik.
/// Arketip, sembolizm, ruhsal ders, aşk/kariyer yorumları.
class MajorArcanaDetailScreen extends StatelessWidget {
  final int cardNumber;

  const MajorArcanaDetailScreen({super.key, required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    final content = majorArcanaContents[cardNumber];

    if (content == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Text(
              'Kart bilgisi bulunamadı',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 300) {
          context.pop();
        }
      },
      child: Scaffold(
        body: CosmicBackground(
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  snap: true,
                  expandedHeight: 280,
                  flexibleSpace: _buildHeader(context, content),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => _shareCard(context, content),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Quick Info Pills
                      _buildQuickInfoPills(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Deep Meaning
                      _buildDeepMeaningSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Kadim Not
                      KadimNotCard(
                        title: '${content.nameTr} Bilgeliği',
                        content: content.viralQuote.replaceAll('"', ''),
                        category: KadimCategory.tarot,
                        source: 'Arketipsel Bilgelik',
                      ),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Reversed Meaning
                      _buildReversedSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Symbolism
                      _buildSymbolismSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Spiritual Lesson
                      _buildSpiritualLessonSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Love & Career Readings
                      _buildReadingsSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Shadow Aspect
                      _buildShadowSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Meditation
                      _buildMeditationSection(context, content),
                      const SizedBox(height: AppConstants.spacingLg),

                      // Card Navigation
                      _buildCardNavigation(context, cardNumber),
                      const SizedBox(height: AppConstants.spacingXl),

                      // Next Blocks
                      const NextBlocks(currentPage: 'tarot'),
                      const SizedBox(height: AppConstants.spacingXl),

                      // Bottom Navigation
                      const PageBottomNavigation(currentRoute: '/tarot'),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MajorArcanaContent content) {
    final color = _getCardColor(cardNumber);

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
            // Card Visual
            Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withValues(alpha: 0.3), AppColors.surfaceDark],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getRomanNumeral(cardNumber),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(_getCardIcon(cardNumber), color: color, size: 32),
                ],
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            // Card Name
            Text(
              content.nameTr,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 4),
            Text(
              content.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 8),
            // Archetype Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.5)),
              ),
              child: Text(
                content.archetype,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoPills(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    final color = _getCardColor(cardNumber);

    return Wrap(
      spacing: AppConstants.spacingSm,
      runSpacing: AppConstants.spacingSm,
      children: [
        _buildInfoPill(
          context,
          'Element',
          content.element,
          Icons.blur_on,
          color,
        ),
        _buildInfoPill(
          context,
          'Gezegen',
          content.planet,
          Icons.public,
          Colors.orange,
        ),
        _buildInfoPill(
          context,
          'İbrani Harf',
          content.hebrewLetter,
          Icons.translate,
          Colors.teal,
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildInfoPill(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color.withValues(alpha: 0.7),
                  fontSize: 9,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeepMeaningSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    final color = _getCardColor(cardNumber);

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
                child: Icon(Icons.auto_awesome, color: color, size: 20),
              ),
              const SizedBox(width: 12),
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
          // Keywords
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingSm),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.tag, color: AppColors.textMuted, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    content.keywords,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.shortMeaning,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              height: 1.5,
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

  Widget _buildReversedSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
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
              Transform.rotate(
                angle: 3.14159,
                child: const Icon(
                  Icons.arrow_upward,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Ters Anlam',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.reversedMeaning.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSymbolismSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
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
              const Icon(
                Icons.visibility,
                color: AppColors.auroraEnd,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Sembolizm',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.auroraEnd,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.symbolism.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSpiritualLessonSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    final color = _getCardColor(cardNumber);

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
              const Icon(Icons.school, color: AppColors.auroraStart, size: 20),
              const SizedBox(width: 8),
              Text(
                'Ruhsal Ders',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.auroraStart,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.spiritualLesson.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          // Advice box
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    content.advice,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: color,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildReadingsSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Love Reading
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.fireElement.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppColors.fireElement.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: AppColors.fireElement,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Aşk',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.fireElement,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content.loveReading.trim(),
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
        // Career Reading
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
                    const Icon(Icons.work, color: AppColors.starGold, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Kariyer',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.starGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content.careerReading.trim(),
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

  Widget _buildShadowSection(BuildContext context, MajorArcanaContent content) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode, color: Colors.grey, size: 18),
              const SizedBox(width: 6),
              Text(
                'Gölge Yönü',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content.shadowAspect,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildMeditationSection(
    BuildContext context,
    MajorArcanaContent content,
  ) {
    final color = _getCardColor(cardNumber);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            AppColors.auroraEnd.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Icon(Icons.self_improvement, color: color, size: 36),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Meditasyon',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            content.meditation.trim(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.7,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCardNavigation(BuildContext context, int currentCard) {
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
            '22 Major Arcana',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 22,
              itemBuilder: (context, index) {
                final isCurrentCard = index == currentCard;
                final color = _getCardColor(index);

                return GestureDetector(
                  onTap: () {
                    if (!isCurrentCard) {
                      context.push('/tarot/major/$index');
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 50,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isCurrentCard
                          ? color
                          : color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: color,
                        width: isCurrentCard ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getRomanNumeral(index),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isCurrentCard ? Colors.white : color,
                          fontWeight: isCurrentCard
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Center(
            child: Text(
              'Şu an ${majorArcanaContents[currentCard]?.nameTr ?? ''} kartındasınız',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  void _shareCard(BuildContext context, MajorArcanaContent content) {
    context.push(
      '/cosmic-share',
      extra: {
        'title': content.nameTr,
        'subtitle': content.archetype,
        'content': content.viralQuote,
        'type': 'tarot',
      },
    );
  }

  Color _getCardColor(int number) {
    // Her kart için benzersiz renkler
    final colors = [
      const Color(0xFF00BCD4), // 0 - Fool - Cyan
      const Color(0xFFFFD700), // 1 - Magician - Gold
      const Color(0xFF9C27B0), // 2 - High Priestess - Purple
      const Color(0xFF4CAF50), // 3 - Empress - Green
      const Color(0xFFF44336), // 4 - Emperor - Red
      const Color(0xFF795548), // 5 - Hierophant - Brown
      const Color(0xFFE91E63), // 6 - Lovers - Pink
      const Color(0xFF607D8B), // 7 - Chariot - Blue Grey
      const Color(0xFFFF9800), // 8 - Strength - Orange
      const Color(0xFF3F51B5), // 9 - Hermit - Indigo
      const Color(0xFF9E9E9E), // 10 - Wheel - Grey
      const Color(0xFFCDDC39), // 11 - Justice - Lime
      const Color(0xFF2196F3), // 12 - Hanged Man - Blue
      const Color(0xFF212121), // 13 - Death - Black
      const Color(0xFF00BCD4), // 14 - Temperance - Cyan
      const Color(0xFF8B0000), // 15 - Devil - Dark Red
      const Color(0xFFFFEB3B), // 16 - Tower - Yellow
      const Color(0xFF7C4DFF), // 17 - Star - Deep Purple
      const Color(0xFFC0C0C0), // 18 - Moon - Silver
      const Color(0xFFFFD700), // 19 - Sun - Gold
      const Color(0xFF9C27B0), // 20 - Judgement - Purple
      const Color(0xFF4CAF50), // 21 - World - Green
    ];
    return colors[number % colors.length];
  }

  String _getRomanNumeral(int number) {
    final romanNumerals = [
      '0',
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
      'XIII',
      'XIV',
      'XV',
      'XVI',
      'XVII',
      'XVIII',
      'XIX',
      'XX',
      'XXI',
    ];
    if (number < 0 || number >= romanNumerals.length) return '?';
    return romanNumerals[number];
  }

  IconData _getCardIcon(int number) {
    final icons = [
      Icons.hiking, // Fool
      Icons.auto_fix_high, // Magician
      Icons.nights_stay, // High Priestess
      Icons.local_florist, // Empress
      Icons.gavel, // Emperor
      Icons.account_balance, // Hierophant
      Icons.favorite, // Lovers
      Icons.directions_car, // Chariot
      Icons.pets, // Strength
      Icons.lightbulb, // Hermit
      Icons.donut_large, // Wheel
      Icons.balance, // Justice
      Icons.flip, // Hanged Man
      Icons.spa, // Death (transformation)
      Icons.water_drop, // Temperance
      Icons.whatshot, // Devil
      Icons.flash_on, // Tower
      Icons.star, // Star
      Icons.nightlight_round, // Moon
      Icons.wb_sunny, // Sun
      Icons.campaign, // Judgement
      Icons.public, // World
    ];
    return icons[number % icons.length];
  }
}
