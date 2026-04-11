import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../core/theme/app_colors.dart';
import '../../data/services/moon_service.dart';

/// Background theme for share cards
enum DreamCardTheme {
  mystical('Mistik', 'Derin mor ve yildizli gece'),
  minimal('Minimal', 'Temiz ve sade'),
  cosmic('Kozmik', 'Nebula ve galaksi'),
  aurora('Aurora', 'Kuzey isiklari'),
  moonlit('Ayisigi', 'Yumusak ay isigi'),
  golden('Altin', 'Sicak altin tonlari');

  final String label;
  final String description;
  const DreamCardTheme(this.label, this.description);
}

/// Font style for share cards
enum DreamCardFont {
  elegant('Zarif', 'serif'),
  modern('Modern', 'sans-serif'),
  mystical('Mistik', 'display'),
  handwritten('El Yazisi', 'cursive');

  final String label;
  final String fontType;
  const DreamCardFont(this.label, this.fontType);
}

/// Card template types
enum DreamCardTemplate {
  dreamQuote('Ruya Alintisi'),
  symbolInsight('Sembol Icgorüsu'),
  dailyMessage('Gunluk Mesaj'),
  moonPhase('Ay Fazı Bilgeligi'),
  personalInsight('Kisisel Icgoru'),
  archetypeDiscovery('Arketip Keşfi'),
  weeklySummary('Haftalik Ozet');

  final String label;
  const DreamCardTemplate(this.label);
}

/// Configuration for share card
class DreamShareCardConfig {
  final DreamCardTheme theme;
  final DreamCardFont font;
  final DreamCardTemplate template;
  final bool showEmoji;
  final bool showMoonPhase;
  final bool showWatermark;
  final List<String> selectedEmojis;
  final Color? accentColor;

  const DreamShareCardConfig({
    this.theme = DreamCardTheme.mystical,
    this.font = DreamCardFont.elegant,
    this.template = DreamCardTemplate.dreamQuote,
    this.showEmoji = true,
    this.showMoonPhase = true,
    this.showWatermark = true,
    this.selectedEmojis = const [],
    this.accentColor,
  });

