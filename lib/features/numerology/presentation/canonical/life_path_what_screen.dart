import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';

/// Yaşam Yolu Sayısı Nedir? - AI-First Canonical Sayfa
class LifePathWhatScreen extends StatelessWidget {
  const LifePathWhatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = const Color(0xFFFFD700);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D0D1A), const Color(0xFF1A1508)]
                : [const Color(0xFFFFFDF5), const Color(0xFFFFF8E5)],
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
                  'Yaşam yolu sayısı nedir?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.2,
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                _buildTag('Numeroloji', color),
                const SizedBox(height: 32),

                _buildSection(isDark, 'Kısa Cevap', color, [
                  'Yaşam yolu sayısı, doğum tarihinden hesaplanan temel numerolojik sayındır.',
                  'Bu hayatta hangi yolda yürüyeceğini gösterir.',
                  '1\'den 9\'a kadar (ve 11, 22, 33 üstat sayıları) değer alır.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Nasıl Hesaplanır?', color, [
                  'Doğum tarihinin tüm rakamları toplanır.',
                  'Tek haneli bir sayıya ulaşana kadar indirgenir.',
                  'Örnek: 15.03.1990 → 1+5+0+3+1+9+9+0 = 28 → 2+8 = 10 → 1+0 = 1',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Ne Anlatır?', color, [
                  'Ruhunun bu hayattaki amacını.',
                  'Doğal yeteneklerini ve güçlü yanlarını.',
                  'Karşılaşacağın zorlukları ve dersleri.',
                  'Hayatında tekrar eden temaları.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Önemli Not', color, [
                  'Yaşam yolu sayısı kader değildir.',
                  'Potansiyeli gösterir, kararlar senin.',
                  'Her sayının hem ışık hem gölge yönü vardır.',
                ]),
                const SizedBox(height: 32),

                _buildSuggestion(
                  context,
                  isDark,
                  '🔢',
                  'Günlük sayı enerjisi ne anlatır?',
                  Routes.numerology,
                ),
                const SizedBox(height: 40),

                Center(
                  child: Text(
                    'Numeroloji — Venus One',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : AppColors.textLight,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
