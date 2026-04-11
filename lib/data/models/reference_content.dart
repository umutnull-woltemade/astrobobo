import 'zodiac_sign.dart';

/// Astrology Glossary Entry with enhanced features
class GlossaryEntry {
  final String term;
  final String termTr;
  final String hint; // Kısa ipucu - kartın üstünde görünür
  final String definition; // Detaylı açıklama
  final String? deepExplanation; // Derin ezoterik açıklama
  final String? example;
  final GlossaryCategory category;
  final List<String> relatedTerms;
  final List<GlossaryReference> references; // Kaynak ve referanslar
  final String? planetInHouse; // Gezegen-Ev yorumu için
  final String? signRuler; // Burç yöneticisi bilgisi

  GlossaryEntry({
    required this.term,
    required this.termTr,
    required this.hint,
    required this.definition,
    this.deepExplanation,
    this.example,
    required this.category,
    this.relatedTerms = const [],
    this.references = const [],
    this.planetInHouse,
    this.signRuler,
  });

  Map<String, dynamic> toJson() => {
    'term': term,
    'termTr': termTr,
    'hint': hint,
    'definition': definition,
    'deepExplanation': deepExplanation,
    'example': example,
    'category': category.index,
    'relatedTerms': relatedTerms,
    'references': references.map((r) => r.toJson()).toList(),
    'planetInHouse': planetInHouse,
    'signRuler': signRuler,
  };

  factory GlossaryEntry.fromJson(Map<String, dynamic> json) => GlossaryEntry(
    term: json['term'] as String,
    termTr: json['termTr'] as String,
    hint: json['hint'] as String? ?? '',
    definition: json['definition'] as String,
    deepExplanation: json['deepExplanation'] as String?,
    example: json['example'] as String?,
    category: GlossaryCategory.values[json['category'] as int],
    relatedTerms: List<String>.from(json['relatedTerms'] as List? ?? []),
    references:
        (json['references'] as List?)
            ?.map((r) => GlossaryReference.fromJson(r as Map<String, dynamic>))
            .toList() ??
        [],
    planetInHouse: json['planetInHouse'] as String?,
    signRuler: json['signRuler'] as String?,
  );
}

/// Kaynak/Referans bilgisi
class GlossaryReference {
  final String title;
  final String author;
  final String? url;
  final String type; // 'book', 'article', 'tradition', 'website'

  GlossaryReference({
    required this.title,
    required this.author,
    this.url,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'url': url,
    'type': type,
  };

  factory GlossaryReference.fromJson(Map<String, dynamic> json) =>
      GlossaryReference(
        title: json['title'] as String,
        author: json['author'] as String,
        url: json['url'] as String?,
        type: json['type'] as String,
      );
}

enum GlossaryCategory {
  basics,
  planets,
  signs,
  houses,
  aspects,
  techniques,
  modern,
  esoteric, // Ezoterik ve spiritüel kavramlar
  psychological, // Psikolojik astroloji
  predictive, // Tahmin teknikleri
  relationships, // İlişki astrolojisi
}

extension GlossaryCategoryExtension on GlossaryCategory {
  String get nameTr {
    switch (this) {
      case GlossaryCategory.basics:
        return 'Temel Kavramlar';
      case GlossaryCategory.planets:
        return 'Gezegenler';
      case GlossaryCategory.signs:
        return 'Burçlar';
      case GlossaryCategory.houses:
        return 'Evler';
      case GlossaryCategory.aspects:
        return 'Açılar';
      case GlossaryCategory.techniques:
        return 'Teknikler';
      case GlossaryCategory.modern:
        return 'Modern Astroloji';
      case GlossaryCategory.esoteric:
        return 'Ezoterik';
      case GlossaryCategory.psychological:
        return 'Psikolojik';
      case GlossaryCategory.predictive:
        return 'Tahmin';
      case GlossaryCategory.relationships:
        return 'İlişkiler';
    }
  }

  String get icon {
    switch (this) {
      case GlossaryCategory.basics:
        return '📚';
      case GlossaryCategory.planets:
        return '🪐';
      case GlossaryCategory.signs:
        return '♈';
      case GlossaryCategory.houses:
        return '🏠';
      case GlossaryCategory.aspects:
        return '📐';
      case GlossaryCategory.techniques:
        return '🔮';
      case GlossaryCategory.modern:
        return '✨';
      case GlossaryCategory.esoteric:
        return '🌙';
      case GlossaryCategory.psychological:
        return '🧠';
      case GlossaryCategory.predictive:
        return '🔭';
      case GlossaryCategory.relationships:
        return '💕';
    }
  }
}

/// Gardening Moon Calendar
class GardeningMoonDay {
  final DateTime date;
  final MoonPhase phase;
  final ZodiacSign moonSign;
  final GardeningActivity bestActivity;
  final List<GardeningActivity> goodActivities;
  final List<GardeningActivity> avoidActivities;
  final String advice;
  final int fertilityRating; // 1-5