  DreamShareCardConfig copyWith({
    DreamCardTheme? theme,
    DreamCardFont? font,
    DreamCardTemplate? template,
    bool? showEmoji,
    bool? showMoonPhase,
    bool? showWatermark,
    List<String>? selectedEmojis,
    Color? accentColor,
  }) {
    return DreamShareCardConfig(
      theme: theme ?? this.theme,
      font: font ?? this.font,
      template: template ?? this.template,
      showEmoji: showEmoji ?? this.showEmoji,
      showMoonPhase: showMoonPhase ?? this.showMoonPhase,
      showWatermark: showWatermark ?? this.showWatermark,
      selectedEmojis: selectedEmojis ?? this.selectedEmojis,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}

/// Reusable dream share card widget
class DreamShareCard extends StatelessWidget {
  final GlobalKey? repaintKey;
  final String mainText;
  final String? subtitle;
  final String? headerEmoji;
  final String? footerText;
  final DreamShareCardConfig config;
  final Size cardSize;

  const DreamShareCard({
    super.key,
    this.repaintKey,
    required this.mainText,
    this.subtitle,
    this.headerEmoji,
    this.footerText,
    this.config = const DreamShareCardConfig(),
    this.cardSize = const Size(350, 450),
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: cardSize.width,
      height: cardSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _getAccentColor().withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background
            Positioned.fill(child: _buildBackground()),
            // Decorative elements
            ..._buildDecorations(),
            // Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: _buildContent(context),
              ),
            ),
            // Watermark
            if (config.showWatermark)
              Positioned(bottom: 16, right: 20, child: _buildWatermark()),
          ],
        ),
      ),
    );

    if (repaintKey != null) {
      return RepaintBoundary(key: repaintKey, child: card);
    }
    return card;
  }

  Widget _buildBackground() {
    switch (config.theme) {
      case DreamCardTheme.mystical:
        return _MysticalBackground(accentColor: _getAccentColor());
      case DreamCardTheme.minimal:
        return _MinimalBackground(accentColor: _getAccentColor());
      case DreamCardTheme.cosmic:
        return _CosmicBackground(accentColor: _getAccentColor());
      case DreamCardTheme.aurora:
        return _AuroraBackground(accentColor: _getAccentColor());
      case DreamCardTheme.moonlit:
        return _MoonlitBackground(accentColor: _getAccentColor());
      case DreamCardTheme.golden:
        return _GoldenBackground(accentColor: _getAccentColor());
    }
  }

  List<Widget> _buildDecorations() {
    final decorations = <Widget>[];

    // Add selected emojis as floating decorations
    if (config.showEmoji && config.selectedEmojis.isNotEmpty) {
      for (int i = 0; i < config.selectedEmojis.length && i < 5; i++) {
        decorations.add(
          Positioned(
            top: 20.0 + (i * 40) + (i % 2 == 0 ? 10 : 0),
            right: 15.0 + (i * 15),
            child: Opacity(
              opacity: 0.4,
              child: Text(
                config.selectedEmojis[i],
                style: TextStyle(fontSize: 24 - (i * 2).toDouble()),
              ),
            ),
          ),
        );
      }
    }

    // Moon phase indicator
    if (config.showMoonPhase) {
      final moonPhase = MoonService.getCurrentPhase();
      decorations.add(
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(moonPhase.emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  moonPhase.nameTr,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return decorations;
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Header emoji
        if (headerEmoji != null) ...[
          Text(headerEmoji!, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 20),
        ],
        // Main text
        Text(mainText, textAlign: TextAlign.center, style: _getMainTextStyle()),
        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: _getSubtitleStyle(),
          ),
        ],
        // Footer text
        if (footerText != null) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              footerText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ],
    );
  }

  TextStyle _getMainTextStyle() {
    final baseStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.5,
      letterSpacing: 0.3,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    switch (config.font) {
      case DreamCardFont.elegant:
        return baseStyle.copyWith(fontFamily: 'Georgia');
      case DreamCardFont.modern:
        return baseStyle.copyWith(fontFamily: 'Helvetica');
      case DreamCardFont.mystical:
        return baseStyle.copyWith(
          fontFamily: 'Georgia',
          fontStyle: FontStyle.italic,
        );
      case DreamCardFont.handwritten:
        return baseStyle.copyWith(fontFamily: 'Brush Script MT');
    }
  }

  TextStyle _getSubtitleStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.white.withOpacity(0.8),
      letterSpacing: 0.5,
    );
  }

  Widget _buildWatermark() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\u{2728}',
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
        ),
        const SizedBox(width: 4),
        Text(
          'venusone.com',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Color _getAccentColor() {
    if (config.accentColor != null) return config.accentColor!;

    switch (config.theme) {
      case DreamCardTheme.mystical:
        return AppColors.mystic;
      case DreamCardTheme.minimal:
        return AppColors.cosmicPurple;
      case DreamCardTheme.cosmic:
        return AppColors.nebulaPurple;
      case DreamCardTheme.aurora:
        return AppColors.auroraStart;
      case DreamCardTheme.moonlit:
        return Colors.indigo;
      case DreamCardTheme.golden:
        return AppColors.starGold;
    }
  }
}

// ============================================================
// BACKGROUND WIDGETS
// ============================================================

class _MysticalBackground extends StatelessWidget {
  final Color accentColor;
  const _MysticalBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A0A2E),
            const Color(0xFF16082A),
            accentColor.withOpacity(0.3),
            const Color(0xFF0D0517),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: CustomPaint(painter: _StarsPainter(starCount: 50)),
    );
  }
}

