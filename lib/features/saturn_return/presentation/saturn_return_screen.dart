import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Saturn Return Calculator Screen
/// Saturn takes ~29.5 years to complete one orbit
/// Returns occur around ages 27-30, 57-60, and 87-90
class SaturnReturnScreen extends ConsumerStatefulWidget {
  const SaturnReturnScreen({super.key});

  @override
  ConsumerState<SaturnReturnScreen> createState() => _SaturnReturnScreenState();
}

class _SaturnReturnScreenState extends ConsumerState<SaturnReturnScreen> {
  late SaturnReturnData _returnData;

  @override
  void initState() {
    super.initState();
    _calculateReturns();
  }

  void _calculateReturns() {
    final userProfile = ref.read(userProfileProvider);
    final birthDate = userProfile?.birthDate ?? DateTime(1990, 1, 1);
    _returnData = SaturnReturnCalculator.calculate(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    // Watch for profile changes to recalculate
    ref.watch(userProfileProvider);

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildCurrentStatus(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildReturnsList(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildInterpretation(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildSaturnInfo(context),
                const SizedBox(height: AppConstants.spacingXl),
                // Kadim Not
                KadimNotCard(
                  category: KadimCategory.astrology,
                  title: 'Olgunlaşma Sınavı',
                  content:
                      'Satürn Dönüşü, astrolojinin en önemli yaşam geçişlerinden biridir. 29.5 yılda '
                      'bir gerçekleşen bu döngü, antik çağlardan beri "olgunlaşma sınavı" olarak bilinir. '
                      'Romalılar Satürn\'ü zaman tanrısı Kronos ile özdeşleştirirdi - biçtiğin şeyi '
                      'toplarsın. Bu dönem seni otantik benliğine çağırır.',
                  icon: Icons.loop,
                ),
                const SizedBox(height: AppConstants.spacingXl),
                // Next Blocks
                const NextBlocks(currentPage: 'saturn_return'),
                const SizedBox(height: AppConstants.spacingXl),
                // Entertainment Disclaimer
                const PageFooterWithDisclaimer(
                  brandText: 'Satürn Dönüşü — Venus One',
                  disclaimerText: DisclaimerTexts.astrology,
                ),
                const SizedBox(height: AppConstants.spacingLg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Satürn Dönüşü',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Yaşamın Dönüşüm Noktaları',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.saturnColor.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Text(
            '♄',
            style: TextStyle(fontSize: 28, color: AppColors.saturnColor),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCurrentStatus(BuildContext context) {
    final currentReturn = _returnData.getCurrentReturn();
    final nextReturn = _returnData.getNextReturn();
    final isInReturn = currentReturn != null && currentReturn.isActive;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isInReturn
              ? [AppColors.saturnColor.withAlpha(40), AppColors.surfaceDark]
              : [AppColors.moonSilver.withAlpha(20), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isInReturn
              ? AppColors.saturnColor.withAlpha(80)
              : AppColors.moonSilver.withAlpha(40),
        ),
      ),
      child: Column(
        children: [
          if (isInReturn) ...[
            // Currently in Saturn Return
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.saturnColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.saturnColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'AKTIF',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.saturnColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${currentReturn.returnNumber}. Donus',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.saturnColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Satürn Dönüşündesin!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getActiveReturnMessage(currentReturn.returnNumber),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ] else if (nextReturn != null) ...[
            // Countdown to next return
            Text(
              'Sıradaki Satürn Dönüşü',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              '${nextReturn.returnNumber}. Donus',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.starGold,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            _buildCountdown(context, nextReturn),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              _formatDateRange(nextReturn.startDate, nextReturn.endDate),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ] else if (_returnData.returns.isEmpty) ...[
            Text(
              'Saturn donusleriniz tamamlandi',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildCountdown(BuildContext context, SaturnReturn returnData) {
    final now = DateTime.now();
    final daysUntil = returnData.startDate.difference(now).inDays;
    final yearsUntil = (daysUntil / 365).floor();
    final monthsUntil = ((daysUntil % 365) / 30).floor();
    final remainingDays = daysUntil % 30;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (yearsUntil > 0) ...[
          _CountdownUnit(value: yearsUntil, label: 'Yil'),
          const SizedBox(width: 16),
        ],
        if (monthsUntil > 0 || yearsUntil > 0) ...[
          _CountdownUnit(value: monthsUntil, label: 'Ay'),
          const SizedBox(width: 16),
        ],
        _CountdownUnit(value: remainingDays, label: 'Gun'),
      ],
    );
  }

  Widget _buildReturnsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saturn Donuslerin',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        ..._returnData.returns.asMap().entries.map((entry) {
          final index = entry.key;
          final returnItem = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            child: _buildReturnCard(context, returnItem),
          ).animate().fadeIn(delay: (200 + index * 100).ms, duration: 400.ms);
        }),
      ],
    );
  }

  Widget _buildReturnCard(BuildContext context, SaturnReturn returnItem) {
    final isPast = returnItem.isPast;
    final isActive = returnItem.isActive;

    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (isActive) {
      statusColor = AppColors.saturnColor;
      statusText = 'Aktif';
      statusIcon = Icons.radio_button_checked;
    } else if (isPast) {
      statusColor = Colors.green;
      statusText = 'Tamamlandi';
      statusIcon = Icons.check_circle;
    } else {
      statusColor = AppColors.textMuted;
      statusText = 'Bekliyor';
      statusIcon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.saturnColor.withAlpha(20)
            : AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(
          color: isActive
              ? AppColors.saturnColor.withAlpha(60)
              : AppColors.surfaceLight.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${returnItem.returnNumber}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${returnItem.returnNumber}. Saturn Donusu',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDateRange(returnItem.startDate, returnItem.endDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Yas: ${returnItem.ageAtReturn}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, size: 14, color: statusColor),
                const SizedBox(width: 4),
                Text(
                  statusText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretation(BuildContext context) {
    final currentOrNext =
        _returnData.getCurrentReturn() ?? _returnData.getNextReturn();
    if (currentOrNext == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.starGold.withAlpha(20), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.starGold,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${currentOrNext.returnNumber}. Donus Yorumu',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _getReturnInterpretation(currentOrNext.returnNumber),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Anahtar Temalar:',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.starGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _getReturnThemes(currentOrNext.returnNumber)
                .map(
                  (theme) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.starGold.withAlpha(20),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.starGold.withAlpha(40),
                      ),
                    ),
                    child: Text(
                      theme,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.starGold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  Widget _buildSaturnInfo(BuildContext context) {
    return Container(
      width: double.infinity,
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
              Text(
                '♄',
                style: TextStyle(fontSize: 24, color: AppColors.saturnColor),
              ),
              const SizedBox(width: 8),
              Text(
                'Saturn Hakkinda',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoRow(context, 'Yörünge Süresi', '29.5 yıl'),
          _buildInfoRow(
            context,
            'Temsil Ettiği',
            'Sorumluluk, olgunluk, sınırlar',
          ),
          _buildInfoRow(context, 'Ev', 'Oğlak (10. ev)'),
          _buildInfoRow(context, 'Element', 'Toprak'),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Satürn, kozmik öğretmendir. Dönüşlerinde bizi sınırlarımızla, sorumluluklarımızla ve gerçek benliğimizle yüzleştirir.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final months = [
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
    return '${months[start.month - 1]} ${start.year} - ${months[end.month - 1]} ${end.year}';
  }

  String _getActiveReturnMessage(int returnNumber) {
    switch (returnNumber) {
      case 1:
        return 'Yetişkinliğe geçiş döneminde, kariyerini ve hayat yönünü belirliyorsun. Bu dönem zorlu olabilir ama seni güçlendirecek.';
      case 2:
        return 'Yaşamın ikinci yarısına geçiş. Gerçek önceliklerin netleşiyor, bilgeliği deneyimle birleştiriyorsun.';
      case 3:
        return 'Mirası ve yaşam amacını gözden geçirme zamanı. Bilgeliğini gelecek nesillere aktarıyorsun.';
      default:
        return 'Önemli bir yaşam dönüşümündesin.';
    }
  }

  String _getReturnInterpretation(int returnNumber) {
    switch (returnNumber) {
      case 1:
        return 'İlk Satürn Dönüşü (27-30 yaş), yetişkinliğe geçiş kapısıdır. Bu dönemde gençlikteki hayallerle gerçeklik arasında bir dengeleme yaşarsın. Kariyer, ilişkiler ve yaşam amacı konusunda önemli kararlar alınır. Satürn seni sınırlarınla yüzleştirir ve gerçek potansiyelini ortaya çıkarmana yardımcı olur.';
      case 2:
        return 'İkinci Satürn Dönüşü (57-60 yaş), yaşamın ikinci yarısına geçiştir. Bu dönemde gerçekten neyin önemli olduğunu anlarsın. Kariyerin zirvesinden bilgeliği paylaşma aşamasına geçiş olur. Fiziksel ve duygusal sağlık ön plana çıkar.';
      case 3:
        return 'Üçüncü Satürn Dönüşü (87-90 yaş), yaşam mirasının değerlendirilmesi zamanıdır. Bilgeliğin ve deneyimlerin gelecek nesillere aktarılır. Ruhsal olgunluk ve iç huzur bu dönemin armağanlarıdır.';
      default:
        return '';
    }
  }

  List<String> _getReturnThemes(int returnNumber) {
    switch (returnNumber) {
      case 1:
        return ['Kariyer', 'Bağımsızlık', 'Sorumluluk', 'Kimlik', 'Sınırlar'];
      case 2:
        return ['Miras', 'Bilgelik', 'Sağlık', 'Öncelikler', 'Anlam'];
      case 3:
        return ['Kabul', 'Huzur', 'Aktarım', 'Tamamlanma', 'Ruhsallık'];
      default:
        return [];
    }
  }
}

class _CountdownUnit extends StatelessWidget {
  final int value;
  final String label;

  const _CountdownUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.starGold.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.starGold.withAlpha(40)),
          ),
          child: Center(
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.starGold,
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
}

/// Saturn Return Calculator
class SaturnReturnCalculator {
  /// Saturn's orbital period in years
  static const double saturnOrbitalPeriod = 29.457;

  /// Calculate all Saturn Returns for a given birth date
  static SaturnReturnData calculate(DateTime birthDate) {
    final returns = <SaturnReturn>[];

    for (int i = 1; i <= 3; i++) {
      final exactReturnAge = saturnOrbitalPeriod * i;
      final startAge =
          exactReturnAge -
          1.5; // Saturn return period starts ~1.5 years before exact
      final endAge = exactReturnAge + 1.0; // And ends ~1 year after

      final startDate = birthDate.add(
        Duration(days: (startAge * 365.25).round()),
      );
      final endDate = birthDate.add(Duration(days: (endAge * 365.25).round()));

      returns.add(
        SaturnReturn(
          returnNumber: i,
          startDate: startDate,
          endDate: endDate,
          exactDate: birthDate.add(
            Duration(days: (exactReturnAge * 365.25).round()),
          ),
          ageAtReturn: exactReturnAge.round(),
        ),
      );
    }

    return SaturnReturnData(birthDate: birthDate, returns: returns);
  }
}

/// Saturn Return Data Container
class SaturnReturnData {
  final DateTime birthDate;
  final List<SaturnReturn> returns;

  SaturnReturnData({required this.birthDate, required this.returns});

  /// Get currently active Saturn Return (if any)
  SaturnReturn? getCurrentReturn() {
    for (final ret in returns) {
      if (ret.isActive) return ret;
    }
    return null;
  }

  /// Get next upcoming Saturn Return
  SaturnReturn? getNextReturn() {
    for (final ret in returns) {
      if (ret.isFuture) return ret;
    }
    return null;
  }
}

/// Individual Saturn Return
class SaturnReturn {
  final int returnNumber;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime exactDate;
  final int ageAtReturn;

  SaturnReturn({
    required this.returnNumber,
    required this.startDate,
    required this.endDate,
    required this.exactDate,
    required this.ageAtReturn,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  bool get isPast => DateTime.now().isAfter(endDate);
  bool get isFuture => DateTime.now().isBefore(startDate);
}
