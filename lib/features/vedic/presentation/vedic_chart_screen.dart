import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/advanced_astrology.dart';
import '../../../data/services/advanced_astrology_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class VedicChartScreen extends ConsumerStatefulWidget {
  const VedicChartScreen({super.key});

  @override
  ConsumerState<VedicChartScreen> createState() => _VedicChartScreenState();
}

class _VedicChartScreenState extends ConsumerState<VedicChartScreen> {
  VedicChart? _chart;

  @override
  void initState() {
    super.initState();
    // Auto-generate chart after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateChart();
    });
  }

  void _generateChart() {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile == null) return;

    // Use actual rising sign if available, otherwise use sun sign as fallback
    // Note: For accurate Vedic chart, birth time is needed for true ascendant (Lagna)
    final ascendantToUse = userProfile.risingSign ?? userProfile.sunSign;

    setState(() {
      _chart = AdvancedAstrologyService.generateVedicChart(
        birthDate: userProfile.birthDate,
        westernSun: userProfile.sunSign,
        westernMoon: userProfile.moonSign ?? userProfile.sunSign,
        westernAscendant: ascendantToUse,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userProfile = ref.watch(userProfileProvider);

    if (userProfile == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                Text(
                  'Profil bulunamadı',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lütfen önce doğum bilgilerinizi girin',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Geri Dön'),
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
              _buildHeader(context, isDark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  child: Column(
                    children: [
                      _buildInfoBanner(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildProfileCard(isDark, userProfile),
                      const SizedBox(height: AppConstants.spacingLg),
                      if (_chart != null) ...[
                        _buildMoonSignCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildNakshatraCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildDashaCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildPlanetPositions(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildYogasCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildDoshaCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildPredictionCard(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ] else ...[
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(color: Colors.orange),
                        const SizedBox(height: 16),
                        Text(
                          'Vedik harita oluşturuluyor...',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.textLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Row(
              children: [
                const Text('', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Vedik Harita',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Vedik astroloji sidereal (yıldız tabanlı) zodyak kullanır. Batı astrolojisinden yaklaşık 24 derece fark vardır.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(bool isDark, UserProfile userProfile) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Profil Bilgileri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoRow(
            isDark,
            Icons.person_outline,
            'İsim',
            userProfile.name ?? 'Kullanıcı',
          ),
          _buildInfoRow(
            isDark,
            Icons.cake_outlined,
            'Doğum Tarihi',
            _formatDate(userProfile.birthDate),
          ),
          _buildInfoRow(
            isDark,
            Icons.wb_sunny_outlined,
            'Batı Güneş',
            userProfile.sunSign.nameTr,
          ),
          if (userProfile.moonSign != null)
            _buildInfoRow(
              isDark,
              Icons.nightlight_outlined,
              'Batı Ay',
              userProfile.moonSign!.nameTr,
            ),
          if (userProfile.risingSign != null)
            _buildInfoRow(
              isDark,
              Icons.arrow_upward,
              'Batı Yükselen',
              userProfile.risingSign!.nameTr,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(bool isDark, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isDark ? Colors.white54 : AppColors.textLight,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : AppColors.textLight,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Widget _buildMoonSignCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.withValues(alpha: isDark ? 0.3 : 0.15),
            Colors.deepOrange.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _chart!.moonSign.symbol,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rasi (Ay Burcu)',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.orange),
                    ),
                    Text(
                      _chart!.moonSign.nameTr,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Lagna',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.orange),
                  ),
                  Row(
                    children: [
                      Text(
                        _chart!.ascendant.symbol,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _chart!.ascendant.nameTr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNakshatraCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Text(
                'Nakshatra',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceLight.withValues(alpha: 0.2)
                  : AppColors.lightSurfaceVariant,
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_chart!.nakshatra}. ${_chart!.nakshatraName}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Pada ${_chart!.nakshatraPada}',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildNakshatraInfo('Lord', _chart!.nakshatraLord, isDark),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNakshatraInfo(String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.3)
            : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text('$label: ', style: Theme.of(context).textTheme.bodySmall),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDashaCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.15),
            Colors.blue.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.timeline, color: Colors.indigo),
              const SizedBox(width: 8),
              Text(
                'Dasha Dönemi',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Expanded(
                child: _buildDashaPeriod(
                  'Mahadasha',
                  _chart!.dashaLord,
                  Colors.indigo,
                  isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDashaPeriod(
                  'Antardasha',
                  _chart!.antardasha,
                  Colors.blue,
                  isDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDashaPeriod(
                  'Pratyantar',
                  _chart!.pratyantardasha,
                  Colors.cyan,
                  isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashaPeriod(
    String label,
    String planet,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(
            planet,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanetPositions(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gezegen Pozisyonları (Sidereal)',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._chart!.planets.map((planet) {
            Color dignityColor = Colors.grey;
            if (planet.isExalted) dignityColor = Colors.green;
            if (planet.isDebilitated) dignityColor = Colors.red;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceLight.withValues(alpha: 0.2)
                    : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      planet.planet,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    planet.sign.symbol,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      planet.sign.nameTr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${planet.house}. Ev',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (planet.isRetrograde)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'R',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: dignityColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      planet.dignity,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: dignityColor,
                        fontSize: 10,
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

  Widget _buildYogasCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.star, color: Colors.green, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Yogalar',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._chart!.yogas.map((yoga) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      yoga,
                      style: Theme.of(context).textTheme.bodySmall,
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

  Widget _buildDoshaCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dosha Analizi',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDoshaItem('Manglik Dosha', _chart!.manglikStatus, isDark),
          const SizedBox(height: 8),
          _buildDoshaItem('Kala Sarpa Yoga', _chart!.kalaSarpaYoga, isDark),
        ],
      ),
    );
  }

  Widget _buildDoshaItem(String title, String content, bool isDark) {
    final hasDosha =
        content.contains('mevcut') || content.contains('belirtileri');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasDosha
            ? Colors.orange.withValues(alpha: 0.1)
            : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasDosha
              ? Colors.orange.withValues(alpha: 0.3)
              : Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasDosha ? Icons.warning_amber : Icons.check_circle,
                color: hasDosha ? Colors.orange : Colors.green,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.starGold.withValues(alpha: isDark ? 0.2 : 0.1),
            AppColors.celestialGold.withValues(alpha: isDark ? 0.2 : 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Text('', style: TextStyle(fontSize: 32)),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Vedik Yorum',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            _chart!.generalPrediction,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.6),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
