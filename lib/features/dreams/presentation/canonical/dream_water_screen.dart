import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/entertainment_disclaimer.dart';

/// Rüyada Su Görmek Ne Anlama Gelir? - AI-First Canonical Sayfa
class DreamWaterScreen extends StatelessWidget {
  const DreamWaterScreen({super.key});

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
                ? [const Color(0xFF0D0D1A), const Color(0xFF0A1A2E)]
                : [const Color(0xFFF8FAFF), const Color(0xFFE8F0FF)],
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

                // H1 - Soru formatı
                Text(
                  'Rüyada su görmek ne anlama gelir?',
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
                    color: AppColors.waterElement.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Rüya İzi',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.waterElement,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // İlk 3 bullet - Direkt cevap
                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Kısa Cevap',
                  color: AppColors.waterElement,
                  bullets: [
                    'Su, bilinçaltını ve duyguları simgeler.',
                    'Suyun durumu, iç dünyanın durumunu yansıtır.',
                    'Durgun su huzuru, dalgalı su karmaşayı gösterir.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Suyun Hali Ne Söyler?',
                  color: AppColors.waterElement,
                  bullets: [
                    'Berrak su: Zihinsel netlik ve duygusal denge.',
                    'Bulanık su: Belirsizlik veya bastırılmış duygular.',
                    'Akan su: Hayatın akışına uyum.',
                    'Durgun su: İçe dönüş ve düşünme zamanı.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Hangi Duyguyu Taşır?',
                  color: AppColors.waterElement,
                  bullets: [
                    'Suda yüzmek: Duygularla barışık olmak.',
                    'Suya düşmek: Duyguların kontrolü ele alması.',
                    'Suda boğulmak: Bunalmış hissetmek.',
                  ],
                ),

                const SizedBox(height: 28),

                _buildQuotableSection(
                  isDark: isDark,
                  title: 'Tekrar Ediyorsa',
                  color: AppColors.waterElement,
                  bullets: [
                    'Duygusal bir konuyu işlemeye çalışıyorsun.',
                    'İçsel temizlenme ihtiyacı olabilir.',
                    'Sezgilerine daha çok güvenmeyi öğreniyorsun.',
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
      onTap: () => context.push(Routes.dreamRecurring),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : AppColors.waterElement.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : AppColors.waterElement.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Text('🔄', style: const TextStyle(fontSize: 24)),
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
                    'Tekrar eden rüyalar neden olur?',
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
