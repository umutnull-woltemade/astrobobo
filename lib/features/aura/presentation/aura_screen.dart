import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/aura_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/null_profile_placeholder.dart';

class AuraScreen extends ConsumerWidget {
  const AuraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    if (userProfile == null) {
      return const NullProfilePlaceholder(
        emoji: '✨',
        titleKey: 'aura_analysis',
        messageKey: 'enter_birth_info_aura',
      );
    }

    final auraProfile = AuraService.createAuraProfile(
      birthDate: userProfile.birthDate,
      name: userProfile.name,
    );
    final dailyEnergy = AuraService.getDailyAuraEnergy(
      userProfile.birthDate,
      DateTime.now(),
    );
    final cleansingTips = AuraService.getCleansingTips(
      auraProfile.primaryColor,
    );

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                snap: true,
                title: Text(
                  'Aura Analizi',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.starGold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Ezoterik giriş
                    _buildEsotericIntro(context),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Ana aura kartı
                    _buildMainAuraCard(
                      context,
                      auraProfile,
                    ).animate().fadeIn(duration: 400.ms),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Chakra dengesi
                    _buildSectionTitle(context, 'Chakra Dengesi'),
                    const SizedBox(height: AppConstants.spacingMd),
                    _buildChakraBalance(
                      context,
                      auraProfile.chakraAlignment,
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Günlük enerji
                    _buildSectionTitle(context, 'Günlük Aura Enerjisi'),
                    const SizedBox(height: AppConstants.spacingMd),
                    _buildDailyEnergyCard(
                      context,
                      dailyEnergy,
                    ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Aura temizleme
                    _buildSectionTitle(context, 'Aura Temizleme'),
                    const SizedBox(height: AppConstants.spacingMd),
                    ...cleansingTips.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.spacingMd,
                        ),
                        child:
                            _buildCleansingTip(
                              context,
                              entry.value,
                              auraProfile.primaryColor,
                            ).animate().fadeIn(
                              delay: (400 + entry.key * 100).ms,
                              duration: 400.ms,
                            ),
                      );
                    }),

                    const SizedBox(height: AppConstants.spacingXl),

                    // Kadim Not
                    KadimNotCard(
                      category: KadimCategory.chakra,
                      title: 'Enerji Bedenin Sırrı',
                      content:
                          'Aura kavramı binlerce yıllık ezoterik geleneğe dayanır. Eski Mısır\'da "ka" '
                          'olarak bilinen enerji bedeni, Hint geleneğinde "prana maya kosha" (yaşam enerjisi '
                          'kılıfı) adını alır. Modern Kirlian fotoğrafçılığı bu kadim bilgeliği doğrulamış, '
                          'canlı organizmaların çevresindeki biyoelektrik alanı görünür kılmıştır.',
                      icon: Icons.blur_on,
                    ),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Next Blocks
                    const NextBlocks(currentPage: 'aura'),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Entertainment Disclaimer
                    const PageFooterWithDisclaimer(
                      brandText: 'Aura — Venus One',
                      disclaimerText: DisclaimerTexts.chakra,
                    ),
                    const SizedBox(height: AppConstants.spacingLg),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEsotericIntro(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withAlpha(25),
            AppColors.auroraEnd.withAlpha(25),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.auroraStart.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.blur_on, color: AppColors.auroraStart, size: 18),
              const SizedBox(width: 8),
              Text(
                'Enerji Bedenin',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.auroraStart,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Aura, fiziksel bedenini çevreleyen enerji alanıdır. Her düşünce, duygu ve deneyim auranın rengini ve yoğunluğunu etkiler. Doğum tarihin ve ismin, temel aura rengini belirler - bu senin ruhsal imzandır. Auranı anlamak, enerjini yönetmenin ve korumanın anahtarıdır.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildMainAuraCard(BuildContext context, AuraProfile profile) {
    final auraColor = profile.primaryColor.color;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            auraColor.withAlpha(100),
            auraColor.withAlpha(50),
            AppColors.surfaceDark,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        border: Border.all(color: auraColor.withAlpha(128)),
        boxShadow: [
          BoxShadow(
            color: auraColor.withAlpha(50),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Aura görselleştirmesi
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  auraColor.withAlpha(200),
                  auraColor.withAlpha(100),
                  auraColor.withAlpha(50),
                  Colors.transparent,
                ],
                stops: const [0.3, 0.5, 0.7, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: auraColor.withAlpha(100),
                  blurRadius: 40,
                  spreadRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceDark,
                  border: Border.all(color: auraColor, width: 2),
                ),
                child: Icon(Icons.person, color: auraColor, size: 40),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            'Birincil Auran',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            profile.primaryColor.nameTr,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: auraColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            profile.primaryColor.meaning,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildAuraAttribute(
                  context,
                  'Enerji Seviyesi',
                  '${profile.overallEnergy}%',
                  auraColor,
                  profile.overallEnergy / 100,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: _buildAuraAttribute(
                  context,
                  'Chakra',
                  profile.primaryColor.chakra.nameTr,
                  profile.primaryColor.chakra.color,
                  null,
                ),
              ),
            ],
          ),
          if (profile.secondaryColor != null) ...[
            const SizedBox(height: AppConstants.spacingLg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: profile.secondaryColor!.color.withAlpha(25),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: profile.secondaryColor!.color,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'İkincil Aura',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                        Text(
                          profile.secondaryColor!.nameTr,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: profile.secondaryColor!.color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppConstants.spacingLg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: auraColor.withAlpha(25),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: auraColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Spiritüel Tavsiye',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: auraColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  profile.spiritualAdvice,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuraAttribute(
    BuildContext context,
    String label,
    String value,
    Color color,
    double? progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          if (progress != null) ...[
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withAlpha(50),
              valueColor: AlwaysStoppedAnimation(color),
              borderRadius: BorderRadius.circular(4),
            ),
          ] else
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: color),
            ),
        ],
      ),
    );
  }

  Widget _buildChakraBalance(BuildContext context, Map<Chakra, int> alignment) {
    // Find strongest and weakest chakras
    final sortedChakras = alignment.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final strongest = sortedChakras.first;
    final weakest = sortedChakras.last;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Intro text
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.auroraStart.withAlpha(15),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              border: Border.all(color: AppColors.auroraStart.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.auroraStart,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Chakralar bedenindeki enerji merkezleridir. Her biri farklı yaşam alanlarını yönetir.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Visual chakra spine representation
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chakra spine visualization
              SizedBox(
                width: 60,
                child: Column(
                  children: Chakra.values.reversed.map((chakra) {
                    final value = alignment[chakra] ?? 50;
                    final isStrong = value >= 80;
                    final isWeak = value < 60;
                    return _buildChakraSpineNode(
                      context,
                      chakra,
                      value,
                      isStrong,
                      isWeak,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              // Chakra details
              Expanded(
                child: Column(
                  children: Chakra.values.reversed.map((chakra) {
                    final value = alignment[chakra] ?? 50;
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppConstants.spacingMd,
                      ),
                      child: _buildChakraDetailRow(context, chakra, value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Analysis cards
          Row(
            children: [
              Expanded(
                child: _buildChakraAnalysisCard(
                  context,
                  'En Güçlü',
                  strongest.key,
                  strongest.value,
                  Icons.arrow_upward,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: _buildChakraAnalysisCard(
                  context,
                  'Dengelenmeli',
                  weakest.key,
                  weakest.value,
                  Icons.arrow_downward,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Recommendation
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [weakest.key.color.withAlpha(30), Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              border: Border.all(color: weakest.key.color.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.healing, color: weakest.key.color, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Dengeleme Tavsiyesi',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: weakest.key.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _getChakraBalancingAdvice(weakest.key),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: weakest.key.color.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Mantra: ${weakest.key.mantras}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: weakest.key.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChakraSpineNode(
    BuildContext context,
    Chakra chakra,
    int value,
    bool isStrong,
    bool isWeak,
  ) {
    final size = isStrong ? 28.0 : (isWeak ? 20.0 : 24.0);

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [chakra.color, chakra.color.withAlpha(150)],
            ),
            boxShadow: [
              BoxShadow(
                color: chakra.color.withAlpha(isStrong ? 150 : 80),
                blurRadius: isStrong ? 12 : 6,
                spreadRadius: isStrong ? 2 : 0,
              ),
            ],
            border: isStrong
                ? Border.all(color: Colors.white.withAlpha(100), width: 2)
                : null,
          ),
          child: isStrong
              ? Icon(Icons.star, color: Colors.white, size: 14)
              : null,
        ),
        if (chakra != Chakra.root)
          Container(
            width: 3,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  chakra.color.withAlpha(100),
                  _getPreviousChakra(chakra).color.withAlpha(100),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Chakra _getPreviousChakra(Chakra chakra) {
    final index = Chakra.values.indexOf(chakra);
    return index > 0 ? Chakra.values[index - 1] : chakra;
  }

  Widget _buildChakraDetailRow(BuildContext context, Chakra chakra, int value) {
    final status = value >= 80 ? 'Aktif' : (value >= 60 ? 'Dengeli' : 'Zayıf');
    final statusColor = value >= 80
        ? AppColors.success
        : (value >= 60 ? AppColors.starGold : AppColors.warning);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: chakra.color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: chakra.color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chakra.nameTr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: chakra.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getChakraArea(chakra),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$value% $status',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: chakra.color.withAlpha(30),
              valueColor: AlwaysStoppedAnimation(chakra.color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChakraAnalysisCard(
    BuildContext context,
    String label,
    Chakra chakra,
    int value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [chakra.color.withAlpha(40), chakra.color.withAlpha(15)],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: chakra.color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: chakra.color, size: 14),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: chakra.color,
              boxShadow: [
                BoxShadow(color: chakra.color.withAlpha(100), blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            chakra.nameTr,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: chakra.color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '$value%',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  String _getChakraArea(Chakra chakra) {
    switch (chakra) {
      case Chakra.root:
        return 'Güvenlik, Hayatta Kalma';
      case Chakra.sacral:
        return 'Yaratıcılık, Duygular';
      case Chakra.solarPlexus:
        return 'Güç, Özgüven';
      case Chakra.heart:
        return 'Sevgi, Bağlantı';
      case Chakra.throat:
        return 'İletişim, İfade';
      case Chakra.thirdEye:
        return 'Sezgi, Bilgelik';
      case Chakra.crown:
        return 'Spiritüellik, Bilinç';
    }
  }

  String _getChakraBalancingAdvice(Chakra chakra) {
    switch (chakra) {
      case Chakra.root:
        return 'Doğada yürüyüş yapın, kırmızı giyinin. Topraklanma meditasyonları ve fiziksel egzersizler bu chakrayı güçlendirir.';
      case Chakra.sacral:
        return 'Yaratıcı aktiviteler yapın, dans edin. Turuncu renkli yiyecekler tüketin ve su elementine yakın olun.';
      case Chakra.solarPlexus:
        return 'Güneş ışığında vakit geçirin. Nefes egzersizleri yapın ve kendinize pozitif olumlamalar söyleyin.';
      case Chakra.heart:
        return 'Sevdiklerinizle zaman geçirin. Şükran günlüğü tutun ve yeşil alanlarla vakit geçirin.';
      case Chakra.throat:
        return 'Duygularınızı ifade edin, şarkı söyleyin. Mavi tonlarda giyinin ve bol su için.';
      case Chakra.thirdEye:
        return 'Meditasyon yapın ve rüyalarınızı kaydedin. Mor/çivit renklerine odaklanın.';
      case Chakra.crown:
        return 'Sessizlikte vakit geçirin, meditasyon yapın. Beyaz veya mor giyin ve doğayla bağlantı kurun.';
    }
  }

  Widget _buildDailyEnergyCard(BuildContext context, DailyAuraEnergy energy) {
    final todayColor = energy.todayAura.color;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [todayColor.withAlpha(50), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: todayColor.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [todayColor, todayColor.withAlpha(100)],
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bugünün Aura Enerjisi',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      energy.todayAura.nameTr,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: todayColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: todayColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${energy.energyLevel}%',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: todayColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            energy.guidance,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: todayColor.withAlpha(25),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.format_quote, color: todayColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Günlük Olumlamanız',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: todayColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  energy.affirmation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleansingTip(
    BuildContext context,
    AuraCleansingTip tip,
    AuraColor aura,
  ) {
    final color = aura.color;

    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'meditation':
          return Icons.self_improvement;
        case 'crystal':
          return Icons.diamond;
        case 'color':
          return Icons.palette;
        case 'nature':
          return Icons.nature;
        case 'sound':
          return Icons.music_note;
        default:
          return Icons.auto_awesome;
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(getIcon(tip.icon), color: color, size: 20),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
    );
  }
}
