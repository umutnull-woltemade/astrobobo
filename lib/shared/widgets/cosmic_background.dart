import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CosmicBackground extends StatelessWidget {
  final Widget child;
  final bool showStars;
  final bool showGradient;

  const CosmicBackground({
    super.key,
    required this.child,
    this.showStars = true,
    this.showGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    // WEB: ALWAYS use dark gradient (onboarding UI designed for dark mode)
    // This check MUST be first - before isDark check, otherwise light mode
    // returns early and web never gets the dark gradient
    if (kIsWeb) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1a2e), // Dark purple-blue
              Color(0xFF0D0D1A), // Deep space black
            ],
          ),
        ),
        child: child,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Light mode - clean, soft gradient background
    if (!isDark) {
      return Container(
        decoration: BoxDecoration(
          gradient: showGradient
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.lightBackground,
                    AppColors.lightSurfaceVariant,
                  ],
                )
              : null,
          color: showGradient ? null : AppColors.lightBackground,
        ),
        child: child,
      );
    }

    // Dark mode - Full cosmic background on native platforms
    return Stack(
      children: [
        // Ana kozmik arka plan - nebula ve yıldızlar
        const Positioned.fill(
          child: IgnorePointer(child: _BeautifulCosmicBackground()),
        ),
        // Content
        child,
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SIMPLIFIED WEB BACKGROUND - Lightweight for web platform
// ═══════════════════════════════════════════════════════════════════════════
class _SimplifiedWebBackground extends StatelessWidget {
  const _SimplifiedWebBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D0D1A), // Deep space black
            Color(0xFF1A1A2E), // Dark purple
            Color(0xFF16213E), // Navy blue
            Color(0xFF0F0F1A), // Deep black
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Simple stars overlay
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _SimpleStarsPainter(),
                willChange: false,
              ),
            ),
          ),
          // Subtle glow effects
          Positioned(
            top: 100,
            left: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF9C27B0).withOpacity(0.15),
                    const Color(0xFF9C27B0).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2196F3).withOpacity(0.12),
                    const Color(0xFF2196F3).withOpacity(0.0),
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

class _SimpleStarsPainter extends CustomPainter {
  static final List<_SimpleStar> _stars = _generateSimpleStars();

