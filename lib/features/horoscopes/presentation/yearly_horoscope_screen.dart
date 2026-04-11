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

class YearlyHoroscopeScreen extends StatefulWidget {
  final String? signName;

  const YearlyHoroscopeScreen({super.key, this.signName});

  @override
  State<YearlyHoroscopeScreen> createState() => _YearlyHoroscopeScreenState();
}

class _YearlyHoroscopeScreenState extends State<YearlyHoroscopeScreen> {
  late ZodiacSign _selectedSign;
  late YearlyHoroscope _horoscope;
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
    _selectedYear = DateTime.now().year;
    _loadHoroscope();
  }

  void _loadHoroscope() {
    _horoscope = ExtendedHoroscopeService.generateYearlyHoroscope(
      _selectedSign,
      _selectedYear,
    );
  }

  void _changeYear(int delta) {
    setState(() {
      _selectedYear += delta;
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
              _buildYearSelector(isDark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  child: Column(
                    children: [
                      _buildSignSelector(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      _buildOverviewCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildThemeCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildMonthlyChart(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildCategoryCards(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildTransitsCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildLuckyMonthsCard(isDark),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildAffirmationCard(isDark),
                      const SizedBox(height: AppConstants.spacingXxl),
                      // Quiz CTA - Google Discover Funnel
                      QuizCTACard.astrology(compact: true),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Entertainment Disclaimer
                      const PageFooterWithDisclaimer(
                        brandText: 'Yıllık Burç — Venus One',
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
              'Bu yıl seni ne bekliyor?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.starGold.withValues(alpha: isDark ? 0.3 : 0.15),
            AppColors.celestialGold.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeYear(-1),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
          Text(
            '$_selectedYear',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeYear(1),
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
                    ? AppColors.starGold.withValues(alpha: 0.3)
                    : isDark
                    ? AppColors.surfaceLight.withValues(alpha: 0.2)
                    : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                border: isSelected
                    ? Border.all(color: AppColors.starGold, width: 2)
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
            AppColors.starGold.withValues(alpha: isDark ? 0.3 : 0.15),
            AppColors.celestialGold.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _selectedSign.symbol,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
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
                  Text(
                    '$_selectedYear Kozmik Özeti',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.starGold),
                  ),
                ],
              ),
              const Spacer(),
              _buildRatingBadge(_horoscope.overallRating),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            _horoscope.yearOverview,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(int rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.starGold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColors.starGold, size: 16),
          const SizedBox(width: 4),
          Text(
            '$rating/5',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.starGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(bool isDark) {
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
        children: [
          const Icon(Icons.auto_awesome, color: Colors.purple, size: 32),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Yılın Teması',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.purple),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            _horoscope.keyTheme,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(bool isDark) {
    final months = ['O', 'S', 'M', 'N', 'M', 'H', 'T', 'A', 'E', 'E', 'K', 'A'];

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
            'Aylık Enerji Haritası',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                final rating = _horoscope.monthlyRatings[index + 1] ?? 3;
                final isCurrentMonth =
                    index + 1 == DateTime.now().month &&
                    _selectedYear == DateTime.now().year;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$rating',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isCurrentMonth
                                    ? AppColors.starGold
                                    : null,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: rating * 18.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: isCurrentMonth
                                  ? [
                                      AppColors.starGold,
                                      AppColors.celestialGold,
                                    ]
                                  : [
                                      AppColors.auroraStart,
                                      AppColors.auroraEnd,
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: isCurrentMonth
                                ? Border.all(
                                    color: AppColors.starGold,
                                    width: 2,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          months[index],
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontWeight: isCurrentMonth
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isCurrentMonth
                                    ? AppColors.starGold
                                    : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
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
        'content': _horoscope.loveYear,
        'color': Colors.pink,
      },
      {
        'icon': Icons.work,
        'title': 'Kariyer',
        'content': _horoscope.careerYear,
        'color': Colors.blue,
      },
      {
        'icon': Icons.health_and_safety,
        'title': 'Sağlık',
        'content': _horoscope.healthYear,
        'color': Colors.green,
      },
      {
        'icon': Icons.attach_money,
        'title': 'Finans',
        'content': _horoscope.financialYear,
        'color': Colors.amber,
      },
      {
        'icon': Icons.self_improvement,
        'title': 'Ruhsal Yolculuk',
        'content': _horoscope.spiritualJourney,
        'color': Colors.purple,
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
                'Önemli Gezegen Transitleri',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._horoscope.majorTransits.map((transit) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.auroraStart,
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: Text(
                      transit,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.5),
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

  Widget _buildLuckyMonthsCard(bool isDark) {
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
            'Yılın Özel Ayları',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Şanslı Aylar',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: _horoscope.luckyMonths.map((month) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            month,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_amber,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Dikkat Gerektiren',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: _horoscope.challengingMonths.map((month) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            month,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            'Yıllık Afirmasyon',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '"${_horoscope.yearlyAffirmation}"',
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
