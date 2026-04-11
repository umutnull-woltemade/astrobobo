import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/entertainment_disclaimer.dart';

/// Rüyada Düşmek Ne Demek? - AI-First Canonical Sayfa
/// H1: Soru formatı
/// İlk 3 bullet: Direkt cevap
/// AI alıntılanabilir format
class DreamFallingScreen extends StatelessWidget {
  const DreamFallingScreen({super.key});

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
                ? [const Color(0xFF0D0D1A), const Color(0xFF1A0A2E)]
                : [const Color(0xFFFAF8FF), const Color(0xFFF0E8FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: isDark ? Colors.white70 : AppColors.textDark,
                  ),
                ),

                const SizedBox(height: 24),

                // H1 - Soru formatı
                Text(
                  'Rüyada düşmek ne demek?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.2,
                  ),
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 8),

                // Branded tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cosmicPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Rüya İzi',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.cosmicPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // İlk 3 bullet - Direkt cevap (AI quotable)
                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Kısa Cevap',
                  bullets: [
                    'Düşme rüyası genellikle kontrol kaybı hissini yansıtır.',
                    'Hayatta bir şeylerin elimizden kaydığını düşündüğümüzde ortaya çıkar.',
                    'Düşerken uyanmak, bilinçaltının seni uyandırma refleksidir.',
                  ],
                ),

                const SizedBox(height: 28),

                // Anlam bölümü
                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Ne Anlama Gelir?',
                  bullets: [
                    'Belirsizlik dönemlerinde daha sık görülür.',
                    'İş, ilişki veya sağlık konusunda endişe taşıyor olabilirsin.',
                    'Düşüşün hızı, kaygının yoğunluğunu gösterir.',
                  ],
                ),

                const SizedBox(height: 28),

                // Duygu bölümü
                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Hangi Duyguyu Taşır?',
                  bullets: [
                    'Güvensizlik veya yetersizlik hissi.',
                    'Başarısızlık korkusu.',
                    'Destek arayışı.',
                  ],
                ),

                const SizedBox(height: 28),

                // Tekrar bölümü
                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Tekrar Ediyorsa',
                  bullets: [
                    'Çözülmemiş bir kaygı işaret eder.',
                    'Hayatında neyin seni dengesiz hissettirdiğine bak.',
                    'Kontrol edemediğin durumları kabul etmek rahatlatabilir.',
                  ],
                ),

                const SizedBox(height: 32),

                // Öneri kutusu - tek iç link
                _buildSuggestionBox(context, isDark),

                const SizedBox(height: 40),

                // Footer with disclaimer
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
            color: isDark ? AppColors.starGold : AppColors.cosmicPurple,
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
      onTap: () => context.push(Routes.dreamWater),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : AppColors.cosmicPurple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : AppColors.cosmicPurple.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Text('💧', style: const TextStyle(fontSize: 24)),
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
                    'Rüyada su görmek ne anlama gelir?',
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
