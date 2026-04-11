import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/natal_chart.dart';
import '../../../../data/models/planet.dart';
import '../../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../../data/services/esoteric_interpretation_service.dart';

class PlanetPositionsCard extends StatelessWidget {
  final NatalChart chart;

  const PlanetPositionsCard({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    // Group planets by type
    final personalPlanets = chart.planets
        .where((p) => p.planet.isPersonalPlanet)
        .toList();
    final socialPlanets = chart.planets
        .where((p) => p.planet.isSocialPlanet)
        .toList();
    final outerPlanets = chart.planets
        .where((p) => p.planet.isOuterPlanet)
        .toList();
    final otherPoints = chart.planets
        .where(
          (p) =>
              !p.planet.isPersonalPlanet &&
              !p.planet.isSocialPlanet &&
              !p.planet.isOuterPlanet &&
              p.planet != Planet.ascendant &&
              p.planet != Planet.midheaven &&
              p.planet != Planet.ic &&
              p.planet != Planet.descendant,
        )
        .toList();
    final angles = chart.planets
        .where(
          (p) =>
              p.planet == Planet.ascendant ||
              p.planet == Planet.midheaven ||
              p.planet == Planet.ic ||
              p.planet == Planet.descendant,
        )
        .toList();

    return Column(
      children: [
        _buildSection(
          context,
          'Kişisel Gezegenler',
          'Benlik ve günlük yaşam',
          personalPlanets,
          0,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _buildSection(
          context,
          'Sosyal Gezegenler',
          'Toplumsal rol',
          socialPlanets,
          100,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _buildSection(
          context,
          'Dış Gezegenler',
          'Nesil ve dönüşüm',
          outerPlanets,
          200,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _buildSection(
          context,
          'Diğer Noktalar',
          'Ay düğümleri, Chiron, Lilith',
          otherPoints,
          300,
        ),
        if (angles.isNotEmpty) ...[
          const SizedBox(height: AppConstants.spacingMd),
          _buildSection(
            context,
            'Açılar',
            'Yükselen, MC, IC, Alçalan',
            angles,
            400,
          ),
        ],
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    List<PlanetPosition> planets,
    int delayMs,
  ) {
    if (planets.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          ...planets.asMap().entries.map((entry) {
            final index = entry.key;
            final planet = entry.value;
            return _PlanetRow(
              planet: planet,
              isLast: index == planets.length - 1,
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: delayMs.ms, duration: 400.ms);
  }
}

class _PlanetRow extends StatelessWidget {
  final PlanetPosition planet;
  final bool isLast;

  const _PlanetRow({required this.planet, this.isLast = false});

  String _getDetailedInterpretation() {
    // Get sign-specific interpretation based on planet
    switch (planet.planet) {
      case Planet.sun:
        return EsotericInterpretationService.getSunInterpretation(planet.sign);
      case Planet.moon:
        return EsotericInterpretationService.getMoonInterpretation(planet.sign);
      case Planet.mercury:
        return EsotericInterpretationService.getMercuryInterpretation(
          planet.sign,
        );
      case Planet.venus:
        return EsotericInterpretationService.getVenusInterpretation(
          planet.sign,
        );
      case Planet.mars:
        return EsotericInterpretationService.getMarsInterpretation(planet.sign);
      case Planet.jupiter:
        return EsotericInterpretationService.getJupiterInterpretation(
          planet.sign,
        );
      case Planet.saturn:
        return EsotericInterpretationService.getSaturnInterpretation(
          planet.sign,
        );
      case Planet.uranus:
        return EsotericInterpretationService.getUranusInterpretation(
          planet.sign,
        );
      case Planet.neptune:
        return EsotericInterpretationService.getNeptuneInterpretation(
          planet.sign,
        );
      case Planet.pluto:
        return EsotericInterpretationService.getPlutoInterpretation(
          planet.sign,
        );
      case Planet.ascendant:
        return EsotericInterpretationService.getRisingInterpretation(
          planet.sign,
        );
      default:
        return _getGenericPlanetInterpretation();
    }
  }

  String _getGenericPlanetInterpretation() {
    final signName = zodiac.ZodiacSignExtension(planet.sign).nameTr;
    final planetMeaning = planet.planet.meaning;

    final interpretations = {
      Planet.jupiter:
          '''
${planet.planet.nameTr} $signName burcunda - büyüme ve şans alanın bu burç enerjisiyle renkleniyor.

$signName'nin özellikleri, nasıl genişlediğini, neye inandığını ve şansını nerede bulduğunu gösteriyor. Felsefik bakış açın, öğrenme stilin ve hayata karşı iyimserliğin bu burçla şekilleniyor.

$planetMeaning alanlarında $signName enerjisi etkin. Bu yerleşim, ruhsal büyüme potansiyelini ve hayatında bereketin nasıl aktığını gösteriyor.
''',
      Planet.saturn:
          '''
${planet.planet.nameTr} $signName burcunda - sorumluluk ve sınırlar bu burç enerjisiyle ifade buluyor.

$signName'nin özellikleri, hangi alanlarda olgunlaşman gerektiğini, korkularını ve hayat derslerini gösteriyor. Disiplin tarzın, otorite ilişkin ve zaman anlayışın bu burçla şekilleniyor.

$planetMeaning alanlarında $signName enerjisi etkin. Bu yerleşim, karmanı ve ustalık yolculuğunu gösteriyor.
''',
      Planet.uranus:
          '''
${planet.planet.nameTr} $signName burcunda - özgünlük ve devrim bu burç enerjisiyle ifade buluyor.

$signName'nin özellikleri, nerede özgür olmak istediğini, farklı olduğun alanları ve yenilikçi potansiyelini gösteriyor. İsyankar ruhun ve vizyonerin bu burçla şekilleniyor.

$planetMeaning alanlarında $signName enerjisi etkin. Bu bir nesil yerleşimi - yaş grubunla paylaştığın kolektif bir enerji.
''',
      Planet.neptune:
          '''
${planet.planet.nameTr} $signName burcunda - rüyalar ve sezgi bu burç enerjisiyle ifade buluyor.

$signName'nin özellikleri, spiritüel eğilimlerini, yaratıcı ilhamını ve illüzyon alanlarını gösteriyor. Hayal gücün ve ruhani bağlantın bu burçla şekilleniyor.

$planetMeaning alanlarında $signName enerjisi etkin. Bu bir nesil yerleşimi - kolektif rüyalar ve spiritüel trendleri yansıtıyor.
''',
      Planet.pluto:
          '''
${planet.planet.nameTr} $signName burcunda - dönüşüm ve güç bu burç enerjisiyle ifade buluyor.

$signName'nin özellikleri, derin dönüşüm alanlarını, gölge çalışması gereken konuları ve yeniden doğuş potansiyelini gösteriyor. Psikolojik derinliğin bu burçla şekilleniyor.

$planetMeaning alanlarında $signName enerjisi etkin. Bu bir nesil yerleşimi - kolektif dönüşüm ve güç dinamiklerini yansıtıyor.
''',
      Planet.northNode:
          '''
${planet.planet.nameTr} $signName burcunda - ruhunun bu hayatta öğrenmesi gereken ders bu burçla ilgili.

$signName enerjisini geliştirmek, bu hayattaki evrimsel yolculuğunun ana teması. Bu burç, konfor alanının dışına çıkarak ulaşman gereken hedefi gösteriyor.

Güney Düğüm'ün karşı burcundaki alışkanlıklarını bırakıp, $signName'nin özelliklerini benimsemek ruhsal gelişimin için kritik.
''',
      Planet.southNode:
          '''
${planet.planet.nameTr} $signName burcunda - geçmiş yaşamlardan getirdiğin yetenekler ve alışkanlıklar.

$signName enerjisi sende doğuştan var - ama bu konfor alanın aynı zamanda büyümeni engelleyebilir. Bu burcun özelliklerine aşırı tutunmak, evrimsel gelişimini yavaşlatabilir.

Kuzey Düğüm'üne yönelmek için $signName alışkanlıklarını dengelemen gerekiyor.
''',
      Planet.chiron:
          '''
${planet.planet.nameTr} $signName burcunda - en derin yaran ve şifa potansiyelin bu burcla bağlantılı.

$signName alanlarında yaşadığın travmalar veya acı deneyimler, paradoks olarak başkalarını iyileştirme gücüne dönüşebilir. "Yaralı şifacı" arketipi senin için bu burçta aktif.

Bu yarayı kabullenmek ve onunla barışmak, hem kendi şifanı hem de başkalarına yardım etme kapasiteni açığa çıkarır.
''',
      Planet.lilith:
          '''
${planet.planet.nameTr} $signName burcunda - bastırılan arzuların ve gölge tarafın bu burçla ilgili.

$signName alanlarında toplum tarafından kabul görmeyen veya bastırdığın istekler var. Bu enerjiyi reddetmek yerine, sağlıklı şekilde entegre etmek senin için önemli.

Kara Ay, vahşi, evcilleştirilmemiş feminine enerjiyi temsil ediyor - $signName burcunda bu enerji nasıl ifade bulmak istiyor?
''',
    };

    return interpretations[planet.planet] ??
        '${planet.planet.nameTr} $signName burcunda - $planetMeaning alanlarında bu burç enerjisi etkin.';
  }

  @override
  Widget build(BuildContext context) {
    final signColor = zodiac.ZodiacSignExtension(planet.sign).color;
    final signSymbol = zodiac.ZodiacSignExtension(planet.sign).symbol;
    final signNameTr = zodiac.ZodiacSignExtension(planet.sign).nameTr;

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: 0,
      ),
      childrenPadding: const EdgeInsets.only(
        left: AppConstants.spacingMd,
        right: AppConstants.spacingMd,
        bottom: AppConstants.spacingMd,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: planet.planet.color.withAlpha(51),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            planet.planet.symbol,
            style: TextStyle(fontSize: 18, color: planet.planet.color),
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              planet.planet.nameTr,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
            ),
          ),
          if (planet.isRetrograde)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.warning.withAlpha(51),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '℞',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(signSymbol, style: TextStyle(fontSize: 16, color: signColor)),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              signNameTr,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: signColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Text(
        planet.planet.meaning,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${planet.degree}° ${planet.minute}\'',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          if (planet.house > 0)
            Text(
              '${planet.house}. Ev',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.auroraStart),
            ),
        ],
      ),
      iconColor: AppColors.textMuted,
      collapsedIconColor: AppColors.textMuted,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                planet.planet.color.withAlpha(25),
                AppColors.surfaceDark,
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            border: Border.all(color: planet.planet.color.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with planet in sign
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: signColor.withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      signSymbol,
                      style: TextStyle(fontSize: 18, color: signColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${planet.planet.nameTr} $signNameTr Burcunda',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: planet.planet.color),
                        ),
                        if (planet.house > 0)
                          Text(
                            '${planet.house}. Evde',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: AppColors.auroraStart),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMd),

              // Detailed interpretation
              Text(
                _getDetailedInterpretation(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.7,
                ),
              ),

              // House interpretation if available
              if (planet.house > 0) ...[
                const SizedBox(height: AppConstants.spacingMd),
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.auroraStart.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.auroraStart.withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 14,
                            color: AppColors.auroraStart,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Ev Yorumu',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.auroraStart,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        EsotericInterpretationService.getPlanetInHouseInterpretation(
                          planet.planet,
                          planet.house,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.auroraStart,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Retrograde message if applicable
              if (planet.isRetrograde) ...[
                const SizedBox(height: AppConstants.spacingMd),
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.warning.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.replay, size: 14, color: AppColors.warning),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Retrograt: Bu gezegenin enerjisi içe dönük ve yeniden değerlendirme sürecinde. '
                          '${planet.planet.nameTr} alanlarında geçmişi gözden geçirme, derinleşme ve içsel çalışma öne çıkıyor.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.warning,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
