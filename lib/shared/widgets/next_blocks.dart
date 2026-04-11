import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/routes.dart';

/// NEXT BLOCKS WIDGET
///
/// Kullanıcıyı dead-end'de bırakmamak için her sayfanın sonuna eklenen
/// "sonraki adımlar" önerileri.
///
/// KULLANIM:
/// ```dart
/// NextBlocks(
///   currentPage: 'horoscope',
///   signName: 'aries', // optional
/// )
/// ```
class NextBlocks extends StatelessWidget {
  final String currentPage;
  final String? signName;
  final String? title;

  const NextBlocks({
    super.key,
    required this.currentPage,
    this.signName,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final blocks = _getBlocksForPage(currentPage, signName);

    if (blocks.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title ?? 'Keşfetmeye Devam Et',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Blocks grid (2 columns)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: blocks
              .map((block) => _NextBlockCard(block: block, isDark: isDark))
              .toList(),
        ),
      ],
    );
  }

  List<_NextBlock> _getBlocksForPage(String page, String? sign) {
    switch (page) {
      case 'horoscope':
      case 'horoscope_detail':
        return [
          _NextBlock(
            icon: Icons.calendar_month_outlined,
            title: 'Haftalık Yorum',
            subtitle: 'Bu hafta seni neler bekliyor',
            route: Routes.weeklyHoroscope,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Kozmik Paylaşım',
            subtitle: 'Enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.favorite_border_outlined,
            title: 'Burç Uyumu',
            subtitle: 'Kiminle uyumlusun?',
            route: Routes.compatibility,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.grid_view_outlined,
            title: 'Tüm Burçlar',
            subtitle: '12 burcu keşfet',
            route: Routes.horoscope,
          ),
        ];

      case 'natal_chart':
      case 'birth_chart':
        return [
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Şu an seni etkileyen',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.people_outline,
            title: 'Synastry',
            subtitle: 'İlişki haritanı çıkar',
            route: Routes.synastry,
          ),
          _NextBlock(
            icon: Icons.cake_outlined,
            title: 'Solar Return',
            subtitle: 'Bu yıl seni neler bekliyor',
            route: Routes.solarReturn,
          ),
          _NextBlock(
            icon: Icons.loop_outlined,
            title: 'Saturn Dönüşü',
            subtitle: 'Satürn döngün ne zaman?',
            route: Routes.saturnReturn,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Haritanı Paylaş',
            subtitle: 'Kozmik enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.person_add_outlined,
            title: 'Profil Karşılaştır',
            subtitle: 'Bir arkadaşınla karşılaştır',
            route: Routes.comparison,
          ),
        ];

      case 'tarot':
        return [
          _NextBlock(
            icon: Icons.auto_graph_outlined,
            title: 'The Fool',
            subtitle: 'Yeni başlangıçlar',
            route: '/tarot/major/0',
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Kartını Paylaş',
            subtitle: 'Kozmik mesajını paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
          _NextBlock(
            icon: Icons.nights_stay_outlined,
            title: 'Rüya İzi',
            subtitle: 'Rüyalarının anlamı',
            route: Routes.dreamInterpretation,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
        ];

      case 'compatibility':
        return [
          _NextBlock(
            icon: Icons.people_outline,
            title: 'Synastry',
            subtitle: 'Detaylı ilişki haritası',
            route: Routes.synastry,
          ),
          _NextBlock(
            icon: Icons.group_outlined,
            title: 'Composite Chart',
            subtitle: 'Birleşik haritanız',
            route: Routes.compositeChart,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Uyumunuzu Paylaş',
            subtitle: 'Kozmik bağınızı paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.favorite_outlined,
            title: 'Aşk Yorumu',
            subtitle: 'İlişki enerjiniz',
            route: Routes.loveHoroscope,
          ),
          _NextBlock(
            icon: Icons.grid_view_outlined,
            title: 'Tüm Burçlar',
            subtitle: '12 burcu keşfet',
            route: Routes.horoscope,
          ),
        ];

      case 'numerology':
        return [
          _NextBlock(
            icon: Icons.route_outlined,
            title: 'Yaşam Yolu 1',
            subtitle: 'Lider arketipi',
            route: '/numerology/life-path/1',
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Sayını paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.star_outline,
            title: 'Master 11',
            subtitle: 'Ruhsal öğretmen',
            route: '/numerology/master/11',
          ),
          _NextBlock(
            icon: Icons.warning_amber_outlined,
            title: 'Karmik Borç 13',
            subtitle: 'Geçmiş yaşam dersi',
            route: '/numerology/karmic-debt/13',
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
        ];

      case 'chakra':
        return [
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Enerjini Paylaş',
            subtitle: 'Chakra enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.palette_outlined,
            title: 'Aura Rengi',
            subtitle: 'Enerji alanın',
            route: Routes.aura,
          ),
          _NextBlock(
            icon: Icons.spa_outlined,
            title: 'Günlük Ritüeller',
            subtitle: 'Enerji pratikleri',
            route: Routes.dailyRituals,
          ),
          _NextBlock(
            icon: Icons.nights_stay_outlined,
            title: 'Rüya İzi',
            subtitle: 'Rüyalarının anlamı',
            route: Routes.dreamInterpretation,
          ),
        ];

      case 'synastry':
        return [
          _NextBlock(
            icon: Icons.group_outlined,
            title: 'Composite Chart',
            subtitle: 'Birleşik haritanız',
            route: Routes.compositeChart,
          ),
          _NextBlock(
            icon: Icons.favorite_border_outlined,
            title: 'Burç Uyumu',
            subtitle: 'Temel uyum analizi',
            route: Routes.compatibility,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'İlişkinizi Paylaş',
            subtitle: 'Kozmik bağınızı paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.favorite_outlined,
            title: 'Aşk Yorumu',
            subtitle: 'İlişki enerjiniz',
            route: Routes.loveHoroscope,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
        ];

      case 'dreams':
      case 'dream_interpretation':
        return [
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Rüyanı Paylaş',
            subtitle: 'Mesajını paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.bedtime_outlined,
            title: 'Ay Takibi',
            subtitle: 'Ay fazlarını takip et',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
        ];

      // ════════════════════════════════════════════════════════════════
      // TAROT DETAIL PAGES
      // ════════════════════════════════════════════════════════════════
      case 'major_arcana_detail':
        return [
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tüm Kartlar',
            subtitle: '22 Major Arcana',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Kartını Paylaş',
            subtitle: 'Kozmik mesajını paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
          _NextBlock(
            icon: Icons.nights_stay_outlined,
            title: 'Rüya İzi',
            subtitle: 'Rüyalarının anlamı',
            route: Routes.dreamInterpretation,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
        ];

      // ════════════════════════════════════════════════════════════════
      // NUMEROLOGY DETAIL PAGES
      // ════════════════════════════════════════════════════════════════
      case 'life_path_detail':
        return [
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Tüm Sayılar',
            subtitle: 'Numeroloji ana sayfa',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Sayını Paylaş',
            subtitle: 'Yaşam yolunu paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.star_outline,
            title: 'Master Sayılar',
            subtitle: '11, 22, 33 gizemi',
            route: '/numerology/master/11',
          ),
          _NextBlock(
            icon: Icons.warning_amber_outlined,
            title: 'Karmik Borçlar',
            subtitle: 'Geçmiş yaşam dersleri',
            route: '/numerology/karmic-debt/13',
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
        ];

      case 'master_number_detail':
        return [
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Tüm Sayılar',
            subtitle: 'Numeroloji ana sayfa',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Master enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.route_outlined,
            title: 'Yaşam Yolu',
            subtitle: '1-9 temel sayılar',
            route: '/numerology/life-path/1',
          ),
          _NextBlock(
            icon: Icons.warning_amber_outlined,
            title: 'Karmik Borçlar',
            subtitle: 'Geçmiş yaşam dersleri',
            route: '/numerology/karmic-debt/13',
          ),
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
          _NextBlock(
            icon: Icons.account_tree_outlined,
            title: 'Kabala',
            subtitle: 'Hayat ağacı',
            route: Routes.kabbalah,
          ),
        ];

      case 'karmic_debt_detail':
        return [
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Tüm Sayılar',
            subtitle: 'Numeroloji ana sayfa',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Karmik yolculuğunu paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.route_outlined,
            title: 'Yaşam Yolu',
            subtitle: 'Temel yaşam sayın',
            route: '/numerology/life-path/1',
          ),
          _NextBlock(
            icon: Icons.star_outline,
            title: 'Master Sayılar',
            subtitle: '11, 22, 33 gizemi',
            route: '/numerology/master/11',
          ),
          _NextBlock(
            icon: Icons.loop_outlined,
            title: 'Saturn Dönüşü',
            subtitle: 'Karma döngüleri',
            route: Routes.saturnReturn,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
        ];

      case 'personal_year_detail':
        return [
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Tüm Sayılar',
            subtitle: 'Numeroloji ana sayfa',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Yıllık enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.calendar_today_outlined,
            title: 'Yıllık Öngörü',
            subtitle: 'Astrolojik yıl analizi',
            route: Routes.yearAhead,
          ),
          _NextBlock(
            icon: Icons.cake_outlined,
            title: 'Solar Return',
            subtitle: 'Doğum günü haritanı',
            route: Routes.solarReturn,
          ),
          _NextBlock(
            icon: Icons.route_outlined,
            title: 'Yaşam Yolu',
            subtitle: 'Temel yaşam sayın',
            route: '/numerology/life-path/1',
          ),
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Şu anki geçişler',
            route: Routes.transits,
          ),
        ];

      case 'transits':
        return [
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Natal haritanı gör',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Transit enerjilerini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.timeline_outlined,
            title: 'Progressions',
            subtitle: 'İlerlemeli harita',
            route: Routes.progressions,
          ),
          _NextBlock(
            icon: Icons.cake_outlined,
            title: 'Solar Return',
            subtitle: 'Yıllık güneş dönüşü',
            route: Routes.solarReturn,
          ),
          _NextBlock(
            icon: Icons.loop_outlined,
            title: 'Saturn Dönüşü',
            subtitle: 'Satürn döngün',
            route: Routes.saturnReturn,
          ),
          _NextBlock(
            icon: Icons.schedule_outlined,
            title: 'Zamanlama',
            subtitle: 'En iyi zamanlar',
            route: Routes.timing,
          ),
        ];

      case 'timing':
        return [
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Güncel gezegen geçişleri',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Zamanlama enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.do_not_disturb_outlined,
            title: 'Ay Boş Seyir',
            subtitle: 'VOC dönemleri',
            route: Routes.voidOfCourse,
          ),
          _NextBlock(
            icon: Icons.calendar_month_outlined,
            title: 'Yıllık Öngörü',
            subtitle: 'Bu yıl seni neler bekliyor',
            route: Routes.yearAhead,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
        ];

      case 'aura':
        return [
          _NextBlock(
            icon: Icons.blur_circular_outlined,
            title: 'Chakra Analizi',
            subtitle: 'Enerji merkezlerin',
            route: Routes.chakraAnalysis,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Aura Rengini Paylaş',
            subtitle: 'Enerji imzanı paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.numbers_outlined,
            title: 'Numeroloji',
            subtitle: 'Sayıların gizemi',
            route: Routes.numerology,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.spa_outlined,
            title: 'Günlük Ritüeller',
            subtitle: 'Enerji pratikleri',
            route: Routes.dailyRituals,
          ),
          _NextBlock(
            icon: Icons.diamond_outlined,
            title: 'Kristal Rehberi',
            subtitle: 'Taşların gücü',
            route: Routes.crystalGuide,
          ),
        ];

      case 'saturn_return':
        return [
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Güncel geçişler',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Satürn yolculuğunu paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Natal haritanı gör',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.calendar_today_outlined,
            title: 'Yıllık Öngörü',
            subtitle: 'Bu yıl seni neler bekliyor',
            route: Routes.yearAhead,
          ),
          _NextBlock(
            icon: Icons.warning_amber_outlined,
            title: 'Karmik Borçlar',
            subtitle: 'Geçmiş yaşam dersleri',
            route: '/numerology/karmic-debt/13',
          ),
          _NextBlock(
            icon: Icons.timeline_outlined,
            title: 'Progressions',
            subtitle: 'İlerlemeli harita',
            route: Routes.progressions,
          ),
        ];

      case 'progressions':
        return [
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Güncel geçişler',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'İlerlemelerini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.cake_outlined,
            title: 'Solar Return',
            subtitle: 'Yıllık güneş dönüşü',
            route: Routes.solarReturn,
          ),
          _NextBlock(
            icon: Icons.loop_outlined,
            title: 'Saturn Dönüşü',
            subtitle: 'Satürn döngün',
            route: Routes.saturnReturn,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Natal haritanı gör',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.calendar_today_outlined,
            title: 'Yıllık Öngörü',
            subtitle: 'Bu yıl seni neler bekliyor',
            route: Routes.yearAhead,
          ),
        ];

      case 'cosmic_share':
        return [
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Detaylı yorum oku',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.calendar_month_outlined,
            title: 'Haftalık Yorum',
            subtitle: 'Bu hafta seni neler bekliyor',
            route: Routes.weeklyHoroscope,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.favorite_border_outlined,
            title: 'Burç Uyumu',
            subtitle: 'Kiminle uyumlusun?',
            route: Routes.compatibility,
          ),
          _NextBlock(
            icon: Icons.chat_bubble_outline,
            title: 'Kozmoz İzi',
            subtitle: 'AI asistanla konuş',
            route: Routes.kozmoz,
          ),
        ];

      case 'weekly_horoscope':
        return [
          _NextBlock(
            icon: Icons.calendar_view_month_outlined,
            title: 'Aylık Yorum',
            subtitle: 'Bu ay seni neler bekliyor',
            route: Routes.monthlyHoroscope,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Haftalık enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Şu an seni etkileyen',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.grid_view_outlined,
            title: 'Tüm Burçlar',
            subtitle: '12 burcu keşfet',
            route: Routes.horoscope,
          ),
        ];

      case 'solar_return':
        return [
          _NextBlock(
            icon: Icons.calendar_today_outlined,
            title: 'Yıllık Öngörü',
            subtitle: 'Bu yıl seni neler bekliyor',
            route: Routes.yearAhead,
          ),
          _NextBlock(
            icon: Icons.loop_outlined,
            title: 'Saturn Dönüşü',
            subtitle: 'Satürn döngün',
            route: Routes.saturnReturn,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Solar return enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Şu anki geçişler',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
        ];

      case 'year_ahead':
        return [
          _NextBlock(
            icon: Icons.cake_outlined,
            title: 'Solar Return',
            subtitle: 'Doğum günü haritanı',
            route: Routes.solarReturn,
          ),
          _NextBlock(
            icon: Icons.calendar_view_month_outlined,
            title: 'Aylık Yorum',
            subtitle: 'Detaylı aylık analiz',
            route: Routes.monthlyHoroscope,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Paylaş',
            subtitle: 'Yıllık öngörünü paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.timeline_outlined,
            title: 'Progressions',
            subtitle: 'İlerlemeli harita',
            route: Routes.progressions,
          ),
          _NextBlock(
            icon: Icons.compare_arrows_outlined,
            title: 'Transitler',
            subtitle: 'Önemli geçişler',
            route: Routes.transits,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
        ];

      default:
        // Generic blocks for any page
        return [
          _NextBlock(
            icon: Icons.wb_sunny_outlined,
            title: 'Günlük Yorum',
            subtitle: 'Bugünün enerjisi',
            route: Routes.horoscope,
          ),
          _NextBlock(
            icon: Icons.auto_awesome_outlined,
            title: 'Kozmik Paylaşım',
            subtitle: 'Enerjini paylaş',
            route: Routes.cosmicShare,
            isHighlighted: true,
          ),
          _NextBlock(
            icon: Icons.pie_chart_outline,
            title: 'Doğum Haritası',
            subtitle: 'Kozmik haritanı keşfet',
            route: Routes.birthChart,
          ),
          _NextBlock(
            icon: Icons.style_outlined,
            title: 'Tarot Falı',
            subtitle: 'Kartlar ne diyor?',
            route: Routes.tarot,
          ),
          _NextBlock(
            icon: Icons.favorite_border_outlined,
            title: 'Burç Uyumu',
            subtitle: 'Kiminle uyumlusun?',
            route: Routes.compatibility,
          ),
          _NextBlock(
            icon: Icons.home_outlined,
            title: 'Ana Sayfa',
            subtitle: 'Tüm özelliklere dön',
            route: Routes.home,
          ),
        ];
    }
  }
}

