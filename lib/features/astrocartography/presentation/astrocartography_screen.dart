import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/premium_astrology.dart';
import '../../../data/services/premium_astrology_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class AstroCartographyScreen extends ConsumerStatefulWidget {
  const AstroCartographyScreen({super.key});

  @override
  ConsumerState<AstroCartographyScreen> createState() =>
      _AstroCartographyScreenState();
}

class _AstroCartographyScreenState
    extends ConsumerState<AstroCartographyScreen> {
  final _service = PremiumAstrologyService();

  AstroCartographyData? _data;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    // Auto-generate chart after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateData();
    });
  }

  void _generateData() {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile == null) return;

    // Use profile data - default to Istanbul if no coordinates
    final latitude = userProfile.birthLatitude ?? 41.0082;
    final longitude = userProfile.birthLongitude ?? 28.9784;

    setState(() {
      _data = _service.generateAstroCartography(
        userName: userProfile.name ?? 'Kullanici',
        birthDate: userProfile.birthDate,
        birthLatitude: latitude,
        birthLongitude: longitude,
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
                const Text('🗺️', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                Text(
                  'Profil Bulunamadı',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Astrokatografi haritanızı görmek için\nönce doğum bilgilerinizi girin',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.go(Routes.onboarding),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Profil Oluştur'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667EEA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'Geri Dön',
                    style: TextStyle(color: Colors.white70),
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
                      if (_data != null) ...[
                        _buildFilterChips(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildWorldMapPlaceholder(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildPowerPlacesCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildPlanetaryLinesCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildAnalysisCard(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ] else ...[
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(
                          color: AppColors.cosmic,
                        ),
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
              'AstroCartography',
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
            AppColors.cosmic.withValues(alpha: 0.3),
            AppColors.mystic.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.cosmic.withValues(alpha: 0.5)),
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
                  'Konum Astrolojisi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  'Dogum haritanizin dunya uzerindeki yansimalarini kesfedin',
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

  Widget _buildProfileCard(bool isDark, dynamic userProfile) {
    final hasCoordinates =
        userProfile.birthLatitude != null && userProfile.birthLongitude != null;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.cosmic.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: AppColors.cosmic, size: 20),
              const SizedBox(width: 8),
              Text(
                'Profil Bilgileri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cosmic.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hasCoordinates ? Icons.check_circle : Icons.info_outline,
                      size: 14,
                      color: hasCoordinates ? AppColors.cosmic : Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hasCoordinates ? 'Tam Veri' : 'Varsayilan Konum',
                      style: TextStyle(
                        fontSize: 11,
                        color: hasCoordinates
                            ? AppColors.cosmic
                            : Colors.orange,
                      ),
                    ),
                  ],
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
            Icons.location_on_outlined,
            'Dogum Yeri',
            userProfile.birthPlace ?? 'Belirtilmedi',
          ),
          if (hasCoordinates)
            _buildInfoRow(
              isDark,
              Icons.explore_outlined,
              'Koordinatlar',
              '${userProfile.birthLatitude!.toStringAsFixed(4)}, ${userProfile.birthLongitude!.toStringAsFixed(4)}',
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

  Widget _buildFilterChips(bool isDark) {
    final filters = [
      {'id': 'all', 'label': 'Tumu'},
      {'id': 'sun', 'label': 'Gunes'},
      {'id': 'moon', 'label': 'Ay'},
      {'id': 'venus', 'label': 'Venus'},
      {'id': 'jupiter', 'label': 'Jupiter'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(filter['label']!),
              onSelected: (_) {
                setState(() {
                  _selectedFilter = filter['id']!;
                });
              },
              selectedColor: AppColors.cosmic.withValues(alpha: 0.3),
              checkmarkColor: AppColors.cosmic,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWorldMapPlaceholder(bool isDark) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepSpace.withValues(alpha: 0.8),
            AppColors.cosmic.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.cosmic.withValues(alpha: 0.5)),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.public, size: 64, color: Colors.white54),
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  'Dunya Haritasi',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Gezegen cizgileriniz burada gosterilir',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Sample planetary line indicators
          Positioned(
            left: 30,
            top: 50,
            child: Container(
              width: 4,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.yellow.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: 60,
            top: 30,
            child: Container(
              width: 4,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.pink.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPowerPlacesCard(bool isDark) {
    if (_data == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Guc Noktalari',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._data!.powerPlaces
              .take(5)
              .map((place) => _buildPowerPlaceTile(place, isDark)),
        ],
      ),
    );
  }

  Widget _buildPowerPlaceTile(PowerPlace place, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${place.name}, ${place.country}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < place.powerRating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.cosmic.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              place.energyType,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.cosmic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aktif Gezegenler: ${place.activePlanets.join(", ")}',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            place.description,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanetaryLinesCard(bool isDark) {
    if (_data == null) return const SizedBox.shrink();

    // Group lines by planet
    final linesByPlanet = <String, List<PlanetaryLine>>{};
    for (final line in _data!.planetaryLines) {
      linesByPlanet.putIfAbsent(line.planet, () => []).add(line);
    }

    // Filter based on selection
    final filteredPlanets = _selectedFilter == 'all'
        ? linesByPlanet.keys.toList()
        : linesByPlanet.keys
              .where((p) => p.toLowerCase().contains(_selectedFilter))
              .toList();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Gezegen Cizgileri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...filteredPlanets.take(3).map((planet) {
            final lines = linesByPlanet[planet]!;
            return _buildPlanetSection(planet, lines, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildPlanetSection(
    String planet,
    List<PlanetaryLine> lines,
    bool isDark,
  ) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        planet,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : AppColors.textDark,
        ),
      ),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: _getPlanetColor(planet).withValues(alpha: 0.2),
        child: Text(
          _getPlanetEmoji(planet),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      children: lines.map((line) {
        return ListTile(
          dense: true,
          leading: Icon(
            line.isPositive ? Icons.add_circle : Icons.remove_circle,
            color: line.isPositive ? Colors.green : Colors.orange,
            size: 20,
          ),
          title: Text(
            line.lineType.nameTr,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          subtitle: Text(
            line.meaning,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : AppColors.textLight,
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getPlanetColor(String planet) {
    switch (planet) {
      case 'Gunes':
        return Colors.amber;
      case 'Ay':
        return Colors.grey;
      case 'Merkur':
        return Colors.cyan;
      case 'Venus':
        return Colors.pink;
      case 'Mars':
        return Colors.red;
      case 'Jupiter':
        return Colors.purple;
      case 'Saturn':
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  String _getPlanetEmoji(String planet) {
    switch (planet) {
      case 'Gunes':
        return '';
      case 'Ay':
        return '';
      case 'Merkur':
        return '';
      case 'Venus':
        return '';
      case 'Mars':
        return '';
      case 'Jupiter':
        return '';
      case 'Saturn':
        return '';
      default:
        return '';
    }
  }

  Widget _buildAnalysisCard(bool isDark) {
    if (_data == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mystic.withValues(alpha: 0.2),
            AppColors.cosmic.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.mystic.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Genel Analiz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _data!.overallAnalysis,
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
}
