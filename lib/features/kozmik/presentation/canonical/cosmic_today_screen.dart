import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/entertainment_disclaimer.dart';

/// Kozmik - Bugünün Teması
/// Günlük değişen kozmik tema sayfası
class CosmicTodayScreen extends ConsumerWidget {
  const CosmicTodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateTime.now();
    final theme = _getDailyTheme(today);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF0D0D1A),
                    Color.lerp(const Color(0xFF0D0D1A), theme.color, 0.15)!,
                  ]
                : [
                    const Color(0xFFFFFDF8),
                    Color.lerp(const Color(0xFFFFFDF8), theme.color, 0.08)!,
                  ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: isDark ? Colors.white70 : AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    _buildDateBadge(context, isDark, today),
                  ],
                ),
                const SizedBox(height: 32),

                // Emoji
                Center(
                  child: Text(
                    theme.emoji,
                    style: const TextStyle(fontSize: 64),
                  ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                ),
                const SizedBox(height: 24),

                // Title
                Center(
                  child: Text(
                    theme.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.textDark,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 400.ms),
                ),
                const SizedBox(height: 8),

                // Tag
                Center(child: _buildTag('Kozmik', theme.color)),
                const SizedBox(height: 40),

                // 3 Bullets - Core Message
                _buildMainBullets(context, isDark, theme),
                const SizedBox(height: 36),

                // Sections
                _buildSection(
                  isDark,
                  'Bugünün Vurgusu',
                  theme.color,
                  theme.emphasis,
                ),
                const SizedBox(height: 28),
                _buildSection(
                  isDark,
                  'Duygusal Ton',
                  theme.color,
                  theme.emotionalTone,
                ),
                const SizedBox(height: 28),
                _buildSection(
                  isDark,
                  'Farkındalık',
                  theme.color,
                  theme.awareness,
                ),
                const SizedBox(height: 32),

                // Suggestion - Kozmik → rüya + numeroloji
                _buildSuggestion(
                  context,
                  isDark,
                  '🌙',
                  'Rüya İzi\'ni keşfet',
                  Routes.dreamRecurring,
                ),
                const SizedBox(height: 40),

                // Footer with disclaimer
                const PageFooterWithDisclaimer(brandText: 'Kozmik — Venus One'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBadge(BuildContext context, bool isDark, DateTime date) {
    final months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '${date.day} ${months[date.month - 1]}',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white70 : AppColors.textDark,
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500),
    ),
  );

  Widget _buildMainBullets(
    BuildContext context,
    bool isDark,
    _DailyTheme theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? theme.color.withValues(alpha: 0.1)
            : theme.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: theme.coreBullets
            .map(
              (bullet) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: theme.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        bullet,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: isDark ? Colors.white : AppColors.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

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
        mainAxisSize: MainAxisSize.min,
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

  _DailyTheme _getDailyTheme(DateTime date) {
    // Rotate themes based on day of year
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final themes = _themes;
    return themes[dayOfYear % themes.length];
  }

  static final List<_DailyTheme> _themes = [
    _DailyTheme(
      emoji: '🌅',
      title: 'Yeni Başlangıçlar',
      color: const Color(0xFFFF9800),
      coreBullets: [
        'Bugün enerji yenileniyor.',
        'Geçmişin yükü hafifliyor.',
        'Küçük adımlar büyük değişimlere kapı açar.',
      ],
      emphasis: [
        'Cesaret gerektiren bir adım atılabilir.',
        'Bekleyen kararlar öne çıkıyor.',
        'İlk hamle senin elinde.',
      ],
      emotionalTone: [
        'Umut ön planda.',
        'Hafif bir heyecan hissedilebilir.',
        'Merak duygusu güçlü.',
      ],
      awareness: [
        'Sabırsızlık tuzağına düşme.',
        'Her şeyin hemen olmasını bekleme.',
        'Süreç de yolculuğun parçası.',
      ],
    ),
    _DailyTheme(
      emoji: '🌊',
      title: 'Duygusal Derinlik',
      color: const Color(0xFF2196F3),
      coreBullets: [
        'İçsel sular hareket halinde.',
        'Duygular yüzeye çıkmak istiyor.',
        'Derinlere inmek bugün mümkün.',
      ],
      emphasis: [
        'Bastırılan duygular fark edilebilir.',
        'Su elementi güçlü.',
        'Sezgiler daha net.',
      ],
      emotionalTone: [
        'Hassasiyet artmış olabilir.',
        'Empati duygusu yoğun.',
        'Gözyaşı da temizleyicidir.',
      ],
      awareness: [
        'Duygulara kapılmak yerine gözlemle.',
        'Her his geçicidir.',
        'Akış halinde kal.',
      ],
    ),
    _DailyTheme(
      emoji: '🔥',
      title: 'İçsel Güç',
      color: const Color(0xFFE91E63),
      coreBullets: [
        'Ateş elementi aktif.',
        'İrade ve kararlılık güçleniyor.',
        'Eylem zamanı yaklaşıyor.',
      ],
      emphasis: [
        'Motivasyon yükseliyor.',
        'Ertelenen işler için uygun.',
        'Cesaret gerektiren adımlar atılabilir.',
      ],
      emotionalTone: [
        'Tutku hissedilebilir.',
        'Sabırsızlık olası.',
        'Enerji yoğun.',
      ],
      awareness: [
        'Öfkeyi fark et ama yönet.',
        'Ateş yakar da ısıtır da.',
        'Güçlü olmak sert olmak değil.',
      ],
    ),
    _DailyTheme(
      emoji: '🌿',
      title: 'Topraklanma',
      color: const Color(0xFF4CAF50),
      coreBullets: [
        'Toprak elementi çağırıyor.',
        'Bedene dönmek bugün önemli.',
        'Basit şeyler değer kazanıyor.',
      ],
      emphasis: [
        'Maddi konular ön planda.',
        'Güvenlik arayışı var.',
        'Somut adımlar atılabilir.',
      ],
      emotionalTone: [
        'Sakinlik aranıyor.',
        'Dinlenme ihtiyacı var.',
        'Yavaşlama hissi.',
      ],
      awareness: [
        'Sıkışmışlık geçici.',
        'Doğayla temas iyileştirir.',
        'Ayakların yere bassın.',
      ],
    ),
    _DailyTheme(
      emoji: '💨',
      title: 'Zihinsel Açıklık',
      color: const Color(0xFF9C27B0),
      coreBullets: [
        'Hava elementi hakim.',
        'Düşünceler berraklaşıyor.',
        'İletişim güçleniyor.',
      ],
      emphasis: [
        'Fikirler akışta.',
        'Yeni bakış açıları mümkün.',
        'Konuşmalar önem kazanıyor.',
      ],
      emotionalTone: [
        'Hafiflik hissi.',
        'Merak artıyor.',
        'Sosyal enerji yükseliyor.',
      ],
      awareness: [
        'Fazla düşünme tuzağı var.',
        'Analiz felç edebilir.',
        'Bazen bırak gitsin.',
      ],
    ),
    _DailyTheme(
      emoji: '🌙',
      title: 'İçe Dönüş',
      color: const Color(0xFF607D8B),
      coreBullets: [
        'Ay enerjisi güçlü.',
        'Bilinçaltı mesajlar taşıyor.',
        'Dinlenme ve düşünme zamanı.',
      ],
      emphasis: [
        'Rüyalar anlamlı olabilir.',
        'Sezgiler güçlü.',
        'Yalnızlık iyi gelebilir.',
      ],
      emotionalTone: [
        'Melankoli olası.',
        'Nostaljik hisler.',
        'Derinleşme isteği.',
      ],
      awareness: [
        'Karanlık da öğretir.',
        'Her şeyin görünür olması gerekmez.',
        'İç dünya da gerçektir.',
      ],
    ),
    _DailyTheme(
      emoji: '⭐',
      title: 'Potansiyel',
      color: const Color(0xFFFFD700),
      coreBullets: [
        'Bugün olasılıklar açık.',
        'Henüz olmamış olan çağırıyor.',
        'Hayal gücü değerli.',
      ],
      emphasis: [
        'Vizyoner düşünce destekleniyor.',
        'Uzun vadeli planlar için uygun.',
        'İlham alınabilir.',
      ],
      emotionalTone: ['Umut dolu.', 'Heyecan var.', 'Beklenti yükseliyor.'],
      awareness: [
        'Hayal kurmak eylem değildir.',
        'Potansiyel gerçekleşmeden kalabilir.',
        'Küçük adımlar büyütür.',
      ],
    ),
  ];
}

class _DailyTheme {
  final String emoji;
  final String title;
  final Color color;
  final List<String> coreBullets;
  final List<String> emphasis;
  final List<String> emotionalTone;
  final List<String> awareness;

  const _DailyTheme({
    required this.emoji,
    required this.title,
    required this.color,
    required this.coreBullets,
    required this.emphasis,
    required this.emotionalTone,
    required this.awareness,
  });
}
