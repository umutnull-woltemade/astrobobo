import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/user_profile.dart';
import '../models/zodiac_sign.dart';
import '../models/planet.dart';
import 'moon_service.dart';

/// PDF Report Generator Service for Birth Charts and Horoscopes
class PdfReportService {
  static final PdfReportService _instance = PdfReportService._internal();
  factory PdfReportService() => _instance;
  PdfReportService._internal();

  // Brand colors
  static const _primaryColor = PdfColor.fromInt(0xFF7C3AED);
  static const _goldColor = PdfColor.fromInt(0xFFFFD700);
  static const _textMuted = PdfColor.fromInt(0xFFA0A0A0);

  /// Generate a complete birth chart report
  Future<Uint8List> generateBirthChartReport({
    required UserProfile profile,
    required Map<Planet, ZodiacSign> planetPositions,
    required Map<Planet, int> planetHouses,
    required ZodiacSign? ascendant,
    required ZodiacSign? moonSign,
  }) async {
    final pdf = pw.Document();

    // Load fonts
    final regularFont = await PdfGoogleFonts.nunitoRegular();
    final boldFont = await PdfGoogleFonts.nunitoBold();
    final italicFont = await PdfGoogleFonts.nunitoItalic();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: regularFont,
          bold: boldFont,
          italic: italicFont,
        ),
        header: (context) => _buildHeader(profile, context),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildTitleSection(profile),
          pw.SizedBox(height: 20),
          _buildBirthDataSection(profile),
          pw.SizedBox(height: 30),
          _buildBigThreeSection(profile.sunSign, moonSign, ascendant),
          pw.SizedBox(height: 30),
          _buildPlanetPositionsSection(planetPositions, planetHouses),
          pw.SizedBox(height: 30),
          _buildElementDistributionSection(planetPositions),
          pw.SizedBox(height: 30),
          _buildModalityDistributionSection(planetPositions),
          pw.SizedBox(height: 30),
          _buildPersonalityInterpretation(profile.sunSign, moonSign, ascendant),
        ],
      ),
    );

    return pdf.save();
  }

  /// Generate a daily horoscope report
  Future<Uint8List> generateDailyHoroscopeReport({
    required UserProfile profile,
    required String horoscope,
    required DateTime date,
  }) async {
    final pdf = pw.Document();

    final regularFont = await PdfGoogleFonts.nunitoRegular();
    final boldFont = await PdfGoogleFonts.nunitoBold();
    final italicFont = await PdfGoogleFonts.nunitoItalic();

    final moonPhase = MoonService.getCurrentPhase(date);
    final moonSign = MoonService.getCurrentMoonSign(date);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: regularFont,
          bold: boldFont,
          italic: italicFont,
        ),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildDailyHeader(profile, date),
            pw.SizedBox(height: 30),
            _buildMoonInfoSection(moonPhase, moonSign),
            pw.SizedBox(height: 30),
            _buildDailyHoroscopeContent(horoscope),
            pw.SizedBox(height: 30),
            _buildDailyRecommendations(profile.sunSign),
            pw.Spacer(),
            _buildFooter(context),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  /// Generate compatibility report
  Future<Uint8List> generateCompatibilityReport({
    required UserProfile profile1,
    required UserProfile profile2,
    required int compatibilityScore,
    required Map<String, int> categoryScores,
    required String analysis,
  }) async {
    final pdf = pw.Document();

    final regularFont = await PdfGoogleFonts.nunitoRegular();
    final boldFont = await PdfGoogleFonts.nunitoBold();
    final italicFont = await PdfGoogleFonts.nunitoItalic();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(
          base: regularFont,
          bold: boldFont,
          italic: italicFont,
        ),
        header: (context) =>
            _buildCompatibilityHeader(profile1, profile2, context),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildCompatibilityTitleSection(profile1, profile2),
          pw.SizedBox(height: 30),
          _buildCompatibilityScoreSection(compatibilityScore),
          pw.SizedBox(height: 30),
          _buildCategoryScoresSection(categoryScores),
          pw.SizedBox(height: 30),
          _buildCompatibilityAnalysis(analysis),
        ],
      ),
    );

    return pdf.save();
  }

  // ============== Private Build Methods ==============

  pw.Widget _buildHeader(UserProfile profile, pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _goldColor, width: 1)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'VENUS ONE',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
              letterSpacing: 2,
            ),
          ),
          pw.Text(
            'Dogum Haritasi Raporu',
            style: const pw.TextStyle(fontSize: 10, color: _textMuted),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: _textMuted, width: 0.5)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Venus One - Kozmik Rehberiniz',
            style: const pw.TextStyle(fontSize: 8, color: _textMuted),
          ),
          pw.Text(
            'Sayfa ${context.pageNumber}/${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 8, color: _textMuted),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTitleSection(UserProfile profile) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF3E8FF),
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: _primaryColor, width: 1),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            profile.sunSign.symbol,
            style: const pw.TextStyle(fontSize: 48),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            profile.name ?? 'Kullanici',
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            '${profile.sunSign.nameTr} Burcu',
            style: const pw.TextStyle(fontSize: 16, color: _textMuted),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildBirthDataSection(UserProfile profile) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFFEF9E7),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _buildBirthDataItem(
            'Dogum Tarihi',
            '${profile.birthDate.day}.${profile.birthDate.month}.${profile.birthDate.year}',
          ),
          _buildBirthDataItem('Dogum Saati', profile.birthTime ?? 'Bilinmiyor'),
          _buildBirthDataItem('Dogum Yeri', profile.birthPlace ?? 'Bilinmiyor'),
        ],
      ),
    );
  }

  pw.Widget _buildBirthDataItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: _textMuted),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _buildBigThreeSection(
    ZodiacSign sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? ascendant,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'BUYuK UC',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildBigThreeItem(
                'Gunes Burcu',
                sunSign.symbol,
                sunSign.nameTr,
                'Temel kimligin, ego ve yasam amacin',
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: _buildBigThreeItem(
                'Ay Burcu',
                moonSign?.symbol ?? '?',
                moonSign?.nameTr ?? 'Bilinmiyor',
                'Duygusal dogan, ic dunya ve sezgiler',
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: _buildBigThreeItem(
                'Yukselan',
                ascendant?.symbol ?? '?',
                ascendant?.nameTr ?? 'Bilinmiyor',
                'Dis gorunum ve baskalarinin seni nasil gordugu',
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildBigThreeItem(
    String title,
    String symbol,
    String sign,
    String description,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF0F0F5),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            title,
            style: const pw.TextStyle(fontSize: 10, color: _textMuted),
          ),
          pw.SizedBox(height: 8),
          pw.Text(symbol, style: const pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 4),
          pw.Text(
            sign,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            description,
            style: const pw.TextStyle(fontSize: 8, color: _textMuted),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPlanetPositionsSection(
    Map<Planet, ZodiacSign> positions,
    Map<Planet, int> houses,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'GEZEGEN KONUMLARI',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Table(
          border: pw.TableBorder.all(color: _textMuted, width: 0.5),
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFFF3E8FF),
              ),
              children: [
                _buildTableCell('Gezegen', isHeader: true),
                _buildTableCell('Burc', isHeader: true),
                _buildTableCell('Ev', isHeader: true),
                _buildTableCell('Anlami', isHeader: true),
              ],
            ),
            // Data rows
            ...positions.entries.map((entry) {
              final planet = entry.key;
              final sign = entry.value;
              final house = houses[planet] ?? 1;
              return pw.TableRow(
                children: [
                  _buildTableCell('${planet.symbol} ${planet.nameTr}'),
                  _buildTableCell('${sign.symbol} ${sign.nameTr}'),
                  _buildTableCell('$house. Ev'),
                  _buildTableCell(_getPlanetMeaning(planet), fontSize: 8),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildTableCell(
    String text, {
    bool isHeader = false,
    double fontSize = 10,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: fontSize,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? _primaryColor : PdfColors.black,
        ),
      ),
    );
  }

  pw.Widget _buildElementDistributionSection(
    Map<Planet, ZodiacSign> positions,
  ) {
    final elementCounts = <Element, int>{};
    for (final sign in positions.values) {
      elementCounts[sign.element] = (elementCounts[sign.element] ?? 0) + 1;
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'ELEMENT DAGILIMI',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: Element.values.map((element) {
            final count = elementCounts[element] ?? 0;
            return _buildElementItem(element, count, positions.length);
          }).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildElementItem(Element element, int count, int total) {
    final percentage = (count / total * 100).round();
    return pw.Column(
      children: [
        pw.Text(element.symbol, style: const pw.TextStyle(fontSize: 24)),
        pw.SizedBox(height: 4),
        pw.Text(
          element.nameTr,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          '$count gezegen ($percentage%)',
          style: const pw.TextStyle(fontSize: 10, color: _textMuted),
        ),
      ],
    );
  }

  pw.Widget _buildModalityDistributionSection(
    Map<Planet, ZodiacSign> positions,
  ) {
    final modalityCounts = <Modality, int>{};
    for (final sign in positions.values) {
      modalityCounts[sign.modality] = (modalityCounts[sign.modality] ?? 0) + 1;
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'MODALITE DAGILIMI',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: Modality.values.map((modality) {
            final count = modalityCounts[modality] ?? 0;
            return _buildModalityItem(modality, count, positions.length);
          }).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildModalityItem(Modality modality, int count, int total) {
    final percentage = (count / total * 100).round();
    return pw.Container(
      width: 150,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF0F0F5),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            modality.nameTr,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            '$count gezegen ($percentage%)',
            style: const pw.TextStyle(fontSize: 10, color: _textMuted),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            _getModalityMeaning(modality),
            style: const pw.TextStyle(fontSize: 8, color: _textMuted),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getModalityMeaning(Modality modality) {
    switch (modality) {
      case Modality.cardinal:
        return 'Baslatan, lider, girisimci';
      case Modality.fixed:
        return 'Kararli, istikrarli, direncli';
      case Modality.mutable:
        return 'Esnek, uyumlu, degisken';
    }
  }

  pw.Widget _buildPersonalityInterpretation(
    ZodiacSign sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? ascendant,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'KISILIK YORUMU',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Container(
          padding: const pw.EdgeInsets.all(15),
          decoration: pw.BoxDecoration(
            color: const PdfColor.fromInt(0xFFF3E8FF),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Gunes ${sunSign.nameTr} Burcunda',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                _getSunSignInterpretation(sunSign),
                style: const pw.TextStyle(fontSize: 10),
              ),
              if (moonSign != null) ...[
                pw.SizedBox(height: 15),
                pw.Text(
                  'Ay ${moonSign.nameTr} Burcunda',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  _getMoonSignInterpretation(moonSign),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
              if (ascendant != null) ...[
                pw.SizedBox(height: 15),
                pw.Text(
                  'Yukselan ${ascendant.nameTr} Burcunda',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  _getAscendantInterpretation(ascendant),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ============== Daily Horoscope Methods ==============

  pw.Widget _buildDailyHeader(UserProfile profile, DateTime date) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [PdfColor.fromInt(0xFFF3E8FF), PdfColor.fromInt(0xFFE8F4FF)],
        ),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            profile.sunSign.symbol,
            style: const pw.TextStyle(fontSize: 48),
          ),
          pw.SizedBox(width: 20),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'GUNLUK BURC YORUMU',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                profile.sunSign.nameTr,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '${date.day}.${date.month}.${date.year}',
                style: const pw.TextStyle(fontSize: 12, color: _textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildMoonInfoSection(MoonPhase phase, MoonSign sign) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFFEF9E7),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(
            children: [
              pw.Text(phase.emoji, style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 4),
              pw.Text(
                'Ay Evresi',
                style: const pw.TextStyle(fontSize: 8, color: _textMuted),
              ),
              pw.Text(
                phase.nameTr,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Column(
            children: [
              pw.Text(sign.symbol, style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 4),
              pw.Text(
                'Ay Burcu',
                style: const pw.TextStyle(fontSize: 8, color: _textMuted),
              ),
              pw.Text(
                sign.nameTr,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildDailyHoroscopeContent(String horoscope) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _primaryColor, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Text(
        horoscope,
        style: const pw.TextStyle(fontSize: 11, lineSpacing: 1.5),
      ),
    );
  }

  pw.Widget _buildDailyRecommendations(ZodiacSign sign) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'GUNUN ONERISI',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildRecommendationItem(
                'Sanslı Sayin',
                _getLuckyNumber(sign).toString(),
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: _buildRecommendationItem(
                'Sanslı Renk',
                _getLuckyColor(sign),
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: _buildRecommendationItem('Dikkat', _getCautionArea(sign)),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildRecommendationItem(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF0F0F5),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 8, color: _textMuted),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ============== Compatibility Report Methods ==============

  pw.Widget _buildCompatibilityHeader(
    UserProfile profile1,
    UserProfile profile2,
    pw.Context context,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _goldColor, width: 1)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'VENUS ONE',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
              letterSpacing: 2,
            ),
          ),
          pw.Text(
            'Uyum Raporu',
            style: const pw.TextStyle(fontSize: 10, color: _textMuted),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCompatibilityTitleSection(
    UserProfile profile1,
    UserProfile profile2,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [PdfColor.fromInt(0xFFFFE8F0), PdfColor.fromInt(0xFFF3E8FF)],
        ),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(
            children: [
              pw.Text(
                profile1.sunSign.symbol,
                style: const pw.TextStyle(fontSize: 36),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                profile1.name ?? 'Kisi 1',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                profile1.sunSign.nameTr,
                style: const pw.TextStyle(fontSize: 10, color: _textMuted),
              ),
            ],
          ),
          pw.Text(
            '+',
            style: const pw.TextStyle(fontSize: 24, color: _goldColor),
          ),
          pw.Column(
            children: [
              pw.Text(
                profile2.sunSign.symbol,
                style: const pw.TextStyle(fontSize: 36),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                profile2.name ?? 'Kisi 2',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                profile2.sunSign.nameTr,
                style: const pw.TextStyle(fontSize: 10, color: _textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCompatibilityScoreSection(int score) {
    return pw.Center(
      child: pw.Column(
        children: [
          pw.Text(
            'GENEL UYUM',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _textMuted,
              letterSpacing: 2,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            width: 100,
            height: 100,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              border: pw.Border.all(color: _getScoreColor(score), width: 4),
            ),
            child: pw.Center(
              child: pw.Text(
                '%$score',
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                  color: _getScoreColor(score),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCategoryScoresSection(Map<String, int> categoryScores) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'KATEGORI BAZLI UYUM',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        pw.SizedBox(height: 15),
        ...categoryScores.entries.map(
          (entry) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: _buildCategoryScoreBar(entry.key, entry.value),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildCategoryScoreBar(String category, int score) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 100,
          child: pw.Text(category, style: const pw.TextStyle(fontSize: 10)),
        ),
        pw.Expanded(
          child: pw.Stack(
            children: [
              pw.Container(
                height: 12,
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xFFE0E0E0),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
              ),
              pw.Container(
                height: 12,
                width: score * 2.0,
                decoration: pw.BoxDecoration(
                  color: _getScoreColor(score),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Text(
          '%$score',
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _buildCompatibilityAnalysis(String analysis) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _primaryColor, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'DETAYLI ANALIZ',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            analysis,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 1.5),
          ),
        ],
      ),
    );
  }

  // ============== Helper Methods ==============

  PdfColor _getScoreColor(int score) {
    if (score >= 80) return const PdfColor.fromInt(0xFF4CAF50);
    if (score >= 60) return const PdfColor.fromInt(0xFF8BC34A);
    if (score >= 40) return const PdfColor.fromInt(0xFFFFEB3B);
    if (score >= 20) return const PdfColor.fromInt(0xFFFF9800);
    return const PdfColor.fromInt(0xFFF44336);
  }

  String _getPlanetMeaning(Planet planet) {
    switch (planet) {
      case Planet.sun:
        return 'Kimlik, ego, yaşam amacı';
      case Planet.moon:
        return 'Duygular, içgüdü, anne';
      case Planet.mercury:
        return 'İletişim, düşünce, öğrenme';
      case Planet.venus:
        return 'Aşk, güzellik, değerler';
      case Planet.mars:
        return 'Enerji, tutku, eylem';
      case Planet.jupiter:
        return 'Genişleme, şans, felsefe';
      case Planet.saturn:
        return 'Disiplin, sorumluluk, sınırlar';
      case Planet.uranus:
        return 'Değişim, özgürlük, yenilik';
      case Planet.neptune:
        return 'Hayal gücü, spiritualite, sezgi';
      case Planet.pluto:
        return 'Dönüşüm, güç, yeniden doğuş';
      case Planet.northNode:
        return 'Hayat amacı, ruhsal yolculuk';
      case Planet.southNode:
        return 'Geçmiş yaşam, doğal yetenekler';
      case Planet.chiron:
        return 'Yaralı şifacı, şifa yolculuğu';
      case Planet.lilith:
        return 'Gölge ben, bastırılan arzular';
      case Planet.ascendant:
        return 'Dış görünüm, ilk izlenim';
      case Planet.midheaven:
        return 'Kariyer, toplumsal imaj';
      case Planet.ic:
        return 'Ev, aile, kökler';
      case Planet.descendant:
        return 'İlişkiler, partnerlik';
    }
  }

  String _getSunSignInterpretation(ZodiacSign sign) {
    final interpretations = <ZodiacSign, String>{
      ZodiacSign.aries:
          'Doğal bir lider olarak, cesur ve girişimcisiniz. Yeni başlangıçlara atılmaktan çekinmiyorsunuz ve rekabetçi ruhunuz sizi ileriye taşıyor.',
      ZodiacSign.taurus:
          'Kararlı ve güvenilir bir yapıya sahipsiniz. Maddi güvenlik ve konfor sizin için önemli, sabır ve inatçılığınız hedeflerinize ulaşmanızı sağlıyor.',
      ZodiacSign.gemini:
          'Meraklı ve çeşitli ilgi alanlarına sahip birisiniz. İletişim yetenekleriniz güçlü ve sosyal çevrenizdeki entelektüel sohbetleri seviyorsunuz.',
      ZodiacSign.cancer:
          'Duygusal derinliğiniz ve sezgilerinizle öne çıkıyorsunuz. Aile ve ev sizin için büyük önem taşıyor, koruyucu ve besleyici bir doğanız var.',
      ZodiacSign.leo:
          'Yaratıcılığınız ve çekiciliğinizle dikkat çekiyorsunuz. Liderlik özellikleri taşıyor ve ilgi odağı olmaktan hoşlanıyorsunuz.',
      ZodiacSign.virgo:
          'Analitik zekanız ve detaylara verdiğiniz önemle tanınıyorsunuz. Mükemmeliyetçi yaklaşımınız hem gücünüz hem de geliştirmeniz gereken bir alan.',
      ZodiacSign.libra:
          'Denge ve harmoni arayışındasınız. İlişkileriniz sizin için çok önemli ve adalet duygunuz güçlü, diplomatik yeteneklerinizle tanınıyorsunuz.',
      ZodiacSign.scorpio:
          'Derin ve yoğun bir yapınız var. Gizleri çözme yeteneğiniz ve dönüşüm gücü sizi farklı kılıyor, sadakatiniz tartışmasız.',
      ZodiacSign.sagittarius:
          'Özgür ruhunuz ve macera arayışınızla tanınıyorsunuz. Felsefi bir yapıya sahip, sürekli öğrenme ve keşfetme arzusu içerisindesiniz.',
      ZodiacSign.capricorn:
          'Hırsınız ve azminizle hedeflerinize ulaşıyorsunuz. Disiplinli ve sorumluluk sahibisiniz, uzun vadeli planlara değer veriyorsunuz.',
      ZodiacSign.aquarius:
          'Yenilikçi ve bağımsız düşüncenizle öne çıkıyorsunuz. İnsanlık için büyük ideallere sahipsiniz ve sıra dışı olmaktan çekinmiyorsunuz.',
      ZodiacSign.pisces:
          'Sezgisel ve empatik doğanızla tanınıyorsunuz. Sanatsal yetenekleriniz ve spiritüel eğilimleriniz sizi özel kılıyor.',
    };
    return interpretations[sign] ?? 'Birçok benzersiz yeteneğe sahipsiniz.';
  }

  String _getMoonSignInterpretation(ZodiacSign sign) {
    final interpretations = <ZodiacSign, String>{
      ZodiacSign.aries:
          'Duygusal tepkileriniz hızlı ve tutkulu. Sabırsızlık yaşayabilirsiniz ama duygusal cesaretiniz etkileyici.',
      ZodiacSign.taurus:
          'Duygusal güvenlik sizin için çok önemli. Sabit ve güvenilir duygusal yapınız var, değişime direnç gösterebilirsiniz.',
      ZodiacSign.gemini:
          'Duygularınızı ifade etmekte yeteneklisiniz. Merak ve iletişim duygusal ihtiyaçlarınızın bir parçası.',
      ZodiacSign.cancer:
          'Ay kendi evinde olduğu için duygusal sezgileriniz çok güçlü. Evrensel anne/baba arketipini taşıyorsunuz.',
      ZodiacSign.leo:
          'Sıcak ve coşkulu bir duygusal yapınız var. Sevilmek ve takdir edilmek duygusal ihtiyacınız.',
      ZodiacSign.virgo:
          'Duygusal analiz yeteneğiniz güçlü. Başkalarına hizmet etmek size duygusal tatmin getiriyor.',
      ZodiacSign.libra:
          'İlişkiler duygusal dengeniz için çok önemli. Harmoni ve estetik size huzur veriyor.',
      ZodiacSign.scorpio:
          'Derin ve yoğun duygusal deneyimler yaşıyorsunuz. Duygusal dönüşüm ve iyileşme temel temalarınız.',
      ZodiacSign.sagittarius:
          'Duygusal özgürlüğe ihtiyaç duyuyorsunuz. İyimserlik ve macera ruhunuz sizi besliyor.',
      ZodiacSign.capricorn:
          'Duygularınızı kontrol altına almaya çalışıyorsunuz. Duygusal olgunluk ve sorumluluk önemli temalarınız.',
      ZodiacSign.aquarius:
          'Duygusal bağımsızlık sizin için önemli. İnsanlık için duyduğunuz duygu güçlü.',
      ZodiacSign.pisces:
          'Sezgisel ve empatik duygusal yapınız var. Spiritüel deneyimler duygusal beslenmenizin parçası.',
    };
    return interpretations[sign] ?? 'Duygusal dünyanız zengin ve çeşitli.';
  }

  String _getAscendantInterpretation(ZodiacSign sign) {
    final interpretations = <ZodiacSign, String>{
      ZodiacSign.aries:
          'İlk izlenim olarak enerjik, kararlı ve lider ruhlu görünüyorsunuz. Cesur ve girişimci bir imaj çiziyorsunuz.',
      ZodiacSign.taurus:
          'Sakin, güvenilir ve ayakları yere basan biri olarak algılanıyorsunuz. Fiziksel görünümünüz etkileyici.',
      ZodiacSign.gemini:
          'Meraklı, iletişime açık ve genç bir enerji yansıtıyorsunuz. Çevik ve esprili olarak algılanıyorsunuz.',
      ZodiacSign.cancer:
          'Sıcak, koruyucu ve besleyici biri olarak görülüyorsunuz. Ev ve aile temaları hayatınızda belirgin.',
      ZodiacSign.leo:
          'Karizmatik, dikkat çekici ve kendine güvenen biri olarak algılanıyorsunuz. Sahne sizin için doğal bir alan.',
      ZodiacSign.virgo:
          'Düzenli, analitik ve detaycı biri olarak görülüyorsunuz. Yardımsever ve pratik bir imaj çiziyorsunuz.',
      ZodiacSign.libra:
          'Zarif, dengeli ve diplomatik biri olarak algılanıyorsunuz. İlişkiler hayatınızın merkezinde.',
      ZodiacSign.scorpio:
          'Gizemli, yoğun ve manyetik biri olarak görülüyorsunuz. Güçlü bir var oluşunuz var.',
      ZodiacSign.sagittarius:
          'İyimser, maceracı ve özgür ruhlu biri olarak algılanıyorsunuz. Felsefi bir hava taşıyorsunuz.',
      ZodiacSign.capricorn:
          'Ciddi, profesyonel ve hırslı biri olarak görülüyorsunuz. Otorite figürü olarak algılanabilirsiniz.',
      ZodiacSign.aquarius:
          'Farklı, yenilikçi ve bağımsız biri olarak algılanıyorsunuz. Orijinal bir stil sergiliyorsunuz.',
      ZodiacSign.pisces:
          'Hayalperest, sanatsal ve spiritüel biri olarak görülüyorsunuz. Empatik ve anlayışlı bir enerji yayıyorsunuz.',
    };
    return interpretations[sign] ?? 'Benzersiz bir dış görünümünüz var.';
  }

  int _getLuckyNumber(ZodiacSign sign) {
    final now = DateTime.now();
    final seed = now.day + now.month + sign.index;
    return (seed % 9) + 1;
  }

  String _getLuckyColor(ZodiacSign sign) {
    final colors = [
      'Kırmızı',
      'Mavi',
      'Yeşil',
      'Mor',
      'Turuncu',
      'Sarı',
      'Pembe',
      'Beyaz',
    ];
    final now = DateTime.now();
    final index = (now.day + sign.index) % colors.length;
    return colors[index];
  }

  String _getCautionArea(ZodiacSign sign) {
    final areas = ['İletişim', 'Finans', 'Sağlık', 'İlişkiler', 'İş', 'Aile'];
    final now = DateTime.now();
    final index = (now.day + sign.index + 3) % areas.length;
    return areas[index];
  }

  // ============== Public Methods ==============

  /// Preview PDF in system viewer
  Future<void> previewPdf(Uint8List pdfData) async {
    await Printing.layoutPdf(onLayout: (_) => pdfData);
  }

  /// Share PDF
  Future<void> sharePdf(Uint8List pdfData, String filename) async {
    await Printing.sharePdf(bytes: pdfData, filename: filename);
  }

  /// Save PDF to device
  Future<bool> savePdf(Uint8List pdfData, String filename) async {
    try {
      await Printing.sharePdf(bytes: pdfData, filename: filename);
      return true;
    } catch (e) {
      return false;
    }
  }
}
