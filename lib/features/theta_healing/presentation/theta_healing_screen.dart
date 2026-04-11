import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Theta Healing Screen - Bilinçaltı Dönüşüm Pratiği
/// Theta beyin dalgası durumunda yapılan enerji çalışması
class ThetaHealingScreen extends StatefulWidget {
  const ThetaHealingScreen({super.key});

  @override
  State<ThetaHealingScreen> createState() => _ThetaHealingScreenState();
}

class _ThetaHealingScreenState extends State<ThetaHealingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              _buildTabBar(isDark),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildIntroTab(isDark),
                    _buildTechniquesTab(isDark),
                    _buildMeditationsTab(isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🧠', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          'Theta Healing',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textDark,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bilinçaltı Dönüşüm Pratiği',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFF7C4DFF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'Theta Healing, theta beyin dalgası durumunda (4-7 Hz) bilinçaltı inançları ve enerji bloklarını dönüştürmeye yönelik bir şifa tekniğidir. Bu pratik, sınırlayıcı inançları keşfetmenize ve pozitif değişimler yaratmanıza yardımcı olur.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildTabBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: isDark ? const Color(0xFF7C4DFF) : const Color(0xFF5E35B1),
        unselectedLabelColor: isDark ? Colors.white60 : AppColors.textLight,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: isDark
              ? const Color(0xFF7C4DFF).withValues(alpha: 0.2)
              : const Color(0xFF5E35B1).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Giriş'),
          Tab(text: 'Teknikler'),
          Tab(text: 'Meditasyonlar'),
        ],
      ),
    );
  }

  Widget _buildIntroTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            title: 'Theta Durumu Nedir?',
            content:
                'Theta beyin dalgaları (4-7 Hz), derin meditasyon, rüya görme ve yaratıcılık anlarında aktif olur. Bu durumda bilinçaltına doğrudan erişim mümkündür ve köklü değişimler yapılabilir.',
            icon: '🌊',
            color: const Color(0xFF7C4DFF),
            isDark: isDark,
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoCard(
            title: 'Sınırlayıcı İnançlar',
            content:
                'Çocukluk döneminde oluşan ve farkında olmadan hayatımızı etkileyen inanç kalıpları vardır. Theta Healing ile bu inançları tespit edip dönüştürebilirsiniz.',
            icon: '🔓',
            color: const Color(0xFFE040FB),
            isDark: isDark,
          ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoCard(
            title: 'Enerji Dönüşümü',
            content:
                'Bedensel, zihinsel ve ruhsal seviyedeki enerji blokları çözülür. Şifalanma süreci hücresel düzeyde başlar ve tüm varlığınıza yayılır.',
            icon: '✨',
            color: const Color(0xFF00BCD4),
            isDark: isDark,
          ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoCard(
            title: '7 Düzlem Bağlantısı',
            content:
                'Theta Healing, evrenin 7 varoluş düzlemiyle çalışır: Mineraller, Bitkiler, Hayvanlar, İnsanlar, Ruhlar, Yasalar ve Yaratıcı Enerji.',
            icon: '🌌',
            color: const Color(0xFFFFD700),
            isDark: isDark,
          ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingXl),
          const PageFooterWithDisclaimer(
            brandText: 'Theta Healing — Venus One',
            disclaimerText: DisclaimerTexts.astrology,
          ),
        ],
      ),
    );
  }

  Widget _buildTechniquesTab(bool isDark) {
    final techniques = [
      _TechniqueTile(
        title: 'Kazı Tekniği (Digging)',
        description:
            'Sınırlayıcı inancın kök nedenini bulmak için bilinçaltına iner ve temel inancı keşfedersiniz.',
        steps: [
          'Güncel sorunu tespit edin',
          '"Bu inanç nereden geliyor?" sorusuyla derinleşin',
          'Çocukluk anılarına ve duygulara ulaşın',
          'Kök inancı bulduğunuzda dönüştürün',
        ],
        icon: '⛏️',
        color: const Color(0xFFFF7043),
      ),
      _TechniqueTile(
        title: 'İnanç Değiştirme',
        description:
            'Olumsuz bir inancı pozitif bir inançla değiştirme sürecidir.',
        steps: [
          'Sınırlayıcı inancı tanımlayın',
          'Yeni, güçlendirici bir inanç oluşturun',
          'Theta durumuna geçin',
          'Yaratıcıdan değişimi isteyin ve tanık olun',
        ],
        icon: '🔄',
        color: const Color(0xFF4CAF50),
      ),
      _TechniqueTile(
        title: 'Duygu Yükleme',
        description:
            'Hiç deneyimlemediğiniz pozitif duyguları hücresel düzeyde öğretme tekniği.',
        steps: [
          'Eksik duyguyu belirleyin (örn: güvende hissetmek)',
          'Yaratıcıya bağlanın',
          'Bu duyguyu bilmenin nasıl bir şey olduğunu sorun',
          'Duyguyu her hücrenize yükleyin',
        ],
        icon: '💜',
        color: const Color(0xFF9C27B0),
      ),
      _TechniqueTile(
        title: 'Bedensel Tarama',
        description:
            'Bedeninizdeki enerji bloklarını ve hastalık kaynaklarını tespit etme.',
        steps: [
          'Theta durumuna geçin',
          'Bedeni tepeden tırnağa tarayın',
          'Enerji yoğunluğu veya eksikliği olan bölgeleri not edin',
          'Yaratıcıdan şifa isteyin',
        ],
        icon: '🔍',
        color: const Color(0xFF2196F3),
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: techniques.length,
      itemBuilder: (context, index) {
        return _buildTechniqueCard(techniques[index], isDark)
            .animate(delay: (100 * index).ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.05);
      },
    );
  }

  Widget _buildMeditationsTab(bool isDark) {
    final meditations = [
      _MeditationTile(
        title: 'Theta Durumuna Geçiş',
        duration: '10 dk',
        description:
            'Theta beyin dalgası durumuna güvenli bir şekilde geçiş yapın.',
        icon: '🌊',
        color: const Color(0xFF7C4DFF),
      ),
      _MeditationTile(
        title: 'Yedinci Düzlem Bağlantısı',
        duration: '15 dk',
        description:
            'Yaratıcı enerjiye bağlanın ve koşulsuz sevgiyi deneyimleyin.',
        icon: '🌌',
        color: const Color(0xFFFFD700),
      ),
      _MeditationTile(
        title: 'İç Çocuk Şifası',
        duration: '20 dk',
        description:
            'Çocukluk travmalarını şefkatle iyileştirin ve iç çocuğunuzla barışın.',
        icon: '👶',
        color: const Color(0xFFFF6B9D),
      ),
      _MeditationTile(
        title: 'Ata Temizliği',
        duration: '25 dk',
        description:
            'Atalardan gelen karma kalıpları ve genetik inançları temizleyin.',
        icon: '🌳',
        color: const Color(0xFF4CAF50),
      ),
      _MeditationTile(
        title: 'Bolluk Manifestasyonu',
        duration: '15 dk',
        description: 'Bolluk bloklarını kaldırın ve bereket akışını açın.',
        icon: '💰',
        color: const Color(0xFF50C878),
      ),
      _MeditationTile(
        title: 'Ruh Eşi Çekimi',
        duration: '20 dk',
        description: 'İlişki engellerini temizleyin ve ruh eşinizi çekin.',
        icon: '💕',
        color: const Color(0xFFE91E63),
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: meditations.length,
      itemBuilder: (context, index) {
        return _buildMeditationCard(
          meditations[index],
          isDark,
        ).animate(delay: (80 * index).ms).fadeIn(duration: 400.ms);
      },
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required String icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: isDark ? 0.2 : 0.1),
            color.withValues(alpha: isDark ? 0.1 : 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechniqueCard(_TechniqueTile technique, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingSm,
        ),
        childrenPadding: const EdgeInsets.only(
          left: AppConstants.spacingLg,
          right: AppConstants.spacingLg,
          bottom: AppConstants.spacingLg,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: technique.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(technique.icon, style: const TextStyle(fontSize: 22)),
          ),
        ),
        title: Text(
          technique.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isDark ? Colors.white : AppColors.textDark,
          ),
        ),
        subtitle: Text(
          technique.description,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white60 : AppColors.textLight,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: technique.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adımlar',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: technique.color,
                  ),
                ),
                const SizedBox(height: 8),
                ...technique.steps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: technique.color.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: technique.color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: isDark ? Colors.white : AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(_MeditationTile meditation, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            meditation.color.withValues(alpha: isDark ? 0.15 : 0.08),
            meditation.color.withValues(alpha: isDark ? 0.08 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: meditation.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: meditation.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                meditation.icon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meditation.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: meditation.color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        meditation.duration,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: meditation.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  meditation.description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark ? Colors.white70 : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechniqueTile {
  final String title;
  final String description;
  final List<String> steps;
  final String icon;
  final Color color;

  _TechniqueTile({
    required this.title,
    required this.description,
    required this.steps,
    required this.icon,
    required this.color,
  });
}

class _MeditationTile {
  final String title;
  final String duration;
  final String description;
  final String icon;
  final Color color;

  _MeditationTile({
    required this.title,
    required this.duration,
    required this.description,
    required this.icon,
    required this.color,
  });
}