  GardeningMoonDay({
    required this.date,
    required this.phase,
    required this.moonSign,
    required this.bestActivity,
    required this.goodActivities,
    required this.avoidActivities,
    required this.advice,
    required this.fertilityRating,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'phase': phase.index,
    'moonSign': moonSign.index,
    'bestActivity': bestActivity.index,
    'goodActivities': goodActivities.map((a) => a.index).toList(),
    'avoidActivities': avoidActivities.map((a) => a.index).toList(),
    'advice': advice,
    'fertilityRating': fertilityRating,
  };

  factory GardeningMoonDay.fromJson(Map<String, dynamic> json) =>
      GardeningMoonDay(
        date: DateTime.parse(json['date'] as String),
        phase: MoonPhase.values[json['phase'] as int],
        moonSign: ZodiacSign.values[json['moonSign'] as int],
        bestActivity: GardeningActivity.values[json['bestActivity'] as int],
        goodActivities: (json['goodActivities'] as List)
            .map((a) => GardeningActivity.values[a as int])
            .toList(),
        avoidActivities: (json['avoidActivities'] as List)
            .map((a) => GardeningActivity.values[a as int])
            .toList(),
        advice: json['advice'] as String,
        fertilityRating: json['fertilityRating'] as int,
      );
}

enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

extension MoonPhaseExtension on MoonPhase {
  String get nameTr {
    switch (this) {
      case MoonPhase.newMoon:
        return 'Yeni Ay';
      case MoonPhase.waxingCrescent:
        return 'Hilal (Büyüyen)';
      case MoonPhase.firstQuarter:
        return 'İlk Dördün';
      case MoonPhase.waxingGibbous:
        return 'Şişkin Ay (Büyüyen)';
      case MoonPhase.fullMoon:
        return 'Dolunay';
      case MoonPhase.waningGibbous:
        return 'Şişkin Ay (Azalan)';
      case MoonPhase.lastQuarter:
        return 'Son Dördün';
      case MoonPhase.waningCrescent:
        return 'Hilal (Azalan)';
    }
  }

  String get icon {
    switch (this) {
      case MoonPhase.newMoon:
        return '🌑';
      case MoonPhase.waxingCrescent:
        return '🌒';
      case MoonPhase.firstQuarter:
        return '🌓';
      case MoonPhase.waxingGibbous:
        return '🌔';
      case MoonPhase.fullMoon:
        return '🌕';
      case MoonPhase.waningGibbous:
        return '🌖';
      case MoonPhase.lastQuarter:
        return '🌗';
      case MoonPhase.waningCrescent:
        return '🌘';
    }
  }

  bool get isWaxing {
    return this == MoonPhase.newMoon ||
        this == MoonPhase.waxingCrescent ||
        this == MoonPhase.firstQuarter ||
        this == MoonPhase.waxingGibbous;
  }
}

enum GardeningActivity {
  planting,
  transplanting,
  pruning,
  harvesting,
  fertilizing,
  weeding,
  watering,
  seedStarting,
  grafting,
  composting,
}

extension GardeningActivityExtension on GardeningActivity {
  String get nameTr {
    switch (this) {
      case GardeningActivity.planting:
        return 'Dikim';
      case GardeningActivity.transplanting:
        return 'Nakil';
      case GardeningActivity.pruning:
        return 'Budama';
      case GardeningActivity.harvesting:
        return 'Hasat';
      case GardeningActivity.fertilizing:
        return 'Gübreleme';
      case GardeningActivity.weeding:
        return 'Ot Temizliği';
      case GardeningActivity.watering:
        return 'Sulama';
      case GardeningActivity.seedStarting:
        return 'Tohum Ekimi';
      case GardeningActivity.grafting:
        return 'Aşılama';
      case GardeningActivity.composting:
        return 'Kompost';
    }
  }

  String get icon {
    switch (this) {
      case GardeningActivity.planting:
        return '🌱';
      case GardeningActivity.transplanting:
        return '🪴';
      case GardeningActivity.pruning:
        return '✂️';
      case GardeningActivity.harvesting:
        return '🧺';
      case GardeningActivity.fertilizing:
        return '💩';
      case GardeningActivity.weeding:
        return '🌿';
      case GardeningActivity.watering:
        return '💧';
      case GardeningActivity.seedStarting:
        return '🫘';
      case GardeningActivity.grafting:
        return '🔗';
      case GardeningActivity.composting:
        return '♻️';
    }
  }
}

/// Celebrity Chart
class CelebrityChart {
  final String name;
  final String profession;
  final DateTime birthDate;
  final String birthPlace;
  final ZodiacSign sunSign;
  final ZodiacSign moonSign;
  final ZodiacSign ascendant;
  final String imageUrl;
  final String chartAnalysis;
  final List<String> notableAspects;
  final CelebrityCategory category;

