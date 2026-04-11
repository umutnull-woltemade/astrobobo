import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';

/// Ay Bugün Hangi Burçta? - AI-First Canonical Sayfa
class MoonSignTodayScreen extends StatelessWidget {
  const MoonSignTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = const Color(0xFFC0C0C0);
    final today = DateTime.now();
    final moonData = _getMoonSign(today);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D0D1A), const Color(0xFF0D1520)]
                : [const Color(0xFFF8FAFF), const Color(0xFFEEF2FF)],
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
                  'Ay bugün hangi burçta?',
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
                  'Ay yaklaşık 2.5 günde bir burç değiştirir.',
                  'Bugün Ay hangi burçtaysa o enerjiye göre duygular şekillenir.',
                  'Ay burcu günlük duygusal tonu belirler.',
                ]),
                const SizedBox(height: 28),

                // Today's moon sign
                _buildMoonCard(context, isDark, moonData),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Ay Burcu Neden Önemli?', color, [
                  'Duygusal ihtiyaçlarını gösterir.',
                  'İçgüdüsel tepkilerini etkiler.',
                  'Ruh haline yön verir.',
                  'Beslenme ve dinlenme ihtiyacını şekillendirir.',
                ]),
                const SizedBox(height: 28),

                _buildSection(isDark, 'Günlük Hayatta', color, [
                  'Ay ateş burcundaysa: Enerji yükselir, sabırsızlık olabilir.',
                  'Ay toprak burcundaysa: Pratik işler için uygun.',
                  'Ay hava burcundaysa: İletişim ve sosyallik ön planda.',
                  'Ay su burcundaysa: Duygusal derinlik artar.',
                ]),
                const SizedBox(height: 32),

                _buildSuggestion(
                  context,
                  isDark,
                  '⬆️',
                  'Yükselen burç nedir?',
                  Routes.horoscope,
                ),
                const SizedBox(height: 40),

                Center(
                  child: Text(
                    'Astroloji — Venus One',
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

  _MoonData _getMoonSign(DateTime date) {
    // Simplified moon sign calculation based on lunar cycle
    // In production, this would use precise ephemeris data
    final signs = [
      _MoonData('Koç', '♈', 'Ateş', const Color(0xFFE53935), [
        'Enerji yüksek',
        'Yeni başlangıçlar için uygun',
        'Sabırsızlık olabilir',
      ]),
      _MoonData('Boğa', '♉', 'Toprak', const Color(0xFF43A047), [
        'Konfor arayışı',
        'Maddi konular ön planda',
        'Kararlılık güçlü',
      ]),
      _MoonData('İkizler', '♊', 'Hava', const Color(0xFFFFB300), [
        'İletişim akışta',
        'Merak artıyor',
        'Çok yönlü düşünce',
      ]),
      _MoonData('Yengeç', '♋', 'Su', const Color(0xFF90CAF9), [
        'Duygusal hassasiyet',
        'Ev ve aile önemli',
        'Sezgiler güçlü',
      ]),
      _MoonData('Aslan', '♌', 'Ateş', const Color(0xFFFF9800), [
        'Yaratıcılık artıyor',
        'Görünür olma isteği',
        'Cömertlik',
      ]),
      _MoonData('Başak', '♍', 'Toprak', const Color(0xFF8D6E63), [
        'Detaylara odaklanma',
        'Düzen ihtiyacı',
        'Sağlık bilinci',
      ]),
      _MoonData('Terazi', '♎', 'Hava', const Color(0xFFEC407A), [
        'İlişkiler ön planda',
        'Denge arayışı',
        'Estetik duyarlılık',
      ]),
      _MoonData('Akrep', '♏', 'Su', const Color(0xFF7B1FA2), [
        'Yoğun duygular',
        'Dönüşüm enerjisi',
        'Derinlik arayışı',
      ]),
      _MoonData('Yay', '♐', 'Ateş', const Color(0xFF5C6BC0), [
        'Özgürlük isteği',
        'Felsefi düşünce',
        'İyimserlik',
      ]),
      _MoonData('Oğlak', '♑', 'Toprak', const Color(0xFF455A64), [
        'Sorumluluk bilinci',
        'Kariyer odağı',
        'Disiplin',
      ]),
      _MoonData('Kova', '♒', 'Hava', const Color(0xFF00BCD4), [
        'Bağımsızlık',
        'Yenilikçi fikirler',
        'Topluluk bilinci',
      ]),
      _MoonData('Balık', '♓', 'Su', const Color(0xFF26A69A), [
        'Sezgisel dönem',
        'Rüyalar anlamlı',
        'Empati yüksek',
      ]),
    ];

    // Approximate lunar cycle position (29.5 days)
    final lunarDayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final signIndex = (lunarDayOfYear ~/ 2.5).toInt() % 12;
    return signs[signIndex];
  }

  Widget _buildMoonCard(BuildContext context, bool isDark, _MoonData data) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            data.color.withValues(alpha: 0.2),
            data.color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: data.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🌙', style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Text(
                data.symbol,
                style: TextStyle(fontSize: 48, color: data.color),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Ay ${data.name} Burcunda',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${data.element} Elementi',
              style: TextStyle(
                fontSize: 12,
                color: data.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...data.bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: data.color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
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

class _MoonData {
  final String name;
  final String symbol;
  final String element;
  final Color color;
  final List<String> bullets;

  const _MoonData(
    this.name,
    this.symbol,
    this.element,
    this.color,
    this.bullets,
  );
}