class _MinimalBackground extends StatelessWidget {
  final Color accentColor;
  const _MinimalBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF1A1A2E), const Color(0xFF16213E)],
        ),
      ),
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                accentColor.withOpacity(0.2),
                accentColor.withOpacity(0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CosmicBackground extends StatelessWidget {
  final Color accentColor;
  const _CosmicBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.5),
          radius: 1.5,
          colors: [
            accentColor.withOpacity(0.4),
            const Color(0xFF0D0517),
            const Color(0xFF1A0A2E),
          ],
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(painter: _StarsPainter(starCount: 80)),
          // Nebula effect
          Positioned(
            top: 50,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.purple.withOpacity(0.3),
                    Colors.purple.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.blue.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuroraBackground extends StatelessWidget {
  final Color accentColor;
  const _AuroraBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        ),
      ),
      child: Stack(
        children: [
          // Aurora waves
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _AuroraPainter(),
            ),
          ),
          CustomPaint(painter: _StarsPainter(starCount: 40)),
        ],
      ),
    );
  }
}

class _MoonlitBackground extends StatelessWidget {
  final Color accentColor;
  const _MoonlitBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF1A1A3E), Color(0xFF0D0D1F)],
        ),
      ),
      child: Stack(
        children: [
          // Moon glow
          Positioned(
            top: 30,
            right: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          CustomPaint(painter: _StarsPainter(starCount: 30)),
        ],
      ),
    );
  }
}

class _GoldenBackground extends StatelessWidget {
  final Color accentColor;
  const _GoldenBackground({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1508),
            const Color(0xFF2D2410),
            accentColor.withOpacity(0.2),
            const Color(0xFF1A1508),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Golden sparkles
          CustomPaint(painter: _SparklesPainter(color: AppColors.starGold)),
        ],
      ),
    );
  }
}

// ============================================================
// PAINTERS
// ============================================================

class _StarsPainter extends CustomPainter {
  final int starCount;
  _StarsPainter({this.starCount = 50});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final random = 42; // Seed for consistent stars

