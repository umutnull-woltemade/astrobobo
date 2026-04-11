import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/extended_horoscope.dart';
import '../../../data/services/extended_horoscope_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

class WeeklyHoroscopeScreen extends StatefulWidget {
  final String? signName;

  const WeeklyHoroscopeScreen({super.key, this.signName});

  @override
  State<WeeklyHoroscopeScreen> createState() => _WeeklyHoroscopeScreenState();
}

class _WeeklyHoroscopeScreenState extends State<WeeklyHoroscopeScreen> {
  late ZodiacSign _selectedSign;
  late WeeklyHoroscope _horoscope;
  late DateTime _weekStart;

  @override
  void initState() {
    super.initState();
    _selectedSign = widget.signName != null
        ? ZodiacSign.values.firstWhere(
            (s) => s.name.toLowerCase() == widget.signName!.toLowerCase(),
            orElse: () => ZodiacSign.aries,
          )
        : ZodiacSign.aries;
    _weekStart = _getWeekStart(DateTime.now());
    _loadHoroscope();
  }

  DateTime _getWeekStart(DateTime date) {
    final dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek - 1));
  }

  void _loadHoroscope() {
    _horoscope = ExtendedHoroscopeService.generateWeeklyHoroscope(
      _selectedSign,
      _weekStart,
    );
  }

  void _changeWeek(int delta) {
    setState(() {
      _weekStart = _weekStart.add(Duration(days: delta * 7));
      _loadHoroscope();
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
              _buildWeekSelector(isDark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  child: Column(
                    children: [
                      _buildSignSelector(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildOverviewCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildCategoryCards(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildKeyDatesCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildAffirmationCard(isDark),
                      const SizedBox(height: AppConstants.spacingXxl),
                      // Quiz CTA - Google Discover Funnel
                      QuizCTACard.astrology(compact: true),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Next Blocks
                      NextBlocks(
                        currentPage: 'weekly_horoscope',
                        signName: _selectedSign.name,
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Entertainment Disclaimer
                      const PageFooterWithDisclaimer(
                        brandText: 'Haftalık Burç — Venus One',
                        disclaimerText: DisclaimerTexts.astrology,
                      ),
                      const SizedBox(height: AppConstants.spacingLg),
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
            child: Text(
              'Bu hafta seni ne bekliyor?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekSelector(bool isDark) {
    final weekEnd = _weekStart.add(const Duration(days: 6));
    final dateFormat =
        '${_weekStart.day}.${_weekStart.month} - ${weekEnd.day}.${weekEnd.month}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
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
            onPressed: () => _changeWeek(-1),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
          Text(
            dateFormat,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeWeek(1),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildSignSelector(bool isDark) {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ZodiacSign.values.length,
        itemBuilder: (context, index) {
          final sign = ZodiacSign.values[index];
          final isSelected = sign == _selectedSign;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSign = sign;
                _loadHoroscope();
              });
            },
            child: Container(
              width: 52,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.auroraStart.withValues(alpha: 0.3)
                    : isDark
                    ? AppColors.surfaceLight.withValues(alpha: 0.2)
                    : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                border: isSelected
                    ? Border.all(color: AppColors.auroraStart, width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(sign.symbol, style: const TextStyle(fontSize: 20)),
                  Text(
                    sign.nameTr,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withValues(alpha: isDark ? 0.3 : 0.15),
            AppColors.auroraEnd.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.auroraStart.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(_selectedSign.symbol, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: AppConstants.spacingMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedSign.nameTr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildRatingStars(_horoscope.overallRating),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingMd,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Text(
                  'Şans Günü: ${_horoscope.luckyDay}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            _horoscope.overview,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.starGold,
          size: 16,
        );
      }),
    );
  }

  Widget _buildCategoryCards(bool isDark) {
    final categories = [
      {
        'icon': Icons.favorite,
        'title': 'Aşk',
        'content': _horoscope.loveWeek,
        'color': Colors.pink,
      },
      {
        'icon': Icons.work,
        'title': 'Kariyer',
        'content': _horoscope.careerWeek,
        'color': Colors.blue,
      },
      {
        'icon': Icons.health_and_safety,
        'title': 'Sağlık',
        'content': _horoscope.healthWeek,
        'color': Colors.green,
      },
      {
        'icon': Icons.attach_money,
        'title': 'Finans',
        'content': _horoscope.financialWeek,
        'color': Colors.amber,
      },
    ];

    return Column(
      children: categories.map((cat) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceLight.withValues(alpha: 0.2)
                : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: cat['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Text(
                    cat['title'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Text(
                cat['content'] as String,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyDatesCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.twilightStart.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.twilightStart,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Önemli Tarihler',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._horoscope.keyDates.map((date) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: AppColors.starGold),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium,
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

  Widget _buildAffirmationCard(bool isDark) {
    return Container(
      width: double.infinity,
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
          const Icon(Icons.auto_awesome, color: AppColors.starGold, size: 32),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Haftalık Afirmasyon',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '"${_horoscope.weeklyAffirmation}"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
