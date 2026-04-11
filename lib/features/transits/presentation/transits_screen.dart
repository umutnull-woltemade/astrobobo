import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/planet.dart';
import '../../../data/models/natal_chart.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/ephemeris_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

/// Current planetary transits provider - uses API with local fallback
final currentTransitsProvider = FutureProvider<List<PlanetPosition>>((
  ref,
) async {
  try {
    // Try to fetch from API
    final api = ref.watch(astrologyApiProvider);
    final response = await api.planets.getCurrentPositions();

    if (response.isSuccess && response.data != null) {
      // Convert API data to local PlanetPosition model
      return response.data!
          .map((dto) {
            final planet = _stringToPlanet(dto.name);
            return PlanetPosition(
              planet: planet,
              longitude: dto.longitude,
              latitude: dto.latitude,
              isRetrograde: dto.isRetrograde,
            );
          })
          .where(
            (p) =>
                p.planet != Planet.ascendant &&
                p.planet != Planet.midheaven &&
                p.planet != Planet.ic &&
                p.planet != Planet.descendant,
          )
          .toList();
    }
  } catch (e) {
    // Fallback to local calculation if API fails
    debugPrint('API failed, using local calculation: $e');
  }

  // Fallback to local calculation
  final now = DateTime.now();
  final birthData = BirthData(date: now);
  final chart = EphemerisService.calculateNatalChart(birthData);
  return chart.planets
      .where(
        (p) =>
            p.planet != Planet.ascendant &&
            p.planet != Planet.midheaven &&
            p.planet != Planet.ic &&
            p.planet != Planet.descendant,
      )
      .toList();
});

Planet _stringToPlanet(String name) {
  final normalized = name.toLowerCase();
  return switch (normalized) {
    'sun' => Planet.sun,
    'moon' => Planet.moon,
    'mercury' => Planet.mercury,
    'venus' => Planet.venus,
    'mars' => Planet.mars,
    'jupiter' => Planet.jupiter,
    'saturn' => Planet.saturn,
    'uranus' => Planet.uranus,
    'neptune' => Planet.neptune,
    'pluto' => Planet.pluto,
    'northnode' || 'truenode' => Planet.northNode,
    'southnode' => Planet.southNode,
    'chiron' => Planet.chiron,
    _ => Planet.sun,
  };
}