    for (int i = 0; i < starCount; i++) {
      final x = ((random * (i + 1) * 17) % size.width.toInt()).toDouble();
      final y = ((random * (i + 1) * 31) % size.height.toInt()).toDouble();
      final starSize = ((random * (i + 1)) % 3 + 1).toDouble() * 0.5;
      final opacity = ((random * (i + 1)) % 60 + 40) / 100;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AuroraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(Offset.zero, Offset(size.width, 0), [
        Colors.green.withOpacity(0.1),
        Colors.cyan.withOpacity(0.15),
        Colors.purple.withOpacity(0.1),
      ]);

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width,
      size.height * 0.2,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SparklesPainter extends CustomPainter {
  final Color color;
  _SparklesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final random = 42;

    for (int i = 0; i < 30; i++) {
      final x = ((random * (i + 1) * 19) % size.width.toInt()).toDouble();
      final y = ((random * (i + 1) * 29) % size.height.toInt()).toDouble();
      final sparkleSize = ((random * (i + 1)) % 4 + 1).toDouble();

      paint.color = color.withOpacity(((random * (i + 1)) % 40 + 20) / 100);

      // Draw 4-pointed star
      final path = Path();
      path.moveTo(x, y - sparkleSize);
      path.lineTo(x + sparkleSize * 0.3, y);
      path.lineTo(x, y + sparkleSize);
      path.lineTo(x - sparkleSize * 0.3, y);
      path.close();

      path.moveTo(x - sparkleSize, y);
      path.lineTo(x, y + sparkleSize * 0.3);
      path.lineTo(x + sparkleSize, y);
      path.lineTo(x, y - sparkleSize * 0.3);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================
// SCREENSHOT CAPTURE UTILITY
// ============================================================

class DreamCardCapture {
  /// Capture the card as image bytes
  static Future<Uint8List?> captureCard(GlobalKey repaintKey) async {
    try {
      final boundary =
          repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Card capture error: $e');
      return null;
    }
  }
}

// ============================================================
// TEMPLATE BUILDERS
// ============================================================

class DreamCardTemplates {
  /// "Bu gece ruyamda..." template
  static DreamShareCard dreamQuoteCard({
    required String dreamQuote,
    String? symbol,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: symbol ?? '\u{1F319}',
      mainText: '"$dreamQuote"',
      footerText: 'Ruya Yorumu',
      config:
          config ??
          const DreamShareCardConfig(template: DreamCardTemplate.dreamQuote),
    );
  }

  /// Symbol meaning card
  static DreamShareCard symbolInsightCard({
    required String symbol,
    required String symbolEmoji,
    required String meaning,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: symbolEmoji,
      mainText: symbol,
      subtitle: meaning,
      footerText: 'Sembol Icgorusu',
      config:
          config ??
          const DreamShareCardConfig(template: DreamCardTemplate.symbolInsight),
    );
  }

  /// Moon phase wisdom card
  static DreamShareCard moonPhaseCard({
    required String moonMessage,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    final moonPhase = MoonService.getCurrentPhase();
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: moonPhase.emoji,
      mainText: moonMessage,
      subtitle: '${moonPhase.nameTr} Enerjisi',
      footerText: 'Ay Fazi Bilgeligi',
      config:
          config ??
          const DreamShareCardConfig(
            template: DreamCardTemplate.moonPhase,
            theme: DreamCardTheme.moonlit,
          ),
    );
  }

  /// Archetype discovery card
  static DreamShareCard archetypeCard({
    required String archetypeName,
    required String archetypeMessage,
    String? archetypeEmoji,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: archetypeEmoji ?? '\u{1F3AD}',
      mainText: archetypeName,
      subtitle: archetypeMessage,
      footerText: 'Arketip Kesfi',
      config:
          config ??
          const DreamShareCardConfig(
            template: DreamCardTemplate.archetypeDiscovery,
            theme: DreamCardTheme.cosmic,
          ),
    );
  }

  /// Personal insight card
  static DreamShareCard personalInsightCard({
    required String insight,
    String? emoji,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: emoji ?? '\u{2728}',
      mainText: insight,
      footerText: 'Kisisel Icgoru',
      config:
          config ??
          const DreamShareCardConfig(
            template: DreamCardTemplate.personalInsight,
          ),
    );
  }

  /// Daily dream message card
  static DreamShareCard dailyMessageCard({
    required String message,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: '\u{1F31F}',
      mainText: message,
      footerText: 'Gunluk Ruya Mesaji',
      config:
          config ??
          const DreamShareCardConfig(
            template: DreamCardTemplate.dailyMessage,
            theme: DreamCardTheme.golden,
          ),
    );
  }

  /// Weekly summary card
  static DreamShareCard weeklySummaryCard({
    required String summary,
    required int dreamCount,
    DreamShareCardConfig? config,
    GlobalKey? repaintKey,
  }) {
    return DreamShareCard(
      repaintKey: repaintKey,
      headerEmoji: '\u{1F4D6}',
      mainText: summary,
      subtitle: '$dreamCount ruya yorumlandi',
      footerText: 'Haftalik Ozet',
      config:
          config ??
          const DreamShareCardConfig(
            template: DreamCardTemplate.weeklySummary,
            theme: DreamCardTheme.aurora,
          ),
    );
  }
}

// ============================================================
// INSTAGRAM STORY FORMAT CARD (9:16)
// ============================================================

class InstagramStoryCard extends StatelessWidget {
  final GlobalKey? repaintKey;
  final String mainText;
  final String? subtitle;
  final String? headerEmoji;
  final DreamShareCardConfig config;

  const InstagramStoryCard({
    super.key,
    this.repaintKey,
    required this.mainText,
    this.subtitle,
    this.headerEmoji,
    this.config = const DreamShareCardConfig(),
  });

  @override
  Widget build(BuildContext context) {
    // Instagram story aspect ratio: 9:16 (1080x1920)
    return DreamShareCard(
      repaintKey: repaintKey,
      mainText: mainText,
      subtitle: subtitle,
      headerEmoji: headerEmoji,
      config: config,
      cardSize: const Size(270, 480), // 9:16 ratio scaled down
    );
  }
}
