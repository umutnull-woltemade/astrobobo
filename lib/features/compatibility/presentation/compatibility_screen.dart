import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/horoscope.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/horoscope_service.dart';
import '../../../data/services/localization_service.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

class CompatibilityScreen extends ConsumerStatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  ConsumerState<CompatibilityScreen> createState() =>
      _CompatibilityScreenState();
}

class _CompatibilityScreenState extends ConsumerState<CompatibilityScreen> {
  ZodiacSign? _sign1;
  ZodiacSign? _sign2;
  Compatibility? _result;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userProfile = ref.read(userProfileProvider);
    if (userProfile != null) {
      _sign1 = userProfile.sunSign;
    }
  }

  Future<void> _calculateCompatibility() async {
    if (_sign1 == null || _sign2 == null) return;

    setState(() => _isLoading = true);

    try {
      // Try API first
      final api = ref.read(astrologyApiProvider);
      final response = await api.compatibility.calculateSignCompatibility(
        sign1: _sign1!.name.toLowerCase(),
        sign2: _sign2!.name.toLowerCase(),
      );

      if (response.isSuccess && response.data != null) {
        final apiResult = response.data!;
        setState(() {
          _result = Compatibility(
            sign1: _sign1!,
            sign2: _sign2!,
            overallScore: apiResult.score.round(),
            loveScore: apiResult.score.round(),
            friendshipScore: apiResult.score.round(),
            communicationScore: apiResult.score.round(),
            summary: apiResult.description,
            strengths: apiResult.strengths,
            challenges: apiResult.challenges,
          );
          _isLoading = false;
        });
        return;
      }
    } catch (e) {
      debugPrint('API failed, using local calculation: $e');
    }

    // Fallback to local calculation
    final compatibility = HoroscopeService.calculateCompatibility(
      _sign1!,
      _sign2!,
    );
    setState(() {
      _result = compatibility;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final language = ref.watch(languageProvider);
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1F1A2E)
          : const Color(0xFFFFF0F5),
      body: Stack(
        children: [
          // Kalpli arka plan - tüm sayfayı kaplar
          Positioned.fill(child: _HeartPatternBackground(isDark: isDark)),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context, language),
                  Padding(
                    padding: const EdgeInsets.all(AppConstants.spacingLg),
                    child: Column(
                      children: [
                        _buildSignSelectors(),
                        const SizedBox(height: AppConstants.spacingXl),
                        if (_sign1 != null && _sign2 != null)
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.starGold,
                                  ),
                                )
                              : GradientButton(
                                  label: 'Uyumu Hesapla',
                                  icon: Icons.favorite,
                                  width: double.infinity,
                                  onPressed: _calculateCompatibility,
                                ).animate().fadeIn(duration: 300.ms),
                        if (_result != null) ...[
                          const SizedBox(height: AppConstants.spacingXxl),
                          _buildResult(),
                        ],
                      ],
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

  Widget _buildHeader(BuildContext context, AppLanguage language) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.textPrimary,
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Text(
            L10n.get('zodiac_analysis', language),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSignSelectors() {
    return Row(
      children: [
        Expanded(
          child: _SignSelector(
            label: 'Sizin Burcunuz',
            selectedSign: _sign1,
            onSignSelected: (sign) {
              setState(() {
                _sign1 = sign;
                _result = null;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMd,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.fireElement.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              color: AppColors.fireElement,
              size: 24,
            ),
          ),
        ),
        Expanded(
          child: _SignSelector(
            label: 'Karşı Burç',
            selectedSign: _sign2,
            onSignSelected: (sign) {
              setState(() {
                _sign2 = sign;
                _result = null;
              });
            },
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildResult() {
    if (_result == null) return const SizedBox();

    final result = _result!;
    final scoreColor = _getScoreColor(result.overallScore);

    return Column(
      children: [
        // Score circle
        Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    scoreColor.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: scoreColor.withValues(alpha: 0.4),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${result.overallScore}%',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getScoreLabel(result.overallScore),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: scoreColor),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),

        const SizedBox(height: AppConstants.spacingXl),

        // Category scores
        Row(
          children: [
            Expanded(
              child: _ScoreCategory(
                icon: Icons.favorite,
                label: 'Aşk',
                score: result.loveScore,
              ),
            ),
            Expanded(
              child: _ScoreCategory(
                icon: Icons.people,
                label: 'Arkadaşlık',
                score: result.friendshipScore,
              ),
            ),
            Expanded(
              child: _ScoreCategory(
                icon: Icons.chat,
                label: 'İletişim',
                score: result.communicationScore,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

        const SizedBox(height: AppConstants.spacingXl),

        // Summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _sign1!.symbol,
                    style: TextStyle(fontSize: 24, color: _sign1!.color),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.add, color: AppColors.textMuted, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    _sign2!.symbol,
                    style: TextStyle(fontSize: 24, color: _sign2!.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${_sign1!.nameTr} & ${_sign2!.nameTr}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Text(
                result.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

        const SizedBox(height: AppConstants.spacingLg),

        // Güçlü Yanlar
        _buildListSection(
          context,
          'Güçlü Yanlar',
          Icons.thumb_up,
          AppColors.success,
          result.strengths,
        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

        const SizedBox(height: AppConstants.spacingMd),

        // Zorluklar
        _buildListSection(
          context,
          'Zorluklar',
          Icons.warning,
          AppColors.warning,
          result.challenges,
        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

        const SizedBox(height: AppConstants.spacingXl),

        // Detaylı burç açıklamaları
        _buildSignDescriptions(context, _sign1!, _sign2!),

        const SizedBox(height: AppConstants.spacingLg),

        // Kadim Not - Uyum bilgeliği
        const KadimNotCard(
          title: 'Kozmik Kimya',
          content:
              'İki burç arasındaki uyum, sadece element ve modalite hesabı değildir. Her ilişki, iki ruhun birbirini tamamlama ve dönüştürme potansiyelini taşır. Zorluklar, en büyük öğretmenlerdir.',
          category: KadimCategory.astrology,
          source: 'Astrolojik Uyum',
        ),
        const SizedBox(height: AppConstants.spacingXl),

        // Quiz CTA - Google Discover Funnel
        QuizCTACard.astrology(compact: true),
        const SizedBox(height: AppConstants.spacingXl),

        // Next Blocks - keşfetmeye devam et
        NextBlocks(
          currentPage: 'compatibility',
        ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
        const SizedBox(height: AppConstants.spacingLg),
        // Disclaimer
        const PageFooterWithDisclaimer(
          brandText: 'Burç Uyumu — Venus One',
          disclaimerText: DisclaimerTexts.compatibility,
        ),
      ],
    );
  }

  Widget _buildSignDescriptions(
    BuildContext context,
    ZodiacSign sign1,
    ZodiacSign sign2,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Burç Profilleri',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.starGold),
        ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
        const SizedBox(height: AppConstants.spacingMd),

        // Sign 1 description
        _buildSignDescriptionCard(
          context,
          sign1,
        ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
        const SizedBox(height: AppConstants.spacingMd),

        // Sign 2 description
        _buildSignDescriptionCard(
          context,
          sign2,
        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildSignDescriptionCard(BuildContext context, ZodiacSign sign) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sign.color.withValues(alpha: 0.15), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sign.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sign.color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  sign.symbol,
                  style: TextStyle(fontSize: 20, color: sign.color),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sign.nameTr,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: sign.color),
                    ),
                    Text(
                      '${sign.element.nameTr} elementi • ${sign.modality.nameTr}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            sign.detailedDescriptionTr,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sign.traits
                .map(
                  (trait) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: sign.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trait,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: sign.color),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<String> items,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.2)),
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
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(color: color)),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
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

  Color _getScoreColor(int score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.auroraStart;
    if (score >= 40) return AppColors.warning;
    return AppColors.error;
  }

  String _getScoreLabel(int score) {
    if (score >= 80) return 'Mükemmel Uyum';
    if (score >= 60) return 'İyi Uyum';
    if (score >= 40) return 'Orta Uyum';
    return 'Zorlu';
  }
}

class _SignSelector extends StatelessWidget {
  final String label;
  final ZodiacSign? selectedSign;
  final ValueChanged<ZodiacSign> onSignSelected;

  const _SignSelector({
    required this.label,
    required this.selectedSign,
    required this.onSignSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSignPicker(context),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          color: selectedSign != null
              ? selectedSign!.color.withValues(alpha: 0.15)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: selectedSign != null
                ? selectedSign!.color.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            if (selectedSign != null) ...[
              Text(
                selectedSign!.symbol,
                style: TextStyle(fontSize: 40, color: selectedSign!.color),
              ),
              const SizedBox(height: 8),
              Text(
                selectedSign!.nameTr,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: selectedSign!.color),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textMuted,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Seç',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSignPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text('Burç Seç', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppConstants.spacingLg),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: ZodiacSign.values.length,
                  itemBuilder: (context, index) {
                    final sign = ZodiacSign.values[index];
                    final isSelected = sign == selectedSign;

                    return GestureDetector(
                      onTap: () {
                        onSignSelected(sign);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? sign.color.withValues(alpha: 0.2)
                              : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? sign.color
                                : Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sign.symbol,
                              style: TextStyle(
                                fontSize: 24,
                                color: isSelected
                                    ? sign.color
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              sign.nameTr,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: isSelected
                                        ? sign.color
                                        : AppColors.textSecondary,
                                    fontSize: 9,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScoreCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final int score;

  const _ScoreCategory({
    required this.icon,
    required this.label,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(score);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          '$score%',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Color _getColor(int score) {
    if (score >= 70) return AppColors.success;
    if (score >= 50) return AppColors.auroraStart;
    return AppColors.warning;
  }
}

// Kalpli arka plan widget'ı
class _HeartPatternBackground extends StatelessWidget {
  final bool isDark;

  const _HeartPatternBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF2D1B3D),
                  const Color(0xFF1F1A2E),
                  const Color(0xFF2D1B3D),
                ]
              : [
                  const Color(0xFFFFF0F5),
                  const Color(0xFFFFE4EC),
                  const Color(0xFFFFF5F8),
                ],
        ),
      ),
      child: CustomPaint(
        painter: _HeartPatternPainter(isDark: isDark),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _HeartPatternPainter extends CustomPainter {
  final bool isDark;

  _HeartPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? Colors.pink : Colors.pink.shade200).withAlpha(
        isDark ? 15 : 25,
      )
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Deterministic random for consistency

    // Küçük kalpler çiz
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final heartSize = 8.0 + random.nextDouble() * 16;

      _drawHeart(canvas, Offset(x, y), heartSize, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();

    // Basit kalp şekli
    path.moveTo(center.dx, center.dy + size * 0.3);
    path.cubicTo(
      center.dx - size * 0.5,
      center.dy - size * 0.3,
      center.dx - size * 0.5,
      center.dy - size * 0.7,
      center.dx,
      center.dy - size * 0.3,
    );
    path.cubicTo(
      center.dx + size * 0.5,
      center.dy - size * 0.7,
      center.dx + size * 0.5,
      center.dy - size * 0.3,
      center.dx,
      center.dy + size * 0.3,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
