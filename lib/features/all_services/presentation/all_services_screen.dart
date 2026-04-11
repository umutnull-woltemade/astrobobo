import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';

/// Tüm Çözümlemeler - Minimal & Estetik katalog sayfası
class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Subtle animated background
          _buildBackground(isDark),

          // Content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // Beautiful header
                SliverToBoxAdapter(child: _buildHeader(context, isDark)),

                // Categories list
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final category = _categories[index];
                      return _buildCategorySection(
                        context,
                        category['name'] as String,
                        category['icon'] as String,
                        category['color'] as Color,
                        (category['services'] as List<Map<String, dynamic>>),
                        isDark,
                        index,
                      );
                    }, childCount: _categories.length),
                  ),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(bool isDark) {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      const Color(0xFF0D0D1A),
                      Color.lerp(
                        const Color(0xFF1A0A2E),
                        const Color(0xFF150820),
                        _bgController.value,
                      )!,
                      const Color(0xFF0D0D1A),
                    ]
                  : [
                      const Color(0xFFFAF8FF),
                      const Color(0xFFF5F0FF),
                      const Color(0xFFFAF8FF),
                    ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        children: [
          // Back button row
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white70 : AppColors.textDark,
                  size: 20,
                ),
              ),
              const Spacer(),
            ],
          ),

          const SizedBox(height: 20),

          // Title with aesthetic design
          Column(
            children: [
              // Decorative line
              Container(
                width: 40,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.starGold.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Main title
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    const Color(0xFFE8D5B7),
                    AppColors.starGold,
                    const Color(0xFFE8D5B7),
                  ],
                ).createShader(bounds),
                child: Text(
                  'Tüm Çözümlemeler',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontFamily: 'serif',
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                '✦ kozmik araçlar ✦',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 4,
                  color: isDark
                      ? Colors.white38
                      : AppColors.textLight.withOpacity(0.6),
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 16),

              // Decorative line
              Container(
                width: 40,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.starGold.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    String icon,
    Color color,
    List<Map<String, dynamic>> services,
    bool isDark,
    int categoryIndex,
  ) {
    return Container(
          margin: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header - minimal
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(icon, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: color,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Services - text only, wrapped
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: services.asMap().entries.map((entry) {
                  final service = entry.value;
                  return _buildServiceChip(
                    context,
                    service['name'] as String,
                    service['route'] as String,
                    color,
                    isDark,
                  );
                }).toList(),
              ),
            ],
          ),
        )
        .animate(delay: (80 * categoryIndex).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.02);
  }

  Widget _buildServiceChip(
    BuildContext context,
    String name,
    String route,
    Color categoryColor,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.04)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : categoryColor.withOpacity(0.15),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white70 : AppColors.textDark,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  // CATEGORIES DATA - Simplified
  // ════════════════════════════════════════════════════════════════

  static final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Burç Yorumları',
      'icon': '⭐',
      'color': AppColors.starGold,
      'services': [
        {'name': 'Günlük', 'route': Routes.horoscope},
        {'name': 'Haftalık', 'route': Routes.weeklyHoroscope},
        {'name': 'Aylık', 'route': Routes.monthlyHoroscope},
        {'name': 'Yıllık', 'route': Routes.yearlyHoroscope},
        {'name': 'Aşk', 'route': Routes.loveHoroscope},
        {'name': 'Uyum', 'route': Routes.compatibility},
      ],
    },
    {
      'name': 'Harita Analizleri',
      'icon': '🗺️',
      'color': AppColors.cosmicPurple,
      'services': [
        {'name': 'Doğum Haritası', 'route': Routes.birthChart},
        {'name': 'Sinastri', 'route': Routes.synastry},
        {'name': 'Kompozit', 'route': Routes.compositeChart},
        {'name': 'Vedik', 'route': Routes.vedicChart},
        {'name': 'Drakonik', 'route': Routes.draconicChart},
        {'name': 'Asteroidler', 'route': Routes.asteroids},
        {'name': 'Lokal Uzay', 'route': Routes.localSpace},
      ],
    },
    {
      'name': 'Zamanlama',
      'icon': '⏰',
      'color': AppColors.auroraEnd,
      'services': [
        {'name': 'Transitler', 'route': Routes.transits},
        {'name': 'Progresyonlar', 'route': Routes.progressions},
        {'name': 'Saturn Dönüşü', 'route': Routes.saturnReturn},
        {'name': 'Solar Return', 'route': Routes.solarReturn},
        {'name': 'Yıl Önizleme', 'route': Routes.yearAhead},
        {'name': 'Zamanlama', 'route': Routes.timing},
        {'name': 'Void of Course', 'route': Routes.voidOfCourse},
        {'name': 'Tutulmalar', 'route': Routes.eclipseCalendar},
      ],
    },
    {
      'name': 'Numeroloji',
      'icon': '🔢',
      'color': AppColors.fireElement,
      'services': [
        {'name': 'Genel Analiz', 'route': Routes.numerology},
        {'name': 'Yaşam Yolu', 'route': Routes.lifePath1},
        {'name': 'Master Sayılar', 'route': Routes.master11},
        {'name': 'Kişisel Yıl', 'route': Routes.personalYear1},
        {'name': 'Karmik Borç', 'route': Routes.karmicDebt},
      ],
    },
    {
      'name': 'Ruhsal Pratikler',
      'icon': '🧘',
      'color': AppColors.tantraCrimson,
      'services': [
        {'name': 'Tantra', 'route': Routes.tantra},
        {'name': 'Chakra', 'route': Routes.chakraAnalysis},
        {'name': 'Aura', 'route': Routes.aura},
        {'name': 'Kabala', 'route': Routes.kabbalah},
        {'name': 'Günlük Ritüel', 'route': Routes.dailyRituals},
        {'name': 'Ay Ritüelleri', 'route': Routes.moonRituals},
        {'name': 'Kristaller', 'route': Routes.crystalGuide},
      ],
    },
    {
      'name': 'Tarot',
      'icon': '🃏',
      'color': AppColors.mystic,
      'services': [
        {'name': 'Tarot Falı', 'route': Routes.tarot},
        {
          'name': 'Major Arcana',
          'route': Routes.majorArcanaDetail.replaceAll(':number', '0'),
        },
      ],
    },
    {
      'name': 'Rüya',
      'icon': '💭',
      'color': AppColors.waterElement,
      'services': [
        {'name': 'Rüya İzi', 'route': Routes.dreamInterpretation},
        {'name': 'Sözlük', 'route': Routes.dreamGlossary},
        {'name': 'Paylaş', 'route': Routes.dreamShare},
        {'name': 'Kozmik Sohbet', 'route': Routes.kozmikIletisim},
        {'name': 'Rüya Döngüsü', 'route': Routes.ruyaDongusu},
      ],
    },
    {
      'name': 'İlişki',
      'icon': '💑',
      'color': const Color(0xFFE91E63),
      'services': [
        {'name': 'Uyum Analizi', 'route': Routes.compatibility},
        {'name': 'Ruh Eşin', 'route': Routes.soulMate},
        {'name': 'İlişki Karması', 'route': Routes.relationshipKarma},
        {'name': 'Ünlü İkizin', 'route': Routes.celebrityTwin},
      ],
    },
    {
      'name': 'Kozmik Keşif',
      'icon': '🔭',
      'color': AppColors.cosmic,
      'services': [
        {'name': 'Günün Özeti', 'route': Routes.dailySummary},
        {'name': 'Ay Enerjisi', 'route': Routes.moonEnergy},
        {'name': 'Aşk Enerjisi', 'route': Routes.loveEnergy},
        {'name': 'Bolluk', 'route': Routes.abundanceEnergy},
        {'name': 'Ruhsal Dönüşüm', 'route': Routes.spiritualTransformation},
        {'name': 'Hayat Amacın', 'route': Routes.lifePurpose},
        {'name': 'Gölge Benlik', 'route': Routes.shadowSelf},
        {'name': 'Kalp Yaran', 'route': Routes.heartbreak},
        {'name': 'Red Flags', 'route': Routes.redFlags},
        {'name': 'Green Flags', 'route': Routes.greenFlags},
        {'name': 'Flört Stilin', 'route': Routes.flirtStyle},
        {'name': 'Liderlik', 'route': Routes.leadershipStyle},
        {'name': 'Karma Dersleri', 'route': Routes.karmaLessons},
        {'name': 'Ruh Sözleşmen', 'route': Routes.soulContract},
        {'name': 'İçsel Gücün', 'route': Routes.innerPower},
        {'name': 'Tarot Kartın', 'route': Routes.tarotCard},
        {'name': 'Aura Rengin', 'route': Routes.auraColor},
        {'name': 'Chakra Dengen', 'route': Routes.chakraBalance},
        {'name': 'Yaşam Sayın', 'route': Routes.lifeNumber},
        {'name': 'Kabala Yolun', 'route': Routes.kabbalaPath},
        {'name': 'Saturn Dersleri', 'route': Routes.saturnLessons},
        {'name': 'Doğum Günü', 'route': Routes.birthdayEnergy},
        {'name': 'Tutulma Etkisi', 'route': Routes.eclipseEffect},
        {'name': 'Transit Akışı', 'route': Routes.transitFlow},
      ],
    },
    {
      'name': 'Referans',
      'icon': '📚',
      'color': AppColors.earthElement,
      'services': [
        {'name': 'Sözlük', 'route': Routes.glossary},
        {'name': 'Ünlüler', 'route': Routes.celebrities},
        {'name': 'Kozmoz İzi', 'route': Routes.kozmoz},
      ],
    },
  ];
}
