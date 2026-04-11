import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/entertainment_disclaimer.dart';

/// Tekrar Eden Rüyalar Neden Olur? - AI-First Canonical Sayfa
class DreamRecurringScreen extends StatelessWidget {
  const DreamRecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D0D1A), const Color(0xFF1A1A2E)]
                : [const Color(0xFFFAF8FF), const Color(0xFFF5F0FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: isDark ? Colors.white70 : AppColors.textDark,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Tekrar eden rüyalar neden olur?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.2,
                  ),
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mystic.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Rüya İzi',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.mystic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Kısa Cevap',
                  color: AppColors.mystic,
                  bullets: [
                    'Tekrar eden rüyalar çözülmemiş bir konuya işaret eder.',
                    'Bilinçaltı, dikkatini çekmeye çalışıyor.',
                    'Mesaj anlaşılana kadar tekrar eder.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Neden Tekrar Eder?',
                  color: AppColors.mystic,
                  bullets: [
                    'İşlenmemiş bir duygu veya travma.',
                    'Hayatında süregelen bir stres kaynağı.',
                    'Bastırılmış bir korku veya arzu.',
                    'Önemli bir karar vermekten kaçınmak.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Ne Yapmalısın?',
                  color: AppColors.mystic,
                  bullets: [
                    'Rüyayı not al, detayları kaydet.',
                    'Hangi duyguyu hissettirdiğini sorgula.',
                    'Hayatında neyle bağlantılı olabileceğini düşün.',
                    'Konuyu bilinçli olarak ele almaya çalış.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Ne Zaman Durur?',
                  color: AppColors.mystic,
                  bullets: [
                    'Mesajı anladığında.',
                    'İlgili konuda adım attığında.',
                    'Duygusal yükü bıraktığında.',
                  ],
                ),

                const SizedBox(height: 32),

                _buildSuggestionBox(context, isDark),

                const SizedBox(height: 40),

                const PageFooterWithDisclaimer(
                  brandText: 'Rüya İzi — Venus One',
                  disclaimerText: DisclaimerTexts.dreams,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuotableSection({
    required bool isDark,
    required String title,
    required Color color,
    required List<String> bullets,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? color : color.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 12),
        ...bullets.map(
          (bullet) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white54 : AppColors.textLight,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: isDark ? Colors.white70 : AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSuggestionBox(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => context.push(Routes.dreamFalling),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : AppColors.mystic.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : AppColors.mystic.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Text('🌀', style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bunu da keşfet',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white38 : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rüyada düşmek ne demek?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isDark ? Colors.white38 : AppColors.textLight,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }
}
