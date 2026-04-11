import 'dart:math' show Random, pi, sin;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/moon_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

class TimingScreen extends ConsumerStatefulWidget {
  const TimingScreen({super.key});

  @override
  ConsumerState<TimingScreen> createState() => _TimingScreenState();
}

class _TimingScreenState extends ConsumerState<TimingScreen> {
  TimingCategory _selectedCategory = TimingCategory.all;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final sign = userProfile?.sunSign ?? ZodiacSign.aries;
    final birthDate = userProfile?.birthDate ?? DateTime(1990, 1, 1);

    final recommendations = TimingService.getRecommendations(
      sunSign: sign,
      birthDate: birthDate,
      category: _selectedCategory,
    );

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              _buildCategorySelector(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  children: [
                    _buildTodayOverview(context),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildCurrentConditions(context),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildRecommendations(context, recommendations),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildUpcoming7Days(context, sign),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildPlanetaryHours(context),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildLuckyElements(context, sign, birthDate),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildBiorhythm(context, birthDate),
                    const SizedBox(height: AppConstants.spacingXl),
                    _buildDailyAspects(context),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Kadim Not
                    KadimNotCard(
                      category: KadimCategory.astrology,
                      title: 'Elektional Astroloji',
                      content:
                          'Kadim astrologlar, her anın eşsiz bir kozmik imzası olduğunu bilirdi. '
                          'Elektional astroloji - doğru zamanı seçme sanatı - krallıkların taç giyme '
                          'törenlerinden evliliklere kadar her önemli olay için kullanılırdı. '
                          'Gezegen saatleri ve Ay\'ın boş seyir dönemleri, başarılı eylemlerin anahtarıydı.',
                      icon: Icons.access_time,
                    ),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Next Blocks
                    const NextBlocks(currentPage: 'timing'),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Entertainment Disclaimer
                    const PageFooterWithDisclaimer(
                      brandText: 'Zamanlama — Venus One',
                      disclaimerText: DisclaimerTexts.astrology,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kişisel Zamanlama',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Yıldızlara göre en iyi zamanlar',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.celestialGold.withAlpha(40),
                  AppColors.starGold.withAlpha(20),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time,
              color: AppColors.celestialGold,
              size: 24,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
        itemCount: TimingCategory.values.length,
        itemBuilder: (context, index) {
          final category = TimingCategory.values[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            category.color.withAlpha(60),
                            category.color.withAlpha(30),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : AppColors.surfaceLight.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? category.color : Colors.white12,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 16,
                      color: isSelected
                          ? category.color
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.nameTr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? category.color
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildTodayOverview(BuildContext context) {
    final moonPhase = MoonService.getCurrentPhase();
    final moonSign = MoonService.getCurrentMoonSign();
    final vocStatus = VoidOfCourseMoonExtension.getVoidOfCourseStatus();
    final retrogrades = MoonService.getRetrogradePlanets();

    // Calculate overall score
    int score = 70;
    if (vocStatus.isVoid) score -= 20;
    if (retrogrades.contains('mercury')) score -= 10;
    if (moonPhase.name.contains('full') || moonPhase.name.contains('new'))
      score += 10;
    score = score.clamp(0, 100);

    final Color scoreColor = score >= 70
        ? Colors.green
        : score >= 50
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.celestialGold.withAlpha(30),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.celestialGold.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      scoreColor.withAlpha(100),
                      scoreColor.withAlpha(30),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '$score',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bugünün Enerjisi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getOverallMessage(score),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MiniIndicator(
                  icon: Icons.nightlight_round,
                  label: moonPhase.nameTr,
                  value: moonSign.nameTr,
                ),
                Container(width: 1, height: 40, color: Colors.white12),
                GestureDetector(
                  onTap: () => context.push('/void-of-course'),
                  child: _MiniIndicator(
                    icon: vocStatus.isVoid
                        ? Icons.do_not_disturb
                        : Icons.check_circle,
                    label: 'VOC',
                    value: vocStatus.isVoid ? 'Aktif' : 'Yok',
                    color: vocStatus.isVoid ? Colors.purple : Colors.green,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white12),
                _MiniIndicator(
                  icon: Icons.replay,
                  label: 'Retro',
                  value: retrogrades.isEmpty ? 'Yok' : '${retrogrades.length}',
                  color: retrogrades.isEmpty ? Colors.green : Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  String _getOverallMessage(int score) {
    if (score >= 80) return 'Mükemmel bir gün! Önemli işler için ideal.';
    if (score >= 60) return 'İyi bir gün. Dikkatli ilerleyebilirsin.';
    if (score >= 40) return 'Orta seviye enerji. Rutinlere odaklan.';
    return 'Zorlayıcı bir gün. Dinlenmeyi tercih et.';
  }

  Widget _buildCurrentConditions(BuildContext context) {
    final vocStatus = VoidOfCourseMoonExtension.getVoidOfCourseStatus();
    final retrogrades = MoonService.getRetrogradePlanets();

    final conditions = <_ConditionItem>[];

    // VOC Warning
    if (vocStatus.isVoid) {
      conditions.add(
        _ConditionItem(
          icon: Icons.do_not_disturb_on,
          title: 'Ay Boş Seyir',
          description:
              'Önemli başlangıçları erteleyin. ${vocStatus.timeRemainingFormatted ?? "Bitiş zamanı yaklaşıyor"}',
          color: Colors.purple,
          severity: 2,
        ),
      );
    }

    // Mercury Retrograde
    if (retrogrades.contains('mercury')) {
      conditions.add(
        _ConditionItem(
          icon: Icons.chat_bubble_outline,
          title: 'Merkür Retrosu',
          description:
              'İletişim ve sözleşmelerde dikkatli olun. Eski bağlantılar dönebilir.',
          color: Colors.orange,
          severity: 2,
        ),
      );
    }

    // Other Retrogrades
    final otherRetros = retrogrades.where((p) => p != 'mercury').toList();
    if (otherRetros.isNotEmpty) {
      conditions.add(
        _ConditionItem(
          icon: Icons.replay,
          title: 'Diğer Retrolar',
          description:
              '${otherRetros.map((p) => _getPlanetNameTr(p)).join(", ")} retroda. İlgili alanlarda yavaşlık.',
          color: Colors.amber,
          severity: 1,
        ),
      );
    }

    if (conditions.isEmpty) {
      conditions.add(
        _ConditionItem(
          icon: Icons.check_circle_outline,
          title: 'Temiz Gökyüzü',
          description: 'Önemli bir uyarı bulunmuyor. Harika bir gün!',
          color: Colors.green,
          severity: 0,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Güncel Koşullar',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ...conditions.map(
          (condition) => _buildConditionCard(context, condition),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildConditionCard(BuildContext context, _ConditionItem condition) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: condition.color.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: condition.color.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: condition.color.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Icon(condition.icon, color: condition.color, size: 18),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  condition.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: condition.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  condition.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(
    BuildContext context,
    List<TimingRecommendation> recommendations,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: AppColors.celestialGold,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'İyi Zamanlar',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ...recommendations.asMap().entries.map((entry) {
          final index = entry.key;
          final rec = entry.value;
          return _buildRecommendationCard(context, rec, index);
        }),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    TimingRecommendation rec,
    int index,
  ) {
    final Color ratingColor = rec.rating >= 4
        ? Colors.green
        : rec.rating >= 3
        ? Colors.amber
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [rec.category.color.withAlpha(25), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: rec.category.color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: rec.category.color.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  rec.category.icon,
                  color: rec.category.color,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rec.activity,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      rec.category.nameTr,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: rec.category.color,
                      ),
                    ),
                  ],
                ),
              ),
              // Rating stars
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < rec.rating ? Icons.star : Icons.star_border,
                    size: 14,
                    color: ratingColor,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            rec.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 12,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rec.bestTime,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (rec.tip.isNotEmpty)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.celestialGold.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.tips_and_updates,
                          size: 12,
                          color: AppColors.celestialGold,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            rec.tip,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: AppColors.celestialGold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (500 + index * 100).ms, duration: 400.ms);
  }

  Widget _buildUpcoming7Days(BuildContext context, ZodiacSign sign) {
    final days = TimingService.get7DayForecast(sign);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: AppColors.moonSilver,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Önümüzdeki 7 Gün',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final isToday = index == 0;

              return Container(
                width: 70,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                decoration: BoxDecoration(
                  gradient: isToday
                      ? LinearGradient(
                          colors: [
                            AppColors.celestialGold.withAlpha(40),
                            AppColors.starGold.withAlpha(20),
                          ],
                        )
                      : null,
                  color: isToday ? null : AppColors.surfaceLight.withAlpha(20),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  border: Border.all(
                    color: isToday ? AppColors.celestialGold : Colors.white12,
                    width: isToday ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.dayName,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isToday
                            ? AppColors.celestialGold
                            : AppColors.textMuted,
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: day.color.withAlpha(40),
                      ),
                      child: Center(
                        child: Text(
                          '${day.score}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: day.color,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.moonSign.symbol,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ).animate().fadeIn(
                delay: (600 + index * 50).ms,
                duration: 300.ms,
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  String _getPlanetNameTr(String planet) {
    switch (planet.toLowerCase()) {
      case 'mercury':
        return 'Merkür';
      case 'venus':
        return 'Venüs';
      case 'mars':
        return 'Mars';
      case 'jupiter':
        return 'Jüpiter';
      case 'saturn':
        return 'Satürn';
      case 'uranus':
        return 'Uranüs';
      case 'neptune':
        return 'Neptün';
      case 'pluto':
        return 'Plüton';
      default:
        return planet;
    }
  }

  Widget _buildPlanetaryHours(BuildContext context) {
    final planetaryHours = TimingService.getPlanetaryHours();
    final currentHour = DateTime.now().hour;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.schedule, color: AppColors.auroraStart, size: 20),
            const SizedBox(width: 8),
            Text(
              'Gezegen Saatleri',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.auroraStart.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Simdi: ${planetaryHours[currentHour % planetaryHours.length].planetTr}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.auroraStart,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withAlpha(20),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            children: [
              // Current planetary hour highlight
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      planetaryHours[currentHour % planetaryHours.length].color
                          .withAlpha(40),
                      AppColors.surfaceDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                  border: Border.all(
                    color: planetaryHours[currentHour % planetaryHours.length]
                        .color
                        .withAlpha(60),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      planetaryHours[currentHour % planetaryHours.length]
                          .symbol,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: AppConstants.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${planetaryHours[currentHour % planetaryHours.length].planetTr} Saati',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color:
                                      planetaryHours[currentHour %
                                              planetaryHours.length]
                                          .color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            planetaryHours[currentHour % planetaryHours.length]
                                .meaning,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Upcoming hours grid
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final hourIndex =
                        (currentHour + index + 1) % planetaryHours.length;
                    final hour = planetaryHours[hourIndex];
                    final displayHour = (currentHour + index + 1) % 24;

                    return Container(
                      width: 65,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: hour.color.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: hour.color.withAlpha(40)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hour.symbol,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${displayHour.toString().padLeft(2, '0')}:00',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                          Text(
                            hour.planetTr,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: hour.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildLuckyElements(
    BuildContext context,
    ZodiacSign sign,
    DateTime birthDate,
  ) {
    final lucky = TimingService.getLuckyElements(sign, birthDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.auto_awesome, color: AppColors.starGold, size: 20),
            const SizedBox(width: 8),
            Text(
              'Bugünün Şans Elemanları',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.starGold.withAlpha(20), AppColors.surfaceDark],
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(color: AppColors.starGold.withAlpha(40)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.tag,
                      label: 'Şans Sayıları',
                      value: lucky.numbers.join(', '),
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.color_lens,
                      label: 'Şans Rengi',
                      value: lucky.colorTr,
                      color: lucky.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.explore,
                      label: 'Şans Yönü',
                      value: lucky.direction,
                      color: Colors.cyan,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.access_time,
                      label: 'Şans Saati',
                      value: lucky.time,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.local_florist,
                      label: 'Şans Çiçeği',
                      value: lucky.flower,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _LuckyCard(
                      icon: Icons.diamond,
                      label: 'Şans Taşı',
                      value: lucky.gemstone,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }

  Widget _buildBiorhythm(BuildContext context, DateTime birthDate) {
    final biorhythm = TimingService.getBiorhythm(birthDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.waves, color: Colors.cyan, size: 20),
            const SizedBox(width: 8),
            Text(
              'Biyoritim Döngüsü',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withAlpha(20),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            children: [
              _BiorhythmBar(
                label: 'Fiziksel',
                value: biorhythm.physical,
                color: Colors.red,
                icon: Icons.fitness_center,
              ),
              const SizedBox(height: 16),
              _BiorhythmBar(
                label: 'Duygusal',
                value: biorhythm.emotional,
                color: Colors.pink,
                icon: Icons.favorite,
              ),
              const SizedBox(height: 16),
              _BiorhythmBar(
                label: 'Zihinsel',
                value: biorhythm.intellectual,
                color: Colors.blue,
                icon: Icons.psychology,
              ),
              const SizedBox(height: 16),
              _BiorhythmBar(
                label: 'Sezgisel',
                value: biorhythm.intuitive,
                color: Colors.purple,
                icon: Icons.visibility,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        biorhythm.summary,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms, duration: 400.ms);
  }

  Widget _buildDailyAspects(BuildContext context) {
    final aspects = TimingService.getDailyAspects();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.blur_circular, color: AppColors.mystic, size: 20),
            const SizedBox(width: 8),
            Text(
              'Günün Önemli Açıları',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ...aspects.map(
          (aspect) => Container(
            margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [aspect.color.withAlpha(30), AppColors.surfaceDark],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(color: aspect.color.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: aspect.color.withAlpha(40),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        aspect.time,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: aspect.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      aspect.planets,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: aspect.isHarmonious
                            ? Colors.green.withAlpha(40)
                            : Colors.orange.withAlpha(40),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        aspect.aspectName,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: aspect.isHarmonious
                              ? Colors.green
                              : Colors.orange,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  aspect.interpretation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 900.ms, duration: 400.ms);
  }
}

// Helper Widgets
class _MiniIndicator extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _MiniIndicator({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color ?? AppColors.moonSilver),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.textMuted,
            fontSize: 9,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ConditionItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int severity;

  const _ConditionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.severity,
  });
}

class _LuckyCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _LuckyCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _BiorhythmBar extends StatelessWidget {
  final String label;
  final double value; // -1 to 1
  final Color color;
  final IconData icon;

  const _BiorhythmBar({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = ((value + 1) / 2 * 100).round();

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (value + 1) / 2,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withAlpha(150), color],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: Text(
            '$percentage%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// Enums and Models
enum TimingCategory {
  all('Tümü', Icons.apps, AppColors.textPrimary),
  love('Aşk', Icons.favorite, Colors.pink),
  career('Kariyer', Icons.work, Colors.blue),
  money('Para', Icons.attach_money, Colors.green),
  health('Sağlık', Icons.health_and_safety, Colors.red),
  travel('Seyahat', Icons.flight, Colors.cyan),
  creative('Yaratıcılık', Icons.palette, Colors.purple);

  final String nameTr;
  final IconData icon;
  final Color color;

  const TimingCategory(this.nameTr, this.icon, this.color);
}

class TimingRecommendation {
  final TimingCategory category;
  final String activity;
  final String description;
  final int rating;
  final String bestTime;
  final String tip;

  const TimingRecommendation({
    required this.category,
    required this.activity,
    required this.description,
    required this.rating,
    required this.bestTime,
    this.tip = '',
  });
}

class DayForecast {
  final String dayName;
  final int score;
  final Color color;
  final MoonSign moonSign;

  const DayForecast({
    required this.dayName,
    required this.score,
    required this.color,
    required this.moonSign,
  });
}

class PlanetaryHour {
  final String planet;
  final String planetTr;
  final String symbol;
  final Color color;
  final String meaning;

  const PlanetaryHour({
    required this.planet,
    required this.planetTr,
    required this.symbol,
    required this.color,
    required this.meaning,
  });
}

class LuckyElements {
  final List<int> numbers;
  final Color color;
  final String colorTr;
  final String direction;
  final String time;
  final String flower;
  final String gemstone;

  const LuckyElements({
    required this.numbers,
    required this.color,
    required this.colorTr,
    required this.direction,
    required this.time,
    required this.flower,
    required this.gemstone,
  });
}

class Biorhythm {
  final double physical;
  final double emotional;
  final double intellectual;
  final double intuitive;
  final String summary;

  const Biorhythm({
    required this.physical,
    required this.emotional,
    required this.intellectual,
    required this.intuitive,
    required this.summary,
  });
}

class DailyAspect {
  final String time;
  final String planets;
  final String aspectName;
  final bool isHarmonious;
  final String interpretation;
  final Color color;

  const DailyAspect({
    required this.time,
    required this.planets,
    required this.aspectName,
    required this.isHarmonious,
    required this.interpretation,
    required this.color,
  });
}

// Service
class TimingService {
  static List<TimingRecommendation> getRecommendations({
    required ZodiacSign sunSign,
    required DateTime birthDate,
    required TimingCategory category,
  }) {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day + sunSign.index;
    final random = Random(seed);

    final moonSign = MoonService.getCurrentMoonSign();
    final vocStatus = VoidOfCourseMoonExtension.getVoidOfCourseStatus();
    final retrogrades = MoonService.getRetrogradePlanets();

    final allRecommendations = <TimingRecommendation>[];

    // Love recommendations
    if (category == TimingCategory.all || category == TimingCategory.love) {
      int loveRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.libra || moonSign == MoonSign.taurus)
        loveRating++;
      if (vocStatus.isVoid) loveRating--;
      if (retrogrades.contains('venus')) loveRating--;
      loveRating = loveRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.love,
          activity: 'Romantik Anlaşma',
          description: _getLoveDescription(
            moonSign,
            vocStatus.isVoid,
            retrogrades,
          ),
          rating: loveRating,
          bestTime: _getBestLoveTime(moonSign),
          tip: loveRating >= 4 ? 'Duygularını ifade et' : 'Sabırla bekle',
        ),
      );
    }

    // Career recommendations
    if (category == TimingCategory.all || category == TimingCategory.career) {
      int careerRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.capricorn || moonSign == MoonSign.virgo)
        careerRating++;
      if (vocStatus.isVoid) careerRating -= 2;
      if (retrogrades.contains('mercury')) careerRating--;
      careerRating = careerRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.career,
          activity: 'İş Görüşmeleri',
          description: _getCareerDescription(
            moonSign,
            vocStatus.isVoid,
            retrogrades,
          ),
          rating: careerRating,
          bestTime: _getBestCareerTime(moonSign),
          tip: careerRating >= 4 ? 'İnisiyatif al' : 'Araştırma yap',
        ),
      );
    }

    // Money recommendations
    if (category == TimingCategory.all || category == TimingCategory.money) {
      int moneyRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.taurus || moonSign == MoonSign.scorpio)
        moneyRating++;
      if (vocStatus.isVoid) moneyRating--;
      moneyRating = moneyRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.money,
          activity: 'Finansal Kararlar',
          description: _getMoneyDescription(moonSign, vocStatus.isVoid),
          rating: moneyRating,
          bestTime: _getBestMoneyTime(moonSign),
          tip: moneyRating >= 4 ? 'Yatırım zamanı' : 'Biriktir',
        ),
      );
    }

    // Health recommendations
    if (category == TimingCategory.all || category == TimingCategory.health) {
      int healthRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.virgo || moonSign == MoonSign.pisces)
        healthRating++;
      healthRating = healthRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.health,
          activity: 'Sağlık Aktiviteleri',
          description: _getHealthDescription(moonSign),
          rating: healthRating,
          bestTime: _getBestHealthTime(moonSign),
          tip: healthRating >= 4 ? 'Yeni rutinler başlat' : 'Dinlen',
        ),
      );
    }

    // Travel recommendations
    if (category == TimingCategory.all || category == TimingCategory.travel) {
      int travelRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.sagittarius || moonSign == MoonSign.gemini)
        travelRating++;
      if (retrogrades.contains('mercury')) travelRating -= 2;
      travelRating = travelRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.travel,
          activity: 'Seyahat Planlama',
          description: _getTravelDescription(moonSign, retrogrades),
          rating: travelRating,
          bestTime: _getBestTravelTime(moonSign),
          tip: travelRating >= 4 ? 'Maceraya atıl' : 'Yerel kal',
        ),
      );
    }

    // Creative recommendations
    if (category == TimingCategory.all || category == TimingCategory.creative) {
      int creativeRating = 3 + random.nextInt(2);
      if (moonSign == MoonSign.leo || moonSign == MoonSign.pisces)
        creativeRating++;
      creativeRating = creativeRating.clamp(1, 5);

      allRecommendations.add(
        TimingRecommendation(
          category: TimingCategory.creative,
          activity: 'Yaratici Projeler',
          description: _getCreativeDescription(moonSign),
          rating: creativeRating,
          bestTime: _getBestCreativeTime(moonSign),
          tip: creativeRating >= 4 ? 'İlham doruklarda' : 'İzle ve öğren',
        ),
      );
    }

    // Sort by rating descending
    allRecommendations.sort((a, b) => b.rating.compareTo(a.rating));

    return allRecommendations;
  }

  static List<DayForecast> get7DayForecast(ZodiacSign sign) {
    final days = <DayForecast>[];
    final now = DateTime.now();
    final dayNames = ['Bugün', 'Yarın', 'Per', 'Cum', 'Cmt', 'Paz', 'Pzt'];

    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      final seed = date.year * 10000 + date.month * 100 + date.day + sign.index;
      final random = Random(seed);

      final score = 50 + random.nextInt(40);
      final Color color = score >= 70
          ? Colors.green
          : score >= 50
          ? Colors.amber
          : Colors.red;

      // Approximate moon sign for the day
      final moonIndex = (date.day + date.month) % 12;
      final moonSign = MoonSign.values[moonIndex];

      days.add(
        DayForecast(
          dayName: i < dayNames.length
              ? dayNames[i]
              : _getShortDayName(date.weekday),
          score: score,
          color: color,
          moonSign: moonSign,
        ),
      );
    }

    return days;
  }

  static String _getShortDayName(int weekday) {
    const names = ['Pzt', 'Sal', 'Car', 'Per', 'Cum', 'Cmt', 'Paz'];
    return names[weekday - 1];
  }

  // Description generators
  static String _getLoveDescription(
    MoonSign moon,
    bool voc,
    List<String> retros,
  ) {
    if (voc)
      return 'Boş seyir nedeniyle duygusal kararlar ertelenmeli. Mevcut ilişkilere odaklanın.';
    if (retros.contains('venus'))
      return 'Venüs retrosu eski aşklar hakkında düşündürür. Yeni başlangıçlar için beklemeniz uygun.';

    switch (moon) {
      case MoonSign.libra:
        return 'İlişki enerjisi yüksek. Partner ile uyum ve romantizm için ideal bir zaman.';
      case MoonSign.taurus:
        return 'Fiziksel yakınlık ve güvenlik önemli. Samimi anlar için uygun.';
      case MoonSign.cancer:
        return 'Duygusal derinlik artıyor. Ailenizle ve sevilenlerle kaliteli zaman geçirin.';
      case MoonSign.scorpio:
        return 'Tutkulu ve yoğun duygular hakim. Derin bağlantı kurmak için cesur olun.';
      default:
        return 'Aşk hayatında yeni fırsatlar belirebilir. Açık olmak önemli.';
    }
  }

  static String _getCareerDescription(
    MoonSign moon,
    bool voc,
    List<String> retros,
  ) {
    if (voc)
      return 'Önemli iş kararları ertelenmeli. Mevcut projelere devam edin.';
    if (retros.contains('mercury'))
      return 'İletişim hatalarına dikkat. Sözleşmeleri dikkatli inceleyin.';

    switch (moon) {
      case MoonSign.capricorn:
        return 'Kariyer hedefleri netleşir. Uzun vadeli planlar yapmak için ideal.';
      case MoonSign.virgo:
        return 'Detaylara odaklanın. Analiz ve organizasyon işleri destekleniyor.';
      case MoonSign.aries:
        return 'Liderlik enerjisi yüksek. Yeni projeler başlatmak için cesaret edin.';
      default:
        return 'İş hayatında stabil bir gün. Rutinlere bağlı kalmak faydalı.';
    }
  }

  static String _getMoneyDescription(MoonSign moon, bool voc) {
    if (voc)
      return 'Büyük finansal kararlar ertelenmeli. Araştırma ve planlama için kullanın.';

    switch (moon) {
      case MoonSign.taurus:
        return 'Finansal istikrar önemli. Uzun vadeli yatırımlar düşünülebilir.';
      case MoonSign.scorpio:
        return 'Gizli fırsatlar ortaya çıkabilir. Araştırma ve analiz yapın.';
      case MoonSign.capricorn:
        return 'Pratik finansal kararlar için ideal. Bütçe planlaması yapın.';
      default:
        return 'Para konularında dikkatli ilerleyin. Büyük harcamalardan kaçının.';
    }
  }

  static String _getHealthDescription(MoonSign moon) {
    switch (moon) {
      case MoonSign.virgo:
        return 'Detoks ve temizlik için ideal. Sağlıklı rutinler oluşturun.';
      case MoonSign.pisces:
        return 'Ruhsal denge önemli. Meditasyon ve rahatlama önerilir.';
      case MoonSign.aries:
        return 'Fiziksel aktivite için yüksek enerji. Spor ve egzersiz yapın.';
      case MoonSign.cancer:
        return 'Duygusal sağlık ön planda. Kendinize şefkat gösterin.';
      default:
        return 'Genel sağlık için uygun. Dengeli beslenme ve dinlenme önemli.';
    }
  }

  static String _getTravelDescription(MoonSign moon, List<String> retros) {
    if (retros.contains('mercury'))
      return 'Seyahat aksaklıklarına hazırlıklı olun. Plan B hazır tutun.';

    switch (moon) {
      case MoonSign.sagittarius:
        return 'Macera ruhu yüksek! Yeni yerler keşfetmek için mükemmel.';
      case MoonSign.gemini:
        return 'Kısa seyahatler ve yerel keşifler için ideal bir dönem.';
      default:
        return 'Seyahat planlaması için uygun. Detayları önceden belirleyin.';
    }
  }

  static String _getCreativeDescription(MoonSign moon) {
    switch (moon) {
      case MoonSign.leo:
        return 'Yaratıcı ifade dorukta! Sanatsal projeler ve performans için ideal.';
      case MoonSign.pisces:
        return 'Hayal gücü ve ilham yüksek. Sezgisel yaratıcılık destekleniyor.';
      case MoonSign.aquarius:
        return 'Yenilikçi fikirler akıyor. Alternatif yaklaşımlar deneyin.';
      default:
        return 'Yaratıcı enerji stabil. Mevcut projelere devam etmek için uygun.';
    }
  }

  // Best time generators
  static String _getBestLoveTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.libra:
      case MoonSign.taurus:
        return 'Akşam 18:00-21:00';
      case MoonSign.cancer:
        return 'Gece 20:00-23:00';
      default:
        return 'Akşam saatleri';
    }
  }

  static String _getBestCareerTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.capricorn:
      case MoonSign.virgo:
        return 'Sabah 09:00-12:00';
      case MoonSign.aries:
        return 'Sabah erken 08:00-10:00';
      default:
        return 'Ogle saatleri';
    }
  }

  static String _getBestMoneyTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.taurus:
        return 'Ogle 11:00-14:00';
      case MoonSign.capricorn:
        return 'Sabah 10:00-12:00';
      default:
        return 'Is saatleri';
    }
  }

  static String _getBestHealthTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.aries:
        return 'Sabah erken 06:00-09:00';
      case MoonSign.virgo:
        return 'Sabah 07:00-10:00';
      default:
        return 'Gun boyunca';
    }
  }

  static String _getBestTravelTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.sagittarius:
        return 'Sabah erken';
      case MoonSign.gemini:
        return 'Ogle sonrasi';
      default:
        return 'Esnek';
    }
  }

  static String _getBestCreativeTime(MoonSign moon) {
    switch (moon) {
      case MoonSign.pisces:
        return 'Gece gec saatler';
      case MoonSign.leo:
        return 'Ogle sonrasi 14:00-18:00';
      default:
        return 'Aksam saatleri';
    }
  }

  // Planetary Hours
  static List<PlanetaryHour> getPlanetaryHours() {
    // Traditional Chaldean order, starting from Sunday sunrise
    final now = DateTime.now();
    final dayOfWeek = now.weekday % 7; // Sunday = 0

    // Day rulers in order: Sun, Moon, Mars, Mercury, Jupiter, Venus, Saturn
    final dayRulers = [
      PlanetaryHour(
        planet: 'Sun',
        planetTr: 'Güneş',
        symbol: '☀️',
        color: Colors.amber,
        meaning: 'Liderlik, başarı, canlılık',
      ),
      PlanetaryHour(
        planet: 'Moon',
        planetTr: 'Ay',
        symbol: '🌙',
        color: Colors.blueGrey,
        meaning: 'Duygular, sezgi, ev işleri',
      ),
      PlanetaryHour(
        planet: 'Mars',
        planetTr: 'Mars',
        symbol: '♂️',
        color: Colors.red,
        meaning: 'Enerji, cesaret, rekabet',
      ),
      PlanetaryHour(
        planet: 'Mercury',
        planetTr: 'Merkür',
        symbol: '☿️',
        color: Colors.cyan,
        meaning: 'İletişim, öğrenme, ticaret',
      ),
      PlanetaryHour(
        planet: 'Jupiter',
        planetTr: 'Jüpiter',
        symbol: '♃',
        color: Colors.purple,
        meaning: 'Şans, genişleme, bilgelik',
      ),
      PlanetaryHour(
        planet: 'Venus',
        planetTr: 'Venüs',
        symbol: '♀️',
        color: Colors.pink,
        meaning: 'Aşk, güzellik, sanat',
      ),
      PlanetaryHour(
        planet: 'Saturn',
        planetTr: 'Satürn',
        symbol: '♄',
        color: Colors.brown,
        meaning: 'Disiplin, sorumluluk, sınırlar',
      ),
    ];

    // Rotate based on day of week
    final hourSequence = <PlanetaryHour>[];
    for (int i = 0; i < 24; i++) {
      final index = (dayOfWeek + i) % 7;
      hourSequence.add(dayRulers[index]);
    }

    return hourSequence;
  }

  // Lucky Elements
  static LuckyElements getLuckyElements(ZodiacSign sign, DateTime birthDate) {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day + sign.index;
    final random = Random(seed);

    // Generate lucky numbers based on sign and day
    final baseNumbers = <int>[];
    final signNumber = sign.index + 1;
    baseNumbers.add(signNumber);
    baseNumbers.add((now.day + signNumber) % 49 + 1);
    baseNumbers.add((now.month * signNumber) % 49 + 1);
    baseNumbers.add(random.nextInt(49) + 1);

    // Remove duplicates and sort
    final uniqueNumbers = baseNumbers.toSet().toList()..sort();

    // Lucky colors by sign
    final signColors = {
      ZodiacSign.aries: (Colors.red, 'Kırmızı'),
      ZodiacSign.taurus: (Colors.green, 'Yeşil'),
      ZodiacSign.gemini: (Colors.yellow, 'Sarı'),
      ZodiacSign.cancer: (Colors.white, 'Beyaz'),
      ZodiacSign.leo: (Colors.orange, 'Turuncu'),
      ZodiacSign.virgo: (Colors.brown, 'Kahverengi'),
      ZodiacSign.libra: (Colors.pink, 'Pembe'),
      ZodiacSign.scorpio: (Colors.purple, 'Mor'),
      ZodiacSign.sagittarius: (Colors.blue, 'Mavi'),
      ZodiacSign.capricorn: (Colors.grey, 'Gri'),
      ZodiacSign.aquarius: (Colors.cyan, 'Turkuaz'),
      ZodiacSign.pisces: (Colors.teal, 'Deniz Mavisi'),
    };

    final directions = [
      'Kuzey',
      'Güney',
      'Doğu',
      'Batı',
      'Kuzeydoğu',
      'Güneybatı',
    ];
    final times = [
      '06:00-09:00',
      '09:00-12:00',
      '12:00-15:00',
      '15:00-18:00',
      '18:00-21:00',
      '21:00-24:00',
    ];

    final signFlowers = {
      ZodiacSign.aries: 'Gelincik',
      ZodiacSign.taurus: 'Gul',
      ZodiacSign.gemini: 'Lavanta',
      ZodiacSign.cancer: 'Zambak',
      ZodiacSign.leo: 'Ayçiçeği',
      ZodiacSign.virgo: 'Papatya',
      ZodiacSign.libra: 'Orkide',
      ZodiacSign.scorpio: 'Kasimpati',
      ZodiacSign.sagittarius: 'Karanfil',
      ZodiacSign.capricorn: 'Pansyon',
      ZodiacSign.aquarius: 'Menekse',
      ZodiacSign.pisces: 'Nilüfer',
    };

    final signGemstones = {
      ZodiacSign.aries: 'Elmas',
      ZodiacSign.taurus: 'Zümrüt',
      ZodiacSign.gemini: 'Akik',
      ZodiacSign.cancer: 'İnci',
      ZodiacSign.leo: 'Yakut',
      ZodiacSign.virgo: 'Safir',
      ZodiacSign.libra: 'Opal',
      ZodiacSign.scorpio: 'Topaz',
      ZodiacSign.sagittarius: 'Turkuaz',
      ZodiacSign.capricorn: 'Garnet',
      ZodiacSign.aquarius: 'Ametist',
      ZodiacSign.pisces: 'Akvamarin',
    };

    final colorPair = signColors[sign] ?? (Colors.blue, 'Mavi');

    return LuckyElements(
      numbers: uniqueNumbers.take(4).toList(),
      color: colorPair.$1,
      colorTr: colorPair.$2,
      direction: directions[random.nextInt(directions.length)],
      time: times[random.nextInt(times.length)],
      flower: signFlowers[sign] ?? 'Gul',
      gemstone: signGemstones[sign] ?? 'Kristal',
    );
  }

  // Biorhythm Calculation
  static Biorhythm getBiorhythm(DateTime birthDate) {
    final now = DateTime.now();
    final daysSinceBirth = now.difference(birthDate).inDays;

    // Standard biorhythm cycles
    final physical = sin(2 * pi * daysSinceBirth / 23);
    final emotional = sin(2 * pi * daysSinceBirth / 28);
    final intellectual = sin(2 * pi * daysSinceBirth / 33);
    final intuitive = sin(2 * pi * daysSinceBirth / 38);

    // Generate summary based on values
    String summary;
    final avgPositive = (physical + emotional + intellectual) / 3;

    if (avgPositive > 0.5) {
      summary =
          'Bugün tüm döngüleriniz yüksekte! Enerjinizi akıllıca kullanın.';
    } else if (avgPositive > 0) {
      summary = 'Dengeli bir gün. Fiziksel ve zihinsel aktiviteler için uygun.';
    } else if (avgPositive > -0.5) {
      summary = 'Enerji seviyeleri düşük. Dinlenmeye öncelik verin.';
    } else {
      summary = 'Kritik gün. Önemli kararları ertelemeniz önerilir.';
    }

    return Biorhythm(
      physical: physical,
      emotional: emotional,
      intellectual: intellectual,
      intuitive: intuitive,
      summary: summary,
    );
  }

  // Daily Aspects
  static List<DailyAspect> getDailyAspects() {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);

    final aspects = <DailyAspect>[];

    // Generate 3-5 aspects for the day
    final aspectCount = 3 + random.nextInt(3);

    final planetPairs = [
      ('Güneş', 'Ay'),
      ('Merkür', 'Venüs'),
      ('Mars', 'Jüpiter'),
      ('Venüs', 'Mars'),
      ('Ay', 'Satürn'),
      ('Jüpiter', 'Neptün'),
      ('Merkür', 'Mars'),
      ('Venüs', 'Jüpiter'),
      ('Satürn', 'Plüton'),
      ('Ay', 'Venüs'),
    ];

    final aspectTypes = [
      ('Kavuşum', true, Colors.purple),
      ('Üçgen', true, Colors.green),
      ('Altıgen', true, Colors.cyan),
      ('Kare', false, Colors.red),
      ('Karşıt', false, Colors.orange),
    ];

    final usedPairs = <int>{};

    for (int i = 0; i < aspectCount; i++) {
      int pairIndex;
      do {
        pairIndex = random.nextInt(planetPairs.length);
      } while (usedPairs.contains(pairIndex));
      usedPairs.add(pairIndex);

      final pair = planetPairs[pairIndex];
      final aspectType = aspectTypes[random.nextInt(aspectTypes.length)];
      final hour = 6 + random.nextInt(16);

      String interpretation;
      if (aspectType.$2) {
        // Harmonious
        interpretation = _getHarmoniousInterpretation(
          pair.$1,
          pair.$2,
          aspectType.$1,
        );
      } else {
        // Challenging
        interpretation = _getChallengingInterpretation(
          pair.$1,
          pair.$2,
          aspectType.$1,
        );
      }

      aspects.add(
        DailyAspect(
          time:
              '${hour.toString().padLeft(2, '0')}:${(random.nextInt(4) * 15).toString().padLeft(2, '0')}',
          planets: '${pair.$1} - ${pair.$2}',
          aspectName: aspectType.$1,
          isHarmonious: aspectType.$2,
          interpretation: interpretation,
          color: aspectType.$3,
        ),
      );
    }

    // Sort by time
    aspects.sort((a, b) => a.time.compareTo(b.time));

    return aspects;
  }

  static String _getHarmoniousInterpretation(
    String p1,
    String p2,
    String aspect,
  ) {
    if (p1 == 'Güneş' || p2 == 'Güneş') {
      return 'Canlılık ve özgüven artıyor. Liderlik yeteneklerinizi kullanmak için ideal zaman.';
    }
    if (p1 == 'Ay' || p2 == 'Ay') {
      return 'Duygusal denge ve sezgisel güç artıyor. İçsel huzur için meditasyon önerilir.';
    }
    if (p1 == 'Venüs' || p2 == 'Venüs') {
      return 'Aşk ve güzellik enerjisi yüksek. İlişkiler ve sanatsal çalışmalar destekleniyor.';
    }
    if (p1 == 'Jüpiter' || p2 == 'Jüpiter') {
      return 'Şans ve bolluk enerjisi akıyor. Yeni fırsatlar kapı çalabilir.';
    }
    return 'Uyumlu enerji akışı. İş birliği ve uyum için olumlu bir zaman.';
  }

  static String _getChallengingInterpretation(
    String p1,
    String p2,
    String aspect,
  ) {
    if (p1 == 'Mars' || p2 == 'Mars') {
      return 'Gerginlik ve çatışma potansiyeli var. Sabırlı olun ve tepkileri kontrol edin.';
    }
    if (p1 == 'Satürn' || p2 == 'Satürn') {
      return 'Kısıtlamalar ve engellerle karşılaşabilirsiniz. Disiplinli yaklaşım gerekli.';
    }
    if (p1 == 'Plüton' || p2 == 'Plüton') {
      return 'Derin dönüşümler gündemde. Eski kalıpları bırakmak gerekebilir.';
    }
    return 'Zorlayıcı enerji. Dikkatli ve bilinçli hareket edin.';
  }
}
