import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/premium_astrology.dart';
import '../../../data/services/premium_astrology_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class ElectionalScreen extends ConsumerStatefulWidget {
  const ElectionalScreen({super.key});

  @override
  ConsumerState<ElectionalScreen> createState() => _ElectionalScreenState();
}

class _ElectionalScreenState extends ConsumerState<ElectionalScreen> {
  final _service = PremiumAstrologyService();
  ElectionalPurpose _selectedPurpose = ElectionalPurpose.wedding;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));

  ElectionalChart? _chart;

  @override
  void initState() {
    super.initState();
    // Auto-generate chart after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateChart();
    });
  }

  void _generateChart() {
    setState(() {
      _chart = _service.generateElectionalChart(
        purpose: _selectedPurpose,
        startDate: _startDate,
        endDate: _endDate,
      );
    });
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(days: 30));
        }
      });
      _generateChart();
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: _startDate.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
      _generateChart();
    }
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
                      _buildPurposeSelector(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildDateRangeCard(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      if (_chart != null) ...[
                        _buildOptimalTimeCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildMoonPhaseCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildRetrogradeCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildFavorableWindowsCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildUnfavorableWindowsCard(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ] else ...[
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(color: AppColors.gold),
                        const SizedBox(height: 16),
                        Text(
                          'Analiz yapiliyor...',
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
              'Secim Astrolojisi',
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
            AppColors.gold.withValues(alpha: 0.2),
            AppColors.cosmic.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.5)),
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
                  'En Uygun Zamani Bulun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  'Onemli kararlar icin astrolojik olarak desteklenen zamanlari kesfedin',
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
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: AppColors.gold, size: 20),
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
            Icons.location_on_outlined,
            'Dogum Yeri',
            userProfile.birthPlace ?? 'Belirtilmedi',
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

  Widget _buildPurposeSelector(bool isDark) {
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
          Text(
            'Amac Secin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ElectionalPurpose.values.map((purpose) {
              final isSelected = _selectedPurpose == purpose;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPurpose = purpose;
                  });
                  _generateChart();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.cosmic.withValues(alpha: 0.3)
                        : (isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.grey.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.cosmic : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(purpose.icon),
                      const SizedBox(width: 6),
                      Text(
                        purpose.nameTr,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isDark ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeCard(bool isDark) {
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
          Text(
            'Tarih Araligi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _selectStartDate,
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.spacingMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMd,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Baslangic',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white60
                                : AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 20),
              ),
              Expanded(
                child: InkWell(
                  onTap: _selectEndDate,
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.spacingMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMd,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bitis',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white60
                                : AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptimalTimeCard(bool isDark) {
    if (_chart == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.3),
            AppColors.cosmic.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('', style: TextStyle(fontSize: 28)),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Onerilen Zaman',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Skor: ${_chart!.optimalScore}/100',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
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
                  color: _getScoreColor(
                    _chart!.optimalScore,
                  ).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getScoreLabel(_chart!.optimalScore),
                  style: TextStyle(
                    color: _getScoreColor(_chart!.optimalScore),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _chart!.overallRecommendation,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return AppColors.gold;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  String _getScoreLabel(int score) {
    if (score >= 80) return 'Mukemmel';
    if (score >= 60) return 'Iyi';
    if (score >= 40) return 'Orta';
    return 'Zayif';
  }

  Widget _buildMoonPhaseCard(bool isDark) {
    if (_chart == null) return const SizedBox.shrink();

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
                'Ay Fazi Tavsiyesi',
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
            _chart!.moonPhaseAdvice,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetrogradeCard(bool isDark) {
    if (_chart == null) return const SizedBox.shrink();

    final isWarning = _chart!.retrogradeWarning.contains('');

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isWarning
            ? Colors.orange.withValues(alpha: 0.1)
            : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isWarning
              ? Colors.orange.withValues(alpha: 0.5)
              : Colors.green.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(isWarning ? '' : '', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Retro Durumu',
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
            _chart!.retrogradeWarning.replaceAll(' ', '').replaceAll(' ', ''),
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorableWindowsCard(bool isDark) {
    if (_chart == null || _chart!.favorableWindows.isEmpty) {
      return const SizedBox.shrink();
    }

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
                'Uygun Zamanlar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._chart!.favorableWindows
              .take(5)
              .map(
                (window) => _buildWindowTile(window, isDark, isPositive: true),
              ),
        ],
      ),
    );
  }

  Widget _buildUnfavorableWindowsCard(bool isDark) {
    if (_chart == null || _chart!.unfavorableWindows.isEmpty) {
      return const SizedBox.shrink();
    }

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
                'Kacinilmasi Gereken Zamanlar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._chart!.unfavorableWindows
              .take(3)
              .map(
                (window) => _buildWindowTile(window, isDark, isPositive: false),
              ),
        ],
      ),
    );
  }

  Widget _buildWindowTile(
    ElectionalWindow window,
    bool isDark, {
    required bool isPositive,
  }) {
    final startStr =
        '${window.start.day}/${window.start.month} ${window.start.hour.toString().padLeft(2, '0')}:${window.start.minute.toString().padLeft(2, '0')}';
    final endStr =
        '${window.end.hour.toString().padLeft(2, '0')}:${window.end.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isPositive
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isPositive
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.red.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: isPositive ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                '$startStr - $endStr',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getScoreColor(window.score).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${window.score}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(window.score),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            window.description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
          if (window.supportingAspects.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: window.supportingAspects.map((aspect) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    aspect,
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? Colors.white60 : AppColors.textLight,
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
}
