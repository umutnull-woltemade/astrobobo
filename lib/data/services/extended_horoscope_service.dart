import 'dart:math';
import '../models/zodiac_sign.dart';
import '../models/extended_horoscope.dart';

class ExtendedHoroscopeService {
  // ============ WEEKLY HOROSCOPE ============

  static WeeklyHoroscope generateWeeklyHoroscope(
    ZodiacSign sign,
    DateTime weekStart,
  ) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final seed =
        weekStart.year * 10000 + _getWeekOfYear(weekStart) * 100 + sign.index;
    final seededRandom = Random(seed);

    final overviews = _getWeeklyOverviews(sign);
    final loves = _getWeeklyLoveContent(sign);
    final careers = _getWeeklyCareerContent(sign);
    final healths = _getWeeklyHealthContent(sign);
    final financials = _getWeeklyFinancialContent(sign);
    final affirmations = _getWeeklyAffirmations(sign);
    final days = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];

    return WeeklyHoroscope(
      sign: sign,
      weekStart: weekStart,
      weekEnd: weekEnd,
      overview: overviews[seededRandom.nextInt(overviews.length)],
      loveWeek: loves[seededRandom.nextInt(loves.length)],
      careerWeek: careers[seededRandom.nextInt(careers.length)],
      healthWeek: healths[seededRandom.nextInt(healths.length)],
      financialWeek: financials[seededRandom.nextInt(financials.length)],
      overallRating: seededRandom.nextInt(5) + 1,
      luckyDay: days[seededRandom.nextInt(days.length)],
      weeklyAffirmation:
          affirmations[seededRandom.nextInt(affirmations.length)],
      keyDates: _generateKeyDates(weekStart, seededRandom),
    );
  }

  static int _getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDiff = date.difference(firstDayOfYear).inDays;
    return (daysDiff / 7).ceil() + 1;
  }

  static List<String> _generateKeyDates(
    DateTime weekStart,
    Random seededRandom,
  ) {
    final keyDates = <String>[];
    final numDates = seededRandom.nextInt(3) + 1;
    final events = [
      'romantik fırsatlar',
      'kariyer atılımları',
      'finansal kararlar',
      'sağlık odağı',
      'sosyal etkinlikler',
      'iç huzur',
    ];

    for (int i = 0; i < numDates; i++) {
      final day = weekStart.add(Duration(days: seededRandom.nextInt(7)));
      final dayStr = '${day.day}.${day.month}';
      keyDates.add('$dayStr - ${events[seededRandom.nextInt(events.length)]}');
    }
    return keyDates;
  }

  // ============ MONTHLY HOROSCOPE ============

  static MonthlyHoroscope generateMonthlyHoroscope(
    ZodiacSign sign,
    int month,
    int year,
  ) {
    final seed = year * 10000 + month * 100 + sign.index;
    final seededRandom = Random(seed);

    final overviews = _getMonthlyOverviews(sign);
    final loves = _getMonthlyLoveContent(sign);
    final careers = _getMonthlyCareerContent(sign);
    final healths = _getMonthlyHealthContent(sign);
    final financials = _getMonthlyFinancialContent(sign);
    final spirituals = _getMonthlySpiritualContent(sign);
    final mantras = _getMonthlyMantras(sign);
    final transits = _getMonthlyTransits(sign, month);

    final weeklyRatings = <String, int>{
      'week1': seededRandom.nextInt(5) + 1,
      'week2': seededRandom.nextInt(5) + 1,
      'week3': seededRandom.nextInt(5) + 1,
      'week4': seededRandom.nextInt(5) + 1,
    };

    final luckyDays = <String>[];
    for (int i = 0; i < 3; i++) {
      luckyDays.add('${seededRandom.nextInt(28) + 1}');
    }

    return MonthlyHoroscope(
      sign: sign,
      month: month,
      year: year,
      overview: overviews[seededRandom.nextInt(overviews.length)],
      loveMonth: loves[seededRandom.nextInt(loves.length)],
      careerMonth: careers[seededRandom.nextInt(careers.length)],
      healthMonth: healths[seededRandom.nextInt(healths.length)],
      financialMonth: financials[seededRandom.nextInt(financials.length)],
      spiritualGuidance: spirituals[seededRandom.nextInt(spirituals.length)],
      overallRating: seededRandom.nextInt(5) + 1,
      luckyDays: luckyDays,
      monthlyMantra: mantras[seededRandom.nextInt(mantras.length)],
      keyTransits: transits[seededRandom.nextInt(transits.length)],
      weeklyRatings: weeklyRatings,
    );
  }

  // ============ LOVE HOROSCOPE ============

  static LoveHoroscope generateLoveHoroscope(ZodiacSign sign, DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day + sign.index;
    final seededRandom = Random(seed);

    final outlooks = _getRomanticOutlooks(sign);
    final singles = _getSingleAdvice(sign);
    final couples = _getCouplesAdvice(sign);
    final souls = _getSoulConnectionContent(sign);
    final venus = _getVenusInfluence(sign);
    final intimacy = _getIntimacyAdvice(sign);

    final compatibleSigns = _getCompatibleSigns(sign);
    final challengingSigns = _getChallengingSigns(sign);

    return LoveHoroscope(
      sign: sign,
      date: date,
      romanticOutlook: outlooks[seededRandom.nextInt(outlooks.length)],
      singleAdvice: singles[seededRandom.nextInt(singles.length)],
      couplesAdvice: couples[seededRandom.nextInt(couples.length)],
      soulConnection: souls[seededRandom.nextInt(souls.length)],
      passionRating: seededRandom.nextInt(5) + 1,
      romanceRating: seededRandom.nextInt(5) + 1,
      communicationRating: seededRandom.nextInt(5) + 1,
      bestMatch: compatibleSigns[seededRandom.nextInt(compatibleSigns.length)],
      challengingMatch:
          challengingSigns[seededRandom.nextInt(challengingSigns.length)],
      venusInfluence: venus[seededRandom.nextInt(venus.length)],
      intimacyAdvice: intimacy[seededRandom.nextInt(intimacy.length)],
    );
  }

  // ============ YEARLY HOROSCOPE ============

  static YearlyHoroscope generateYearlyHoroscope(ZodiacSign sign, int year) {
    final seed = year * 100 + sign.index;
    final seededRandom = Random(seed);

    final overviews = _getYearlyOverviews(sign);
    final loves = _getYearlyLoveContent(sign);
    final careers = _getYearlyCareerContent(sign);
    final healths = _getYearlyHealthContent(sign);
    final financials = _getYearlyFinancialContent(sign);
    final spirituals = _getYearlySpiritualContent(sign);
    final affirmations = _getYearlyAffirmations(sign);
    final themes = _getYearlyThemes(sign);
    final transits = _getMajorTransits(year);

    final monthlyRatings = <int, int>{};
    for (int i = 1; i <= 12; i++) {
      monthlyRatings[i] = seededRandom.nextInt(5) + 1;
    }

    final luckyMonths = <String>[];
    final challengingMonths = <String>[];
    final months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];

    for (int i = 0; i < 3; i++) {
      luckyMonths.add(months[seededRandom.nextInt(12)]);
    }
    for (int i = 0; i < 2; i++) {
      challengingMonths.add(months[seededRandom.nextInt(12)]);
    }

    return YearlyHoroscope(
      sign: sign,
      year: year,
      yearOverview: overviews[seededRandom.nextInt(overviews.length)],
      loveYear: loves[seededRandom.nextInt(loves.length)],
      careerYear: careers[seededRandom.nextInt(careers.length)],
      healthYear: healths[seededRandom.nextInt(healths.length)],
      financialYear: financials[seededRandom.nextInt(financials.length)],
      spiritualJourney: spirituals[seededRandom.nextInt(spirituals.length)],
      overallRating: seededRandom.nextInt(5) + 1,
      monthlyRatings: monthlyRatings,
      majorTransits: transits,
      luckyMonths: luckyMonths,
      challengingMonths: challengingMonths,
      yearlyAffirmation:
          affirmations[seededRandom.nextInt(affirmations.length)],
      keyTheme: themes[seededRandom.nextInt(themes.length)],
    );
  }

  // ============ ECLIPSE CALENDAR ============

  static List<EclipseEvent> getEclipsesForYear(int year) {
    // Real eclipse data for 2024-2026
    final eclipses = <EclipseEvent>[];

    if (year == 2024) {
      eclipses.addAll([
        EclipseEvent(
          date: DateTime(2024, 3, 25),
          type: EclipseType.lunarPenumbral,
          zodiacSign: ZodiacSign.libra,
          title: 'Terazi Burcunda Yarıgölge Ay Tutulması',
          description: 'Bu tutulma ilişkilerinizde denge arayışını tetikliyor.',
          spiritualMeaning:
              'İlişkilerdeki dengesizlikleri fark etme ve düzeltme zamanı. Terazi enerjisi, adalet ve harmoni arayışını güçlendiriyor.',
          practicalAdvice:
              'Partnerlilkte karşılıklı ihtiyaçları gözden geçirin. Taviz vermek ile sınır koymak arasındaki dengeyi bulun.',
          mostAffectedSigns: [
            ZodiacSign.libra,
            ZodiacSign.aries,
            ZodiacSign.cancer,
            ZodiacSign.capricorn,
          ],
          isVisible: true,
          peakTime: '10:13 UTC',
          magnitude: 0.96,
        ),
        EclipseEvent(
          date: DateTime(2024, 4, 8),
          type: EclipseType.solarTotal,
          zodiacSign: ZodiacSign.aries,
          title: 'Koç Burcunda Tam Güneş Tutulması',
          description:
              'Güçlü bir yeni başlangıç enerjisi. Cesaretle ileri atılma zamanı.',
          spiritualMeaning:
              'Kimlik dönüşümü ve yeniden doğuş. Eski benliği bırakıp, yeni bir sayfa açma fırsatı.',
          practicalAdvice:
              'Büyük kararlar almak için ideal. Yeni projelere başlayın, cesur adımlar atın.',
          mostAffectedSigns: [
            ZodiacSign.aries,
            ZodiacSign.libra,
            ZodiacSign.cancer,
            ZodiacSign.capricorn,
          ],
          isVisible: false,
          peakTime: '18:17 UTC',
          magnitude: 1.0,
        ),
        EclipseEvent(
          date: DateTime(2024, 9, 18),
          type: EclipseType.lunarPartial,
          zodiacSign: ZodiacSign.pisces,
          title: 'Balık Burcunda Kısmi Ay Tutulması',
          description: 'Duygusal derinlik ve ruhsal uyanış.',
          spiritualMeaning:
              'İç sesin güçlendiği bir dönem. Sezgilerinize güvenin, rüyalarınıza dikkat edin.',
          practicalAdvice:
              'Meditasyon ve içe dönüş pratikleri için ideal. Duygusal bagajlarınızı bırakın.',
          mostAffectedSigns: [
            ZodiacSign.pisces,
            ZodiacSign.virgo,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: true,
          peakTime: '02:44 UTC',
          magnitude: 0.08,
        ),
        EclipseEvent(
          date: DateTime(2024, 10, 2),
          type: EclipseType.solarAnnular,
          zodiacSign: ZodiacSign.libra,
          title: 'Terazi Burcunda Halkalı Güneş Tutulması',
          description: 'İlişki dinamiklerinde köklü değişiklikler.',
          spiritualMeaning:
              'Ortaklıklar ve bağlantılar konusunda yeni bir vizyon. Karşılıklılık ilkesini yeniden tanımlama.',
          practicalAdvice:
              'Sözleşmeler, anlaşmalar ve resmi birliktelikler için dikkatli olun. Yeni ortaklıklar kurulabilir.',
          mostAffectedSigns: [
            ZodiacSign.libra,
            ZodiacSign.aries,
            ZodiacSign.cancer,
            ZodiacSign.capricorn,
          ],
          isVisible: false,
          peakTime: '18:45 UTC',
          magnitude: 0.93,
        ),
      ]);
    } else if (year == 2025) {
      eclipses.addAll([
        EclipseEvent(
          date: DateTime(2025, 3, 14),
          type: EclipseType.lunarTotal,
          zodiacSign: ZodiacSign.virgo,
          title: 'Başak Burcunda Tam Ay Tutulması',
          description: 'Detaylara dikkat ve mükemmeliyetçilikle yüzleşme.',
          spiritualMeaning:
              'Kendini eleştirme kalıplarını bırakma. Kusurlarınızı kabullenme ve şefkat geliştirme.',
          practicalAdvice:
              'Sağlık rutinlerinizi gözden geçirin. İş süreçlerini iyileştirin ama takıntılı olmayın.',
          mostAffectedSigns: [
            ZodiacSign.virgo,
            ZodiacSign.pisces,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: true,
          peakTime: '06:58 UTC',
          magnitude: 1.0,
        ),
        EclipseEvent(
          date: DateTime(2025, 3, 29),
          type: EclipseType.solarPartial,
          zodiacSign: ZodiacSign.aries,
          title: 'Koç Burcunda Kısmi Güneş Tutulması',
          description: 'Yeni başlangıçlar için enerji patlaması.',
          spiritualMeaning:
              'Öncü ruhunuzu kucaklayın. Liderlik potansiyelinizi aktive edin.',
          practicalAdvice:
              'Girişimcilik ve yeni projeler için ideal. Korku yerine cesareti seçin.',
          mostAffectedSigns: [
            ZodiacSign.aries,
            ZodiacSign.libra,
            ZodiacSign.cancer,
            ZodiacSign.capricorn,
          ],
          isVisible: false,
          peakTime: '10:50 UTC',
          magnitude: 0.94,
        ),
        EclipseEvent(
          date: DateTime(2025, 9, 7),
          type: EclipseType.lunarTotal,
          zodiacSign: ZodiacSign.pisces,
          title: 'Balık Burcunda Tam Ay Tutulması',
          description: 'Derin duygusal arınma ve ruhsal yükseliş.',
          spiritualMeaning:
              'Kolektif bilinçle bağlantı. Şifa ve sezgisel yeteneklerin güçlenmesi.',
          practicalAdvice:
              'Sanatsal ve yaratıcı çalışmalar için bereketli. Bağımlılıklarla yüzleşme zamanı.',
          mostAffectedSigns: [
            ZodiacSign.pisces,
            ZodiacSign.virgo,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: true,
          peakTime: '18:11 UTC',
          magnitude: 1.0,
        ),
        EclipseEvent(
          date: DateTime(2025, 9, 21),
          type: EclipseType.solarPartial,
          zodiacSign: ZodiacSign.virgo,
          title: 'Başak Burcunda Kısmi Güneş Tutulması',
          description: 'Pratik düzenlemeler ve sağlık odağı.',
          spiritualMeaning:
              'Hizmet ve alçakgönüllülük temalı bir döngü. Günlük ritüellerin kutsallığını keşfetme.',
          practicalAdvice:
              'Sağlık check-up\'ları planlayın. İş yerinde verimlilik artışı için adımlar atın.',
          mostAffectedSigns: [
            ZodiacSign.virgo,
            ZodiacSign.pisces,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: false,
          peakTime: '19:42 UTC',
          magnitude: 0.86,
        ),
      ]);
    } else if (year == 2026) {
      eclipses.addAll([
        EclipseEvent(
          date: DateTime(2026, 2, 17),
          type: EclipseType.solarAnnular,
          zodiacSign: ZodiacSign.aquarius,
          title: 'Kova Burcunda Halkalı Güneş Tutulması',
          description: 'İnsanlık ve topluluk bilinci öne çıkıyor.',
          spiritualMeaning:
              'Kolektif amaçlarla bireysel hedeflerin uyumu. Gelecek vizyonu netleşiyor.',
          practicalAdvice:
              'Sosyal projeler ve grup çalışmaları için ideal. Teknoloji ve inovasyon alanında fırsatlar.',
          mostAffectedSigns: [
            ZodiacSign.aquarius,
            ZodiacSign.leo,
            ZodiacSign.taurus,
            ZodiacSign.scorpio,
          ],
          isVisible: false,
          peakTime: '12:02 UTC',
          magnitude: 0.96,
        ),
        EclipseEvent(
          date: DateTime(2026, 3, 3),
          type: EclipseType.lunarTotal,
          zodiacSign: ZodiacSign.virgo,
          title: 'Başak Burcunda Tam Ay Tutulması',
          description: 'Mükemmeliyetçilik ve hizmet temalarının doruk noktası.',
          spiritualMeaning:
              'Eleştirici zihni şefkatle dengeleme. İyileştirme ve arınma süreçleri.',
          practicalAdvice:
              'Sağlık konularına öncelik verin. Organizasyon ve planlama zamanı.',
          mostAffectedSigns: [
            ZodiacSign.virgo,
            ZodiacSign.pisces,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: true,
          peakTime: '11:33 UTC',
          magnitude: 1.0,
        ),
        EclipseEvent(
          date: DateTime(2026, 8, 12),
          type: EclipseType.solarTotal,
          zodiacSign: ZodiacSign.leo,
          title: 'Aslan Burcunda Tam Güneş Tutulması',
          description: 'Yaratıcılık ve kendini ifade patlaması.',
          spiritualMeaning:
              'İç güneşinizi parlatın. Otantik benliğinizi cesaretle ortaya koyun.',
          practicalAdvice:
              'Sanat, eğlence ve yaratıcı projeler için mükemmel. Çocuklarla ilgili konular öne çıkabilir.',
          mostAffectedSigns: [
            ZodiacSign.leo,
            ZodiacSign.aquarius,
            ZodiacSign.taurus,
            ZodiacSign.scorpio,
          ],
          isVisible: true,
          peakTime: '17:46 UTC',
          magnitude: 1.0,
        ),
        EclipseEvent(
          date: DateTime(2026, 8, 28),
          type: EclipseType.lunarPartial,
          zodiacSign: ZodiacSign.pisces,
          title: 'Balık Burcunda Kısmi Ay Tutulması',
          description: 'Duygusal ve ruhsal boyutlarda son düzenlemeler.',
          spiritualMeaning:
              'Mistik deneyimler ve sezgisel açılımlar. Geçmişle barışma.',
          practicalAdvice:
              'Meditatif pratikler ve ruhsal çalışmalar için ideal. Bağımlılık konularına dikkat.',
          mostAffectedSigns: [
            ZodiacSign.pisces,
            ZodiacSign.virgo,
            ZodiacSign.gemini,
            ZodiacSign.sagittarius,
          ],
          isVisible: true,
          peakTime: '04:13 UTC',
          magnitude: 0.93,
        ),
      ]);
    }

    return eclipses;
  }

  static EclipseEvent? getNextEclipse() {
    final now = DateTime.now();
    final currentYear = now.year;

    for (int year = currentYear; year <= currentYear + 2; year++) {
      final eclipses = getEclipsesForYear(year);
      for (final eclipse in eclipses) {
        if (eclipse.date.isAfter(now)) {
          return eclipse;
        }
      }
    }
    return null;
  }

  // ============ CONTENT GENERATORS ============

  static List<String> _getWeeklyOverviews(ZodiacSign sign) {
    return [
      'Bu hafta ${sign.nameTr} burcu için kozmik enerjiler yoğunlaşıyor. Gezegenler sizin lehinize hizalanırken, büyük fırsatların kapıları aralanıyor. İç sesinize kulak verin ve sezgilerinizi takip edin.',
      'Evren bu hafta size güçlü mesajlar gönderiyor. ${sign.nameTr} enerjisi dorukta ve potansiyelinizi ortaya koyma zamanı. Cesur adımlar atın, korkularınızı geride bırakın.',
      'Hafta boyunca ${sign.element.nameTr} elementi güçleniyor. Bu enerjiyi kendi avantajınıza kullanın. İç dünyanızda derin dönüşümler yaşanırken, dış dünyada da somut değişiklikler görülecek.',
      'Yıldızlar bu hafta ${sign.nameTr} burcu için parlak bir tablo çiziyor. Yeni bağlantılar, beklenmedik fırsatlar ve ruhsal açılımlar sizi bekliyor. Açık kalın ve akışa güvenin.',
      'Gökyüzündeki gezegen dansı ${sign.nameTr} burcuna özel mesajlar taşıyor. Bu hafta kader anları yaşayabilir, hayatınızı değiştirecek kararlar alabilirsiniz. Sezgileriniz her zamankinden keskin.',
      '${sign.nameTr} burcu için bu hafta enerji akışı olumlu yönde. Engeller kalkıyor, yollar açılıyor. Uzun süredir beklediğiniz haber veya gelişme bu hafta gelebilir.',
      'Kozmik rüzgarlar ${sign.nameTr} burcunun yelkenlerini şişiriyor. Hangi yöne gitmek istediğinizi biliyorsanız, evren sizi desteklemeye hazır. Niyetlerinizi net tutun.',
      'Bu hafta evrensel enerji ${sign.nameTr} burcunu kucaklıyor. Yaratıcılık, ilham ve motivasyon dorukta. Ertelediğiniz projelere başlamak için ideal bir zamanlama.',
    ];
  }

  static List<String> _getWeeklyLoveContent(ZodiacSign sign) {
    return [
      'Aşk hayatınızda bu hafta hareketli bir dönem başlıyor. Venüs etkisi altında, ilişkilerinizde daha derin bağlar kurabilirsiniz. Bekarlar için sürpriz karşılaşmalar olası.',
      'Kalp çakranız bu hafta aktive oluyor. Duygusal açıdan hassas olabilirsiniz ama bu, sevgiyi daha derin hissetmenize de olanak tanıyor. Partnerinizle özel anlar yaratın.',
      'Romantik enerjiler yükseliyor. İlişkinizde yeni bir sayfa açılabilir veya bekarlar için önemli bir tanışma gerçekleşebilir. Kalbinizi açık tutun.',
      'Bu hafta aşk, beklenmedik yerlerden gelebilir. Sezgilerinize güvenin ve evrenin size sunduğu işaretleri takip edin. Kadersel bağlantılar mümkün.',
      'Venüs\'ün olumlu açıları aşk hayatınızı ışıklandırıyor. Çiftler için tutku yeniden alevlenirken, bekarlar manyetik çekicilik yayıyor. Flört enerjisi güçlü.',
      'İlişkilerde iletişim bu hafta kritik öneme sahip. Duygularınızı açıkça ifade edin, karşı tarafı dinleyin. Yanlış anlamalar çözülüyor, bağlar güçleniyor.',
      'Romantik sürprizlere hazır olun. Evren aşk konusunda size güzel haberler getirebilir. Geçmişten biri yeniden hayatınıza girebilir veya yeni biri çıkabilir.',
      'Aşkta cesur olma haftası. Duygularınızı bastırmayın, risk alın. Karşılık görmekten korkmayın - evren cesareti ödüllendirir.',
    ];
  }

  static List<String> _getWeeklyCareerContent(ZodiacSign sign) {
    return [
      'Kariyer alanında bu hafta önemli gelişmeler yaşanabilir. Liderlik yetenekleriniz ön plana çıkıyor. Fikirlerinizi cesurca paylaşın.',
      'Profesyonel yaşamınızda yeni kapılar açılıyor. Bu hafta stratejik düşünün ve uzun vadeli planlarınızı gözden geçirin. Değişimler lehinize.',
      'İş yerinde yaratıcılığınız dorukta. Yenilikçi fikirleriniz dikkat çekecek. Ekip çalışması ve işbirlikleri bereketli sonuçlar getirebilir.',
      'Maddi konularda olumlu haberler gelebilir. Bu hafta finansal kararlarınızda sezgilerinize güvenin ama mantığı da ihmal etmeyin.',
      'Kariyer basamaklarında yükseliş zamanı. Üstlerinizin dikkatini çekebilir, terfi veya zam haberi gelebilir. Kendinizi görünür kılın.',
      'İş görüşmeleri ve müzakereler için elverişli bir hafta. İsteklerinizi net ifade edin, hak ettiğinizi isteyin. Evren sizi destekliyor.',
      'Yeni iş fırsatları kapınızı çalabilir. LinkedIn profilinizi güncelleyin, ağınızı genişletin. Beklenmedik yerlerden teklifler gelebilir.',
      'Projeleriniz bu hafta hız kazanıyor. Engeller kalkıyor, süreçler hızlanıyor. Ertelenen onaylar, beklenen kararlar bu hafta gelebilir.',
    ];
  }

  static List<String> _getWeeklyHealthContent(ZodiacSign sign) {
    return [
      'Enerji seviyeniz bu hafta yüksek. Fiziksel aktivitelere zaman ayırın. Bedeninizin size gönderdiği sinyallere dikkat edin.',
      'Zihinsel ve duygusal sağlığınıza odaklanın. Stres yönetimi için meditasyon veya yoga deneyin. Doğada vakit geçirmek size iyi gelecek.',
      'Bu hafta beslenme düzeninizi gözden geçirin. Vücudunuzun ihtiyaç duyduğu besinleri verin. Uyku düzeninize dikkat edin.',
      'Enerji dengenizi korumak için molalar verin. Kendinize şefkat gösterin ve aşırı yorgunluktan kaçının. Şifa enerjileri güçlü.',
    ];
  }

  static List<String> _getWeeklyFinancialContent(ZodiacSign sign) {
    return [
      'Finansal konularda bu hafta dikkatli olun. Büyük harcamalardan önce iki kez düşünün. Tasarruf planları yapmanın tam zamanı.',
      'Maddi bolluk enerjisi güçleniyor. Beklenmedik kazançlar veya fırsatlar gelebilir. Ama ayaklarınızı yere basın.',
      'Yatırımlar için araştırma yapın ama aceleci davranmayın. Bu hafta finansal bilincinizi geliştirmek için ideal.',
      'Para konularında yeni bir bakış açısı geliştirin. Bolluk bilincini aktive edin ve kıtlık korkularını bırakın.',
    ];
  }

  static List<String> _getWeeklyAffirmations(ZodiacSign sign) {
    return [
      'Evrenin bolluğuna açığım ve her şey yolunda.',
      'Her gün her anlamda daha iyiye gidiyorum.',
      'İçimdeki gücü fark ediyorum ve onu kullanıyorum.',
      'Sevgiyi çekiyorum ve sevgi veriyorum.',
      'Korkularımı bırakıyor, güvenle ilerliyorum.',
      'Ruhsal yolculuğumda doğru yöndeyim.',
    ];
  }

  static List<String> _getMonthlyOverviews(ZodiacSign sign) {
    return [
      'Bu ay ${sign.nameTr} burcu için dönüşüm ve yenilenme zamanı. Gezegenler güçlü açılar oluşturarak, hayatınızda köklü değişikliklere zemin hazırlıyor. İç dünyanızda başlayan dönüşüm, dış dünyanıza yansıyacak.',
      'Ayın enerjileri ${sign.nameTr} burcunu destekliyor. Bu dönem kendinizi keşfetmek, potansiyelinizi gerçekleştirmek ve ruhsal olarak büyümek için ideal. Evrenin size sunduğu fırsatları değerlendirin.',
      'Kozmik akış bu ay sizden yana. ${sign.element.nameTr} enerjisi güçlenirken, doğal yetenekleriniz ve güçlü yanlarınız ön plana çıkıyor. Özgüvenle hareket edin ve hedeflerinize odaklanın.',
      'Gezegenler bu ay ${sign.nameTr} burcu için özel bir koreografi sergiliyor. Kader kapıları aralanıyor, yeni olanaklar beliriyor. Hayatınızın akışını değiştirecek olaylar yaşanabilir.',
      'Ay boyunca ${sign.nameTr} burcunun enerjisi yoğun. Duygusal iniş çıkışlar yaşanabilir ama her biri sizi daha güçlü kılacak. Sabırlı olun, süreç size çalışıyor.',
      'Bu ay evrensel enerji ${sign.nameTr} burcunu sarmalıyor. Uzun süredir beklediğiniz değişimler başlıyor. Korkularınızı bırakın, yeniye açılın.',
      'Kozmik takvim bu ay sizin için önemli sayfalar açıyor. Kişisel ve profesyonel yaşamınızda dönüm noktaları var. Her kararınız geleceğinizi şekillendiriyor.',
      '${sign.nameTr} burcu için bereketli bir ay başlıyor. Emeklerinizin karşılığını alma, hedeflerinize yaklaşma zamanı. Evren çabalarınızı görüyor ve ödüllendiriyor.',
    ];
  }

  static List<String> _getMonthlyLoveContent(ZodiacSign sign) {
    return [
      'Aşk hayatınızda bu ay önemli gelişmeler var. Venüs\'ün etkisi altında, ilişkileriniz derinleşiyor ve yeni romantik bağlar kurulabilir. Kalbinizi açık tutun.',
      'Bu ay ilişkilerde dönüşüm yaşanıyor. Eski kalıpları kırmak ve daha otantik bağlar kurmak için ideal bir dönem. Cesur olun ve duygularınızı ifade edin.',
      'Romantik enerjiler yoğunlaşıyor. Bekarlar için önemli karşılaşmalar, çiftler için tutkulu bir dönem başlıyor. Aşkın büyüsüne kendinizi bırakın.',
      'Kalp çakranız bu ay fazla mesai yapıyor. Derin duygusal bağlantılar, anlamlı konuşmalar ve romantik anlar sizi bekliyor. Savunmalarınızı indirin.',
      'Ay boyunca romantik atmosfer güçlü. Sürpriz randevular, beklenmedik itiraflar veya ilişkinizde yeni bir sayfa açılması mümkün.',
      'İlişkilerde netlik zamanı. Belirsizlikler çözülüyor, duygular berraklaşıyor. "Nerede duruyorum?" sorusunun cevabını bu ay alabilirsiniz.',
      'Aşkta şanslı bir ay başlıyor. Bekarlar için kader anları, çiftler için yeniden aşık olma dönemi. Romantizm havada.',
      'Bu ay duygusal bağlar güçleniyor. Sevdiklerinizle geçirdiğiniz her an değerli. Kaliteli zaman yaratın, anılar biriktirin.',
    ];
  }

  static List<String> _getMonthlyCareerContent(ZodiacSign sign) {
    return [
      'Kariyer hedefleriniz bu ay netleşiyor. Profesyonel alanda yeni fırsatlar ve ilerleme potansiyeli var. Liderlik yeteneklerinizi gösterme zamanı.',
      'İş hayatınızda stratejik hamleler yapın. Bu ay uzun vadeli planlar için zemin hazırlayabilir, önemli kararlar alabilirsiniz. Vizyonunuza güvenin.',
      'Profesyonel ilişkileriniz güçleniyor. Ağ kurma ve işbirlikleri için bereketli bir dönem. Fikirlerinizi paylaşın ve destek arayın.',
      'Kariyer alanında ay boyunca hareketlilik var. Toplantılar, görüşmeler, yeni projeler... Enerji yüksek, fırsatlar bol. Aktif olun.',
      'Bu ay iş yerinde öne çıkma zamanı. Yeteneklerinizi sergileyin, fikirlerinizi sunun. Üstlerinizin dikkatini çekme şansınız yüksek.',
      'Profesyonel alanda kararlılık ve odaklanma gerekiyor. Dikkat dağıtıcılardan uzak durun, önceliklerinizi belirleyin. Sonuçlar gelecek.',
      'İş hayatında değişim rüzgarları esiyor. Yeni roller, sorumluluklar veya tamamen farklı bir kariyer yolu gündeme gelebilir.',
      'Ay boyunca iş dünyasında şansınız parlak. Beklenmedik fırsatlar, olumlu haberler veya maddi kazançlar mümkün.',
    ];
  }

  static List<String> _getMonthlyHealthContent(ZodiacSign sign) {
    return [
      'Sağlığınıza bu ay özel önem verin. Beslenme, uyku ve egzersiz dengesini gözden geçirin. Bedeniniz size mesajlar gönderiyor - dinleyin.',
      'Enerji seviyelerinizi optimize etmek için doğru zamanlama önemli. Stres yönetimi ve zihinsel sağlık bu ay odak noktası olsun.',
      'Bütünsel sağlık yaklaşımını benimseyin. Beden, zihin ve ruh dengesini kurarak, yaşam kalitenizi artırın.',
    ];
  }

  static List<String> _getMonthlyFinancialContent(ZodiacSign sign) {
    return [
      'Finansal konularda bu ay bilinçli hareket edin. Bütçenizi gözden geçirin, gereksiz harcamaları kısın ve geleceğe yatırım yapın.',
      'Maddi bolluk enerjisi güçleniyor. Yeni gelir kaynakları veya beklenmedik kazançlar mümkün. Ama yine de temkinli olun.',
      'Para ile ilişkinizi gözden geçirin. Bolluk bilincini geliştirmek için çalışın. Verdiğiniz değer, aldığınızı belirler.',
    ];
  }

  static List<String> _getMonthlySpiritualContent(ZodiacSign sign) {
    return [
      'Ruhsal yolculuğunuzda önemli bir dönemdesiniz. İç sesinize kulak verin, meditasyon ve farkındalık pratiklerine zaman ayırın.',
      'Evrenle bağlantınız güçleniyor. Senkronisiteler artıyor, işaretler netleşiyor. Ruhsal rehberleriniz sizinle iletişim halinde.',
      'İç dünyanızda derin keşifler yapma zamanı. Gölge yanlarınızla yüzleşin, eski yaraları iyileştirin ve bütünleşin.',
    ];
  }

  static List<String> _getMonthlyMantras(ZodiacSign sign) {
    return [
      'Değişimi kucaklıyorum ve onunla büyüyorum.',
      'Her deneyim, ruhsal evrimimin bir parçası.',
      'Evrenin planına güveniyorum.',
      'Gücüm içimde ve her an erişebilirim.',
      'Sevgiyle hareket ediyor, sevgiyle çekiyorum.',
    ];
  }

  static List<String> _getMonthlyTransits(ZodiacSign sign, int month) {
    return [
      'Ay başında Merkür\'ün hareketi iletişim alanını aktive ediyor. Ay ortasında Venüs geçişi aşk ve finans konularını ön plana çıkarıyor.',
      'Mars enerjisi bu ay güçlü. Eylem ve kararlılık gerektiren konularda cesur adımlar atabilirsiniz. Dolunay döneminde duygusal doruk noktası.',
      'Jüpiter\'in olumlu açısı şans ve fırsatlar getiriyor. Satürn\'ün etkisi ise disiplin ve sorumluluk temalarını vurguluyor.',
    ];
  }

  static List<String> _getRomanticOutlooks(ZodiacSign sign) {
    return [
      'Bugün romantik enerjiler güçlü. Venüs size göz kırpıyor - beklenmedik romantik gelişmeler olabilir. Kalbinizi açık tutun ve aşkın sihrine kendinizi bırakın.',
      'Aşk hayatınızda bugün derin bağlantılar kurabilirsiniz. Duygusal açıdan hassas olabilirsiniz ama bu, sevgiyi daha yoğun hissetmenizi sağlıyor.',
      'Romantik potansiyel yüksek. İster biriyle tanışın ister mevcut ilişkinizi derinleştirin - bugün kalp çakranız parlıyor.',
      'Tutku ve romantizm dengede. Bugün hem fiziksel hem duygusal bağlantılar için ideal. Cesaretinizi toplayın ve ilk adımı atın.',
    ];
  }

  static List<String> _getSingleAdvice(ZodiacSign sign) {
    return [
      'Bekarlar için bugün sürpriz karşılaşmalar mümkün. Sosyal etkinliklere katılın, yeni insanlarla tanışmaya açık olun. Ruh eşiniz yakınınızda olabilir.',
      'Kendinizi sevmeye odaklanın - bu, doğru kişiyi çekmenin anahtarı. Bugün kendi değerinizi hatırlayın ve standartlarınızdan ödün vermeyin.',
      'Yeni bağlantılar için enerji güçlü. Ama aceleci davranmayın - kalıcı ilişkiler zaman ister. Sabırlı olun ve akışa güvenin.',
      'Kadersel karşılaşmalar için kapılar açık. Sezgilerinize güvenin - birini gördüğünüzde içinizde bir şeyin kıpırdadığını hissederseniz, bu önemli bir işaret.',
    ];
  }

  static List<String> _getCouplesAdvice(ZodiacSign sign) {
    return [
      'Çiftler için bugün ilişkinizi derinleştirme fırsatı var. Kaliteli zaman geçirin, duygularınızı paylaşın ve birbirinizi dinleyin.',
      'İlişkinizde yenilenme enerjisi güçlü. Rutini kırın, sürprizler yapın ve tutkuyu yeniden ateşleyin. Küçük jestler büyük farklar yaratır.',
      'İletişim bugün kritik. Partnerlınızla açık ve dürüst konuşun. Yanlış anlamalar varsa, bugün çözme şansınız var.',
      'Birlikte büyümek için bugünü kullanın. Ortak hedefler belirleyin, hayaller paylaşın ve geleceğe birlikte bakın.',
    ];
  }

  static List<String> _getSoulConnectionContent(ZodiacSign sign) {
    return [
      'Ruhsal bağlantılar bugün güçleniyor. Karşınızdaki kişiyle sadece fiziksel değil, ruhsal düzeyde de bağ kurabilirsiniz. Bu, sıradan bir ilişkinin ötesinde.',
      'Ruh eşi enerjisi aktif. Geçmiş yaşamlardan gelen bağlantılar yüzeye çıkabilir. Tanıdık hissettiren yabancılara dikkat edin.',
      'Karmik ilişki temaları öne çıkıyor. Bazı insanlar hayatımıza bir ders için gelir - bugün bu dersleri görebilirsiniz.',
      'Koşulsuz sevgi enerjisi güçlü. Beklentisiz sevmek ve sevilmek - bugün bunun ne demek olduğunu anlayabilirsiniz.',
    ];
  }

  static List<String> _getVenusInfluence(ZodiacSign sign) {
    return [
      'Venüs bugün ${sign.nameTr} burcunu destekliyor. Güzellik, aşk ve harmoni temaları güçleniyor. Kendinize bakım yapın ve iç güzelliğinizi yansıtın.',
      'Venüs enerjisi romantik alanı ışıklandırıyor. Çekicilik ve manyetizmanız artıyor. Bu enerjiyi bilinçli kullanın.',
      'Aşk gezegeni size gülümsüyor. Hem verici hem alıcı olun - sevgi alışverişi bugün dengede.',
    ];
  }

  static List<String> _getIntimacyAdvice(ZodiacSign sign) {
    return [
      'Yakınlık bugün farklı boyutlarda deneyimlenebilir. Fiziksel yakınlık kadar duygusal ve ruhsal yakınlık da önemli.',
      'Güven ve açıklık, gerçek yakınlığın anahtarı. Bugün savunmalarınızı indirin ve kendinizi gösterin.',
      'Bedensel farkındalık yüksek. Dokunuşun şifa gücünü keşfedin. Sevgiyi fiziksel olarak ifade etmekten çekinmeyin.',
    ];
  }

  static List<ZodiacSign> _getCompatibleSigns(ZodiacSign sign) {
    // Same element + complementary elements
    switch (sign.element) {
      case Element.fire:
        return [
          ZodiacSign.aries,
          ZodiacSign.leo,
          ZodiacSign.sagittarius,
          ZodiacSign.gemini,
          ZodiacSign.libra,
          ZodiacSign.aquarius,
        ];
      case Element.earth:
        return [
          ZodiacSign.taurus,
          ZodiacSign.virgo,
          ZodiacSign.capricorn,
          ZodiacSign.cancer,
          ZodiacSign.scorpio,
          ZodiacSign.pisces,
        ];
      case Element.air:
        return [
          ZodiacSign.gemini,
          ZodiacSign.libra,
          ZodiacSign.aquarius,
          ZodiacSign.aries,
          ZodiacSign.leo,
          ZodiacSign.sagittarius,
        ];
      case Element.water:
        return [
          ZodiacSign.cancer,
          ZodiacSign.scorpio,
          ZodiacSign.pisces,
          ZodiacSign.taurus,
          ZodiacSign.virgo,
          ZodiacSign.capricorn,
        ];
    }
  }

  static List<ZodiacSign> _getChallengingSigns(ZodiacSign sign) {
    // Square and opposite signs
    final index = sign.index;
    return [
      ZodiacSign.values[(index + 3) % 12],
      ZodiacSign.values[(index + 6) % 12],
      ZodiacSign.values[(index + 9) % 12],
    ];
  }

  static List<String> _getYearlyOverviews(ZodiacSign sign) {
    return [
      'Bu yıl ${sign.nameTr} burcu için dönüşüm, büyüme ve kendini gerçekleştirme yılı. Gezegenler sizin için güçlü bir enerji alanı oluşturuyor. Cesur adımlar atma, yeni başlangıçlar yapma ve hayallerinizi gerçekleştirme zamanı.',
      'Kozmik enerji bu yıl ${sign.nameTr} burcunu destekliyor. İster kariyer, ister aşk, ister kişisel gelişim olsun - her alanda ilerleme potansiyeli var. Fırsatları değerlendirin ve potansiyelinizi ortaya koyun.',
      'Evrensel akış bu yıl sizin yanınızda. ${sign.element.nameTr} elementi güçlenirken, doğal yetenekleriniz parlamaya başlıyor. Kendinize güvenin ve büyük hayaller kurun.',
      'Bu yıl ${sign.nameTr} burcu için kader kapıları sonuna kadar açılıyor. Yıllardır beklediğiniz fırsatlar, uzun süredir hayal ettiğiniz değişimler gerçekleşebilir. Hazır olun ve cesaretle ilerleyin.',
      'Gezegenler bu yıl ${sign.nameTr} burcuna özel bir yol çiziyor. Kişisel dönüşüm, ruhsal büyüme ve maddi başarı bir arada. Her ay yeni bir hediye sunacak.',
      '${sign.nameTr} burcu için yıldızların parladığı bir yıl başlıyor. Şans, fırsat ve bereket enerjileri güçlü. Evren size "evet" diyor - siz de kendinize "evet" deyin.',
      'Bu yıl ${sign.nameTr} burcunun potansiyelini tam olarak ortaya koyacağı bir dönem. Ertelediğiniz hayalleri gerçekleştirin, korktuğunuz adımları atın. Evren arkanızda.',
      'Kozmik takvim bu yıl ${sign.nameTr} burcu için önemli sayfalar açıyor. Kariyer, aşk, sağlık ve ruhsal gelişim alanlarında kayda değer ilerlemeler mümkün.',
    ];
  }

  static List<String> _getYearlyLoveContent(ZodiacSign sign) {
    return [
      'Aşk hayatınızda bu yıl önemli dönüm noktaları var. Bekarlar için kadersel karşılaşmalar, çiftler için ilişkiyi derinleştirme fırsatları. Kalp çakranız yıl boyunca aktif.',
      'Romantik enerjiler yoğun bir yıl sizi bekliyor. İlişkilerde dönüşüm, yeni başlangıçlar ve derin bağlantılar temalı. Aşka açık olun.',
      'Bu yıl aşk, beklenmedik şekillerde hayatınıza girebilir. Eski kalıpları bırakın, yeni deneyimlere açık olun. Evrenin planına güvenin.',
      'Venüs bu yıl ${sign.nameTr} burcuna özel bir dans sergiliyor. Bekarlar için ruh eşi potansiyeli güçlü, çiftler için evlilik veya bebekhaberi gündemde olabilir.',
      'Aşk hayatınızda bu yıl köklü dönüşümler mümkün. İlişki statünüz değişebilir - bekarlar çift olabilir, çiftler yeni bir aşamaya geçebilir.',
      'Romantik alanda şanslı bir yıl sizi bekliyor. Evren aşk konusunda cömert davranıyor. Kalp kırıklıkları iyileşiyor, yeni kapılar açılıyor.',
      'Bu yıl ilişkilerde derin bağlantılar kurma zamanı. Yüzeysel ilişkiler dökülürken, gerçek, anlamlı bağlar güçleniyor. Kaliteli zaman için niceliği feda edin.',
      'Aşkta cesaret yılı. Duygularınızı ifade edin, risk alın, kalbinizin sesini dinleyin. Evren cesaretli aşıkları ödüllendiriyor.',
    ];
  }

  static List<String> _getYearlyCareerContent(ZodiacSign sign) {
    return [
      'Kariyer alanında bu yıl büyük adımlar atabilirsiniz. Profesyonel hedeflerinize ulaşmak için gerekli enerji ve fırsatlar mevcut. Vizyonunuza odaklanın.',
      'İş hayatınızda dönüşüm yılı. Yeni roller, sorumluluklar veya tamamen yeni bir kariyer yolu gündeme gelebilir. Değişime açık olun.',
      'Profesyonel başarı için bereketli bir yıl. Liderlik yetenekleriniz ön plana çıkıyor, fikirleriniz değer görüyor. Kendinizi gösterme zamanı.',
      'Kariyer basamaklarında hızlı yükseliş potansiyeli var. Terfi, zam, yeni pozisyonlar veya iş değişikliği gündemde olabilir. Fırsatları kaçırmayın.',
      'Bu yıl profesyonel alanda parlamak için ideal. Projeleriniz dikkat çekiyor, çabalarınız takdir görüyor. Görünürlüğünüzü artırın.',
      'İş dünyasında şansınız açık. Yeni ortaklıklar, anlaşmalar veya iş fırsatları kapınızı çalabilir. Networking\'e önem verin.',
      'Girişimcilik enerjisi güçlü bir yıl. Kendi işinizi kurma hayaliniz varsa, bu yıl harekete geçme zamanı. Evren cesur girişimcileri destekliyor.',
      'Kariyer hedeflerinize ulaşmak için gereken her şey bu yıl elinizin altında. Tek gereken odaklanmak ve kararlılıkla ilerlemek.',
    ];
  }

  static List<String> _getYearlyHealthContent(ZodiacSign sign) {
    return [
      'Sağlık alanında bu yıl farkındalık geliştirin. Bütünsel yaklaşımla beden, zihin ve ruh dengesini kurun. Önleyici sağlık önemli.',
      'Enerji seviyelerinizi optimize etmek için yaşam tarzı değişiklikleri yapın. Beslenme, egzersiz ve uyku düzeninizi gözden geçirin.',
      'Şifa enerjileri bu yıl güçlü. Eski sağlık sorunlarını çözme, yeni alışkanlıklar edinme ve genel iyilik halini yükseltme zamanı.',
    ];
  }

  static List<String> _getYearlyFinancialContent(ZodiacSign sign) {
    return [
      'Finansal açıdan bu yıl istikrar ve büyüme potansiyeli var. Akıllı yatırımlar, bilinçli harcamalar ve uzun vadeli planlama önemli.',
      'Maddi bolluk enerjisi güçleniyor. Yeni gelir kaynakları, beklenmedik kazançlar veya finansal fırsatlar gündeme gelebilir.',
      'Para ile ilişkinizi dönüştürme yılı. Bolluk bilincini geliştirin, kısıtlayıcı inançları bırakın ve bereketin akmasına izin verin.',
    ];
  }

  static List<String> _getYearlySpiritualContent(ZodiacSign sign) {
    return [
      'Ruhsal yolculuğunuzda bu yıl önemli ilerlemeler kaydedeceksiniz. Farkındalık derinleşiyor, sezgiler güçleniyor, evrenle bağlantı kuvvetleniyor.',
      'İç keşif yılı. Meditasyon, farkındalık pratikleri ve ruhsal çalışmalar için ideal bir dönem. Kendinizi tanıma yolculuğu derinleşiyor.',
      'Uyanış ve dönüşüm temaları güçlü. Eski kalıpları bırakma, yeni bilinç seviyelerine yükselme ve ruhsal olarak evrilme zamanı.',
    ];
  }

  static List<String> _getYearlyAffirmations(ZodiacSign sign) {
    return [
      'Bu yıl en yüksek potansiyelimi gerçekleştiriyorum.',
      'Evrenin bolluğu hayatımın her alanına akıyor.',
      'Her gün, her anlamda büyüyor ve gelişiyorum.',
      'Ruhsal yolculuğumda doğru zamanda doğru yerdeyim.',
      'Sevgi ve bereket beni her yerde takip ediyor.',
    ];
  }

  static List<String> _getYearlyThemes(ZodiacSign sign) {
    return [
      'Dönüşüm ve Yeniden Doğuş',
      'Kendini Gerçekleştirme',
      'Bolluk ve Bereket',
      'İlişkilerde Derinleşme',
      'Ruhsal Uyanış',
      'Cesaret ve Eylem',
      'Denge ve Harmoni',
      'Şifa ve Bütünleşme',
    ];
  }

  static List<String> _getMajorTransits(int year) {
    return [
      'Jüpiter\'in burç değişimi yılın ana teması. Şans ve genişleme enerjisi yeni alanlara kayıyor.',
      'Satürn\'ün hareketi sorumluluk ve olgunlaşma konularını vurguluyor.',
      'Tutulma ekseni ilişki ve kimlik temalarını aktive ediyor.',
      'Uranüs beklenmedik değişimler ve özgürlük arayışını tetikliyor.',
      'Neptün ruhsal derinlik ve hayal gücünü güçlendiriyor.',
    ];
  }
}
