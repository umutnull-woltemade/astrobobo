import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/specialized_tools.dart';
import '../../../data/services/specialized_tools_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class LocalSpaceScreen extends ConsumerStatefulWidget {
  const LocalSpaceScreen({super.key});

  @override
  ConsumerState<LocalSpaceScreen> createState() => _LocalSpaceScreenState();
}

class _LocalSpaceScreenState extends ConsumerState<LocalSpaceScreen>
    with SingleTickerProviderStateMixin {
  final _service = SpecializedToolsService();
  LocalSpaceChart? _chart;
  late TabController _tabController;

  // Compass rotation state
  double _compassRotation = 0.0;
  double _startRotation = 0.0;
  Offset? _startPosition;

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

    // Use profile data - default to Istanbul if no coordinates
    final latitude = userProfile.birthLatitude ?? 41.0082;
    final longitude = userProfile.birthLongitude ?? 28.9784;

    setState(() {
      _chart = _service.generateLocalSpaceChart(
        userName: userProfile.name ?? 'Kullanıcı',
        birthDate: userProfile.birthDate,
        latitude: latitude,
        longitude: longitude,
      );
    });
  }

  // Compass rotation handlers
  void _onPanStart(DragStartDetails details) {
    _startPosition = details.localPosition;
    _startRotation = _compassRotation;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_startPosition == null) return;

    // Calculate rotation based on circular gesture
    const center = Offset(140, 140); // Center of 280x280 compass
    final startAngle = math.atan2(
      _startPosition!.dy - center.dy,
      _startPosition!.dx - center.dx,
    );
    final currentAngle = math.atan2(
      details.localPosition.dy - center.dy,
      details.localPosition.dx - center.dx,
    );

    setState(() {
      _compassRotation = _startRotation + (currentAngle - startAngle);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _startPosition = null;
  }

  void _resetRotation() {
    setState(() {
      _compassRotation = 0.0;
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
                const Text('🧭', style: TextStyle(fontSize: 64)),
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
                        _buildCompass(isDark),
                        const SizedBox(height: AppConstants.spacingLg),
                        _buildTabSection(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ] else ...[
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(color: Colors.teal),
                        const SizedBox(height: 16),
                        Text(
                          'Harita oluşturuluyor...',
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
              'Yerel Uzay Astrolojisi',
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
            Colors.teal.withValues(alpha: 0.3),
            AppColors.cosmic.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Text('🧭', style: TextStyle(fontSize: 32)),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mekansal Astroloji',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  'Gezegen enerjilerinin yön ve mekan üzerindeki etkilerini keşfedin',
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
        border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.teal, size: 20),
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
                  color: Colors.teal.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hasCoordinates ? Icons.check_circle : Icons.info_outline,
                      size: 14,
                      color: hasCoordinates ? Colors.teal : Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hasCoordinates ? 'Tam Veri' : 'Varsayılan Konum',
                      style: TextStyle(
                        fontSize: 11,
                        color: hasCoordinates ? Colors.teal : Colors.orange,
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
            Icons.location_on_outlined,
            'Doğum Yeri',
            userProfile.birthPlace ?? 'Belirtilmedi',
          ),
          if (hasCoordinates)
            _buildInfoRow(
              isDark,
              Icons.explore_outlined,
              'Koordinatlar',
              '${userProfile.birthLatitude!.toStringAsFixed(4)}°, ${userProfile.birthLongitude!.toStringAsFixed(4)}°',
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

  Widget _buildCompass(bool isDark) {
    if (_chart == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gezegen Pusula',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.touch_app,
                size: 16,
                color: Colors.teal.withValues(alpha: 0.7),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Döndürmek için sürükleyin',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white54 : AppColors.textLight,
                ),
              ),
              if (_compassRotation != 0.0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(_compassRotation * 180 / math.pi).toStringAsFixed(0)}°',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                onDoubleTap: _resetRotation,
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: Transform.rotate(
                    angle: _compassRotation,
                    child: CustomPaint(
                      painter: _CompassPainter(
                        planetLines: _chart!.planetLines,
                        isDark: isDark,
                        rotation: _compassRotation,
                      ),
                    ),
                  ),
                ),
              ),
              // Center indicator (fixed - doesn't rotate)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_compassRotation != 0.0) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _resetRotation,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Sıfırla'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _chart!.planetLines.take(7).map((line) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getPlanetColor(line.planet).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getPlanetColor(line.planet),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${line.planet} ${line.direction.symbol}',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getPlanetColor(String planet) {
    switch (planet) {
      case 'Güneş':
        return Colors.amber;
      case 'Ay':
        return Colors.blueGrey;
      case 'Merkür':
        return Colors.cyan;
      case 'Venüs':
        return Colors.pink;
      case 'Mars':
        return Colors.red;
      case 'Jüpiter':
        return Colors.purple;
      case 'Satürn':
        return Colors.brown;
      default:
        return Colors.blue;
    }
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
            labelColor: Colors.teal,
            unselectedLabelColor: isDark ? Colors.white60 : AppColors.textLight,
            indicatorColor: Colors.teal,
            tabs: const [
              Tab(text: 'Yönler'),
              Tab(text: 'Ev'),
              Tab(text: 'Ofis'),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        SizedBox(
          height: 500,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDirectionsTab(isDark),
              _buildHomeTab(isDark),
              _buildOfficeTab(isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionsTab(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        children: _chart!.directions.map((dir) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dir.direction.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dir.direction.nameTr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < dir.strengthRating
                              ? Icons.circle
                              : Icons.circle_outlined,
                          size: 10,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                if (dir.activePlanets.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: dir.activePlanets.map((p) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getPlanetColor(p).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(p, style: const TextStyle(fontSize: 10)),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  dir.theme,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white70 : AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dir.advice,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isDark ? Colors.white60 : AppColors.textLight,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHomeTab(bool isDark) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🏠', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Ev Düzeni Önerileri',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              _chart!.homeAnalysis,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white70 : AppColors.textLight,
              ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            const Divider(),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Oda Bazlı Öneriler',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            ..._chart!.planetLines.take(4).map((line) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getPlanetColor(line.planet).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _getPlanetEmoji(line.planet),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${line.planet} - ${line.direction.nameTr}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      line.homeAdvice,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficeTab(bool isDark) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('💼', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Ofis Düzeni Önerileri',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              _chart!.officeAnalysis,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white70 : AppColors.textLight,
              ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            const Divider(),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Seyahat Önerileri',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            ..._chart!.planetLines.take(4).map((line) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getPlanetColor(line.planet).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          line.direction.icon,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${line.direction.nameTr} - ${line.planet}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      line.travelAdvice,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getPlanetEmoji(String planet) {
    switch (planet) {
      case 'Güneş':
        return '☀️';
      case 'Ay':
        return '🌙';
      case 'Merkür':
        return '☿️';
      case 'Venüs':
        return '♀️';
      case 'Mars':
        return '♂️';
      case 'Jüpiter':
        return '♃';
      case 'Satürn':
        return '♄';
      default:
        return '⭐';
    }
  }
}

class _CompassPainter extends CustomPainter {
  final List<LocalSpaceLine> planetLines;
  final bool isDark;
  final double rotation;

  _CompassPainter({
    required this.planetLines,
    required this.isDark,
    this.rotation = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Draw outer circle
    final circlePaint = Paint()
      ..color = isDark ? Colors.white24 : Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawCircle(center, radius * 0.7, circlePaint);
    canvas.drawCircle(center, radius * 0.4, circlePaint);

    // Draw direction lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 - 90) * math.pi / 180;
      final outer = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, outer, circlePaint);
    }

    // Draw planet lines
    for (final line in planetLines.take(7)) {
      final angle = (line.azimuth - 90) * math.pi / 180;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final planetPaint = Paint()
        ..color = _getPlanetColor(line.planet)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawLine(center, end, planetPaint);

      // Draw planet dot at end
      final dotPaint = Paint()
        ..color = _getPlanetColor(line.planet)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(end, 6, dotPaint);
    }

    // Draw N, S, E, W labels
    final textStyle = TextStyle(
      color: isDark ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final directions = ['N', 'E', 'S', 'W'];
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90 - 90) * math.pi / 180;
      final pos = Offset(
        center.dx + (radius + 12) * math.cos(angle),
        center.dy + (radius + 12) * math.sin(angle),
      );

      final textSpan = TextSpan(text: directions[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2),
      );
    }
  }

  Color _getPlanetColor(String planet) {
    switch (planet) {
      case 'Güneş':
        return Colors.amber;
      case 'Ay':
        return Colors.blueGrey;
      case 'Merkür':
        return Colors.cyan;
      case 'Venüs':
        return Colors.pink;
      case 'Mars':
        return Colors.red;
      case 'Jüpiter':
        return Colors.purple;
      case 'Satürn':
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
