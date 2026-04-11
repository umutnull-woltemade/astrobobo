import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/premium_astrology.dart';
import '../../../data/services/premium_astrology_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class AsteroidsScreen extends ConsumerStatefulWidget {
  const AsteroidsScreen({super.key});

  @override
  ConsumerState<AsteroidsScreen> createState() => _AsteroidsScreenState();
}

class _AsteroidsScreenState extends ConsumerState<AsteroidsScreen>
    with SingleTickerProviderStateMixin {
  final _service = PremiumAstrologyService();

  AsteroidChart? _chart;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Auto-generate chart after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateChart();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _generateChart() {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile == null) return;

    setState(() {
      _chart = _service.generateAsteroidChart(
        birthDate: userProfile.birthDate,
        sunSign: userProfile.sunSign,
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
                  'Profil bulunamadi',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lutfen once dogum bilgilerinizi girin',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Geri Don'),
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
                        _buildTabSection(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ] else ...[
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(color: Colors.purple),
                        const SizedBox(height: 16),
                        Text(
                          'Harita olusturuluyor...',
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
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          Expanded(
            child: Text(
              'Asteroid Haritasi',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildInfoBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withValues(alpha: 0.3),
            AppColors.cosmic.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Text('', style: TextStyle(fontSize: 32)),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Genisletilmis Asteroidler',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  'Kiron, Ceres, Pallas, Juno, Vesta ve daha fazlasi',
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildProfileCard(bool isDark, UserProfile userProfile) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.purple, size: 20),
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
            'Isim',
            userProfile.name ?? 'Kullanici',
          ),
          _buildInfoRow(
            isDark,
            Icons.cake_outlined,
            'Dogum Tarihi',
            _formatDate(userProfile.birthDate),
          ),
          _buildInfoRow(
            isDark,
            Icons.wb_sunny_outlined,
            'Gunes Burcu',
            userProfile.sunSign.nameTr,
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Widget _buildTabSection(bool isDark) {
    if (_chart == null) return const SizedBox.shrink();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.purple,
            unselectedLabelColor: isDark ? Colors.white60 : AppColors.textLight,
            indicatorColor: Colors.purple,
            tabs: const [
              Tab(text: 'Ana Asteroidler'),
              Tab(text: 'Ikincil'),
              Tab(text: 'Analiz'),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        SizedBox(
          height: 800,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMainAsteroidsTab(isDark),
              _buildSecondaryAsteroidsTab(isDark),
              _buildAnalysisTab(isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainAsteroidsTab(bool isDark) {
    final mainAsteroids = [
      Asteroid.chiron,
      Asteroid.ceres,
      Asteroid.pallas,
      Asteroid.juno,
      Asteroid.vesta,
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          ...mainAsteroids.map((asteroid) {
            final pos = _chart!.asteroids.firstWhere(
              (a) => a.asteroid == asteroid,
            );
            return _buildAsteroidCard(pos, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildSecondaryAsteroidsTab(bool isDark) {
    final secondaryAsteroids = [
      Asteroid.eros,
      Asteroid.psyche,
      Asteroid.lilith,
      Asteroid.nessus,
      Asteroid.pholus,
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          ...secondaryAsteroids.map((asteroid) {
            final pos = _chart!.asteroids.firstWhere(
              (a) => a.asteroid == asteroid,
            );
            return _buildAsteroidCard(pos, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildAsteroidCard(AsteroidPosition pos, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: _getAsteroidColor(pos.asteroid).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getAsteroidColor(pos.asteroid).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    pos.asteroid.symbol,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pos.asteroid.nameTr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: pos.sign.color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${pos.sign.symbol} ${pos.sign.nameTr}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white : AppColors.textDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${pos.degree.toStringAsFixed(1)} - ${pos.house}. Ev',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white60
                                : AppColors.textLight,
                          ),
                        ),
                      ],
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
              color: isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Text(
              pos.asteroid.theme,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: _getAsteroidColor(pos.asteroid),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            pos.interpretation,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
          if (pos.aspects.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: pos.aspects.map((aspect) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cosmic.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    aspect,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalysisTab(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Kiron Analizi',
            content: _chart!.chiron,
            color: Colors.teal,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Ceres Analizi',
            content: _chart!.ceres,
            color: Colors.green,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Pallas Analizi',
            content: _chart!.pallas,
            color: Colors.blue,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Juno Analizi',
            content: _chart!.juno,
            color: Colors.pink,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Vesta Analizi',
            content: _chart!.vesta,
            color: Colors.orange,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDetailedAnalysisCard(
            icon: '',
            title: 'Genel Analiz',
            content: _chart!.overallAnalysis,
            color: Colors.purple,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedAnalysisCard({
    required String icon,
    required String title,
    required String content,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
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

  Color _getAsteroidColor(Asteroid asteroid) {
    switch (asteroid) {
      case Asteroid.chiron:
        return Colors.teal;
      case Asteroid.ceres:
        return Colors.green;
      case Asteroid.pallas:
        return Colors.blue;
      case Asteroid.juno:
        return Colors.pink;
      case Asteroid.vesta:
        return Colors.orange;
      case Asteroid.eros:
        return Colors.red;
      case Asteroid.psyche:
        return Colors.purple;
      case Asteroid.lilith:
        return Colors.deepPurple;
      case Asteroid.nessus:
        return Colors.brown;
      case Asteroid.pholus:
        return Colors.indigo;
    }
  }
}