class TransitsScreen extends ConsumerWidget {
  const TransitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transitsAsync = ref.watch(currentTransitsProvider);
    final language = ref.watch(languageProvider);

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: transitsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.starGold),
            ),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.fireElement,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Gezegen verileri yüklenemedi',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.invalidate(currentTransitsProvider),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            ),
            data: (currentTransits) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, ref),
                  const SizedBox(height: AppConstants.spacingXl),
                  _buildCurrentSkyCard(context, currentTransits),
                  const SizedBox(height: AppConstants.spacingXl),
                  _buildRetrogradePlanets(context, currentTransits),
                  const SizedBox(height: AppConstants.spacingXl),
                  _buildPlanetList(context, currentTransits, language),
                  const SizedBox(height: AppConstants.spacingXl),
                  // Kadim Not
                  KadimNotCard(
                    category: KadimCategory.astrology,
                    title: 'Kozmik Hava Durumu',
                    content:
                        'Transitler, gökyüzündeki gezegenlerin şu anki konumlarının doğum haritanla '
                        'nasıl etkileştiğini gösterir. Kozmik bir hava durumu raporu gibi düşün - '
                        'evrenin enerjileri her gün değişir ve bu geçişler hayatının farklı alanlarını tetikler. '
                        'Antik astrologlar gökyüzünü okuyarak krallıkların kaderini belirlerdi.',
                    icon: Icons.compare_arrows,
                  ),
                  const SizedBox(height: AppConstants.spacingXl),
                  // Quiz CTA - Google Discover Funnel
                  QuizCTACard.astrology(compact: true),
                  const SizedBox(height: AppConstants.spacingXl),
                  // Next Blocks
                  const NextBlocks(currentPage: 'transits'),
                  const SizedBox(height: AppConstants.spacingXl),
                  // Entertainment Disclaimer
                  const PageFooterWithDisclaimer(
                    brandText: 'Transitler — Venus One',
                    disclaimerText: DisclaimerTexts.astrology,
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language == AppLanguage.tr
                    ? 'Gezegen Transitler'
                    : 'Planet Transits',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.starGold),
              ).animate().fadeIn(duration: 400.ms),
              Text(
                language == AppLanguage.tr
                    ? 'Bugünkü gökyüzü enerjileri'
                    : 'Today\'s sky energies',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentSkyCard(
    BuildContext context,
    List<PlanetPosition> transits,
  ) {
    final now = DateTime.now();
    final dateStr = '${now.day}.${now.month}.${now.year}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withValues(alpha: 0.3),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        border: Border.all(color: AppColors.auroraStart.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.auroraStart.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.public,
                  color: AppColors.auroraStart,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bugünün Gökyüzü',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      dateStr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildMiniPlanetRow(context, transits),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildMiniPlanetRow(
    BuildContext context,
    List<PlanetPosition> transits,
  ) {
    // Show first 5 personal planets
    final personalPlanets = transits
        .where((p) => p.planet.isPersonalPlanet)
        .take(5)
        .toList();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: personalPlanets.map((planet) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: planet.planet.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: planet.planet.color.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                planet.planet.symbol,
                style: TextStyle(fontSize: 16, color: planet.planet.color),
              ),
              const SizedBox(width: 6),
              Text(
                planet.sign.symbol,
                style: TextStyle(fontSize: 14, color: planet.sign.color),
              ),
              const SizedBox(width: 4),
              Text(
                planet.sign.nameTr,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: planet.sign.color),
              ),
              if (planet.isRetrograde) ...[
                const SizedBox(width: 4),
                Text(
                  '℞',
                  style: TextStyle(fontSize: 12, color: AppColors.fireElement),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRetrogradePlanets(
    BuildContext context,
    List<PlanetPosition> transits,
  ) {
    final retrogrades = transits.where((p) => p.isRetrograde).toList();

    if (retrogrades.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          color: AppColors.earthElement.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: AppColors.earthElement.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: AppColors.earthElement),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: Text(
                'Hiçbir gezegen retro değil!',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.earthElement),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.rotate_left, color: AppColors.fireElement, size: 20),
            const SizedBox(width: 8),
            Text(
              'Retrograd Gezegenler',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ...retrogrades.asMap().entries.map((entry) {
          final index = entry.key;
          final planet = entry.value;
          return _buildRetrogradeCard(
            context,
            planet,
          ).animate().fadeIn(delay: (300 + index * 100).ms, duration: 400.ms);
        }),
      ],
    );
  }

  Widget _buildRetrogradeCard(BuildContext context, PlanetPosition planet) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            planet.planet.color.withValues(alpha: 0.2),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: planet.planet.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: planet.planet.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Text(
              planet.planet.symbol,
              style: TextStyle(fontSize: 20, color: planet.planet.color),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      planet.planet.nameTr,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: planet.planet.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fireElement.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '℞ RETRO',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.fireElement,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _getRetrogradeMessage(planet.planet),
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

  String _getRetrogradeMessage(Planet planet) {
    switch (planet) {
      case Planet.mercury:
        return 'İletişim ve seyahatte dikkatli ol. Eski konuları gözden geçir.';
      case Planet.venus:
        return 'Aşk ve finans konularında yavaş ilerle. İlişkileri sorgula.';
      case Planet.mars:
        return 'Enerjini içe yönlendir. Agresif kararlardan kaçın.';
      case Planet.jupiter:
        return 'İç büyüme ve felsefik sorgulamalar zamanı.';
      case Planet.saturn:
        return 'Sorumlulukları yeniden yapılandır. Sabırlı ol.';
      case Planet.uranus:
        return 'İç özgürlük arayışı. Beklenmedik değişimler.';
      case Planet.neptune:
        return 'Rüyalar ve sezgiler güçleniyor. Gerçeklik bulanık.';
      case Planet.pluto:
        return 'Derin dönüşüm süreci. Gölge çalışması zamanı.';
      default:
        return 'Bu gezegen retro döneminde.';
    }
  }

  Widget _buildPlanetList(
    BuildContext context,
    List<PlanetPosition> transits,
    AppLanguage language,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language == AppLanguage.tr ? 'Tüm Gezegenler' : 'All Planets',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        const SizedBox(height: AppConstants.spacingMd),
        ...transits.asMap().entries.map((entry) {
          final index = entry.key;
          final planet = entry.value;
          return _buildPlanetCard(
            context,
            planet,
            language,
          ).animate().fadeIn(delay: (500 + index * 50).ms, duration: 300.ms);
        }),
      ],
    );
  }

  Widget _buildPlanetCard(
    BuildContext context,
    PlanetPosition position,
    AppLanguage language,
  ) {
    final planetName = language == AppLanguage.tr
        ? position.planet.nameTr
        : position.planet.name;
    final signName = language == AppLanguage.tr
        ? position.sign.nameTr
        : position.sign.name;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: position.planet.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                position.planet.symbol,
                style: TextStyle(fontSize: 20, color: position.planet.color),
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
                    Text(
                      planetName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (position.isRetrograde) ...[
                      const SizedBox(width: 6),
                      Text(
                        '℞',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.fireElement,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  position.planet.meaning,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: position.sign.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  position.sign.symbol,
                  style: TextStyle(fontSize: 14, color: position.sign.color),
                ),
                const SizedBox(width: 4),
                Text(
                  signName,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: position.sign.color),
                ),
                const SizedBox(width: 4),
                Text(
                  '${position.degree}°',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textPrimary,
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
