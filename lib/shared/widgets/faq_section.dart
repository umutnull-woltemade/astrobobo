import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// FAQ Section Widget
/// SEO-optimized expandable FAQ section with Schema.org markup support
class FaqSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<FaqItem> items;
  final bool initiallyExpanded;

  const FaqSection({
    super.key,
    this.title = 'Sıkça Sorulan Sorular',
    this.subtitle,
    required this.items,
    this.initiallyExpanded = false,
  });

  /// Create FAQ section for zodiac signs
  factory FaqSection.zodiacSign(String signName) {
    return FaqSection(
      title: '$signName Burcu Hakkında SSS',
      subtitle: 'En çok merak edilen sorular ve cevapları',
      items: [
        FaqItem(
          question: '$signName burcu özellikleri nelerdir?',
          answer:
              '$signName burcu, zodyak kuşağındaki burçlardan biridir. Her burcun kendine özgü kişilik özellikleri, güçlü ve zayıf yönleri vardır. Doğum haritanızda Güneş burcunuz $signName olsa bile, yükselen burcunuz ve Ay burcunuz da kişiliğinizi önemli ölçüde etkiler.',
        ),
        FaqItem(
          question: '$signName burcu ile hangi burçlar uyumludur?',
          answer:
              'Burç uyumu, sadece Güneş burçlarına değil, tüm doğum haritasına bağlıdır. Genel olarak aynı element grubundaki burçlar (ateş, toprak, hava, su) birbirleriyle daha uyumlu olma eğilimindedir. Detaylı uyum analizi için synastry (karşılaştırmalı harita) analizi önerilir.',
        ),
        FaqItem(
          question: '$signName burcu günlük burç yorumları ne kadar doğrudur?',
          answer:
              'Günlük burç yorumları genel kozmik enerjileri yansıtır. Her bireyin doğum haritası benzersiz olduğundan, kişiselleştirilmiş yorumlar için doğum haritası analizi ve transit raporları daha isabetli sonuçlar verir.',
        ),
        FaqItem(
          question: 'Yükselen burcum $signName ise ne anlama gelir?',
          answer:
              'Yükselen burç (Ascendant), doğum anınızda doğu ufkunda yükselen burçtur. Dış görünüşünüzü, başkalarının sizi nasıl algıladığını ve hayata yaklaşım tarzınızı temsil eder. Yükselen burcunuzu öğrenmek için doğum saatinizi bilmeniz gerekir.',
        ),
      ],
    );
  }

  /// Create FAQ section for birth chart
  factory FaqSection.birthChart() {
    return const FaqSection(
      title: 'Doğum Haritası SSS',
      subtitle: 'Natal chart hakkında merak edilenler',
      items: [
        FaqItem(
          question: 'Doğum haritası nedir?',
          answer:
              'Doğum haritası (natal chart), doğduğunuz anda gökyüzündeki gezegenlerin konumlarını gösteren kozmik bir haritadır. Güneş, Ay ve gezegenlerin hangi burçlarda ve evlerde olduğunu, birbirleriyle yaptıkları açıları gösterir.',
        ),
        FaqItem(
          question: 'Doğum haritası hesaplamak için nelere ihtiyacım var?',
          answer:
              'Doğum haritası hesaplamak için doğum tarihiniz, doğum saatiniz ve doğum yeriniz gereklidir. Doğum saati ne kadar hassas olursa, yükselen burç ve ev yerleşimleri o kadar doğru hesaplanır.',
        ),
        FaqItem(
          question: 'Doğum saatimi bilmiyorsam ne olur?',
          answer:
              'Doğum saati bilinmediğinde genellikle öğlen 12:00 kullanılır. Bu durumda Ay burcu ve yükselen burç hatalı çıkabilir. Gezegen burç yerleşimleri ve aralarındaki açılar yine de doğru hesaplanır.',
        ),
        FaqItem(
          question: 'Ev sistemleri (Placidus, Whole Sign) farkı nedir?',
          answer:
              'Farklı ev sistemleri, gökyüzünü 12 eve bölerken farklı matematiksel yöntemler kullanır. Placidus en yaygın kullanılan sistemdir. Whole Sign ise her burcun bir evi temsil ettiği antik sistemdir. Her iki sistem de geçerlidir.',
        ),
      ],
    );
  }

  /// Create FAQ section for tarot
  factory FaqSection.tarot() {
    return const FaqSection(
      title: 'Tarot SSS',
      subtitle: 'Tarot kartları hakkında bilmeniz gerekenler',
      items: [
        FaqItem(
          question: 'Tarot kartları geleceği gösterir mi?',
          answer:
              'Tarot kartları kesin geleceği değil, mevcut enerji alanınızı ve olasılıkları gösterir. Kartlar bir ayna gibi çalışır - bilinçaltınızı ve durumunuzu yansıtır. Gelecek, kararlarınız ve eylemlerinizle şekillenir.',
        ),
        FaqItem(
          question: 'Tarot destesi kaç karttan oluşur?',
          answer:
              'Standart tarot destesi 78 karttan oluşur: 22 Major Arcana (büyük sırlar) ve 56 Minor Arcana (küçük sırlar). Minor Arcana dört gruptan (Asalar, Kupalar, Kılıçlar, Pentaküller) ve her grupta 14 karttan oluşur.',
        ),
        FaqItem(
          question: 'Ters gelen kartlar ne anlama gelir?',
          answer:
              'Ters (reversed) kartlar, kartın enerjisinin bloke olduğunu, içselleştiğini veya aşırıya kaçtığını gösterebilir. Bazı tarot okuyucuları ters kartları kullanmazken, bazıları önemli bir nüans olarak değerlendirir.',
        ),
        FaqItem(
          question: 'Kendime tarot çekebilir miyim?',
          answer:
              'Evet, kendinize tarot çekebilirsiniz. Önemli olan niyetinizi net belirlemek ve kartları objektif yorumlamaktır. Günlük kart çekimi, öz-keşif için mükemmel bir pratiktir.',
        ),
      ],
    );
  }

  /// Create FAQ section for numerology
  factory FaqSection.numerology() {
    return const FaqSection(
      title: 'Numeroloji SSS',
      subtitle: 'Sayıların gizemli dünyası',
      items: [
        FaqItem(
          question: 'Numeroloji nedir?',
          answer:
              'Numeroloji, sayıların sembolik ve ruhani anlamlarını inceleyen antik bir bilgelik sistemidir. Doğum tarihinizdeki ve isminizdeki sayıların yaşam yolunuz, kişiliğiniz ve potansiyeliniz hakkında bilgi verdiğine inanılır.',
        ),
        FaqItem(
          question: 'Yaşam yolu sayısı nasıl hesaplanır?',
          answer:
              'Yaşam yolu sayınız, doğum tarihinizdeki tüm rakamların tek haneli bir sayıya (veya 11, 22, 33 gibi master sayılara) indirgenesiyle bulunur. Örnek: 15.05.1990 = 1+5+0+5+1+9+9+0 = 30 = 3+0 = 3',
        ),
        FaqItem(
          question: 'Master sayılar (11, 22, 33) nedir?',
          answer:
              'Master sayılar, özel bir potansiyel ve zorluk taşıyan güçlü titreşimlerdir. 11 sezgisel aydınlanmayı, 22 master yapıcıyı, 33 ise master öğretmeni temsil eder. Bu sayılar tek haneye indirgenmez.',
        ),
        FaqItem(
          question: 'İsim numerolojisi nasıl çalışır?',
          answer:
              'Her harfin bir sayısal değeri vardır (Pythagoras veya Keldani sisteminde). İsminizin harflerinin sayısal değerleri toplanarak ifade sayınız, ruh sayınız ve kişilik sayınız hesaplanır.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: isDark
                          ? AppColors.starGold
                          : AppColors.lightStarGold,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      subtitle!,
                      style: GoogleFonts.raleway(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textSecondary.withOpacity(0.7)
                            : AppColors.lightTextSecondary.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // FAQ Items
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _FaqItemWidget(
                  item: item,
                  initiallyExpanded: initiallyExpanded && index == 0,
                )
                .animate(delay: Duration(milliseconds: 50 * index))
                .fadeIn(duration: 300.ms);
          }),
        ],
      ),
    );
  }
}

