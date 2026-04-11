import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/extended_horoscope.dart';
import '../../../data/services/extended_horoscope_service.dart';
import '../../../shared/widgets/cosmic_background.dart';

class EclipseCalendarScreen extends StatefulWidget {
  const EclipseCalendarScreen({super.key});

  @override
  State<EclipseCalendarScreen> createState() => _EclipseCalendarScreenState();
}

class _EclipseCalendarScreenState extends State<EclipseCalendarScreen> {
  late int _selectedYear;
  late List<EclipseEvent> _eclipses;
  EclipseEvent? _nextEclipse;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
    _loadEclipses();
    _nextEclipse = ExtendedHoroscopeService.getNextEclipse();
  }

  void _loadEclipses() {
    _eclipses = ExtendedHoroscopeService.getEclipsesForYear(_selectedYear);
  }

  void _changeYear(int delta) {
    setState(() {
      _selectedYear += delta;
      _loadEclipses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_nextEclipse != null) ...[
                        _buildNextEclipseCard(isDark),
                        const SizedBox(height: AppConstants.spacingXl),
                      ],
                      _buildYearSelector(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildEclipsesList(isDark),
                      const SizedBox(height: AppConstants.spacingXxl),
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
                const Text('🌑', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Tutulma Takvimi',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextEclipseCard(bool isDark) {
    final eclipse = _nextEclipse!;
    final daysUntil = eclipse.daysUntil;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: eclipse.type.isSolar
              ? [
                  Colors.orange.withValues(alpha: isDark ? 0.4 : 0.2),
                  Colors.amber.withValues(alpha: isDark ? 0.4 : 0.2),
                ]
              : [
                  Colors.indigo.withValues(alpha: isDark ? 0.4 : 0.2),
                  Colors.purple.withValues(alpha: isDark ? 0.4 : 0.2),
                ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: eclipse.type.isSolar
              ? Colors.orange.withValues(alpha: 0.5)
              : Colors.indigo.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: eclipse.type.isSolar
                      ? Colors.orange.withValues(alpha: 0.3)
                      : Colors.indigo.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  eclipse.type.isSolar ? '☀️' : '🌙',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.starGold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Siradaki Tutulma',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.starGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      eclipse.type.nameTr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '$daysUntil',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: eclipse.type.isSolar
                          ? Colors.orange
                          : Colors.indigo,
                    ),
                  ),
                  Text('gun', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              _buildInfoChip(
                '${eclipse.date.day}.${eclipse.date.month}.${eclipse.date.year}',
                Icons.calendar_today,
                isDark,
              ),
              const SizedBox(width: 8),
              _buildInfoChip(
                eclipse.zodiacSign.nameTr,
                null,
                isDark,
                prefix: eclipse.zodiacSign.symbol,
              ),
              const SizedBox(width: 8),
              _buildInfoChip(eclipse.peakTime, Icons.access_time, isDark),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            eclipse.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            eclipse.description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _buildExpandableSection(
            'Ruhsal Anlam',
            eclipse.spiritualMeaning,
            Icons.auto_awesome,
            Colors.purple,
            isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildExpandableSection(
            'Pratik Tavsiye',
            eclipse.practicalAdvice,
            Icons.lightbulb_outline,
            Colors.amber,
            isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildAffectedSignsRow(eclipse.mostAffectedSigns, isDark),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    String label,
    IconData? icon,
    bool isDark, {
    String? prefix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefix != null) ...[
            Text(prefix, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
          ],
          if (icon != null) ...[Icon(icon, size: 12), const SizedBox(width: 4)],
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(
    String title,
    String content,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAffectedSignsRow(List<ZodiacSign> signs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'En Cok Etkilenen Burclar',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: signs.map((sign) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceLight.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                border: Border.all(
                  color: AppColors.starGold.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(sign.symbol, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    sign.nameTr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildYearSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.3)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _selectedYear > 2024 ? () => _changeYear(-1) : null,
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
          Text(
            '$_selectedYear Tutulmalari',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _selectedYear < 2026 ? () => _changeYear(1) : null,
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildEclipsesList(bool isDark) {
    if (_eclipses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.spacingXl),
        child: Center(
          child: Text(
            'Bu yil icin tutulma verisi bulunamadi.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return Column(
      children: _eclipses.map((eclipse) {
        return _buildEclipseCard(eclipse, isDark);
      }).toList(),
    );
  }

  Widget _buildEclipseCard(EclipseEvent eclipse, bool isDark) {
    final isPast = eclipse.isPast;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: isPast ? 0.1 : 0.2)
            : isPast
            ? AppColors.lightSurfaceVariant.withValues(alpha: 0.5)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: isPast
            ? null
            : Border.all(
                color: eclipse.type.isSolar
                    ? Colors.orange.withValues(alpha: 0.3)
                    : Colors.indigo.withValues(alpha: 0.3),
              ),
        boxShadow: isDark || isPast
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingSm,
          ),
          childrenPadding: const EdgeInsets.only(
            left: AppConstants.spacingLg,
            right: AppConstants.spacingLg,
            bottom: AppConstants.spacingLg,
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: eclipse.type.isSolar
                  ? Colors.orange.withValues(alpha: isPast ? 0.1 : 0.2)
                  : Colors.indigo.withValues(alpha: isPast ? 0.1 : 0.2),
              shape: BoxShape.circle,
            ),
            child: Text(
              eclipse.type.isSolar ? '☀️' : '🌙',
              style: TextStyle(
                fontSize: 20,
                color: isPast ? Colors.grey : null,
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isPast)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Gecmis',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                        ),
                      ),
                    Text(
                      eclipse.type.nameTr,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isPast ? Colors.grey : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Text(
                  '${eclipse.date.day}.${eclipse.date.month}.${eclipse.date.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isPast ? Colors.grey : null,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  eclipse.zodiacSign.symbol,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPast ? Colors.grey : null,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  eclipse.zodiacSign.nameTr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isPast ? Colors.grey : null,
                  ),
                ),
              ],
            ),
          ),
          children: [
            Text(
              eclipse.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            _buildExpandableSection(
              'Ruhsal Anlam',
              eclipse.spiritualMeaning,
              Icons.auto_awesome,
              Colors.purple,
              isDark,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            _buildExpandableSection(
              'Pratik Tavsiye',
              eclipse.practicalAdvice,
              Icons.lightbulb_outline,
              Colors.amber,
              isDark,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            _buildAffectedSignsRow(eclipse.mostAffectedSigns, isDark),
          ],
        ),
      ),
    );
  }
}
