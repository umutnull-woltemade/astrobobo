// Experiment configuration models for A/B testing
// Used for paywall timing and pricing experiments

/// Paywall timing experiment variants
enum PaywallTimingVariant {
  /// Show immediately after onboarding
  immediate('A', 'Immediate'),

  /// Show after first insight/horoscope (DEFAULT)
  firstInsight('B', 'First Insight'),

  /// Show on 2nd session or after 24 hours
  delayed('C', 'Delayed');

  const PaywallTimingVariant(this.code, this.name);
  final String code;
  final String name;

  static PaywallTimingVariant fromCode(String code) {
    return PaywallTimingVariant.values.firstWhere(
      (v) => v.code == code,
      orElse: () => PaywallTimingVariant.firstInsight,
    );
  }
}

/// Pricing experiment variants
enum PricingVariant {
  /// $7.99/month (50% traffic)
  priceA('A', 7.99, 'monthly_799'),

  /// $9.99/month (30% traffic)
  priceB('B', 9.99, 'monthly_999'),

  /// $11.99/month (20% traffic)
  priceC('C', 11.99, 'monthly_1199');

  const PricingVariant(this.code, this.price, this.productId);
  final String code;
  final double price;
  final String productId;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}/month';

  static PricingVariant fromCode(String code) {
    return PricingVariant.values.firstWhere(
      (v) => v.code == code,
      orElse: () => PricingVariant.priceA,
    );
  }
}

/// Churn alert levels
enum ChurnLevel {
  /// Normal churn rate (< 7%)
  normal(0.0, 0.07),

  /// Warning level (7% - 10%)
  warning(0.07, 0.10),

  /// Critical level (> 10%)
  critical(0.10, 1.0);

  const ChurnLevel(this.minThreshold, this.maxThreshold);
  final double minThreshold;
  final double maxThreshold;

  static ChurnLevel fromRate(double rate) {
    if (rate >= 0.10) return ChurnLevel.critical;
    if (rate >= 0.07) return ChurnLevel.warning;
    return ChurnLevel.normal;
  }
}

/// User experiment assignment
class ExperimentAssignment {
  final PaywallTimingVariant timingVariant;
  final PricingVariant pricingVariant;
  final DateTime assignedAt;
  final int sessionCount;
  final bool hasSeenFirstInsight;
  final DateTime? lastPaywallShown;
  final bool hasConverted;

  const ExperimentAssignment({
    required this.timingVariant,
    required this.pricingVariant,
    required this.assignedAt,
    this.sessionCount = 0,
    this.hasSeenFirstInsight = false,
    this.lastPaywallShown,
    this.hasConverted = false,
  });

  ExperimentAssignment copyWith({
    PaywallTimingVariant? timingVariant,
    PricingVariant? pricingVariant,
    DateTime? assignedAt,
    int? sessionCount,
    bool? hasSeenFirstInsight,
    DateTime? lastPaywallShown,
    bool? hasConverted,
  }) {
    return ExperimentAssignment(
      timingVariant: timingVariant ?? this.timingVariant,
      pricingVariant: pricingVariant ?? this.pricingVariant,
      assignedAt: assignedAt ?? this.assignedAt,
      sessionCount: sessionCount ?? this.sessionCount,
      hasSeenFirstInsight: hasSeenFirstInsight ?? this.hasSeenFirstInsight,
      lastPaywallShown: lastPaywallShown ?? this.lastPaywallShown,
      hasConverted: hasConverted ?? this.hasConverted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timingVariant': timingVariant.code,
      'pricingVariant': pricingVariant.code,
      'assignedAt': assignedAt.toIso8601String(),
      'sessionCount': sessionCount,
      'hasSeenFirstInsight': hasSeenFirstInsight,
      'lastPaywallShown': lastPaywallShown?.toIso8601String(),
      'hasConverted': hasConverted,
    };
  }

  factory ExperimentAssignment.fromJson(Map<String, dynamic> json) {
    return ExperimentAssignment(
      timingVariant: PaywallTimingVariant.fromCode(
        json['timingVariant'] ?? 'B',
      ),
      pricingVariant: PricingVariant.fromCode(json['pricingVariant'] ?? 'A'),
      assignedAt: DateTime.parse(
        json['assignedAt'] ?? DateTime.now().toIso8601String(),
      ),
      sessionCount: json['sessionCount'] ?? 0,
      hasSeenFirstInsight: json['hasSeenFirstInsight'] ?? false,
      lastPaywallShown: json['lastPaywallShown'] != null
          ? DateTime.parse(json['lastPaywallShown'])
          : null,
      hasConverted: json['hasConverted'] ?? false,
    );
  }

  /// Check if paywall should be shown based on timing variant
  bool shouldShowPaywall() {
    if (hasConverted) return false;

    switch (timingVariant) {
      case PaywallTimingVariant.immediate:
        return true;
      case PaywallTimingVariant.firstInsight:
        return hasSeenFirstInsight;
      case PaywallTimingVariant.delayed:
        final hoursSinceAssigned = DateTime.now()
            .difference(assignedAt)
            .inHours;
        return sessionCount >= 2 || hoursSinceAssigned >= 24;
    }
  }

  /// Check if enough time has passed since last paywall (48h cooldown during churn defense)
  bool canShowPaywallWithCooldown({
    Duration cooldown = const Duration(hours: 48),
  }) {
    if (lastPaywallShown == null) return true;
    return DateTime.now().difference(lastPaywallShown!) >= cooldown;
  }
}

