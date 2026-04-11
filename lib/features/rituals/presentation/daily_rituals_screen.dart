import 'dart:math';
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

/// Daily Rituals & Meditation Screen
/// Personalized spiritual practices based on moon phase, zodiac sign, and planetary influences
class DailyRitualsScreen extends ConsumerStatefulWidget {
  const DailyRitualsScreen({super.key});

  @override
  ConsumerState<DailyRitualsScreen> createState() => _DailyRitualsScreenState();
}

class _DailyRitualsScreenState extends ConsumerState<DailyRitualsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DailyRitualData _ritualData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _generateRituals();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _generateRituals() {
    final userProfile = ref.read(userProfileProvider);
    final sign = userProfile?.sunSign ?? ZodiacSign.aries;
    final moonPhase = MoonService.getCurrentPhase();
    final moonSign = MoonService.getCurrentMoonSign();

    _ritualData = DailyRitualsService.generate(
      sunSign: sign,
      moonPhase: moonPhase,
      moonSign: moonSign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final sign = userProfile?.sunSign ?? ZodiacSign.aries;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, sign),
              _buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMorningRitual(context),
                    _buildMeditationTab(context),
                    _buildAffirmationsTab(context),
                    _buildEveningRitual(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ZodiacSign sign) {
    final moonPhase = MoonService.getCurrentPhase();

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gunluk Rituel & Meditasyon',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${sign.nameTr} ',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: sign.color),
                    ),
                    Text(sign.symbol, style: TextStyle(color: sign.color)),
                    Text(
                      ' • ${moonPhase.emoji} ${moonPhase.nameTr}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.auroraStart.withAlpha(60),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        labelColor: AppColors.auroraStart,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Sabah'),
          Tab(text: 'Meditasyon'),
          Tab(text: 'Olumlama'),
          Tab(text: 'Aksam'),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 300.ms);
  }

  Widget _buildMorningRitual(BuildContext context) {
    final ritual = _ritualData.morningRitual;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRitualHeader(
            context,
            icon: Icons.wb_sunny,
            title: 'Sabah Ritueli',
            subtitle: 'Gune pozitif enerji ile basla',
            color: Colors.orange,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildTimeCard(context, ritual.bestTime, 'En Uygun Saat'),
          const SizedBox(height: AppConstants.spacingMd),
          _buildIntentionCard(context, ritual.intention),
          const SizedBox(height: AppConstants.spacingMd),
          _buildStepsSection(context, ritual.steps),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCrystalCard(context, ritual.crystalSuggestion),
          const SizedBox(height: AppConstants.spacingMd),
          _buildEssentialOilCard(context, ritual.essentialOil),
          const SizedBox(height: AppConstants.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildMeditationTab(BuildContext context) {
    final meditation = _ritualData.meditation;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRitualHeader(
            context,
            icon: Icons.self_improvement,
            title: 'Gunun Meditasyonu',
            subtitle: 'Ic huzuru bul',
            color: AppColors.auroraStart,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildMeditationTypeCard(context, meditation),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDurationSelector(context, meditation.recommendedDuration),
          const SizedBox(height: AppConstants.spacingMd),
          _buildMeditationGuide(context, meditation),
          const SizedBox(height: AppConstants.spacingMd),
          _buildBreathingExercise(context, meditation.breathingPattern),
          const SizedBox(height: AppConstants.spacingMd),
          _buildChakraFocus(context, meditation.chakraFocus),
          const SizedBox(height: AppConstants.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildAffirmationsTab(BuildContext context) {
    final affirmations = _ritualData.affirmations;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRitualHeader(
            context,
            icon: Icons.format_quote,
            title: 'Günün Olumlamaları',
            subtitle: 'Pozitif düşüncelerle güçlen',
            color: AppColors.starGold,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildMainAffirmation(context, affirmations.mainAffirmation),
          const SizedBox(height: AppConstants.spacingMd),
          _buildAffirmationList(
            context,
            'Sabah Olumlamalari',
            affirmations.morningAffirmations,
            Colors.orange,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildAffirmationList(
            context,
            'Ogle Olumlamalari',
            affirmations.noonAffirmations,
            AppColors.starGold,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildAffirmationList(
            context,
            'Aksam Olumlamalari',
            affirmations.eveningAffirmations,
            AppColors.auroraStart,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildAffirmationTips(context),
          const SizedBox(height: AppConstants.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildEveningRitual(BuildContext context) {
    final ritual = _ritualData.eveningRitual;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRitualHeader(
            context,
            icon: Icons.nightlight_round,
            title: 'Aksam Ritueli',
            subtitle: 'Gunu huzurla tamamla',
            color: AppColors.auroraEnd,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildTimeCard(context, ritual.bestTime, 'En Uygun Saat'),
          const SizedBox(height: AppConstants.spacingMd),
          _buildReflectionCard(context, ritual.reflectionPrompts),
          const SizedBox(height: AppConstants.spacingMd),
          _buildGratitudeSection(context, ritual.gratitudePrompts),
          const SizedBox(height: AppConstants.spacingMd),
          _buildReleasingRitual(context, ritual.releasingRitual),
          const SizedBox(height: AppConstants.spacingMd),
          _buildSleepPreparation(context, ritual.sleepPreparation),
          const SizedBox(height: AppConstants.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildRitualHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withAlpha(30), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildTimeCard(BuildContext context, String time, String label) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, color: AppColors.starGold, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntentionCard(BuildContext context, String intention) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.starGold.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Gunun Niyeti',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '"$intention"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsSection(BuildContext context, List<RitualStep> steps) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rituel Adimlari',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.auroraStart.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.auroraStart,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          step.description,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        Text(
                          '${step.durationMinutes} dakika',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCrystalCard(BuildContext context, CrystalSuggestion crystal) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.purple.withAlpha(40)),
      ),
      child: Row(
        children: [
          Text(crystal.emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Onerilen Kristal',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
                Text(
                  crystal.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  crystal.benefit,
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

  Widget _buildEssentialOilCard(
    BuildContext context,
    EssentialOilSuggestion oil,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.green.withAlpha(40)),
      ),
      child: Row(
        children: [
          Text(oil.emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Onerilen Esansiyel Yag',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
                Text(
                  oil.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  oil.usage,
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

  Widget _buildMeditationTypeCard(
    BuildContext context,
    MeditationData meditation,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
                child: Text(
                  meditation.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meditation.type,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.auroraStart,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      meditation.focus,
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
          Text(
            meditation.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSelector(BuildContext context, int minutes) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Onerilen Sure',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.auroraStart.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: AppColors.auroraStart, size: 18),
                const SizedBox(width: 6),
                Text(
                  '$minutes dakika',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.auroraStart,
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

  Widget _buildMeditationGuide(
    BuildContext context,
    MeditationData meditation,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meditasyon Rehberi',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...meditation.steps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.auroraStart.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.auroraStart,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBreathingExercise(
    BuildContext context,
    BreathingPattern pattern,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.blue.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.air, color: Colors.blue, size: 24),
              const SizedBox(width: 8),
              Text(
                'Nefes Egzersizi: ${pattern.name}',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBreathPhase(
                context,
                'Nefes Al',
                '${pattern.inhaleSeconds}s',
                Colors.blue,
              ),
              _buildBreathPhase(
                context,
                'Tut',
                '${pattern.holdSeconds}s',
                Colors.purple,
              ),
              _buildBreathPhase(
                context,
                'Ver',
                '${pattern.exhaleSeconds}s',
                Colors.teal,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '${pattern.cycles} kez tekrarla',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBreathPhase(
    BuildContext context,
    String label,
    String duration,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              duration,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildChakraFocus(BuildContext context, ChakraInfo chakra) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [chakra.color.withAlpha(30), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: chakra.color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: chakra.color.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(chakra.symbol, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Odaklanilacak Cakra',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
                Text(
                  chakra.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: chakra.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  chakra.focus,
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

  Widget _buildMainAffirmation(BuildContext context, String affirmation) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.starGold.withAlpha(30),
            AppColors.auroraStart.withAlpha(20),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.starGold.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: AppColors.starGold, size: 40),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            affirmation,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Gunun Ana Olumlamasi',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.starGold),
          ),
        ],
      ),
    );
  }

  Widget _buildAffirmationList(
    BuildContext context,
    String title,
    List<String> affirmations,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...affirmations.map(
            (aff) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star, color: color, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      aff,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAffirmationTips(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Olumlama Ipuclari',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildTipItem(context, 'Olumlamaları yüksek sesle söyleyin'),
          _buildTipItem(context, 'Aynaya bakarak tekrarlayın'),
          _buildTipItem(context, 'Duyguyu hissedin, sadece kelime değil'),
          _buildTipItem(context, 'Günde en az 3 kez tekrarlayın'),
        ],
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.starGold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            tip,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionCard(BuildContext context, List<String> prompts) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: AppColors.auroraEnd, size: 20),
              const SizedBox(width: 8),
              Text(
                'Gun Sonu Yansimasi',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.auroraEnd),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...prompts.map(
            (prompt) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.help_outline,
                    color: AppColors.textMuted,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      prompt,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGratitudeSection(BuildContext context, List<String> prompts) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.pink.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.pink, size: 20),
              const SizedBox(width: 8),
              Text(
                'Sukran Pratiği',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.pink),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Bu gun icin sukran duydugun 3 seyi yaz:',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...prompts.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '${entry.key + 1}.',
                      style: TextStyle(color: Colors.pink),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReleasingRitual(BuildContext context, ReleasingRitual ritual) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.waves, color: AppColors.auroraEnd, size: 20),
              const SizedBox(width: 8),
              Text(
                'Birakma Ritueli',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.auroraEnd),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            ritual.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Birak:',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ritual.thingsToRelease.map((thing) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(20),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  thing,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.red),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepPreparation(BuildContext context, SleepPreparation prep) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.withAlpha(20), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.indigo.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bedtime, color: Colors.indigo, size: 20),
              const SizedBox(width: 8),
              Text(
                'Uyku Hazirligi',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.indigo),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...prep.steps.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key + 1}.',
                    style: TextStyle(color: Colors.indigo),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.format_quote, color: Colors.indigo, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"${prep.sleepAffirmation}"',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
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
}

// ==================== Data Classes ====================

class DailyRitualData {
  final MorningRitual morningRitual;
  final MeditationData meditation;
  final AffirmationsData affirmations;
  final EveningRitual eveningRitual;

  DailyRitualData({
    required this.morningRitual,
    required this.meditation,
    required this.affirmations,
    required this.eveningRitual,
  });
}

class MorningRitual {
  final String bestTime;
  final String intention;
  final List<RitualStep> steps;
  final CrystalSuggestion crystalSuggestion;
  final EssentialOilSuggestion essentialOil;

  MorningRitual({
    required this.bestTime,
    required this.intention,
    required this.steps,
    required this.crystalSuggestion,
    required this.essentialOil,
  });
}

class RitualStep {
  final String title;
  final String description;
  final int durationMinutes;

  RitualStep({
    required this.title,
    required this.description,
    required this.durationMinutes,
  });
}

class CrystalSuggestion {
  final String name;
  final String emoji;
  final String benefit;

  CrystalSuggestion({
    required this.name,
    required this.emoji,
    required this.benefit,
  });
}

class EssentialOilSuggestion {
  final String name;
  final String emoji;
  final String usage;

  EssentialOilSuggestion({
    required this.name,
    required this.emoji,
    required this.usage,
  });
}

class MeditationData {
  final String type;
  final String emoji;
  final String focus;
  final String description;
  final int recommendedDuration;
  final List<String> steps;
  final BreathingPattern breathingPattern;
  final ChakraInfo chakraFocus;

  MeditationData({
    required this.type,
    required this.emoji,
    required this.focus,
    required this.description,
    required this.recommendedDuration,
    required this.steps,
    required this.breathingPattern,
    required this.chakraFocus,
  });
}

class BreathingPattern {
  final String name;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int cycles;

  BreathingPattern({
    required this.name,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.cycles,
  });
}

class ChakraInfo {
  final String name;
  final String symbol;
  final Color color;
  final String focus;

  ChakraInfo({
    required this.name,
    required this.symbol,
    required this.color,
    required this.focus,
  });
}

class AffirmationsData {
  final String mainAffirmation;
  final List<String> morningAffirmations;
  final List<String> noonAffirmations;
  final List<String> eveningAffirmations;

  AffirmationsData({
    required this.mainAffirmation,
    required this.morningAffirmations,
    required this.noonAffirmations,
    required this.eveningAffirmations,
  });
}

class EveningRitual {
  final String bestTime;
  final List<String> reflectionPrompts;
  final List<String> gratitudePrompts;
  final ReleasingRitual releasingRitual;
  final SleepPreparation sleepPreparation;

  EveningRitual({
    required this.bestTime,
    required this.reflectionPrompts,
    required this.gratitudePrompts,
    required this.releasingRitual,
    required this.sleepPreparation,
  });
}

class ReleasingRitual {
  final String description;
  final List<String> thingsToRelease;

  ReleasingRitual({required this.description, required this.thingsToRelease});
}

class SleepPreparation {
  final List<String> steps;
  final String sleepAffirmation;

  SleepPreparation({required this.steps, required this.sleepAffirmation});
}

// ==================== Service ====================

class DailyRitualsService {
  static DailyRitualData generate({
    required ZodiacSign sunSign,
    required MoonPhase moonPhase,
    required MoonSign moonSign,
  }) {
    final seed = DateTime.now().day + sunSign.index + moonPhase.index;
    final random = Random(seed);

    return DailyRitualData(
      morningRitual: _generateMorningRitual(sunSign, moonPhase, random),
      meditation: _generateMeditation(sunSign, moonSign, random),
      affirmations: _generateAffirmations(sunSign, moonPhase),
      eveningRitual: _generateEveningRitual(sunSign, moonPhase, random),
    );
  }

  static MorningRitual _generateMorningRitual(
    ZodiacSign sign,
    MoonPhase moonPhase,
    Random random,
  ) {
    final crystals = [
      CrystalSuggestion(
        name: 'Ametist',
        emoji: '💜',
        benefit: 'Ic huzur ve sezgi',
      ),
      CrystalSuggestion(
        name: 'Sitrin',
        emoji: '💛',
        benefit: 'Bolluk ve pozitif enerji',
      ),
      CrystalSuggestion(
        name: 'Gul Kuvars',
        emoji: '💗',
        benefit: 'Ask ve kendini sevme',
      ),
      CrystalSuggestion(
        name: 'Kaplan Gozu',
        emoji: '🧡',
        benefit: 'Cesaret ve odaklanma',
      ),
      CrystalSuggestion(
        name: 'Aventurin',
        emoji: '💚',
        benefit: 'Sans ve firsatlar',
      ),
      CrystalSuggestion(
        name: 'Lapis Lazuli',
        emoji: '💙',
        benefit: 'Bilgelik ve gercek',
      ),
    ];

    final oils = [
      EssentialOilSuggestion(
        name: 'Lavanta',
        emoji: '💜',
        usage: 'Huzur icin birkaç damla yayin',
      ),
      EssentialOilSuggestion(
        name: 'Limon',
        emoji: '🍋',
        usage: 'Canlandirici sabah enerjisi',
      ),
      EssentialOilSuggestion(
        name: 'Nane',
        emoji: '🌿',
        usage: 'Zihinsel berraklik icin',
      ),
      EssentialOilSuggestion(
        name: 'Portakal',
        emoji: '🍊',
        usage: 'Mutluluk ve neşe icin',
      ),
      EssentialOilSuggestion(
        name: 'Okaliptus',
        emoji: '🌲',
        usage: 'Temizlik ve yenilenme',
      ),
    ];

    final intentions = {
      ZodiacSign.aries: 'Bugün cesaretle yeni başlangıçlar yapıyorum.',
      ZodiacSign.taurus: 'Bugün bolluğu ve güvenliği çekiyorum.',
      ZodiacSign.gemini: 'Bugün merakımla dünyayı keşfediyorum.',
      ZodiacSign.cancer: 'Bugün sevdiklerime şefkat sunuyorum.',
      ZodiacSign.leo: 'Bugün ışığımı parlak bir şekilde paylaşıyorum.',
      ZodiacSign.virgo: 'Bugün detaylarda mükemmelliği buluyorum.',
      ZodiacSign.libra: 'Bugün denge ve uyum yaratıyorum.',
      ZodiacSign.scorpio: 'Bugün derinlere dalıyor, dönüşüyorum.',
      ZodiacSign.sagittarius: 'Bugün özgürce keşfediyor ve büyüyorum.',
      ZodiacSign.capricorn: 'Bugün hedeflerime kararlılıkla ilerliyorum.',
      ZodiacSign.aquarius: 'Bugün benzersizliğimi kutluyorum.',
      ZodiacSign.pisces: 'Bugün sezgilerimle akışta kalıyorum.',
    };

    return MorningRitual(
      bestTime: '06:00 - 08:00',
      intention: intentions[sign] ?? 'Bugün en iyi versiyonum oluyorum.',
      steps: [
        RitualStep(
          title: 'Uyanis Nefesi',
          description:
              'Yatakta uzanırken 3 derin nefes alın. Her nefeste vücudunuzu uyanmaya davet edin.',
          durationMinutes: 2,
        ),
        RitualStep(
          title: 'Niyet Belirleme',
          description: 'Günün niyetinizi yüksek sesle söyleyin veya yazın.',
          durationMinutes: 3,
        ),
        RitualStep(
          title: 'Vücut Uyandırma',
          description:
              'Hafif esnemeler ve dönüşlerle vücudu nazikçe harekete geçirin.',
          durationMinutes: 5,
        ),
        RitualStep(
          title: 'Sukran Anı',
          description: 'Yeni bir güne uyanmış olduğunuz için teşekkür edin.',
          durationMinutes: 2,
        ),
      ],
      crystalSuggestion: crystals[random.nextInt(crystals.length)],
      essentialOil: oils[random.nextInt(oils.length)],
    );
  }

  static MeditationData _generateMeditation(
    ZodiacSign sunSign,
    MoonSign moonSign,
    Random random,
  ) {
    final meditations = [
      MeditationData(
        type: 'Nefes Meditasyonu',
        emoji: '🌬️',
        focus: 'Nefese odaklanma',
        description:
            'Nefes meditasyonu, zihni sakinleştirmenin en etkili yoludur. Bugün sadece nefesinize odaklanarak iç huzuru bulun.',
        recommendedDuration: 15,
        steps: [
          'Rahat bir pozisyonda oturun veya uzanın',
          'Gözlerinizi yavaşça kapatın',
          'Nefesinizi izlemeye başlayın',
          'Düşünceler geldiğinde nazikçe nefese dönün',
          'Vücudunuzun gevşediğini hissedin',
        ],
        breathingPattern: BreathingPattern(
          name: '4-7-8 Nefes',
          inhaleSeconds: 4,
          holdSeconds: 7,
          exhaleSeconds: 8,
          cycles: 4,
        ),
        chakraFocus: ChakraInfo(
          name: 'Kalp Çakrası',
          symbol: '💚',
          color: Colors.green,
          focus: 'Şefkat ve sevgi',
        ),
      ),
      MeditationData(
        type: 'Body Scan',
        emoji: '🧘',
        focus: 'Vücut farkındalığı',
        description:
            'Vücut taraması meditasyonu ile bedeninizle bağlantı kurun ve gerginlikleri fark edin.',
        recommendedDuration: 20,
        steps: [
          'Sırt üstü uzanın',
          'Ayak parmaklarınızdan başlayın',
          'Her bölgeye dikkat verin ve gevşetin',
          'Yavaşça yukarı doğru ilerleyin',
          'Tüm vücudu bir bütün olarak hissedin',
        ],
        breathingPattern: BreathingPattern(
          name: 'Doğal Nefes',
          inhaleSeconds: 4,
          holdSeconds: 0,
          exhaleSeconds: 6,
          cycles: 10,
        ),
        chakraFocus: ChakraInfo(
          name: 'Kök Çakra',
          symbol: '🔴',
          color: Colors.red,
          focus: 'Topraklanma ve güvenlik',
        ),
      ),
      MeditationData(
        type: 'Sevgi-Şefkat',
        emoji: '💕',
        focus: 'Metta meditasyonu',
        description:
            'Kendinize ve başkalarına şefkat göndererek kalp merkezinizi açın.',
        recommendedDuration: 15,
        steps: [
          'Rahatça oturun ve gözlerinizi kapatın',
          'Önce kendinize sevgi gönderin',
          'Sevdiğiniz birine sevgi gönderin',
          'Tanımadığınız birine sevgi gönderin',
          'Tüm varlıklara sevgi gönderin',
        ],
        breathingPattern: BreathingPattern(
          name: 'Kalp Nefesi',
          inhaleSeconds: 4,
          holdSeconds: 4,
          exhaleSeconds: 4,
          cycles: 6,
        ),
        chakraFocus: ChakraInfo(
          name: 'Kalp Çakrası',
          symbol: '💚',
          color: Colors.green,
          focus: 'Koşulsuz sevgi',
        ),
      ),
      MeditationData(
        type: 'Görselleştirme',
        emoji: '🌟',
        focus: 'Hayal gücü',
        description:
            'Zihinsel görselleştirme ile hedeflerinizi ve hayallerinizi canlandırın.',
        recommendedDuration: 20,
        steps: [
          'Rahat bir pozisyon alın',
          'Gözlerinizi kapatın ve gevşeyin',
          'Hedefinizi net bir şekilde hayal edin',
          'Tüm duyularınızla deneyimleyin',
          'Bu gerçekliği kabul edin ve minnet duyun',
        ],
        breathingPattern: BreathingPattern(
          name: 'Yaratıcı Nefes',
          inhaleSeconds: 5,
          holdSeconds: 3,
          exhaleSeconds: 5,
          cycles: 5,
        ),
        chakraFocus: ChakraInfo(
          name: 'Üçüncü Göz',
          symbol: '💜',
          color: Colors.indigo,
          focus: 'Sezgi ve vizyon',
        ),
      ),
    ];

    return meditations[random.nextInt(meditations.length)];
  }

  static AffirmationsData _generateAffirmations(
    ZodiacSign sign,
    MoonPhase moonPhase,
  ) {
    final mainAffirmations = {
      ZodiacSign.aries: 'Ben cesur, güçlü ve kararlıyım.',
      ZodiacSign.taurus: 'Bolluk ve bereket bana doğru akıyor.',
      ZodiacSign.gemini: 'Her gün yeni bilgiler ve bağlantılar çekiyorum.',
      ZodiacSign.cancer:
          'Duygusal güvenliğim sağlam, sevgi veriyorum ve alıyorum.',
      ZodiacSign.leo: 'Işığım parlak, yaratıcılığım sınırsız.',
      ZodiacSign.virgo: 'Mükemmellik değil, ilerleme önemli.',
      ZodiacSign.libra: 'Hayatımda denge ve uyum yaratıyorum.',
      ZodiacSign.scorpio: 'Dönüşümü kucaklıyorum, her gün yeniden doğuyorum.',
      ZodiacSign.sagittarius: 'Özgürce keşfediyorum, hayat bir maceradır.',
      ZodiacSign.capricorn: 'Hedeflerime kararlılıkla ilerliyorum.',
      ZodiacSign.aquarius: 'Benzersizliğim dünyaya armağanımdır.',
      ZodiacSign.pisces: 'Sezgilerime güveniyorum, evrenle akışta kalıyorum.',
    };

    return AffirmationsData(
      mainAffirmation: mainAffirmations[sign] ?? 'Ben değerli ve yeteriyim.',
      morningAffirmations: [
        'Bugün harika şeyler olacak.',
        'Enerjim yüksek ve odağım net.',
        'Tüm fırsatlara açığım.',
      ],
      noonAffirmations: [
        'İlerliyorum ve büyüyorum.',
        'Zorluklarla başa çıkabilecek güçteyim.',
        'Şu an mükemmel bir andır.',
      ],
      eveningAffirmations: [
        'Bugün için teşekkür ederim.',
        'Yarın için hazırım.',
        'Huzurla dinlenmeyi hak ediyorum.',
      ],
    );
  }

  static EveningRitual _generateEveningRitual(
    ZodiacSign sign,
    MoonPhase moonPhase,
    Random random,
  ) {
    return EveningRitual(
      bestTime: '21:00 - 22:00',
      reflectionPrompts: [
        'Bugün neyi başardım?',
        'Ne öğrendim?',
        'Yarın neyi farklı yapmak isterim?',
      ],
      gratitudePrompts: [
        'Hayatımdaki bir kişi',
        'Bugün yaşadığım bir deneyim',
        'Sahip olduğum bir şey',
      ],
      releasingRitual: ReleasingRitual(
        description:
            'Günün stresini ve olumsuz enerjileri bilinçli olarak bırakın. Her nefesinizde gitmesine izin verin.',
        thingsToRelease: [
          'Günün stresi',
          'Endişeler',
          'Yarıda kalan işler',
          'Olumsuz düşünceler',
        ],
      ),
      sleepPreparation: SleepPreparation(
        steps: [
          'Elektronik cihazları kapatın',
          'Odayı karartın ve serinletin',
          'Rahat bir pozisyon alın',
          'Nefeslerinizi yavaşlatın',
          'Vücudunuzu gevşetin',
        ],
        sleepAffirmation: 'Huzurla uyuyorum, yarın için yenileniyorum.',
      ),
    );
  }
}