  CelebrityChart({
    required this.name,
    required this.profession,
    required this.birthDate,
    required this.birthPlace,
    required this.sunSign,
    required this.moonSign,
    required this.ascendant,
    required this.imageUrl,
    required this.chartAnalysis,
    required this.notableAspects,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'profession': profession,
    'birthDate': birthDate.toIso8601String(),
    'birthPlace': birthPlace,
    'sunSign': sunSign.index,
    'moonSign': moonSign.index,
    'ascendant': ascendant.index,
    'imageUrl': imageUrl,
    'chartAnalysis': chartAnalysis,
    'notableAspects': notableAspects,
    'category': category.index,
  };

  factory CelebrityChart.fromJson(Map<String, dynamic> json) => CelebrityChart(
    name: json['name'] as String,
    profession: json['profession'] as String,
    birthDate: DateTime.parse(json['birthDate'] as String),
    birthPlace: json['birthPlace'] as String,
    sunSign: ZodiacSign.values[json['sunSign'] as int],
    moonSign: ZodiacSign.values[json['moonSign'] as int],
    ascendant: ZodiacSign.values[json['ascendant'] as int],
    imageUrl: json['imageUrl'] as String,
    chartAnalysis: json['chartAnalysis'] as String,
    notableAspects: List<String>.from(json['notableAspects'] as List),
    category: CelebrityCategory.values[json['category'] as int],
  );
}

enum CelebrityCategory {
  actors,
  musicians,
  politicians,
  athletes,
  artists,
  scientists,
  writers,
  historical,
}

extension CelebrityCategoryExtension on CelebrityCategory {
  String get nameTr {
    switch (this) {
      case CelebrityCategory.actors:
        return 'Oyuncular';
      case CelebrityCategory.musicians:
        return 'Müzisyenler';
      case CelebrityCategory.politicians:
        return 'Politikacılar';
      case CelebrityCategory.athletes:
        return 'Sporcular';
      case CelebrityCategory.artists:
        return 'Sanatçılar';
      case CelebrityCategory.scientists:
        return 'Bilim İnsanları';
      case CelebrityCategory.writers:
        return 'Yazarlar';
      case CelebrityCategory.historical:
        return 'Tarihi Figürler';
    }
  }

  String get icon {
    switch (this) {
      case CelebrityCategory.actors:
        return '🎬';
      case CelebrityCategory.musicians:
        return '🎵';
      case CelebrityCategory.politicians:
        return '🏛️';
      case CelebrityCategory.athletes:
        return '⚽';
      case CelebrityCategory.artists:
        return '🎨';
      case CelebrityCategory.scientists:
        return '🔬';
      case CelebrityCategory.writers:
        return '✍️';
      case CelebrityCategory.historical:
        return '📜';
    }
  }
}

/// Article/Guide
class AstrologyArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final ArticleCategory category;
  final DateTime publishedAt;
  final String author;
  final int readTimeMinutes;
  final List<String> tags;
  final bool isPremium;

  AstrologyArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.publishedAt,
    required this.author,
    required this.readTimeMinutes,
    required this.tags,
    this.isPremium = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'content': content,
    'category': category.index,
    'publishedAt': publishedAt.toIso8601String(),
    'author': author,
    'readTimeMinutes': readTimeMinutes,
    'tags': tags,
    'isPremium': isPremium,
  };

  factory AstrologyArticle.fromJson(Map<String, dynamic> json) =>
      AstrologyArticle(
        id: json['id'] as String,
        title: json['title'] as String,
        summary: json['summary'] as String,
        content: json['content'] as String,
        category: ArticleCategory.values[json['category'] as int],
        publishedAt: DateTime.parse(json['publishedAt'] as String),
        author: json['author'] as String,
        readTimeMinutes: json['readTimeMinutes'] as int,
        tags: List<String>.from(json['tags'] as List),
        isPremium: json['isPremium'] as bool? ?? false,
      );
}

enum ArticleCategory {
  beginners,
  intermediate,
  advanced,
  relationships,
  career,
  spirituality,
  currentTransits,
  techniques,
}

extension ArticleCategoryExtension on ArticleCategory {
  String get nameTr {
    switch (this) {
      case ArticleCategory.beginners:
        return 'Başlangıç';
      case ArticleCategory.intermediate:
        return 'Orta Seviye';
      case ArticleCategory.advanced:
        return 'İleri Seviye';
      case ArticleCategory.relationships:
        return 'İlişkiler';
      case ArticleCategory.career:
        return 'Kariyer';
      case ArticleCategory.spirituality:
        return 'Spiritüellik';
      case ArticleCategory.currentTransits:
        return 'Güncel Transitler';
      case ArticleCategory.techniques:
        return 'Teknikler';
    }
  }

  String get icon {
    switch (this) {
      case ArticleCategory.beginners:
        return '🌱';
      case ArticleCategory.intermediate:
        return '📖';
      case ArticleCategory.advanced:
        return '🎓';
      case ArticleCategory.relationships:
        return '💕';
      case ArticleCategory.career:
        return '💼';
      case ArticleCategory.spirituality:
        return '🧘';
      case ArticleCategory.currentTransits:
        return '🌍';
      case ArticleCategory.techniques:
        return '⚙️';
    }
  }
}