class _NextBlock {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final bool isHighlighted;

  const _NextBlock({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    this.isHighlighted = false,
  });
}

class _NextBlockCard extends StatelessWidget {
  final _NextBlock block;
  final bool isDark;

  const _NextBlockCard({required this.block, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - 32 - 12) / 2; // 2 columns with padding and gap

    return SizedBox(
      width: cardWidth,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(block.route),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: block.isHighlighted
                  ? (isDark
                        ? AppColors.starGold.withValues(alpha: 0.1)
                        : AppColors.lightStarGold.withValues(alpha: 0.1))
                  : (isDark ? AppColors.surfaceDark : AppColors.lightCard),
              borderRadius: BorderRadius.circular(12),
              border: block.isHighlighted
                  ? Border.all(
                      color: isDark
                          ? AppColors.starGold.withValues(alpha: 0.3)
                          : AppColors.lightStarGold.withValues(alpha: 0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cosmicPurple
                        : AppColors.lightSurfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    block.icon,
                    size: 20,
                    color: block.isHighlighted
                        ? (isDark
                              ? AppColors.starGold
                              : AppColors.lightStarGold)
                        : (isDark
                              ? AppColors.auroraStart
                              : AppColors.lightAuroraStart),
                  ),
                ),
                const SizedBox(width: 12),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        block.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        block.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact version for smaller spaces
class NextBlocksCompact extends StatelessWidget {
  final String currentPage;
  final int maxItems;

  const NextBlocksCompact({
    super.key,
    required this.currentPage,
    this.maxItems = 3,
  });

  @override
  Widget build(BuildContext context) {
    return NextBlocks(currentPage: currentPage, title: 'Sonraki');
  }
}
