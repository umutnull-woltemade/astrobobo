import 'zodiac_sign.dart';

/// Local Space Astrology
class LocalSpaceChart {
  final String userName;
  final DateTime birthDate;
  final double latitude;
  final double longitude;
  final List<LocalSpaceLine> planetLines;
  final List<DirectionalInfluence> directions;
  final String homeAnalysis;
  final String officeAnalysis;

  LocalSpaceChart({
    required this.userName,
    required this.birthDate,
    required this.latitude,
    required this.longitude,
    required this.planetLines,
    required this.directions,
    required this.homeAnalysis,
    required this.officeAnalysis,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'birthDate': birthDate.toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'planetLines': planetLines.map((l) => l.toJson()).toList(),
    'directions': directions.map((d) => d.toJson()).toList(),
    'homeAnalysis': homeAnalysis,
    'officeAnalysis': officeAnalysis,
  };

  factory LocalSpaceChart.fromJson(Map<String, dynamic> json) =>
      LocalSpaceChart(
        userName: json['userName'] as String,
        birthDate: DateTime.parse(json['birthDate'] as String),
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        planetLines: (json['planetLines'] as List)
            .map((l) => LocalSpaceLine.fromJson(l as Map<String, dynamic>))
            .toList(),
        directions: (json['directions'] as List)
            .map(
              (d) => DirectionalInfluence.fromJson(d as Map<String, dynamic>),
            )
            .toList(),
        homeAnalysis: json['homeAnalysis'] as String,
        officeAnalysis: json['officeAnalysis'] as String,
      );
}

class LocalSpaceLine {
  final String planet;
  final double azimuth; // Direction in degrees (0-360)
  final CardinalDirection direction;
  final String meaning;
  final String homeAdvice;
  final String travelAdvice;

  LocalSpaceLine({
    required this.planet,
    required this.azimuth,
    required this.direction,
    required this.meaning,
    required this.homeAdvice,
    required this.travelAdvice,
  });

  Map<String, dynamic> toJson() => {
    'planet': planet,
    'azimuth': azimuth,
    'direction': direction.index,
    'meaning': meaning,
    'homeAdvice': homeAdvice,
    'travelAdvice': travelAdvice,
  };

  factory LocalSpaceLine.fromJson(Map<String, dynamic> json) => LocalSpaceLine(
    planet: json['planet'] as String,
    azimuth: (json['azimuth'] as num).toDouble(),
    direction: CardinalDirection.values[json['direction'] as int],
    meaning: json['meaning'] as String,
    homeAdvice: json['homeAdvice'] as String,
    travelAdvice: json['travelAdvice'] as String,
  );
}

class DirectionalInfluence {
  final CardinalDirection direction;
  final List<String> activePlanets;
  final String theme;
  final String advice;
  final int strengthRating; // 1-5

  DirectionalInfluence({
    required this.direction,
    required this.activePlanets,
    required this.theme,
    required this.advice,
    required this.strengthRating,
  });

  Map<String, dynamic> toJson() => {
    'direction': direction.index,
    'activePlanets': activePlanets,
    'theme': theme,
    'advice': advice,
    'strengthRating': strengthRating,
  };

  factory DirectionalInfluence.fromJson(Map<String, dynamic> json) =>
      DirectionalInfluence(
        direction: CardinalDirection.values[json['direction'] as int],
        activePlanets: List<String>.from(json['activePlanets'] as List),
        theme: json['theme'] as String,
        advice: json['advice'] as String,
        strengthRating: json['strengthRating'] as int,
      );
}

enum CardinalDirection {
  north,
  northeast,
  east,
  southeast,
  south,
  southwest,
  west,
  northwest,
}

extension CardinalDirectionExtension on CardinalDirection {
  String get nameTr {
    switch (this) {
      case CardinalDirection.north:
        return 'Kuzey';
      case CardinalDirection.northeast:
        return 'Kuzeydoğu';
      case CardinalDirection.east:
        return 'Doğu';
      case CardinalDirection.southeast:
        return 'Güneydoğu';
      case CardinalDirection.south:
        return 'Güney';
      case CardinalDirection.southwest:
        return 'Güneybatı';
      case CardinalDirection.west:
        return 'Batı';
      case CardinalDirection.northwest:
        return 'Kuzeybatı';
    }
  }

