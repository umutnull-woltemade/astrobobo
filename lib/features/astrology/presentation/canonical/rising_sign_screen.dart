import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/entertainment_disclaimer.dart';

/// Yükselen Burç Nedir? - AI-First Canonical Sayfa
class RisingSignScreen extends StatelessWidget {
  const RisingSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = const Color(0xFFFF9800);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D0D1A), const Color(0xFF1A1208)]
                : [const Color(0xFFFFFCF5), const Color(0xFFFFF5E5)],
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
                  'Yükselen burç nedir?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.2,
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                _buildTag('Astroloji', color),
                const SizedBox(height: 32),

                _buildSection(isDark, 'Kısa Cevap', color, [
                  'Yükselen burç, doğum anında doğu ufkunda yükselen burçtur.',
                  'Dış dünyanın seni nasıl gördüğünü belirler.',
                  'Güneş burcundan farklıdır ve hesaplamak için doğum saati gerekir.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Ne Anlatır?', color, [
                  'İlk izlenimin: İnsanların seni ilk gördüğünde hissettikleri.',
                  'Fiziksel görünümün: Yüz hatları ve beden yapısını etkiler.',
                  'Savunma mekanizman: Yeni durumlarda nasıl davrandığın.',
                  'Hayata yaklaşımın: Dünyayla nasıl etkileşime geçtiğin.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Güneş Burcundan Farkı', color, [
                  'Güneş burcu: Özün, kim olduğun.',
                  'Yükselen burç: Masken, nasıl göründüğün.',
                  'Ay burcu: Duyguların, ne hissettiğin.',
                  'Üçü birlikte: Tam astrolojik profil.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Nasıl Hesaplanır?', color, [
                  'Kesin doğum saati gereklidir.',
                  'Doğum yeri koordinatları kullanılır.',
                  'Yaklaşık her 2 saatte bir yükselen değişir.',
                  'Doğum saati bilinmiyorsa hesaplanamaz.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Neden Önemli?', color, [
                  'Haritanın tüm evlerini belirler.',
                  'Gezegenlerin hangi evlere düştüğünü etkiler.',
                  'Kariyerden ilişkilere kadar hayat alanlarını konumlandırır.',
                ]),
                const SizedBox(height: 32),

                _buildSuggestion(
                  context,
                  isDark,
                  '☿️',
                  'Merkür retrosu ne demek?',
                  Routes.transits,
                ),
                const SizedBox(height: 40),

                const PageFooterWithDisclaimer(
                  brandText: 'Astroloji — Venus One',
                  disclaimerText: DisclaimerTexts.astrology,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
    ),
  );

  Widget _buildSection(
    bool isDark,
    String title,
    Color color,
    List<String> bullets,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? color : color.withValues(alpha: 0.85),
        ),
      ),
      const SizedBox(height: 12),
      ...bullets.map(
        (b) => Padding(
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
                  b,
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

  Widget _buildSuggestion(
    BuildContext context,
    bool isDark,
    String emoji,
    String text,
    String route,
  ) => GestureDetector(
    onTap: () => context.push(route),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
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
                  text,
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
