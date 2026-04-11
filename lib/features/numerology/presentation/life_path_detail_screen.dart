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

/// YAŞAM YOLU DETAY SAYFASI
///
/// Her yaşam yolu sayısı (1-9) için detaylı içerik sayfası.
/// Kadim/ezoterik dilde yazılmış derin içerikler.
class LifePathDetailScreen extends StatelessWidget {
  final int number;

  const LifePathDetailScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final content = lifePathContents[number];

    if (content == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Text(
              'Yaşam yolu sayısı bulunamadı',
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
              // App Bar
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                snap: true,
                expandedHeight: 200,
                flexibleSpace: _buildHeader(context, content),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              // Content
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // AI-QUOTABLE: İlk 3 Bullet (Kısa Cevap)
                    _buildQuotableBullets(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Quick Info Pills
                    _buildQuickInfoPills(context, content),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Deep Meaning
                    _buildSection(
                      context,
                      'Derin Anlam',
                      content.deepMeaning,
                      Icons.auto_awesome,
                      AppColors.auroraStart,
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

                    // Gift to World
                    _buildSection(
                      context,
                      'Dünyaya Armağanın',
                      content.giftToWorld,
                      Icons.card_giftcard,
                      AppColors.success,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Kadim Not
                    KadimNotCard(
                      title: '${content.number} Sayısının Sırrı',
                      content: content.viralQuote,
                      category: KadimCategory.numerology,
                      source: 'Kadim Numeroloji',
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Love & Relationships
                    _buildSection(
                      context,
                      'Aşk ve İlişkiler',
                      content.loveAndRelationships,
                      Icons.favorite,
                      AppColors.fireElement,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Career Path
                    _buildSection(
                      context,
                      'Kariyer Yolu',
                      content.careerPath,
                      Icons.work,
                      AppColors.earthElement,
                    ),
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

                    // Shadow Work
                    _buildShadowSection(context, content.shadowWork),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Health & Wellness
                    _buildSection(
                      context,
                      'Sağlık ve Wellness',
                      content.healthAndWellness,
                      Icons.spa,
                      AppColors.airElement,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Compatible Numbers
                    _buildCompatibilitySection(context, content),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Famous People
                    _buildFamousPeopleSection(context, content.famousPeople),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Daily Affirmation
                    _buildAffirmationCard(context, content.dailyAffirmation),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Next Blocks
                    const NextBlocks(currentPage: 'numerology'),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Bottom Navigation
                    const PageBottomNavigation(currentRoute: '/numerology'),
                    const SizedBox(height: AppConstants.spacingLg),

                    // AI-QUOTABLE: Footer
                    Center(
                      child: Text(
                        'Numeroloji — Venus One',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// AI-QUOTABLE: İlk 3 bullet - direkt cevap
  Widget _buildQuotableBullets(BuildContext context, LifePathContent content) {
    final color = _getColorForNumber(content.number);
    final bullets = _getQuotableBullets(content.number);
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kısa Cevap',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bullet,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  List<String> _getQuotableBullets(int number) {
    final Map<int, List<String>> bullets = {
      1: [
        'Yaşam yolu 1, liderlik ve bağımsızlık enerjisi taşır.',
        'Öncü ruh, yeni başlangıçlar için doğmuştur.',
        'Bireysellik ve özgünlük temel yaşam temasıdır.',
      ],
      2: [
        'Yaşam yolu 2, denge ve ortaklık enerjisi taşır.',
        'Diplomasi ve uyum sağlama doğal yetenektir.',
        'İlişkiler ve işbirliği yaşam amacının merkezindedir.',
      ],
      3: [
        'Yaşam yolu 3, yaratıcılık ve ifade enerjisi taşır.',
        'Sanat ve iletişim alanında doğal yetenek vardır.',
        'Neşe ve ilham yaymak ruhsal misyondur.',
      ],
      4: [
        'Yaşam yolu 4, düzen ve istikrar enerjisi taşır.',
        'Sağlam temeller kurmak için doğmuştur.',
        'Disiplin ve çalışkanlık temel yaşam temasıdır.',
      ],
      5: [
        'Yaşam yolu 5, özgürlük ve değişim enerjisi taşır.',
        'Macera ve deneyim arayışı doğaldır.',
        'Esneklik ve uyum sağlama güçlü yanlarıdır.',
      ],
      6: [
        'Yaşam yolu 6, sorumluluk ve sevgi enerjisi taşır.',
        'Aile ve toplum için bakım vermek doğaldır.',
        'Uyum ve güzellik yaratmak yaşam amacıdır.',
      ],
      7: [
        'Yaşam yolu 7, bilgelik ve içe bakış enerjisi taşır.',
        'Spiritüel arayış ve analiz doğal eğilimdir.',
        'Derin anlam arayışı yaşamın merkezindedir.',
      ],
      8: [
        'Yaşam yolu 8, güç ve bolluk enerjisi taşır.',
        'Maddi ve manevi başarı için potansiyel yüksektir.',
        'Liderlik ve yöneticilik doğal yetenektir.',
      ],
      9: [
        'Yaşam yolu 9, insanlık ve tamamlanma enerjisi taşır.',
        'Evrensel sevgi ve şefkat doğal haldir.',
        'Başkalarına hizmet etmek ruhsal misyondur.',
      ],
    };
    return bullets[number] ??
        [
          'Bu sayı özel bir enerji taşır.',
          'Potansiyelin keşfedilmeyi bekliyor.',
          'Yaşam yolculuğun benzersizdir.',
        ];
  }

  Widget _buildHeader(BuildContext context, LifePathContent content) {
    final color = _getColorForNumber(content.number);
    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.3), Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // AI-QUOTABLE: H1 Soru formatı
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingLg,
              ),
              child: Text(
                'Yaşam yolu ${content.number} ne demek?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Brand tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Numeroloji',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Number Circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    _getColorForNumber(content.number),
                    _getColorForNumber(content.number).withValues(alpha: 0.6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _getColorForNumber(
                      content.number,
                    ).withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  content.number.toString(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
            const SizedBox(height: 12),
            // Title
            Text(
              'Yaşam Yolu ${content.number}: ${content.title}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 4),
            // Archetype
            Text(
              content.archetype,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoPills(BuildContext context, LifePathContent content) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _buildInfoPill(
          context,
          content.symbol,
          content.element,
          _getElementColor(content.element),
        ),
        _buildInfoPill(context, '☿', content.planet, AppColors.auroraStart),
        _buildInfoPill(context, '🎴', content.tarotCard, AppColors.auroraEnd),
        _buildInfoPill(context, '🎨', content.color, AppColors.starGold),
        _buildInfoPill(context, '💎', content.crystal, AppColors.moonSilver),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildInfoPill(
    BuildContext context,
    String emoji,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
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

  Widget _buildShadowSection(BuildContext context, String shadowWork) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.error.withValues(alpha: 0.1),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.nights_stay,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Gölge Taraf',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            shadowWork,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.textMuted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Gölge farkındalıkla dönüşür. Kabullenmek, entegre etmektir.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
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

  Widget _buildCompatibilitySection(
    BuildContext context,
    LifePathContent content,
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
          Text(
            'Sayı Uyumu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Expanded(
                child: _buildCompatibilityGroup(
                  context,
                  'Uyumlu',
                  content.compatibleNumbers,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCompatibilityGroup(
                  context,
                  'Zorlayıcı',
                  content.challengingNumbers,
                  AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCompatibilityGroup(
    BuildContext context,
    String label,
    List<String> numbers,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: numbers.map((numStr) {
            return Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Text(
                  numStr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFamousPeopleSection(BuildContext context, String famousPeople) {
    final people = famousPeople.split(', ');
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.starGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Bu Yaşam Yolundaki Ünlüler',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: people.map((person) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  person.trim(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.starGold),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildAffirmationCard(BuildContext context, String affirmation) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getColorForNumber(number).withValues(alpha: 0.2),
            AppColors.auroraEnd.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: _getColorForNumber(number).withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: _getColorForNumber(number), size: 32),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            affirmation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Günlük Olumlamanız',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Color _getColorForNumber(int number) {
    switch (number) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFF78909C); // Blue Grey
      case 3:
        return const Color(0xFFFF9800); // Orange
      case 4:
        return const Color(0xFF4CAF50); // Green
      case 5:
        return const Color(0xFF00BCD4); // Cyan
      case 6:
        return const Color(0xFFE91E63); // Pink
      case 7:
        return const Color(0xFF9C27B0); // Purple
      case 8:
        return const Color(0xFF212121); // Black
      case 9:
        return const Color(0xFFF44336); // Red
      default:
        return AppColors.auroraStart;
    }
  }

  Color _getElementColor(String element) {
    switch (element.toLowerCase()) {
      case 'ateş':
        return AppColors.fireElement;
      case 'toprak':
        return AppColors.earthElement;
      case 'hava':
        return AppColors.airElement;
      case 'su':
        return AppColors.waterElement;
      default:
        return AppColors.auroraStart;
    }
  }
}
