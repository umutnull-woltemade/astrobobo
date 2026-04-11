import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Eğlence Amaçlı Disclaimer Widget
///
/// Tüm yorumlama içeren sayfalarda kullanılır.
/// App Store uyumluluğu ve yasal koruma için gereklidir.
///
/// KULLANIM:
/// ```dart
/// // Sayfa sonuna ekle (footer'dan önce)
/// const EntertainmentDisclaimer(),
/// ```

class EntertainmentDisclaimer extends StatelessWidget {
  final bool compact;
  final String? customText;

  const EntertainmentDisclaimer({
    super.key,
    this.compact = false,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final text =
        customText ??
        'Bu içerik eğlence amaçlıdır ve profesyonel tavsiye yerine geçmez.';

    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: isDark
                ? Colors.white30
                : AppColors.textLight.withValues(alpha: 0.6),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 14,
            color: isDark
                ? Colors.white30
                : AppColors.textLight.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: isDark
                    ? Colors.white38
                    : AppColors.textLight.withValues(alpha: 0.7),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kategori bazlı disclaimer metinleri
class DisclaimerTexts {
  static const String general =
      'Bu içerik eğlence amaçlıdır ve profesyonel tavsiye yerine geçmez.';

  static const String dreams =
      'Rüya yorumları eğlence amaçlıdır. Psikolojik destek için uzmana başvurun.';

  static const String health =
      'Bu içerik tıbbi tavsiye değildir. Sağlık konularında doktorunuza danışın.';

  static const String astrology =
      'Astrolojik yorumlar eğlence amaçlıdır ve bilimsel kesinlik taşımaz.';

  static const String tarot =
      'Tarot okumaları eğlence amaçlıdır ve geleceği garanti etmez.';

  static const String numerology =
      'Numeroloji yorumları eğlence amaçlıdır ve kişisel rehberlik yerine geçmez.';

  static const String chakra =
      'Enerji yorumları eğlence amaçlıdır. Sağlık sorunları için uzmana başvurun.';

  static const String compatibility =
      'Uyum analizleri eğlence amaçlıdır ve ilişki kararlarınızı belirlememeli.';
}

/// Sayfa footer'ı ile disclaimer birlikte
class PageFooterWithDisclaimer extends StatelessWidget {
  final String brandText; // "Rüya İzi — Venus One"
  final String? disclaimerText;
  final bool showDisclaimer;

  const PageFooterWithDisclaimer({
    super.key,
    required this.brandText,
    this.disclaimerText,
    this.showDisclaimer = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        if (showDisclaimer) ...[
          EntertainmentDisclaimer(compact: true, customText: disclaimerText),
          const SizedBox(height: 8),
        ],
        Center(
          child: Text(
            brandText,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : AppColors.textLight,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