  String get symbol {
    switch (this) {
      case CardinalDirection.north:
        return 'N';
      case CardinalDirection.northeast:
        return 'NE';
      case CardinalDirection.east:
        return 'E';
      case CardinalDirection.southeast:
        return 'SE';
      case CardinalDirection.south:
        return 'S';
      case CardinalDirection.southwest:
        return 'SW';
      case CardinalDirection.west:
        return 'W';
      case CardinalDirection.northwest:
        return 'NW';
    }
  }

  String get icon {
    switch (this) {
      case CardinalDirection.north:
        return '⬆️';
      case CardinalDirection.northeast:
        return '↗️';
      case CardinalDirection.east:
        return '➡️';
      case CardinalDirection.southeast:
        return '↘️';
      case CardinalDirection.south:
        return '⬇️';
      case CardinalDirection.southwest:
        return '↙️';
      case CardinalDirection.west:
        return '⬅️';
      case CardinalDirection.northwest:
        return '↖️';
    }
  }

  double get azimuthStart {
    switch (this) {
      case CardinalDirection.north:
        return 337.5;
      case CardinalDirection.northeast:
        return 22.5;
      case CardinalDirection.east:
        return 67.5;
      case CardinalDirection.southeast:
        return 112.5;
      case CardinalDirection.south:
        return 157.5;
      case CardinalDirection.southwest:
        return 202.5;
      case CardinalDirection.west:
        return 247.5;
      case CardinalDirection.northwest:
        return 292.5;
    }
  }
}

/// Family/Children Horoscopes
class FamilyHoroscope {
  final List<FamilyMember> members;
  final String familyDynamics;
  final List<String> strengthsAsFamily;
  final List<String> challengesAsFamily;
  final String communicationStyle;
  final String familyAdvice;
  final DateTime date;

  FamilyHoroscope({
    required this.members,
    required this.familyDynamics,
    required this.strengthsAsFamily,
    required this.challengesAsFamily,
    required this.communicationStyle,
    required this.familyAdvice,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'members': members.map((m) => m.toJson()).toList(),
    'familyDynamics': familyDynamics,
    'strengthsAsFamily': strengthsAsFamily,
    'challengesAsFamily': challengesAsFamily,
    'communicationStyle': communicationStyle,
    'familyAdvice': familyAdvice,
    'date': date.toIso8601String(),
  };

  factory FamilyHoroscope.fromJson(Map<String, dynamic> json) =>
      FamilyHoroscope(
        members: (json['members'] as List)
            .map((m) => FamilyMember.fromJson(m as Map<String, dynamic>))
            .toList(),
        familyDynamics: json['familyDynamics'] as String,
        strengthsAsFamily: List<String>.from(json['strengthsAsFamily'] as List),
        challengesAsFamily: List<String>.from(
          json['challengesAsFamily'] as List,
        ),
        communicationStyle: json['communicationStyle'] as String,
        familyAdvice: json['familyAdvice'] as String,
        date: DateTime.parse(json['date'] as String),
      );
}

class FamilyMember {
  final String name;
  final FamilyRole role;
  final DateTime birthDate;
  final ZodiacSign sunSign;
  final String dailyAdvice;
  final String relationshipTip;
  final int energyLevel; // 1-5

