import 'api_client.dart';

/// API service for compatibility-related endpoints
class CompatibilityApiService {
  final ApiClient _client;

  CompatibilityApiService(this._client);

  /// Calculate compatibility between two birth profiles
  Future<ApiResponse<CompatibilityResultDto>> calculateCompatibility({
    required String person1ProfileId,
    required String person2ProfileId,
  }) async {
    return _client.post<CompatibilityResultDto>(
      '/compatibility/profiles',
      body: {
        'person1ProfileId': person1ProfileId,
        'person2ProfileId': person2ProfileId,
      },
      fromJson: (json) => CompatibilityResultDto.fromJson(json),
    );
  }

  /// Calculate basic compatibility between two zodiac signs
  Future<ApiResponse<SignCompatibilityDto>> calculateSignCompatibility({
    required String sign1,
    required String sign2,
  }) async {
    return _client.get<SignCompatibilityDto>(
      '/compatibility/signs',
      queryParams: {'sign1': sign1.toLowerCase(), 'sign2': sign2.toLowerCase()},
      fromJson: (json) => SignCompatibilityDto.fromJson(json),
    );
  }
}

class CompatibilityResultDto {
  final double overallScore;
  final double emotionalScore;
  final double communicationScore;
  final double passionScore;
  final double stabilityScore;
  final double growthScore;
  final List<String> strengths;
  final List<String> challenges;
  final List<String> advice;
  final List<InterAspectDto> interAspects;
  final List<String> compositeHighlights;

  CompatibilityResultDto({
    required this.overallScore,
    required this.emotionalScore,
    required this.communicationScore,
    required this.passionScore,
    required this.stabilityScore,
    required this.growthScore,
    required this.strengths,
    required this.challenges,
    required this.advice,
    required this.interAspects,
    required this.compositeHighlights,
  });

  factory CompatibilityResultDto.fromJson(Map<String, dynamic> json) {
    return CompatibilityResultDto(
      overallScore: (json['overallScore'] as num).toDouble(),
      emotionalScore: (json['emotionalScore'] as num).toDouble(),
      communicationScore: (json['communicationScore'] as num).toDouble(),
      passionScore: (json['passionScore'] as num).toDouble(),
      stabilityScore: (json['stabilityScore'] as num).toDouble(),
      growthScore: (json['growthScore'] as num).toDouble(),
      strengths: List<String>.from(json['strengths'] as List),
      challenges: List<String>.from(json['challenges'] as List),
      advice: List<String>.from(json['advice'] as List),
      interAspects:
          (json['interAspects'] as List?)
              ?.map((a) => InterAspectDto.fromJson(a))
              .toList() ??
          [],
      compositeHighlights: List<String>.from(
        json['compositeHighlights'] as List? ?? [],
      ),
    );
  }
}

class InterAspectDto {
  final String planet1;
  final String planet2;
  final String aspect;
  final double orb;
  final String nature;

  InterAspectDto({
    required this.planet1,
    required this.planet2,
    required this.aspect,
    required this.orb,
    required this.nature,
  });

  factory InterAspectDto.fromJson(Map<String, dynamic> json) {
    return InterAspectDto(
      planet1: json['planet1'] as String,
      planet2: json['planet2'] as String,
      aspect: json['aspect'] as String,
      orb: (json['orb'] as num).toDouble(),
      nature: json['nature'] as String? ?? 'neutral',
    );
  }
}

class SignCompatibilityDto {
  final double score;
  final String element1;
  final String element2;
  final String modality1;
  final String modality2;
  final String description;
  final List<String> strengths;
  final List<String> challenges;

  SignCompatibilityDto({
    required this.score,
    required this.element1,
    required this.element2,
    required this.modality1,
    required this.modality2,
    required this.description,
    required this.strengths,
    required this.challenges,
  });

  factory SignCompatibilityDto.fromJson(Map<String, dynamic> json) {
    return SignCompatibilityDto(
      score: (json['score'] as num).toDouble(),
      element1: json['element1'] as String,
      element2: json['element2'] as String,
      modality1: json['modality1'] as String,
      modality2: json['modality2'] as String,
      description: json['description'] as String,
      strengths: List<String>.from(json['strengths'] as List),
      challenges: List<String>.from(json['challenges'] as List),
    );
  }
}
