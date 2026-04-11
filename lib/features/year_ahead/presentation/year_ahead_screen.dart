import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Year Ahead Forecast Screen
/// Comprehensive yearly forecast with quarterly breakdowns
class YearAheadScreen extends ConsumerStatefulWidget {
  const YearAheadScreen({super.key});

  @override
  ConsumerState<YearAheadScreen> createState() => _YearAheadScreenState();
}

class _YearAheadScreenState extends ConsumerState<YearAheadScreen> {
  late int _selectedYear;
  late YearAheadForecast _forecast;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
    _generateForecast();
  }

  void _generateForecast() {
    final userProfile = ref.read(userProfileProvider);
    final sign = userProfile?.sunSign ?? ZodiacSign.aries;
    _forecast = YearAheadService.generate(sign, _selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final sign = userProfile?.sunSign ?? ZodiacSign.aries;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, sign),
                const SizedBox(height: AppConstants.spacingXl),
                _buildYearOverview(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildQuarterlyBreakdown(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildKeyTransits(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildLuckyPeriods(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildChallengingPeriods(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildYearAffirmation(context),
                const SizedBox(height: AppConstants.spacingXxl),
                // Next Blocks
                const NextBlocks(currentPage: 'year_ahead'),
                const SizedBox(height: AppConstants.spacingXl),
                // Entertainment Disclaimer
                const PageFooterWithDisclaimer(
                  brandText: 'Yıl Öngörüsü — Venus One',
                  disclaimerText: DisclaimerTexts.astrology,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ZodiacSign sign) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_selectedYear Yılı Öngörüsü',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    sign.nameTr,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: sign.color),
                  ),
                  const SizedBox(width: 4),
                  Text(sign.symbol, style: TextStyle(color: sign.color)),
                ],
              ),
            ],
          ),
        ),
        // Year selector
        GestureDetector(
          onTap: () => _showYearPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.starGold.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.starGold.withAlpha(60)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_selectedYear',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: AppColors.starGold),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  void _showYearPicker(BuildContext context) {
    final currentYear = DateTime.now().year;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Yil Secin',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(3, (i) {
                final year = currentYear + i;
                final isSelected = year == _selectedYear;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedYear = year;
                      _generateForecast();
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.starGold
                          : AppColors.surfaceLight.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$year',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isSelected
                            ? AppColors.deepSpace
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildYearOverview(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.auroraStart.withAlpha(30), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.auroraStart.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.auroraStart.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.auroraStart,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Yil Ozeti',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _forecast.overview,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildScoreCard(
                  context,
                  'Kariyer',
                  _forecast.careerScore,
                  Icons.work,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScoreCard(
                  context,
                  'Ask',
                  _forecast.loveScore,
                  Icons.favorite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildScoreCard(
                  context,
                  'Finans',
                  _forecast.financeScore,
                  Icons.attach_money,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScoreCard(
                  context,
                  'Sağlık',
                  _forecast.healthScore,
                  Icons.favorite_border,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildScoreCard(
    BuildContext context,
    String label,
    int score,
    IconData icon,
  ) {
    final color = score >= 80
        ? Colors.green
        : score >= 60
        ? AppColors.starGold
        : score >= 40
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
                Text(
                  '$score%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterlyBreakdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_view_month,
              color: AppColors.twilightStart,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Ceyreklik Ongorular',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ..._forecast.quarters.asMap().entries.map((entry) {
          final index = entry.key;
          final quarter = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            child: _buildQuarterCard(context, quarter),
          ).animate().fadeIn(delay: (200 + index * 100).ms, duration: 400.ms);
        }),
      ],
    );
  }

  Widget _buildQuarterCard(BuildContext context, QuarterForecast quarter) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: quarter.color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: quarter.color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: quarter.color.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  quarter.name,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: quarter.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                quarter.dateRange,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
              const Spacer(),
              Text(quarter.emoji, style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            quarter.theme,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            quarter.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyTransits(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.public, color: AppColors.celestialGold, size: 20),
            const SizedBox(width: 8),
            Text(
              'Önemli Geçişler',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ..._forecast.keyTransits.map(
          (transit) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            child: Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight.withAlpha(30),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    transit.planetEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transit.title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                        Text(
                          transit.dateRange,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.starGold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transit.effect,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildLuckyPeriods(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              'Sansli Donemler',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _forecast.luckyPeriods.map((period) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.withAlpha(40)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    period,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.green),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }

  Widget _buildChallengingPeriods(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            Text(
              'Dikkat Edilmesi Gereken Donemler',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _forecast.challengingPeriods.map((period) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withAlpha(40)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.schedule, color: Colors.orange, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    period,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms, duration: 400.ms);
  }

  Widget _buildYearAffirmation(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.starGold.withAlpha(20),
            AppColors.auroraEnd.withAlpha(20),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withAlpha(40)),
      ),
      child: Column(
        children: [
          const Text('✨', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          Text(
            'Yil Affirmasyonu',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.starGold),
          ),
          const SizedBox(height: 8),
          Text(
            '"${_forecast.affirmation}"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 900.ms, duration: 400.ms);
  }
}

/// Year Ahead Service
class YearAheadService {
  static YearAheadForecast generate(ZodiacSign sign, int year) {
    final seed = sign.index * 1000 + year;
    final random = Random(seed);

    return YearAheadForecast(
      year: year,
      sign: sign,
      overview: _generateOverview(sign, year),
      careerScore: 50 + random.nextInt(45),
      loveScore: 50 + random.nextInt(45),
      financeScore: 50 + random.nextInt(45),
      healthScore: 50 + random.nextInt(45),
      quarters: _generateQuarters(sign, year, random),
      keyTransits: _generateTransits(sign, year),
      luckyPeriods: _generateLuckyPeriods(sign, year, random),
      challengingPeriods: _generateChallengingPeriods(year, random),
      affirmation: _generateAffirmation(sign),
    );
  }

  static String _generateOverview(ZodiacSign sign, int year) {
    final overviews = {
      ZodiacSign.aries:
          '$year sizin için cesaret ve yeni başlangıçlar yılı. Liderlik özellikleriniz ön plana çıkacak.',
      ZodiacSign.taurus:
          '$year finansal istikrar ve kişisel değerler üzerine odaklanacağınız bir yıl olacak.',
      ZodiacSign.gemini:
          '$year iletişim ve öğrenim için önemli fırsatlar getirecek. Sosyal çevreniz genişleyecek.',
      ZodiacSign.cancer:
          '$year ev, aile ve duygusal güvenlik temalarına odaklanacağınız bir dönem.',
      ZodiacSign.leo:
          '$year yaratıcı ifade ve kişisel parlaklık zamanı. Sahneye çıkmaktan korkmayın.',
      ZodiacSign.virgo:
          '$year detaylara odaklanma ve hizmet etme enerjisi taşıyor. Sağlık ve rutin önemli.',
      ZodiacSign.libra:
          '$year ilişkiler ve ortaklıklar için dönüşüm zamanı. Denge arayın.',
      ZodiacSign.scorpio:
          '$year derin dönüşümler ve yenilenme getiriyor. Eski kalıpları bırakın.',
      ZodiacSign.sagittarius:
          '$year macera, eğitim ve ufukları genişletme yılı. Özgürlük ön planda.',
      ZodiacSign.capricorn:
          '$year kariyer zirvesi ve toplumsal başarı için uygun. Hedeflerinize odaklanın.',
      ZodiacSign.aquarius:
          '$year yenilikçi fikirler ve toplumsal bağlantı için güçlü enerji taşıyor.',
      ZodiacSign.pisces:
          '$year ruhsal gelişim ve yaratıcı ilham için zengin bir dönem olacak.',
    };
    return overviews[sign] ??
        '$year sizin için önemli fırsatlar ve gelişim getiriyor.';
  }

  static List<QuarterForecast> _generateQuarters(
    ZodiacSign sign,
    int year,
    Random random,
  ) {
    final themes = [
      ['Başlangıçlar', 'Enerji', 'Yenilik', 'Cesaret'],
      ['Büyüme', 'İstikrar', 'Uygulama', 'Toplama'],
      ['Hasat', 'Denge', 'İlişkiler', 'Değerlendirme'],
      ['Tamamlama', 'Planlama', 'Yansıma', 'Hazırlık'],
    ];

    final colors = [
      AppColors.fireElement,
      AppColors.earthElement,
      AppColors.airElement,
      AppColors.waterElement,
    ];

    final emojis = ['🌱', '☀️', '🍂', '❄️'];

    return List.generate(4, (i) {
      final q = i + 1;
      final startMonth = i * 3 + 1;
      final endMonth = startMonth + 2;
      final themeIndex = random.nextInt(themes[i].length);

      return QuarterForecast(
        quarter: q,
        name: '$q. Ceyrek',
        dateRange: '${_getMonthName(startMonth)} - ${_getMonthName(endMonth)}',
        theme: themes[i][themeIndex],
        description: _getQuarterDescription(sign, q, themes[i][themeIndex]),
        color: colors[i],
        emoji: emojis[i],
      );
    });
  }

  static String _getMonthName(int month) {
    const months = [
      'Ocak',
      'Subat',
      'Mart',
      'Nisan',
      'Mayis',
      'Haziran',
      'Temmuz',
      'Agustos',
      'Eylul',
      'Ekim',
      'Kasim',
      'Aralik',
    ];
    return months[month - 1];
  }

  static String _getQuarterDescription(
    ZodiacSign sign,
    int quarter,
    String theme,
  ) {
    final descriptions = {
      1: 'Yılın başlangıcı $theme enerjisi ile geliyor. ${sign.nameTr} burcu olarak bu dönemde aktif olacaksınız.',
      2: 'İlkbahar ve yaz arasında $theme ön plana çıkıyor. Projelerinizi somutlaştırma zamanı.',
      3: 'Sonbahar mevsimi $theme ile ilgili konuları öne çıkarıyor. Dengeleme önemli.',
      4: 'Yılın son çeyreği $theme üzerine düşünme ve gelecek yılı planlama zamanı.',
    };
    return descriptions[quarter] ??
        'Bu çeyrek $theme üzerine odaklanmanızı gerektiriyor.';
  }

  static List<TransitInfo> _generateTransits(ZodiacSign sign, int year) {
    return [
      TransitInfo(
        planetEmoji: '♃',
        title: 'Jupiter Transiti',
        dateRange: 'Yil boyunca',
        effect:
            'Genislemeve sans getiren enerji. ${sign.nameTr} icin firsatlar bolgesinde.',
      ),
      TransitInfo(
        planetEmoji: '♄',
        title: 'Saturn Transiti',
        dateRange: 'Yil boyunca',
        effect: 'Sorumluluk ve yapilandirma zamani. Sabir gerektiren donem.',
      ),
      TransitInfo(
        planetEmoji: '☿',
        title: 'Merkur Retrolari',
        dateRange: '3-4 kez/yil',
        effect:
            'Iletisim ve teknolojide dikkat. Eski konulari tamamlama firsati.',
      ),
    ];
  }

  static List<String> _generateLuckyPeriods(
    ZodiacSign sign,
    int year,
    Random random,
  ) {
    final months = [
      'Ocak',
      'Subat',
      'Mart',
      'Nisan',
      'Mayis',
      'Haziran',
      'Temmuz',
      'Agustos',
      'Eylul',
      'Ekim',
      'Kasim',
      'Aralik',
    ];
    final luckyMonths = <String>[];

    for (int i = 0; i < 12; i++) {
      if (random.nextDouble() > 0.6) {
        luckyMonths.add(months[i]);
      }
    }

    return luckyMonths.isEmpty ? ['Mart', 'Haziran', 'Ekim'] : luckyMonths;
  }

  static List<String> _generateChallengingPeriods(int year, Random random) {
    // Mercury retrograde periods
    return [
      'Merkur Retrosu (Nisan)',
      'Merkur Retrosu (Agustos)',
      'Merkur Retrosu (Aralik)',
    ];
  }

  static String _generateAffirmation(ZodiacSign sign) {
    final affirmations = {
      ZodiacSign.aries: 'Cesaretle ilerliyorum, yeni başlangıçlara hazırım.',
      ZodiacSign.taurus: 'Bolluk ve bereket hayatıma akıyor.',
      ZodiacSign.gemini: 'Her gün yeni şeyler öğreniyor ve büyüyorum.',
      ZodiacSign.cancer: 'Duygusal güvenliğim ve huzurum sağlamdır.',
      ZodiacSign.leo: 'Işığımı parlatıyor ve dünyayla paylaşıyorum.',
      ZodiacSign.virgo: 'Mükemmellik yerine ilerlemeyi seçiyorum.',
      ZodiacSign.libra: 'Hayatımda denge ve uyum yaratıyorum.',
      ZodiacSign.scorpio: 'Dönüşümü kucaklıyor, yeniden doğuyorum.',
      ZodiacSign.sagittarius: 'Özgürce keşfediyor ve büyüyorum.',
      ZodiacSign.capricorn: 'Hedeflerime kararlılıkla ilerliyorum.',
      ZodiacSign.aquarius: 'Benzersizliğimi kutluyor, farkı yaratıyorum.',
      ZodiacSign.pisces: 'Sezgilerime güveniyorum, evrenle akıyorum.',
    };
    return affirmations[sign] ?? 'Her gün daha iyi bir versiyonum oluyorum.';
  }
}

/// Data classes
class YearAheadForecast {
  final int year;
  final ZodiacSign sign;
  final String overview;
  final int careerScore;
  final int loveScore;
  final int financeScore;
  final int healthScore;
  final List<QuarterForecast> quarters;
  final List<TransitInfo> keyTransits;
  final List<String> luckyPeriods;
  final List<String> challengingPeriods;
  final String affirmation;

  YearAheadForecast({
    required this.year,
    required this.sign,
    required this.overview,
    required this.careerScore,
    required this.loveScore,
    required this.financeScore,
    required this.healthScore,
    required this.quarters,
    required this.keyTransits,
    required this.luckyPeriods,
    required this.challengingPeriods,
    required this.affirmation,
  });
}

class QuarterForecast {
  final int quarter;
  final String name;
  final String dateRange;
  final String theme;
  final String description;
  final Color color;
  final String emoji;

  QuarterForecast({
    required this.quarter,
    required this.name,
    required this.dateRange,
    required this.theme,
    required this.description,
    required this.color,
    required this.emoji,
  });
}

class TransitInfo {
  final String planetEmoji;
  final String title;
  final String dateRange;
  final String effect;

  TransitInfo({
    required this.planetEmoji,
    required this.title,
    required this.dateRange,
    required this.effect,
  });
}
