import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// KADİM NOT (ANCIENT NOTE) CARD WIDGET
///
/// Ezoterik bilgelik notları için kullanılan premium kart.
/// Her sayfada 1-2 adet "Kadim Not" gösterilir.
/// Arketipsel, sembolik ve mistik dil kullanılır.
///
/// KULLANIM:
/// ```dart
/// KadimNotCard(
///   title: 'Sayıların Sırrı',
///   content: 'Her sayı evrenin bir titreşimini taşır...',
///   icon: Icons.auto_awesome,
///   category: KadimCategory.numerology,
/// )
/// ```

/// Kadim not kategorileri
enum KadimCategory {
  numerology, // Numeroloji - Sayıların Kadim Bilgeliği
  astrology, // Astroloji - Göksel Bilgelik
  tarot, // Tarot - Arketipsel Semboller
  chakra, // Çakra - Enerji Merkezleri
  moonWisdom, // Ay Bilgeliği - Döngüsel Sırlar
  elements, // Elementler - Doğanın Dili
  rituals, // Ritüeller - Kadim Pratikler
  dreams, // Rüyalar - Bilinçaltının Sırları
  symbols, // Semboller - Evrensel Dil
  alchemy, // Simya - Dönüşüm Sanatı
}

/// Kadim not kartı - Ezoterik bilgelik parçaları
class KadimNotCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final KadimCategory category;
  final String? source; // "Hermetik Öğreti", "Kabala", etc.
  final VoidCallback? onTap;
  final bool showGlow;
  final bool compact;

  const KadimNotCard({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    this.category = KadimCategory.astrology,
    this.source,
    this.onTap,
    this.showGlow = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoryData = _getCategoryData(category);
    final displayIcon = icon ?? categoryData.icon;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(compact ? 12 : 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    categoryData.color.withValues(alpha: 0.15),
                    categoryData.color.withValues(alpha: 0.08),
                  ]
                : [
                    categoryData.color.withValues(alpha: 0.12),
                    categoryData.color.withValues(alpha: 0.05),
                  ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: categoryData.color.withValues(alpha: isDark ? 0.3 : 0.25),
            width: 1.5,
          ),
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: categoryData.color.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and category
            Row(
              children: [
                // Mystical icon container
                Container(
                  width: compact ? 32 : 40,
                  height: compact ? 32 : 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        categoryData.color.withValues(alpha: 0.4),
                        categoryData.color.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: categoryData.color.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Icon(
                    displayIcon,
                    size: compact ? 18 : 22,
                    color: categoryData.color,
                  ),
                ),
                const SizedBox(width: 12),
                // Title and category label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: categoryData.color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '✦ ${categoryData.label}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: categoryData.color,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: compact ? 14 : 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                // Decorative symbol
                if (!compact)
                  Text(
                    categoryData.symbol,
                    style: TextStyle(
                      fontSize: 24,
                      color: categoryData.color.withValues(alpha: 0.4),
                    ),
                  ),
              ],
            ),
            SizedBox(height: compact ? 10 : 14),
            // Decorative divider
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    categoryData.color.withValues(alpha: 0.3),
                    categoryData.color.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.2, 0.8, 1.0],
                ),
              ),
            ),
            SizedBox(height: compact ? 10 : 14),
            // Content - Kadim bilgelik metni
            Text(
              content,
              style: TextStyle(
                fontSize: compact ? 13 : 14,
                height: 1.6,
                fontStyle: FontStyle.italic,
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            // Source attribution
            if (source != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '— $source',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: categoryData.color.withValues(alpha: 0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  _CategoryData _getCategoryData(KadimCategory category) {
    switch (category) {
      case KadimCategory.numerology:
        return _CategoryData(
          label: 'Kadim Sayı Bilgeliği',
          color: const Color(0xFF9C27B0), // Deep purple
          icon: Icons.tag,
          symbol: '∞',
        );
      case KadimCategory.astrology:
        return _CategoryData(
          label: 'Göksel Bilgelik',
          color: AppColors.auroraStart,
          icon: Icons.stars,
          symbol: '☿',
        );
      case KadimCategory.tarot:
        return _CategoryData(
          label: 'Arketipsel Sırlar',
          color: const Color(0xFFE91E63), // Pink
          icon: Icons.style,
          symbol: '⚜',
        );
      case KadimCategory.chakra:
        return _CategoryData(
          label: 'Enerji Bilgeliği',
          color: const Color(0xFF00BCD4), // Cyan
          icon: Icons.blur_circular,
          symbol: '☯',
        );
      case KadimCategory.moonWisdom:
        return _CategoryData(
          label: 'Ay Sırları',
          color: const Color(0xFF78909C), // Blue grey
          icon: Icons.nightlight_round,
          symbol: '☽',
        );
      case KadimCategory.elements:
        return _CategoryData(
          label: 'Element Bilgeliği',
          color: const Color(0xFF4CAF50), // Green
          icon: Icons.eco,
          symbol: '◈',
        );
      case KadimCategory.rituals:
        return _CategoryData(
          label: 'Kadim Ritüeller',
          color: const Color(0xFFFF9800), // Orange
          icon: Icons.local_fire_department,
          symbol: '⛤',
        );
      case KadimCategory.dreams:
        return _CategoryData(
          label: 'Rüya Bilgeliği',
          color: const Color(0xFF673AB7), // Deep purple
          icon: Icons.cloud,
          symbol: '☁',
        );
      case KadimCategory.symbols:
        return _CategoryData(
          label: 'Sembolik Sırlar',
          color: const Color(0xFF795548), // Brown
          icon: Icons.auto_awesome,
          symbol: '⚕',
        );
      case KadimCategory.alchemy:
        return _CategoryData(
          label: 'Simya Bilgeliği',
          color: const Color(0xFFFFD700), // Gold
          icon: Icons.science,
          symbol: '☿',
        );
    }
  }
}

class _CategoryData {
  final String label;
  final Color color;
  final IconData icon;
  final String symbol;

  _CategoryData({
    required this.label,
    required this.color,
    required this.icon,
    required this.symbol,
  });
}

/// Kadim bilgelik koleksiyonu - Yan yana iki kadim not
class KadimNotRow extends StatelessWidget {
  final KadimNotCard left;
  final KadimNotCard right;

  const KadimNotRow({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }
}

/// Kadim Bilgelik Banner - Ekran genelinde önemli mesaj
class KadimBanner extends StatelessWidget {
  final String message;
  final KadimCategory category;
  final VoidCallback? onTap;

  const KadimBanner({
    super.key,
    required this.message,
    this.category = KadimCategory.astrology,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoryData = _getCategoryData(category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              categoryData.color.withValues(alpha: 0.2),
              categoryData.color.withValues(alpha: 0.1),
              categoryData.color.withValues(alpha: 0.2),
            ],
          ),
          border: Border(
            top: BorderSide(color: categoryData.color.withValues(alpha: 0.3)),
            bottom: BorderSide(
              color: categoryData.color.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              categoryData.symbol,
              style: TextStyle(fontSize: 20, color: categoryData.color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              categoryData.symbol,
              style: TextStyle(fontSize: 20, color: categoryData.color),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  _CategoryData _getCategoryData(KadimCategory category) {
    // Same as above - duplicated for independent usage
    switch (category) {
      case KadimCategory.numerology:
        return _CategoryData(
          label: 'Kadim Sayı Bilgeliği',
          color: const Color(0xFF9C27B0),
          icon: Icons.tag,
          symbol: '∞',
        );
      case KadimCategory.astrology:
        return _CategoryData(
          label: 'Göksel Bilgelik',
          color: AppColors.auroraStart,
          icon: Icons.stars,
          symbol: '☿',
        );
      case KadimCategory.tarot:
        return _CategoryData(
          label: 'Arketipsel Sırlar',
          color: const Color(0xFFE91E63),
          icon: Icons.style,
          symbol: '⚜',
        );
      case KadimCategory.chakra:
        return _CategoryData(
          label: 'Enerji Bilgeliği',
          color: const Color(0xFF00BCD4),
          icon: Icons.blur_circular,
          symbol: '☯',
        );
      case KadimCategory.moonWisdom:
        return _CategoryData(
          label: 'Ay Sırları',
          color: const Color(0xFF78909C),
          icon: Icons.nightlight_round,
          symbol: '☽',
        );
      case KadimCategory.elements:
        return _CategoryData(
          label: 'Element Bilgeliği',
          color: const Color(0xFF4CAF50),
          icon: Icons.eco,
          symbol: '◈',
        );
      case KadimCategory.rituals:
        return _CategoryData(
          label: 'Kadim Ritüeller',
          color: const Color(0xFFFF9800),
          icon: Icons.local_fire_department,
          symbol: '⛤',
        );
      case KadimCategory.dreams:
        return _CategoryData(
          label: 'Rüya Bilgeliği',
          color: const Color(0xFF673AB7),
          icon: Icons.cloud,
          symbol: '☁',
        );
      case KadimCategory.symbols:
        return _CategoryData(
          label: 'Sembolik Sırlar',
          color: const Color(0xFF795548),
          icon: Icons.auto_awesome,
          symbol: '⚕',
        );
      case KadimCategory.alchemy:
        return _CategoryData(
          label: 'Simya Bilgeliği',
          color: const Color(0xFFFFD700),
          icon: Icons.science,
          symbol: '☿',
        );
    }
  }
}

/// Viral paylaşım metinleri - 10 Türkçe varyasyon
class KadimViralTexts {
  static const List<String> shareTexts = [
    'Kozmik haritanı keşfet, kaderini oku ✨',
    'Yıldızlar sana ne fısıldıyor? 🌟',
    'Kadim bilgelik, modern içgörü 🔮',
    'Evrenin sana özel mesajı var 💫',
    'Göksel rehberliğini al, yolunu aydınlat ⭐',
    'Sayıların sırrını, yıldızların dilini öğren 🌙',
    'Kozmik enerjini keşfet, potansiyelini aç 🌌',
    'Kadim semboller, ebedi bilgelik ♾️',
    'Evrenle uyumunu bul, akışa gir 🌊',
    'Astrolojik içgörünü paylaş, ışığını yay ✦',
  ];

  /// Kategori bazlı viral metinler
  static String getViralText(KadimCategory category, {int? index}) {
    final texts = _categoryViralTexts[category] ?? shareTexts;
    final idx = index ?? DateTime.now().millisecond % texts.length;
    return texts[idx];
  }

  static const Map<KadimCategory, List<String>> _categoryViralTexts = {
    KadimCategory.numerology: [
      'Yaşam yolu sayın ne diyor? ∞',
      'Sayıların kadim sırrını keşfet 🔢',
      'Doğum tarihinde evrenin şifresi var 💫',
      'Numerolojik haritanı çöz, kaderini oku ✨',
      'Her sayı bir titreşim, her titreşim bir mesaj 🌟',
    ],
    KadimCategory.tarot: [
      'Kartlar sana ne söylüyor? 🎴',
      'Arketipsel yolculuğuna çık ⚜️',
      'Tarot aynası: İçindekini gör 🪞',
      'Kadim semboller, derin içgörüler ✨',
      'Kartların bilgeliğini al 🔮',
    ],
    KadimCategory.astrology: [
      'Yıldız haritanı keşfet ⭐',
      'Göksel rehberliğini al 🌟',
      'Kozmik enerjini öğren 💫',
      'Burç yorumun hazır ♈',
      'Gezegenler sana ne diyor? 🪐',
    ],
    KadimCategory.chakra: [
      'Enerji merkezlerini dengele ☯️',
      'Çakra uyumunu keşfet 🌈',
      'İç enerjini aç, ışığını yay ✨',
      'Chakra haritanı oku 💫',
      '7 kapıyı aç, dönüşümü başlat 🔮',
    ],
    KadimCategory.dreams: [
      'Rüyalarının sırrını çöz 🌙',
      'Bilinçaltın sana ne söylüyor? 💭',
      'Rüya sembolleri, derin mesajlar ☁️',
      'Gece yolculuğunu yorumla ✨',
      'Rüyaların kadim bilgeliği 🔮',
    ],
  };
}