  FamilyMember({
    required this.name,
    required this.role,
    required this.birthDate,
    required this.sunSign,
    required this.dailyAdvice,
    required this.relationshipTip,
    required this.energyLevel,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role.index,
    'birthDate': birthDate.toIso8601String(),
    'sunSign': sunSign.index,
    'dailyAdvice': dailyAdvice,
    'relationshipTip': relationshipTip,
    'energyLevel': energyLevel,
  };

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    name: json['name'] as String,
    role: FamilyRole.values[json['role'] as int],
    birthDate: DateTime.parse(json['birthDate'] as String),
    sunSign: ZodiacSign.values[json['sunSign'] as int],
    dailyAdvice: json['dailyAdvice'] as String,
    relationshipTip: json['relationshipTip'] as String,
    energyLevel: json['energyLevel'] as int,
  );
}

enum FamilyRole { parent, child, sibling, grandparent, spouse, other }

extension FamilyRoleExtension on FamilyRole {
  String get nameTr {
    switch (this) {
      case FamilyRole.parent:
        return 'Ebeveyn';
      case FamilyRole.child:
        return 'Çocuk';
      case FamilyRole.sibling:
        return 'Kardeş';
      case FamilyRole.grandparent:
        return 'Büyükanne/Baba';
      case FamilyRole.spouse:
        return 'Eş';
      case FamilyRole.other:
        return 'Diğer';
    }
  }

  String get icon {
    switch (this) {
      case FamilyRole.parent:
        return '👨‍👩‍👧';
      case FamilyRole.child:
        return '👶';
      case FamilyRole.sibling:
        return '👫';
      case FamilyRole.grandparent:
        return '👴';
      case FamilyRole.spouse:
        return '💑';
      case FamilyRole.other:
        return '👤';
    }
  }
}

/// Children's Horoscope
class ChildHoroscope {
  final String childName;
  final DateTime birthDate;
  final ZodiacSign sunSign;
  final ZodiacSign? moonSign;
  final String personalityProfile;
  final String learningStyle;
  final String socialStyle;
  final String emotionalNeeds;
  final List<String> talents;
  final List<String> challenges;
  final String parentingTips;
  final String dailyHoroscope;
  final int moodRating; // 1-5
  final int energyRating; // 1-5
  final int focusRating; // 1-5

  ChildHoroscope({
    required this.childName,
    required this.birthDate,
    required this.sunSign,
    this.moonSign,
    required this.personalityProfile,
    required this.learningStyle,
    required this.socialStyle,
    required this.emotionalNeeds,
    required this.talents,
    required this.challenges,
    required this.parentingTips,
    required this.dailyHoroscope,
    required this.moodRating,
    required this.energyRating,
    required this.focusRating,
  });

  Map<String, dynamic> toJson() => {
    'childName': childName,
    'birthDate': birthDate.toIso8601String(),
    'sunSign': sunSign.index,
    'moonSign': moonSign?.index,
    'personalityProfile': personalityProfile,
    'learningStyle': learningStyle,
    'socialStyle': socialStyle,
    'emotionalNeeds': emotionalNeeds,
    'talents': talents,
    'challenges': challenges,
    'parentingTips': parentingTips,
    'dailyHoroscope': dailyHoroscope,
    'moodRating': moodRating,
    'energyRating': energyRating,
    'focusRating': focusRating,
  };

  factory ChildHoroscope.fromJson(Map<String, dynamic> json) => ChildHoroscope(
    childName: json['childName'] as String,
    birthDate: DateTime.parse(json['birthDate'] as String),
    sunSign: ZodiacSign.values[json['sunSign'] as int],
    moonSign: json['moonSign'] != null
        ? ZodiacSign.values[json['moonSign'] as int]
        : null,
    personalityProfile: json['personalityProfile'] as String,
    learningStyle: json['learningStyle'] as String,
    socialStyle: json['socialStyle'] as String,
    emotionalNeeds: json['emotionalNeeds'] as String,
    talents: List<String>.from(json['talents'] as List),
    challenges: List<String>.from(json['challenges'] as List),
    parentingTips: json['parentingTips'] as String,
    dailyHoroscope: json['dailyHoroscope'] as String,
    moodRating: json['moodRating'] as int,
    energyRating: json['energyRating'] as int,
    focusRating: json['focusRating'] as int,
  );
}
