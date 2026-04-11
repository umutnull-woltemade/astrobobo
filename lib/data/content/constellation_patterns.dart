import '../models/constellation_data.dart';
import '../models/zodiac_sign.dart';

/// Static constellation data for all 12 zodiac signs
/// Based on real astronomical star positions, normalized to 0-1 coordinates
class ConstellationPatterns {
  ConstellationPatterns._();

  static final Map<ZodiacSign, ConstellationPattern> _patterns = {
    // ═══════════════════════════════════════════════════════════════════════
    // ARIES (Koç) - Simple curved line, 4 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.aries: ConstellationPattern(
      sign: ZodiacSign.aries,
      stars: const [
        ConstellationStar(
          x: 0.20,
          y: 0.30,
          magnitude: 2.0,
          name: 'Hamal',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.40, y: 0.40, magnitude: 2.6, name: 'Sheratan'),
        ConstellationStar(x: 0.60, y: 0.55, magnitude: 4.0, name: 'Mesarthim'),
        ConstellationStar(x: 0.80, y: 0.70, magnitude: 4.5, name: '41 Arietis'),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(2, 3),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // TAURUS (Boğa) - V-shape with horns, 7 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.taurus: ConstellationPattern(
      sign: ZodiacSign.taurus,
      stars: const [
        ConstellationStar(
          x: 0.15,
          y: 0.45,
          magnitude: 0.9,
          name: 'Aldebaran',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.30, y: 0.50, magnitude: 3.5, name: 'Ain'),
        ConstellationStar(x: 0.40, y: 0.55, magnitude: 3.0, name: 'Hyadum I'),
        ConstellationStar(x: 0.50, y: 0.45, magnitude: 3.4, name: 'Hyadum II'),
        ConstellationStar(x: 0.60, y: 0.35, magnitude: 2.9, name: 'Chamukuy'),
        ConstellationStar(x: 0.80, y: 0.20, magnitude: 1.7, name: 'Elnath'),
        ConstellationStar(x: 0.85, y: 0.55, magnitude: 3.0, name: 'Zeta Tauri'),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(2, 3),
        StarConnection(3, 4),
        StarConnection(4, 5),
        StarConnection(3, 6),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // GEMINI (İkizler) - Two parallel figures, 6 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.gemini: ConstellationPattern(
      sign: ZodiacSign.gemini,
      stars: const [
        ConstellationStar(
          x: 0.25,
          y: 0.15,
          magnitude: 1.2,
          name: 'Pollux',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.45, y: 0.15, magnitude: 1.6, name: 'Castor'),
        ConstellationStar(x: 0.30, y: 0.45, magnitude: 3.0, name: 'Wasat'),
        ConstellationStar(x: 0.50, y: 0.45, magnitude: 2.9, name: 'Mebsuta'),
        ConstellationStar(x: 0.35, y: 0.75, magnitude: 3.6, name: 'Mekbuda'),
        ConstellationStar(x: 0.60, y: 0.80, magnitude: 3.3, name: 'Alhena'),
      ],
      connections: const [
        StarConnection(0, 2),
        StarConnection(1, 3),
        StarConnection(2, 4),
        StarConnection(3, 5),
        StarConnection(2, 3),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // CANCER (Yengeç) - Y-shape, 5 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.cancer: ConstellationPattern(
      sign: ZodiacSign.cancer,
      stars: const [
        ConstellationStar(
          x: 0.50,
          y: 0.25,
          magnitude: 3.5,
          name: 'Al Tarf',
          isBrightest: true,
        ),
        ConstellationStar(
          x: 0.35,
          y: 0.45,
          magnitude: 4.0,
          name: 'Asellus Australis',
        ),
        ConstellationStar(
          x: 0.60,
          y: 0.50,
          magnitude: 4.7,
          name: 'Asellus Borealis',
        ),
        ConstellationStar(x: 0.20, y: 0.75, magnitude: 4.0, name: 'Acubens'),
        ConstellationStar(
          x: 0.75,
          y: 0.70,
          magnitude: 5.0,
          name: 'Iota Cancri',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(0, 2),
        StarConnection(1, 3),
        StarConnection(2, 4),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // LEO (Aslan) - Sickle + tail shape, 9 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.leo: ConstellationPattern(
      sign: ZodiacSign.leo,
      stars: const [
        ConstellationStar(
          x: 0.20,
          y: 0.40,
          magnitude: 1.4,
          name: 'Regulus',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.30, y: 0.25, magnitude: 2.1, name: 'Algieba'),
        ConstellationStar(x: 0.15, y: 0.55, magnitude: 2.6, name: 'Adhafera'),
        ConstellationStar(x: 0.25, y: 0.65, magnitude: 3.4, name: 'Rasalas'),
        ConstellationStar(
          x: 0.40,
          y: 0.15,
          magnitude: 3.5,
          name: 'Epsilon Leonis',
        ),
        ConstellationStar(x: 0.55, y: 0.30, magnitude: 2.2, name: 'Zosma'),
        ConstellationStar(x: 0.70, y: 0.40, magnitude: 2.6, name: 'Chertan'),
        ConstellationStar(x: 0.85, y: 0.55, magnitude: 2.0, name: 'Denebola'),
        ConstellationStar(x: 0.10, y: 0.75, magnitude: 4.0, name: 'Eta Leonis'),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(0, 2),
        StarConnection(2, 3),
        StarConnection(3, 8),
        StarConnection(1, 4),
        StarConnection(4, 5),
        StarConnection(5, 6),
        StarConnection(6, 7),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // VIRGO (Başak) - Y-shaped branching figure, 9 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.virgo: ConstellationPattern(
      sign: ZodiacSign.virgo,
      stars: const [
        ConstellationStar(
          x: 0.50,
          y: 0.85,
          magnitude: 1.0,
          name: 'Spica',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.45, y: 0.60, magnitude: 2.7, name: 'Porrima'),
        ConstellationStar(x: 0.55, y: 0.45, magnitude: 3.4, name: 'Auva'),
        ConstellationStar(
          x: 0.40,
          y: 0.35,
          magnitude: 2.8,
          name: 'Vindemiatrix',
        ),
        ConstellationStar(
          x: 0.30,
          y: 0.25,
          magnitude: 3.9,
          name: 'Eta Virginis',
        ),
        ConstellationStar(
          x: 0.65,
          y: 0.30,
          magnitude: 3.6,
          name: 'Zeta Virginis',
        ),
        ConstellationStar(
          x: 0.75,
          y: 0.20,
          magnitude: 3.9,
          name: 'Tau Virginis',
        ),
        ConstellationStar(
          x: 0.60,
          y: 0.15,
          magnitude: 4.2,
          name: 'Omicron Virginis',
        ),
        ConstellationStar(
          x: 0.20,
          y: 0.15,
          magnitude: 4.5,
          name: 'Beta Virginis',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(2, 3),
        StarConnection(3, 4),
        StarConnection(4, 8),
        StarConnection(2, 5),
        StarConnection(5, 6),
        StarConnection(5, 7),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // LIBRA (Terazi) - Scale/balance shape, 6 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.libra: ConstellationPattern(
      sign: ZodiacSign.libra,
      stars: const [
        ConstellationStar(
          x: 0.50,
          y: 0.25,
          magnitude: 2.6,
          name: 'Zubeneschamali',
          isBrightest: true,
        ),
        ConstellationStar(
          x: 0.30,
          y: 0.45,
          magnitude: 2.7,
          name: 'Zubenelgenubi',
        ),
        ConstellationStar(x: 0.70, y: 0.45, magnitude: 3.9, name: 'Brachium'),
        ConstellationStar(
          x: 0.20,
          y: 0.70,
          magnitude: 4.5,
          name: 'Gamma Librae',
        ),
        ConstellationStar(
          x: 0.50,
          y: 0.55,
          magnitude: 4.5,
          name: 'Upsilon Librae',
        ),
        ConstellationStar(
          x: 0.80,
          y: 0.70,
          magnitude: 4.0,
          name: 'Theta Librae',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(0, 2),
        StarConnection(1, 4),
        StarConnection(2, 4),
        StarConnection(1, 3),
        StarConnection(2, 5),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCORPIO (Akrep) - Curved tail with stinger, 10 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.scorpio: ConstellationPattern(
      sign: ZodiacSign.scorpio,
      stars: const [
        ConstellationStar(
          x: 0.30,
          y: 0.30,
          magnitude: 1.0,
          name: 'Antares',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.20, y: 0.20, magnitude: 2.6, name: 'Dschubba'),
        ConstellationStar(x: 0.25, y: 0.10, magnitude: 2.3, name: 'Acrab'),
        ConstellationStar(x: 0.15, y: 0.15, magnitude: 2.9, name: 'Pi Scorpii'),
        ConstellationStar(x: 0.40, y: 0.40, magnitude: 2.8, name: 'Alniyat'),
        ConstellationStar(x: 0.50, y: 0.50, magnitude: 2.4, name: 'Larawag'),
        ConstellationStar(x: 0.55, y: 0.65, magnitude: 2.3, name: 'Sargas'),
        ConstellationStar(
          x: 0.65,
          y: 0.75,
          magnitude: 3.0,
          name: 'Iota Scorpii',
        ),
        ConstellationStar(x: 0.75, y: 0.80, magnitude: 2.4, name: 'Girtab'),
        ConstellationStar(x: 0.85, y: 0.70, magnitude: 1.6, name: 'Shaula'),
      ],
      connections: const [
        StarConnection(2, 1),
        StarConnection(1, 3),
        StarConnection(1, 0),
        StarConnection(0, 4),
        StarConnection(4, 5),
        StarConnection(5, 6),
        StarConnection(6, 7),
        StarConnection(7, 8),
        StarConnection(8, 9),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SAGITTARIUS (Yay) - Teapot shape, 8 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.sagittarius: ConstellationPattern(
      sign: ZodiacSign.sagittarius,
      stars: const [
        ConstellationStar(
          x: 0.50,
          y: 0.50,
          magnitude: 1.8,
          name: 'Kaus Australis',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.40, y: 0.35, magnitude: 2.0, name: 'Nunki'),
        ConstellationStar(x: 0.55, y: 0.35, magnitude: 2.7, name: 'Ascella'),
        ConstellationStar(x: 0.65, y: 0.50, magnitude: 2.8, name: 'Kaus Media'),
        ConstellationStar(
          x: 0.75,
          y: 0.65,
          magnitude: 2.6,
          name: 'Kaus Borealis',
        ),
        ConstellationStar(
          x: 0.35,
          y: 0.55,
          magnitude: 3.0,
          name: 'Phi Sagittarii',
        ),
        ConstellationStar(x: 0.25, y: 0.70, magnitude: 3.2, name: 'Alnasl'),
        ConstellationStar(
          x: 0.45,
          y: 0.65,
          magnitude: 2.9,
          name: 'Tau Sagittarii',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(2, 3),
        StarConnection(3, 4),
        StarConnection(0, 5),
        StarConnection(5, 6),
        StarConnection(0, 7),
        StarConnection(7, 3),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // CAPRICORN (Oğlak) - Triangle-like closed shape, 7 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.capricorn: ConstellationPattern(
      sign: ZodiacSign.capricorn,
      stars: const [
        ConstellationStar(
          x: 0.15,
          y: 0.45,
          magnitude: 2.9,
          name: 'Deneb Algedi',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.25, y: 0.30, magnitude: 3.6, name: 'Nashira'),
        ConstellationStar(x: 0.40, y: 0.20, magnitude: 3.0, name: 'Dabih'),
        ConstellationStar(x: 0.55, y: 0.30, magnitude: 3.7, name: 'Algedi'),
        ConstellationStar(
          x: 0.70,
          y: 0.45,
          magnitude: 4.1,
          name: 'Zeta Capricorni',
        ),
        ConstellationStar(
          x: 0.80,
          y: 0.60,
          magnitude: 4.5,
          name: 'Omega Capricorni',
        ),
        ConstellationStar(
          x: 0.60,
          y: 0.70,
          magnitude: 4.0,
          name: 'Psi Capricorni',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(2, 3),
        StarConnection(3, 4),
        StarConnection(4, 5),
        StarConnection(5, 6),
        StarConnection(6, 0),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // AQUARIUS (Kova) - Y-shape with water stream, 7 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.aquarius: ConstellationPattern(
      sign: ZodiacSign.aquarius,
      stars: const [
        ConstellationStar(
          x: 0.40,
          y: 0.20,
          magnitude: 2.9,
          name: 'Sadalsuud',
          isBrightest: true,
        ),
        ConstellationStar(x: 0.55, y: 0.15, magnitude: 2.9, name: 'Sadalmelik'),
        ConstellationStar(x: 0.50, y: 0.40, magnitude: 3.8, name: 'Sadachbia'),
        ConstellationStar(x: 0.35, y: 0.50, magnitude: 3.3, name: 'Skat'),
        ConstellationStar(x: 0.25, y: 0.65, magnitude: 3.8, name: 'Albali'),
        ConstellationStar(
          x: 0.60,
          y: 0.60,
          magnitude: 4.2,
          name: 'Eta Aquarii',
        ),
        ConstellationStar(
          x: 0.75,
          y: 0.75,
          magnitude: 3.8,
          name: 'Lambda Aquarii',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(0, 2),
        StarConnection(2, 3),
        StarConnection(3, 4),
        StarConnection(2, 5),
        StarConnection(5, 6),
      ],
      brightestStarIndex: 0,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // PISCES (Balık) - Two fish connected, 7 stars
    // ═══════════════════════════════════════════════════════════════════════
    ZodiacSign.pisces: ConstellationPattern(
      sign: ZodiacSign.pisces,
      stars: const [
        ConstellationStar(
          x: 0.25,
          y: 0.35,
          magnitude: 3.6,
          name: 'Alrescha',
          isBrightest: true,
        ),
        ConstellationStar(
          x: 0.15,
          y: 0.50,
          magnitude: 4.5,
          name: 'Omega Piscium',
        ),
        ConstellationStar(
          x: 0.20,
          y: 0.65,
          magnitude: 4.3,
          name: 'Iota Piscium',
        ),
        ConstellationStar(
          x: 0.30,
          y: 0.20,
          magnitude: 4.4,
          name: 'Omicron Piscium',
        ),
        ConstellationStar(
          x: 0.50,
          y: 0.30,
          magnitude: 4.0,
          name: 'Eta Piscium',
        ),
        ConstellationStar(
          x: 0.70,
          y: 0.40,
          magnitude: 4.5,
          name: 'Gamma Piscium',
        ),
        ConstellationStar(
          x: 0.85,
          y: 0.55,
          magnitude: 4.3,
          name: 'Kullat Nunu',
        ),
      ],
      connections: const [
        StarConnection(0, 1),
        StarConnection(1, 2),
        StarConnection(0, 3),
        StarConnection(3, 4),
        StarConnection(4, 5),
        StarConnection(5, 6),
        StarConnection(0, 4),
      ],
      brightestStarIndex: 0,
    ),
  };

  /// Get constellation pattern for a zodiac sign
  static ConstellationPattern getPattern(ZodiacSign sign) {
    return _patterns[sign]!;
  }

  /// Get all patterns
  static Map<ZodiacSign, ConstellationPattern> get all => _patterns;
}