  static List<_SimpleStar> _generateSimpleStars() {
    final random = math.Random(42);
    final stars = <_SimpleStar>[];

    // Only 100 stars for web performance
    for (int i = 0; i < 100; i++) {
      stars.add(
        _SimpleStar(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 0.5 + random.nextDouble() * 1.5,
          opacity: 0.3 + random.nextDouble() * 0.5,
        ),
      );
    }
    return stars;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (final star in _stars) {
      paint.color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SimpleStar {
  final double x;
  final double y;
  final double size;
  final double opacity;

  const _SimpleStar({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// GÜZEL KOZMİK ARKA PLAN - Nebula, yıldızlar, ışık efektleri
// ═══════════════════════════════════════════════════════════════════════════
class _BeautifulCosmicBackground extends StatelessWidget {
  const _BeautifulCosmicBackground();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: const _CosmicPainter(),
        willChange: false,
        isComplex: true,
      ),
    );
  }
}

class _CosmicPainter extends CustomPainter {
  const _CosmicPainter();

  // Sabit veriler - çoğu zaman aynı
  static final List<_Star> _stars = _generateStars();
  static final List<_Nebula> _nebulas = _generateNebulas();
  static final List<_GlowOrb> _glowOrbs = _generateGlowOrbs();
  static final List<_EsotericSymbol> _symbols = _generateEsotericSymbols();

  static List<_Star> _generateStars() {
    final random = math.Random(42);
    final stars = <_Star>[];

    // 200 yıldız - farklı boyut ve parlaklıkta
    for (int i = 0; i < 200; i++) {
      final size = random.nextDouble();
      stars.add(
        _Star(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: size < 0.7
              ? 0.5 + random.nextDouble() * 1.0
              : 1.5 + random.nextDouble() * 2.5,
          opacity: 0.3 + random.nextDouble() * 0.7,
          hasGlow: size > 0.85, // Büyük yıldızlarda glow efekti
          color: _getStarColor(random),
        ),
      );
    }
    return stars;
  }

  static Color _getStarColor(math.Random random) {
    final colors = [
      Colors.white,
      Colors.white,
      Colors.white,
      const Color(0xFFFFE4B5), // Sıcak sarı
      const Color(0xFFADD8E6), // Açık mavi
      const Color(0xFFFFB6C1), // Pembe
      const Color(0xFFE6E6FA), // Lavanta
    ];
    return colors[random.nextInt(colors.length)];
  }

  static List<_Nebula> _generateNebulas() {
    return [
      // Mor nebula - sol üst
      _Nebula(
        x: 0.15,
        y: 0.2,
        radiusX: 0.4,
        radiusY: 0.3,
        color: const Color(0xFF9C27B0),
        opacity: 0.15,
      ),
      // Pembe nebula - sağ orta
      _Nebula(
        x: 0.85,
        y: 0.4,
        radiusX: 0.35,
        radiusY: 0.45,
        color: const Color(0xFFE91E63),
        opacity: 0.12,
      ),
      // Mavi nebula - alt
      _Nebula(
        x: 0.5,
        y: 0.85,
        radiusX: 0.5,
        radiusY: 0.3,
        color: const Color(0xFF3F51B5),
        opacity: 0.1,
      ),
      // Turkuaz nebula - orta
      _Nebula(
        x: 0.3,
        y: 0.6,
        radiusX: 0.25,
        radiusY: 0.35,
        color: const Color(0xFF00BCD4),
        opacity: 0.08,
      ),
      // Altın nebula - sağ üst
      _Nebula(
        x: 0.8,
        y: 0.15,
        radiusX: 0.2,
        radiusY: 0.2,
        color: const Color(0xFFFFD700),
        opacity: 0.06,
      ),
    ];
  }

  static List<_GlowOrb> _generateGlowOrbs() {
    return [
      // Büyük mor ışık
      _GlowOrb(
        x: 0.1,
        y: 0.3,
        size: 0.15,
        color: const Color(0xFF9C27B0),
        opacity: 0.3,
      ),
      // Pembe ışık
      _GlowOrb(
        x: 0.9,
        y: 0.5,
        size: 0.12,
        color: const Color(0xFFE91E63),
        opacity: 0.25,
      ),
      // Mavi ışık
      _GlowOrb(
        x: 0.5,
        y: 0.9,
        size: 0.18,
        color: const Color(0xFF2196F3),
        opacity: 0.2,
      ),
      // Turkuaz ışık
      _GlowOrb(
        x: 0.2,
        y: 0.7,
        size: 0.1,
        color: const Color(0xFF00BCD4),
        opacity: 0.2,
      ),
      // Altın ışık
      _GlowOrb(
        x: 0.75,
        y: 0.2,
        size: 0.08,
        color: const Color(0xFFFFD700),
        opacity: 0.15,
      ),
    ];
  }

  // Ezoterik semboller - burç ve gezegen sembolleri
  static List<_EsotericSymbol> _generateEsotericSymbols() {
    final random = math.Random(99);
    final symbols = <_EsotericSymbol>[];

    // Burç sembolleri
    const zodiacSymbols = [
      '♈',
      '♉',
      '♊',
      '♋',
      '♌',
      '♍',
      '♎',
      '♏',
      '♐',
      '♑',
      '♒',
      '♓',
    ];
    // Gezegen sembolleri
    const planetSymbols = ['☉', '☽', '☿', '♀', '♂', '♃', '♄', '♅', '♆', '⚷'];
    // Ezoterik semboller
    const esotericSymbols = ['✧', '⚹', '△', '☆', '◇', '⬡', '⊛', '✦'];

    // Pastel renkler
    const pastelColors = [
      Color(0xFFE6E6FA), // Lavanta
      Color(0xFFFFB6C1), // Pembe
      Color(0xFFADD8E6), // Açık mavi
      Color(0xFFFFE4B5), // Sıcak sarı
      Color(0xFFB0E0E6), // Turkuaz
      Color(0xFFDDA0DD), // Mor
      Color(0xFF98FB98), // Yeşil
      Color(0xFFF0E68C), // Altın
    ];

    final allSymbols = [...zodiacSymbols, ...planetSymbols, ...esotericSymbols];

    // 25-30 sembol ekle - dağınık ve soluk
    for (int i = 0; i < 28; i++) {
      symbols.add(
        _EsotericSymbol(
          x: random.nextDouble(),
          y: random.nextDouble(),
          symbol: allSymbols[random.nextInt(allSymbols.length)],
          size: 14 + random.nextDouble() * 20, // 14-34 arası boyut
          opacity: 0.04 + random.nextDouble() * 0.08, // Soluk: 0.04-0.12
          rotation: random.nextDouble() * math.pi * 2,
          color: pastelColors[random.nextInt(pastelColors.length)],
        ),
      );
    }
    return symbols;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Derin uzay gradient arka planı
    _drawSpaceGradient(canvas, size);

    // 2. Nebula bulutları
    _drawNebulas(canvas, size);

    // 3. Parlak ışık küreleri
    _drawGlowOrbs(canvas, size);

    // 4. Ezoterik semboller (burç, gezegen)
    _drawEsotericSymbols(canvas, size);

    // 5. Yıldızlar
    _drawStars(canvas, size);
  }

  void _drawSpaceGradient(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = ui.Gradient.linear(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.7, size.height),
      [
        const Color(0xFF0D0D1A), // Derin uzay siyahı
        const Color(0xFF1A1A2E), // Koyu mor
        const Color(0xFF16213E), // Lacivert
        const Color(0xFF1A1A2E), // Koyu mor
        const Color(0xFF0F0F1A), // Derin siyah
      ],
      [0.0, 0.25, 0.5, 0.75, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = gradient);
  }

  void _drawNebulas(Canvas canvas, Size size) {
    for (final nebula in _nebulas) {
      final center = Offset(nebula.x * size.width, nebula.y * size.height);
      final radiusX = nebula.radiusX * size.width;
      final radiusY = nebula.radiusY * size.height;

      final gradient = ui.Gradient.radial(
        center,
        math.max(radiusX, radiusY),
        [
          nebula.color.withOpacity(nebula.opacity),
          nebula.color.withOpacity(nebula.opacity * 0.5),
          nebula.color.withOpacity(0),
        ],
        [0.0, 0.5, 1.0],
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(1.0, radiusY / radiusX);
      canvas.translate(-center.dx, -center.dy);

      canvas.drawCircle(
        center,
        radiusX,
        Paint()
          ..shader = gradient
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50),
      );
      canvas.restore();
    }
  }

  void _drawGlowOrbs(Canvas canvas, Size size) {
    for (final orb in _glowOrbs) {
      final center = Offset(orb.x * size.width, orb.y * size.height);
      final radius = orb.size * size.width;

      final gradient = ui.Gradient.radial(
        center,
        radius,
        [
          orb.color.withOpacity(orb.opacity),
          orb.color.withOpacity(orb.opacity * 0.3),
          orb.color.withOpacity(0),
        ],
        [0.0, 0.4, 1.0],
      );

      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = gradient
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30),
      );
    }
  }

  void _drawStars(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final star in _stars) {
      final center = Offset(star.x * size.width, star.y * size.height);

      // Glow efekti olan yıldızlar için
      if (star.hasGlow) {
        canvas.drawCircle(
          center,
          star.size * 3,
          Paint()
            ..color = star.color.withOpacity(star.opacity * 0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
        );
      }

      // Ana yıldız
      paint.color = star.color.withOpacity(star.opacity);
      canvas.drawCircle(center, star.size, paint);
    }
  }

  void _drawEsotericSymbols(Canvas canvas, Size size) {
    for (final symbol in _symbols) {
      final center = Offset(symbol.x * size.width, symbol.y * size.height);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(symbol.rotation);

      final textPainter = TextPainter(
        text: TextSpan(
          text: symbol.symbol,
          style: TextStyle(
            fontSize: symbol.size,
            color: symbol.color.withOpacity(symbol.opacity),
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _CosmicPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// VERİ MODELLERİ
// ═══════════════════════════════════════════════════════════════════════════

class _Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final bool hasGlow;
  final Color color;

  const _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.hasGlow,
    required this.color,
  });
}

class _Nebula {
  final double x;
  final double y;
  final double radiusX;
  final double radiusY;
  final Color color;
  final double opacity;

  const _Nebula({
    required this.x,
    required this.y,
    required this.radiusX,
    required this.radiusY,
    required this.color,
    required this.opacity,
  });
}

class _GlowOrb {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double opacity;

  const _GlowOrb({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.opacity,
  });
}

class _EsotericSymbol {
  final double x;
  final double y;
  final String symbol;
  final double size;
  final double opacity;
  final double rotation;
  final Color color;

  const _EsotericSymbol({
    required this.x,
    required this.y,
    required this.symbol,
    required this.size,
    required this.opacity,
    required this.rotation,
    this.color = const Color(0xFFE6E6FA), // Lavanta - varsayılan
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// LEGACY WIDGET'LAR - Uyumluluk için
// ═══════════════════════════════════════════════════════════════════════════

class StarField extends StatelessWidget {
  const StarField({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BeautifulCosmicBackground();
  }
}

class StaticStarField extends StatelessWidget {
  const StaticStarField({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BeautifulCosmicBackground();
  }
}

class GlowingOrb extends StatelessWidget {
  final Color color;
  final double size;
  final double blurRadius;

  const GlowingOrb({
    super.key,
    required this.color,
    this.size = 200,
    this.blurRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: blurRadius,
            spreadRadius: blurRadius / 2,
          ),
        ],
      ),
    );
  }
}
