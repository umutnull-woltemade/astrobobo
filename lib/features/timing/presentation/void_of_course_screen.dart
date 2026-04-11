import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/moon_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';

/// Provider for current VOC status
final voidOfCourseProvider = Provider<VoidOfCourseMoon>((ref) {
  return VoidOfCourseMoonExtension.getVoidOfCourseStatus();
});

/// Provider for upcoming VOC periods
final upcomingVocPeriodsProvider = Provider<List<VoidOfCourseMoon>>((ref) {
  final periods = <VoidOfCourseMoon>[];
  final now = DateTime.now();

  // Get VOC periods for the next 7 days
  for (int i = 0; i < 7; i++) {
    final date = now.add(Duration(days: i));
    // Check multiple times per day
    for (int hour = 0; hour < 24; hour += 6) {
      final checkTime = DateTime(date.year, date.month, date.day, hour);
      final voc = VoidOfCourseMoonExtension.getVoidOfCourseStatus(checkTime);
      if (voc.isVoid && voc.startTime != null) {
        // Avoid duplicates
        if (!periods.any(
          (p) =>
              p.startTime?.day == voc.startTime?.day &&
              p.startTime?.hour == voc.startTime?.hour,
        )) {
          periods.add(voc);
        }
      }
    }
  }

  // Sort by start time
  periods.sort(
    (a, b) => (a.startTime ?? DateTime.now()).compareTo(
      b.startTime ?? DateTime.now(),
    ),
  );

  return periods;
});

class VoidOfCourseScreen extends ConsumerWidget {
  const VoidOfCourseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVoc = ref.watch(voidOfCourseProvider);
    final upcomingPeriods = ref.watch(upcomingVocPeriodsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isDark),
                const SizedBox(height: AppConstants.spacingXl),
                _buildCurrentStatus(context, currentVoc, isDark)
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 400.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXl),
                _buildWhatIsVoc(context, isDark)
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXl),
                _buildDosDonts(context, isDark)
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 400.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXl),
                _buildUpcomingPeriods(context, upcomingPeriods, isDark)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXxl),
                const PageBottomNavigation(currentRoute: '/timing'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(width: AppConstants.spacingSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Void of Course Ay',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kozmik Zamanlama Rehberi',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mysticBlue.withOpacity(0.3),
                AppColors.cosmicPurple.withOpacity(0.3),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: const Text('🌙', style: TextStyle(fontSize: 28)),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCurrentStatus(
    BuildContext context,
    VoidOfCourseMoon voc,
    bool isDark,
  ) {
    final isVoid = voc.isVoid;
    final statusColor = isVoid ? AppColors.warning : AppColors.success;
    final moonPhase = MoonService.getCurrentPhase();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [statusColor.withOpacity(0.2), statusColor.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                isVoid ? 'AY VOID OF COURSE' : 'AY AKTIF',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Moon info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoonInfoItem(
                context,
                'Ay Evresi',
                moonPhase.emoji,
                moonPhase.nameTr,
                isDark,
              ),
              _buildMoonInfoItem(
                context,
                'Ay Burcu',
                voc.currentSign.symbol,
                voc.currentSign.nameTr,
                isDark,
              ),
              if (voc.nextSign != null)
                _buildMoonInfoItem(
                  context,
                  'Sonraki Burc',
                  voc.nextSign!.symbol,
                  voc.nextSign!.nameTr,
                  isDark,
                ),
            ],
          ),

          if (isVoid && voc.timeRemaining != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer_outlined, color: statusColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Kalan Sure: ${voc.timeRemainingFormatted}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),
          Text(
            isVoid
                ? 'Bu dönemde önemli kararlar almaktan ve yeni başlangıçlara girmekten kaçının.'
                : 'Ay aktif ve enerji akışında. Yeni başlangıçlara ve kararlara açık bir dönem.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMoonInfoItem(
    BuildContext context,
    String label,
    String symbol,
    String value,
    bool isDark,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 6),
        Text(symbol, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWhatIsVoc(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.7)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: AppColors.mysticBlue, size: 24),
              const SizedBox(width: 10),
              Text(
                'Void of Course Ay Nedir?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Void of Course (VOC), Ay\'ın bulunduğu burçta son major aspektini yaptıktan sonra bir sonraki burca geçene kadar geçen süredir. Bu dönemde Ay hiçbir gezegenle önemli bir açı yapmaz.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'VOC dönemlerinde başlatılan projeler, alınan kararlar ve yapılan planlar genellikle beklenilen sonuçları vermez veya hiçbir sonuca ulaşmaz.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDosDonts(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildRecommendationCard(
            context,
            'Yapilmasi Uygun',
            Icons.check_circle_outline,
            AppColors.success,
            [
              'Meditasyon ve ic gozlem',
              'Rutin isler ve temizlik',
              'Dinlenme ve rahatlama',
              'Eski projeleri tamamlama',
              'Planlama ve arastirma',
              'Yaratici calismalar',
            ],
            isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildRecommendationCard(
            context,
            'Kaçınılması Gereken',
            Icons.cancel_outlined,
            AppColors.error,
            [
              'Yeni iş başlatmak',
              'Önemli kararlar almak',
              'Sözleşme imzalamak',
              'İş görüşmeleri',
              'Evlilik teklifi',
              'Büyük alışverişler',
            ],
            isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<String> items,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•', style: TextStyle(color: color, fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
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

  Widget _buildUpcomingPeriods(
    BuildContext context,
    List<VoidOfCourseMoon> periods,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.7)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: AppColors.starGold, size: 24),
              const SizedBox(width: 10),
              Text(
                'Yaklasan VOC Donemleri',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (periods.isEmpty)
            Text(
              'Yaklasan VOC donemi bulunamadi.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            )
          else
            ...periods
                .take(5)
                .map((voc) => _buildVocPeriodItem(context, voc, isDark)),
        ],
      ),
    );
  }

  Widget _buildVocPeriodItem(
    BuildContext context,
    VoidOfCourseMoon voc,
    bool isDark,
  ) {
    final start = voc.startTime;
    final end = voc.endTime;

    if (start == null || end == null) return const SizedBox.shrink();

    final dayNames = ['Paz', 'Pzt', 'Sal', 'Car', 'Per', 'Cum', 'Cmt'];
    final dayName = dayNames[start.weekday % 7];
    final duration = voc.durationHours;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withOpacity(0.1)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${start.day}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dayName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.warning),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_formatTime(start)} - ${_formatTime(end)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${voc.currentSign.symbol} ${voc.currentSign.nameTr}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    if (voc.nextSign != null) ...[
                      const Text(' → '),
                      Text(
                        '${voc.nextSign!.symbol} ${voc.nextSign!.nameTr}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (duration != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${duration.toStringAsFixed(1)}s',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