/// Churn defense state
class ChurnDefenseState {
  final ChurnLevel level;
  final double currentChurnRate;
  final bool isPricingFrozen;
  final bool isTimingFrozen;
  final bool isHighPriceDisabled;
  final DateTime? lastChurnCheck;
  final DateTime? defenseActivatedAt;

  const ChurnDefenseState({
    this.level = ChurnLevel.normal,
    this.currentChurnRate = 0.0,
    this.isPricingFrozen = false,
    this.isTimingFrozen = false,
    this.isHighPriceDisabled = false,
    this.lastChurnCheck,
    this.defenseActivatedAt,
  });

  bool get isDefenseActive => level != ChurnLevel.normal;

  ChurnDefenseState copyWith({
    ChurnLevel? level,
    double? currentChurnRate,
    bool? isPricingFrozen,
    bool? isTimingFrozen,
    bool? isHighPriceDisabled,
    DateTime? lastChurnCheck,
    DateTime? defenseActivatedAt,
  }) {
    return ChurnDefenseState(
      level: level ?? this.level,
      currentChurnRate: currentChurnRate ?? this.currentChurnRate,
      isPricingFrozen: isPricingFrozen ?? this.isPricingFrozen,
      isTimingFrozen: isTimingFrozen ?? this.isTimingFrozen,
      isHighPriceDisabled: isHighPriceDisabled ?? this.isHighPriceDisabled,
      lastChurnCheck: lastChurnCheck ?? this.lastChurnCheck,
      defenseActivatedAt: defenseActivatedAt ?? this.defenseActivatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'currentChurnRate': currentChurnRate,
      'isPricingFrozen': isPricingFrozen,
      'isTimingFrozen': isTimingFrozen,
      'isHighPriceDisabled': isHighPriceDisabled,
      'lastChurnCheck': lastChurnCheck?.toIso8601String(),
      'defenseActivatedAt': defenseActivatedAt?.toIso8601String(),
    };
  }

  factory ChurnDefenseState.fromJson(Map<String, dynamic> json) {
    return ChurnDefenseState(
      level: ChurnLevel.values.firstWhere(
        (l) => l.name == json['level'],
        orElse: () => ChurnLevel.normal,
      ),
      currentChurnRate: (json['currentChurnRate'] ?? 0.0).toDouble(),
      isPricingFrozen: json['isPricingFrozen'] ?? false,
      isTimingFrozen: json['isTimingFrozen'] ?? false,
      isHighPriceDisabled: json['isHighPriceDisabled'] ?? false,
      lastChurnCheck: json['lastChurnCheck'] != null
          ? DateTime.parse(json['lastChurnCheck'])
          : null,
      defenseActivatedAt: json['defenseActivatedAt'] != null
          ? DateTime.parse(json['defenseActivatedAt'])
          : null,
    );
  }
}

/// Churn analysis for post-incident review
class ChurnAnalysis {
  final Map<String, double> priceVariantBreakdown;
  final Map<String, double> timingVariantBreakdown;
  final Map<String, double> countryBreakdown;
  final Map<String, double> acquisitionSourceBreakdown;
  final String? rootCause;
  final String? recommendedAction;
  final DateTime analyzedAt;

  const ChurnAnalysis({
    required this.priceVariantBreakdown,
    required this.timingVariantBreakdown,
    required this.countryBreakdown,
    required this.acquisitionSourceBreakdown,
    this.rootCause,
    this.recommendedAction,
    required this.analyzedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'priceVariantBreakdown': priceVariantBreakdown,
      'timingVariantBreakdown': timingVariantBreakdown,
      'countryBreakdown': countryBreakdown,
      'acquisitionSourceBreakdown': acquisitionSourceBreakdown,
      'rootCause': rootCause,
      'recommendedAction': recommendedAction,
      'analyzedAt': analyzedAt.toIso8601String(),
    };
  }
}

/// Monetization metrics for dashboard
class MonetizationMetrics {
  final double mrr;
  final double arr;
  final double arpu;
  final double ltv;
  final double grossRevenue;
  final double netRevenue;
  final double conversionRate;
  final double monthlyChurn;
  final double renewalRate;
  final double refundRate;
  final int paywallViews;
  final double paywallConversion;
  final double dismissRate;
  final double adImpressions;
  final double adRevenue;
  final double adEcpm;
  final double adFillRate;
  final DateTime updatedAt;

  const MonetizationMetrics({
    this.mrr = 0.0,
    this.arr = 0.0,
    this.arpu = 0.0,
    this.ltv = 0.0,
    this.grossRevenue = 0.0,
    this.netRevenue = 0.0,
    this.conversionRate = 0.0,
    this.monthlyChurn = 0.0,
    this.renewalRate = 0.0,
    this.refundRate = 0.0,
    this.paywallViews = 0,
    this.paywallConversion = 0.0,
    this.dismissRate = 0.0,
    this.adImpressions = 0.0,
    this.adRevenue = 0.0,
    this.adEcpm = 0.0,
    this.adFillRate = 0.0,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'mrr': mrr,
      'arr': arr,
      'arpu': arpu,
      'ltv': ltv,
      'grossRevenue': grossRevenue,
      'netRevenue': netRevenue,
      'conversionRate': conversionRate,
      'monthlyChurn': monthlyChurn,
      'renewalRate': renewalRate,
      'refundRate': refundRate,
      'paywallViews': paywallViews,
      'paywallConversion': paywallConversion,
      'dismissRate': dismissRate,
      'adImpressions': adImpressions,
      'adRevenue': adRevenue,
      'adEcpm': adEcpm,
      'adFillRate': adFillRate,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
