import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/extended_horoscope.dart';
import '../../../data/services/extended_horoscope_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

class MonthlyHoroscopeScreen extends StatefulWidget {
  final String? signName;

  const MonthlyHoroscopeScreen({super.key, this.signName});

  @override
  State<MonthlyHoroscopeScreen> createState() => _MonthlyHoroscopeScreenState();
}

class _MonthlyHoroscopeScreenState extends State<MonthlyHoroscopeScreen> {
  late ZodiacSign _selectedSign;
  late MonthlyHoroscope _horoscope;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedSign = widget.signName != null
        ? ZodiacSign.values.firstWhere(
            (s) => s.name.toLowerCase() == widget.signName!.toLowerCase(),
            orElse: () => ZodiacSign.aries,
          )
        : ZodiacSign.aries;
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
    _loadHoroscope();
  }

  void _loadHoroscope() {
    _horoscope = ExtendedHoroscopeService.generateMonthlyHoroscope(
      _selectedSign,
      _selectedMonth,
      _selectedYear,
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedMonth += delta;
      if (_selectedMonth > 12) {
        _selectedMonth = 1;
        _selectedYear++;
      } else if (_selectedMonth < 1) {
        _selectedMonth = 12;
        _selectedYear--;
      }
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
              _buildMonthSelector(isDark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  child: Column(
                    children: [
                      _buildSignSelector(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildOverviewCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildWeeklyRatingsCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildCategoryCards(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildSpiritualCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildTransitsCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildMantraCard(isDark),
                      const SizedBox(height: AppConstants.spacingXxl),
                      // Quiz CTA - Google Discover Funnel
                      QuizCTACard.astrology(compact: true),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Entertainment Disclaimer
                      const PageFooterWithDisclaimer(
                        brandText: 'Aylık Burç — Venus One',
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
              'Bu ay seni ne bekliyor?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector(bool isDark) {
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
            onPressed: () => _changeMonth(-1),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
          Text(
            '${_horoscope.monthName} $_selectedYear',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(1),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildSignSelector(bool isDark) {
    return SizedBox(
      height: 56, // Küçültüldü: 80 -> 56
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
              width: 52, // Küçültüldü: 70 -> 52
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
                  Text(
                    sign.symbol,
                    style: const TextStyle(
                      fontSize: 20,
                    ), // Küçültüldü: 24 -> 20
                  ),
                  Text(
                    sign.nameTr,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 10,
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
            AppColors.twilightStart.withValues(alpha: isDark ? 0.3 : 0.15),
            AppColors.twilightEnd.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: AppColors.twilightStart.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _selectedSign.symbol,
                style: const TextStyle(fontSize: 26), // Küçültüldü: 32 -> 26
              ),
              const SizedBox(width: AppConstants.spacingSm),
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
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _horoscope.luckyDays.map((day) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingMd,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Text(
                  '$day. gün',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
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

  Widget _buildWeeklyRatingsCard(bool isDark) {
    final weeks = ['1. Hafta', '2. Hafta', '3. Hafta', '4. Hafta'];

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
          Text(
            'Haftalık Enerji Grafiği',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: List.generate(4, (index) {
              final rating = _horoscope.weeklyRatings['week${index + 1}'] ?? 3;
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      height: rating * 20.0,
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [AppColors.auroraStart, AppColors.auroraEnd],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      weeks[index],
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCards(bool isDark) {
    final categories = [
      {
        'icon': Icons.favorite,
        'title': 'Aşk',
        'content': _horoscope.loveMonth,
        'color': Colors.pink,
      },
      {
        'icon': Icons.work,
        'title': 'Kariyer',
        'content': _horoscope.careerMonth,
        'color': Colors.blue,
      },
      {
        'icon': Icons.health_and_safety,
        'title': 'Sağlık',
        'content': _horoscope.healthMonth,
        'color': Colors.green,
      },
      {
        'icon': Icons.attach_money,
        'title': 'Finans',
        'content': _horoscope.financialMonth,
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

  Widget _buildSpiritualCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withValues(alpha: isDark ? 0.3 : 0.15),
            Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
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
                child: const Icon(
                  Icons.self_improvement,
                  color: Colors.purple,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Ruhsal Rehberlik',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _horoscope.spiritualGuidance,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTransitsCard(bool isDark) {
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
                  color: AppColors.auroraStart.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.blur_circular,
                  color: AppColors.auroraStart,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                'Gezegen Transitler',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _horoscope.keyTransits,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMantraCard(bool isDark) {
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
            'Aylık Mantra',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '"${_horoscope.monthlyMantra}"',
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
