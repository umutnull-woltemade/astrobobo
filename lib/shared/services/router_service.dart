import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/routes.dart';
import '../../data/providers/app_providers.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/home/presentation/responsive_home_screen.dart';
import '../../features/horoscope/presentation/horoscope_screen.dart';
import '../../features/horoscope/presentation/horoscope_detail_screen.dart';
import '../../features/compatibility/presentation/compatibility_screen.dart';
import '../../features/natal_chart/presentation/natal_chart_screen.dart';
import '../../features/numerology/presentation/numerology_screen.dart';
import '../../features/kabbalah/presentation/kabbalah_screen.dart';
import '../../features/tarot/presentation/tarot_screen.dart';
import '../../features/aura/presentation/aura_screen.dart';
import '../../features/transits/presentation/transits_screen.dart';
import '../../features/premium/presentation/premium_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/share/presentation/cosmic_share_screen.dart';
import '../../features/share/presentation/screenshot_share_screen.dart';
import '../../features/horoscopes/presentation/weekly_horoscope_screen.dart';
import '../../features/horoscopes/presentation/monthly_horoscope_screen.dart';
import '../../features/horoscopes/presentation/yearly_horoscope_screen.dart';
import '../../features/horoscopes/presentation/love_horoscope_screen.dart';
import '../../features/horoscopes/presentation/eclipse_calendar_screen.dart';
import '../../features/compatibility/presentation/composite_chart_screen.dart';
import '../../features/vedic/presentation/vedic_chart_screen.dart';
import '../../features/predictive/presentation/progressions_screen.dart';
import '../../features/astrocartography/presentation/astrocartography_screen.dart';
import '../../features/electional/presentation/electional_screen.dart';
import '../../features/draconic/presentation/draconic_chart_screen.dart';
import '../../features/asteroids/presentation/asteroids_screen.dart';
import '../../features/glossary/presentation/glossary_screen.dart';
import '../../features/gardening/presentation/gardening_moon_screen.dart';
import '../../features/celebrities/presentation/celebrities_screen.dart';
import '../../features/articles/presentation/articles_screen.dart';
import '../../features/local_space/presentation/local_space_screen.dart';
import '../../features/saturn_return/presentation/saturn_return_screen.dart';
import '../../features/solar_return/presentation/solar_return_screen.dart';
import '../../features/year_ahead/presentation/year_ahead_screen.dart';
import '../../features/timing/presentation/timing_screen.dart';
import '../../features/timing/presentation/void_of_course_screen.dart';
import '../../features/synastry/presentation/synastry_screen.dart';
import '../../features/transits/presentation/transit_calendar_screen.dart';
import '../../features/rituals/presentation/daily_rituals_screen.dart';
import '../../features/chakra/presentation/chakra_analysis_screen.dart';
import '../../features/profile/presentation/saved_profiles_screen.dart';
import '../../features/profile/presentation/comparison_screen.dart';
import '../../features/kozmoz/presentation/kozmoz_screen.dart';
import '../../features/cosmic_discovery/presentation/cosmic_discovery_screen.dart';
import '../../features/dreams/presentation/dream_interpretation_screen.dart';
import '../../features/dreams/presentation/dream_oracle_screen.dart';
import '../../features/dreams/presentation/dream_glossary_screen.dart';
import '../../features/dreams/presentation/dream_share_screen.dart';
import '../../features/dreams/presentation/canonical/dream_falling_screen.dart';
import '../../features/dreams/presentation/canonical/dream_water_screen.dart';
import '../../features/dreams/presentation/canonical/dream_recurring_screen.dart';
import '../../features/dreams/presentation/canonical/dream_running_screen.dart';
import '../../features/dreams/presentation/canonical/dream_flying_screen.dart';
import '../../features/dreams/presentation/canonical/dream_losing_screen.dart';
import '../../features/dreams/presentation/canonical/dream_darkness_screen.dart';
import '../../features/dreams/presentation/canonical/dream_past_screen.dart';
import '../../features/dreams/presentation/canonical/dream_searching_screen.dart';
import '../../features/dreams/presentation/canonical/dream_voiceless_screen.dart';
import '../../features/dreams/presentation/canonical/dream_lost_screen.dart';
import '../../features/dreams/presentation/canonical/dream_unable_to_fly_screen.dart';
import '../../features/tantra/presentation/tantra_screen.dart';
import '../../features/theta_healing/presentation/theta_healing_screen.dart';
import '../../features/reiki/presentation/reiki_screen.dart';
import '../../features/kozmik/presentation/canonical/cosmic_today_screen.dart';
import '../../features/tantra/presentation/canonical/tantra_micro_ritual_screen.dart';
import '../../features/tarot/presentation/major_arcana_detail_screen.dart';
import '../../features/numerology/presentation/life_path_detail_screen.dart';
import '../../features/numerology/presentation/master_number_screen.dart';
import '../../features/numerology/presentation/personal_year_screen.dart';
import '../../features/numerology/presentation/karmic_debt_screen.dart';
import '../../features/all_services/presentation/all_services_screen.dart';
import '../../features/admin/presentation/admin_login_screen.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/quiz/presentation/quiz_screen.dart';
import '../../data/services/admin_auth_service.dart';
import '../../data/services/storage_service.dart';
import '../../core/design_system/inner_cycles_bottom_nav.dart';
import '../../core/design_system/icon_showcase.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    errorBuilder: (context, state) => _NotFoundScreen(path: state.uri.path),
    redirect: (context, state) {
      final path = state.uri.path;

      // Allow splash and onboarding without guard
      if (path == Routes.splash || path == Routes.onboarding) {
        return null;
      }

      // Allow admin routes without onboarding
      if (path.startsWith('/admin')) {
        return null;
      }

      // Guard: redirect to onboarding if not completed
      final onboardingDone = StorageService.loadOnboardingComplete();
      if (!onboardingDone) {
        return Routes.onboarding;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // MAIN SHELL — Persistent floating bottom navigation
      // 5 primary tabs: Home, Keşfet, Kozmoz, İçgörü, Profil
      // ════════════════════════════════════════════════════════════════
      ShellRoute(
        builder: (context, state, child) {
          return InnerCyclesAppShell(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const ResponsiveHomeScreen(),
          ),
          GoRoute(
            path: Routes.allServices,
            builder: (context, state) => const AllServicesScreen(),
          ),
          GoRoute(
            path: Routes.kozmoz,
            builder: (context, state) => const KozmozScreen(),
          ),
          GoRoute(
            path: Routes.horoscope,
            builder: (context, state) => const HoroscopeScreen(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Dev: Icon system showcase
      GoRoute(
        path: '/dev/icons',
        builder: (context, state) => const IconShowcase(),
      ),
      GoRoute(
        path: Routes.horoscopeDetail,
        builder: (context, state) {
          final sign = state.pathParameters['sign'] ?? 'aries';
          return HoroscopeDetailScreen(signName: sign);
        },
      ),
      GoRoute(
        path: Routes.compatibility,
        builder: (context, state) => const CompatibilityScreen(),
      ),
      GoRoute(
        path: Routes.birthChart,
        builder: (context, state) => const NatalChartScreen(),
      ),
      GoRoute(
        path: Routes.numerology,
        builder: (context, state) => const NumerologyScreen(),
      ),
      // Numerology - Life Path Detail (1-9)
      GoRoute(
        path: Routes.lifePathDetail,
        builder: (context, state) {
          final number =
              int.tryParse(state.pathParameters['number'] ?? '1') ?? 1;
          return LifePathDetailScreen(number: number);
        },
      ),
      // Numerology - Master Numbers (11, 22, 33)
      GoRoute(
        path: Routes.masterNumber,
        builder: (context, state) {
          final number =
              int.tryParse(state.pathParameters['number'] ?? '11') ?? 11;
          return MasterNumberScreen(number: number);
        },
      ),
      // Numerology - Personal Year (1-9)
      GoRoute(
        path: Routes.personalYearDetail,
        builder: (context, state) {
          final number =
              int.tryParse(state.pathParameters['number'] ?? '1') ?? 1;
          return PersonalYearScreen(year: number);
        },
      ),
      // Numerology - Karmic Debt (13, 14, 16, 19)
      GoRoute(
        path: '/numerology/karmic-debt/:number',
        builder: (context, state) {
          final number =
              int.tryParse(state.pathParameters['number'] ?? '13') ?? 13;
          return KarmicDebtScreen(debtNumber: number);
        },
      ),
      GoRoute(
        path: Routes.kabbalah,
        builder: (context, state) => const KabbalahScreen(),
      ),
      GoRoute(
        path: Routes.tarot,
        builder: (context, state) => const TarotScreen(),
      ),
      // Tarot - Major Arcana Detail (22 cards)
      GoRoute(
        path: '/tarot/major/:number',
        builder: (context, state) {
          final number =
              int.tryParse(state.pathParameters['number'] ?? '0') ?? 0;
          return MajorArcanaDetailScreen(cardNumber: number);
        },
      ),
      GoRoute(
        path: Routes.aura,
        builder: (context, state) => const AuraScreen(),
      ),
      GoRoute(
        path: Routes.transits,
        builder: (context, state) => const TransitsScreen(),
      ),
      GoRoute(
        path: Routes.premium,
        builder: (context, state) => const PremiumScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      // Routes.profile is now inside the ShellRoute (bottom nav tab)
      GoRoute(
        path: Routes.shareSummary,
        // SIMPLIFIED SHARE SCREEN: Tek fullscreen görsel, screenshot-ready
        // Instagram'a yönlendirme YOK, kullanıcı ekran görüntüsü alacak
        builder: (context, state) => const ScreenshotShareScreen(),
      ),
      GoRoute(
        path: Routes.cosmicShare,
        builder: (context, state) => const CosmicShareScreen(),
      ),
      // Extended Horoscopes
      GoRoute(
        path: Routes.weeklyHoroscope,
        builder: (context, state) => const WeeklyHoroscopeScreen(),
      ),
      GoRoute(
        path: Routes.weeklyHoroscopeDetail,
        builder: (context, state) {
          final sign = state.pathParameters['sign'] ?? 'aries';
          return WeeklyHoroscopeScreen(signName: sign);
        },
      ),
      GoRoute(
        path: Routes.monthlyHoroscope,
        builder: (context, state) => const MonthlyHoroscopeScreen(),
      ),
      GoRoute(
        path: Routes.monthlyHoroscopeDetail,
        builder: (context, state) {
          final sign = state.pathParameters['sign'] ?? 'aries';
          return MonthlyHoroscopeScreen(signName: sign);
        },
      ),
      GoRoute(
        path: Routes.yearlyHoroscope,
        builder: (context, state) => const YearlyHoroscopeScreen(),
      ),
      GoRoute(
        path: Routes.yearlyHoroscopeDetail,
        builder: (context, state) {
          final sign = state.pathParameters['sign'] ?? 'aries';
          return YearlyHoroscopeScreen(signName: sign);
        },
      ),
      GoRoute(
        path: Routes.loveHoroscope,
        builder: (context, state) => const LoveHoroscopeScreen(),
      ),
      GoRoute(
        path: Routes.loveHoroscopeDetail,
        builder: (context, state) {
          final sign = state.pathParameters['sign'] ?? 'aries';
          return LoveHoroscopeScreen(signName: sign);
        },
      ),
      GoRoute(
        path: Routes.eclipseCalendar,
        builder: (context, state) => const EclipseCalendarScreen(),
      ),
      // Advanced Astrology
      GoRoute(
        path: Routes.compositeChart,
        builder: (context, state) => const CompositeChartScreen(),
      ),
      GoRoute(
        path: Routes.vedicChart,
        builder: (context, state) => const VedicChartScreen(),
      ),
      GoRoute(
        path: Routes.progressions,
        builder: (context, state) => const ProgressionsScreen(),
      ),
      GoRoute(
        path: Routes.saturnReturn,
        builder: (context, state) => const SaturnReturnScreen(),
      ),
      GoRoute(
        path: Routes.solarReturn,
        builder: (context, state) => const SolarReturnScreen(),
      ),
      GoRoute(
        path: Routes.yearAhead,
        builder: (context, state) => const YearAheadScreen(),
      ),
      GoRoute(
        path: Routes.timing,
        builder: (context, state) => const TimingScreen(),
      ),
      GoRoute(
        path: Routes.voidOfCourse,
        builder: (context, state) => const VoidOfCourseScreen(),
      ),
      GoRoute(
        path: Routes.synastry,
        builder: (context, state) => const SynastryScreen(),
      ),
      // Premium Features
      GoRoute(
        path: Routes.astroCartography,
        builder: (context, state) => const AstroCartographyScreen(),
      ),
      GoRoute(
        path: Routes.electional,
        builder: (context, state) => const ElectionalScreen(),
      ),
      GoRoute(
        path: Routes.draconicChart,
        builder: (context, state) => const DraconicChartScreen(),
      ),
      GoRoute(
        path: Routes.asteroids,
        builder: (context, state) => const AsteroidsScreen(),
      ),
      GoRoute(
        path: Routes.localSpace,
        builder: (context, state) => const LocalSpaceScreen(),
      ),
      // Reference & Content
      GoRoute(
        path: Routes.glossary,
        builder: (context, state) {
          final searchQuery = state.uri.queryParameters['search'];
          return GlossaryScreen(initialSearch: searchQuery);
        },
      ),
      GoRoute(
        path: Routes.gardeningMoon,
        builder: (context, state) => const GardeningMoonScreen(),
      ),
      GoRoute(
        path: Routes.celebrities,
        builder: (context, state) => const CelebritiesScreen(),
      ),
      GoRoute(
        path: Routes.articles,
        builder: (context, state) => const ArticlesScreen(),
      ),
      // New Features
      GoRoute(
        path: Routes.transitCalendar,
        builder: (context, state) => const TransitCalendarScreen(),
      ),
      // Spiritual & Wellness
      GoRoute(
        path: Routes.dailyRituals,
        builder: (context, state) => const DailyRitualsScreen(),
      ),
      GoRoute(
        path: Routes.chakraAnalysis,
        builder: (context, state) => const ChakraAnalysisScreen(),
      ),
      GoRoute(
        path: Routes.crystalGuide,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Kristal Rehberi',
          subtitle: 'Şifalı taşların enerjisi',
          emoji: '💎',
          primaryColor: Color(0xFF9D4EDD),
          type: CosmicDiscoveryType.auraColor,
        ),
      ),
      GoRoute(
        path: Routes.moonRituals,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ay Ritüelleri',
          subtitle: 'Ayın döngüsüyle uyum',
          emoji: '🌕',
          primaryColor: Color(0xFFC0C0C0),
          type: CosmicDiscoveryType.moonEnergy,
        ),
      ),
      GoRoute(
        path: Routes.dreamInterpretation,
        builder: (context, state) => const DreamInterpretationScreen(),
      ),
      GoRoute(
        path: Routes.dreamGlossary,
        builder: (context, state) => const DreamGlossaryScreen(),
      ),
      GoRoute(
        path: Routes.dreamShare,
        builder: (context, state) => const DreamShareScreen(),
      ),
      // ════════════════════════════════════════════════════════════════
      // RÜYA İZİ - AI-First Canonical Sayfalar
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.dreamFalling,
        builder: (context, state) => const DreamFallingScreen(),
      ),
      GoRoute(
        path: Routes.dreamWater,
        builder: (context, state) => const DreamWaterScreen(),
      ),
      GoRoute(
        path: Routes.dreamRecurring,
        builder: (context, state) => const DreamRecurringScreen(),
      ),
      GoRoute(
        path: Routes.dreamRunning,
        builder: (context, state) => const DreamRunningScreen(),
      ),
      GoRoute(
        path: Routes.dreamFlying,
        builder: (context, state) => const DreamFlyingScreen(),
      ),
      GoRoute(
        path: Routes.dreamLosing,
        builder: (context, state) => const DreamLosingScreen(),
      ),
      GoRoute(
        path: Routes.dreamDarkness,
        builder: (context, state) => const DreamDarknessScreen(),
      ),
      GoRoute(
        path: Routes.dreamPast,
        builder: (context, state) => const DreamPastScreen(),
      ),
      GoRoute(
        path: Routes.dreamSearching,
        builder: (context, state) => const DreamSearchingScreen(),
      ),
      GoRoute(
        path: Routes.dreamVoiceless,
        builder: (context, state) => const DreamVoicelessScreen(),
      ),
      GoRoute(
        path: Routes.dreamLost,
        builder: (context, state) => const DreamLostScreen(),
      ),
      GoRoute(
        path: Routes.dreamUnableToFly,
        builder: (context, state) => const DreamUnableToFlyScreen(),
      ),
      // Tantra - Mindfulness & Connection
      GoRoute(
        path: Routes.tantra,
        builder: (context, state) => const TantraScreen(),
      ),
      // Theta Healing - Bilinçaltı Dönüşüm
      GoRoute(
        path: Routes.thetaHealing,
        builder: (context, state) => const ThetaHealingScreen(),
      ),
      // Reiki - Evrensel Yaşam Enerjisi
      GoRoute(
        path: Routes.reiki,
        builder: (context, state) => const ReikiScreen(),
      ),
      // Tantra Mikro Ritüel - AI-First Canonical
      GoRoute(
        path: Routes.tantraMicroRitual,
        builder: (context, state) => const TantraMicroRitualScreen(),
      ),
      // Kozmik Iletisim - Chatbot formatinda ruya yorumlama
      GoRoute(
        path: Routes.kozmikIletisim,
        builder: (context, state) => const DreamInterpretationScreen(),
      ),
      // Ruya Dongusu - 7 Boyutlu form bazli ruya yorumlama
      GoRoute(
        path: Routes.ruyaDongusu,
        builder: (context, state) => const DreamOracleScreen(),
      ),
      // ════════════════════════════════════════════════════════════════
      // KOZMİK - Günlük Tema (AI-First Canonical)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.cosmicToday,
        builder: (context, state) => const CosmicTodayScreen(),
      ),
      // Profile Management
      GoRoute(
        path: Routes.savedProfiles,
        builder: (context, state) => const SavedProfilesScreen(),
      ),
      GoRoute(
        path: Routes.comparison,
        builder: (context, state) => const ComparisonScreen(),
      ),
      // Routes.kozmoz and Routes.allServices are now inside the ShellRoute

      // ════════════════════════════════════════════════════════════════
      // KOZMİK KEŞİF - Viral & Felsefi İçerikler (Özel Ekranlar)
      // ════════════════════════════════════════════════════════════════

      // Günlük Enerjiler
      GoRoute(
        path: Routes.dailySummary,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Bugünün Özeti',
          subtitle: 'Kozmik enerjilerin günlük rehberin',
          emoji: '☀️',
          primaryColor: Color(0xFFFFD700),
          type: CosmicDiscoveryType.dailySummary,
        ),
      ),
      GoRoute(
        path: Routes.moonEnergy,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ay Enerjisi',
          subtitle: 'Ayın bugünkü mesajı',
          emoji: '🌙',
          primaryColor: Color(0xFFC0C0C0),
          type: CosmicDiscoveryType.moonEnergy,
        ),
      ),
      GoRoute(
        path: Routes.loveEnergy,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Aşk Enerjisi',
          subtitle: 'Kalbinin kozmik rehberi',
          emoji: '💕',
          primaryColor: Color(0xFFFF6B9D),
          type: CosmicDiscoveryType.loveEnergy,
        ),
      ),
      GoRoute(
        path: Routes.abundanceEnergy,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Bolluk Enerjisi',
          subtitle: 'Bereketin kaynağını keşfet',
          emoji: '💰',
          primaryColor: Color(0xFF50C878),
          type: CosmicDiscoveryType.abundanceEnergy,
        ),
      ),

      // Ruhsal Dönüşüm & Hayat Amacı
      GoRoute(
        path: Routes.spiritualTransformation,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ruhsal Dönüşüm',
          subtitle: 'İçsel yolculuğunun haritası',
          emoji: '🦋',
          primaryColor: Color(0xFF9D4EDD),
          type: CosmicDiscoveryType.spiritualTransformation,
        ),
      ),
      GoRoute(
        path: Routes.lifePurpose,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Hayat Amacın',
          subtitle: 'Neden burada olduğunu keşfet',
          emoji: '🎯',
          primaryColor: Color(0xFFE91E63),
          type: CosmicDiscoveryType.lifePurpose,
        ),
      ),
      GoRoute(
        path: Routes.subconsciousPatterns,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Bilinçaltı Kalıpların',
          subtitle: 'Gizli programlarını çöz',
          emoji: '🧠',
          primaryColor: Color(0xFF00BCD4),
          type: CosmicDiscoveryType.subconsciousPatterns,
        ),
      ),
      GoRoute(
        path: Routes.karmaLessons,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Karma Derslerin',
          subtitle: 'Ruhunun öğrenmesi gerekenler',
          emoji: '⚖️',
          primaryColor: Color(0xFFFF9800),
          type: CosmicDiscoveryType.karmaLessons,
        ),
      ),
      GoRoute(
        path: Routes.soulContract,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ruh Sözleşmen',
          subtitle: 'Doğmadan önce yaptığın anlaşma',
          emoji: '📜',
          primaryColor: Color(0xFFD4AF37),
          type: CosmicDiscoveryType.soulContract,
        ),
      ),
      GoRoute(
        path: Routes.innerPower,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'İçsel Gücün',
          subtitle: 'Süper güçlerini aktive et',
          emoji: '⚡',
          primaryColor: Color(0xFFFFD700),
          type: CosmicDiscoveryType.innerPower,
        ),
      ),

      // Kişilik Analizleri
      GoRoute(
        path: Routes.shadowSelf,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Gölge Benliğin',
          subtitle: 'Karanlık tarafınla tanış',
          emoji: '🌑',
          primaryColor: Color(0xFF37474F),
          type: CosmicDiscoveryType.shadowSelf,
        ),
      ),
      GoRoute(
        path: Routes.leadershipStyle,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Liderlik Stilin',
          subtitle: 'Nasıl bir lider olduğunu keşfet',
          emoji: '👑',
          primaryColor: Color(0xFFFFD700),
          type: CosmicDiscoveryType.leadershipStyle,
        ),
      ),
      GoRoute(
        path: Routes.heartbreak,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Kalp Yaran',
          subtitle: 'Aşkta hassas noktaların',
          emoji: '💔',
          primaryColor: Color(0xFFE91E63),
          type: CosmicDiscoveryType.heartbreak,
        ),
      ),
      GoRoute(
        path: Routes.redFlags,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Red Flag\'lerin',
          subtitle: 'Dikkat etmen gereken yönlerin',
          emoji: '🚩',
          primaryColor: Color(0xFFB71C1C),
          type: CosmicDiscoveryType.redFlags,
        ),
      ),
      GoRoute(
        path: Routes.greenFlags,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Green Flag\'lerin',
          subtitle: 'Harika özelliklerini keşfet',
          emoji: '💚',
          primaryColor: Color(0xFF4CAF50),
          type: CosmicDiscoveryType.greenFlags,
        ),
      ),
      GoRoute(
        path: Routes.flirtStyle,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Flört Stilin',
          subtitle: 'Nasıl baştan çıkardığını öğren',
          emoji: '😏',
          primaryColor: Color(0xFFFF6B9D),
          type: CosmicDiscoveryType.flirtStyle,
        ),
      ),

      // Mistik Keşifler
      GoRoute(
        path: Routes.tarotCard,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Tarot Kartın',
          subtitle: 'Ruhunu temsil eden kart',
          emoji: '🃏',
          primaryColor: Color(0xFF9C27B0),
          type: CosmicDiscoveryType.tarotCard,
        ),
      ),
      GoRoute(
        path: Routes.auraColor,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Aura Rengin',
          subtitle: 'Enerji alanının rengi',
          emoji: '🌈',
          primaryColor: Color(0xFF00BCD4),
          type: CosmicDiscoveryType.auraColor,
        ),
      ),
      GoRoute(
        path: Routes.chakraBalance,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Çakra Dengen',
          subtitle: 'Enerji merkezlerinin durumu',
          emoji: '🔮',
          primaryColor: Color(0xFF673AB7),
          type: CosmicDiscoveryType.chakraBalance,
        ),
      ),
      GoRoute(
        path: Routes.lifeNumber,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Yaşam Sayın',
          subtitle: 'Numerolojik kaderini keşfet',
          emoji: '🔢',
          primaryColor: Color(0xFFFFD700),
          type: CosmicDiscoveryType.lifeNumber,
        ),
      ),
      GoRoute(
        path: Routes.kabbalaPath,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Kabala Yolun',
          subtitle: 'Hayat ağacındaki yerin',
          emoji: '✡️',
          primaryColor: Color(0xFF3F51B5),
          type: CosmicDiscoveryType.kabbalaPath,
        ),
      ),

      // Zaman & Döngüler
      GoRoute(
        path: Routes.saturnLessons,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Saturn Derslerin',
          subtitle: 'Olgunlaşma yolculuğun',
          emoji: '🪐',
          primaryColor: Color(0xFF795548),
          type: CosmicDiscoveryType.saturnLessons,
        ),
      ),
      GoRoute(
        path: Routes.birthdayEnergy,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Doğum Günü Enerjin',
          subtitle: 'Solar return\'ün mesajı',
          emoji: '🎂',
          primaryColor: Color(0xFFE91E63),
          type: CosmicDiscoveryType.birthdayEnergy,
        ),
      ),
      GoRoute(
        path: Routes.eclipseEffect,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Tutulma Etkisi',
          subtitle: 'Tutulmaların sana etkisi',
          emoji: '🌒',
          primaryColor: Color(0xFF212121),
          type: CosmicDiscoveryType.eclipseEffect,
        ),
      ),
      GoRoute(
        path: Routes.transitFlow,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Transit Akışı',
          subtitle: 'Gezegen geçişlerinin etkisi',
          emoji: '🌊',
          primaryColor: Color(0xFF2196F3),
          type: CosmicDiscoveryType.transitFlow,
        ),
      ),

      // İlişki Analizleri
      GoRoute(
        path: Routes.compatibilityAnalysis,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Uyum Analizi',
          subtitle: 'İlişki potansiyelini keşfet',
          emoji: '💞',
          primaryColor: Color(0xFFE91E63),
          type: CosmicDiscoveryType.compatibilityAnalysis,
        ),
      ),
      GoRoute(
        path: Routes.soulMate,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ruh Eşin',
          subtitle: 'Kozmik eşini tanımla',
          emoji: '👫',
          primaryColor: Color(0xFFFF6B9D),
          type: CosmicDiscoveryType.soulMate,
        ),
      ),
      GoRoute(
        path: Routes.relationshipKarma,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'İlişki Karman',
          subtitle: 'İlişkilerindeki karma kalıplar',
          emoji: '🔄',
          primaryColor: Color(0xFF9C27B0),
          type: CosmicDiscoveryType.relationshipKarma,
        ),
      ),
      GoRoute(
        path: Routes.celebrityTwin,
        builder: (context, state) => const CosmicDiscoveryScreen(
          title: 'Ünlü İkizin',
          subtitle: 'Hangi ünlüyle aynı enerjidesin?',
          emoji: '⭐',
          primaryColor: Color(0xFFFFD700),
          type: CosmicDiscoveryType.celebrityTwin,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // QUIZ FUNNEL - Google Discover → Quiz → Premium
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: '/quiz',
        builder: (context, state) {
          final quizType = state.uri.queryParameters['type'] ?? 'general';
          final source = state.uri.queryParameters['source'];
          return QuizScreen(quizType: quizType, sourceContext: source);
        },
      ),

      // ════════════════════════════════════════════════════════════════
      // ADMIN SYSTEM - PIN Protected Dashboard
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.adminLogin,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: Routes.admin,
        redirect: (context, state) {
          if (!AdminAuthService.isAuthenticated) {
            return Routes.adminLogin;
          }
          return null;
        },
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
});

class _NotFoundScreen extends StatelessWidget {
  final String path;

  const _NotFoundScreen({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🔮', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 24),
                Text(
                  '404',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: const Color(0xFFFFD700),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sayfa Bulunamadı',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aradığınız sayfa yıldızlarda kaybolmuş görünüyor.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Aranan: $path',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white38,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => context.go(Routes.home),
                  icon: const Icon(Icons.home),
                  label: const Text('Ana Sayfaya Dön'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFF0D0D1A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go(Routes.horoscope),
                  child: const Text(
                    'Burç Yorumlarına Git',
                    style: TextStyle(color: Color(0xFFFFD700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashScreen extends ConsumerStatefulWidget {
  const _SplashScreen();

  @override
  ConsumerState<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final onboardingComplete = ref.read(onboardingCompleteProvider);
    final userProfile = ref.read(userProfileProvider);

    // Require BOTH onboarding complete AND valid user profile with name
    final hasValidProfile =
        userProfile != null &&
        userProfile.name != null &&
        userProfile.name!.isNotEmpty;

    if (onboardingComplete && hasValidProfile) {
      context.go(Routes.home);
    } else {
      context.go(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('✨', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text(
              'Venus One',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFFFFD700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
