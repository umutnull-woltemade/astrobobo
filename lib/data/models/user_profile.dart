import 'package:uuid/uuid.dart';
import 'zodiac_sign.dart';

class UserProfile {
  final String id;
  final String? name;
  final DateTime birthDate;
  final String? birthTime;
  final String? birthPlace;
  final double? birthLatitude;
  final double? birthLongitude;
  final ZodiacSign sunSign;
  final ZodiacSign? moonSign;
  final ZodiacSign? risingSign;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPrimary;
  final String? relationship; // 'partner', 'friend', 'family', 'child', etc.
  final String? avatarEmoji; // Custom emoji for the profile

  UserProfile({
    String? id,
    this.name,
    required this.birthDate,
    this.birthTime,
    this.birthPlace,
    this.birthLatitude,
    this.birthLongitude,
    ZodiacSign? sunSign,
    this.moonSign,
    this.risingSign,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPrimary = false,
    this.relationship,
    this.avatarEmoji,
  }) : id = id ?? const Uuid().v4(),
       sunSign = sunSign ?? ZodiacSignExtension.fromDate(birthDate),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'birthDate': birthDate.toIso8601String(),
    'birthTime': birthTime,
    'birthPlace': birthPlace,
    'birthLatitude': birthLatitude,
    'birthLongitude': birthLongitude,
    'sunSign': sunSign.index,
    'moonSign': moonSign?.index,
    'risingSign': risingSign?.index,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'isPrimary': isPrimary,
    'relationship': relationship,
    'avatarEmoji': avatarEmoji,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final sunSignIndex = json['sunSign'] as int? ?? 0;
    final moonSignIndex = json['moonSign'] as int?;
    final risingSignIndex = json['risingSign'] as int?;

    return UserProfile(
      id: json['id'] as String?,
      name: json['name'] as String?,
      birthDate: DateTime.parse(json['birthDate'] as String),
      birthTime: json['birthTime'] as String?,
      birthPlace: json['birthPlace'] as String?,
      birthLatitude: json['birthLatitude'] as double?,
      birthLongitude: json['birthLongitude'] as double?,
      sunSign: (sunSignIndex >= 0 && sunSignIndex < ZodiacSign.values.length)
          ? ZodiacSign.values[sunSignIndex]
          : null,
      moonSign:
          (moonSignIndex != null &&
              moonSignIndex >= 0 &&
              moonSignIndex < ZodiacSign.values.length)
          ? ZodiacSign.values[moonSignIndex]
          : null,
      risingSign:
          (risingSignIndex != null &&
              risingSignIndex >= 0 &&
              risingSignIndex < ZodiacSign.values.length)
          ? ZodiacSign.values[risingSignIndex]
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      isPrimary: json['isPrimary'] as bool? ?? false,
      relationship: json['relationship'] as String?,
      avatarEmoji: json['avatarEmoji'] as String?,
    );
  }

  UserProfile copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? birthTime,
    String? birthPlace,
    double? birthLatitude,
    double? birthLongitude,
    ZodiacSign? sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? risingSign,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPrimary,
    String? relationship,
    String? avatarEmoji,
  }) => UserProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    birthDate: birthDate ?? this.birthDate,
    birthTime: birthTime ?? this.birthTime,
    birthPlace: birthPlace ?? this.birthPlace,
    birthLatitude: birthLatitude ?? this.birthLatitude,
    birthLongitude: birthLongitude ?? this.birthLongitude,
    sunSign: sunSign ?? this.sunSign,
    moonSign: moonSign ?? this.moonSign,
    risingSign: risingSign ?? this.risingSign,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? DateTime.now(),
    isPrimary: isPrimary ?? this.isPrimary,
    relationship: relationship ?? this.relationship,
    avatarEmoji: avatarEmoji ?? this.avatarEmoji,
  );

  /// Check if the profile has complete birth data for chart calculation
  bool get hasCompleteBirthData =>
      birthTime != null && birthLatitude != null && birthLongitude != null;

  /// Check if moon and rising signs have been calculated
  bool get hasCalculatedSigns => moonSign != null && risingSign != null;

  /// Get effective moon sign (falls back to sun sign if not calculated)
  /// Moon sign can reasonably fallback to sun sign for approximate readings
  ZodiacSign get effectiveMoonSign => moonSign ?? sunSign;

  /// Get actual rising sign - returns null if not calculated
  /// Rising sign should NEVER fallback to sun sign as they are fundamentally different
  /// Rising sign requires exact birth time and location to calculate accurately
  ZodiacSign? get actualRisingSign => risingSign;

  /// DEPRECATED: Use actualRisingSign instead
  /// This getter incorrectly falls back to sun sign which causes inconsistencies
  @Deprecated(
    'Use actualRisingSign instead - risingSign should not fallback to sunSign',
  )
  ZodiacSign get effectiveRisingSign => risingSign ?? sunSign;

  /// Get display emoji (uses relationship emoji or sign emoji)
  String get displayEmoji => avatarEmoji ?? sunSign.symbol;

  /// Get relationship display name
  String get relationshipLabel {
    switch (relationship) {
      case 'partner':
        return 'Partner';
      case 'friend':
        return 'Arkadaş';
      case 'family':
        return 'Aile';
      case 'child':
        return 'Çocuk';
      case 'crush':
        return 'İlgi';
      case 'ex':
        return 'Eski';
      case 'colleague':
        return 'İş Arkadaşı';
      default:
        return relationship ?? '';
    }
  }

  /// Calculate age from birth date
  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
