import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../domain/quiz_models.dart';
import '../domain/quiz_service.dart';

/// Quiz Screen - Google Discover → Quiz → Premium Funnel
/// Segmentasyon amaçlı kısa test ekranı
class QuizScreen extends ConsumerStatefulWidget {
  final String? quizType; // 'dream', 'astrology', 'numerology', 'general'
  final String? sourceContext; // Hangi sayfadan geldi

  const QuizScreen({super.key, this.quizType, this.sourceContext});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  late Quiz _currentQuiz;
  int _currentQuestionIndex = 0;
  final Map<int, int> _answers = {}; // questionIndex -> answerIndex
  bool _isLoading = true;
  QuizResult? _result;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    setState(() {
      _currentQuiz = QuizService.getQuiz(widget.quizType ?? 'general');
      _isLoading = false;
    });
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _answers[_currentQuestionIndex] = answerIndex;
    });

    // Kısa gecikme ile sonraki soruya geç
    Future.delayed(const Duration(milliseconds: 400), () {
      if (_currentQuestionIndex < _currentQuiz.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        _calculateResult();
      }
    });
  }

  void _calculateResult() {
    final result = QuizService.calculateResult(_currentQuiz, _answers);
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: _result != null
              ? _buildResultView(context, isDark)
              : _buildQuizView(context, isDark),
        ),
      ),
    );
  }

  Widget _buildQuizView(BuildContext context, bool isDark) {
    final question = _currentQuiz.questions[_currentQuestionIndex];
    final progress =
        (_currentQuestionIndex + 1) / _currentQuiz.questions.length;

    return Column(
      children: [
        // Header with progress
        Padding(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    '${_currentQuestionIndex + 1}/${_currentQuiz.questions.length}',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance
                ],
              ),
              const SizedBox(height: AppConstants.spacingMd),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark
                      ? AppColors.surfaceLight.withOpacity(0.3)
                      : AppColors.lightSurfaceVariant,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.auroraStart,
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),

        // Question
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingLg,
            ),
            child: Column(
              children: [
                const SizedBox(height: AppConstants.spacingXl),
                // Question icon/emoji
                if (question.emoji != null)
                  Text(
                    question.emoji!,
                    style: const TextStyle(fontSize: 48),
                  ).animate().scale(duration: 300.ms, curve: Curves.elasticOut),
                const SizedBox(height: AppConstants.spacingLg),
                // Question text
                Text(
                  question.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                    height: 1.4,
                  ),
                ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXl),
                // Answers
                ...question.answers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final answer = entry.value;
                  final isSelected = _answers[_currentQuestionIndex] == index;

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppConstants.spacingMd,
                    ),
                    child:
                        _buildAnswerCard(
                              context,
                              answer,
                              isSelected,
                              isDark,
                              () => _selectAnswer(index),
                            )
                            .animate(delay: (100 * index).ms)
                            .fadeIn()
                            .slideX(begin: 0.05),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerCard(
    BuildContext context,
    QuizAnswer answer,
    bool isSelected,
    bool isDark,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.auroraStart, AppColors.auroraEnd],
                )
              : null,
          color: isSelected
              ? null
              : isDark
              ? AppColors.surfaceLight.withOpacity(0.5)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : isDark
                ? AppColors.surfaceLight
                : AppColors.lightSurfaceVariant,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.auroraStart.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            if (answer.emoji != null) ...[
              Text(answer.emoji!, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
            ],
            Expanded(
              child: Text(
                answer.text,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(BuildContext context, bool isDark) {
    final result = _result!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          const SizedBox(height: AppConstants.spacingXl),
          // Result emoji/icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.auroraStart, AppColors.auroraEnd],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.auroraStart.withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(result.emoji, style: const TextStyle(fontSize: 48)),
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
          const SizedBox(height: AppConstants.spacingXl),

          // Result title
          Text(
            result.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.starGold : AppColors.lightStarGold,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: AppConstants.spacingMd),

          // Result description
          Text(
            result.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: AppConstants.spacingXl),

          // Segment-based CTA
          if (result.segment == QuizSegment.high) ...[
            _buildPremiumCTA(context, isDark),
          ] else if (result.segment == QuizSegment.medium) ...[
            _buildSoftPremiumCTA(context, isDark),
          ] else ...[
            _buildExploreCTA(context, isDark),
          ],
          const SizedBox(height: AppConstants.spacingLg),

          // Secondary action
          TextButton(
            onPressed: () => context.go('/home'),
            child: Text(
              'Ana Sayfaya Dön',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCTA(BuildContext context, bool isDark) {
    // seg=high için agresif premium teklif (%30-40 dönüşüm hedefi)
    return GestureDetector(
      onTap: () => context.push('/premium?source=quiz_high&discount=20'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.starGold, AppColors.auroraStart],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.starGold.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Özel indirim rozeti
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_offer, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'ÖZEL %20 İNDİRİM',
                    style: GoogleFonts.raleway(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            const Icon(Icons.auto_awesome, color: Colors.white, size: 32),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Kişisel Kozmik Haritanı Aç',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Profilin çok güçlü! Kişiselleştirilmiş içerikler seni bekliyor.',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Şimdi Başla',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.auroraStart,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.auroraStart,
                    size: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            // Urgency text
            Text(
              'Sadece bugün geçerli',
              style: GoogleFonts.raleway(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildSoftPremiumCTA(BuildContext context, bool isDark) {
    // seg=medium için soft premium teklif
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceLight.withOpacity(0.5)
                : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? AppColors.starGold.withOpacity(0.3)
                  : AppColors.lightStarGold.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              Text(
                'Kozmik yolculuğuna devam etmek ister misin?',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              GestureDetector(
                onTap: () => context.push('/premium'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.auroraStart, AppColors.auroraEnd],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Premium Özellikleri Gör',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextButton(
          onPressed: () => context.go('/home'),
          child: Text(
            'Ücretsiz içeriklerle devam et',
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildExploreCTA(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => context.go('/home'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.auroraStart.withOpacity(0.8),
              AppColors.auroraEnd.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore, color: Colors.white, size: 24),
            const SizedBox(width: AppConstants.spacingMd),
            Text(
              'Keşfetmeye Başla',
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
