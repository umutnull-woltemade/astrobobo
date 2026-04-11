import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/natal_chart.dart';
import '../../../data/models/planet.dart';
import '../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../data/services/ephemeris_service.dart';
import '../../../data/services/esoteric_interpretation_service.dart';
import '../../../data/services/ad_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/pdf_report_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/ad_banner_widget.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';
import 'widgets/planet_positions_card.dart';
import 'widgets/houses_card.dart';
import 'widgets/aspects_card.dart';
import 'widgets/chart_summary_card.dart';
import 'widgets/natal_chart_wheel.dart';

class NatalChartScreen extends ConsumerStatefulWidget {
  const NatalChartScreen({super.key});

  @override
  ConsumerState<NatalChartScreen> createState() => _NatalChartScreenState();
}

class _NatalChartScreenState extends ConsumerState<NatalChartScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NatalChart? _natalChart;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _calculateChart();
  }

  void _calculateChart() {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile != null) {
      final birthData = BirthData(
        date: userProfile.birthDate,
        time: userProfile.birthTime,
        latitude: userProfile.birthLatitude,
        longitude: userProfile.birthLongitude,
        placeName: userProfile.birthPlace,
      );
      final natalChart = EphemerisService.calculateNatalChart(birthData);
      setState(() {
        _natalChart = natalChart;
      });

      // Save calculated rising sign and moon sign to user profile if not already set
      // Using Future.microtask to avoid modifying provider during widget build
      if (userProfile.risingSign == null || userProfile.moonSign == null) {
        final ascendant = natalChart.ascendant;
        final moon = natalChart.moon;

        if (ascendant != null || moon != null) {
          Future.microtask(() {
            final updatedProfile = userProfile.copyWith(
              risingSign: userProfile.risingSign ?? ascendant?.sign,
              moonSign: userProfile.moonSign ?? moon?.sign,
            );
            ref.read(userProfileProvider.notifier).setProfile(updatedProfile);
            // Also persist to storage
            StorageService.saveUserProfile(updatedProfile);
          });
        }
      }

      // Show interstitial ad after chart calculation
      _showPostAnalysisAd();
    }
  }

  Future<void> _showPostAnalysisAd() async {
    final adService = ref.read(adServiceProvider);
    await adService.showInterstitialAfterAnalysis();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);

    if (userProfile == null) {
      return const Scaffold(body: Center(child: Text('Profil bulunamadı')));
    }

    if (_natalChart == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColors.starGold),
                const SizedBox(height: 16),
                Text(
                  'Kozmik haritanız çözümleniyor...',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gezegenler konumlarını fısıldıyor ✨',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, userProfile.name),
              _buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOverviewTab(),
                    _buildPlanetsTab(),
                    _buildHousesTab(),
                    _buildAspectsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String? name) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doğum Haritası',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: isDark ? AppColors.starGold : colorScheme.primary,
                  ),
                ),
                if (name != null)
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
              ],
            ),
          ),
          // PDF Export Button
          IconButton(
            onPressed: () => _showExportOptions(context),
            icon: Icon(
              Icons.picture_as_pdf_outlined,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
            tooltip: 'PDF Raporu',
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceLight.withAlpha(128)
                  : _natalChart!.sunSign.color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: isDark
                  ? null
                  : Border.all(
                      color: _natalChart!.sunSign.color.withOpacity(0.3),
                      width: 2,
                    ),
            ),
            child: Text(
              _natalChart!.sunSign.symbol,
              style: TextStyle(fontSize: 24, color: _natalChart!.sunSign.color),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  void _showExportOptions(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.lightCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.textMuted : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Raporu Disa Aktar',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildExportOption(
              context,
              icon: Icons.visibility_outlined,
              title: 'Onizle',
              subtitle: 'PDF raporunu goruntule',
              onTap: () => _previewPdf(context),
            ),
            const SizedBox(height: 12),
            _buildExportOption(
              context,
              icon: Icons.share_outlined,
              title: 'Paylas',
              subtitle: 'PDF olarak paylas',
              onTap: () => _sharePdf(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceLight.withOpacity(0.1)
              : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? AppColors.surfaceLight.withOpacity(0.2)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.starGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.starGold, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _previewPdf(BuildContext context) async {
    Navigator.pop(context); // Close bottom sheet
    _showLoadingDialog(context);

    try {
      final userProfile = ref.read(userProfileProvider);
      if (userProfile == null || _natalChart == null) return;

      // Convert planet positions to the expected format
      final planetPositions = <Planet, zodiac.ZodiacSign>{};
      final planetHouses = <Planet, int>{};
      for (final position in _natalChart!.planets) {
        planetPositions[position.planet] = position.sign;
        planetHouses[position.planet] = position.house;
      }

      final pdfService = PdfReportService();
      final pdfData = await pdfService.generateBirthChartReport(
        profile: userProfile,
        planetPositions: planetPositions,
        planetHouses: planetHouses,
        ascendant: _natalChart!.ascendant?.sign,
        moonSign: _natalChart!.moon?.sign,
      );

      if (context.mounted) Navigator.pop(context); // Close loading dialog

      await pdfService.previewPdf(pdfData);
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog
        _showErrorSnackBar(context, 'PDF olusturulamadi');
      }
    }
  }

  Future<void> _sharePdf(BuildContext context) async {
    Navigator.pop(context); // Close bottom sheet
    _showLoadingDialog(context);

    try {
      final userProfile = ref.read(userProfileProvider);
      if (userProfile == null || _natalChart == null) return;

      // Convert planet positions to the expected format
      final planetPositions = <Planet, zodiac.ZodiacSign>{};
      final planetHouses = <Planet, int>{};
      for (final position in _natalChart!.planets) {
        planetPositions[position.planet] = position.sign;
        planetHouses[position.planet] = position.house;
      }

      final pdfService = PdfReportService();
      final pdfData = await pdfService.generateBirthChartReport(
        profile: userProfile,
        planetPositions: planetPositions,
        planetHouses: planetHouses,
        ascendant: _natalChart!.ascendant?.sign,
        moonSign: _natalChart!.moon?.sign,
      );

      if (context.mounted) Navigator.pop(context); // Close loading dialog

      final filename =
          'dogum_haritasi_${userProfile.name?.replaceAll(' ', '_') ?? 'rapor'}.pdf';
      await pdfService.sharePdf(pdfData, filename);
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog
        _showErrorSnackBar(context, 'PDF paylasilamadi');
      }
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.starGold),
                SizedBox(height: 16),
                Text('PDF olusturuluyor...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withAlpha(200)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.primary, colorScheme.secondary],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: isDark
            ? AppColors.textMuted
            : AppColors.lightTextMuted,
        labelStyle: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        splashBorderRadius: BorderRadius.circular(12),
        tabs: [
          _buildTab(context, Icons.auto_awesome, 'Özet'),
          _buildTab(context, Icons.public, 'Gezegenler'),
          _buildTab(context, Icons.home_outlined, 'Evler'),
          _buildTab(context, Icons.hub_outlined, 'Açılar'),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildTab(BuildContext context, IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Tab(icon: Icon(icon, size: 22), iconMargin: EdgeInsets.zero),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          // Esoteric intro
          _buildEsotericIntro(
            context,
            'Ruhunun Kozmik Haritası',
            'Bu harita, doğduğunda gökyüzünün bir an görüntüsüdür - ama bundan çok daha fazlası. Bu, ruhunun bu dünyaya getirdiği potansiyellerin, derslerin ve armağanların şifreli bir haritasıdır. Her gezegen bir iç ses, her burç bir enerji kalıbı, her ev bir yaşam alanıdır. Bu harita seni sınırlamaz - sana kim olduğunu hatırlatır.',
            AppColors.starGold,
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),
          ChartSummaryCard(chart: _natalChart!),
          const SizedBox(height: AppConstants.spacingLg),
          _buildBigThree(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedSunReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedMoonReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedRisingReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedMercuryReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedVenusReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPersonalizedMarsReading(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildDominants(),
          const SizedBox(height: AppConstants.spacingLg),
          _buildRetrogrades(),
          const SizedBox(height: AppConstants.spacingLg),
          // Ad Banner
          const InlineAdBanner(),
          const SizedBox(height: AppConstants.spacingLg),
          // Visual Chart Wheel - moved to bottom
          _buildChartWheelSection(),
          const SizedBox(height: AppConstants.spacingXl),
          // Quiz CTA - Google Discover Funnel
          QuizCTACard.astrology(compact: true),
          const SizedBox(height: AppConstants.spacingXl),
          // Next Blocks - Sonraki öneriler
          const NextBlocks(currentPage: 'natal_chart'),
          const SizedBox(height: AppConstants.spacingXl),
          // Entertainment Disclaimer
          const PageFooterWithDisclaimer(
            brandText: 'Doğum Haritası — Venus One',
            disclaimerText: DisclaimerTexts.astrology,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // Back-Button-Free Navigation
          const PageBottomNavigation(currentRoute: '/birth-chart'),
        ],
      ),
    );
  }

  Widget _buildPersonalizedSunReading() {
    final sun = _natalChart!.sun;
    if (sun == null) return const SizedBox.shrink();

    final interpretation = EsotericInterpretationService.getSunInterpretation(
      sun.sign,
    );

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sun.sign.color.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sun.sign.color.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sun.sign.color.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  sun.sign.symbol,
                  style: TextStyle(fontSize: 24, color: sun.sign.color),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Güneş Burcun: ${sun.sign.nameTr}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: sun.sign.color),
                    ),
                    Text(
                      'Özünün Sırrı',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildPersonalizedMoonReading() {
    final moon = _natalChart!.moon;
    if (moon == null) return const SizedBox.shrink();

    final interpretation = EsotericInterpretationService.getMoonInterpretation(
      moon.sign,
    );

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.moonSilver.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.moonSilver.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.moonSilver.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  moon.sign.symbol,
                  style: TextStyle(fontSize: 24, color: AppColors.moonSilver),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ay Burcun: ${moon.sign.nameTr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.moonSilver,
                      ),
                    ),
                    Text(
                      'Duygusal Dünyan',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildPersonalizedRisingReading() {
    final rising = _natalChart!.ascendant;
    if (rising == null) return const SizedBox.shrink();

    final interpretation =
        EsotericInterpretationService.getRisingInterpretation(rising.sign);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.fireElement.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.fireElement.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.fireElement.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  rising.sign.symbol,
                  style: TextStyle(fontSize: 24, color: AppColors.fireElement),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yükselen: ${rising.sign.nameTr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.fireElement,
                      ),
                    ),
                    Text(
                      'Dış İmajın & İlk İzlenim',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 450.ms, duration: 400.ms);
  }

  Widget _buildPersonalizedMercuryReading() {
    final mercury = _natalChart!.mercury;
    if (mercury == null) return const SizedBox.shrink();

    final interpretation =
        EsotericInterpretationService.getMercuryInterpretation(mercury.sign);
    // Only show house interpretation if houses were calculated (time & location provided)
    final houseInterp = _natalChart!.hasExactTime
        ? EsotericInterpretationService.getPlanetInHouseInterpretation(
            Planet.mercury,
            mercury.house,
          )
        : '';

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [mercury.planet.color.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: mercury.planet.color.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mercury.planet.color.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  mercury.planet.symbol,
                  style: TextStyle(fontSize: 24, color: mercury.planet.color),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merkür: ${mercury.sign.nameTr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: mercury.planet.color,
                      ),
                    ),
                    Text(
                      'Zihin & İletişim Tarzı',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (mercury.isRetrograde)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
          if (houseInterp.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingSm),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingSm),
              decoration: BoxDecoration(
                color: mercury.planet.color.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                houseInterp,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: mercury.planet.color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  Widget _buildPersonalizedVenusReading() {
    final venus = _natalChart!.venus;
    if (venus == null) return const SizedBox.shrink();

    final interpretation = EsotericInterpretationService.getVenusInterpretation(
      venus.sign,
    );
    // Only show house interpretation if houses were calculated (time & location provided)
    final houseInterp = _natalChart!.hasExactTime
        ? EsotericInterpretationService.getPlanetInHouseInterpretation(
            Planet.venus,
            venus.house,
          )
        : '';

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [venus.planet.color.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: venus.planet.color.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: venus.planet.color.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  venus.planet.symbol,
                  style: TextStyle(fontSize: 24, color: venus.planet.color),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venüs: ${venus.sign.nameTr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: venus.planet.color,
                      ),
                    ),
                    Text(
                      'Aşk & Değerler & Estetik',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (venus.isRetrograde)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
          if (houseInterp.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingSm),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingSm),
              decoration: BoxDecoration(
                color: venus.planet.color.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                houseInterp,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: venus.planet.color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 550.ms, duration: 400.ms);
  }

  Widget _buildPersonalizedMarsReading() {
    final mars = _natalChart!.mars;
    if (mars == null) return const SizedBox.shrink();

    final interpretation = EsotericInterpretationService.getMarsInterpretation(
      mars.sign,
    );
    // Only show house interpretation if houses were calculated (time & location provided)
    final houseInterp = _natalChart!.hasExactTime
        ? EsotericInterpretationService.getPlanetInHouseInterpretation(
            Planet.mars,
            mars.house,
          )
        : '';

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [mars.planet.color.withAlpha(38), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: mars.planet.color.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mars.planet.color.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  mars.planet.symbol,
                  style: TextStyle(fontSize: 24, color: mars.planet.color),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mars: ${mars.sign.nameTr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: mars.planet.color,
                      ),
                    ),
                    Text(
                      'İrade & Motivasyon & Enerji',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (mars.isRetrograde)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withAlpha(51),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
          if (houseInterp.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingSm),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingSm),
              decoration: BoxDecoration(
                color: mars.planet.color.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                houseInterp,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: mars.planet.color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildEsotericIntro(
    BuildContext context,
    String title,
    String text,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withAlpha(isDark ? 25 : 15),
            isDark ? Colors.transparent : AppColors.lightSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(isDark ? 51 : 40)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartWheelSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final accentColor = isDark ? AppColors.starGold : colorScheme.primary;

    return Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            gradient: isDark
                ? AppColors.cardGradient
                : AppColors.lightCardGradient,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(color: accentColor.withAlpha(isDark ? 76 : 50)),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.public, color: accentColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Doğum Haritası',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: accentColor),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Center(
                child: NatalChartWheel(
                  chart: _natalChart!,
                  showAspects: true,
                  showHouses: _natalChart!.hasExactTime,
                  size: MediaQuery.of(context).size.width - 80,
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              // Legend
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildLegendItem('Uyumlu', AppColors.success),
                  _buildLegendItem('Zorlayıcı', AppColors.error),
                  _buildLegendItem(
                    'Kavuşum',
                    isDark ? AppColors.starGold : colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 100.ms, duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildLegendItem(String label, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 2, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildBigThree() {
    final sun = _natalChart!.sun;
    final moon = _natalChart!.moon;
    final rising = _natalChart!.ascendant;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final accentColor = isDark ? AppColors.starGold : colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.cardGradient : AppColors.lightCardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: AppColors.auroraStart.withAlpha(isDark ? 76 : 50),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Büyük Üçlü',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: accentColor),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _BigThreeItem(
            label: 'Güneş Burcu',
            planet: sun,
            description: 'Temel kimlik ve ego',
          ),
          const SizedBox(height: AppConstants.spacingSm),
          _BigThreeItem(
            label: 'Ay Burcu',
            planet: moon,
            description: 'Duygular ve iç dünya',
          ),
          if (rising != null) ...[
            const SizedBox(height: AppConstants.spacingSm),
            _BigThreeItem(
              label: 'Yükselen',
              planet: rising,
              description: 'Dış imaj ve ilk izlenim',
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildDominants() {
    final dominantElement = _natalChart!.dominantElement;
    final dominantModality = _natalChart!.dominantModality;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.cardGradient : AppColors.lightCardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: AppColors.auroraEnd.withAlpha(isDark ? 76 : 50),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: isDark ? AppColors.auroraEnd : colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Baskın Enerjiler',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark ? AppColors.auroraEnd : colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Expanded(
                child: _DominantItem(
                  label: 'Element',
                  value: zodiac.ElementExtension(dominantElement).nameTr,
                  icon: zodiac.ElementExtension(dominantElement).symbol,
                  color: zodiac.ElementExtension(dominantElement).color,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: _DominantItem(
                  label: 'Modalite',
                  value: zodiac.ModalityExtension(dominantModality).nameTr,
                  icon: zodiac.ModalityExtension(dominantModality).symbol,
                  color: isDark
                      ? AppColors.moonSilver
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildRetrogrades() {
    final retrogrades = _natalChart!.retrogradePlanets;
    if (retrogrades.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.cardGradient : AppColors.lightCardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: AppColors.warning.withAlpha(isDark ? 76 : 50),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.replay, color: AppColors.warning, size: 20),
              const SizedBox(width: 8),
              Text(
                'Geri Giden Gezegenler',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.warning),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: retrogrades.map((p) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: p.planet.color.withAlpha(isDark ? 51 : 25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: p.planet.color.withAlpha(isDark ? 128 : 80),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p.planet.symbol,
                      style: TextStyle(fontSize: 16, color: p.planet.color),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${p.planet.nameTr} R',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Geri giden gezegenler, o gezegenin enerjisinin içe dönük ve yeniden değerlendirme sürecinde olduğunu gösterir.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildPlanetsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          _buildEsotericIntro(
            context,
            'Gezegenler: Ruhunun Sesleri',
            'Her gezegen, içindeki bir arketipi, bir iç sesi temsil eder. Güneş senin özünü, Ay duygusal doğanı, Merkür zihnini, Venüs sevgi dilini, Mars iradenı taşır. Dış gezegenler ise nesil enerjilerini ve derin dönüşüm potansiyellerini gösterir. Bu sesler bazen uyum içinde, bazen çatışma halindedir - ve bu dansı anlamak, kendini tanımanın anahtarıdır.',
            AppColors.auroraStart,
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),
          PlanetPositionsCard(chart: _natalChart!),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation (compact)
          const PageBottomNavigationCompact(currentRoute: '/birth-chart'),
        ],
      ),
    );
  }

  Widget _buildHousesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          _buildEsotericIntro(
            context,
            'Evler: Yaşamın Kutsal Alanları',
            'On iki ev, yaşamın on iki kutsal alanını temsil eder. Her ev bir tapınak gibidir - kendi ritüelleri, dersleri ve hazineleri olan. Birinci ev "ben"in tapınağı, yedinci ev "biz"in tapınağı, onuncu ev toplumsal misyonun tapınağıdır. Hangi burç bir evi yönetiyorsa, o yaşam alanına o burçun enerjisi damgasını vurur. Evlerdeki gezegenler ise o alana özel ilgi ve potansiyel getirir.',
            AppColors.auroraEnd,
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),
          HousesCard(chart: _natalChart!),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation (compact)
          const PageBottomNavigationCompact(currentRoute: '/birth-chart'),
        ],
      ),
    );
  }

  Widget _buildAspectsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          _buildEsotericIntro(
            context,
            'Açılar: Simyanın Dansı',
            'Açılar, içindeki farklı enerjilerin birbirleriyle nasıl ilişkilendiğini gösterir. Üçgen açılar doğal yetenekleri, kare açılar büyüme fırsatlarını, karşıt açılar dengelenmesi gereken kutuplaşmaları işaret eder. Bu bir "iyi" ya da "kötü" meselesi değil - her açı bir simya fırsatıdır. Zorluklar altına, gerilimler güce dönüşebilir. Sır, bu enerjilerle bilinçli çalışmaktır.',
            AppColors.fireElement,
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),
          AspectsCard(chart: _natalChart!),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation (compact)
          const PageBottomNavigationCompact(currentRoute: '/birth-chart'),
        ],
      ),
    );
  }
}

class _BigThreeItem extends StatelessWidget {
  final String label;
  final PlanetPosition? planet;
  final String description;

  const _BigThreeItem({
    required this.label,
    required this.planet,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (planet == null) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: planet!.sign.color.withAlpha(isDark ? 51 : 25),
            borderRadius: BorderRadius.circular(8),
            border: isDark
                ? null
                : Border.all(color: planet!.sign.color.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              planet!.sign.symbol,
              style: TextStyle(fontSize: 20, color: planet!.sign.color),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppColors.textMuted
                      : AppColors.lightTextMuted,
                ),
              ),
              Text(
                '${planet!.sign.nameTr} ${planet!.degree}',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: planet!.sign.color),
              ),
            ],
          ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}

class _DominantItem extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;

  const _DominantItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: color.withAlpha(isDark ? 25 : 15),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: isDark ? null : Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(icon, style: TextStyle(fontSize: 24, color: color)),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
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
}