/// Single FAQ item model
class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

/// Expandable FAQ item widget
class _FaqItemWidget extends StatefulWidget {
  final FaqItem item;
  final bool initiallyExpanded;

  const _FaqItemWidget({required this.item, this.initiallyExpanded = false});

  @override
  State<_FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<_FaqItemWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withOpacity(_isExpanded ? 0.08 : 0.05)
            : (_isExpanded
                  ? AppColors.lightCard
                  : AppColors.lightSurfaceVariant),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? (_isExpanded
                    ? AppColors.starGold.withOpacity(0.2)
                    : AppColors.textMuted.withOpacity(0.1))
              : (_isExpanded
                    ? AppColors.lightStarGold.withOpacity(0.3)
                    : AppColors.lightTextMuted.withOpacity(0.15)),
          width: _isExpanded ? 1.5 : 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingSm,
          ),
          childrenPadding: EdgeInsets.zero,
          initiallyExpanded: widget.initiallyExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.starGold.withOpacity(_isExpanded ? 0.2 : 0.1)
                  : AppColors.lightStarGold.withOpacity(
                      _isExpanded ? 0.2 : 0.1,
                    ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '?',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.starGold : AppColors.lightStarGold,
                ),
              ),
            ),
          ),
          title: Text(
            widget.item.question,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
              height: 1.4,
            ),
          ),
          trailing: AnimatedRotation(
            turns: _isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.expand_more,
              color: isDark
                  ? (_isExpanded ? AppColors.starGold : AppColors.textMuted)
                  : (_isExpanded
                        ? AppColors.lightStarGold
                        : AppColors.lightTextMuted),
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingLg + 32 + AppConstants.spacingMd,
                0,
                AppConstants.spacingLg,
                AppConstants.spacingLg,
              ),
              child: Text(
                widget.item.answer,
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact FAQ for inline usage
class FaqInline extends StatelessWidget {
  final String question;
  final String answer;

  const FaqInline({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withOpacity(0.05)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.textMuted.withOpacity(0.1)
              : AppColors.lightTextMuted.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.help_outline,
                size: 16,
                color: isDark ? AppColors.starGold : AppColors.lightStarGold,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              answer,
              style: GoogleFonts.raleway(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
