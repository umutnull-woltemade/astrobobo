import '../models/reference_content.dart';

/// Comprehensive Astrology Glossary - 300+ terms
class GlossaryContent {
  static List<GlossaryEntry> getAllEntries() {
    return [
      ..._basicTerms,
      ..._planetTerms,
      ..._signTerms,
      ..._houseTerms,
      ..._aspectTerms,
      ..._techniqueTerms,
      ..._modernTerms,
      ..._planetInHouseTerms,
      ..._additionalTerms,
      ..._moreTerms,
      ..._esotericTerms,
      ..._psychologicalTerms,
      ..._predictiveTerms,
      ..._relationshipTerms,
      ..._extendedSignTerms,
      ..._advancedTechniques,
      ..._lunarTerms,
      ..._fixedStarsTerms,
      ..._mundaneTerms,
      ..._healthTerms,
      ..._financeTerms,
      ..._vedicExtraTerms,
      ..._asteroidExtras,
      ..._dreamSymbols,
      ..._chakraTerms,
      ..._meditationTerms,
      ..._crystalTerms,
      ..._ritualTerms,
      ..._psychologicalTerms2,
      ..._spiritualConcepts,
    ];
  }

  /// Gezegen-Ev kombinasyonu aramak için yardımcı metot
  static List<GlossaryEntry> searchPlanetInHouse(String query) {
    final normalizedQuery = query.toLowerCase().trim();
    return getAllEntries().where((entry) {
      if (entry.planetInHouse == null) return false;
      final planetInHouse = entry.planetInHouse!.toLowerCase();
      final termTr = entry.termTr.toLowerCase();
      return planetInHouse.contains(normalizedQuery) ||
          termTr.contains(normalizedQuery) ||
          entry.term.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  /// Kategori bazlı arama
  static List<GlossaryEntry> getByCategory(GlossaryCategory category) {
    return getAllEntries().where((e) => e.category == category).toList();
  }

  /// Terim sayısı
  static int get totalCount => getAllEntries().length;

  // ═══════════════════════════════════════════════════════════════
  // TEMEL KAVRAMLAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _basicTerms = [
    GlossaryEntry(
      term: 'Natal Chart',
      termTr: 'Doğum Haritası',
      hint: 'Kozmik kimlik kartın',
      definition:
          'Bir kişinin doğduğu anda gökyüzündeki gezegen konumlarını gösteren astrolojik harita. Kişilik, yetenekler ve yaşam yolculuğu hakkında bilgi verir.',
      deepExplanation:
          'Doğum haritası, evrenin o anki fotoğrafıdır. Antik astrologlar bunu "kozmik DNA" olarak tanımlar. Her gezegen, burç ve ev konumu, ruhun bu yaşamdaki amacını ve potansiyelini kodlar. Harita, determinizm değil, bir yol haritasıdır - özgür irade ile şekillendirilebilir.',
      example:
          'Doğum haritanızda Güneş Koç burcunda, 10. evde ise liderlik pozisyonlarına çekilirsiniz.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yükselen', 'Ev', 'Açı', 'Transit'],
      references: [
        GlossaryReference(
          title: 'The Inner Sky',
          author: 'Steven Forrest',
          type: 'book',
        ),
        GlossaryReference(
          title: 'Astrology: A Cosmic Science',
          author: 'Isabel Hickey',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Ascendant',
      termTr: 'Yükselen',
      hint: 'Dünyaya açılan kapın',
      definition:
          'Doğum anında doğu ufkunda yükselen burç. Dış görünüşünüzü, ilk izleniminizi ve dünyaya nasıl yaklaştığınızı temsil eder.',
      deepExplanation:
          'Yükselen burç, ruhun bedenle buluştuğu noktadır. Ezoterik gelenekte "maske" olarak bilinir, ancak bu maske zamanla gerçek yüzümüze dönüşür. Yükselen, fiziksel görünümü, vücut dilini ve hayata karşı temel tutumu belirler. Ayrıca sağlık eğilimlerini de gösterir.',
      example:
          'Aslan yükseleni olan biri karizmatik görünür, dikkat çeker ve güçlü bir varlık hissi yaratır.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Doğum Haritası', '1. Ev', 'Descendant', 'MC'],
      references: [
        GlossaryReference(
          title: 'The Twelve Houses',
          author: 'Howard Sasportas',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Descendant',
      termTr: 'Alçalan',
      hint: 'İlişkilerdeki ayna',
      definition:
          'Yükselenin tam karşısındaki nokta, 7. evin başlangıcı. İlişkilerde aradığımız özellikleri ve partnerlere yansıttığımız gölge yanlarımızı gösterir.',
      deepExplanation:
          'Descendant, Jung psikolojisindeki "gölge" kavramıyla doğrudan bağlantılıdır. Kendimizde kabul etmediğimiz özellikleri başkalarında ararız. Bu projeksiyon mekanizması ilişkilerin temel dinamiğini oluşturur.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yükselen', '7. Ev', 'Sinastri'],
    ),
    GlossaryEntry(
      term: 'Midheaven',
      termTr: 'Gökyüzü Ortası (MC)',
      hint: 'Kariyer ve kamusal imaj',
      definition:
          'Haritanın en üst noktası, 10. evin başlangıcı. Kariyer yolunuzu, toplumsal konumunuzu ve hayatta neyi başarmak istediğinizi gösterir.',
      deepExplanation:
          'MC (Medium Coeli), ruhun dünyaya bırakmak istediği mirası temsil eder. Sadece meslek değil, nasıl hatırlanmak istediğimizi de gösterir. Bu nokta, anne figürü ve otorite ile ilişkimizi de yansıtır.',
      category: GlossaryCategory.basics,
      relatedTerms: ['10. Ev', 'IC', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'IC',
      termTr: 'Gökyüzü Dibi (IC)',
      hint: 'Kökler ve iç dünya',
      definition:
          'Haritanın en alt noktası, 4. evin başlangıcı. Aile kökenlerinizi, iç dünyanızı, ev yaşamınızı ve duygusal temellerinizi gösterir.',
      deepExplanation:
          'Imum Coeli (IC), ruhun en derin katmanlarını ve atalardan gelen mirası temsil eder. Bilinçaltı kalıplar, çocukluk deneyimleri ve "eve dönüş" hissi burada kodlanmıştır.',
      category: GlossaryCategory.basics,
      relatedTerms: ['4. Ev', 'MC', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Transit',
      termTr: 'Transit',
      hint: 'Güncel kozmik hava durumu',
      definition:
          'Şu anki gezegen konumlarının doğum haritanızdaki gezegen konumlarıyla etkileşimi. Güncel astrolojik etkileri ve zamanlamayı anlamak için kullanılır.',
      deepExplanation:
          'Transitler, evrenin bize gönderdiği mesajlardır. Her transit, bir ders, bir fırsat veya bir test getirir. Dış gezegenler (Satürn, Uranüs, Neptün, Pluto) yıllar süren dönüşümleri, iç gezegenler ise günlük/haftalık etkileri tetikler.',
      example:
          'Satürn transiti 7. evinize geçtiğinde ilişkilerde ciddi kararlar ve olgunlaşma gündeme gelir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Progresyon', 'Açı', 'Gezegen Dönüşleri'],
      references: [
        GlossaryReference(
          title: 'Planets in Transit',
          author: 'Robert Hand',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Retrograde',
      termTr: 'Retro',
      hint: 'Geriye bakış dönemi',
      definition:
          'Bir gezegenin Dünya\'dan bakıldığında geriye doğru hareket ediyor gibi görünmesi. Bu dönemlerde o gezegenin temsil ettiği konularda içe dönüş ve yeniden değerlendirme yaşanır.',
      deepExplanation:
          'Retro dönemleri aslında optik bir yanılsamadır, ancak astrolojik etkisi gerçektir. Bu dönemler, o gezegenin enerjisinin içselleştirildiği zamanlardır. Merkür retrosu iletişimi, Venüs retrosu ilişkileri, Mars retrosu eylemi yeniden gözden geçirmeye davet eder.',
      example:
          'Merkür retrosu sırasında eski arkadaşlar arar, kayıp eşyalar bulunur, iletişim aksaklıkları yaşanabilir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Gezegen', 'Transit', 'Gölge Dönemi'],
    ),
    GlossaryEntry(
      term: 'Orb',
      termTr: 'Orb (Etki Alanı)',
      hint: 'Açının tolerans payı',
      definition:
          'Bir açının tam derecesinden ne kadar sapma gösterebileceğini belirten tolerans değeri. Örneğin 8 derece orb ile 82-98 derece arası kare açı sayılabilir.',
      deepExplanation:
          'Orb ne kadar dar tutulursa açı o kadar güçlü kabul edilir. Geleneksel astrolojide ışıklar (Güneş-Ay) için geniş orb, dış gezegenler için dar orb kullanılır.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Açı', 'Kavuşum', 'Kare'],
    ),
    GlossaryEntry(
      term: 'Cusp',
      termTr: 'Sınır/Başlangıç',
      hint: 'Ev veya burç geçiş noktası',
      definition:
          'Bir evin veya burcun başladığı derece. Ev sınırları harita sistemine göre değişir.',
      deepExplanation:
          'Cusp enerjisi, iki burcun karışımını taşır. Örneğin Koç-Boğa cuspında doğanlar her iki burcun özelliklerini gösterebilir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Ev', 'Burç', 'Derece'],
    ),
    GlossaryEntry(
      term: 'Element',
      termTr: 'Element',
      hint: 'Dört temel enerji',
      definition:
          'Burçları gruplandıran dört temel enerji: Ateş (Koç, Aslan, Yay), Toprak (Boğa, Başak, Oğlak), Hava (İkizler, Terazi, Kova), Su (Yengeç, Akrep, Balık).',
      deepExplanation:
          'Elementler, antik Yunan felsefesinden gelir. Ateş yaratıcılık ve eylemi, Toprak pratikliği ve istikrarı, Hava düşünce ve iletişimi, Su duygu ve sezgiyi temsil eder. Haritadaki element dengesi kişiliğin temel yapısını gösterir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Modalite', 'Ateş', 'Toprak', 'Hava', 'Su'],
    ),
    GlossaryEntry(
      term: 'Modality',
      termTr: 'Modalite',
      hint: 'Üç hareket biçimi',
      definition:
          'Burçları hareket tarzlarına göre gruplandırma: Öncü (başlatıcı), Sabit (sürdürücü), Değişken (uyum sağlayıcı).',
      deepExplanation:
          'Öncü burçlar (Koç, Yengeç, Terazi, Oğlak) mevsimleri başlatır ve liderlik eder. Sabit burçlar (Boğa, Aslan, Akrep, Kova) istikrar sağlar. Değişken burçlar (İkizler, Başak, Yay, Balık) geçişleri yönetir ve esneklik gösterir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Öncü', 'Sabit', 'Değişken'],
    ),
    GlossaryEntry(
      term: 'Dignity',
      termTr: 'Onur/Güç',
      hint: 'Gezegenin burçtaki gücü',
      definition:
          'Bir gezegenin bulunduğu burçta ne kadar rahat ve güçlü olduğunu gösteren sistem. Yönetim, yücelme, sürgün ve düşüş olmak üzere dört seviye vardır.',
      deepExplanation:
          'Yönetimde gezegen kendi evindedir, en güçlüdür. Yücelmede misafir olarak ağırlanır. Sürgünde karşı burçtadır, enerjisi zayıflar. Düşüşte en zor konumdadır ama derin dersler öğretir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yönetici Gezegen', 'Yücelme', 'Sürgün', 'Düşüş'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // GEZEGENLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _planetTerms = [
    GlossaryEntry(
      term: 'Sun',
      termTr: 'Güneş',
      hint: 'Özün ve yaşam gücün',
      definition:
          'Astrolojide benlik, ego, yaşam gücü ve temel kimliği temsil eder. Güneş burcunuz, en temel karakteristiklerinizi ve yaşam amacınızı gösterir.',
      deepExplanation:
          'Güneş, ruhun merkezidir. Hint astrolojisinde Atman (öz benlik) ile ilişkilendirilir. Baba figürünü, otoriteyi ve yaratıcı ifadeyi yönetir. Güneş\'in evi, enerjimizi en çok yoğunlaştırdığımız yaşam alanını gösterir.',
      example:
          'Güneş 5. evde sanatsal ifade ve çocuklarla ilişkide parlamayı gösterir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Ay', 'Yükselen', 'Aslan'],
      signRuler: 'Aslan',
      references: [
        GlossaryReference(
          title: 'The Luminaries',
          author: 'Liz Greene',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Moon',
      termTr: 'Ay',
      hint: 'Duyguların ve içgüdülerin',
      definition:
          'Duygusal doğanızı, içgüdülerinizi, alışkanlıklarınızı ve iç dünyanızı temsil eder. Ay burcunuz, duygusal ihtiyaçlarınızı ve tepkilerinizi gösterir.',
      deepExplanation:
          'Ay, ruhun duygusal hafızasıdır. Anne arketipi, beslenme, güvenlik ve geçmişle bağı temsil eder. Ay her 2.5 günde burç değiştirir, bu da duygusal ritimleri etkiler. Dolunay ve yeniay dönemleri önemli dönüm noktalarıdır.',
      example: 'Ay Akrep\'te derin, yoğun duygular ve sezgisel algı gösterir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Güneş', 'Yengeç', 'Ay Düğümleri'],
      signRuler: 'Yengeç',
    ),
    GlossaryEntry(
      term: 'Mercury',
      termTr: 'Merkür',
      hint: 'Zihin ve iletişim',
      definition:
          'İletişim, düşünme biçimi, öğrenme, yazma ve kısa mesafe seyahatleri yönetir. Merkür konumunuz nasıl düşündüğünüzü ve iletişim kurduğunuzu gösterir.',
      deepExplanation:
          'Merkür, tanrıların habercisidir. Hermes arketipi - tüccar, hırsız, şifacı ve rehber. Merkür retrosu yılda 3-4 kez gerçekleşir ve bu dönemler iç iletişim için idealdir.',
      example:
          'Merkür Yay\'da felsefi düşünce, Başak\'ta analitik zeka güçlenir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['İkizler', 'Başak', 'Retro'],
      signRuler: 'İkizler, Başak',
    ),
    GlossaryEntry(
      term: 'Venus',
      termTr: 'Venüs',
      hint: 'Aşk, güzellik ve değerler',
      definition:
          'Aşk, güzellik, sanat, para, zevkler ve değerler gezegenidir. Venüs konumunuz neyi çekici bulduğunuzu ve nasıl sevdiğinizi gösterir.',
      deepExplanation:
          'Venüs, Afrodit arketipidir - aşk tanrıçası. Çekim yasasını, estetik algıyı ve ilişki dinamiklerini yönetir. 2. evde maddi değerleri, 7. evde romantik ilişkileri etkiler.',
      example:
          'Venüs Boğa\'da duyusal zevkler, Kova\'da sıradışı ilişki biçimleri tercih edilir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Mars', 'Boğa', 'Terazi', '7. Ev'],
      signRuler: 'Boğa, Terazi',
    ),
    GlossaryEntry(
      term: 'Mars',
      termTr: 'Mars',
      hint: 'Eylem, tutku ve enerji',
      definition:
          'Eylem, enerji, tutku, saldırganlık, cinsel dürtü ve fiziksel güç gezegenidir. Mars konumunuz nasıl motive olduğunuzu ve çatışmalara nasıl yaklaştığınızı gösterir.',
      deepExplanation:
          'Mars, savaşçı arketipidir. Ares/Mars - cesaret, rekabet ve hayatta kalma içgüdüsü. Fiziksel enerjiyi, atletik yeteneği ve girişimciliği yönetir. Mars\'ın evi, en çok enerji harcadığımız alanı gösterir.',
      example:
          'Mars Koç\'ta cesur ve doğrudan, Terazi\'de diplomatik ve işbirlikçidir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Venüs', 'Koç', 'Akrep'],
      signRuler: 'Koç (geleneksel: Akrep)',
    ),
    GlossaryEntry(
      term: 'Jupiter',
      termTr: 'Jüpiter',
      hint: 'Şans, büyüme ve bilgelik',
      definition:
          'Şans, genişleme, büyüme, felsefe, yüksek öğrenim ve uzak seyahatler gezegenidir. Jüpiter konumunuz nerede şanslı olduğunuzu gösterir.',
      deepExplanation:
          'Jüpiter, Zeus/Guru arketipidir - en büyük gezegen, en büyük vaatler. Bereket, iyimserlik ve anlam arayışını yönetir. Her burçta yaklaşık 1 yıl kalır. Jüpiter dönüşü (12 yılda bir) önemli büyüme dönemlerini işaret eder.',
      example:
          'Jüpiter 9. evde yabancı kültürler ve felsefe konusunda şans getirir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Satürn', 'Yay', 'Balık', '9. Ev'],
      signRuler: 'Yay (geleneksel: Balık)',
    ),
    GlossaryEntry(
      term: 'Saturn',
      termTr: 'Satürn',
      hint: 'Yapı, disiplin ve zaman',
      definition:
          'Yapı, disiplin, sorumluluk, kısıtlamalar, olgunluk ve zaman gezegenidir. Satürn konumunuz zorluklarla karşılaştığınız ve ders aldığınız alanları gösterir.',
      deepExplanation:
          'Satürn, Kronos arketipidir - zamanın efendisi. Karma öğretmen olarak bilinir. Korkularımızı, sınırlarımızı ve ustalık gerektiren alanları gösterir. Satürn dönüşü (29.5 yılda bir) büyük olgunlaşma dönemleridir.',
      example:
          'Satürn 10. evde kariyer başarısı için uzun vadeli çaba gerektirir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Jüpiter', 'Oğlak', 'Kova', 'Satürn Dönüşü'],
      signRuler: 'Oğlak (geleneksel: Kova)',
      references: [
        GlossaryReference(
          title: 'Saturn: A New Look at an Old Devil',
          author: 'Liz Greene',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Uranus',
      termTr: 'Uranüs',
      hint: 'Devrim, özgürlük ve değişim',
      definition:
          'Ani değişim, devrim, özgünlük, teknoloji ve beklenmedik olaylar gezegenidir. Uranüs, gelenekleri yıkar ve yeniliği getirir.',
      deepExplanation:
          'Uranüs, Prometheus arketipidir - tanrılardan ateşi çalan isyankar. 1781\'de keşfedildi, Amerikan ve Fransız devrimlerinin zamanı. Her burçta 7 yıl kalır, nesil özelliklerini belirler.',
      example:
          'Uranüs transiti 1. eve geçtiğinde kimlik ve görünüşte radikal değişimler olabilir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Kova', 'Neptün', 'Pluto'],
      signRuler: 'Kova',
    ),
    GlossaryEntry(
      term: 'Neptune',
      termTr: 'Neptün',
      hint: 'Rüyalar, ilham ve yanılsama',
      definition:
          'Rüyalar, hayal gücü, spiritüellik, sanat, yanılsama ve kaçış gezegenidir. Neptün, maddi dünyanın ötesine işaret eder.',
      deepExplanation:
          'Neptün, Poseidon arketipidir - okyanusun derinlikleri, bilinçaltının sırları. 1846\'da keşfedildi. Her burçta 14 yıl kalır. Mistisizm, bağımlılık ve kurban/kurtarıcı dinamiklerini yönetir.',
      example:
          'Neptün 12. evde güçlü spiritüel bağlantı ama sınır sorunları olabilir.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Balık', 'Uranüs', 'Pluto', '12. Ev'],
      signRuler: 'Balık',
    ),
    GlossaryEntry(
      term: 'Pluto',
      termTr: 'Pluto',
      hint: 'Dönüşüm, güç ve yeniden doğuş',
      definition:
          'Derin dönüşüm, ölüm ve yeniden doğuş, güç dinamikleri, bilinçaltı ve tabular gezegenidir.',
      deepExplanation:
          'Pluto, Hades arketipidir - yeraltı dünyasının efendisi. 1930\'da keşfedildi, atom çağının başlangıcı. Her burçta 12-30 yıl kalır. Gölge çalışması, psikoterapi ve radikal dönüşümü yönetir.',
      example: 'Pluto Güneş\'e transit yaptığında ego ölür ve yeniden doğar.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Akrep', '8. Ev', 'Dönüşüm'],
      signRuler: 'Akrep',
      references: [
        GlossaryReference(
          title: 'Pluto: The Evolutionary Journey of the Soul',
          author: 'Jeff Green',
          type: 'book',
        ),
      ],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // BURÇLAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _signTerms = [
    GlossaryEntry(
      term: 'Aries',
      termTr: 'Koç',
      hint: 'Öncü ateş - başlangıçlar',
      definition:
          'Zodyak\'ın ilk burcu. Cesaret, enerji, liderlik ve yeni başlangıçları temsil eder. Yöneticisi Mars\'tır.',
      deepExplanation:
          'Koç, yaşam gücünün ilk patlamasıdır. Bahar ekinoksunda başlar, yenilenmeyi simgeler. Arketip olarak savaşçı, öncü ve kahramandır. Gölge yönü sabırsızlık ve bencilliktir.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Mars', 'Ateş', 'Öncü'],
      signRuler: 'Mars',
    ),
    GlossaryEntry(
      term: 'Taurus',
      termTr: 'Boğa',
      hint: 'Sabit toprak - istikrar',
      definition:
          'İstikrar, güvenlik, konfor, doğa ve maddi değerleri temsil eder. Yöneticisi Venüs\'tür.',
      deepExplanation:
          'Boğa, yaşam gücünün somutlaşmasıdır. Beş duyuyla deneyimlenen dünya, sahip olma ve inşa etme. Arketip olarak çiftçi ve sanatçıdır. Gölge yönü inatçılık ve materyalizmdir.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Venüs', 'Toprak', 'Sabit'],
      signRuler: 'Venüs',
    ),
    GlossaryEntry(
      term: 'Gemini',
      termTr: 'İkizler',
      hint: 'Değişken hava - iletişim',
      definition:
          'İletişim, merak, çok yönlülük ve zihinsel aktiviteyi temsil eder. Yöneticisi Merkür\'dür.',
      deepExplanation:
          'İkizler, zihnin keşif gezisidir. Bilgi toplama, bağlantı kurma ve fikir alışverişi. Arketip olarak habercı ve hikaye anlatıcısıdır. Gölge yönü yüzeysellik ve tutarsızlıktır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Merkür', 'Hava', 'Değişken'],
      signRuler: 'Merkür',
    ),
    GlossaryEntry(
      term: 'Cancer',
      termTr: 'Yengeç',
      hint: 'Öncü su - duygusal güvenlik',
      definition:
          'Duygusallık, koruma, aile ve sezgiyi temsil eder. Yöneticisi Ay\'dır.',
      deepExplanation:
          'Yengeç, ruhun evidir. Beslenme, ait olma ve duygusal hafıza. Arketip olarak anne ve koruyucudur. Gölge yönü aşırı korumacılık ve geçmişe takılmadır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Ay', 'Su', 'Öncü'],
      signRuler: 'Ay',
    ),
    GlossaryEntry(
      term: 'Leo',
      termTr: 'Aslan',
      hint: 'Sabit ateş - yaratıcı ifade',
      definition:
          'Yaratıcılık, liderlik, cömertlik ve kendini ifadeyi temsil eder. Yöneticisi Güneş\'tir.',
      deepExplanation:
          'Aslan, ruhun sahnesidir. Yaratıcı potansiyelin gösterilmesi, alkış alma ve sevgi verme. Arketip olarak kral/kraliçe ve performansçıdır. Gölge yönü kibir ve dikkat bağımlılığıdır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Güneş', 'Ateş', 'Sabit'],
      signRuler: 'Güneş',
    ),
    GlossaryEntry(
      term: 'Virgo',
      termTr: 'Başak',
      hint: 'Değişken toprak - hizmet',
      definition:
          'Analiz, hizmet, mükemmeliyetçilik ve pratikliği temsil eder. Yöneticisi Merkür\'dür.',
      deepExplanation:
          'Başak, ustalığın yoludur. Ayrıntılara dikkat, iyileştirme ve arındırma. Arketip olarak şifacı ve zanaatkardır. Gölge yönü aşırı eleştiri ve kaygıdır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Merkür', 'Toprak', 'Değişken'],
      signRuler: 'Merkür',
    ),
    GlossaryEntry(
      term: 'Libra',
      termTr: 'Terazi',
      hint: 'Öncü hava - denge ve ilişkiler',
      definition:
          'Denge, uyum, ilişkiler ve adaleti temsil eder. Yöneticisi Venüs\'tür.',
      deepExplanation:
          'Terazi, ilişkinin aynasıdır. Başkasıyla bağlantı kurarak kendini tanıma. Arketip olarak diplomat ve arabulucudur. Gölge yönü kararsızlık ve bağımlılıktır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Venüs', 'Hava', 'Öncü'],
      signRuler: 'Venüs',
    ),
    GlossaryEntry(
      term: 'Scorpio',
      termTr: 'Akrep',
      hint: 'Sabit su - dönüşüm',
      definition:
          'Yoğunluk, dönüşüm, tutku ve gizemleri temsil eder. Yöneticisi Pluto (geleneksel: Mars).',
      deepExplanation:
          'Akrep, ölüm ve yeniden doğuşun simgesidir. Gölgeyle yüzleşme, tabular ve derin bağlar. Arketip olarak şaman ve dedektiftir. Gölge yönü obsesyon ve intikamcılıktır.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Pluto', 'Mars', 'Su', 'Sabit'],
      signRuler: 'Pluto (Mars)',
    ),
    GlossaryEntry(
      term: 'Sagittarius',
      termTr: 'Yay',
      hint: 'Değişken ateş - macera ve anlam',
      definition:
          'Macera, felsefe, özgürlük ve genişlemeyi temsil eder. Yöneticisi Jüpiter\'dir.',
      deepExplanation:
          'Yay, ufukların ötesidir. Anlam arayışı, yüksek öğrenim ve evrensel gerçekler. Arketip olarak filozof ve gezgindir. Gölge yönü aşırı iyimserlik ve vaaz vermedir.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Jüpiter', 'Ateş', 'Değişken'],
      signRuler: 'Jüpiter',
    ),
    GlossaryEntry(
      term: 'Capricorn',
      termTr: 'Oğlak',
      hint: 'Öncü toprak - hırs ve yapı',
      definition:
          'Hırs, disiplin, sorumluluk ve toplumsal başarıyı temsil eder. Yöneticisi Satürn\'dür.',
      deepExplanation:
          'Oğlak, dağın zirvesidir. Uzun vadeli hedefler, otorite ve miras. Arketip olarak bilge yaşlı ve yöneticidir. Gölge yönü işkoliklik ve duygusal mesafedir.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Satürn', 'Toprak', 'Öncü'],
      signRuler: 'Satürn',
    ),
    GlossaryEntry(
      term: 'Aquarius',
      termTr: 'Kova',
      hint: 'Sabit hava - yenilik ve insancıllık',
      definition:
          'Yenilik, insancıllık, bağımsızlık ve toplumsal idealleri temsil eder. Yöneticisi Uranüs (geleneksel: Satürn).',
      deepExplanation:
          'Kova, geleceğin vizyonudur. Kolektif bilinç, teknoloji ve reform. Arketip olarak devrimci ve mucittir. Gölge yönü duygusal kopukluk ve diktatörlüktür.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Uranüs', 'Satürn', 'Hava', 'Sabit'],
      signRuler: 'Uranüs (Satürn)',
    ),
    GlossaryEntry(
      term: 'Pisces',
      termTr: 'Balık',
      hint: 'Değişken su - spiritüellik ve şefkat',
      definition:
          'Sezgi, şefkat, spiritüellik ve hayali temsil eder. Yöneticisi Neptün (geleneksel: Jüpiter).',
      deepExplanation:
          'Balık, evrensel okyanustur. Sınırların erimesi, mistisizm ve koşulsuz sevgi. Arketip olarak şair ve mistiktir. Gölge yönü kaçış ve kurban psikolojisidir.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Neptün', 'Jüpiter', 'Su', 'Değişken'],
      signRuler: 'Neptün (Jüpiter)',
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // EVLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _houseTerms = [
    GlossaryEntry(
      term: 'First House',
      termTr: '1. Ev',
      hint: 'Benlik ve fiziksel görünüm',
      definition:
          'Benlik evi. Fiziksel görünümünüzü, kişiliğinizi, ilk izleniminizi ve dünyaya nasıl yaklaştığınızı temsil eder.',
      deepExplanation:
          'Yükselen burcun bulunduğu ev. Bedenin, kimliğin ve yaşam enerjisinin evidir. Buradaki gezegenler kişiliğin çekirdeğini oluşturur.',
      example: 'Mars 1. evde güçlü fiziksel enerji ve cesur kişilik gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Yükselen', 'Koç', 'Mars'],
    ),
    GlossaryEntry(
      term: 'Second House',
      termTr: '2. Ev',
      hint: 'Para, değerler ve kaynaklar',
      definition:
          'Maddi kaynaklar, para, mülkler, öz değer ve yetenekleri temsil eder.',
      deepExplanation:
          'Ne kazandığımız ve nelere değer verdiğimiz. Finansal güvenlik, doğal yetenekler ve beş duyu deneyimleri.',
      example: 'Jüpiter 2. evde finansal bolluk potansiyeli gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Boğa', 'Venüs', 'Para'],
    ),
    GlossaryEntry(
      term: 'Third House',
      termTr: '3. Ev',
      hint: 'İletişim ve yakın çevre',
      definition:
          'İletişim, kardeşler, kısa seyahatler, ilk öğrenim ve yakın çevreyi temsil eder.',
      deepExplanation:
          'Zihinsel aktivite, öğrenme stili ve günlük iletişim. Komşuluk ilişkileri ve erken eğitim deneyimleri.',
      example: 'Merkür 3. evde güçlü yazarlık ve iletişim becerisi gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['İkizler', 'Merkür', 'Kardeşler'],
    ),
    GlossaryEntry(
      term: 'Fourth House',
      termTr: '4. Ev',
      hint: 'Ev, aile ve kökler',
      definition:
          'Ev yaşamı, aile kökleri, anne, iç dünya ve yaşlılık dönemini temsil eder.',
      deepExplanation:
          'IC noktasının bulunduğu ev. Duygusal temeller, atalardan gelen miras ve güvenlik hissi.',
      example: 'Ay 4. evde güçlü aile bağları ve ev sevgisi gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Yengeç', 'Ay', 'IC', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Fifth House',
      termTr: '5. Ev',
      hint: 'Yaratıcılık, aşk ve eğlence',
      definition:
          'Yaratıcılık, romantik aşk, çocuklar, eğlence, hobi ve kendini ifadeyi temsil eder.',
      deepExplanation:
          'Kalbin evi, neşe ve oyun. Yaratıcı projeler, flört ve spekülasyon. Risk alma ve dramatik ifade.',
      example: 'Venüs 5. evde sanatsal yetenek ve romantik doğa gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Aslan', 'Güneş', 'Çocuklar'],
    ),
    GlossaryEntry(
      term: 'Sixth House',
      termTr: '6. Ev',
      hint: 'Sağlık, iş ve günlük rutinler',
      definition:
          'Sağlık, günlük çalışma, rutinler, hizmet ve küçük hayvanları temsil eder.',
      deepExplanation:
          'Beden-zihin bağlantısı, iş ahlakı ve mükemmelleştirme. Astrolojide "düşme" evi - ego\'nun erimesi ve hizmete adanma.',
      example: 'Başak etkisi güçlü biri 6. evde detaylara dikkat eder.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Başak', 'Merkür', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Seventh House',
      termTr: '7. Ev',
      hint: 'Ortaklıklar ve evlilik',
      definition:
          'Romantik ilişkiler, evlilik, iş ortaklıkları ve açık düşmanları temsil eder.',
      deepExplanation:
          'Descendant\'ın bulunduğu ev. Ayna olarak başkaları - kendimizi ilişkiler aracılığıyla tanırız.',
      example:
          'Satürn 7. evde ciddi, uzun süreli ilişkiler ve geç evlilik gösterebilir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Terazi', 'Venüs', 'Evlilik', 'Descendant'],
    ),
    GlossaryEntry(
      term: 'Eighth House',
      termTr: '8. Ev',
      hint: 'Dönüşüm, paylaşılan kaynaklar',
      definition:
          'Ölüm, dönüşüm, cinsellik, miras, vergiler ve başkalarının kaynaklarını temsil eder.',
      deepExplanation:
          'Gizem evi - tabular, psikolojik derinlik ve güç dinamikleri. Okült ilgi, kriz anları ve yeniden doğuş.',
      example: 'Pluto 8. evde derin dönüşümler ve psikolojik güç gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Akrep', 'Pluto', 'Miras'],
    ),
    GlossaryEntry(
      term: 'Ninth House',
      termTr: '9. Ev',
      hint: 'Felsefe, uzak yerler ve yüksek öğrenim',
      definition:
          'Yüksek öğrenim, felsefe, din, hukuk, yayıncılık ve uzak seyahatleri temsil eder.',
      deepExplanation:
          'Anlam arayışı evi. Evrensel gerçekler, guru figürü ve dünya görüşü. Kültürel genişleme ve entelektüel macera.',
      example: 'Jüpiter 9. evde akademik başarı ve seyahat şansı gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Yay', 'Jüpiter', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Tenth House',
      termTr: '10. Ev',
      hint: 'Kariyer ve toplumsal konum',
      definition:
          'Kariyer, toplumsal statü, baba, otorite ve yaşamdaki başarıları temsil eder.',
      deepExplanation:
          'MC\'nin bulunduğu ev. Kamusal imaj, profesyonel hedefler ve miras. Topluma katkımız ve nasıl hatırlanacağımız.',
      example: 'Güneş 10. evde liderlik rolü ve kamusal tanınma gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Oğlak', 'Satürn', 'MC', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Eleventh House',
      termTr: '11. Ev',
      hint: 'Arkadaşlar, gruplar ve idealler',
      definition:
          'Arkadaşlıklar, gruplar, idealler, umutlar ve insani hedefleri temsil eder.',
      deepExplanation:
          'Kolektif bilinç evi. Sosyal ağlar, reform hareketleri ve geleceğe yönelik vizyonlar. Bireyselliğin ötesinde.',
      example:
          'Uranüs 11. evde sıradışı arkadaşlıklar ve reformcu gruplar gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Kova', 'Uranüs', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Twelfth House',
      termTr: '12. Ev',
      hint: 'Bilinçaltı, izolasyon ve spiritüellik',
      definition:
          'Bilinçaltı, izolasyon, kurumlar, gizli düşmanlar, karma ve spiritüelliği temsil eder.',
      deepExplanation:
          'Gizem evi - görünmeyenler alemi. Meditasyon, rüyalar ve önceki yaşam anıları. Kayıp ve fedakarlık, ama aynı zamanda kozmik birlik.',
      example: 'Neptün 12. evde güçlü spiritüel bağlantı ve sezgi gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Balık', 'Neptün', 'Karma'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // AÇILAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _aspectTerms = [
    GlossaryEntry(
      term: 'Conjunction',
      termTr: 'Kavuşum',
      hint: 'Enerjilerin birleşimi (0°)',
      definition:
          'İki gezegen aynı derecede veya çok yakın olduğunda oluşur. Enerjiler birleşir ve yoğunlaşır.',
      deepExplanation:
          'En güçlü açı. İki gezegenin enerjileri kaynaşır, ayırt edilemez hale gelir. Yeni döngülerin başlangıcı. Olumlu veya olumsuz olması gezegenlere bağlıdır.',
      example:
          'Güneş-Ay kavuşumu (Yeni Ay) yeni başlangıçlar için güçlü bir zamandır.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Karşıtlık', 'Yeni Ay'],
    ),
    GlossaryEntry(
      term: 'Opposition',
      termTr: 'Karşıtlık',
      hint: 'Gerilim ve denge (180°)',
      definition:
          'İki gezegen 180° açı yaptığında oluşur. Gerilim ve denge arayışını temsil eder.',
      deepExplanation:
          'Farkındalık açısı. İki zıt kutbun birbirini tamamlaması gerekir. Projeksiyon riski - kendi içimizde reddettiğimizi başkalarına yansıtırız.',
      example:
          'Güneş-Ay karşıtlığı (Dolunay) duygusal farkındalık ve tamamlanma zamanıdır.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Kavuşum', 'Dolunay'],
    ),
    GlossaryEntry(
      term: 'Trine',
      termTr: 'Üçgen',
      hint: 'Uyum ve akış (120°)',
      definition:
          'İki gezegen 120° açı yaptığında oluşur. Uyum, akış ve doğal yetenekleri gösterir.',
      deepExplanation:
          'En olumlu açı. Aynı element içinde oluşur (ateş-ateş, su-su). Doğal yetenekler ve kolaylık. Dikkat: Tembellik riski - çaba göstermeden verilen hediyeler.',
      example: 'Venüs-Jüpiter üçgeni aşk ve bolluk konularında şans getirir.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Altıgen', 'Element'],
    ),
    GlossaryEntry(
      term: 'Square',
      termTr: 'Kare',
      hint: 'Zorluk ve büyüme (90°)',
      definition:
          'İki gezegen 90° açı yaptığında oluşur. Gerilim, zorluk ve büyüme potansiyeli taşır.',
      deepExplanation:
          'Dinamik gerilim açısı. Aynı modalite içinde oluşur (öncü-öncü, sabit-sabit). Çatışma yaratır ama aynı zamanda harekete geçirir. Başarı için çaba gerekir.',
      example:
          'Mars-Satürn karesi engellenmiş enerji ve sabır dersleri getirebilir.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Karşıtlık', 'T-Kare'],
    ),
    GlossaryEntry(
      term: 'Sextile',
      termTr: 'Altıgen',
      hint: 'Fırsat ve işbirliği (60°)',
      definition:
          'İki gezegen 60° açı yaptığında oluşur. Fırsatlar, işbirliği ve pozitif potansiyel sunar.',
      deepExplanation:
          'Uyumlu element çiftleri arasında (ateş-hava, toprak-su) oluşur. Üçgenden daha az güçlü ama daha fazla çaba gerektirir - fırsatı değerlendirmek size kalmış.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Üçgen', 'Fırsat'],
    ),
    GlossaryEntry(
      term: 'Quincunx',
      termTr: 'Quincunx (Ayarsız)',
      hint: 'Uyumsuzluk ve ayarlama (150°)',
      definition:
          '150° açı. İki gezegen arasında doğal bağlantı yoktur, sürekli ayarlama gerektirir.',
      deepExplanation:
          'En kafa karıştırıcı açı. İki gezegen birbirini anlamaz, ortak noktaları yoktur. Sağlık sorunları ve sürekli adaptasyon. Ancak ustalaşıldığında benzersiz beceriler geliştirir.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Yod', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Grand Trine',
      termTr: 'Büyük Üçgen',
      hint: 'Üç gezegenin uyumu',
      definition:
          'Üç gezegen birbirleriyle 120° açı yaparak eşkenar üçgen oluşturur. Güçlü doğal yetenekler.',
      deepExplanation:
          'Aynı element içinde üç gezegen. Korunaklı enerji döngüsü. Büyük yetenek ama pasiflik riski - dışarı açılmak için diğer açılara ihtiyaç duyar.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Üçgen', 'Element'],
    ),
    GlossaryEntry(
      term: 'T-Square',
      termTr: 'T-Kare',
      hint: 'Dinamik gerilim üçgeni',
      definition:
          'İki gezegen karşıtlık yaparken, üçüncü gezegen ikisine de kare yapar. Yoğun enerji ve motivasyon.',
      deepExplanation:
          'Kare enerjisinin yoğunlaşmış hali. "Odak noktası" gezegen, gerilimi çözmek için anahtar. Başarılı insanların haritalarında sık görülür - zorluk motivasyon yaratır.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Kare', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Yod',
      termTr: 'Yod (Tanrı Parmağı)',
      hint: 'Kader noktası',
      definition:
          'İki gezegen altıgen yaparken, üçüncü gezegen ikisine de quincunx yapar. Özel bir misyonu gösterir.',
      deepExplanation:
          'Nadir bulunan, güçlü karmik yapılandırma. "Tanrı\'nın parmağı" anlamına gelir. Kaçınılmaz bir kader hissi, özel bir yaşam amacı. Tepe noktasındaki gezegen kilit rol oynar.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Quincunx', 'Altıgen', 'Kader'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // TEKNİKLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _techniqueTerms = [
    GlossaryEntry(
      term: 'Synastry',
      termTr: 'Sinastri',
      hint: 'İlişki uyumu analizi',
      definition:
          'İki kişinin doğum haritalarını karşılaştırarak ilişki uyumunu analiz etme tekniği.',
      deepExplanation:
          'Her iki haritadaki gezegenler arasındaki açılar incelenir. Güneş-Ay uyumu temel bağı, Venüs-Mars romantik çekimi, Satürn bağlantıları uzun vadeli bağlılığı gösterir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Composite Chart', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Solar Return',
      termTr: 'Güneş Dönüşü',
      hint: 'Yıllık harita',
      definition:
          'Güneş\'in doğum haritanızdaki tam pozisyonuna döndüğü an için çıkarılan harita. Gelecek bir yılın temalarını gösterir.',
      deepExplanation:
          'Her doğum günü civarında gerçekleşir. Haritanın çıkarıldığı yer önemlidir - bazı astrologlar en uygun yere seyahat ederler. Yıllık temalar, fırsatlar ve zorluklar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Transit', 'Progresyon'],
    ),
    GlossaryEntry(
      term: 'Progressions',
      termTr: 'Progresyonlar',
      hint: 'İç gelişim takibi',
      definition:
          'Doğum sonrası her gün = bir yıl formülüyle hesaplanan ilerlemiş harita. İç gelişimi gösterir.',
      deepExplanation:
          'Secondary Progressions en yaygın yöntemdir. İç psikolojik gelişimi, olgunlaşmayı ve kişisel evrimi yansıtır. Progrese Ay her 2.5 yılda burç değiştirir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Transit', 'Güneş Dönüşü'],
    ),
    GlossaryEntry(
      term: 'Saturn Return',
      termTr: 'Satürn Dönüşü',
      hint: 'Olgunlaşma krizi (29.5 yılda bir)',
      definition:
          'Satürn\'ün doğum haritasındaki yerine dönmesi. 29-30, 58-60 ve 87-88 yaşlarında gerçekleşir.',
      deepExplanation:
          'Hayatın en önemli dönüm noktalarından biri. Birinci dönüş yetişkinliğe geçiş, ikincisi bilgelik yaşına geçiş. Sorumluluk, olgunluk ve hayat dersleri.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Satürn', 'Transit', 'Olgunlaşma'],
      references: [
        GlossaryReference(
          title: 'Saturn: A New Look at an Old Devil',
          author: 'Liz Greene',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Void of Course Moon',
      termTr: 'Boşlukta Ay',
      hint: 'Bekleme zamanı',
      definition:
          'Ay\'ın son major açıdan sonra yeni burca geçene kadar geçen süre. Bu dönemde başlanan işler sonuçsuz kalabilir.',
      deepExplanation:
          'Ay "boşlukta" iken önemli kararlar ve yeni başlangıçlar önerilmez. Ancak rutin işler, meditasyon ve dinlenme için idealdir. Süre birkaç dakikadan birkaç güne kadar değişebilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ay', 'Transit', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Electional Astrology',
      termTr: 'Seçim Astrolojisi',
      hint: 'En uygun zamanı bulma',
      definition:
          'Bir faaliyet için en uygun astrolojik zamanı seçme sanatı. Düğün, iş kurma, ameliyat gibi olaylar için kullanılır.',
      deepExplanation:
          'Evrenin enerjisiyle uyumlu hareket etme. Ay fazları, gezegen konumları ve açılar değerlendirilir. Antik çağlardan beri krallar ve tüccarlar tarafından kullanılmıştır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Transit', 'Boşlukta Ay', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Horary Astrology',
      termTr: 'Horary Astroloji',
      hint: 'Soru astrolojisi',
      definition:
          'Belirli bir soruya cevap bulmak için, sorunun sorulduğu ana göre harita çıkarma tekniği.',
      deepExplanation:
          'Antik bir tekniktir. "Kayıp eşyamı bulabilir miyim?", "Bu iş teklifi iyi mi?" gibi sorulara cevap arar. Katı kuralları vardır ve deneyim gerektirir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Geleneksel Astroloji'],
      references: [
        GlossaryReference(
          title: 'Horary Astrology',
          author: 'William Lilly',
          type: 'book',
        ),
      ],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // MODERN ASTROLOJI
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _modernTerms = [
    GlossaryEntry(
      term: 'Chiron',
      termTr: 'Kiron',
      hint: 'Yaralı şifacı',
      definition:
          'Yaralı şifacı asteroidi. Derin yaralarımızı ve bu yaraları başkalarını iyileştirmek için nasıl kullanabileceğimizi gösterir.',
      deepExplanation:
          'Mitolojide ölümsüz bir centaur, kendi yarasını iyileştiremez ama başkalarını iyileştirir. Haritada Kiron, şifa yolculuğumuzun hem acı veren hem de dönüştürücü noktasını gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroid', 'Şifa', '6. Ev'],
    ),
    GlossaryEntry(
      term: 'North Node',
      termTr: 'Kuzey Düğümü (Rahu)',
      hint: 'Ruhsal amaç ve büyüme',
      definition:
          'Ay\'ın yörüngesinin ekliptik ile kesiştiği kuzey noktası. Bu yaşamdaki ruhsal amacınızı ve büyüme yönünüzü gösterir.',
      deepExplanation:
          'Kuzey Düğümü konfor zonumuzun dışındadır ama oraya doğru evrilmemiz gerekir. Güney Düğümü (Ketu) ise geçmiş yaşam yetenekleri ve alışkanlıklarımızı temsil eder.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Güney Düğümü', 'Karma', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Black Moon Lilith',
      termTr: 'Kara Ay Lilith',
      hint: 'Vahşi dişil enerji',
      definition:
          'Ay\'ın yörüngesinin Dünya\'dan en uzak noktası. Bastırılmış dişil güç, öfke ve özgürleşmeyi temsil eder.',
      deepExplanation:
          'Mitolojide Adem\'in ilk eşi, itaat etmeyi reddetti. Haritada, toplum tarafından kabul edilmeyen, bastırılmış yanlarımızı gösterir. Güçlendirildiğinde özgün gücümüze dönüşür.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Ay', 'Dişil Enerji'],
    ),
    GlossaryEntry(
      term: 'Part of Fortune',
      termTr: 'Şans Noktası',
      hint: 'Doğal bolluk alanı',
      definition:
          'Güneş, Ay ve Yükselen\'den hesaplanan matematiksel nokta. Doğal şans ve refah alanınızı gösterir.',
      deepExplanation:
          'Antik Arap noktalarından biri. Formül: Yükselen + Ay - Güneş. Haritada bulunduğu ev ve burç, en az çabayla en çok doyum bulacağınız alanı gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Arap Noktaları', 'Şans'],
    ),
    GlossaryEntry(
      term: 'Asteroids',
      termTr: 'Asteroidler',
      hint: 'Ek semboller ve temalar',
      definition:
          'Ceres, Pallas, Juno, Vesta gibi ana kuşak asteroidleri. Dişil arketipler ve özel yetenekleri temsil eder.',
      deepExplanation:
          'Ceres: beslenme, Pallas: strateji ve bilgelik, Juno: evlilik ortağı, Vesta: adanmışlık. Modern astrolojide daha fazla nüans ekler.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Ceres', 'Pallas', 'Juno', 'Vesta'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // GEZEGEN EV YORUMLARI
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _planetInHouseTerms = [
    // Güneş ev yorumları
    GlossaryEntry(
      term: 'Sun in 1st House',
      termTr: 'Güneş 1. Evde',
      hint: 'Güçlü benlik ve liderlik',
      definition:
          'Güneş 1. evde güçlü kişilik, doğal liderlik ve kendine güven gösterir.',
      deepExplanation:
          'Kişi dikkat çeker, karizmatiktir ve "ben" kimliği güçlüdür. Fiziksel canlılık ve sağlık genellikle iyidir. Ego bazen aşırı baskın olabilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 1. Ev',
      relatedTerms: ['Güneş', '1. Ev', 'Yükselen'],
    ),
    GlossaryEntry(
      term: 'Sun in 10th House',
      termTr: 'Güneş 10. Evde',
      hint: 'Kariyer odaklı ve hırslı',
      definition:
          'Güneş 10. evde kariyer başarısı, toplumsal tanınma ve otorite pozisyonları gösterir.',
      deepExplanation:
          'Profesyonel yaşam kimliğin merkezindedir. Liderlik rolleri çeker, kamusal figür olma potansiyeli yüksektir. Baba figürü önemli bir etkidir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 10. Ev',
      relatedTerms: ['Güneş', '10. Ev', 'MC'],
    ),
    // Ay ev yorumları
    GlossaryEntry(
      term: 'Moon in 4th House',
      termTr: 'Ay 4. Evde',
      hint: 'Güçlü aile bağları',
      definition:
          'Ay 4. evde derin aile bağları, ev sevgisi ve duygusal güvenlik ihtiyacı gösterir.',
      deepExplanation:
          'Ev ortamı duygusal denge için kritiktir. Anne figürü çok önemlidir. Geçmişe ve köklere güçlü bağlılık. Gayrimenkul konularında şans olabilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 4. Ev',
      relatedTerms: ['Ay', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Moon in 7th House',
      termTr: 'Ay 7. Evde',
      hint: 'İlişkilerde duygusal ihtiyaç',
      definition:
          'Ay 7. evde ilişkilerde duygusal doyum arayışı ve partner bağımlılığı gösterebilir.',
      deepExplanation:
          'Tek başına olmaktan hoşlanmaz, partner tarafından beslenmek ister. Partner seçiminde anne figürü yansıması olabilir. Halkla ilişkilerde başarılı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 7. Ev',
      relatedTerms: ['Ay', '7. Ev', 'Evlilik'],
    ),
    // Diğer önemli kombinasyonlar
    GlossaryEntry(
      term: 'Mars in 1st House',
      termTr: 'Mars 1. Evde',
      hint: 'Enerjik ve rekabetçi',
      definition:
          'Mars 1. evde yüksek enerji, cesaret, rekabetçilik ve bazen agresiflik gösterir.',
      deepExplanation:
          'Fiziksel olarak aktif, cesur ve doğrudan. Savaşçı ruhu güçlü. Spor yetenekleri olabilir. Sabırsızlık ve öfke kontrolü gerektirebilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 1. Ev',
      relatedTerms: ['Mars', '1. Ev', 'Enerji'],
    ),
    GlossaryEntry(
      term: 'Venus in 5th House',
      termTr: 'Venüs 5. Evde',
      hint: 'Romantik ve yaratıcı',
      definition:
          'Venüs 5. evde sanatsal yetenek, romantik aşklar ve çocuklarla güzel ilişki gösterir.',
      deepExplanation:
          'Aşk hayatı zengin ve renkli. Yaratıcı ifade için güçlü ihtiyaç. Flört etmeyi sever. Çocuklarla özel bağ. Kumar ve spekülasyonda dikkatli olmalı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 5. Ev',
      relatedTerms: ['Venüs', '5. Ev', 'Aşk'],
    ),
    GlossaryEntry(
      term: 'Saturn in 7th House',
      termTr: 'Satürn 7. Evde',
      hint: 'Ciddi ilişkiler, geç evlilik',
      definition:
          'Satürn 7. evde ilişkilerde ciddiyet, sorumluluk ve bazen gecikmeler gösterir.',
      deepExplanation:
          'İlişkilere olgun yaklaşım. Geç evlilik veya yaşça büyük partner. Uzun süreli, kalıcı ilişkiler tercih edilir. Yalnızlık korkusu olabilir ama ustalaşıldığında en sadık partner.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 7. Ev',
      relatedTerms: ['Satürn', '7. Ev', 'Evlilik'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 9th House',
      termTr: 'Jüpiter 9. Evde',
      hint: 'Gezgin ve filozof',
      definition:
          'Jüpiter 9. evde felsefi zeka, seyahat şansı ve yüksek öğrenimde başarı gösterir.',
      deepExplanation:
          'Jüpiter kendi evindedir, en güçlü konumu. Evrensel düşünce, kültürel açıklık ve öğretmenlik yetenekleri. Yabancı bağlantılarda şans. Hukuk ve yayıncılıkta başarı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 9. Ev',
      relatedTerms: ['Jüpiter', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Pluto in 8th House',
      termTr: 'Pluto 8. Evde',
      hint: 'Derin dönüşüm gücü',
      definition:
          'Pluto 8. evde derin psikolojik güç, dönüşüm kapasitesi ve miras konularında yoğunluk gösterir.',
      deepExplanation:
          'Pluto kendi evindedir, çok güçlü konumdadır. Yaşam ve ölüm konularıyla derin bağlantı. Psikoterapi yeteneği. Güç mücadeleleri ve kontrol konuları. Derin dönüşümler.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 8. Ev',
      relatedTerms: ['Pluto', '8. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Neptune in 12th House',
      termTr: 'Neptün 12. Evde',
      hint: 'Spiritüel derinlik',
      definition:
          'Neptün 12. evde güçlü sezgi, spiritüel bağlantı ve bilinçaltı hassasiyet gösterir.',
      deepExplanation:
          'Neptün kendi evindedir. Mistik deneyimler, rüya çalışması ve medyumluk potansiyeli. Ancak sınır sorunları ve kaçış eğilimleri konusunda dikkatli olunmalı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 12. Ev',
      relatedTerms: ['Neptün', '12. Ev', 'Spiritüellik'],
    ),
    // Güneş tüm evlerde
    GlossaryEntry(
      term: 'Sun in 2nd House',
      termTr: 'Güneş 2. Evde',
      hint: 'Para ve değerlerle kimlik',
      definition:
          'Güneş 2. evde maddi güvenlik, öz değer ve kazanç kapasitesi önemlidir.',
      deepExplanation:
          'Kimlik maddi başarıyla bağlantılı. Para kazanma yeteneği güçlü. Sahip olunan şeylerle gurur duyulur. Değerler net ve belirgindir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 2. Ev',
      relatedTerms: ['Güneş', '2. Ev', 'Para'],
    ),
    GlossaryEntry(
      term: 'Sun in 3rd House',
      termTr: 'Güneş 3. Evde',
      hint: 'İletişimci ve meraklı',
      definition:
          'Güneş 3. evde iletişim, öğrenme ve kardeş ilişkileri kimliğin merkezindedir.',
      deepExplanation:
          'Zihinsel aktivite çok önemli. Yazarlık, konuşmacılık yetenekleri. Kardeşlerle güçlü bağ veya rekabet. Sürekli öğrenme ihtiyacı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 3. Ev',
      relatedTerms: ['Güneş', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Sun in 4th House',
      termTr: 'Güneş 4. Evde',
      hint: 'Aile ve köklerle bağ',
      definition:
          'Güneş 4. evde aile, ev ve duygusal güvenlik kimliğin temelidir.',
      deepExplanation:
          'Ev ortamı ve aile mirası çok önemli. Baba evde baskın figür olabilir. Gayrimenkul işlerinde başarı. Yaşlılıkta parlar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 4. Ev',
      relatedTerms: ['Güneş', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Sun in 5th House',
      termTr: 'Güneş 5. Evde',
      hint: 'Yaratıcı ve oyuncu',
      definition:
          'Güneş 5. evde yaratıcılık, aşk ve çocuklar kimliğin parlayan noktalarıdır.',
      deepExplanation:
          'Güneş kendi evindedir, güçlü konumda. Sahne almayı sever, dikkat çeker. Romantik ve dramatik. Çocuklarla özel bağ. Spekülasyonda şanslı olabilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 5. Ev',
      relatedTerms: ['Güneş', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Sun in 6th House',
      termTr: 'Güneş 6. Evde',
      hint: 'Hizmette kimlik',
      definition:
          'Güneş 6. evde iş, sağlık ve hizmet kimliğin önemli parçalarıdır.',
      deepExplanation:
          'İş ahlakı güçlü, mükemmeliyetçi. Sağlık bilinci yüksek. Başkalarına hizmet etmekten doyum alır. Detaylara dikkat eder.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 6. Ev',
      relatedTerms: ['Güneş', '6. Ev', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Sun in 7th House',
      termTr: 'Güneş 7. Evde',
      hint: 'İlişkilerde kimlik',
      definition:
          'Güneş 7. evde ilişkiler ve ortaklıklar kimliğin merkezindedir.',
      deepExplanation:
          'Tek başına olmaktan hoşlanmaz, partner aracılığıyla parlar. Diplomatik yetenekler. Başarılı işbirlikler. Evlilik hayatta önemli yer tutar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 7. Ev',
      relatedTerms: ['Güneş', '7. Ev', 'Ortaklık'],
    ),
    GlossaryEntry(
      term: 'Sun in 8th House',
      termTr: 'Güneş 8. Evde',
      hint: 'Dönüşümde kimlik',
      definition:
          'Güneş 8. evde derin dönüşümler, paylaşılan kaynaklar ve gizli konular kimliği şekillendirir.',
      deepExplanation:
          'Psikolojik derinlik, gizem arayışı. Başkalarının kaynaklarını yönetme yeteneği. Krizlerde güçlenir. Ölüm-yeniden doğuş temaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 8. Ev',
      relatedTerms: ['Güneş', '8. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Sun in 9th House',
      termTr: 'Güneş 9. Evde',
      hint: 'Filozof ve gezgin',
      definition:
          'Güneş 9. evde felsefe, yüksek öğrenim ve uzak seyahatler kimliğin parçasıdır.',
      deepExplanation:
          'Anlam arayışı güçlü. Öğretmenlik, yayıncılık potansiyeli. Yabancı kültürlere ilgi. İdealist ve vizyoner. Hukuk alanında başarı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 9. Ev',
      relatedTerms: ['Güneş', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Sun in 11th House',
      termTr: 'Güneş 11. Evde',
      hint: 'Topluluk lideri',
      definition:
          'Güneş 11. evde arkadaşlıklar, gruplar ve idealler kimliği tanımlar.',
      deepExplanation:
          'Sosyal ağlarda parlar, grup lideri olur. İnsani idealler önemli. Arkadaşlıklar hayatın merkezinde. Teknoloji ve yenilikle bağ.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 11. Ev',
      relatedTerms: ['Güneş', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Sun in 12th House',
      termTr: 'Güneş 12. Evde',
      hint: 'Gizli güç',
      definition:
          'Güneş 12. evde bilinçaltı, spiritüellik ve izolasyon kimliği derinden etkiler.',
      deepExplanation:
          'Ego geri planda çalışır. Sahne arkası rolleri tercih edilir. Spiritüel arayış güçlü. Yalnızlık ihtiyacı. Gizli düşmanlar veya gizli yetenekler.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Güneş - 12. Ev',
      relatedTerms: ['Güneş', '12. Ev', 'Bilinçaltı'],
    ),
    // Ay tüm evlerde
    GlossaryEntry(
      term: 'Moon in 1st House',
      termTr: 'Ay 1. Evde',
      hint: 'Duygusal ve hassas',
      definition:
          'Ay 1. evde duygusal hassasiyet, sezgisel algı ve değişken ruh halleri belirgindir.',
      deepExplanation:
          'Duygular yüzde okunur. Halkla ilişkilerde başarılı. Anne figürü güçlü etki. Çevreye karşı aşırı hassas. Koruyucu içgüdüler gelişmiş.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 1. Ev',
      relatedTerms: ['Ay', '1. Ev', 'Duygular'],
    ),
    GlossaryEntry(
      term: 'Moon in 2nd House',
      termTr: 'Ay 2. Evde',
      hint: 'Duygusal güvenlik = maddi güvenlik',
      definition:
          'Ay 2. evde duygusal güvenlik maddi durumla doğrudan bağlantılıdır.',
      deepExplanation:
          'Finansal duruma göre ruh hali değişir. Yiyecek, konfor ve lüks ihtiyacı. Değişken gelir akışı. Koleksiyon yapma eğilimi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 2. Ev',
      relatedTerms: ['Ay', '2. Ev', 'Güvenlik'],
    ),
    GlossaryEntry(
      term: 'Moon in 3rd House',
      termTr: 'Ay 3. Evde',
      hint: 'Duygusal iletişim',
      definition:
          'Ay 3. evde düşünce ve duygular iç içedir, iletişimde duygu paylaşımı önemlidir.',
      deepExplanation:
          'Duyguları kelimelerle ifade eder. Kardeşlerle duygusal bağ. Kısa seyahatler stresi azaltır. Yazarlık yeteneği.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 3. Ev',
      relatedTerms: ['Ay', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Moon in 5th House',
      termTr: 'Ay 5. Evde',
      hint: 'Duygusal yaratıcılık',
      definition: 'Ay 5. evde yaratıcılık duygusal ifade için bir araçtır.',
      deepExplanation:
          'Sanatsal ifade duygu sağlığı için gerekli. Çocuklarla derin bağ. Romantik ilişkilerde duygusallık. Oyun ve eğlence önemli.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 5. Ev',
      relatedTerms: ['Ay', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Moon in 6th House',
      termTr: 'Ay 6. Evde',
      hint: 'Sağlıkta duygu etkisi',
      definition:
          'Ay 6. evde duygusal durum fiziksel sağlığı doğrudan etkiler.',
      deepExplanation:
          'Stres mide ve sindirim sorunlarına yol açabilir. İş ortamında duygusal atmosfer önemli. Beslenme alışkanlıkları değişken.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 6. Ev',
      relatedTerms: ['Ay', '6. Ev', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Moon in 8th House',
      termTr: 'Ay 8. Evde',
      hint: 'Derin duygusal bağlar',
      definition: 'Ay 8. evde duygusal yaşam yoğun ve dönüştürücüdür.',
      deepExplanation:
          'Derin psikolojik sezgi. Miras ve paylaşılan kaynaklarda dalgalanma. Cinsel bağlarda duygusal derinlik. Gizli duygular.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 8. Ev',
      relatedTerms: ['Ay', '8. Ev', 'Yoğunluk'],
    ),
    GlossaryEntry(
      term: 'Moon in 9th House',
      termTr: 'Ay 9. Evde',
      hint: 'Duygusal anlam arayışı',
      definition: 'Ay 9. evde duygusal doyum felsefe ve keşifle bağlantılıdır.',
      deepExplanation:
          'Seyahat duygusal beslenme sağlar. Yabancı kültürlere duygusal çekim. İnanç sistemi güvenlik hissi verir. Öğretmenlik içgüdüsü.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 9. Ev',
      relatedTerms: ['Ay', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Moon in 10th House',
      termTr: 'Ay 10. Evde',
      hint: 'Kamusal duygusallık',
      definition:
          'Ay 10. evde kariyer ve kamusal imaj duygusal ihtiyaçlarla şekillenir.',
      deepExplanation:
          'Halkla ilişkilerde başarı. Kariyer seçimi duygusal motivasyona bağlı. Anne figürü kariyer yönelimini etkiler. Şöhret dalgalanmaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 10. Ev',
      relatedTerms: ['Ay', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Moon in 11th House',
      termTr: 'Ay 11. Evde',
      hint: 'Dostlukta duygusal bağ',
      definition:
          'Ay 11. evde arkadaşlıklar ve gruplar duygusal güvenlik sağlar.',
      deepExplanation:
          'Sosyal çevre aile gibi hissettirir. Kadın gruplarıyla bağ. İdealler duygusal olarak benimsenmiş. Değişken arkadaş çevresi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 11. Ev',
      relatedTerms: ['Ay', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Moon in 12th House',
      termTr: 'Ay 12. Evde',
      hint: 'Gizli duygular',
      definition: 'Ay 12. evde duygular derinde yaşanır, bilinçaltı aktiftir.',
      deepExplanation:
          'Duyguları gizleme eğilimi. Güçlü sezgi ve rüya yaşamı. Yalnızlık ihtiyacı. Empati kapasitesi yüksek. Geçmiş yaşam hafızası.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Ay - 12. Ev',
      relatedTerms: ['Ay', '12. Ev', 'Bilinçaltı'],
    ),
    // Merkür tüm evlerde
    GlossaryEntry(
      term: 'Mercury in 1st House',
      termTr: 'Merkür 1. Evde',
      hint: 'Zeki ve konuşkan',
      definition:
          'Merkür 1. evde hızlı düşünce, iletişim yeteneği ve genç görünüm belirgindir.',
      deepExplanation:
          'Meraklı, hareketli ve çok yönlü. Konuşmayı sever. Genç görünüm ve ruh. Elleri ve sinirleri aktif.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 1. Ev',
      relatedTerms: ['Merkür', '1. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Mercury in 2nd House',
      termTr: 'Merkür 2. Evde',
      hint: 'Zekadan para',
      definition:
          'Merkür 2. evde para kazanma zeka ve iletişimle bağlantılıdır.',
      deepExplanation:
          'Ticaret, yazarlık veya iletişimle gelir. Değerler mantıksal analiz sonucu oluşur. Birden fazla gelir kaynağı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 2. Ev',
      relatedTerms: ['Merkür', '2. Ev', 'Para'],
    ),
    GlossaryEntry(
      term: 'Mercury in 3rd House',
      termTr: 'Merkür 3. Evde',
      hint: 'Güçlü iletişimci',
      definition:
          'Merkür 3. evde kendi evindedir, iletişim ve öğrenme yetenekleri zirvededir.',
      deepExplanation:
          'Doğal yazar ve konuşmacı. Kardeşlerle yakın iletişim. Sürekli hareket, kısa seyahatler. Çoklu görev yeteneği.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 3. Ev',
      relatedTerms: ['Merkür', '3. Ev', 'Kardeşler'],
    ),
    GlossaryEntry(
      term: 'Mercury in 4th House',
      termTr: 'Merkür 4. Evde',
      hint: 'Evde zihinsel aktivite',
      definition: 'Merkür 4. evde ev ortamı zihinsel çalışma için önemlidir.',
      deepExplanation:
          'Evden çalışma tercihi. Aile içi iletişim aktif. Sık ev değişikliği olabilir. Aile tarihine ilgi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 4. Ev',
      relatedTerms: ['Merkür', '4. Ev', 'Ev'],
    ),
    GlossaryEntry(
      term: 'Mercury in 5th House',
      termTr: 'Merkür 5. Evde',
      hint: 'Yaratıcı zeka',
      definition: 'Merkür 5. evde yaratıcı ifade zihinsel kanallardan akar.',
      deepExplanation:
          'Yazarlık, tiyatro, oyun tasarımı yetenekleri. Çocuklarla eğitici iletişim. Romantik ilişkilerde sözel ifade önemli.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 5. Ev',
      relatedTerms: ['Merkür', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Mercury in 6th House',
      termTr: 'Merkür 6. Evde',
      hint: 'Analitik çalışan',
      definition:
          'Merkür 6. evde kendi evindedir, detaylara dikkat ve iş analizi güçlüdür.',
      deepExplanation:
          'Mükemmel organizatör. Sağlık konularını araştırır. Eleştirici bakış açısı. Zihinsel iş ortamı tercih edilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 6. Ev',
      relatedTerms: ['Merkür', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Mercury in 7th House',
      termTr: 'Merkür 7. Evde',
      hint: 'İletişim ortağı',
      definition: 'Merkür 7. evde iletişim ilişkilerin merkezindedir.',
      deepExplanation:
          'Partner ile zihinsel uyum aranır. Müzakereci ve diplomatik. Sözleşmeler ve anlaşmalarda başarılı. Genç veya zeki partner.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 7. Ev',
      relatedTerms: ['Merkür', '7. Ev', 'Ortaklık'],
    ),
    GlossaryEntry(
      term: 'Mercury in 8th House',
      termTr: 'Merkür 8. Evde',
      hint: 'Araştırmacı zeka',
      definition:
          'Merkür 8. evde derin araştırma, psikoloji ve gizli bilgilere ilgi vardır.',
      deepExplanation:
          'Dedektif zihin. Tabular hakkında konuşabilir. Miras ve vergi konularında zeka. Okült araştırmaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 8. Ev',
      relatedTerms: ['Merkür', '8. Ev', 'Araştırma'],
    ),
    GlossaryEntry(
      term: 'Mercury in 9th House',
      termTr: 'Merkür 9. Evde',
      hint: 'Felsefi düşünür',
      definition:
          'Merkür 9. evde yüksek öğrenim, felsefe ve yabancı dillere ilgi vardır.',
      deepExplanation:
          'Akademik başarı potansiyeli. Yabancı dil yeteneği. Yayıncılık ve öğretmenlik. Seyahat yazarlığı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 9. Ev',
      relatedTerms: ['Merkür', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Mercury in 10th House',
      termTr: 'Merkür 10. Evde',
      hint: 'İletişimde kariyer',
      definition:
          'Merkür 10. evde kariyer iletişim ve zeka gerektiren alanlardadır.',
      deepExplanation:
          'Yazar, konuşmacı, medya figürü potansiyeli. Birden fazla kariyer. Kamusal iletişim yetenekleri.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 10. Ev',
      relatedTerms: ['Merkür', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Mercury in 11th House',
      termTr: 'Merkür 11. Evde',
      hint: 'Sosyal ağ kurucusu',
      definition:
          'Merkür 11. evde arkadaşlıklar ve gruplar zihinsel paylaşıma dayanır.',
      deepExplanation:
          'Entelektüel arkadaş çevresi. Sosyal medya yeteneği. Grup iletişiminde lider. Teknoloji ve yenilikle bağ.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 11. Ev',
      relatedTerms: ['Merkür', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Mercury in 12th House',
      termTr: 'Merkür 12. Evde',
      hint: 'Sezgisel düşünce',
      definition:
          'Merkür 12. evde düşünce sezgisel ve bilinçaltından beslenir.',
      deepExplanation:
          'İç ses güçlü. Gizli düşünceler ve planlar. Yalnız çalışma tercihi. Rüya günlüğü faydalı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Merkür - 12. Ev',
      relatedTerms: ['Merkür', '12. Ev', 'Sezgi'],
    ),
    // Venüs tüm evlerde
    GlossaryEntry(
      term: 'Venus in 1st House',
      termTr: 'Venüs 1. Evde',
      hint: 'Çekici ve sevimli',
      definition:
          'Venüs 1. evde fiziksel çekicilik, cazibe ve uyum arayışı belirgindir.',
      deepExplanation:
          'Doğal güzellik ve çekicilik. Sosyal ortamlarda sevilir. Sanat ve estetik duygusu güçlü. Tatlı ve diplomatik.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 1. Ev',
      relatedTerms: ['Venüs', '1. Ev', 'Güzellik'],
    ),
    GlossaryEntry(
      term: 'Venus in 2nd House',
      termTr: 'Venüs 2. Evde',
      hint: 'Lüks ve konfor',
      definition:
          'Venüs 2. evde kendi evindedir, maddi konfor ve güzel şeyler önemlidir.',
      deepExplanation:
          'Para kazanma yeteneği iyi. Lüks ve kaliteli eşyalara değer verir. Sanat koleksiyonculuğu. Güzel ses.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 2. Ev',
      relatedTerms: ['Venüs', '2. Ev', 'Değerler'],
    ),
    GlossaryEntry(
      term: 'Venus in 3rd House',
      termTr: 'Venüs 3. Evde',
      hint: 'Hoş iletişim',
      definition: 'Venüs 3. evde iletişim tatlı ve çekicidir.',
      deepExplanation:
          'Güzel yazma ve konuşma yeteneği. Kardeşlerle uyumlu ilişki. Kısa romantik kaçamaklar. Hoş sesli.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 3. Ev',
      relatedTerms: ['Venüs', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Venus in 4th House',
      termTr: 'Venüs 4. Evde',
      hint: 'Güzel ev',
      definition: 'Venüs 4. evde ev güzelliği ve aile uyumu önemlidir.',
      deepExplanation:
          'Ev dekorasyonuna önem verir. Aile ortamı huzurlu. Anne güzellik figürü. Gayrimenkulde şans.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 4. Ev',
      relatedTerms: ['Venüs', '4. Ev', 'Ev'],
    ),
    GlossaryEntry(
      term: 'Venus in 6th House',
      termTr: 'Venüs 6. Evde',
      hint: 'İş yerinde uyum',
      definition: 'Venüs 6. evde iş ortamında uyum ve estetik önemlidir.',
      deepExplanation:
          'Çalışma ortamı güzel olmalı. İş arkadaşlarıyla iyi geçinir. Güzellik veya sanat sektöründe iş. Sağlıklı beslenme.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 6. Ev',
      relatedTerms: ['Venüs', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Venus in 7th House',
      termTr: 'Venüs 7. Evde',
      hint: 'Romantik ilişkiler',
      definition:
          'Venüs 7. evde kendi evindedir, ilişkiler hayatın merkezindedir.',
      deepExplanation:
          'Evlilik için ideal konum. Çekici partner çeker. Diplomasi yeteneği. İş ortaklıklarında başarı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 7. Ev',
      relatedTerms: ['Venüs', '7. Ev', 'Evlilik'],
    ),
    GlossaryEntry(
      term: 'Venus in 8th House',
      termTr: 'Venüs 8. Evde',
      hint: 'Tutkulu aşk',
      definition: 'Venüs 8. evde aşk derin ve dönüştürücüdür.',
      deepExplanation:
          'Yoğun romantik bağlar. Miras veya partner kaynakları aracılığıyla para. Cinsellikte derin bağlantı arayışı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 8. Ev',
      relatedTerms: ['Venüs', '8. Ev', 'Tutku'],
    ),
    GlossaryEntry(
      term: 'Venus in 9th House',
      termTr: 'Venüs 9. Evde',
      hint: 'Yabancı aşk',
      definition: 'Venüs 9. evde yabancı kültürler ve felsefe çekicidir.',
      deepExplanation:
          'Farklı kültürden partner. Seyahatte romantik macera. Sanat ve din felsefesine ilgi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 9. Ev',
      relatedTerms: ['Venüs', '9. Ev', 'Kültür'],
    ),
    GlossaryEntry(
      term: 'Venus in 10th House',
      termTr: 'Venüs 10. Evde',
      hint: 'Kariyer cazibesi',
      definition:
          'Venüs 10. evde kariyer sanat, güzellik veya diplomasiyle ilgilidir.',
      deepExplanation:
          'Kamusal alanda sevilir. Güzellik veya sanat kariyeri. İş dünyasında sosyal beceriler avantaj sağlar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 10. Ev',
      relatedTerms: ['Venüs', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Venus in 11th House',
      termTr: 'Venüs 11. Evde',
      hint: 'Sosyal çekicilik',
      definition: 'Venüs 11. evde sosyal çevrede popüler ve sevilendir.',
      deepExplanation:
          'Arkadaşlıktan aşka dönüşen ilişkiler. Sosyal gruplardan destek. Sanatçı arkadaş çevresi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 11. Ev',
      relatedTerms: ['Venüs', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Venus in 12th House',
      termTr: 'Venüs 12. Evde',
      hint: 'Gizli aşk',
      definition:
          'Venüs 12. evde gizli ilişkiler veya karşılıksız aşk temaları vardır.',
      deepExplanation:
          'Romantizm gizli veya spiritüel boyutta yaşanır. Fedakar aşk. Sanat sığınak olur. Kurumlarda sevilen.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Venüs - 12. Ev',
      relatedTerms: ['Venüs', '12. Ev', 'Gizem'],
    ),
    // Mars tüm evlerde
    GlossaryEntry(
      term: 'Mars in 2nd House',
      termTr: 'Mars 2. Evde',
      hint: 'Agresif kazanç',
      definition: 'Mars 2. evde para kazanma enerjik ve rekabetçidir.',
      deepExplanation:
          'Aktif para kazanma çabası. Finansal riskler alabilir. Değerler uğruna savaşır. Gelir dalgalanmaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 2. Ev',
      relatedTerms: ['Mars', '2. Ev', 'Para'],
    ),
    GlossaryEntry(
      term: 'Mars in 3rd House',
      termTr: 'Mars 3. Evde',
      hint: 'Keskin iletişim',
      definition: 'Mars 3. evde iletişim doğrudan ve bazen sert olabilir.',
      deepExplanation:
          'Tartışmacı zeka. Kardeşlerle rekabet. Tehlikeli sürüş eğilimi. Cesur konuşmacı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 3. Ev',
      relatedTerms: ['Mars', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Mars in 4th House',
      termTr: 'Mars 4. Evde',
      hint: 'Evde enerji',
      definition: 'Mars 4. evde ev ortamı enerjik veya çatışmalı olabilir.',
      deepExplanation:
          'Ev projeleri ve tadilatlar. Aile içi gerilimler. Bağımsızlık için erken ayrılma. Gayrimenkul işlerinde aktivite.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 4. Ev',
      relatedTerms: ['Mars', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Mars in 5th House',
      termTr: 'Mars 5. Evde',
      hint: 'Tutkulu yaratıcılık',
      definition: 'Mars 5. evde yaratıcılık ve romantizm tutkuyla yaşanır.',
      deepExplanation:
          'Rekabetçi sporlar. Ateşli aşklar. Yaratıcı projelerle enerjik ilişki. Çocuklarla aktif.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 5. Ev',
      relatedTerms: ['Mars', '5. Ev', 'Tutku'],
    ),
    GlossaryEntry(
      term: 'Mars in 6th House',
      termTr: 'Mars 6. Evde',
      hint: 'Çalışkan savaşçı',
      definition: 'Mars 6. evde iş ve sağlık konularında enerji yoğunlaşır.',
      deepExplanation:
          'İş ahlakı güçlü. Fiziksel iş tercih edilir. Stres kaynaklı sağlık sorunları. Çalışma arkadaşlarıyla çatışma olabilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 6. Ev',
      relatedTerms: ['Mars', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Mars in 7th House',
      termTr: 'Mars 7. Evde',
      hint: 'İlişkilerde ateş',
      definition: 'Mars 7. evde ilişkiler tutkulu ve bazen çatışmalı olabilir.',
      deepExplanation:
          'Enerjik partner çeker. İlişkilerde rekabet. Hukuki mücadeleler. Açık düşmanlarla karşılaşma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 7. Ev',
      relatedTerms: ['Mars', '7. Ev', 'Ortaklık'],
    ),
    GlossaryEntry(
      term: 'Mars in 8th House',
      termTr: 'Mars 8. Evde',
      hint: 'Güçlü irade',
      definition: 'Mars 8. evde dönüşüm enerjik ve yoğun bir şekilde yaşanır.',
      deepExplanation:
          'Güçlü cinsel enerji. Başkalarının kaynaklarını yönetme. Kriz anlarında güçlenme. Okült ilgi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 8. Ev',
      relatedTerms: ['Mars', '8. Ev', 'Güç'],
    ),
    GlossaryEntry(
      term: 'Mars in 9th House',
      termTr: 'Mars 9. Evde',
      hint: 'İnançlar uğruna savaş',
      definition: 'Mars 9. evde felsefe ve inançlar tutkuyla savunulur.',
      deepExplanation:
          'Aktivist veya misyoner ruhu. Macera dolu seyahatler. Akademik rekabet. Hukuk mücadeleleri.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 9. Ev',
      relatedTerms: ['Mars', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Mars in 10th House',
      termTr: 'Mars 10. Evde',
      hint: 'Kariyer hırsı',
      definition:
          'Mars 10. evde kariyer hedefleri agresif bir şekilde takip edilir.',
      deepExplanation:
          'Liderlik pozisyonlarına çekilir. Rekabetçi iş ortamı. Otorite figürleriyle çatışma. Askeriye veya atletizm.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 10. Ev',
      relatedTerms: ['Mars', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Mars in 11th House',
      termTr: 'Mars 11. Evde',
      hint: 'Grup lideri',
      definition: 'Mars 11. evde gruplar ve idealler için mücadele edilir.',
      deepExplanation:
          'Sosyal aktivizm. Arkadaş gruplarında liderlik. Hedefler agresif takip edilir. Teknoloji veya yenilikte rekabet.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 11. Ev',
      relatedTerms: ['Mars', '11. Ev', 'İdealler'],
    ),
    GlossaryEntry(
      term: 'Mars in 12th House',
      termTr: 'Mars 12. Evde',
      hint: 'Gizli enerji',
      definition: 'Mars 12. evde enerji gizlice veya bilinçaltında çalışır.',
      deepExplanation:
          'Bastırılmış öfke. Sahne arkası faaliyetler. Spiritüel savaşçı. Kurumsal çalışma. Gizli düşmanlar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Mars - 12. Ev',
      relatedTerms: ['Mars', '12. Ev', 'Bilinçaltı'],
    ),
    // Jüpiter tüm evlerde
    GlossaryEntry(
      term: 'Jupiter in 1st House',
      termTr: 'Jüpiter 1. Evde',
      hint: 'İyimser ve şanslı',
      definition:
          'Jüpiter 1. evde iyimserlik, cömertlik ve fiziksel genişleme eğilimi vardır.',
      deepExplanation:
          'Karizmatik ve güvenilir görünüm. Doğal öğretmen. Fiziksel genişleme eğilimi. Hayata pozitif bakış.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 1. Ev',
      relatedTerms: ['Jüpiter', '1. Ev', 'Şans'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 2nd House',
      termTr: 'Jüpiter 2. Evde',
      hint: 'Finansal şans',
      definition:
          'Jüpiter 2. evde para ve değerler konusunda genişleme vardır.',
      deepExplanation:
          'Finansal bolluk potansiyeli. Cömert harcama eğilimi. Değerler geniş ve felsefi. Doğal yeteneklerden para.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 2. Ev',
      relatedTerms: ['Jüpiter', '2. Ev', 'Bolluk'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 3rd House',
      termTr: 'Jüpiter 3. Evde',
      hint: 'Geniş iletişim',
      definition: 'Jüpiter 3. evde iletişim ve öğrenme genişler.',
      deepExplanation:
          'Öğrenme iştahı yüksek. Kardeşlerle iyi ilişkiler. Yayıncılık yeteneği. Kısa seyahatlerde şans.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 3. Ev',
      relatedTerms: ['Jüpiter', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 4th House',
      termTr: 'Jüpiter 4. Evde',
      hint: 'Geniş ev ve aile',
      definition: 'Jüpiter 4. evde ev ortamı genişler, aile desteği güçlüdür.',
      deepExplanation:
          'Büyük ev veya aile. Gayrimenkulde şans. Ev ortamında bolluk. Destekleyici aile geçmişi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 4. Ev',
      relatedTerms: ['Jüpiter', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 5th House',
      termTr: 'Jüpiter 5. Evde',
      hint: 'Yaratıcı bolluk',
      definition: 'Jüpiter 5. evde yaratıcılık, aşk ve çocuklarda şans vardır.',
      deepExplanation:
          'Yaratıcı projelerle genişleme. Birçok romantik fırsat. Çocuklarla şanslı. Kumar ve spekülasyonda dikkat.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 5. Ev',
      relatedTerms: ['Jüpiter', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 6th House',
      termTr: 'Jüpiter 6. Evde',
      hint: 'İş şansı',
      definition: 'Jüpiter 6. evde iş ve sağlık konularında koruma vardır.',
      deepExplanation:
          'İş fırsatları bolca gelir. Genel sağlık iyi. Aşırı yeme eğilimi. Hizmet sektöründe başarı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 6. Ev',
      relatedTerms: ['Jüpiter', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 7th House',
      termTr: 'Jüpiter 7. Evde',
      hint: 'Şanslı ortaklıklar',
      definition:
          'Jüpiter 7. evde ilişkiler ve ortaklıklarda genişleme vardır.',
      deepExplanation:
          'Cömert ve destekleyici partner. Hukuki konularda şans. Başarılı iş ortaklıkları. Evlilik bolluğu getirebilir.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 7. Ev',
      relatedTerms: ['Jüpiter', '7. Ev', 'Evlilik'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 8th House',
      termTr: 'Jüpiter 8. Evde',
      hint: 'Miras şansı',
      definition:
          'Jüpiter 8. evde paylaşılan kaynaklar ve dönüşümlerde genişleme vardır.',
      deepExplanation:
          'Miras veya partner kaynaklarından yararlanma. Krizlerden büyüyerek çıkma. Psikolojik derinlik. Okült koruma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 8. Ev',
      relatedTerms: ['Jüpiter', '8. Ev', 'Miras'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 10th House',
      termTr: 'Jüpiter 10. Evde',
      hint: 'Kariyer başarısı',
      definition: 'Jüpiter 10. evde kariyer ve toplumsal konum genişler.',
      deepExplanation:
          'Profesyonel başarı ve tanınma. Liderlik fırsatları. Mentor figürlerden destek. Etik iş anlayışı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 10. Ev',
      relatedTerms: ['Jüpiter', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 11th House',
      termTr: 'Jüpiter 11. Evde',
      hint: 'Sosyal genişleme',
      definition: 'Jüpiter 11. evde arkadaşlıklar ve gruplardan şans gelir.',
      deepExplanation:
          'Geniş sosyal çevre. Gruplardan fayda. İdealler ve umutlar gerçekleşebilir. Hayırseverlik.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 11. Ev',
      relatedTerms: ['Jüpiter', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Jupiter in 12th House',
      termTr: 'Jüpiter 12. Evde',
      hint: 'Gizli koruma',
      definition:
          'Jüpiter 12. evde görünmeyen koruma ve spiritüel genişleme vardır.',
      deepExplanation:
          'Koruyucu melek figürü. Spiritüel yolda şans. Kurumlarda koruma. Yalnızlıkta huzur.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Jüpiter - 12. Ev',
      relatedTerms: ['Jüpiter', '12. Ev', 'Spiritüellik'],
    ),
    // Satürn tüm evlerde
    GlossaryEntry(
      term: 'Saturn in 1st House',
      termTr: 'Satürn 1. Evde',
      hint: 'Ciddi ve disiplinli',
      definition:
          'Satürn 1. evde ciddiyet, sorumluluk ve olgunluk belirgindir.',
      deepExplanation:
          'Erken yaşta olgunluk. Yaşla birlikte gençleşme. Fiziksel kısıtlamalar veya kemik/diş sorunları. Otorite figürü.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 1. Ev',
      relatedTerms: ['Satürn', '1. Ev', 'Disiplin'],
    ),
    GlossaryEntry(
      term: 'Saturn in 2nd House',
      termTr: 'Satürn 2. Evde',
      hint: 'Finansal disiplin',
      definition:
          'Satürn 2. evde para konusunda sınırlamalar ve disiplin gerektirir.',
      deepExplanation:
          'Erken dönemde finansal zorluklar. Zamanla istikrarlı birikim. Tutumlu yaklaşım. Değerler sağlam temellere dayanır.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 2. Ev',
      relatedTerms: ['Satürn', '2. Ev', 'Para'],
    ),
    GlossaryEntry(
      term: 'Saturn in 3rd House',
      termTr: 'Satürn 3. Evde',
      hint: 'Yapısal düşünce',
      definition:
          'Satürn 3. evde iletişim ve öğrenmede disiplin ve ciddiyet vardır.',
      deepExplanation:
          'Metodlu düşünce. Erken öğrenme zorlukları. Kardeşlerle mesafeli ilişki. Ciddi yazar veya konuşmacı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 3. Ev',
      relatedTerms: ['Satürn', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Saturn in 4th House',
      termTr: 'Satürn 4. Evde',
      hint: 'Aile sorumluluğu',
      definition:
          'Satürn 4. evde aile ve ev konularında kısıtlamalar veya sorumluluklar vardır.',
      deepExplanation:
          'Zor çocukluk. Ebeveyne bakım sorumluluğu. Ev satın alma gecikmesi. Emeklilikte güvenlik arayışı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 4. Ev',
      relatedTerms: ['Satürn', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Saturn in 5th House',
      termTr: 'Satürn 5. Evde',
      hint: 'Disiplinli yaratıcılık',
      definition:
          'Satürn 5. evde yaratıcılık ve aşk konularında engellemeler veya gecikmeler olabilir.',
      deepExplanation:
          'Çocuk sahibi olmada gecikme. Aşkta ciddiyet. Yaratıcı ifadede bloklar. Zamanla ustalaşma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 5. Ev',
      relatedTerms: ['Satürn', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Saturn in 6th House',
      termTr: 'Satürn 6. Evde',
      hint: 'Çalışkan ve sağlam',
      definition:
          'Satürn 6. evde iş ve sağlık konularında disiplin ve dayanıklılık vardır.',
      deepExplanation:
          'Güvenilir çalışan. Kronik sağlık sorunları olabilir. İş rutinleri önemli. Hizmet sektöründe otorite.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 6. Ev',
      relatedTerms: ['Satürn', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Saturn in 8th House',
      termTr: 'Satürn 8. Evde',
      hint: 'Derin sorumluluk',
      definition:
          'Satürn 8. evde paylaşılan kaynaklar ve dönüşüm konularında ciddiyet vardır.',
      deepExplanation:
          'Miras gecikmeleri. Ölüm korkusu ve ustalaşma. Partner kaynaklarında kısıtlama. Derin psikolojik çalışma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 8. Ev',
      relatedTerms: ['Satürn', '8. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Saturn in 9th House',
      termTr: 'Satürn 9. Evde',
      hint: 'Yapısal felsefe',
      definition:
          'Satürn 9. evde felsefe ve yüksek öğrenimde disiplin gerektirir.',
      deepExplanation:
          'Geleneksel inanç sistemi. Akademik başarı için çaba. Yabancı seyahatlerde engeller. Zamanla guru figürü.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 9. Ev',
      relatedTerms: ['Satürn', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Saturn in 10th House',
      termTr: 'Satürn 10. Evde',
      hint: 'Kariyer zirvesi',
      definition:
          'Satürn 10. evde kendi evindedir, kariyer ciddi çaba ve zaman gerektirir.',
      deepExplanation:
          'Yavaş ama istikrarlı yükseliş. Otorite pozisyonu. Baba figürü sorunları. Geç gelen başarı kalıcıdır.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 10. Ev',
      relatedTerms: ['Satürn', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Saturn in 11th House',
      termTr: 'Satürn 11. Evde',
      hint: 'Az ama kaliteli dostlar',
      definition: 'Satürn 11. evde arkadaşlıklar az ama derin ve kalıcıdır.',
      deepExplanation:
          'Güvenilir az sayıda arkadaş. Grup sorumluluklarından kaçınma veya üstlenme. İdeallerde gerçekçilik.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 11. Ev',
      relatedTerms: ['Satürn', '11. Ev', 'Arkadaşlar'],
    ),
    GlossaryEntry(
      term: 'Saturn in 12th House',
      termTr: 'Satürn 12. Evde',
      hint: 'Gizli korkular',
      definition:
          'Satürn 12. evde bilinçaltı korkular ve izolasyon temaları vardır.',
      deepExplanation:
          'Geçmiş yaşam karması. Yalnızlık korkusu. Kurumlarda çalışma. Spiritüel disiplin öğretisi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Satürn - 12. Ev',
      relatedTerms: ['Satürn', '12. Ev', 'Karma'],
    ),
    // Uranüs tüm evlerde
    GlossaryEntry(
      term: 'Uranus in 1st House',
      termTr: 'Uranüs 1. Evde',
      hint: 'Özgün ve sıradışı',
      definition:
          'Uranüs 1. evde sıradışı görünüm, bağımsızlık ve beklenmedik değişimler belirgindir.',
      deepExplanation:
          'Farklı olmak ister. Ani görünüm değişiklikleri. Bağımsızlık tutkusu. Yenilikçi kişilik.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 1. Ev',
      relatedTerms: ['Uranüs', '1. Ev', 'Özgünlük'],
    ),
    GlossaryEntry(
      term: 'Uranus in 2nd House',
      termTr: 'Uranüs 2. Evde',
      hint: 'Değişken finans',
      definition:
          'Uranüs 2. evde gelir akışı düzensiz ve beklenmedik olabilir.',
      deepExplanation:
          'Teknolojiden para. Ani kazanç ve kayıplar. Değerler geleneksel değil. Freelance çalışma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 2. Ev',
      relatedTerms: ['Uranüs', '2. Ev', 'Para'],
    ),
    GlossaryEntry(
      term: 'Uranus in 3rd House',
      termTr: 'Uranüs 3. Evde',
      hint: 'Yenilikçi düşünce',
      definition:
          'Uranüs 3. evde düşünce ve iletişim sıradışı ve yenilikçidir.',
      deepExplanation:
          'Dahi zekası. Farklı öğrenme stili. Sıradışı kardeşler. Teknoloji iletişiminde başarı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 3. Ev',
      relatedTerms: ['Uranüs', '3. Ev', 'İletişim'],
    ),
    GlossaryEntry(
      term: 'Uranus in 4th House',
      termTr: 'Uranüs 4. Evde',
      hint: 'Sıradışı ev yaşamı',
      definition: 'Uranüs 4. evde ev ortamı sıradışı veya değişkendir.',
      deepExplanation:
          'Farklı aile yapısı. Sık ev değişikliği. Bağımsızlık için erken ayrılma. Teknolojik ev.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 4. Ev',
      relatedTerms: ['Uranüs', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Uranus in 5th House',
      termTr: 'Uranüs 5. Evde',
      hint: 'Yaratıcı devrim',
      definition:
          'Uranüs 5. evde yaratıcılık ve romantizm sıradışı ve beklenmedik şekilde gelişir.',
      deepExplanation:
          'Avangard sanat. Ani aşklar. Sıradışı çocuklar. Risk almada heyecan arayışı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 5. Ev',
      relatedTerms: ['Uranüs', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Uranus in 6th House',
      termTr: 'Uranüs 6. Evde',
      hint: 'Yenilikçi iş',
      definition:
          'Uranüs 6. evde iş ve sağlık konularında sıradışı yaklaşımlar vardır.',
      deepExplanation:
          'Geleneksel olmayan iş ortamı. Teknoloji sektörü. Alternatif sağlık yöntemleri. Sinir sistemi hassasiyeti.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 6. Ev',
      relatedTerms: ['Uranüs', '6. Ev', 'İş'],
    ),
    GlossaryEntry(
      term: 'Uranus in 7th House',
      termTr: 'Uranüs 7. Evde',
      hint: 'Sıradışı ilişkiler',
      definition: 'Uranüs 7. evde ilişkiler sıradışı, özgür ve değişkendir.',
      deepExplanation:
          'Geleneksel olmayan ilişki biçimleri. Ani evlilik veya ayrılık. Eksantrik partner. Bağımsızlık ihtiyacı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 7. Ev',
      relatedTerms: ['Uranüs', '7. Ev', 'Ortaklık'],
    ),
    GlossaryEntry(
      term: 'Uranus in 8th House',
      termTr: 'Uranüs 8. Evde',
      hint: 'Ani dönüşümler',
      definition:
          'Uranüs 8. evde dönüşümler ani ve beklenmedik şekilde gerçekleşir.',
      deepExplanation:
          'Beklenmedik miras veya kayıp. Cinsel özgürleşme. Okült ilgileri araştırma. Ani krizler ve uyanışlar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 8. Ev',
      relatedTerms: ['Uranüs', '8. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Uranus in 9th House',
      termTr: 'Uranüs 9. Evde',
      hint: 'Devrimci felsefe',
      definition: 'Uranüs 9. evde dünya görüşü özgün ve geleneksel değildir.',
      deepExplanation:
          'Radikal inanç sistemi. Alternatif eğitim. Ani uzak seyahatler. Astroloji ve bilime ilgi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 9. Ev',
      relatedTerms: ['Uranüs', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Uranus in 10th House',
      termTr: 'Uranüs 10. Evde',
      hint: 'Sıradışı kariyer',
      definition: 'Uranüs 10. evde kariyer yolu sıradışı ve değişkendir.',
      deepExplanation:
          'Birden fazla farklı kariyer. Teknoloji veya yenilikle tanınma. Ani kariyer değişiklikleri. Otorite ile çatışma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 10. Ev',
      relatedTerms: ['Uranüs', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Uranus in 11th House',
      termTr: 'Uranüs 11. Evde',
      hint: 'Devrimci arkadaşlar',
      definition:
          'Uranüs 11. evde kendi evindedir, sosyal çevre sıradışı ve yenilikçidir.',
      deepExplanation:
          'Eksantrik arkadaşlar. Reformcu gruplar. Teknoloji toplulukları. İdealler radikal ve ilerici.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 11. Ev',
      relatedTerms: ['Uranüs', '11. Ev', 'İdealler'],
    ),
    GlossaryEntry(
      term: 'Uranus in 12th House',
      termTr: 'Uranüs 12. Evde',
      hint: 'Gizli dahi',
      definition:
          'Uranüs 12. evde sezgisel zeka ve bilinçaltı içgörüler güçlüdür.',
      deepExplanation:
          'Ani spiritüel uyanışlar. Gizli yenilikçi fikirler. Kolektif bilinçle bağlantı. Kurumlarda reformcu.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Uranüs - 12. Ev',
      relatedTerms: ['Uranüs', '12. Ev', 'Bilinçaltı'],
    ),
    // Neptün tüm evlerde
    GlossaryEntry(
      term: 'Neptune in 1st House',
      termTr: 'Neptün 1. Evde',
      hint: 'Mistik ve hassas',
      definition:
          'Neptün 1. evde hassas, empatik ve mistik bir kişilik gösterir.',
      deepExplanation:
          'Bulanık kimlik. Güçlü empati. Sanatsal yetenekler. Fiziksel sınırlar belirsiz. Karizmatik ama kaygan.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 1. Ev',
      relatedTerms: ['Neptün', '1. Ev', 'Sezgi'],
    ),
    GlossaryEntry(
      term: 'Neptune in 2nd House',
      termTr: 'Neptün 2. Evde',
      hint: 'Belirsiz finans',
      definition:
          'Neptün 2. evde para konuları belirsiz veya idealist olabilir.',
      deepExplanation:
          'Finansal yanılsamalar. Para gelir ve gider. Sanat veya spiritüel işlerden gelir. Değerler idealist.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 2. Ev',
      relatedTerms: ['Neptün', '2. Ev', 'Değerler'],
    ),
    GlossaryEntry(
      term: 'Neptune in 3rd House',
      termTr: 'Neptün 3. Evde',
      hint: 'Hayal gücü zengin',
      definition: 'Neptün 3. evde düşünce sezgisel ve hayal gücü güçlüdür.',
      deepExplanation:
          'Şiirsel ifade. Dağınık düşünce. Kardeşlerle karmik bağ. Telepatik yetenek.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 3. Ev',
      relatedTerms: ['Neptün', '3. Ev', 'Hayal Gücü'],
    ),
    GlossaryEntry(
      term: 'Neptune in 4th House',
      termTr: 'Neptün 4. Evde',
      hint: 'Mistik aile',
      definition:
          'Neptün 4. evde aile ve ev konularında yanılsamalar veya idealleştirme olabilir.',
      deepExplanation:
          'Aile sırları. Ev ortamında kaçış ihtiyacı. Deniz kenarı ev tercihi. Anne figürü idealize edilmiş.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 4. Ev',
      relatedTerms: ['Neptün', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Neptune in 5th House',
      termTr: 'Neptün 5. Evde',
      hint: 'Romantik hayalci',
      definition: 'Neptün 5. evde yaratıcılık ve romantizm idealize edilir.',
      deepExplanation:
          'Sanatsal ilham. Platonik aşklar. Çocuklarla spiritüel bağ. Kumar ve spekülasyonda dikkat.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 5. Ev',
      relatedTerms: ['Neptün', '5. Ev', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'Neptune in 6th House',
      termTr: 'Neptün 6. Evde',
      hint: 'Hassas sağlık',
      definition:
          'Neptün 6. evde sağlık hassas ve iş ortamı belirsiz olabilir.',
      deepExplanation:
          'Teşhis konulması zor hastalıklar. Alternatif şifa yöntemleri. İş sınırları belirsiz. Hizmet idealizmi.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 6. Ev',
      relatedTerms: ['Neptün', '6. Ev', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Neptune in 7th House',
      termTr: 'Neptün 7. Evde',
      hint: 'İdealize edilmiş partner',
      definition:
          'Neptün 7. evde ilişkilerde yanılsamalar ve idealleştirme belirgindir.',
      deepExplanation:
          'Partneri idealize etme. Ruh eşi arayışı. İlişkilerde sınır sorunları. Aldatılma veya aldatma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 7. Ev',
      relatedTerms: ['Neptün', '7. Ev', 'İlişkiler'],
    ),
    GlossaryEntry(
      term: 'Neptune in 8th House',
      termTr: 'Neptün 8. Evde',
      hint: 'Mistik dönüşüm',
      definition:
          'Neptün 8. evde dönüşümler spiritüel ve gizemli boyutlarda yaşanır.',
      deepExplanation:
          'Mistik deneyimler. Miras konularında karışıklık. Psişik yetenekler. Ölüm ve sonrası merakı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 8. Ev',
      relatedTerms: ['Neptün', '8. Ev', 'Gizem'],
    ),
    GlossaryEntry(
      term: 'Neptune in 9th House',
      termTr: 'Neptün 9. Evde',
      hint: 'Spiritüel arayış',
      definition:
          'Neptün 9. evde felsefe ve inanç sistemi mistik ve spiritüeldir.',
      deepExplanation:
          'Evrensel bilinç arayışı. Spiritüel seyahatler. Guru figürüne dikkat. Şiirsel felsefe.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 9. Ev',
      relatedTerms: ['Neptün', '9. Ev', 'Spiritüellik'],
    ),
    GlossaryEntry(
      term: 'Neptune in 10th House',
      termTr: 'Neptün 10. Evde',
      hint: 'Kamusal ilham',
      definition:
          'Neptün 10. evde kariyer sanat, şifa veya spiritüel alanlarda olabilir.',
      deepExplanation:
          'Kamusal figür olarak ilham verici. Kariyer yolu belirsiz. Film, müzik, şifa meslekleri. İtibar dalgalanmaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 10. Ev',
      relatedTerms: ['Neptün', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Neptune in 11th House',
      termTr: 'Neptün 11. Evde',
      hint: 'İdealist arkadaşlar',
      definition:
          'Neptün 11. evde arkadaşlıklar ve gruplar idealist veya yanıltıcı olabilir.',
      deepExplanation:
          'Spiritüel gruplar. Arkadaşlarda aldanma riski. İnsani idealler. Kolektif bilinç çalışmaları.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Neptün - 11. Ev',
      relatedTerms: ['Neptün', '11. Ev', 'İdealler'],
    ),
    // Pluto tüm evlerde
    GlossaryEntry(
      term: 'Pluto in 1st House',
      termTr: 'Pluto 1. Evde',
      hint: 'Yoğun ve güçlü',
      definition:
          'Pluto 1. evde yoğun kişilik, güç ve dönüşüm kapasitesi belirgindir.',
      deepExplanation:
          'Manyetik çekim. Güç arayışı. Fiziksel dönüşümler. Çevreyi etkileyen varlık. Kontrol ihtiyacı.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 1. Ev',
      relatedTerms: ['Pluto', '1. Ev', 'Güç'],
    ),
    GlossaryEntry(
      term: 'Pluto in 2nd House',
      termTr: 'Pluto 2. Evde',
      hint: 'Finansal güç',
      definition:
          'Pluto 2. evde para ve değerler konusunda yoğun deneyimler ve dönüşümler yaşanır.',
      deepExplanation:
          'Finansal krizler ve yeniden doğuşlar. Para ile güç ilişkisi. Değerlerin derin dönüşümü. Kaynak kontrolü.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 2. Ev',
      relatedTerms: ['Pluto', '2. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Pluto in 3rd House',
      termTr: 'Pluto 3. Evde',
      hint: 'Derin düşünce',
      definition: 'Pluto 3. evde düşünce ve iletişim derin ve araştırıcıdır.',
      deepExplanation:
          'Penetran zeka. Kardeşlerle güç dinamikleri. Söz gücü. Tabular hakkında yazma veya konuşma.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 3. Ev',
      relatedTerms: ['Pluto', '3. Ev', 'Zeka'],
    ),
    GlossaryEntry(
      term: 'Pluto in 4th House',
      termTr: 'Pluto 4. Evde',
      hint: 'Aile dönüşümü',
      definition:
          'Pluto 4. evde aile ve ev konularında derin dönüşümler ve güç dinamikleri vardır.',
      deepExplanation:
          'Aile sırları ve dönüşümü. Baskın ebeveyn. Köklerle derin bağ. Ev ortamında yoğunluk.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 4. Ev',
      relatedTerms: ['Pluto', '4. Ev', 'Aile'],
    ),
    GlossaryEntry(
      term: 'Pluto in 5th House',
      termTr: 'Pluto 5. Evde',
      hint: 'Tutkulu yaratıcılık',
      definition:
          'Pluto 5. evde yaratıcılık ve romantizm yoğun ve dönüştürücüdür.',
      deepExplanation:
          'Sanatla dönüşüm. Tutkulu aşklar. Çocuklarla güç mücadeleleri. Risk alma obsesyonu.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 5. Ev',
      relatedTerms: ['Pluto', '5. Ev', 'Tutku'],
    ),
    GlossaryEntry(
      term: 'Pluto in 6th House',
      termTr: 'Pluto 6. Evde',
      hint: 'Şifa gücü',
      definition:
          'Pluto 6. evde iş ve sağlık konularında dönüştürücü güç vardır.',
      deepExplanation:
          'Şifa yetenekleri. İş ortamında güç dinamikleri. Sağlık krizleri ve yenilenme. Hizmet aracılığıyla dönüşüm.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 6. Ev',
      relatedTerms: ['Pluto', '6. Ev', 'Şifa'],
    ),
    GlossaryEntry(
      term: 'Pluto in 7th House',
      termTr: 'Pluto 7. Evde',
      hint: 'Dönüştürücü ilişkiler',
      definition:
          'Pluto 7. evde ilişkiler yoğun, dönüştürücü ve güç odaklı olabilir.',
      deepExplanation:
          'İlişkilerde güç mücadeleleri. Partner aracılığıyla dönüşüm. Kontrol konuları. Derin bağlar veya ayrılıklar.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 7. Ev',
      relatedTerms: ['Pluto', '7. Ev', 'İlişkiler'],
    ),
    GlossaryEntry(
      term: 'Pluto in 9th House',
      termTr: 'Pluto 9. Evde',
      hint: 'Felsefi dönüşüm',
      definition:
          'Pluto 9. evde inanç sistemi ve dünya görüşü derin dönüşümler geçirir.',
      deepExplanation:
          'İnançların radikal değişimi. Yabancı deneyimlerde yoğunluk. Fanatizm riski. Öğretmenlik gücü.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 9. Ev',
      relatedTerms: ['Pluto', '9. Ev', 'Felsefe'],
    ),
    GlossaryEntry(
      term: 'Pluto in 10th House',
      termTr: 'Pluto 10. Evde',
      hint: 'Kariyer gücü',
      definition:
          'Pluto 10. evde kariyer ve toplumsal konum aracılığıyla güç ve dönüşüm yaşanır.',
      deepExplanation:
          'Güçlü kariyer hırsı. Otorite figürü. Kamusal dönüşümler. Yükseliş ve düşüşler.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 10. Ev',
      relatedTerms: ['Pluto', '10. Ev', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Pluto in 11th House',
      termTr: 'Pluto 11. Evde',
      hint: 'Grup gücü',
      definition:
          'Pluto 11. evde gruplar ve sosyal ağlar aracılığıyla güç ve dönüşüm deneyimlenir.',
      deepExplanation:
          'Gruplar üzerinde etki. Radikal idealler. Arkadaşlıklarda güç dinamikleri. Kolektif dönüşüm.',
      category: GlossaryCategory.houses,
      planetInHouse: 'Pluto - 11. Ev',
      relatedTerms: ['Pluto', '11. Ev', 'Gruplar'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // EK TERİMLER (Geleneksel, Lunar, Vedik, vb.)
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _additionalTerms = [
    GlossaryEntry(
      term: 'New Moon',
      termTr: 'Yeni Ay',
      hint: 'Yeni başlangıçlar',
      definition:
          'Ay ve Güneş aynı burçta kavuştuğunda oluşur. Yeni döngülerin, niyetlerin ve başlangıçların zamanı.',
      deepExplanation:
          'Her ayın en karanlık gecesi, tohumların toprak altında beklemesi gibidir. Bu dönem içe dönüş, niyet belirleme ve yeni projelere zemin hazırlama için idealdir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dolunay', 'Kavuşum', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Full Moon',
      termTr: 'Dolunay',
      hint: 'Farkındalık ve tamamlanma',
      definition:
          'Ay ve Güneş karşıt burçlarda olduğunda oluşur. Farkındalık, sonuçlar ve duygusal zirve zamanı.',
      deepExplanation:
          'Dolunay, döngünün zirvesidir. Başlattığımız işlerin meyve verdiği, gerçeklerin aydınlandığı ve duyguların yoğunlaştığı zamandır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeni Ay', 'Karşıtlık', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Lunar Eclipse',
      termTr: 'Ay Tutulması',
      hint: 'Duygusal dönüm noktası',
      definition:
          'Dünya, Güneş ile Ay arasına girdiğinde gerçekleşir. Güçlendirilmiş dolunay etkisi, önemli kapanışlar.',
      deepExplanation:
          'Ay tutulmaları, gölgemizin duygusal dünyamıza düşmesidir. Bastırılmış duygular yüzeye çıkar, ilişkilerde ve iç dünyamızda kritik dönüm noktaları yaşanır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Güneş Tutulması', 'Dolunay', 'Düğümler'],
    ),
    GlossaryEntry(
      term: 'Solar Eclipse',
      termTr: 'Güneş Tutulması',
      hint: 'Yeni yön ve kader',
      definition:
          'Ay, Dünya ile Güneş arasına girdiğinde gerçekleşir. Güçlendirilmiş yeni ay etkisi, kadersel yeni başlangıçlar.',
      deepExplanation:
          'Güneş tutulmaları kozmiği "reset" tuşlarıdır. Hayatın önemli alanlarında yeni kapılar açılır, eski kimlikler dönüşür.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ay Tutulması', 'Yeni Ay', 'Düğümler'],
    ),
    GlossaryEntry(
      term: 'Decan',
      termTr: 'Dekan',
      hint: 'Burcun 10 derecelik bölümü',
      definition:
          'Her burcu üçe bölen 10 derecelik dilimler. Her dekan, burcun farklı bir alt tonunu temsil eder.',
      deepExplanation:
          'Birinci dekan saf burç enerjisi taşır. İkinci ve üçüncü dekanlar sırasıyla aynı elementin diğer burçlarının etkisini ekler.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Burç', 'Derece', 'Element'],
    ),
    GlossaryEntry(
      term: 'Dispositor',
      termTr: 'Yönetici',
      hint: 'Gezegenin ev sahibi',
      definition:
          'Bir gezegenin bulunduğu burcun yöneticisi. Örneğin Mars Boğa\'daysa, Venüs Mars\'ın dispositorudur.',
      deepExplanation:
          'Dispositor zinciri haritanın gizli patronunu ortaya çıkarır. Final dispositor, tüm haritanın enerjisinin aktığı noktadır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yönetici Gezegen', 'Burç', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Intercepted Sign',
      termTr: 'Kuşatılmış Burç',
      definition:
          'Bir evin içinde tamamen kalan, hiçbir ev sınırına dokunmayan burç.',
      hint: 'Gizli enerji deposu',
      deepExplanation:
          'Kuşatılmış burçlar bastırılmış enerjiyi temsil eder. Bu burcun özellikleri zorla açığa çıkarılmalıdır.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Ev', 'Cusp', 'Burç'],
    ),
    GlossaryEntry(
      term: 'Stellium',
      termTr: 'Yığılım',
      hint: 'Üç+ gezegen bir burçta',
      definition:
          'Üç veya daha fazla gezegenin aynı burçta veya evde toplanması. Yoğun enerji odağı.',
      deepExplanation:
          'Stellium, yaşamın belirli bir alanına aşırı odaklanma gösterir. Güçlü yetenekler ama denge sorunu olabilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kavuşum', 'Ev', 'Burç'],
    ),
    GlossaryEntry(
      term: 'Mutual Reception',
      termTr: 'Karşılıklı Kabul',
      hint: 'Gezegenlerin ev değişimi',
      definition:
          'İki gezegen birbirinin burçlarında olduğunda oluşur (Mars Boğa\'da, Venüs Koç\'ta gibi).',
      deepExplanation:
          'Karşılıklı kabul, iki gezegen arasında özel bir işbirliği yaratır. Her iki enerjiye de kolay erişim sağlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dispositor', 'Onur', 'Yönetici'],
    ),
    GlossaryEntry(
      term: 'Out of Bounds',
      termTr: 'Sınır Dışı',
      hint: 'Aşırı gezegen enerjisi',
      definition:
          'Bir gezegenin ekliptiğin normal sınırlarının (±23.5°) dışına çıkması.',
      deepExplanation:
          'Sınır dışı gezegenler aşırı veya sıradışı davranır. Dahi veya marjinal ifade biçimleri.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ekliptik', 'Gezegen'],
    ),
    GlossaryEntry(
      term: 'Cazimi',
      termTr: 'Cazimi',
      hint: 'Güneşin kalbinde',
      definition:
          'Bir gezegenin Güneş\'e 17 yay dakikası içinde yaklaşması. En güçlü konum.',
      deepExplanation:
          'Cazimi, kralla yüz yüze görüşmektir. Yanık olma tehlikesi yerine, özel güç ve koruma sağlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yanık', 'Güneş', 'Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Combust',
      termTr: 'Yanık',
      hint: 'Güneşe çok yakın',
      definition:
          'Bir gezegenin Güneş\'e 8.5 derece içinde yaklaşması. Gezegenin enerjisi zayıflar.',
      deepExplanation:
          'Yanık gezegen, Güneş\'in ışığında görünmez olur. O gezegenin temaları bilinçte gölgelenir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Cazimi', 'Güneş', 'Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Aspect Pattern',
      termTr: 'Açı Kalıbı',
      hint: 'Geometrik gezegen yapıları',
      definition:
          'Üç veya daha fazla gezegen arasında oluşan geometrik yapılar (T-Kare, Büyük Üçgen, Yod vb.).',
      deepExplanation:
          'Açı kalıpları haritanın dinamik yapısını gösterir. Bu kalıplar kişiliğin temel motivasyonlarını belirler.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['T-Kare', 'Büyük Üçgen', 'Yod'],
    ),
    GlossaryEntry(
      term: 'Grand Cross',
      termTr: 'Büyük Haç',
      hint: 'Dört gezegen karşılıklı kare',
      definition:
          'Dört gezegen birbirleriyle kare ve karşıtlık yaparak haç oluşturur. Yoğun gerilim ve dinamizm.',
      deepExplanation:
          'Büyük haç, dört yönden gelen baskıdır. Çok zorlu ama ustalaşıldığında büyük başarı potansiyeli.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['T-Kare', 'Kare', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Kite',
      termTr: 'Uçurtma',
      hint: 'Üçgen + karşıtlık',
      definition:
          'Büyük üçgene bir karşıtlık eklendiğinde oluşur. Yetenekleri harekete geçiren yapı.',
      deepExplanation:
          'Uçurtma, büyük üçgenin pasifliğini kırar. Karşıtlık noktası, yeteneklerin dışa ifade edildiği yerdir.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Büyük Üçgen', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Mystic Rectangle',
      termTr: 'Mistik Dikdörtgen',
      hint: 'Uyumlu geometrik yapı',
      definition:
          'İki karşıtlık, iki üçgen ve iki altıgen içeren dikdörtgen şekil.',
      deepExplanation:
          'Mistik dikdörtgen, zıtlıkları uyumla birleştirme yeteneği verir. İç denge ve pratik bilgelik.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Karşıtlık', 'Üçgen', 'Altıgen'],
    ),
    GlossaryEntry(
      term: 'Semi-Sextile',
      termTr: 'Yarı Altıgen',
      hint: 'Hafif gerilim (30°)',
      definition:
          'İki gezegen 30° açı yaptığında oluşur. Hafif rahatsızlık ve adaptasyon gerektirir.',
      deepExplanation:
          'Yan yana burçlar doğal olarak uyumsuz. Bu küçük sürtüşme farkındalık ve ayarlama gerektirir.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Altıgen', 'Açı'],
    ),
    GlossaryEntry(
      term: 'Semi-Square',
      termTr: 'Yarı Kare',
      hint: 'Gizli gerilim (45°)',
      definition:
          'İki gezegen 45° açı yaptığında oluşur. İç gerilim ve tahriş.',
      deepExplanation:
          'Yarı kare, karenin küçük kardeşidir. Daha az belirgin ama sürekli bir rahatsızlık hissi yaratır.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Kare', 'Sesquiquadrate'],
    ),
    GlossaryEntry(
      term: 'Sesquiquadrate',
      termTr: 'Bir Buçuk Kare',
      hint: 'Aktif gerilim (135°)',
      definition:
          'İki gezegen 135° açı yaptığında oluşur. Kare ve karşıtlık arası gerilim.',
      deepExplanation:
          'Sesquiquadrate, çözülmesi gereken bir iç çatışmayı gösterir. Agresif enerji çıkışı.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Kare', 'Yarı Kare'],
    ),
    GlossaryEntry(
      term: 'Quintile',
      termTr: 'Beşgen',
      hint: 'Yaratıcı yetenek (72°)',
      definition:
          'İki gezegen 72° açı yaptığında oluşur. Özel yaratıcı yetenekler.',
      deepExplanation:
          'Beşgen açılar dahi potansiyelini gösterir. Sıradışı, özgün ve yaratıcı ifade biçimleri.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Açı', 'Yaratıcılık'],
    ),
    GlossaryEntry(
      term: 'South Node',
      termTr: 'Güney Düğümü (Ketu)',
      hint: 'Geçmiş yaşam yetenekleri',
      definition:
          'Kuzey Düğümünün karşısında, geçmiş yaşam kalıpları ve doğal yetenekleri gösterir.',
      deepExplanation:
          'Güney Düğümü konfor zonumuzdur. Buradan gelen yetenekler doğaldır ama aşırı bağlanmak büyümeyi engeller.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Kuzey Düğümü', 'Karma', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Lunar Return',
      termTr: 'Ay Dönüşü',
      hint: 'Aylık duygusal döngü',
      definition:
          'Ay\'ın doğum haritasındaki pozisyonuna dönmesi. Her ay gerçekleşir.',
      deepExplanation:
          'Ay dönüşü haritası, önümüzdeki ayın duygusal tonunu gösterir. Kişisel döngüleri anlamak için kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Güneş Dönüşü', 'Ay', 'Transit'],
    ),
    GlossaryEntry(
      term: 'Profection',
      termTr: 'Profeksiyon',
      hint: 'Yıllık ev aktivasyonu',
      definition:
          'Her yaşta bir sonraki evin aktifleştiği geleneksel teknik. 1 yaş = 2. ev, 12 yaş = 1. ev.',
      deepExplanation:
          'Profeksiyon, o yılın ana temasını belirler. Aktif evin yöneticisi "yıl lordu" olur.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ev', 'Transit', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Zodiacal Releasing',
      termTr: 'Zodyak Serbest Bırakma',
      hint: 'Helenistik zamanlama',
      definition:
          'Spirit veya Fortune Lotundan başlayan uzun dönemli zamanlama tekniği.',
      deepExplanation:
          'Bu teknik yaşamın büyük dönemlerini gösterir. Kariyer zirveleri ve duygusal olgunlaşma dönemleri.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Şans Noktası', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Firdaria',
      termTr: 'Firdaria',
      hint: 'Gezegen dönemleri',
      definition:
          'Gezegenler tarafından yönetilen yaşam dönemleri sistemi. Ortaçağ astroloji tekniği.',
      deepExplanation:
          'Her gezegen belirli yıllarda yaşamı yönetir. Güneş 10 yıl, Ay 9 yıl gibi dönemler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Zamanlama', 'Gezegen'],
    ),
    GlossaryEntry(
      term: 'Antiscion',
      termTr: 'Antisyon',
      hint: 'Gizli bağlantı noktası',
      definition:
          'Bir gezegenin 0° Yengeç-Oğlak eksenine göre yansıma noktası.',
      deepExplanation:
          'Antisyon noktaları gizli bağlantılar gösterir. Bu noktadaki transit veya natal gezegen gizli etkileşim yaratır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Açı', 'Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Lot of Spirit',
      termTr: 'Ruh Noktası',
      hint: 'Ruhsal amaç',
      definition:
          'Yükselen + Güneş - Ay formülüyle hesaplanan nokta. Kariyer ve eylem yönelimi.',
      deepExplanation:
          'Şans Noktasının tersine hesaplanır. Bilinçli iradeyle yapılanları, profesyonel yaşamı gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Şans Noktası', 'Kariyer'],
    ),
    GlossaryEntry(
      term: 'Sect',
      termTr: 'Sekt (Gündüz/Gece)',
      hint: 'Haritanın takımı',
      definition:
          'Güneş ufkun üstündeyse gündüz doğumu, altındaysa gece doğumu. Gezegen güçlerini etkiler.',
      deepExplanation:
          'Gündüz doğumlarında Güneş, Jüpiter, Satürn güçlenir. Gece doğumlarında Ay, Venüs, Mars güçlenir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Güneş', 'Ay', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Almuten',
      termTr: 'Almuten',
      hint: 'En güçlü yönetici',
      definition:
          'Belirli bir noktada en çok onura sahip gezegen. Geleneksel astrolojide kullanılır.',
      deepExplanation:
          'Almuten hesaplaması yönetim, yücelme, üçlük, sınır ve yüz onurlarını içerir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Yönetici'],
    ),
    GlossaryEntry(
      term: 'Triplicity',
      termTr: 'Üçlük Yöneticileri',
      hint: 'Element yöneticileri',
      definition:
          'Her elementin gündüz ve gece yöneticileri. Ateş-Güneş/Jüpiter, Toprak-Venüs/Ay vb.',
      deepExplanation:
          'Üçlük yöneticileri, gezegenin destek sistemini gösterir. Güçlü üçlük yöneticisi kaynakları bollaştırır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Element', 'Sekt', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Term',
      termTr: 'Sınır',
      hint: 'Küçük onur bölgeleri',
      definition:
          'Her burcu 5 eşit olmayan bölgeye ayıran eski sistem. Gezegenler bu sınırlarda güç kazanır.',
      deepExplanation:
          'Mısır veya Ptolemaik sınırları kullanılır. İnce ayar yorumu için değerlidir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Dekan', 'Yüz'],
    ),
    GlossaryEntry(
      term: 'Face',
      termTr: 'Yüz (Dekan)',
      hint: 'En zayıf onur',
      definition:
          'Her burcu üçe bölen 10 derecelik dilimler. En düşük onur seviyesi.',
      deepExplanation:
          'Bir gezegen sadece yüz onuruna sahipse "arabada oturan yabancı" gibidir - bir şey yapabilir ama güçsüzdür.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Dekan', 'Sınır'],
    ),
    GlossaryEntry(
      term: 'Peregrine',
      termTr: 'Sürgün',
      hint: 'Onursuz gezegen',
      definition: 'Hiçbir onura sahip olmayan gezegen. Evsiz ve güçsüz.',
      deepExplanation:
          'Sürgün gezegen ne yapacağını bilmez, rastgele hareket eder. Dezavantajlı ama özgür.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Onur', 'Düşüş'],
    ),
    GlossaryEntry(
      term: 'Fall',
      termTr: 'Düşüş',
      hint: 'Gezegenin en zayıf hali',
      definition: 'Gezegenin yücelme burcunun karşısında olması. En zor konum.',
      deepExplanation:
          'Düşüşteki gezegen derin dersler öğretir. Güçsüzlükten bilgelik doğar. Satürn Koç\'ta, Güneş Terazi\'de.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yücelme', 'Onur', 'Sürgün'],
    ),
    GlossaryEntry(
      term: 'Exaltation',
      termTr: 'Yücelme',
      hint: 'Gezegenin onur konuğu',
      definition:
          'Gezegenin özellikle güçlü olduğu burç. Güneş-Koç, Ay-Boğa, Merkür-Başak vb.',
      deepExplanation:
          'Yücelmede gezegen misafir olarak ağırlanır. Doğal değil ama çok saygı görür.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Düşüş', 'Onur', 'Yönetim'],
    ),
    GlossaryEntry(
      term: 'Rulership',
      termTr: 'Yönetim',
      hint: 'Gezegenin kendi evi',
      definition:
          'Gezegenin doğal olarak yönettiği burç. Mars-Koç, Venüs-Boğa vb.',
      deepExplanation:
          'Yönetimde gezegen kendi evindedir, istediği gibi davranır. En rahat ve güçlü konum.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Sürgün', 'Onur', 'Yücelme'],
    ),
    GlossaryEntry(
      term: 'Detriment',
      termTr: 'Zıt Burç',
      hint: 'Karşı evde gezegen',
      definition:
          'Gezegenin yönettiği burcun karşısında olması. Mars-Terazi, Venüs-Koç vb.',
      deepExplanation:
          'Zıt burçta gezegen başkasının kurallarına uymak zorundadır. Zorlu ama büyütücü deneyim.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yönetim', 'Onur'],
    ),
    // Daha fazla terim
    GlossaryEntry(
      term: 'Waxing Moon',
      termTr: 'Büyüyen Ay',
      hint: 'Genişleme ve büyüme zamanı',
      definition:
          'Yeni Ay\'dan Dolunay\'a kadar olan dönem. Ay ışığı artarken yeni projelere başlamak için idealdir.',
      deepExplanation:
          'Büyüyen Ay dönemlerinde enerji dışa doğru akar. Tohum ekme, yeni başlangıçlar ve büyüme için uygun.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeni Ay', 'Dolunay', 'Azalan Ay'],
    ),
    GlossaryEntry(
      term: 'Waning Moon',
      termTr: 'Azalan Ay',
      hint: 'İçe dönüş ve tamamlama',
      definition:
          'Dolunay\'dan Yeni Ay\'a kadar olan dönem. Tamamlama, bırakma ve içe dönüş zamanı.',
      deepExplanation:
          'Azalan Ay dönemlerinde enerji içe doğru akar. Temizlik, meditasyon ve sonlandırma için ideal.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dolunay', 'Yeni Ay', 'Büyüyen Ay'],
    ),
    GlossaryEntry(
      term: 'Balsamic Moon',
      termTr: 'Balsamik Ay',
      hint: 'Döngünün son nefesi',
      definition:
          'Yeni Ay\'dan önceki son 3-4 gün. Derin içe dönüş, rüyalar ve vizyonlar dönemi.',
      deepExplanation:
          'En karanlık gece, en derin sezgi. Bu dönemde doğanlar önceki döngülerin bilgeliğini taşır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeni Ay', 'Azalan Ay'],
    ),
    GlossaryEntry(
      term: 'Angular Houses',
      termTr: 'Açısal Evler',
      hint: 'En güçlü evler (1, 4, 7, 10)',
      definition:
          'Yükselen, IC, Descendant ve MC noktalarından başlayan evler. Haritanın köşe taşları.',
      deepExplanation:
          'Açısal evlerdeki gezegenler çok güçlüdür, hayatta belirgin ve görünür etkiler yaratır.',
      category: GlossaryCategory.houses,
      relatedTerms: ['1. Ev', '4. Ev', '7. Ev', '10. Ev'],
    ),
    GlossaryEntry(
      term: 'Succedent Houses',
      termTr: 'Takip Eden Evler',
      hint: 'İstikrar evleri (2, 5, 8, 11)',
      definition:
          'Açısal evleri takip eden evler. Kaynaklar, değerler ve sürdürülebilirlik.',
      deepExplanation:
          'Takip eden evler, açısal evlerin başlattıklarını pekiştirir ve destekler.',
      category: GlossaryCategory.houses,
      relatedTerms: ['2. Ev', '5. Ev', '8. Ev', '11. Ev'],
    ),
    GlossaryEntry(
      term: 'Cadent Houses',
      termTr: 'Düşen Evler',
      hint: 'Adaptasyon evleri (3, 6, 9, 12)',
      definition:
          'Açısal evlerden önce gelen evler. Öğrenme, hazırlık ve adaptasyon.',
      deepExplanation:
          'Düşen evlerdeki gezegenler daha az görünür ama derin iç işleyişi etkiler.',
      category: GlossaryCategory.houses,
      relatedTerms: ['3. Ev', '6. Ev', '9. Ev', '12. Ev'],
    ),
    GlossaryEntry(
      term: 'Fire Element',
      termTr: 'Ateş Elementi',
      hint: 'Yaratıcılık ve eylem',
      definition:
          'Koç, Aslan ve Yay burçları. Enerji, tutku, ilham ve spontanlık.',
      deepExplanation:
          'Ateş elementi yaratıcı kıvılcımı temsil eder. Yang enerjisi, dışa dönük ve aktif.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Koç', 'Aslan', 'Yay', 'Element'],
    ),
    GlossaryEntry(
      term: 'Earth Element',
      termTr: 'Toprak Elementi',
      hint: 'Pratiklik ve istikrar',
      definition:
          'Boğa, Başak ve Oğlak burçları. Dayanıklılık, pratiklik, güvenlik ve somutluk.',
      deepExplanation:
          'Toprak elementi maddi dünyayı temsil eder. Yin enerjisi, içe dönük ve kararlı.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Boğa', 'Başak', 'Oğlak', 'Element'],
    ),
    GlossaryEntry(
      term: 'Air Element',
      termTr: 'Hava Elementi',
      hint: 'İletişim ve düşünce',
      definition:
          'İkizler, Terazi ve Kova burçları. Düşünce, iletişim, sosyallik ve fikirler.',
      deepExplanation:
          'Hava elementi zihinsel dünyayı temsil eder. Yang enerjisi, değişken ve hareketli.',
      category: GlossaryCategory.signs,
      relatedTerms: ['İkizler', 'Terazi', 'Kova', 'Element'],
    ),
    GlossaryEntry(
      term: 'Water Element',
      termTr: 'Su Elementi',
      hint: 'Duygular ve sezgi',
      definition:
          'Yengeç, Akrep ve Balık burçları. Duygu, sezgi, empati ve derinlik.',
      deepExplanation:
          'Su elementi duygusal dünyayı temsil eder. Yin enerjisi, akıcı ve adapte olabilen.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Yengeç', 'Akrep', 'Balık', 'Element'],
    ),
    GlossaryEntry(
      term: 'Ceres',
      termTr: 'Ceres',
      hint: 'Beslenme ve bakım',
      definition:
          'Beslenme, bakım ve anne-çocuk ilişkisini temsil eden cüce gezegen/asteroit.',
      deepExplanation:
          'Ceres, toprak ana arketipidir. Nasıl beslendiğimizi ve başkalarını nasıl beslediğimizi gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Ay', 'Yengeç'],
    ),
    GlossaryEntry(
      term: 'Pallas Athena',
      termTr: 'Pallas',
      hint: 'Bilgelik ve strateji',
      definition:
          'Bilgelik, strateji, yaratıcı zeka ve savunuculuğu temsil eden asteroit.',
      deepExplanation:
          'Pallas, savaşçı bilgelik arketipidir. Kalıp tanıma, adalet ve yaratıcı problem çözme.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Merkür', 'Başak'],
    ),
    GlossaryEntry(
      term: 'Juno',
      termTr: 'Juno',
      hint: 'Evlilik ve bağlılık',
      definition:
          'Evlilik, uzun vadeli ortaklık ve bağlılığı temsil eden asteroit.',
      deepExplanation:
          'Juno, ruh eşi arketipidir. Partnerde ne aradığımızı ve evlilik dinamiklerini gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Venüs', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Vesta',
      termTr: 'Vesta',
      hint: 'Adanmışlık ve kutsal ateş',
      definition:
          'Adanmışlık, odaklanma, kutsallık ve hizmeti temsil eden asteroit.',
      deepExplanation:
          'Vesta, kutsal rahibeler arketipidir. Neye adandığımızı ve spiritüel odağımızı gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Başak', '6. Ev'],
    ),
    GlossaryEntry(
      term: 'Midpoint',
      termTr: 'Orta Nokta',
      hint: 'İki gezegenin birleşim noktası',
      definition:
          'İki gezegen arasındaki tam orta nokta. Uranian astrolojide önemli teknik.',
      deepExplanation:
          'Orta noktalar, iki gezegenin enerjisinin birleştiği hassas noktadır. Özellikle Güneş/Ay orta noktası önemlidir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Açı', 'Uranyan Astroloji'],
    ),
    GlossaryEntry(
      term: 'Composite Chart',
      termTr: 'Kompozit Harita',
      hint: 'İlişkinin haritası',
      definition:
          'İki kişinin gezegenlerinin orta noktalarından oluşturulan, ilişkinin kendisinin haritası.',
      deepExplanation:
          'Kompozit harita, ilişkinin ayrı bir varlık olarak karakterini gösterir. Sinastri\'den farklı bir yaklaşım.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sinastri', 'Orta Nokta', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Davison Chart',
      termTr: 'Davison Haritası',
      hint: 'İlişkinin doğum anı',
      definition:
          'İki kişinin doğum zamanlarının ve yerlerinin ortalamasından oluşturulan ilişki haritası.',
      deepExplanation:
          'Davison haritası, ilişkinin gerçek bir doğum anı ve yerini temsil eder. Kompozit\'e alternatif.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kompozit Harita', 'Sinastri'],
    ),
    GlossaryEntry(
      term: 'Relocation Chart',
      termTr: 'Taşınma Haritası',
      hint: 'Farklı yerin etkisi',
      definition:
          'Doğum haritasını farklı bir coğrafi konum için yeniden hesaplama.',
      deepExplanation:
          'Aynı zaman, farklı yer. Taşınma haritası, belirli bir yerde deneyimlerin nasıl farklılaşacağını gösterir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Astrokartografi', 'Yükselen'],
    ),
    GlossaryEntry(
      term: 'Astrocartography',
      termTr: 'Astrokartografi',
      hint: 'Coğrafi astroloji haritası',
      definition:
          'Gezegenlerin yeryüzünde nerede açısal olduğunu gösteren dünya haritası.',
      deepExplanation:
          'Astrokartografi, her yerin farklı astrolojik etkiler taşıdığını gösterir. Taşınma ve seyahat planlaması için kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Taşınma Haritası', 'Local Space'],
    ),
    GlossaryEntry(
      term: 'Local Space',
      termTr: 'Lokal Uzay',
      hint: 'Çevrenin haritası',
      definition:
          'Gezegenlerın bulunduğunuz yerden hangi yöne düştüğünü gösteren teknik.',
      deepExplanation:
          'Lokal uzay, evinizdeki veya şehrinizdeki belirli yönlerin astrolojik anlamını gösterir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Astrokartografi', 'Açısal Evler'],
    ),
    GlossaryEntry(
      term: 'Heliocentric',
      termTr: 'Güneş Merkezli',
      hint: 'Güneşten bakış',
      definition:
          'Güneş\'in merkezde olduğu, Dünya\'nın da bir gezegen olarak gösterildiği harita sistemi.',
      deepExplanation:
          'Heliosentrik astroloji daha kozmik bir bakış açısı sunar. Ruhsal amaç ve evrensel perspektif.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Geosentrik', 'Güneş'],
    ),
    GlossaryEntry(
      term: 'Geocentric',
      termTr: 'Dünya Merkezli',
      hint: 'Dünyadan bakış',
      definition:
          'Standart astroloji sistemi, Dünya\'nın merkezde olduğu bakış açısı.',
      deepExplanation:
          'Geosentrik astroloji, bireysel deneyimi temsil eder. Günlük yaşam ve kişisel perspektif.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Heliosentrik'],
    ),
    GlossaryEntry(
      term: 'Sidereal Zodiac',
      termTr: 'Sabit Zodyak',
      hint: 'Yıldız tabanlı burçlar',
      definition:
          'Sabit yıldızlara göre hesaplanan burçlar. Vedik astrolojide kullanılır.',
      deepExplanation:
          'Sabit zodyak, tropik zodyaktan yaklaşık 24 derece geridedir (Ayanamsa). Hint astrolojisinin temelidir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tropik Zodyak', 'Vedik Astroloji', 'Ayanamsa'],
    ),
    GlossaryEntry(
      term: 'Tropical Zodiac',
      termTr: 'Tropik Zodyak',
      hint: 'Mevsim tabanlı burçlar',
      definition:
          'Mevsimlere göre hesaplanan burçlar. Batı astrolojisinde standart.',
      deepExplanation:
          'Tropik zodyak, ilkbahar ekinoksunu Koç\'un başlangıcı olarak alır. Mevsimsel döngülerle bağlantılı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Zodyak', 'Batı Astrolojisi'],
    ),
    GlossaryEntry(
      term: 'Ayanamsa',
      termTr: 'Ayanamsa',
      hint: 'Tropik-Sidereal farkı',
      definition:
          'Tropik ve sidereal zodyak arasındaki derece farkı (yaklaşık 24°).',
      deepExplanation:
          'Presesyon hareketi nedeniyle her yıl biraz artan fark. Lahiri, Raman gibi farklı ayanamsa sistemleri var.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Zodyak', 'Tropik Zodyak'],
    ),
    GlossaryEntry(
      term: 'Vedic Astrology',
      termTr: 'Vedik Astroloji',
      hint: 'Hint astroloji sistemi',
      definition:
          'Jyotish olarak da bilinen antik Hint astroloji sistemi. Sidereal zodyak kullanır.',
      deepExplanation:
          'Vedik astroloji karma, dharma ve moksha kavramlarını içerir. Dasha sistemleri ve özel teknikler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Zodyak', 'Ayanamsa', 'Dasha'],
      references: [
        GlossaryReference(
          title: 'Light on Life',
          author: 'Hart de Fouw',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Dasha',
      termTr: 'Dasha',
      hint: 'Vedik gezegen dönemleri',
      definition:
          'Vedik astrolojide gezegenlerin yönettiği yaşam dönemleri sistemi.',
      deepExplanation:
          'Vimshottari Dasha en yaygın kullanılan sistemdir. 120 yıllık döngü, Ay\'ın Nakshatra\'sından başlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Vedik Astroloji', 'Nakshatra'],
    ),
    GlossaryEntry(
      term: 'Nakshatra',
      termTr: 'Nakshatra',
      hint: 'Ay konaklama evleri',
      definition:
          'Vedik astrolojide kullanılan 27 ay konağı. Her biri 13°20\' genişliğinde.',
      deepExplanation:
          'Nakshatralar, Ay\'ın gecelik hareketini yansıtır. Her birinin özel sembolizmi ve yöneticisi var.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Vedik Astroloji', 'Ay', 'Dasha'],
    ),
    GlossaryEntry(
      term: 'Benefic',
      termTr: 'Hayırlı Gezegen',
      hint: 'Olumlu etki',
      definition:
          'Geleneksel olarak olumlu etki veren gezegenler: Jüpiter ve Venüs.',
      deepExplanation:
          'Büyük hayırlı (Jüpiter) ve küçük hayırlı (Venüs). Ancak ev yöneticiliğine göre değişebilir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Zararlı Gezegen', 'Jüpiter', 'Venüs'],
    ),
    GlossaryEntry(
      term: 'Malefic',
      termTr: 'Zararlı Gezegen',
      hint: 'Zorlayıcı etki',
      definition: 'Geleneksel olarak zorluk veren gezegenler: Satürn ve Mars.',
      deepExplanation:
          'Büyük zararlı (Satürn) ve küçük zararlı (Mars). Ancak ev yöneticiliğine göre olumlu olabilir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Hayırlı Gezegen', 'Satürn', 'Mars'],
    ),
    GlossaryEntry(
      term: 'Joy',
      termTr: 'Neşe (Gezegen Sevinci)',
      hint: 'Gezegenin en mutlu evi',
      definition:
          'Her gezegenin en mutlu olduğu ev. Merkür 1. evde, Ay 3. evde vb.',
      deepExplanation:
          'Gezegen sevinçleri, Helenistik astrolojiden gelir. Joy\'daki gezegen o evin konularında kolaylık sağlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Ev'],
    ),
    GlossaryEntry(
      term: 'Whole Sign Houses',
      termTr: 'Tam Burç Evleri',
      hint: 'Burç = Ev sistemi',
      definition:
          'Her burcun tam olarak bir evi oluşturduğu en eski ev sistemi.',
      deepExplanation:
          'Yükselen burcun tamamı 1. evdir. Helenistik astrolojide standart, modern astrolojide yeniden popülerleşiyor.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Placidus', 'Ev', 'Yükselen'],
    ),
    GlossaryEntry(
      term: 'Placidus',
      termTr: 'Placidus',
      hint: 'Yaygın ev sistemi',
      definition: 'Modern Batı astrolojisinde en yaygın kullanılan ev sistemi.',
      deepExplanation:
          'Zaman tabanlı hesaplama. Yüksek enlemlerde sorunlu olabilir. 17. yüzyıldan beri popüler.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Tam Burç Evleri', 'Ev', 'Koch'],
    ),
    GlossaryEntry(
      term: 'Primary Directions',
      termTr: 'Birincil Direktiyonlar',
      hint: 'En eski tahmin tekniği',
      definition:
          'Gökyüzünün günlük dönüşüne dayanan tahmin tekniği. 1° = 1 yıl.',
      deepExplanation:
          'Antik çağların ana tahmin yöntemiydi. Karmaşık ama çok kesin sonuçlar verebilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Progresyonlar', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Circumambulation',
      termTr: 'Çevreleme',
      hint: 'Gezegen hareketi takibi',
      definition:
          'Bir gezegenin açısal noktalara veya diğer gezegenlere yaklaşmasını takip etme.',
      deepExplanation:
          'Helenistik astrolojide önemli zamanlama tekniği. Gezegenin evleri "dolaşması".',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Birincil Direktiyonlar', 'Profeksiyon'],
    ),
    GlossaryEntry(
      term: 'Doryphory',
      termTr: 'Mızrak Taşıyıcı',
      hint: 'Güneşin öncüsü',
      definition:
          'Güneş\'ten önce doğan gezegen. Güneş\'e yol açan, onu koruyan güç.',
      deepExplanation:
          'Helenistik kavram. Doryphory güçlü ise kişi güçlü destekçilere sahiptir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Güneş', 'Sekt'],
    ),
    GlossaryEntry(
      term: 'Hayz',
      termTr: 'Hayz',
      hint: 'Gezegen uyumu',
      definition:
          'Bir gezegenin cinsiyetine uygun burç ve evin yarısında olması.',
      deepExplanation:
          'Gündüz doğumunda eril gezegen ufkun üstünde, eril burçta = tam hayz. Güç ve etkinlik artışı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sekt', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Contra-Antiscia',
      termTr: 'Karşı Antisyon',
      hint: 'Gizli karşıtlık',
      definition:
          'Antisyon noktasının karşısı. Gizli gerilim veya bağlantı gösterir.',
      deepExplanation:
          '0° Koç-Terazi eksenine göre yansıma. Antisyondan daha zorlu bir bağlantı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Antisyon', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Besiegement',
      termTr: 'Kuşatma',
      hint: 'İki zararlı arasında sıkışma',
      definition:
          'Bir gezegenin Mars ve Satürn arasında kalması. Çok zorlu konum.',
      deepExplanation:
          'Antik metinlerde kötü şöhretli durum. Modern yorumda yoğun baskı ve zorlu dersler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Zararlı Gezegen', 'Mars', 'Satürn'],
    ),
    GlossaryEntry(
      term: 'Under the Beams',
      termTr: 'Işınlar Altında',
      hint: 'Güneşe yakın ama yanık değil',
      definition:
          'Güneş\'e 17 derece içinde olan gezegen. Zayıflamış ama yanık değil.',
      deepExplanation:
          'Yanık kadar kötü değil ama gezegen gizlenmiş durumda. Güneş\'in gölgesinde.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yanık', 'Cazimi', 'Güneş'],
    ),
    GlossaryEntry(
      term: 'Sect Light',
      termTr: 'Sekt Işığı',
      hint: 'Gündüz/gece ışıltısı',
      definition:
          'Gündüz doğumlarında Güneş, gece doğumlarında Ay. Haritanın ana ışığı.',
      deepExplanation:
          'Sekt ışığı, haritanın tonunu belirler. Güçlü konumda olması genel yaşam kalitesini artırır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sekt', 'Güneş', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Hyleg',
      termTr: 'Hyleg (Yaşam Vericisi)',
      hint: 'Ömür göstergesi',
      definition:
          'Yaşam uzunluğu ve sağlık gücünü gösteren nokta. Güneş, Ay veya Yükselen olabilir.',
      deepExplanation:
          'Ortaçağ astrolojisinin önemli kavramı. Hyleg\'in alcochodeni (yönetici) ömrü belirler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Alcochoden', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Alcochoden',
      termTr: 'Alcochoden',
      hint: 'Ömür yöneticisi',
      definition:
          'Hyleg\'in en güçlü yöneticisi. Ömür hesaplamasında kullanılır.',
      deepExplanation:
          'Karmaşık hesaplama sistemi. Modern astrolojide daha az kullanılır ama geleneksel astrolojide önemli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Hyleg', 'Ömür'],
    ),
    GlossaryEntry(
      term: 'Prenatal Lunation',
      termTr: 'Doğum Öncesi Lunasyon',
      hint: 'Doğumdan önceki Ay fazı',
      definition: 'Doğumdan hemen önce gerçekleşen yeni ay veya dolunay.',
      deepExplanation:
          'Prenatal lunasyon, ruhun dünyaya geliş koşullarını gösterir. Özellikle tutulma ise çok önemli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeni Ay', 'Dolunay', 'Tutulma'],
    ),
    GlossaryEntry(
      term: 'Syzygy',
      termTr: 'Sizigi',
      hint: 'Ay-Güneş hizalanması',
      definition:
          'Yeni ay veya dolunay anı. Güneş, Ay ve Dünya\'nın hizalanması.',
      deepExplanation:
          'Sizigi noktaları enerji kapılarıdır. Özellikle tutulma sizigisi çok güçlüdür.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeni Ay', 'Dolunay', 'Tutulma'],
    ),
    GlossaryEntry(
      term: 'Dragon\'s Head',
      termTr: 'Ejder Başı',
      hint: 'Kuzey Düğümünün diğer adı',
      definition: 'Kuzey Ay Düğümünün geleneksel adı. Gelecek ve büyüme yönü.',
      deepExplanation:
          'Hint mitolojisinde Rahu. Ejder başı, tutkulara ve arzu nesnesine doğru çeker.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Kuzey Düğümü', 'Ejder Kuyruğu', 'Düğümler'],
    ),
    GlossaryEntry(
      term: 'Dragon\'s Tail',
      termTr: 'Ejder Kuyruğu',
      hint: 'Güney Düğümünün diğer adı',
      definition:
          'Güney Ay Düğümünün geleneksel adı. Geçmiş ve bırakılması gerekenler.',
      deepExplanation:
          'Hint mitolojisinde Ketu. Ejder kuyruğu, eski kalıpları ve aşılması gereken bağımlılıkları gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Güney Düğümü', 'Ejder Başı', 'Düğümler'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // DAHA FAZLA TERİM (300+ hedefi için)
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _moreTerms = [
    GlossaryEntry(
      term: 'Fixed Stars',
      termTr: 'Sabit Yıldızlar',
      hint: 'Zodyak dışı yıldızlar',
      definition:
          'Gezegen dışı yıldızların astrolojik etkileri. Regulus, Algol, Spica gibi.',
      deepExplanation:
          'Sabit yıldızlar özel yetenekler veya zorluklar verir. Gezegenlerle kavuşumda çok güçlü etki.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Regulus', 'Algol', 'Behenian Stars'],
    ),
    GlossaryEntry(
      term: 'Regulus',
      termTr: 'Regulus',
      hint: 'Kralın yıldızı',
      definition:
          'Aslan takımyıldızının kalp yıldızı. Şöhret, liderlik ve kraliyet bağlantıları.',
      deepExplanation:
          'Dört kraliyet yıldızından biri. Büyük başarı vaat eder ama intikamdan kaçınmayı öğretir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar', 'Aslan'],
    ),
    GlossaryEntry(
      term: 'Algol',
      termTr: 'Algol',
      hint: 'Şeytan yıldızı',
      definition:
          'Perseus takımyıldızında yer alan değişken yıldız. Medusa\'nın başı olarak bilinir.',
      deepExplanation:
          'Zor bir yıldız ama doğru kullanıldığında büyük güç ve koruma sağlar. Kadınların intikamı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar'],
    ),
    GlossaryEntry(
      term: 'Lunar Mansion',
      termTr: 'Ay Evi',
      hint: 'Ay\'ın gecelik konakları',
      definition:
          'Ay\'ın zodyak etrafındaki 28 günlük yolculuğundaki konak noktaları.',
      deepExplanation:
          'Arap astrolojisinde menziller, Hint astrolojisinde nakshatralar. Her birinin özel etkisi var.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Nakshatra', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Parallel',
      termTr: 'Paralel',
      hint: 'Deklinasyon açısı',
      definition:
          'İki gezegenin aynı deklinasyonda olması. Kavuşum gibi etki eder.',
      deepExplanation:
          'Deklinasyon, gezegenin ekvatora uzaklığıdır. Paraleller gizli kavuşumlardır.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Kavuşum', 'Kontra-paralel'],
    ),
    GlossaryEntry(
      term: 'Contra-parallel',
      termTr: 'Kontra-paralel',
      hint: 'Karşı deklinasyon',
      definition:
          'İki gezegenin aynı deklinasyonda ama farklı yarıkürelerde olması. Karşıtlık gibi.',
      deepExplanation:
          'Bir gezegen kuzeyde, diğeri güneyde aynı derecede. Gizli karşıtlık enerjisi.',
      category: GlossaryCategory.aspects,
      relatedTerms: ['Paralel', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Aphelion',
      termTr: 'Afelyon',
      hint: 'Güneşten en uzak',
      definition: 'Bir gezegenin yörüngesinde Güneş\'e en uzak olduğu nokta.',
      deepExplanation:
          'Afelyonda gezegen enerjisi daha içe dönük ve yansıtıcı.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Perihelyon', 'Yörünge'],
    ),
    GlossaryEntry(
      term: 'Perihelion',
      termTr: 'Perihelyon',
      hint: 'Güneşe en yakın',
      definition: 'Bir gezegenin yörüngesinde Güneş\'e en yakın olduğu nokta.',
      deepExplanation:
          'Perihelyonda gezegen enerjisi daha yoğun ve dışa dönük.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Afelyon', 'Yörünge'],
    ),
    GlossaryEntry(
      term: 'Ingress',
      termTr: 'Giriş',
      hint: 'Burç değişimi',
      definition: 'Bir gezegenin yeni bir burca girmesi anı.',
      deepExplanation:
          'Giriş anları önemli dönüm noktalarıdır. Özellikle Güneş\'in öncü burçlara girişi (ekinoks/gündönümü).',
      category: GlossaryCategory.basics,
      relatedTerms: ['Transit', 'Cusp'],
    ),
    GlossaryEntry(
      term: 'Equinox',
      termTr: 'Ekinoks',
      hint: 'Gece-gündüz eşitliği',
      definition:
          'Gece ve gündüzün eşit olduğu an. İlkbahar (Koç) ve Sonbahar (Terazi) ekinoksları.',
      deepExplanation:
          'İlkbahar ekinoksu tropik zodyakın başlangıcıdır. Denge ve yeni döngü enerjisi.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Gündönümü', 'Koç', 'Terazi'],
    ),
    GlossaryEntry(
      term: 'Solstice',
      termTr: 'Gündönümü',
      hint: 'En uzun/kısa gün',
      definition:
          'Yaz (Yengeç) ve Kış (Oğlak) gündönümü. Güneş\'in en yüksek ve alçak noktaları.',
      deepExplanation:
          'Gündönümü, ışığın zirve ve dip noktalarıdır. Güçlü manifestasyon ve içe dönüş zamanları.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Ekinoks', 'Yengeç', 'Oğlak'],
    ),
    GlossaryEntry(
      term: 'Ephemeris',
      termTr: 'Efemeris',
      hint: 'Gezegen pozisyon tablosu',
      definition:
          'Gezegenlerin günlük pozisyonlarını gösteren tablo veya kitap.',
      deepExplanation:
          'Astrolojinin temel referans kaynağı. Modern yazılımlar efemeris hesaplamalarını otomatik yapar.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Transit', 'Hesaplama'],
    ),
    GlossaryEntry(
      term: 'Ephemeris Time',
      termTr: 'Efemeris Zamanı',
      hint: 'Astronomik zaman',
      definition: 'Gezegen hesaplamalarında kullanılan standart zaman sistemi.',
      deepExplanation:
          'UTC\'den farklı, Dünya\'nın yavaşlamasını hesaba katan düzeltilmiş zaman.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Efemeris', 'Hesaplama'],
    ),
    GlossaryEntry(
      term: 'Rectification',
      termTr: 'Rektifikasyon',
      hint: 'Doğum zamanı düzeltme',
      definition:
          'Bilinmeyen veya belirsiz doğum zamanını yaşam olayları kullanarak belirleme.',
      deepExplanation:
          'Karmaşık ve uzmanlık gerektiren teknik. Geçmiş olayların tarihleri ve gelecek tahminleri kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Doğum Haritası', 'Yükselen'],
    ),
    GlossaryEntry(
      term: 'Mundane Astrology',
      termTr: 'Dünya Astrolojisi',
      hint: 'Kolektif olayların astrolojisi',
      definition:
          'Ülkeler, dünya olayları ve toplumsal hareketlerin astrolojisi.',
      deepExplanation:
          'Tutulmalar, büyük kavuşumlar ve ülke haritaları kullanılır. Siyasi ve ekonomik tahminler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tutulma', 'Büyük Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Financial Astrology',
      termTr: 'Finansal Astroloji',
      hint: 'Piyasa astrolojisi',
      definition:
          'Finansal piyasaları ve ekonomik döngüleri analiz eden astroloji dalı.',
      deepExplanation:
          'Gezegen döngüleri ve ekonomik trendler arasındaki ilişkiyi inceler. W.D. Gann gibi tüccarlar kullandı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dünya Astrolojisi', 'Döngüler'],
    ),
    GlossaryEntry(
      term: 'Medical Astrology',
      termTr: 'Tıbbi Astroloji',
      hint: 'Sağlık astrolojisi',
      definition:
          'Sağlık eğilimleri ve hastalık zamanlamalarını inceleyen astroloji dalı.',
      deepExplanation:
          'Her burç ve ev vücudun farklı bölgeleriyle ilişkilidir. Hipokrat zamanından beri kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['6. Ev', 'Sağlık', 'Dekanlar'],
    ),
    GlossaryEntry(
      term: 'Decumbiture',
      termTr: 'Dekümbitür',
      hint: 'Hastalık başlangıç haritası',
      definition:
          'Hastalığın başladığı veya kişinin yatağa düştüğü an için çıkarılan harita.',
      deepExplanation:
          'Tıbbi astrolojide kullanılan geleneksel teknik. Hastalığın seyri ve iyileşme tahmini.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tıbbi Astroloji', 'Horary'],
    ),
    GlossaryEntry(
      term: 'Astrometeorology',
      termTr: 'Astro-meteoroloji',
      hint: 'Hava durumu astrolojisi',
      definition: 'Gezegen konumlarından hava durumu tahmin etme sanatı.',
      deepExplanation:
          'En eski astroloji dallarından biri. Çiftçiler ve denizciler için önemliydi.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dünya Astrolojisi'],
    ),
    GlossaryEntry(
      term: 'Cosmobiology',
      termTr: 'Kozmobiyoloji',
      hint: 'Alman astroloji okulu',
      definition:
          'Alfred Witte ve Reinhold Ebertin\'in geliştirdiği modern astroloji sistemi.',
      deepExplanation:
          'Orta noktalar, yarım toplamlar ve 90 derece kadran kullanır. Uranyan astroloji ile bağlantılı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Orta Nokta', 'Uranyan Astroloji'],
    ),
    GlossaryEntry(
      term: 'Psychological Astrology',
      termTr: 'Psikolojik Astroloji',
      hint: 'Derinlik psikolojisi yaklaşımı',
      definition:
          'Jung ve derinlik psikolojisini astrolojiyle birleştiren modern yaklaşım.',
      deepExplanation:
          'Arketipler, gölge çalışması ve bireyselleşme sürecini astrolojik sembollerle birleştirir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Jung', 'Arketip'],
      references: [
        GlossaryReference(
          title: 'The Astrological Neptune',
          author: 'Liz Greene',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Evolutionary Astrology',
      termTr: 'Evrimsel Astroloji',
      hint: 'Ruh evrimi yaklaşımı',
      definition:
          'Ruhun evrimini ve geçmiş yaşam kalıplarını inceleyen astroloji okulu.',
      deepExplanation:
          'Pluto ve Ay düğümlerine odaklanır. Jeff Green ve Steven Forrest tarafından popülerleştirildi.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Pluto', 'Ay Düğümleri', 'Karma'],
      references: [
        GlossaryReference(
          title: 'Pluto: The Evolutionary Journey',
          author: 'Jeff Green',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Aspect Grid',
      termTr: 'Açı Tablosu',
      hint: 'Gezegen açıları matrisi',
      definition: 'Tüm gezegen çiftleri arasındaki açıları gösteren tablo.',
      deepExplanation:
          'Haritayı hızlıca analiz etmek için kullanılır. Hangi gezegenlerin bağlantılı olduğunu gösterir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Açı', 'Doğum Haritası'],
    ),
    GlossaryEntry(
      term: 'Chart Ruler',
      termTr: 'Harita Yöneticisi',
      hint: 'Yükselenin yöneticisi',
      definition:
          'Yükselen burcun yöneticisi gezegen. Haritanın en önemli gezegenlerinden.',
      deepExplanation:
          'Harita yöneticisinin konumu, açıları ve durumu kişiliği derinden şekillendirir.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yükselen', 'Yönetici Gezegen'],
    ),
    GlossaryEntry(
      term: 'Final Dispositor',
      termTr: 'Son Dispositor',
      hint: 'Zincirin sonu',
      definition: 'Dispositor zincirinin sonunda, kendi burcunda olan gezegen.',
      deepExplanation:
          'Tüm haritanın enerjisi bu gezegene akar. Haritanın gizli patronu.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dispositor', 'Yönetici'],
    ),
    GlossaryEntry(
      term: 'Singleton',
      termTr: 'Singleton',
      hint: 'Yalnız gezegen',
      definition:
          'Haritanın bir bölgesinde tek başına olan gezegen. Özel önem taşır.',
      deepExplanation:
          'Hemisphere, element veya modalite singleton olabilir. Fokus noktası ve tek başına güç.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yığılım', 'Element'],
    ),
    GlossaryEntry(
      term: 'Bowl Pattern',
      termTr: 'Kase Kalıbı',
      hint: 'Yarım haritada toplanan gezegenler',
      definition:
          'Tüm gezegenler haritanın yarısında toplandığında oluşan kalıp.',
      deepExplanation:
          'Kase kalıbı tek taraflı odaklanma gösterir. Boş yarı kendini tamamlama alanı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kova Kalıbı', 'Açı Kalıbı'],
    ),
    GlossaryEntry(
      term: 'Bucket Pattern',
      termTr: 'Kova Kalıbı',
      hint: 'Kase + sap gezegen',
      definition:
          'Kase kalıbı artı karşı tarafta bir gezegen. Sap gezegen çok önemli.',
      deepExplanation:
          'Sap gezegen, enerjinin dışa aktığı nokta. Liderlik ve fokus alanı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kase Kalıbı', 'Singleton'],
    ),
    GlossaryEntry(
      term: 'Locomotive Pattern',
      termTr: 'Lokomotif Kalıbı',
      hint: '240 derece içinde gezegenler',
      definition: 'Gezegenler haritanın 2/3\'üne yayıldığında oluşan kalıp.',
      deepExplanation:
          'Öncü gezegen lokomotifi çeker. Güçlü motivasyon ve itme gücü.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Açı Kalıbı', 'Kase Kalıbı'],
    ),
    GlossaryEntry(
      term: 'Splay Pattern',
      termTr: 'Yelpaze Kalıbı',
      hint: 'Düzensiz dağılım',
      definition:
          'Gezegenler haritaya düzensiz ama belirli gruplarda dağıldığında.',
      deepExplanation:
          'Bireycilik ve çeşitlilik gösterir. Çok yönlü yetenekler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Açı Kalıbı'],
    ),
    GlossaryEntry(
      term: 'Bundle Pattern',
      termTr: 'Demet Kalıbı',
      hint: 'Dar alanda toplanan gezegenler',
      definition:
          'Tüm gezegenler 120 derece veya daha az alanda toplandığında.',
      deepExplanation:
          'Çok yoğun odaklanma ama dar bakış açısı. Uzmanlaşma potansiyeli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yığılım', 'Açı Kalıbı'],
    ),
    GlossaryEntry(
      term: 'See-Saw Pattern',
      termTr: 'Tahterevalli Kalıbı',
      hint: 'İki karşıt grupta gezegenler',
      definition: 'Gezegenler karşılıklı iki grupta toplandığında.',
      deepExplanation:
          'İç çatışma ve denge arayışı. Her iki tarafın ihtiyaçlarını dengeleme.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Karşıtlık', 'Açı Kalıbı'],
    ),
    GlossaryEntry(
      term: 'Splash Pattern',
      termTr: 'Sıçrama Kalıbı',
      hint: 'Eşit dağılım',
      definition: 'Gezegenler haritanın tamamına eşit dağıldığında.',
      deepExplanation:
          'Evrensel ilgi ve çok yönlülük. Odaklanma zorluğu olabilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Açı Kalıbı'],
    ),
    GlossaryEntry(
      term: 'Part of Marriage',
      termTr: 'Evlilik Noktası',
      hint: 'Arap noktası',
      definition: 'Evlilik ve ortaklık konularını gösteren Arap noktası.',
      deepExplanation:
          'Formül: Yükselen + Descendant - Venüs. Evlilik potansiyeli ve türü.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Şans Noktası', 'Arap Noktaları', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Part of Death',
      termTr: 'Ölüm Noktası',
      hint: 'Arap noktası',
      definition: 'Dönüşüm ve sonlanma konularını gösteren Arap noktası.',
      deepExplanation:
          'Formül: Yükselen + 8. ev cusp - Ay. Fiziksel ölümden çok dönüşümleri gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Şans Noktası', 'Arap Noktaları', '8. Ev'],
    ),
    GlossaryEntry(
      term: 'Turning Point',
      termTr: 'Dönüm Noktası',
      hint: 'Kritik derece',
      definition:
          'Haritada özellikle hassas ve kritik dereceler. Örneğin burç değişim noktaları.',
      deepExplanation:
          '0° ve 29° özellikle hassas. Anaretic derece (29°) bitirme ve son şans enerjisi.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Cusp', 'Kritik Derece'],
    ),
    GlossaryEntry(
      term: 'Critical Degree',
      termTr: 'Kritik Derece',
      hint: 'Hassas noktalar',
      definition: 'Her burcun 0°, 13°, 26° gibi özellikle güçlü dereceleri.',
      deepExplanation:
          'Kritik derecelerdeki gezegenler daha belirgin etki gösterir. Bazı geleneklerde farklı dereceler.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Derece', 'Dönüm Noktası'],
    ),
    GlossaryEntry(
      term: 'Anaretic Degree',
      termTr: 'Anaretik Derece (29°)',
      hint: 'Son derece',
      definition:
          'Her burcun 29. derecesi. Bitirme, kriz ve aciliyet enerjisi.',
      deepExplanation:
          '29° gezegenler eski işleri bitirmek zorundadır. Kararsızlık veya ustalık.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Kritik Derece', 'Cusp'],
    ),
    GlossaryEntry(
      term: 'Avatar Degree',
      termTr: 'Avatar Derecesi (15°)',
      hint: 'Burcun kalbi',
      definition:
          'Her burcun 15. derecesi, burcun en saf ifadesini temsil eder.',
      deepExplanation: '15° burcun tam ortası, en güçlü ve kararlı noktası.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Derece', 'Burç'],
    ),
    GlossaryEntry(
      term: 'Exalted Degree',
      termTr: 'Yücelme Derecesi',
      hint: 'Gezegenin yükseldiği spesifik derece',
      definition: 'Her gezegenin yüceldiği burcun spesifik derecesi.',
      deepExplanation:
          'Güneş 19° Koç, Ay 3° Boğa gibi. Bu derecelere transit çok güçlü.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yücelme', 'Onur'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // EZOTERİK VE SPİRİTÜEL KAVRAMLAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _esotericTerms = [
    GlossaryEntry(
      term: 'Karma',
      termTr: 'Karma',
      hint: 'Ruhsal neden-sonuç yasası',
      definition:
          'Geçmiş yaşamlardaki eylemlerimizin bu yaşama etkisi. Astrolojide özellikle Ay Düğümleri ve Satürn ile bağlantılı.',
      deepExplanation:
          'Karma, ceza değil öğrenme fırsatıdır. Güney Düğümü geçmiş yaşam alışkanlıklarını, Kuzey Düğümü ruhun evrimsel hedefini gösterir. Satürn\'ün evdeki konumu karmik derslerimizi işaret eder.',
      example:
          'Satürn 7. evde ilişkilerde olgunlaşma gerektiren karmik dersler gösterir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ay Düğümleri', 'Satürn', 'Reenkarnasyon'],
    ),
    GlossaryEntry(
      term: 'Reincarnation',
      termTr: 'Reenkarnasyon',
      hint: 'Ruhun yeniden doğumu',
      definition:
          'Ruhun farklı bedenlerde tekrar tekrar doğması inancı. Ezoterik astrolojinin temel kavramlarından.',
      deepExplanation:
          'Doğum haritası, ruhun bu yaşam için seçtiği dersleri ve görevleri gösterir. Ay Düğümleri ekseninde geçmiş ve gelecek yaşamların ipuçları okunur.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Karma', 'Ay Düğümleri', 'Ruh Amacı'],
    ),
    GlossaryEntry(
      term: 'Soul Purpose',
      termTr: 'Ruh Amacı',
      hint: 'Bu yaşamın anlamı',
      definition:
          'Ruhun bu enkarnasyonda gerçekleştirmek istediği temel amaç ve dersler.',
      deepExplanation:
          'Kuzey Ay Düğümü, Güneş ve MC üçgeni ruh amacının ana göstergeleridir. Bunların birbiriyle açıları ve ev konumları yaşam yolunu belirler.',
      example:
          'Kuzey Düğüm Koç\'ta = Bu yaşamda bağımsızlık ve liderlik geliştirme amacı.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kuzey Düğüm', 'MC', 'Güneş'],
    ),
    GlossaryEntry(
      term: 'Shadow Self',
      termTr: 'Gölge Benlik',
      hint: 'Bastırılmış yönler',
      definition:
          'Bilinçaltına ittiğimiz, kabul etmediğimiz kişilik yönleri. Jung psikolojisinden astrolojiye uyarlanan kavram.',
      deepExplanation:
          'Pluto, 12. ev ve Güney Düğüm gölge benliği gösterir. Descendant\'taki özellikler de başkalarına yansıttığımız gölge yanlarımızdır.',
      example:
          'Terazi Yükselen - Koç Descendant: Agresyonumuzu bastırıp partnerlere yansıtırız.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['12. Ev', 'Pluto', 'Descendant'],
    ),
    GlossaryEntry(
      term: 'Akashic Records',
      termTr: 'Akaşik Kayıtlar',
      hint: 'Evrensel hafıza',
      definition:
          'Tüm ruhların tüm yaşamlarının kaydedildiğine inanılan kozmik hafıza bankası.',
      deepExplanation:
          'Ezoterik astrologlar doğum haritasını akaşik kayıtlara bir pencere olarak görür. Neptün ve 12. ev bu kayıtlara erişimi simgeler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Reenkarnasyon', 'Neptün', '12. Ev'],
    ),
    GlossaryEntry(
      term: 'Higher Self',
      termTr: 'Yüksek Benlik',
      hint: 'İlahi özümüz',
      definition:
          'Ego\'nun ötesindeki, evrensel bilgeliğe bağlı ruhsal özümüz.',
      deepExplanation:
          'Güneş ego\'yu, Neptün ve 12. ev yüksek benliği temsil eder. Güneş-Neptün açıları ego ve ruhsal öz arasındaki ilişkiyi gösterir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Neptün', '12. Ev', 'Güneş'],
    ),
    GlossaryEntry(
      term: 'Spiritual Awakening',
      termTr: 'Spiritüel Uyanış',
      hint: 'Bilinç genişlemesi',
      definition: 'Maddi dünyadan daha yüksek gerçekliklere açılma süreci.',
      deepExplanation:
          'Uranüs, Neptün ve Pluto transitleri sıklıkla spiritüel uyanışı tetikler. Özellikle bu dış gezegenlerin iç gezegenlere yaptığı sert açılar dönüştürücüdür.',
      example:
          'Pluto natal Güneş\'e kare = Ego ölümü ve yeniden doğuş, derinden dönüşüm.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Uranüs', 'Neptün', 'Pluto'],
    ),
    GlossaryEntry(
      term: 'Kundalini',
      termTr: 'Kundalini',
      hint: 'Ruhsal enerji yılanı',
      definition:
          'Omurga tabanında uyuyan ve uyanınca yukarı yükselen spiritüel enerji.',
      deepExplanation:
          'Pluto ve Akrep kundalini enerjisiyle ilişkilendirilir. Pluto transitleri kundalini aktivasyonunu tetikleyebilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Pluto', 'Akrep', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Archetype',
      termTr: 'Arketip',
      hint: 'Evrensel kalıp',
      definition:
          'Kolektif bilinçaltında bulunan evrensel semboller ve kalıplar. Her gezegen ve burç bir arketipi temsil eder.',
      deepExplanation:
          'Gezegenler tanrı arketipleridir: Mars=Savaşçı, Venüs=Aşık, Satürn=Bilge Yaşlı. Burçlar ise bu enerjilerin nasıl ifade edildiğini gösterir.',
      example: 'Mars Koç\'ta = Savaşçı arketipin en saf hali.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Gezegen', 'Burç', 'Jung'],
    ),
    GlossaryEntry(
      term: 'Chakra',
      termTr: 'Çakra',
      hint: 'Enerji merkezi',
      definition:
          'Bedendeki enerji merkezleri. Her çakra belirli gezegenler ve burçlarla ilişkilendirilir.',
      deepExplanation:
          'Kök çakra=Satürn/Oğlak, Sakral=Ay/Yengeç, Solar Plexus=Mars/Güneş, Kalp=Venüs, Boğaz=Merkür, Üçüncü Göz=Neptün/Jüpiter, Taç=Uranüs.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Gezegen', 'Kundalini', 'Enerji'],
    ),
    GlossaryEntry(
      term: 'Past Life',
      termTr: 'Geçmiş Yaşam',
      hint: 'Önceki enkarnasyonlar',
      definition: 'Ruhun bu yaşamdan önce deneyimlediği diğer yaşamlar.',
      deepExplanation:
          'Güney Düğüm, 12. ev ve Satürn geçmiş yaşam ipuçları verir. 12. evdeki gezegenler geçmiş yaşamdan getirilen yetenekler veya korkular olabilir.',
      example:
          '12. evde Merkür = Geçmiş yaşamda yazar, öğretmen veya tüccar olma ihtimali.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Güney Düğüm', '12. Ev', 'Karma'],
    ),
    GlossaryEntry(
      term: 'Collective Unconscious',
      termTr: 'Kolektif Bilinçdışı',
      hint: 'Ortak insanlık hafızası',
      definition:
          'Jung\'un tanımladığı, tüm insanlığın paylaştığı derin bilinçdışı katman.',
      deepExplanation:
          'Dış gezegenler (Uranüs, Neptün, Pluto) kolektif bilinçdışını temsil eder. Bu gezegenlerin nesil transitleri toplumsal dönüşümleri tetikler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Neptün', 'Pluto', 'Jung'],
    ),
    GlossaryEntry(
      term: 'Synchronicity',
      termTr: 'Eşzamanlılık',
      hint: 'Anlamlı tesadüfler',
      definition:
          'Jung\'un tanımladığı, nedensel bağlantısı olmayan ama anlamlı olayların eşzamanlı gerçekleşmesi.',
      deepExplanation:
          'Astroloji senkronisiteye dayanır: Gökyüzü olaylar yaratmaz, onlarla senkronize olur. "Yukarıda ne varsa aşağıda da var."',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Jung', 'Uranüs', 'Kozmik Düzen'],
    ),
    GlossaryEntry(
      term: 'Esoteric Ruler',
      termTr: 'Ezoterik Yönetici',
      hint: 'Ruhsal burç yöneticisi',
      definition:
          'Burçların spiritüel evrimle ilgili gizli yöneticileri. Geleneksel yöneticiden farklı.',
      deepExplanation:
          'Alice Bailey\'nin sisteminde her burcun ezoterik yöneticisi var. Örneğin Koç\'un ezoterik yöneticisi Merkür\'dür (geleneksel Mars yerine).',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Yönetici Gezegen', 'Bailey', 'Ruhsal Evrim'],
    ),
    GlossaryEntry(
      term: 'Seven Rays',
      termTr: 'Yedi Işın',
      hint: 'Kozmik enerji akışları',
      definition:
          'Alice Bailey\'nin ezoterik sisteminde evrenin yedi temel enerji kalitesi.',
      deepExplanation:
          'Her ışın farklı gezegenler ve burçlarla bağlantılı. Ruhun ışını kişiliğin ışınından farklı olabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Bailey', 'Ezoterik Astroloji', 'Ruh'],
    ),
    GlossaryEntry(
      term: 'Aura',
      termTr: 'Aura',
      hint: 'Enerji alanın',
      definition:
          'Canlı varlıkları çevreleyen ve onların enerji durumunu yansıtan görünmez enerji alanı. Her burcun ve gezegenin kendine özgü aura renkleri vardır.',
      deepExplanation:
          'Aura, fiziksel bedenin ötesinde uzanan biyoenerjetik bir alandır. Astrolojide Güneş burcu ana aura rengini, Yükselen fiziksel aurayı, Ay duygusal aurayı etkiler. Neptün ve 12. ev hassas auraları gösterir.',
      example:
          'Aslan burcu altın-sarı aura, Balık burcu mor-leylak tonu aura ile ilişkilendirilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Enerji', 'Neptün', '12. Ev'],
    ),
    GlossaryEntry(
      term: 'Soul Contract',
      termTr: 'Ruh Sözleşmesi',
      hint: 'Doğum öncesi yapılan anlaşmalar',
      definition:
          'Ruhun bu dünyaya gelmeden önce belirlediği yaşam dersleri, ilişkiler ve deneyimler. Kuzey Düğümü ve Satürn ile yakından ilişkili.',
      deepExplanation:
          'Ruh sözleşmesi, enkarnasyondan önce seçilen deneyimler bütünüdür. Doğum haritası bu sözleşmenin bir yansımasıdır. Zor açılar ve evler, ruhun büyümek için seçtiği zorluklardır.',
      example:
          'Satürn 7. evde = ilişkilerde olgunlaşma sözleşmesi, Kiron 10. evde = kariyer yarası şifası sözleşmesi.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Karma', 'Kuzey Düğümü', 'Satürn', 'Yaşam Amacı'],
    ),
    GlossaryEntry(
      term: 'Red Flag',
      termTr: 'Red Flag (Kırmızı Bayrak)',
      hint: 'İlişkilerde uyarı işaretleri',
      definition:
          'Bir kişinin davranışlarında dikkat edilmesi gereken potansiyel sorunlu kalıplar. Her burcun karakteristik red flag\'leri vardır.',
      deepExplanation:
          'Astrolojik red flag\'ler genellikle zor gezegen açıları, bastırılmış gölge yönleri ve dengelenmemiş element/modalitelerden kaynaklanır. Farkındalıkla bu kalıplar dönüştürülebilir.',
      example:
          'Akrep burcunda kontrol takıntısı, Koç burcunda sabırsızlık, Terazi burcunda kararsızlık red flag olabilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Gölge Benlik', 'İlişki Kalıpları', 'Farkındalık'],
    ),
    GlossaryEntry(
      term: 'Green Flag',
      termTr: 'Green Flag (Yeşil Bayrak)',
      hint: 'İlişkilerde olumlu işaretler',
      definition:
          'Bir kişinin sağlıklı, olgun ve güvenilir olduğunu gösteren olumlu davranış kalıpları. Her burcun güçlü green flag\'leri vardır.',
      deepExplanation:
          'Green flag\'ler, kişinin gölge çalışması yapmış, güçlü yanlarını geliştirmiş ve duygusal zekasını kullandığını gösterir. Dengeli element ve modalite dağılımı, uyumlu gezegen açıları green flag\'leri destekler.',
      example:
          'Boğa burcunda sadakat, Yengeç burcunda şefkat, Oğlak burcunda sorumluluk green flag\'lerdir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Duygusal Zeka', 'Olgunluk', 'İlişki Kalıpları'],
    ),
    GlossaryEntry(
      term: 'Subconscious Pattern',
      termTr: 'Bilinçaltı Kalıp',
      hint: 'Farkında olmadan tekrarlanan davranışlar',
      definition:
          'Bilinçaltında kodlanmış ve otomatik olarak tekrarlanan düşünce, duygu ve davranış kalıpları. Ay, 4. ev ve 12. ev ile ilişkili.',
      deepExplanation:
          'Bilinçaltı kalıplar çocukluk deneyimlerinden, aile dinamiklerinden ve belki geçmiş yaşamlardan gelir. Ay burcu temel duygusal kalıpları, 4. ev aile kalıplarını, 12. ev gizli bilinçaltı programlarını gösterir.',
      example:
          'Ay-Satürn karesi = "sevilmek için mükemmel olmalıyım" bilinçaltı kalıbı.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Ay', '4. Ev', '12. Ev', 'İç Çocuk'],
    ),
    GlossaryEntry(
      term: 'Life Purpose',
      termTr: 'Yaşam Amacı',
      hint: 'Ruhun bu hayattaki misyonu',
      definition:
          'Kişinin bu yaşamda gerçekleştirmesi gereken temel misyon ve katkı. Kuzey Düğümü, MC ve Güneş ile belirlenir.',
      deepExplanation:
          'Yaşam amacı tek bir şey değil, çok katmanlı bir yolculuktur. Kuzey Düğümü ruhsal evrim yönünü, MC toplumsal katkıyı, Güneş özü ifade etmeyi gösterir. 10. ev kariyerdeki misyonu işaret eder.',
      example:
          'Kuzey Düğümü 9. evde = öğretmenlik, felsefe veya yabancı kültürlerle ilgili yaşam amacı.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kuzey Düğümü', 'MC', 'Güneş', 'Ruh Sözleşmesi'],
    ),
    GlossaryEntry(
      term: 'Inner Power',
      termTr: 'İçsel Güç',
      hint: 'Doğuştan gelen potansiyel',
      definition:
          'Kişinin doğum haritasında kodlanmış doğal güçler, yetenekler ve potansiyeller. Güneş, Mars ve Pluto ile yakından ilişkili.',
      deepExplanation:
          'İçsel güç, dış onaya bağımlı olmayan özgün güç kaynağıdır. Güneş yaşam enerjisini, Mars eylem gücünü, Pluto dönüşüm gücünü temsil eder. Yükselen burcun elementi güç ifade tarzını gösterir.',
      example:
          'Ateş elementi güçlü = girişimci güç, Su elementi güçlü = sezgisel güç, Toprak güçlü = pratik güç.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Güneş', 'Mars', 'Pluto', 'Element'],
    ),
    GlossaryEntry(
      term: 'Spiritual Transformation',
      termTr: 'Ruhsal Dönüşüm',
      hint: 'Derin içsel değişim',
      definition:
          'Ruhun eski kalıpları bırakıp yeni bilinç düzeyine ulaşma süreci. Pluto, Kiron ve 8. ev ile ilişkili.',
      deepExplanation:
          'Ruhsal dönüşüm genellikle kriz dönemlerinde tetiklenir. Pluto transitleri, Kiron dönüşü ve 8. ev aktivasyonları derin dönüşüm dönemlerini işaret eder. Ölüm-yeniden doğuş döngüsü sembolik düzeyde yaşanır.',
      example:
          'Pluto Yükselene transit = kimlik dönüşümü, tamamen farklı bir insan olarak çıkma.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Pluto', 'Kiron', '8. Ev', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Eclipse',
      termTr: 'Tutulma',
      hint: 'Kozmik kapı açılma anları',
      definition:
          'Güneş veya Ay tutulmaları - astrolojide önemli dönüm noktaları ve kader anları. Düğümlerle bağlantılı.',
      deepExplanation:
          'Tutulmalar Ay Düğümlerinin yakınında gerçekleşir ve karmik kapılar açar. Güneş tutulması yeni başlangıçlar, Ay tutulması tamamlanmalar ve bırakmalar getirir. Etkileri 6 ay öncesinden hissedilebilir.',
      example:
          'Tutulma natal Güneşe denk gelirse = kimlik ve yaşam yönünde önemli değişimler.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Ay Düğümleri', 'Yeni Ay', 'Dolunay', 'Kader'],
    ),
    GlossaryEntry(
      term: 'Flirt Style',
      termTr: 'Flört Stili',
      hint: 'Romantik ilgi çekme tarzı',
      definition:
          'Kişinin romantik ilgi çekmek ve ifade etmek için kullandığı doğal yaklaşım. Venüs ve Mars burçları ile belirlenir.',
      deepExplanation:
          'Venüs nasıl çekici bulunduğumuzu ve aşkı nasıl ifade ettiğimizi, Mars nasıl peşinden koştuğumuzu ve cinsel enerjiyi gösterir. 5. ev romantik ifadeyi, 7. ev ilişki dinamiklerini etkiler.',
      example:
          'Venüs Aslan = dramatik, gösterişli flört stili. Mars Akrep = yoğun, manyetik çekim.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Venüs', 'Mars', '5. Ev', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Leadership Style',
      termTr: 'Liderlik Stili',
      hint: 'Doğal yönetim tarzı',
      definition:
          'Kişinin doğal liderlik yaklaşımı ve başkalarını yönlendirme biçimi. Güneş, Mars ve MC ile belirlenir.',
      deepExplanation:
          'Her burç farklı bir liderlik stili sergiler. Ateş burçları karizmatik, Toprak pratik, Hava entelektüel, Su empatik liderlik yapar. 10. ev profesyonel liderliği, 1. ev kişisel otoriteyi gösterir.',
      example:
          'Güneş Oğlak = geleneksel, disiplinli lider. Güneş Kova = yenilikçi, demokratik lider.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Güneş', 'Mars', 'MC', '10. Ev'],
    ),
    GlossaryEntry(
      term: 'Heartbreak Pattern',
      termTr: 'Kalp Kırıklığı Kalıbı',
      hint: 'Tekrarlayan ilişki yaraları',
      definition:
          'Kişinin ilişkilerde deneyimlediği tekrarlayan acı ve hayal kırıklığı kalıpları. Kiron, Venüs ve 7. ev ile ilişkili.',
      deepExplanation:
          'Kalp kırıklığı kalıpları genellikle çocukluk yaralarından ve bilinçaltı programlardan kaynaklanır. Kiron\'un burcu ve evi yara alanını, Venüs-Satürn/Pluto açıları ilişki korkularını gösterir.',
      example:
          'Kiron 7. evde = ilişkilerde tekrarlayan yaralanma ve onun üzerinden şifa bulma.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Kiron', 'Venüs', '7. Ev', 'İlişki Kalıpları'],
    ),
    GlossaryEntry(
      term: 'Soulmate',
      termTr: 'Ruh Eşi',
      hint: 'Derin ruh bağlantısı',
      definition:
          'Ruhsal düzeyde derin bağ hissedilen kişi. Sinastride özellikle Ay Düğümleri ve iç gezegen bağlantılarıyla belirlenir.',
      deepExplanation:
          'Ruh eşi tek bir kişi değil, farklı yaşam alanlarında karşılaşabileceğimiz birçok ruh olabilir. Kuzey Düğümü-Güneş, Ay-Ay, Venüs-Mars bağlantıları güçlü ruh eşi göstergeleridir.',
      example:
          'Birinin Kuzey Düğümü diğerinin Güneşine denk gelirse = büyümeyi destekleyen ruh eşi bağlantısı.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Ay Düğümleri', 'Kompozit Harita', 'Karma'],
    ),
    GlossaryEntry(
      term: 'Relationship Karma',
      termTr: 'İlişki Karması',
      hint: 'Geçmişten gelen ilişki dersleri',
      definition:
          'Geçmiş yaşamlardan veya bu yaşamın erken dönemlerinden gelen ilişki kalıpları ve dersler. Güney Düğümü ve Satürn ile ilişkili.',
      deepExplanation:
          'İlişki karması, ruhun ilişkiler aracılığıyla öğrenmesi gereken dersleri içerir. Güney Düğümü 7. evde veya ilişki gezegenlerine açı yapıyorsa geçmiş yaşam ilişkileri aktif olabilir.',
      example:
          'Satürn 7. evde = ilişkilerde olgunlaşma karması, uzun vadeli bağlılık dersleri.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Karma', 'Güney Düğümü', 'Satürn', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Birthday Energy',
      termTr: 'Doğum Günü Enerjisi',
      hint: 'Solar Return enerjisi',
      definition:
          'Güneşin doğum haritasındaki yerine döndüğü yıllık döngü. Solar Return haritası yıllık temaları belirler.',
      deepExplanation:
          'Doğum günü, kişisel yeni yılın başlangıcıdır. Solar Return haritası, doğum günü anı için hesaplanır ve o yılın ana temalarını gösterir. Solar Return Yükseleni ve evleri özellikle önemlidir.',
      example:
          'Solar Return\'de Jüpiter 1. evde = şanslı, genişlemeci bir yıl.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Solar Return', 'Güneş', 'Yıllık Döngü'],
    ),
    GlossaryEntry(
      term: 'Abundance Energy',
      termTr: 'Bolluk Enerjisi',
      hint: 'Maddi ve manevi zenginlik',
      definition:
          'Kişinin bolluk ve bereket çekme kapasitesi. Jüpiter, 2. ev ve 8. ev ile belirlenir.',
      deepExplanation:
          'Bolluk sadece maddi değil, sevgi, sağlık, fırsatlar ve deneyimler açısından da değerlendirilir. Jüpiter doğal bolluk gezegeni, 2. ev kişisel kaynaklar, 8. ev paylaşılan kaynakları yönetir.',
      example:
          'Jüpiter 2. evde = doğal finansal şans. Jüpiter 8. evde = başkalarından gelen kaynaklar.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Jüpiter', '2. Ev', '8. Ev', 'Şans'],
    ),
    GlossaryEntry(
      term: 'Moon Energy',
      termTr: 'Ay Enerjisi',
      hint: 'Duygusal ve döngüsel güç',
      definition:
          'Ayın farklı fazları ve burçlarındaki enerji kaliteleri. Günlük ve aylık döngüleri etkiler.',
      deepExplanation:
          'Ay enerjisi sürekli değişir. Yeni Ay başlangıçlar, Dolunay doruk noktaları ve tamamlanmalar içindir. Ayın içinde bulunduğu burç o günün duygusal tonunu belirler.',
      example:
          'Ay Koç\'ta = enerjik, başlatıcı enerji. Ay Yengeç\'te = şefkatli, yuva odaklı enerji.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Ay', 'Yeni Ay', 'Dolunay', 'Ay Fazları'],
    ),
    GlossaryEntry(
      term: 'Life Path Number',
      termTr: 'Yaşam Sayısı',
      hint: 'Numerolojik yaşam yolu',
      definition:
          'Doğum tarihinden hesaplanan ve kişinin yaşam yolunu gösteren numerolojik sayı. 1-9 ve 11, 22, 33 master sayıları.',
      deepExplanation:
          'Yaşam sayısı, astrolojide Kuzey Düğümüne benzer bir işlev görür - ruhun bu yaşamdaki temel yolunu gösterir. Her sayının kendine özgü enerji kalitesi ve dersleri vardır.',
      example:
          'Yaşam Sayısı 1 = Liderlik ve bağımsızlık yolu. Yaşam Sayısı 7 = Spiritüellik ve bilgelik yolu.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Numeroloji', 'Kuzey Düğümü', 'Yaşam Amacı'],
    ),
    GlossaryEntry(
      term: 'Kabbalah Path',
      termTr: 'Kabala Yolu',
      hint: 'Hayat Ağacı üzerindeki yolculuk',
      definition:
          'Kabalistik Hayat Ağacı\'ndaki spiritüel yükseliş yolu. 22 yol, 22 İbrani harfi ve Major Arcana Tarot kartlarıyla ilişkili.',
      deepExplanation:
          'Kabala, evrenin yapısını ve ruhsal evrimi açıklayan mistik Yahudi öğretisidir. Hayat Ağacı\'ndaki 10 sefira ve 22 yol, bilinçin farklı düzeylerini temsil eder.',
      example:
          'Tiphareth (6. sefira) = Güneş enerjisi, benlik farkındalığı ve şifa.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Tarot', 'Hayat Ağacı', 'Mistisizm', 'Sefira'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // PSİKOLOJİK ASTROLOJİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _psychologicalTerms = [
    GlossaryEntry(
      term: 'Psychological Astrology',
      termTr: 'Psikolojik Astroloji',
      hint: 'İç dünya haritalama',
      definition:
          'Astrolojiyi psikolojik analiz ve kişisel gelişim aracı olarak kullanan yaklaşım.',
      deepExplanation:
          'Dane Rudhyar ve Liz Greene öncülüğünde gelişti. Jung psikolojisiyle astrolojiyi birleştirir. Olayları tahmin etmek yerine iç dinamikleri anlamaya odaklanır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Jung', 'Liz Greene', 'Dane Rudhyar'],
      references: [
        GlossaryReference(
          title: 'Saturn: A New Look',
          author: 'Liz Greene',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Persona',
      termTr: 'Persona (Maske)',
      hint: 'Toplumsal yüzümüz',
      definition:
          'Dünyaya gösterdiğimiz toplumsal kimlik. Yükselen burç bunu temsil eder.',
      deepExplanation:
          'Persona gerekli ama sınırlayıcı olabilir. Yükselenin gelişimi kişiliğin olgunlaşmasını gösterir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Yükselen', 'Jung', 'Maske'],
    ),
    GlossaryEntry(
      term: 'Anima/Animus',
      termTr: 'Anima/Animus',
      hint: 'İç karşı cinsiyet',
      definition:
          'Jung\'un iç dişil (anima) ve iç eril (animus) kavramları. Venüs ve Mars ile ilişkili.',
      deepExplanation:
          'Erkeklerde Venüs/Ay anima\'yı, kadınlarda Mars/Güneş animus\'u temsil eder. Bu gezegenlerin durumu karşı cinsle ilişkileri etkiler.',
      example:
          'Bir erkeğin Venüs Akrep\'te olması = anima\'sı yoğun, tutkulu ve dönüştürücü.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Venüs', 'Mars', 'Jung'],
    ),
    GlossaryEntry(
      term: 'Individuation',
      termTr: 'Bireyselleşme',
      hint: 'Tam kendin olma yolculuğu',
      definition:
          'Jung\'un tanımladığı, kişinin potansiyelini tam olarak gerçekleştirme süreci.',
      deepExplanation:
          'Astrolojide bireyselleşme, haritadaki tüm enerjileri bütünleştirmektir. Kareler ve karşıtlıklar entegre edilmeli, bastırılan gezegenler sahiplenilmeli.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Jung', 'Gölge Benlik', 'Bütünleşme'],
    ),
    GlossaryEntry(
      term: 'Complex',
      termTr: 'Kompleks',
      hint: 'Duygusal yük merkezi',
      definition:
          'Bilinçdışında güçlü duygusal yük taşıyan düşünce ve his kümesi.',
      deepExplanation:
          'Kiron, sert Satürn açıları ve 12. ev kompleksleri gösterir. Bunlar farkındalıkla şifalandırılabilir.',
      example:
          'Satürn-Güneş karesi = baba kompleksi, otorite figürleriyle zorluk.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Kiron', 'Satürn', 'Yara'],
    ),
    GlossaryEntry(
      term: 'Projection',
      termTr: 'Projeksiyon (Yansıtma)',
      hint: 'İç dünyayı dışarıda görmek',
      definition:
          'Kendi bilinçdışı özelliklerimizi başkalarına yansıtma mekanizması.',
      deepExplanation:
          'Descendant ve 7. evdeki gezegenler projeksiyon alanlarıdır. Partnerlerde eleştirdiğimiz şeyler genellikle kendi gölgemizdir.',
      example:
          'Terazi yükselen birisi kendi asertifliğini (Koç descendant) partnerlere yansıtır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Descendant', '7. Ev', 'Gölge Benlik'],
    ),
    GlossaryEntry(
      term: 'Defense Mechanism',
      termTr: 'Savunma Mekanizması',
      hint: 'Ego\'nun korunma yolları',
      definition:
          'Ego\'nun tehdit edici duygulardan korunmak için geliştirdiği bilinçdışı stratejiler.',
      deepExplanation:
          'Her burcun ve gezegenin karakteristik savunma mekanizmaları var. Yengeç kabuğa çekilir, Aslan inkâr eder, Başak kontrol eder.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Ego', 'Burç', 'Bilinçdışı'],
    ),
    GlossaryEntry(
      term: 'Inner Child',
      termTr: 'İç Çocuk',
      hint: 'Çocukluk yaraları',
      definition:
          'Psişenin çocukluk deneyimlerini ve yaralarını taşıyan parçası.',
      deepExplanation:
          'Ay, 4. ev ve Kiron iç çocuğu temsil eder. Çocukluk yaralarının şifası bu alanlardaki transitlere denk gelebilir.',
      example:
          'Ay-Satürn karesi = iç çocukta güvensizlik, duygusal ihtiyaçların bastırılması.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Ay', '4. Ev', 'Kiron'],
    ),
    GlossaryEntry(
      term: 'Wounded Healer',
      termTr: 'Yaralı Şifacı',
      hint: 'Kiron arketipi',
      definition:
          'Kendi yarasından şifa gücü çıkaran arketip. Kiron\'un temsil ettiği kavram.',
      deepExplanation:
          'Kiron\'un ev ve burç konumu yaramızı ve başkalarına nasıl şifa verebileceğimizi gösterir. En derin acımız en büyük armağanımıza dönüşebilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Kiron', 'Şifa', 'Arketip'],
    ),
    GlossaryEntry(
      term: 'Ego Development',
      termTr: 'Ego Gelişimi',
      hint: 'Benlik oluşumu',
      definition:
          'Güneş ve Satürn\'ün temsil ettiği sağlıklı ego yapısının gelişim süreci.',
      deepExplanation:
          'Güneş özgün kimliği, Satürn sınırları ve yapıyı temsil eder. Satürn dönüşü (yaklaşık 29 yaş) ego olgunlaşmasının önemli eşiğidir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Güneş', 'Satürn', 'Satürn Dönüşü'],
    ),
    GlossaryEntry(
      term: 'Attachment Style',
      termTr: 'Bağlanma Biçimi',
      hint: 'İlişki kalıpları',
      definition:
          'Erken çocukluk deneyimlerinden kaynaklanan ilişki kurma kalıpları.',
      deepExplanation:
          'Ay, 4. ev ve Venüs bağlanma biçimini gösterir. Ay-Satürn açısı kaygılı bağlanmaya, Ay-Uranüs kaçıngan bağlanmaya işaret edebilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Ay', '4. Ev', 'Venüs'],
    ),
    GlossaryEntry(
      term: 'Core Beliefs',
      termTr: 'Temel İnançlar',
      hint: 'Hayata bakış açısı',
      definition:
          'Kendimiz, başkaları ve dünya hakkındaki temel varsayımlarımız.',
      deepExplanation:
          'Güneş, Ay ve Yükselen temel inançları şekillendirir. 9. ev ve Jüpiter dünya görüşünü, Satürn sınırlayıcı inançları gösterir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['9. Ev', 'Jüpiter', 'Satürn'],
    ),
    GlossaryEntry(
      term: 'Self-Sabotage',
      termTr: 'Kendini Sabotaj',
      hint: 'İç engelleyici',
      definition: 'Başarıya yaklaştığımızda kendimizi baltalama eğilimi.',
      deepExplanation:
          'Satürn, Pluto ve 12. evdeki zorlu açılar kendini sabotaj kalıplarını gösterir. Bilinçdışı korku ve değersizlik hissi temelde yatar.',
      example:
          'Pluto 10. evde = başarıya yaklaştıkça bilinçdışı sabotaj, güç korkusu.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Satürn', 'Pluto', '12. Ev'],
    ),
    GlossaryEntry(
      term: 'Repression',
      termTr: 'Bastırma',
      hint: 'Bilinçdışına itme',
      definition: 'Kabul edilemez düşünce ve duyguları bilinçdışına itme.',
      deepExplanation:
          '12. ev ve zayıf gezegenler bastırılmış enerjileri gösterir. Bastırılan projeksiyona veya somatik semptomlara dönüşür.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['12. Ev', 'Gölge Benlik', 'Projeksiyon'],
    ),
    GlossaryEntry(
      term: 'Compensation',
      termTr: 'Telafi',
      hint: 'Zayıflığı örtme',
      definition:
          'Algılanan bir zayıflığı başka bir alanda aşırı geliştirerek telafi etme.',
      deepExplanation:
          'Zayıf konumdaki gezegen enerjisi sıklıkla telafi edilir. Örneğin zayıf Güneşli biri dikkat çekmek için aşırı çaba gösterebilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Savunma Mekanizması', 'Ego'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // TAHMİN TEKNİKLERİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _predictiveTerms = [
    GlossaryEntry(
      term: 'Secondary Progressions',
      termTr: 'İkincil Progresyonlar',
      hint: '1 gün = 1 yıl',
      definition:
          'Doğumdan sonraki her günün bir yılı temsil ettiği tahmin tekniği.',
      deepExplanation:
          'En yaygın progresyon sistemi. Progrese Ay her 2.5 yılda burç değiştirir ve duygusal temaları işaret eder. Progrese Güneş 30 yılda bir burç değiştirir.',
      example:
          'Progrese Ay 7. eve geçti = önümüzdeki 2.5 yıl ilişkilere odaklı.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Progresyon', 'Transit', 'Zamanlama'],
      references: [
        GlossaryReference(
          title: 'The Art of Predictive Astrology',
          author: 'Carol Rushman',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Solar Arc',
      termTr: 'Güneş Arkı',
      hint: 'Tüm gezegenler hareket eder',
      definition:
          'Güneş\'in progresyon hızıyla tüm gezegenleri ilerleten tahmin tekniği.',
      deepExplanation:
          'Yaklaşık 1° = 1 yıl. Progresyonların daha dinamik versiyonu. Özellikle açısal noktaları tetiklediğinde önemli.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Progresyon', 'Güneş', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Profection',
      termTr: 'Profeksiyon',
      hint: 'Yıllık ev aktivasyonu',
      definition:
          'Her yaş için bir evin aktive olduğu basit ama etkili tahmin tekniği.',
      deepExplanation:
          '1 yaş=1. ev, 13 yaş=1. ev, 25 yaş=1. ev... Her yıl o evin temaları ve yöneticisi öne çıkar. Helenistik astrolojinin ana zamanlama aracı.',
      example:
          '30 yaşında 7. ev profeksiyonu = ilişkiler ve ortaklıklar yılın teması.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Helenistik Astroloji', 'Ev', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Time Lord',
      termTr: 'Zaman Lordu',
      hint: 'Dönemin yöneticisi',
      definition:
          'Belirli bir dönemde etkin olan gezegen. Profeksiyon ve diğer zamanlama tekniklerinden gelir.',
      deepExplanation:
          'Zaman lordu o dönemdeki deneyimleri renklendirir. Zaman lordunun natal durumu, transitleri ve progresyonları önemlidir.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Profeksiyon', 'Firdaria', 'Dönem'],
    ),
    GlossaryEntry(
      term: 'Firdaria',
      termTr: 'Firdaria',
      hint: 'Gezegen dönemleri sistemi',
      definition:
          'Ortaçağ Pers kökenli gezegen dönemleri sistemi. 75 yıllık bir döngü.',
      deepExplanation:
          'Her gezegen belirli yıl sayısı boyunca yönetir. Güneş 10 yıl, Ay 9 yıl vb. Alt dönemler de var. Vedik Dasha\'ya benzer.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Zaman Lordu', 'Dasha', 'Dönem'],
    ),
    GlossaryEntry(
      term: 'Ingress',
      termTr: 'Giriş',
      hint: 'Burç değişimi',
      definition:
          'Bir gezegenin yeni bir burca girmesi. Özellikle yavaş gezegenlerin girişleri önemli.',
      deepExplanation:
          'Güneş\'in Koç\'a girişi (ilkbahar ekinoksu) yılın haritasını verir. Satürn ve Jüpiter burç değişimleri toplumsal değişimleri işaret eder.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Transit', 'Ekinoks', 'Mundane'],
    ),
    GlossaryEntry(
      term: 'Eclipse',
      termTr: 'Tutulma',
      hint: 'Kozmik sıfırlama',
      definition:
          'Güneş veya Ay tutulması. Astrolojide güçlü değişim ve başlangıç dönemleri.',
      deepExplanation:
          'Tutulmalar Ay Düğümleri yakınında olur, 6 aylık döngülerle gelir. Natal haritada düştüğü ev ve yaptığı açılar o alandaki değişimleri tetikler.',
      example:
          'Tutulma natal Güneş\'e kavuşum = kimlik dönüşümü, hayat değişikliği.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Ay Düğümleri', 'Yeniay', 'Dolunay'],
    ),
    GlossaryEntry(
      term: 'Return Chart',
      termTr: 'Dönüş Haritası',
      hint: 'Yıllık tema haritası',
      definition: 'Bir gezegenin natal konumuna döndüğü anın haritası.',
      deepExplanation:
          'Solar Return en yaygın olanı, doğum gününde çekilir ve önümüzdeki yılı gösterir. Lunar Return her ay, Saturn Return 29 yılda bir.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Solar Return', 'Lunar Return', 'Satürn Dönüşü'],
    ),
    GlossaryEntry(
      term: 'Trigger',
      termTr: 'Tetikleyici',
      hint: 'Olayı başlatan transit',
      definition:
          'Hızlı hareket eden gezegenin yavaş transiti veya progresyonu aktive etmesi.',
      deepExplanation:
          'Dış gezegen transitleri arka plan temasını kurar, iç gezegenler (özellikle Ay, Mars, Güneş) olayı tetikler.',
      example:
          'Satürn natal Güneş\'e kare yapıyor, Mars da o noktaya geldiğinde olay tetiklenir.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Transit', 'Zamanlama', 'Aktivasyon'],
    ),
    GlossaryEntry(
      term: 'Electional Astrology',
      termTr: 'Seçim Astrolojisi',
      hint: 'Doğru zamanı seçmek',
      definition: 'Bir eylem için en uygun zamanı belirleme sanatı.',
      deepExplanation:
          'Evlilik, iş açılışı, ameliyat gibi önemli olaylar için uygun gök haritası seçilir. Void Ay\'dan ve retro dönemlerden kaçınılır.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Void of Course', 'Retro', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Horary Astrology',
      termTr: 'Saat Astrolojisi',
      hint: 'Soruya cevap aramak',
      definition:
          'Belirli bir sorunun sorulduğu anın haritasını yorumlama sanatı.',
      deepExplanation:
          'En eski tahmin tekniklerinden. "Kayıp eşyam nerede?", "İş teklifini kabul etmeli miyim?" gibi spesifik sorulara cevap arar.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Ev', 'Yönetici', 'Soru'],
      references: [
        GlossaryReference(
          title: 'The Horary Textbook',
          author: 'John Frawley',
          type: 'book',
        ),
      ],
    ),
    GlossaryEntry(
      term: 'Void of Course Moon',
      termTr: 'Boşlukta Ay',
      hint: 'Ay etkisiz dönem',
      definition:
          'Ay\'ın bulunduğu burçta son açıyı yapıp yeni burca geçene kadar ki dönem.',
      deepExplanation:
          'Bu dönemde başlanan işler genellikle bekleneni vermez. Rutin işler için uygun, yeni başlangıçlar için değil.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Ay', 'Seçim Astrolojisi', 'Açı'],
    ),
    GlossaryEntry(
      term: 'Planetary Hour',
      termTr: 'Gezegen Saati',
      hint: 'Günün bölümleri',
      definition:
          'Günün ve gecenin her saatini bir gezegenin yönettiği sistem.',
      deepExplanation:
          'Caldean sırasıyla (Satürn, Jüpiter, Mars, Güneş, Venüs, Merkür, Ay) saatler döner. Haftanın günleri de buradan gelir.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Seçim Astrolojisi', 'Gezegen', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Lunation Cycle',
      termTr: 'Ay Döngüsü',
      hint: 'Yeniay\'dan Yeniay\'a',
      definition:
          '29.5 günlük Ay döngüsü. Yeniay\'da başlar, dolunay\'da zirve yapar, azalan evrede sonlanır.',
      deepExplanation:
          'Her ay döngüsü natal haritada farklı bir alanı vurgular. Yeniay başlangıçlar, dolunay doruk noktaları ve farkındalıklar.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Yeniay', 'Dolunay', 'Ay'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // İLİŞKİ ASTROLOJİSİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _relationshipTerms = [
    GlossaryEntry(
      term: 'Synastry',
      termTr: 'Sinastri',
      hint: 'İki haritanın karşılaştırması',
      definition:
          'İki kişinin doğum haritalarının üst üste konularak ilişki dinamiklerinin analiz edilmesi.',
      deepExplanation:
          'Gezegenler arası açılar ilişkinin kimyasını gösterir. Venüs-Mars açıları romantik çekimi, Güneş-Ay açıları temel uyumu belirler.',
      example:
          'A\'nın Venüs\'ü B\'nin Mars\'ına üçgen = güçlü ve uyumlu romantik çekim.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Kompozit Harita', 'Açı', 'İlişki'],
    ),
    GlossaryEntry(
      term: 'Soul Mate',
      termTr: 'Ruh Eşi',
      hint: 'Derin bağlantı',
      definition:
          'Ruhsal düzeyde derin bağ hissedilen kişi. Astrolojide belirli açı kalıplarıyla gösterilir.',
      deepExplanation:
          'Güney Düğüm kavuşumları geçmiş yaşam bağlantısını, Güneş-Ay kavuşumu ruhsal uyumu, Juno kavuşumları evlilik potansiyelini gösterir.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Ay Düğümleri', 'Juno'],
    ),
    GlossaryEntry(
      term: 'Twin Flame',
      termTr: 'İkiz Alev',
      hint: 'Ruhun diğer yarısı',
      definition:
          'Aynı ruhun iki parçası olduğuna inanılan yoğun ruhsal bağlantı.',
      deepExplanation:
          'Pluto ve Kuzey Düğüm bağlantıları, sert açılar ve 12. ev vurguları ikiz alev dinamiğini gösterebilir. Yoğun, dönüştürücü ve sıklıkla zorlayıcı.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Ruh Eşi', 'Pluto', 'Kuzey Düğüm'],
    ),
    GlossaryEntry(
      term: 'Karmic Relationship',
      termTr: 'Karmik İlişki',
      hint: 'Geçmiş yaşam bağı',
      definition:
          'Geçmiş yaşamlardan devam eden, tamamlanmamış işler içeren ilişki.',
      deepExplanation:
          'Satürn, Ay Düğümleri ve 12. ev bağlantıları karmik ilişkileri işaret eder. Bazen acı verse de önemli dersler öğretir.',
      example:
          'Partner\'ın Satürn\'ü sizin Güneş\'inize kavuşum = karmik baba/otorite dinamiği.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Karma', 'Satürn', 'Ay Düğümleri'],
    ),
    GlossaryEntry(
      term: 'Love Language',
      termTr: 'Aşk Dili',
      hint: 'Sevgiyi ifade biçimi',
      definition:
          'Kişinin sevgiyi nasıl verdiği ve almak istediği. Venüs ve 5. ev bunu gösterir.',
      deepExplanation:
          'Venüs\'ün burcu aşk dilini belirler: Boğa fiziksel dokunuş, İkizler sözlü ifade, Yengeç bakım, Aslan hediyeler ve ilgi.',
      example:
          'Venüs Başak\'ta = hizmet ederek, pratik şekillerde sevgi gösterme.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Venüs', '5. Ev', 'Aşk'],
    ),
    GlossaryEntry(
      term: 'Relationship Houses',
      termTr: 'İlişki Evleri',
      hint: '5., 7., 8. evler',
      definition:
          'İlişkileri gösteren evler: 5. ev romantizm, 7. ev ortaklık, 8. ev cinsellik ve paylaşım.',
      deepExplanation:
          '5. ev flört ve aşık olmayı, 7. ev ciddi ilişki ve evliliği, 8. ev derin duygusal ve fiziksel birleşmeyi temsil eder.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['5. Ev', '7. Ev', '8. Ev'],
    ),
    GlossaryEntry(
      term: 'Venus-Mars Aspects',
      termTr: 'Venüs-Mars Açıları',
      hint: 'Romantik kimya',
      definition:
          'Sinastride Venüs ve Mars arasındaki açılar romantik ve cinsel çekimi gösterir.',
      deepExplanation:
          'Kavuşum ve üçgen = güçlü, akıcı çekim. Kare = yoğun ama gerilimli tutku. Karşıtlık = çekim ama güç mücadelesi.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Venüs', 'Mars'],
    ),
    GlossaryEntry(
      term: 'Sun-Moon Aspects',
      termTr: 'Güneş-Ay Açıları',
      hint: 'Temel uyum',
      definition:
          'Sinastride Güneş ve Ay arasındaki açılar temel kişilik uyumunu gösterir.',
      deepExplanation:
          'A\'nın Güneş\'i B\'nin Ay\'ına uyumlu açı = karşılıklı anlayış ve destek. Sert açılar = temel ihtiyaçlarda çatışma.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Güneş', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Saturn Aspects in Synastry',
      termTr: 'Sinastride Satürn Açıları',
      hint: 'Kalıcılık veya sınırlama',
      definition:
          'Sinastride Satürn açıları ilişkiye ciddiyet, bağlılık ama aynı zamanda kısıtlama getirebilir.',
      deepExplanation:
          'Satürn kavuşumları karmik hissettirir ve uzun vadeli potansiyel gösterir. Ama sert açılar eleştiri, baskı ve soğukluk yaratabilir.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Satürn', 'Karmik İlişki'],
    ),
    GlossaryEntry(
      term: 'Nodal Connections',
      termTr: 'Düğüm Bağlantıları',
      hint: 'Kader ilişkisi',
      definition:
          'Sinastride bir kişinin gezegeni diğerinin Ay Düğümlerine kavuşum yapması.',
      deepExplanation:
          'Güney Düğüm kavuşumları tanıdık, geçmişten gelen bağ hissi verir. Kuzey Düğüm kavuşumları büyüme ve gelecek potansiyeli.',
      example:
          'Partner\'ın Güneş\'i sizin Kuzey Düğümünüze = sizi ruh amacınıza yaklaştıran ilişki.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Ay Düğümleri', 'Sinastri', 'Karmik İlişki'],
    ),
    GlossaryEntry(
      term: 'House Overlay',
      termTr: 'Ev Çakışması',
      hint: 'Gezegenler hangi eve düşüyor',
      definition:
          'Sinastride bir kişinin gezegenlerinin diğerinin evlerine düşmesi.',
      deepExplanation:
          'Partner\'ın Güneş\'i sizin 7. evinize düşüyorsa, onu doğal bir partner olarak görürsünüz. 12. eve düşerse, gizli veya karmaşık bağ.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Sinastri', 'Ev', 'Açı'],
    ),
    GlossaryEntry(
      term: 'Composite Midpoint',
      termTr: 'Kompozit Orta Nokta',
      hint: 'İki gezegenin ortası',
      definition:
          'Kompozit haritada iki kişinin aynı gezegenlerinin orta noktası.',
      deepExplanation:
          'Kompozit harita bu orta noktalardan oluşur ve ilişkinin kendi kimliğini gösterir. Kompozit Güneş ilişkinin amacı, Ay duygusal tonu.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Kompozit Harita', 'Orta Nokta', 'İlişki'],
    ),
    GlossaryEntry(
      term: 'Relationship Timing',
      termTr: 'İlişki Zamanlaması',
      hint: 'Aşk ne zaman gelir',
      definition:
          '7. eve yapılan transitler ve progresyonlar ilişki zamanlamasını gösterir.',
      deepExplanation:
          'Jüpiter 7. evden geçerken evlilik fırsatları, Satürn geçerken ciddi kararlar. Progrese Venüs açıları da romantik dönemleri işaret eder.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['7. Ev', 'Transit', 'Progresyon'],
    ),
    GlossaryEntry(
      term: 'Attraction Indicators',
      termTr: 'Çekim Göstergeleri',
      hint: 'Ne çeker bizi',
      definition: 'Doğum haritasında bizi kime çektiğimizi gösteren unsurlar.',
      deepExplanation:
          'Descendant burcu, 7. ev gezegenleri, Venüs ve Mars durumu çekim kalıplarını gösterir. Bazen Güney Düğüm de tanıdık çekim yaratır.',
      category: GlossaryCategory.relationships,
      relatedTerms: ['Descendant', 'Venüs', 'Mars'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // EK BURÇ VE GEZEGEN TERİMLERİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _extendedSignTerms = [
    GlossaryEntry(
      term: 'Fire Signs',
      termTr: 'Ateş Burçları',
      hint: 'Koç, Aslan, Yay',
      definition:
          'Ateş elementi burçları: Koç, Aslan ve Yay. Enerjik, tutkulu ve aksiyona yönelik.',
      deepExplanation:
          'Ateş burçları yaratıcılık, cesaret ve coşku ile karakterize edilir. İlham verici liderlerdir ama sabırsız olabilirler.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Element', 'Koç', 'Aslan', 'Yay'],
    ),
    GlossaryEntry(
      term: 'Earth Signs',
      termTr: 'Toprak Burçları',
      hint: 'Boğa, Başak, Oğlak',
      definition:
          'Toprak elementi burçları: Boğa, Başak ve Oğlak. Pratik, güvenilir ve maddiyatçı.',
      deepExplanation:
          'Toprak burçları istikrar, güvenlik ve somut sonuçlara odaklanır. Gerçekçi ve çalışkandırlar.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Element', 'Boğa', 'Başak', 'Oğlak'],
    ),
    GlossaryEntry(
      term: 'Air Signs',
      termTr: 'Hava Burçları',
      hint: 'İkizler, Terazi, Kova',
      definition:
          'Hava elementi burçları: İkizler, Terazi ve Kova. Entelektüel, sosyal ve iletişimci.',
      deepExplanation:
          'Hava burçları fikirler, iletişim ve sosyal bağlantılarla ilgilenir. Meraklı ve adaptiftirler.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Element', 'İkizler', 'Terazi', 'Kova'],
    ),
    GlossaryEntry(
      term: 'Water Signs',
      termTr: 'Su Burçları',
      hint: 'Yengeç, Akrep, Balık',
      definition:
          'Su elementi burçları: Yengeç, Akrep ve Balık. Duygusal, sezgisel ve empatik.',
      deepExplanation:
          'Su burçları derin duygusal zeka ve sezgiyle karakterize edilir. Hassas ve şefkatlidirler.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Element', 'Yengeç', 'Akrep', 'Balık'],
    ),
    GlossaryEntry(
      term: 'Cardinal Signs',
      termTr: 'Öncü Burçlar',
      hint: 'Koç, Yengeç, Terazi, Oğlak',
      definition:
          'Mevsimleri başlatan burçlar. Liderlik, inisiyatif ve yeni başlangıçlarla ilişkili.',
      deepExplanation:
          'Öncü burçlar aksiyona yöneliktir ve değişim başlatırlar. Her biri kendi elementinin öncüsüdür.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Modalite', 'Koç', 'Yengeç', 'Terazi', 'Oğlak'],
    ),
    GlossaryEntry(
      term: 'Fixed Signs',
      termTr: 'Sabit Burçlar',
      hint: 'Boğa, Aslan, Akrep, Kova',
      definition:
          'Mevsimlerin ortasındaki burçlar. İstikrar, kararlılık ve dayanıklılıkla ilişkili.',
      deepExplanation:
          'Sabit burçlar başlanmış olanı sürdürür. Güçlü irade ama inatçılık eğilimi.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Modalite', 'Boğa', 'Aslan', 'Akrep', 'Kova'],
    ),
    GlossaryEntry(
      term: 'Mutable Signs',
      termTr: 'Değişken Burçlar',
      hint: 'İkizler, Başak, Yay, Balık',
      definition:
          'Mevsim geçişlerindeki burçlar. Esneklik, adaptasyon ve değişimle ilişkili.',
      deepExplanation:
          'Değişken burçlar uyum sağlar ve köprü kurar. Çok yönlü ama kararsız olabilirler.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Modalite', 'İkizler', 'Başak', 'Yay', 'Balık'],
    ),
    GlossaryEntry(
      term: 'Polarity',
      termTr: 'Polarite',
      hint: 'Aktif/Pasif enerji',
      definition:
          'Burçların yin (dişil/içe dönük) veya yang (eril/dışa dönük) kategorileri.',
      deepExplanation:
          'Ateş ve Hava = Yang (aktif), Toprak ve Su = Yin (alıcı). Denge için her iki enerji gerekli.',
      category: GlossaryCategory.signs,
      relatedTerms: ['Element', 'Yin', 'Yang'],
    ),
    GlossaryEntry(
      term: 'Decan',
      termTr: 'Dekan',
      hint: 'Burcun 10 derecelik bölümü',
      definition:
          'Her burcun 10 derecelik üç bölümünden biri. Her dekan farklı gezegen tarafından yönetilir.',
      deepExplanation:
          'Aynı burçtaki gezegenler farklı dekanlarda farklı nüanslar gösterir. Ek yorum katmanı sağlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Derece', 'Burç', 'Yönetici'],
    ),
    GlossaryEntry(
      term: 'Dwad',
      termTr: 'Dwad (Duvadasamsa)',
      hint: 'Burcun 2.5 derecelik bölümü',
      definition:
          'Her burcun 12 eşit parçaya bölünmesi. Her parça bir burcu temsil eder.',
      deepExplanation:
          'Daha detaylı analiz için kullanılır. Vedik astrolojideki D-12 haritasına benzer.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dekan', 'Derece', 'Vedik'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // İLERİ DÜZEY TEKNİKLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _advancedTechniques = [
    GlossaryEntry(
      term: 'Sect',
      termTr: 'Sekt',
      hint: 'Gündüz/Gece ayrımı',
      definition:
          'Haritanın gündüz mü gece mi doğumu olduğuna göre yapılan temel ayrım.',
      deepExplanation:
          'Güneş ufkun üstünde = gündüz sekt. Gündüz: Güneş, Jüpiter, Satürn güçlü. Gece: Ay, Venüs, Mars güçlü.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Güneş', 'Ay', 'Gündüz', 'Gece'],
    ),
    GlossaryEntry(
      term: 'Planetary Speed',
      termTr: 'Gezegen Hızı',
      hint: 'Yavaş veya hızlı hareket',
      definition:
          'Gezegenin ortalama hızına göre yavaş veya hızlı hareket etmesi.',
      deepExplanation:
          'Hızlı gezegen aktif ve hevesli, yavaş gezegen temkinli ve derinlikli ifade.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Retro', 'Stasyon', 'Hareket'],
    ),
    GlossaryEntry(
      term: 'Station',
      termTr: 'Stasyon (Duruş)',
      hint: 'Gezegenin durduğu an',
      definition:
          'Gezegenin retro veya ileri harekete geçmeden önce duraksadığı nokta.',
      deepExplanation:
          'Stasyondaki gezegen çok güçlüdür. Direkt stasyon = ileri hareket başlıyor, retro stasyon = geriye bakış başlıyor.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Retro', 'Gezegen Hızı'],
    ),
    GlossaryEntry(
      term: 'Cazimi',
      termTr: 'Cazimi',
      hint: 'Güneşin kalbinde',
      definition:
          'Gezegenin Güneş\'e 17 dakika (0°17\') içinde kavuşum yapması. Çok güçlü konum.',
      deepExplanation:
          'Yanıklığın tersi - gezegen "taht odasında" ve kralla birlikte. Olağanüstü güç ve netlik.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yanık', 'Güneş', 'Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Combust',
      termTr: 'Yanık',
      hint: 'Güneşe çok yakın',
      definition:
          'Gezegenin Güneş\'e 8.5 derece içinde olması. Güneş ışığında kaybolur.',
      deepExplanation:
          'Yanık gezegen zayıflamış ve görünmezdir. O gezegenin temsil ettiği konularda zorluklar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Cazimi', 'Güneş', 'Işınlar Altında'],
    ),
    GlossaryEntry(
      term: 'Reception',
      termTr: 'Resepsiyon (Karşılama)',
      hint: 'Gezegenler arası misafirlik',
      definition:
          'İki gezegenin birbirinin burçlarında olması - karşılıklı resepsiyon.',
      deepExplanation:
          'Karşılıklı resepsiyon iki gezegen arasında işbirliği yaratır. Güçlü bağ ve destek.',
      example:
          'Mars Boğa\'da (Venüs\'ün evi), Venüs Koç\'ta (Mars\'ın evi) = karşılıklı resepsiyon.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yönetici', 'Onur', 'Dispositor'],
    ),
    GlossaryEntry(
      term: 'Dispositor',
      termTr: 'Dispositor',
      hint: 'Ev sahibi gezegen',
      definition:
          'Bir gezegenin bulunduğu burcun yöneticisi. Misafir gezegenin "ev sahibi".',
      deepExplanation:
          'Dispositor zinciri takip edilirse haritanın güç merkezleri bulunur. Final dispositor özellikle önemli.',
      example: 'Ay Koç\'ta, Koç\'un yöneticisi Mars = Mars Ay\'ın dispositoru.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yönetici', 'Son Dispositor', 'Resepsiyon'],
    ),
    GlossaryEntry(
      term: 'Almuten',
      termTr: 'Almuten',
      hint: 'En güçlü yönetici',
      definition:
          'Bir derece veya noktanın tüm onur sistemleri değerlendirildiğinde en güçlü yöneticisi.',
      deepExplanation:
          'Almuten hesaplaması yönetim, yücelme, üçlülük, sınır ve yüz puanlarını toplar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Yönetici', 'Yücelme'],
    ),
    GlossaryEntry(
      term: 'Triplicity',
      termTr: 'Üçlülük Yöneticisi',
      hint: 'Element yöneticileri',
      definition:
          'Her elementin gündüz, gece ve katılımcı yöneticileri sistemi.',
      deepExplanation:
          'Ateş: Güneş (gündüz), Jüpiter (gece). Toprak: Venüs (gündüz), Ay (gece). Sekt\'e göre hangisi aktif.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Element', 'Sekt', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Term/Bound',
      termTr: 'Sınır (Term)',
      hint: 'Derecedeki gezegen yönetimi',
      definition:
          'Her burcun belirli derece aralıklarının farklı gezegenler tarafından yönetilmesi.',
      deepExplanation:
          'Mısır ve Ptolemy sistemleri var. Bir gezegenin kendi sınırında olması küçük onur.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Onur', 'Derece', 'Dekan'],
    ),
    GlossaryEntry(
      term: 'Face/Decan',
      termTr: 'Yüz (Face)',
      hint: 'Dekan yönetimi',
      definition:
          'Caldean sırasına göre her 10 derecelik dekanın gezegen yöneticisi.',
      deepExplanation:
          'En zayıf onur formu ama yine de değerli. Mars 1-10° Koç\'un yüzünde vb.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dekan', 'Onur', 'Caldean Sırası'],
    ),
    GlossaryEntry(
      term: 'Antiscia',
      termTr: 'Antisyon',
      hint: 'Gizli bağlantı noktası',
      definition:
          'Yaz/Kış gündönümü eksenine (0° Yengeç - 0° Oğlak) göre yansıma noktası.',
      deepExplanation:
          'Antisyondaki gezegenler gizli veya karmik bağlantı gösterir. Görünmeyen açı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kontra-Antisyon', 'Açı'],
    ),
    GlossaryEntry(
      term: 'Lot/Arabic Part',
      termTr: 'Arap Noktası',
      hint: 'Hesaplanmış hassas nokta',
      definition:
          'Üç faktörün (genellikle Yükselen + A - B) kombinasyonuyla hesaplanan özel nokta.',
      deepExplanation:
          'Şans Noktası en ünlüsü. Spiritus, Eros, Evlilik, Kariyer gibi yüzlerce lot var.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Şans Noktası', 'Yükselen'],
    ),
    GlossaryEntry(
      term: 'Part of Fortune',
      termTr: 'Şans Noktası',
      hint: 'Maddi şans ve bolluk',
      definition:
          'En önemli Arap noktası. Formül: Yükselen + Ay - Güneş (gündüz), tersi gece.',
      deepExplanation:
          'Maddi dünyada şansın, refahın ve fiziksel sağlığın aktığı yer. Evi ve yöneticisi önemli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Arap Noktası', 'Ruh Noktası'],
    ),
    GlossaryEntry(
      term: 'Part of Spirit',
      termTr: 'Ruh Noktası',
      hint: 'Spiritüel şans',
      definition:
          'Şans Noktası\'nın tersi formülüyle hesaplanan ruhsal refah noktası.',
      deepExplanation:
          'Ruhsal yolculuk, amaç ve manevi gelişimin aktığı yer. Şans Noktası ile dengeyi gösterir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Şans Noktası', 'Arap Noktası'],
    ),
    GlossaryEntry(
      term: 'Planetary Joy',
      termTr: 'Gezegen Sevinci',
      hint: 'Gezegenin en mutlu evi',
      definition: 'Her gezegenin doğal olarak en güçlü ve mutlu olduğu ev.',
      deepExplanation:
          'Merkür=1, Ay=3, Venüs=5, Mars=6, Güneş=9, Jüpiter=11, Satürn=12. Evlerin anlamını da şekillendirir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ev', 'Gezegen', 'Onur'],
    ),
    GlossaryEntry(
      term: 'Planetary Hour',
      termTr: 'Gezegen Saatleri',
      hint: 'Günün gezegen yönetimi',
      definition:
          'Gün doğumundan itibaren her saati bir gezegenin yönettiği sistem.',
      deepExplanation:
          'Caldean sırasıyla (Satürn-Jüpiter-Mars-Güneş-Venüs-Merkür-Ay) devam eder. Seçim astrolojisinde kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Seçim Astrolojisi', 'Caldean Sırası'],
    ),
    GlossaryEntry(
      term: 'Planetary Day',
      termTr: 'Gezegen Günleri',
      hint: 'Haftanın gezegen yönetimi',
      definition:
          'Her gün bir gezegen tarafından yönetilir: Pazar=Güneş, Pazartesi=Ay, vb.',
      deepExplanation:
          'Gezegen saatleri sisteminden türemiştir. O gezegenin konularına uygun aktiviteler önerilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Gezegen Saatleri', 'Seçim Astrolojisi'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // AY FAZLARI VE DÖNGÜLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _lunarTerms = [
    GlossaryEntry(
      term: 'New Moon',
      termTr: 'Yeniay',
      hint: 'Başlangıçlar',
      definition:
          'Ay\'ın Güneş ile kavuşum yaptığı faz. Yeni başlangıçlar ve niyet koyma zamanı.',
      deepExplanation:
          'Tohum ekme zamanı. Yeni projeler, ilişkiler ve girişimler için ideal. Enerji içe dönük.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Dolunay', 'Ay Fazları', 'Kavuşum'],
    ),
    GlossaryEntry(
      term: 'Full Moon',
      termTr: 'Dolunay',
      hint: 'Doruk ve farkındalık',
      definition:
          'Ay\'ın Güneş\'e karşıtlık yaptığı faz. Tamamlanma, farkındalık ve hasat zamanı.',
      deepExplanation:
          'Duygular yoğun, her şey görünür. Yeniay\'da ekilen tohumların meyvesi. Bırakma zamanı.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yeniay', 'Ay Fazları', 'Karşıtlık'],
    ),
    GlossaryEntry(
      term: 'Waxing Moon',
      termTr: 'Büyüyen Ay',
      hint: 'Yeniay\'dan Dolunay\'a',
      definition:
          'Ay\'ın görünür yüzeyinin artmakta olduğu dönem. Büyüme ve inşa zamanı.',
      deepExplanation:
          'Enerji artar, projeler gelişir, momentum kazanılır. Aksiyona geçme dönemi.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yeniay', 'Dolunay', 'İlk Dördün'],
    ),
    GlossaryEntry(
      term: 'Waning Moon',
      termTr: 'Küçülen Ay',
      hint: 'Dolunay\'dan Yeniay\'a',
      definition:
          'Ay\'ın görünür yüzeyinin azalmakta olduğu dönem. Bırakma ve tamamlama zamanı.',
      deepExplanation:
          'Enerji azalır, gereksizler elenir, içe dönülür. Yansıtma ve hazırlık dönemi.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Dolunay', 'Yeniay', 'Son Dördün'],
    ),
    GlossaryEntry(
      term: 'First Quarter',
      termTr: 'İlk Dördün',
      hint: 'Eylem zamanı',
      definition:
          'Yeniay\'dan yaklaşık 7 gün sonra, Ay-Güneş karesi. Karar ve eylem zamanı.',
      deepExplanation:
          'Kriz noktası - engeller aşılmalı, kararlar verilmeli. Büyüme sürerken zorluklar.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yeniay', 'Kare', 'Büyüyen Ay'],
    ),
    GlossaryEntry(
      term: 'Last Quarter',
      termTr: 'Son Dördün',
      hint: 'Yeniden değerlendirme',
      definition:
          'Dolunay\'dan yaklaşık 7 gün sonra, Ay-Güneş karesi. Yeniden değerlendirme zamanı.',
      deepExplanation:
          'Ne işe yaradı, ne yaramadı? Bırakılması gerekenlerin netleştiği kriz noktası.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Dolunay', 'Kare', 'Küçülen Ay'],
    ),
    GlossaryEntry(
      term: 'Balsamic Moon',
      termTr: 'Balsamik Ay',
      hint: 'Son faz, dinlenme',
      definition:
          'Yeniay\'dan hemen önceki karanlık ay dönemi. Dinlenme, meditasyon ve hazırlık.',
      deepExplanation:
          'En içe dönük faz. Eski döngünün tamamlanması, yeni döngü için tohum hazırlığı.',
      category: GlossaryCategory.basics,
      relatedTerms: ['Yeniay', 'Küçülen Ay', 'Karanlık Ay'],
    ),
    GlossaryEntry(
      term: 'Lunar Return',
      termTr: 'Ay Dönüşü',
      hint: 'Aylık duygusal döngü',
      definition:
          'Ay\'ın her ay natal konumuna dönmesi. Yaklaşık 27.3 günde bir.',
      deepExplanation:
          'Duygusal yeniden başlangıç. Lunar return haritası önümüzdeki ayın duygusal tonunu gösterir.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Solar Return', 'Transit', 'Ay'],
    ),
    GlossaryEntry(
      term: 'Progressed Moon',
      termTr: 'Progrese Ay',
      hint: '2.5 yıllık duygusal tema',
      definition:
          'Sekonder progresyonda Ay\'ın konumu. Her 2.5 yılda burç değiştirir.',
      deepExplanation:
          'Evrimsel duygusal yolculuğu gösterir. Progrese Ay\'ın evi ve burcu o dönemin duygusal temasını belirler.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Progresyon', 'Ay', 'Dönem'],
    ),
    GlossaryEntry(
      term: 'Prenatal Lunation',
      termTr: 'Doğum Öncesi Lunasyon',
      hint: 'Doğumdan önceki ay fazı',
      definition: 'Doğumdan hemen önce gerçekleşen yeniay veya dolunay.',
      deepExplanation:
          'Helenistik astrolojide önemli. Ruhun dünyaya gelişinin koşullarını gösterir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Yeniay', 'Dolunay', 'Doğum Haritası'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // SABİT YILDIZLAR VE ÖZEL NOKTALAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _fixedStarsTerms = [
    GlossaryEntry(
      term: 'Fixed Stars',
      termTr: 'Sabit Yıldızlar',
      hint: 'Gökyüzündeki yıldızlar',
      definition:
          'Gezegenlerin aksine hareketsiz görünen yıldızlar. Bazıları astrolojide önemli etkilere sahip.',
      deepExplanation:
          'Aslında yavaş hareket ederler (yılda yaklaşık 50 saniye). Antik astrolojide çok önemliydiler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Regulus', 'Algol', 'Spica'],
    ),
    GlossaryEntry(
      term: 'Regulus',
      termTr: 'Regulus',
      hint: 'Aslan\'ın Kalbi',
      definition:
          'En parlak kraliyet yıldızlarından biri. Şu an 0° Başak\'ta. Şan, şöhret ve başarı.',
      deepExplanation:
          'Regulus\'la kavuşumdaki gezegenler büyük başarı potansiyeli verir ama intikam uyarısı taşır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar', 'Aslan', 'Kraliyet Yıldızları'],
    ),
    GlossaryEntry(
      term: 'Algol',
      termTr: 'Algol',
      hint: 'Şeytanın Başı',
      definition:
          'En kötü şöhretli sabit yıldız. 26° Boğa\'da. Yoğun, dönüştürücü ama zorlu.',
      deepExplanation:
          'Medusa\'nın kesik başını temsil eder. Modern yorumda yaratıcı yıkım ve derin dönüşüm.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar', 'Perseus'],
    ),
    GlossaryEntry(
      term: 'Spica',
      termTr: 'Spica',
      hint: 'Başak\'ın Başağı',
      definition:
          'En olumlu sabit yıldızlardan biri. 24° Terazi\'de. Yetenek, başarı ve koruma.',
      deepExplanation:
          'Tarımın ve bereketin yıldızı. Sanatsal yetenek ve şifa gücü verir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar', 'Başak'],
    ),
    GlossaryEntry(
      term: 'Royal Stars',
      termTr: 'Kraliyet Yıldızları',
      hint: 'Dört muhafız yıldız',
      definition:
          'Pers geleneğinden dört önemli yıldız: Aldebaran, Regulus, Antares, Fomalhaut.',
      deepExplanation:
          'Gökyüzünün dört köşesini koruyan muhafızlar. Büyük güç ve sorumluluk verirler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Yıldızlar', 'Regulus', 'Aldebaran'],
    ),
    GlossaryEntry(
      term: 'Vertex',
      termTr: 'Vertex',
      hint: 'Kadersel karşılaşmalar',
      definition:
          'Haritanın batı tarafında, asal vertikalin ekliptikle kesiştiği nokta.',
      deepExplanation:
          'Kadersel karşılaşmalar ve "yazgı" noktası. Sinastride vertex kavuşumları önemli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Anti-Vertex', 'Kader', 'Sinastri'],
    ),
    GlossaryEntry(
      term: 'Black Moon Lilith',
      termTr: 'Kara Ay Lilith',
      hint: 'Ay yörüngesinin uzak noktası',
      definition:
          'Ay\'ın Dünya etrafındaki yörüngesinin en uzak noktası (apogee). Gizli, bastırılmış dişil enerji.',
      deepExplanation:
          'Lilith, bastırılmış seksüelite, öfke ve bağımsızlığı temsil eder. Gölge dişil arketip.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Dişil Enerji', 'Gölge'],
    ),
    GlossaryEntry(
      term: 'True Lilith',
      termTr: 'Gerçek Lilith',
      hint: 'Düzeltilmiş Lilith pozisyonu',
      definition: 'Ay\'ın apogeesinin düzeltilmiş, salınımlı pozisyonu.',
      deepExplanation:
          'Ortalama Lilith\'ten farklı hesaplanır. Daha doğru ama daha değişken.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Kara Ay Lilith', 'Asteroidler'],
    ),
    GlossaryEntry(
      term: 'Priapus',
      termTr: 'Priapus',
      hint: 'Ay yörüngesinin yakın noktası',
      definition:
          'Ay\'ın perigeesi, Lilith\'in karşı noktası. Eril enerji ve fiziksel tutku.',
      deepExplanation:
          'Lilith\'in dengeleyicisi. Daha az kullanılır ama önemli bir nokta.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Kara Ay Lilith', 'Perigee'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // MUNDANE VE KOLEKTİF ASTROLOJİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _mundaneTerms = [
    GlossaryEntry(
      term: 'Mundane Astrology',
      termTr: 'Mundane Astroloji',
      hint: 'Dünya olayları astrolojisi',
      definition:
          'Ülkeler, hükümetler, ekonomi ve toplumsal olaylarla ilgilenen astroloji dalı.',
      deepExplanation:
          'Tutulmalar, büyük kavuşumlar ve dış gezegen geçişleri toplumsal değişimleri tetikler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tutulma', 'Büyük Kavuşum', 'Kolektif'],
    ),
    GlossaryEntry(
      term: 'Great Conjunction',
      termTr: 'Büyük Kavuşum',
      hint: 'Jüpiter-Satürn kavuşumu',
      definition:
          'Jüpiter ve Satürn\'ün yaklaşık her 20 yılda bir yaptığı kavuşum.',
      deepExplanation:
          'Toplumsal döngüleri belirler. Her 200 yılda element değiştirir (Büyük Mutasyon).',
      example: '2020\'de Kova\'da başlayan yeni 200 yıllık Hava dönemi.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Mundane Astroloji', 'Jüpiter', 'Satürn'],
    ),
    GlossaryEntry(
      term: 'Outer Planet Transit',
      termTr: 'Dış Gezegen Transiti',
      hint: 'Nesil transitleri',
      definition:
          'Uranüs, Neptün ve Pluto\'nun yaptığı uzun süreli transitler.',
      deepExplanation:
          'Bireysel değil nesil ve toplumsal dönüşümleri etkiler. Uzun yıllar sürer.',
      category: GlossaryCategory.predictive,
      relatedTerms: ['Uranüs', 'Neptün', 'Pluto', 'Transit'],
    ),
    GlossaryEntry(
      term: 'Generational Planets',
      termTr: 'Nesil Gezegenleri',
      hint: 'Uranüs, Neptün, Pluto',
      definition:
          'Yavaş hareket eden dış gezegenler. Aynı dönemde doğanlar aynı burçta paylaşır.',
      deepExplanation:
          'Nesil özelliklerini belirler. Kişisel deneyim için natal açılar ve evler daha önemli.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Uranüs', 'Neptün', 'Pluto'],
    ),
    GlossaryEntry(
      term: 'Pluto in Signs',
      termTr: 'Burçlarda Pluto',
      hint: 'Nesil dönüşümleri',
      definition:
          'Pluto\'nun burçlardaki 12-30 yıllık geçişleri nesil özelliklerini belirler.',
      deepExplanation:
          'Pluto Akrep nesli (1983-1995), Pluto Yay nesli (1995-2008) gibi gruplamalar.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Pluto', 'Nesil Gezegenleri'],
    ),
    GlossaryEntry(
      term: 'Ingress Chart',
      termTr: 'Giriş Haritası',
      hint: 'Burç değişimi anı',
      definition: 'Önemli bir gezegenin yeni burca girdiği anın haritası.',
      deepExplanation:
          'Aries Ingress (ilkbahar ekinoksu) en önemlisi. Yılın haritası olarak okunur.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ekinoks', 'Mundane Astroloji'],
    ),
    GlossaryEntry(
      term: 'Eclipse Path',
      termTr: 'Tutulma Yolu',
      hint: 'Tutulmanın görüldüğü yerler',
      definition: 'Güneş tutulmasının tam olarak görülebildiği coğrafi hat.',
      deepExplanation:
          'Tutulma yolu üzerindeki bölgeler o tutulmanın etkilerini daha yoğun hisseder.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tutulma', 'Mundane Astroloji'],
    ),
    GlossaryEntry(
      term: 'Saros Cycle',
      termTr: 'Saros Döngüsü',
      hint: 'Tutulma aileleri',
      definition:
          'Yaklaşık 18 yılda tekrarlayan tutulma serisi. Her seri belirli temalar taşır.',
      deepExplanation:
          'Aynı Saros ailesindeki tutulmalar benzer olayları tetikler. Bernadette Brady\'nin çalışmaları.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tutulma', 'Ay Düğümleri'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // SAĞLIK VE BEDEN ASTROLOJİSİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _healthTerms = [
    GlossaryEntry(
      term: 'Medical Astrology',
      termTr: 'Tıbbi Astroloji',
      hint: 'Sağlık ve beden',
      definition:
          'Doğum haritasından sağlık eğilimleri ve beden yapısı okuyan astroloji dalı.',
      deepExplanation:
          'Her burç ve gezegen belirli vücut bölgeleri ve sağlık konularıyla ilişkili.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['6. Ev', 'Yükselen', 'Sağlık'],
    ),
    GlossaryEntry(
      term: 'Zodiac Body Parts',
      termTr: 'Burçların Vücut Bölgeleri',
      hint: 'Her burcun yönettiği organ',
      definition:
          'Koç=baş, Boğa=boyun... Balık=ayaklar şeklinde devam eden sistem.',
      deepExplanation:
          'O burçtaki gezegenler ilgili bölgelerde hassasiyet yaratabilir. Tıbbi astrolojinin temeli.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tıbbi Astroloji', 'Burç'],
    ),
    GlossaryEntry(
      term: 'Sixth House Health',
      termTr: '6. Ev ve Sağlık',
      hint: 'Günlük sağlık rutinleri',
      definition:
          '6. ev günlük sağlık alışkanlıkları, hastalıklar ve tedavi ile ilgilidir.',
      deepExplanation:
          '6. evdeki gezegenler ve ev yöneticisinin durumu sağlık eğilimlerini gösterir.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Tıbbi Astroloji', 'Ev', 'Rutinler'],
    ),
    GlossaryEntry(
      term: 'Decumbiture',
      termTr: 'Hastalık Haritası',
      hint: 'Hastalığın başlangıç anı',
      definition:
          'Hastanın yatağa düştüğü veya hastalığın başladığı anın haritası.',
      deepExplanation:
          'Geleneksel tıbbi astrolojide hastalığın seyri ve tedavisi için kullanılır.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Tıbbi Astroloji', 'Saat Astrolojisi'],
    ),
    GlossaryEntry(
      term: 'Hyleg',
      termTr: 'Hayat Gücü (Hyleg)',
      hint: 'Yaşam enerjisi göstergesi',
      definition:
          'Yaşam gücünü ve sağlık dayanıklılığını gösteren nokta. Güneş, Ay veya Yükselen.',
      deepExplanation:
          'Hyleg\'in alcochoden\'i (yöneticisi) ile birlikte sağlık ve ömür değerlendirilir.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Alcochoden', 'Tıbbi Astroloji'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // FİNANS VE MADDI KONULAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _financeTerms = [
    GlossaryEntry(
      term: 'Financial Astrology',
      termTr: 'Finansal Astroloji',
      hint: 'Para ve yatırım',
      definition:
          'Ekonomi, borsa ve finansal kararlarla ilgilenen astroloji dalı.',
      deepExplanation:
          '2. ev (kişisel gelir), 8. ev (ortaklık finansı) ve Jüpiter/Venüs önemli göstergeler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['2. Ev', '8. Ev', 'Jüpiter'],
    ),
    GlossaryEntry(
      term: 'Second House',
      termTr: '2. Ev',
      hint: 'Değerler ve gelir',
      definition:
          'Kişisel değerler, gelir kaynakları ve maddi güvenlikle ilgili ev.',
      deepExplanation:
          'Para kazanma biçimi, neye değer verdiğimiz ve öz değer duygusu burada kodlanır.',
      category: GlossaryCategory.houses,
      relatedTerms: ['Ev', 'Finans', 'Değerler'],
    ),
    GlossaryEntry(
      term: 'Eighth House',
      termTr: '8. Ev',
      hint: 'Paylaşılan kaynaklar',
      definition:
          'Ortak finanslar, miras, vergiler, borçlar ve başkalarının parasıyla ilgili ev.',
      deepExplanation:
          'Ayrıca cinsellik, ölüm, dönüşüm ve psikolojik derinlik. "Başkasının değerleri".',
      category: GlossaryCategory.houses,
      relatedTerms: ['Ev', 'Finans', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Jupiter Finance',
      termTr: 'Jüpiter ve Finans',
      hint: 'Bolluk ve genişleme',
      definition: 'Jüpiter maddi bolluk, şans ve fırsatları temsil eder.',
      deepExplanation:
          'Jüpiter\'in evi ve açıları zenginlik potansiyelini gösterir. 2. veya 8. evde olumlu.',
      category: GlossaryCategory.planets,
      relatedTerms: ['Jüpiter', '2. Ev', 'Bolluk'],
    ),
    GlossaryEntry(
      term: 'Part of Fortune Finance',
      termTr: 'Şans Noktası ve Finans',
      hint: 'Maddi şans alanı',
      definition:
          'Şans Noktası\'nın evi ve durumu maddi refahın aktığı yeri gösterir.',
      deepExplanation:
          'Şans Noktası 2. evde = doğrudan gelir yoluyla, 10. evde = kariyer yoluyla finans.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Şans Noktası', 'Ev', 'Bolluk'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // VEDİK ASTROLOJİ TERİMLERİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _vedicExtraTerms = [
    GlossaryEntry(
      term: 'Rashi',
      termTr: 'Raşi',
      hint: 'Vedik burç',
      definition:
          'Hint astrolojisinde burç. Sidereal (sabit) zodyak kullanılır.',
      deepExplanation:
          'Batı burçlarından yaklaşık 24 derece geridedir (Ayanamsa farkı).',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Sabit Zodyak', 'Ayanamsa', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Bhava',
      termTr: 'Bhava',
      hint: 'Vedik ev',
      definition:
          'Hint astrolojisinde ev. Genellikle Tam Burç Evleri kullanılır.',
      deepExplanation:
          'Her bhava\'nın anlamı Batı astrolojisiyle benzer ama bazı farklılıklar var.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Ev', 'Vedik', 'Tam Burç Evleri'],
    ),
    GlossaryEntry(
      term: 'Graha',
      termTr: 'Graha',
      hint: 'Vedik gezegen',
      definition:
          'Hint astrolojisinde gezegen. 9 graha: 7 klasik gezegen + Rahu ve Ketu.',
      deepExplanation:
          'Graha kelimesi "kavrayan" anlamına gelir. Karmik etki yaratanlar.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Gezegen', 'Rahu', 'Ketu', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Rahu',
      termTr: 'Rahu',
      hint: 'Kuzey Ay Düğümü',
      definition:
          'Vedik astrolojide Kuzey Ay Düğümü. Obsesyon, arzu ve materiyal büyüme.',
      deepExplanation:
          'Rahu yabancı, teknoloji, yanılsama ve doyumsuz arzuları temsil eder. Gölge gezegen.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Kuzey Düğüm', 'Ketu', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Ketu',
      termTr: 'Ketu',
      hint: 'Güney Ay Düğümü',
      definition:
          'Vedik astrolojide Güney Ay Düğümü. Bırakma, spiritüalite ve geçmiş yaşam.',
      deepExplanation:
          'Ketu mistisizm, izolasyon ve aydınlanmayı temsil eder. Rahu\'nun tamamlayıcısı.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Güney Düğüm', 'Rahu', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Yoga (Astrology)',
      termTr: 'Yoga (Astroloji)',
      hint: 'Gezegen kombinasyonları',
      definition:
          'Vedik astrolojide gezegenler arasındaki özel kombinasyonlar.',
      deepExplanation:
          'Yüzlerce yoga var. Bazıları çok olumlu (Raja Yoga), bazıları zorlu (Kemadruma).',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Vedik', 'Gezegen', 'Kombinasyon'],
    ),
    GlossaryEntry(
      term: 'Vimshottari Dasha',
      termTr: 'Vimshottari Dasha',
      hint: '120 yıllık gezegen döngüsü',
      definition:
          'En yaygın Vedik dasha sistemi. Her gezegenin belirli yıl sayısı boyunca yönetimi.',
      deepExplanation:
          'Güneş=6, Ay=10, Mars=7, Rahu=18, Jüpiter=16, Satürn=19, Merkür=17, Ketu=7, Venüs=20 yıl.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dasha', 'Vedik', 'Zamanlama'],
    ),
    GlossaryEntry(
      term: 'Mahadasha',
      termTr: 'Mahadasha',
      hint: 'Ana gezegen dönemi',
      definition: 'Vimshottari sisteminde gezegenin ana yönetim dönemi.',
      deepExplanation:
          'Mahadasha döneminin gezegeninin natal durumu o dönemin genel tonunu belirler.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dasha', 'Antardasha', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Antardasha',
      termTr: 'Antardasha',
      hint: 'Alt gezegen dönemi',
      definition:
          'Mahadasha içindeki alt dönemler. Mahadasha/Antardasha kombinasyonu okunur.',
      deepExplanation:
          'Örneğin Satürn Mahadasha - Venüs Antardasha = iki gezegenin birlikte etkisi.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Dasha', 'Mahadasha', 'Vedik'],
    ),
    GlossaryEntry(
      term: 'Navamsa',
      termTr: 'Navamsa (D-9)',
      hint: 'Evlilik ve ruh haritası',
      definition:
          'Her burcun 9 parçaya bölünmesiyle oluşan varga haritası. En önemli ikinci harita.',
      deepExplanation:
          'Evlilik, ruhsal gelişim ve gezegenin gerçek gücü Navamsa\'dan okunur.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Varga', 'Vedik', 'Evlilik'],
    ),
    GlossaryEntry(
      term: 'Varga Charts',
      termTr: 'Varga Haritaları',
      hint: 'Bölümsel haritalar',
      definition:
          'Vedik astrolojide burcun farklı bölümlere ayrılmasıyla oluşan ek haritalar.',
      deepExplanation:
          'D-1 (Rashi), D-9 (Navamsa), D-10 (Dasamsa) vb. Toplam 16 önemli varga.',
      category: GlossaryCategory.techniques,
      relatedTerms: ['Navamsa', 'Dasamsa', 'Vedik'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // ÖZEL ASTEROİDLER VE NOKTALAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _asteroidExtras = [
    GlossaryEntry(
      term: 'Eros',
      termTr: 'Eros',
      hint: 'Erotik tutku',
      definition: 'Cinsel tutku, erotizm ve derin çekim ile ilgili asteroit.',
      deepExplanation:
          'Eros\'un burcu ve evi cinsel ifade tarzını ve tutkuyu gösterir. Sinastride önemli.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Psyche', 'Cinsellik'],
    ),
    GlossaryEntry(
      term: 'Psyche',
      termTr: 'Psyche',
      hint: 'Ruh ve ruhsal bağ',
      definition: 'Ruh, psişe ve derin ruhsal bağlantıyla ilgili asteroit.',
      deepExplanation:
          'Eros-Psyche mitinden gelir. Sinastride ruh bağlantısını gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Eros', 'Ruh'],
    ),
    GlossaryEntry(
      term: 'Sappho',
      termTr: 'Sappho',
      hint: 'Sanatsal aşk',
      definition:
          'Romantik şiir, sanatsal ifade ve alternatif aşk formlarıyla ilgili asteroit.',
      deepExplanation:
          'Lesbos adasının şairinin adını taşır. Yaratıcılık ve samimi bağlar.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Venüs', 'Sanat'],
    ),
    GlossaryEntry(
      term: 'Amor',
      termTr: 'Amor',
      hint: 'Koşulsuz sevgi',
      definition: 'Romantik aşk ve koşulsuz sevgiyle ilgili asteroit.',
      deepExplanation:
          'Aşk tanrısı Cupid\'in Latin adı. Romantik idealizm ve aşkta vericilik.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Asteroidler', 'Venüs', 'Aşk'],
    ),
    GlossaryEntry(
      term: 'Nessus',
      termTr: 'Nessus',
      hint: 'Taciz ve güç istismarı',
      definition:
          'Taciz, istismar ve intikamla ilgili Centaur. Zorlu ama şifalandırıcı.',
      deepExplanation:
          'Nessus taciz döngülerini ve bunlardan şifa bulma potansiyelini gösterir.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Centaur', 'Kiron', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Pholus',
      termTr: 'Pholus',
      hint: 'Küçük neden büyük etki',
      definition:
          'Domino etkisi ve küçük olayların büyük sonuçlara yol açmasıyla ilgili Centaur.',
      deepExplanation:
          'Pholus transitleri beklenmedik, hızlı ve geri dönüşsüz değişimleri tetikler.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Centaur', 'Kiron', 'Değişim'],
    ),
    GlossaryEntry(
      term: 'Sedna',
      termTr: 'Sedna',
      hint: 'Uzak, izole',
      definition:
          'Güneş sisteminin en uzak bilinen cisimlerinden. İzolasyon ve kurban durumu.',
      deepExplanation:
          'İnuit deniz tanrıçasından alır adını. Derin travma ve transandans.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Transpluto', 'İzolasyon'],
    ),
    GlossaryEntry(
      term: 'Eris',
      termTr: 'Eris',
      hint: 'Kaos ve rekabet',
      definition: 'Pluto benzeri cüce gezegen. Kaos, rekabet ve dışlanmışlık.',
      deepExplanation:
          'Adını anlaşmazlık tanrıçasından alır. Status quo\'yu bozan dönüştürücü güç.',
      category: GlossaryCategory.modern,
      relatedTerms: ['Pluto', 'Cüce Gezegen', 'Dönüşüm'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // RÜYA SEMBOLLERİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _dreamSymbols = [
    GlossaryEntry(
      term: 'Dream Water Symbol',
      termTr: 'Rüyada Su',
      hint: 'Duygular ve bilinçaltı',
      definition:
          'Rüyalarda su, duyguların, bilinçaltının ve arınmanın sembolüdür. Durgun su huzuru, dalgalı su duygusal çalkantıyı temsil eder.',
      deepExplanation:
          'Su elementi, ruhun derinliklerini yansıtır. Denizde yüzmek bilinçaltına dalmak, boğulmak duyguların altında ezilmek anlamına gelebilir. Su burçları için özellikle güçlü mesajlar taşır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Bilinçaltı', 'Duygular', 'Arınma'],
    ),
    GlossaryEntry(
      term: 'Dream Flying Symbol',
      termTr: 'Rüyada Uçmak',
      hint: 'Özgürlük ve yükseliş',
      definition:
          'Rüyalarda uçmak, özgürlük arzusunu, sınırları aşmayı ve spiritüel yükselişi temsil eder.',
      deepExplanation:
          'Uçuş rüyaları genellikle kontrolde hissettiğimiz dönemlerde gelir. Zorlukla uçmak engellenmiş potansiyeli, kolayca uçmak özgüven ve başarıyı simgeler.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Özgürlük', 'Yükseliş', 'Potansiyel'],
    ),
    GlossaryEntry(
      term: 'Dream Falling Symbol',
      termTr: 'Rüyada Düşmek',
      hint: 'Kontrol kaybı',
      definition:
          'Rüyalarda düşmek, kontrol kaybı korkusunu, güvensizliği veya hayatta bir alanda temel kaybını simgeler.',
      deepExplanation:
          'Düşüş rüyaları stres dönemlerinde yaygınlaşır. Düşüp yere çarpmamak umut ve dayanıklılığı, çarpmak korkuyla yüzleşme ihtiyacını gösterir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Korku', 'Kontrol', 'Güvenlik'],
    ),
    GlossaryEntry(
      term: 'Dream Death Symbol',
      termTr: 'Rüyada Ölüm',
      hint: 'Dönüşüm ve yeni başlangıç',
      definition:
          'Rüyalarda ölüm, fiziksel ölümü değil, transformasyonu, bir dönemin sonunu ve yeni başlangıçları simgeler.',
      deepExplanation:
          'Tarot\'taki Ölüm kartı gibi, rüyada ölüm radikal değişimi müjdeler. Eski benliğin ölümü, yeni benliğin doğuşuna kapı açar.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Transformasyon', 'Yeniden Doğuş', 'Değişim'],
    ),
    GlossaryEntry(
      term: 'Dream Chase Symbol',
      termTr: 'Rüyada Kovalanmak',
      hint: 'Kaçınılan konular',
      definition:
          'Rüyalarda kovalanmak, hayatta kaçtığımız konularla, bastırılmış korkularla veya kabul etmediğimiz gerçeklerle yüzleşme çağrısıdır.',
      deepExplanation:
          'Kovalayan figür genellikle gölge benliğimizi temsil eder. Dönüp bakma cesareti göstermek, kaçılan konuyla yüzleşme hazırlığını simgeler.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Gölge Benlik', 'Kaçınma', 'Yüzleşme'],
    ),
    GlossaryEntry(
      term: 'Dream Snake Symbol',
      termTr: 'Rüyada Yılan',
      hint: 'Dönüşüm ve şifa',
      definition:
          'Yılan, dönüşümü, şifayı, gizli bilgiyi ve kundalini enerjisini temsil eden güçlü bir semboldür.',
      deepExplanation:
          'Yılan deri değiştirir, bu nedenle yenilenmenin sembolüdür. Ayrıca şifa tanrısı Asklepios\'un simgesidir. Korkulan yılan bastırılmış içgüdüleri gösterebilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Kundalini', 'Şifa', 'Dönüşüm'],
    ),
    GlossaryEntry(
      term: 'Dream House Symbol',
      termTr: 'Rüyada Ev',
      hint: 'Benlik ve iç dünya',
      definition:
          'Rüyalarda ev, benliği ve iç dünyayı temsil eder. Farklı odalar kişiliğin farklı yönlerini simgeler.',
      deepExplanation:
          'Bodrum bilinçaltı, çatı spiritüel farkındalık, mutfak beslenme ve bakım, yatak odası yakınlık ve gizlilikle ilişkilidir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Benlik', 'İç Dünya', 'Bilinçaltı'],
    ),
    GlossaryEntry(
      term: 'Dream Animal Symbol',
      termTr: 'Rüyada Hayvan',
      hint: 'İçgüdüler ve totem',
      definition:
          'Rüyalarda hayvanlar, içgüdüsel doğamızı, bastırılmış enerjileri ve totem rehberlerimizi temsil eder.',
      deepExplanation:
          'Her hayvanın kendine özgü bir mesajı vardır. Köpek sadakati, kedi bağımsızlığı, kuş özgürlüğü, at gücü simgeler.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['İçgüdü', 'Totem', 'Doğa'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // ÇAKRA SİSTEMİ
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _chakraTerms = [
    GlossaryEntry(
      term: 'Root Chakra',
      termTr: 'Kök Çakra (Muladhara)',
      hint: 'Güvenlik ve temel',
      definition:
          'Omurganın tabanında yer alan 1. çakra. Güvenlik, hayatta kalma, topraklanma ve maddi dünyayla bağlantıyı yönetir.',
      deepExplanation:
          'Sanskrit\'te "kök destek" anlamına gelir. Kırmızı renkle ve toprak elementiyle ilişkilidir. Bloke olduğunda korku, güvensizlik; dengeli olduğunda istikrar ve güven hissi verir.',
      example:
          'Kök çakra çalışması: Yalın ayak toprakta yürümek, kırmızı giysiler giymek.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Topraklanma', 'Güvenlik'],
    ),
    GlossaryEntry(
      term: 'Sacral Chakra',
      termTr: 'Sakral Çakra (Svadhisthana)',
      hint: 'Yaratıcılık ve duygular',
      definition:
          'Göbek altında yer alan 2. çakra. Duygular, yaratıcılık, cinsellik ve zevk alma kapasitesini yönetir.',
      deepExplanation:
          'Sanskrit\'te "tatlılığın yeri" anlamına gelir. Turuncu renkle ve su elementiyle ilişkilidir. Bloke olduğunda duygusal donukluk, suçluluk; dengeli olduğunda yaratıcı akış ve neşe.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Yaratıcılık', 'Duygular'],
    ),
    GlossaryEntry(
      term: 'Solar Plexus Chakra',
      termTr: 'Güneş Sinir Ağı Çakrası (Manipura)',
      hint: 'Güç ve irade',
      definition:
          'Mide bölgesinde yer alan 3. çakra. Kişisel güç, irade, özgüven ve ego\'yu yönetir.',
      deepExplanation:
          'Sanskrit\'te "mücevherler şehri" anlamına gelir. Sarı renkle ve ateş elementiyle ilişkilidir. Bloke olduğunda düşük özgüven, pasiflik; dengeli olduğunda güçlü benlik algısı.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Güç', 'Özgüven'],
    ),
    GlossaryEntry(
      term: 'Heart Chakra',
      termTr: 'Kalp Çakrası (Anahata)',
      hint: 'Sevgi ve şefkat',
      definition:
          'Göğüs merkezinde yer alan 4. çakra. Sevgi, şefkat, empati ve ilişkileri yönetir. Alt ve üst çakraları birbirine bağlar.',
      deepExplanation:
          'Sanskrit\'te "zarar görmemiş" anlamına gelir. Yeşil/pembe renkle ve hava elementiyle ilişkilidir. Bloke olduğunda kıskançlık, korku; dengeli olduğunda koşulsuz sevgi.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Sevgi', 'Empati'],
    ),
    GlossaryEntry(
      term: 'Throat Chakra',
      termTr: 'Boğaz Çakrası (Vishuddha)',
      hint: 'İletişim ve ifade',
      definition:
          'Boğaz bölgesinde yer alan 5. çakra. İletişim, kendini ifade etme, gerçeği söyleme ve yaratıcı ifadeyi yönetir.',
      deepExplanation:
          'Sanskrit\'te "çok saf" anlamına gelir. Mavi renkle ve eter elementiyle ilişkilidir. Bloke olduğunda iletişim zorlukları, utangaçlık; dengeli olduğunda açık ve dürüst ifade.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'İletişim', 'Gerçek'],
    ),
    GlossaryEntry(
      term: 'Third Eye Chakra',
      termTr: 'Üçüncü Göz Çakrası (Ajna)',
      hint: 'Sezgi ve içgörü',
      definition:
          'Kaşlar arasında yer alan 6. çakra. Sezgi, içgörü, hayal gücü ve spiritüel farkındalığı yönetir.',
      deepExplanation:
          'Sanskrit\'te "komut" anlamına gelir. İndigo renkle ve ışık elementiyle ilişkilidir. Bloke olduğunda kafa karışıklığı, yanılsama; dengeli olduğunda berrak görüş ve güçlü sezgi.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Sezgi', 'Farkındalık'],
    ),
    GlossaryEntry(
      term: 'Crown Chakra',
      termTr: 'Taç Çakrası (Sahasrara)',
      hint: 'Spiritüel bağlantı',
      definition:
          'Başın tepesinde yer alan 7. çakra. Kozmik bilinç, spiritüel bağlantı ve aydınlanmayı yönetir.',
      deepExplanation:
          'Sanskrit\'te "bin yapraklı lotus" anlamına gelir. Mor/beyaz renkle ve saf düşünce elementiyle ilişkilidir. Tamamen açık olduğunda birlik bilinci ve aşkın deneyimler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Aydınlanma', 'Kozmik Bilinç'],
    ),
    GlossaryEntry(
      term: 'Kundalini',
      termTr: 'Kundalini',
      hint: 'Uyuyan yılan enerjisi',
      definition:
          'Omurganın tabanında kıvrılmış yılan şeklinde uyuyan yaşam gücü enerjisi. Uyanınca tüm çakralardan yükselir.',
      deepExplanation:
          'Sanskrit\'te "kıvrılmış" anlamına gelir. Yoga ve meditasyonla uyandırılabilir. Ani uyanış tehlikeli olabilir, aşamalı ve rehberli çalışma önerilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Enerji', 'Uyanış'],
    ),
    GlossaryEntry(
      term: 'Chakra Balancing',
      termTr: 'Çakra Dengeleme',
      hint: 'Enerji uyumu',
      definition:
          'Çakraların aşırı aktif veya bloke durumlarını dengeleyerek enerji akışını optimize etme pratiği.',
      deepExplanation:
          'Dengeli çakralar fiziksel, duygusal ve spiritüel sağlığın temelidir. Meditasyon, kristaller, ses terapisi ve yoga ile dengeleme yapılabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Enerji', 'Şifa'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // MEDİTASYON VE NEFES
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _meditationTerms = [
    GlossaryEntry(
      term: 'Breath Meditation',
      termTr: 'Nefes Meditasyonu',
      hint: 'Nefese odaklanma',
      definition:
          'Nefes alıp vermeye odaklanarak zihni sakinleştiren temel meditasyon tekniği.',
      deepExplanation:
          'En erişilebilir meditasyon formu. Dikkati nefese yönelterek şimdiki ana çapa atar. Anksiyete ve stresi azaltır, odaklanmayı artırır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Meditasyon', 'Mindfulness', 'Rahatlama'],
    ),
    GlossaryEntry(
      term: '4-7-8 Breathing',
      termTr: '4-7-8 Nefes Tekniği',
      hint: 'Rahatlatıcı nefes paterni',
      definition:
          '4 saniye nefes al, 7 saniye tut, 8 saniye yavaşça ver. Sinir sistemini sakinleştiren güçlü teknik.',
      deepExplanation:
          'Dr. Andrew Weil tarafından popülerleştirilmiş. Parasempatik sinir sistemini aktive eder, kalp atışını yavaşlatır, uykuya geçişi kolaylaştırır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Nefes', 'Rahatlama', 'Uyku'],
    ),
    GlossaryEntry(
      term: 'Body Scan Meditation',
      termTr: 'Beden Taraması Meditasyonu',
      hint: 'Bedensel farkındalık',
      definition:
          'Dikkati sistematik olarak bedenin her bölgesine yönelterek gerginlikleri fark etme ve bırakma pratiği.',
      deepExplanation:
          'MBSR (Mindfulness Tabanlı Stres Azaltma) programının temel pratiği. Bedende depolanan duyguları fark etmeye ve serbest bırakmaya yardımcı olur.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Meditasyon', 'Farkındalık', 'Beden'],
    ),
    GlossaryEntry(
      term: 'Loving-Kindness Meditation',
      termTr: 'Sevgi-Şefkat Meditasyonu (Metta)',
      hint: 'Merhamet pratiği',
      definition:
          'Kendine ve başkalarına sevgi ve şefkat dilekleri göndererek merhamet kapasitesini geliştiren meditasyon.',
      deepExplanation:
          'Budist gelenekten gelen Metta pratiği. "Mutlu olayım, sağlıklı olayım" gibi ifadelerle başlar, sonra başkalarına genişler. Empatiyi ve bağlantı hissini güçlendirir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Meditasyon', 'Merhamet', 'Sevgi'],
    ),
    GlossaryEntry(
      term: 'Visualization',
      termTr: 'Görselleştirme',
      hint: 'Zihinsel imgeleme',
      definition:
          'İstenen sonuçları veya deneyimleri zihinsel olarak canlandırarak manifestasyon ve şifa çalışması yapma tekniği.',
      deepExplanation:
          'Beyin, gerçek ve hayal edilen deneyimler arasında tam ayrım yapamaz. Bu nedenle görselleştirme, nöral yolları yeniden programlayabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Manifestasyon', 'Meditasyon', 'Niyet'],
    ),
    GlossaryEntry(
      term: 'Grounding',
      termTr: 'Topraklanma',
      hint: 'Dünyaya bağlanma',
      definition:
          'Enerjiyi toprağa vererek dengeleme, şimdiki ana gelme ve bedenle bağlantı kurma pratiği.',
      deepExplanation:
          'Anksiyete, disosiyasyon ve aşırı düşünmeye karşı güçlü bir araç. Yalın ayak toprakta yürüme, ağaç kök görselleştirmesi kullanılabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kök Çakra', 'Şimdiki An', 'Denge'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // KRİSTALLER VE TAŞLAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _crystalTerms = [
    GlossaryEntry(
      term: 'Amethyst',
      termTr: 'Ametist',
      hint: 'Huzur ve sezgi',
      definition:
          'Mor renkli kuvars kristali. Sakinlik, spiritüel farkındalık ve sezgiyi güçlendirir. Taç ve üçüncü göz çakrasıyla çalışır.',
      deepExplanation:
          'Antik çağda sarhoşluğa karşı koruyucu olarak kullanılırdı. Meditasyonu derinleştirir, uykuyu iyileştirir, negatif enerjiyi dönüştürür.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Taç Çakra', 'Sezgi'],
    ),
    GlossaryEntry(
      term: 'Rose Quartz',
      termTr: 'Gül Kuvars',
      hint: 'Koşulsuz sevgi',
      definition:
          'Pembe renkli kuvars kristali. Koşulsuz sevgi, kendini sevme ve duygusal şifayı destekler. Kalp çakrasıyla çalışır.',
      deepExplanation:
          'Sevgi taşı olarak bilinir. Kalp yaralarını iyileştirir, kendini affetmeyi kolaylaştırır, ilişkilerde şefkati artırır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Kalp Çakra', 'Sevgi'],
    ),
    GlossaryEntry(
      term: 'Citrine',
      termTr: 'Sitrin',
      hint: 'Bolluk ve neşe',
      definition:
          'Sarı renkli kuvars kristali. Bolluk, neşe, özgüven ve yaratıcılığı çeker. Güneş sinir ağı çakrasıyla çalışır.',
      deepExplanation:
          'Tüccarın taşı olarak bilinir, finansal bolluğu çeker. Negatif enerjiyi emmez, dönüştürür. Motivasyon ve yaratıcılığı artırır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Bolluk', 'Güneş Çakra'],
    ),
    GlossaryEntry(
      term: 'Tiger Eye',
      termTr: 'Kaplan Gözü',
      hint: 'Cesaret ve koruma',
      definition:
          'Altın-kahverengi çizgili taş. Cesaret, güç, koruma ve netlik sağlar. Güneş sinir ağı çakrasıyla çalışır.',
      deepExplanation:
          'Savaşçının taşı olarak bilinir. Korku ve kaygıyı azaltır, kararlılığı artırır, net karar vermeyi destekler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Koruma', 'Cesaret'],
    ),
    GlossaryEntry(
      term: 'Lapis Lazuli',
      termTr: 'Lapis Lazuli',
      hint: 'Bilgelik ve gerçek',
      definition:
          'Koyu mavi taş, altın piritli. Bilgelik, gerçek, iletişim ve spiritüel farkındalığı destekler. Boğaz ve üçüncü göz çakrasıyla çalışır.',
      deepExplanation:
          'Antik Mısır\'da kraliyet taşıydı. Dürüst iletişimi teşvik eder, sezgisel yetenekleri güçlendirir, spiritüel yolculuğu derinleştirir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Bilgelik', 'Üçüncü Göz'],
    ),
    GlossaryEntry(
      term: 'Black Tourmaline',
      termTr: 'Siyah Turmalin',
      hint: 'Koruma ve topraklanma',
      definition:
          'Güçlü koruyucu taş. Negatif enerjiyi emer, elektromanyetik kirliliğe karşı korur, topraklanmayı sağlar.',
      deepExplanation:
          'En güçlü koruyucu taşlardan biri. Psişik saldırılara karşı kalkan oluşturur, kaygıyı azaltır, fiziksel ve enerjetik detoks destekler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Koruma', 'Kök Çakra'],
    ),
    GlossaryEntry(
      term: 'Clear Quartz',
      termTr: 'Berrak Kuvars',
      hint: 'Güçlendirici ve arındırıcı',
      definition:
          'Şeffaf kuvars kristali. Enerjiyi güçlendirir, niyetleri programlar, diğer kristallerin etkisini artırır.',
      deepExplanation:
          'Ana şifa taşı olarak bilinir. Tüm çakralarla çalışır, enerjiyi temizler, niyetleri manifestasyona dönüştürür.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Kristal', 'Arınma', 'Güçlendirme'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // RİTÜELLER VE PRATİKLER
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _ritualTerms = [
    GlossaryEntry(
      term: 'Morning Ritual',
      termTr: 'Sabah Ritüeli',
      hint: 'Güne bilinçli başlangıç',
      definition:
          'Güne pozitif ve bilinçli başlamak için uygulanan düzenli pratikler dizisi. Meditasyon, niyet belirleme, şükran içerebilir.',
      deepExplanation:
          'Sabah saatleri, bilinçaltının en erişilebilir olduğu zamanlardır. Sabah ritüeli günün tonunu belirler, üretkenliği ve refahı artırır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ritüel', 'Niyet', 'Meditasyon'],
    ),
    GlossaryEntry(
      term: 'Evening Ritual',
      termTr: 'Akşam Ritüeli',
      hint: 'Günü bilinçli kapatma',
      definition:
          'Günü değerlendirmek, bırakmak ve kaliteli uykuya hazırlanmak için uygulanan akşam pratikleri.',
      deepExplanation:
          'Günün enerjisini temizlemek, yarım kalan işleri bilinçli olarak bırakmak ve bedenin uyku moduna geçmesini desteklemek için önemlidir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ritüel', 'Bırakma', 'Uyku'],
    ),
    GlossaryEntry(
      term: 'New Moon Ritual',
      termTr: 'Yeni Ay Ritüeli',
      hint: 'Yeni başlangıçlar',
      definition:
          'Yeni ay döneminde niyet belirleme, tohum ekme ve yeni projelere başlama için uygulanan ritüel.',
      deepExplanation:
          'Yeni ay, manifestasyon için en güçlü zamandır. Karanlıkta tohum ekilir, ay büyüdükçe niyetler de büyür.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ay Fazı', 'Niyet', 'Manifestasyon'],
    ),
    GlossaryEntry(
      term: 'Full Moon Ritual',
      termTr: 'Dolunay Ritüeli',
      hint: 'Bırakma ve arınma',
      definition:
          'Dolunay döneminde bırakma, arınma, şükran ve kutlama için uygulanan ritüel.',
      deepExplanation:
          'Dolunay enerji zirvesidir. Artık hizmet etmeyen şeyleri bırakma, başarıları kutlama ve içsel aydınlanma zamanıdır.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ay Fazı', 'Bırakma', 'Arınma'],
    ),
    GlossaryEntry(
      term: 'Intention Setting',
      termTr: 'Niyet Belirleme',
      hint: 'Bilinçli odaklanma',
      definition:
          'İstenilen sonucu veya deneyimi net bir şekilde ifade ederek evrenle işbirliği kurma pratiği.',
      deepExplanation:
          'Niyet, düşünce ile eylem arasındaki köprüdür. "İstiyorum" yerine "niyetliyim" kullanmak daha güçlüdür çünkü şimdiki zamana çapa atar.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Manifestasyon', 'Niyet', 'Odaklanma'],
    ),
    GlossaryEntry(
      term: 'Gratitude Practice',
      termTr: 'Şükran Pratiği',
      hint: 'Minnettarlık ritüeli',
      definition:
          'Sahip olunan şeyler için bilinçli olarak şükretme pratiği. Bolluk bilincini ve pozitifliği artırır.',
      deepExplanation:
          'Bilimsel araştırmalar şükran pratiğinin mutluluğu, sağlığı ve ilişkileri iyileştirdiğini gösteriyor. Beyni pozitife yeniden programlar.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Şükran', 'Bolluk', 'Pozitiflik'],
    ),
    GlossaryEntry(
      term: 'Releasing Ritual',
      termTr: 'Bırakma Ritüeli',
      hint: 'Eski enerjileri serbest bırakma',
      definition:
          'Artık hizmet etmeyen duygu, düşünce, alışkanlık veya ilişkileri bilinçli olarak bırakma pratiği.',
      deepExplanation:
          'Bırakma yazmak ve yakmak, suyun içine atmak veya nefesle vermek şeklinde olabilir. Sembolik eylem bilinçaltına güçlü mesaj gönderir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Arınma', 'Dönüşüm', 'Bırakma'],
    ),
    GlossaryEntry(
      term: 'Affirmation',
      termTr: 'Olumlama',
      hint: 'Pozitif ifadeler',
      definition:
          'Bilinçaltını yeniden programlamak için tekrarlanan pozitif, şimdiki zamanda ifadeler.',
      deepExplanation:
          '"Ben yeterliyim", "Bolluk bana akıyor" gibi ifadeler. Ayna karşısında, yazılı veya sesli tekrarlanabilir. İnançları dönüştürür.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Manifestasyon', 'Bilinçaltı', 'Pozitiflik'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // PSİKOLOJİK KAVRAMLAR 2
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _psychologicalTerms2 = [
    GlossaryEntry(
      term: 'Shadow Self',
      termTr: 'Gölge Benlik',
      hint: 'Bastırılan yönler',
      definition:
          'Carl Jung\'un kavramı. Toplumsal kabul görmediği için bastırılan, reddedilen veya farkında olunmayan kişilik yönleri.',
      deepExplanation:
          'Gölge, karanlık değil, sadece bilinçdışıdır. İçinde bastırılmış yetenekler de vardır. Gölge çalışması bütünleşme ve özgürleşme getirir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Jung', 'Bilinçaltı', 'Projeksiyon'],
    ),
    GlossaryEntry(
      term: 'Red Flags',
      termTr: 'Kırmızı Bayraklar',
      hint: 'Uyarı işaretleri',
      definition:
          'İlişkilerde veya durumlarda dikkat edilmesi gereken uyarı işaretleri. Astrolojik haritada görülebilen zorlu eğilimler.',
      deepExplanation:
          'Her burcun ve gezegen konumunun potansiyel red flag\'leri vardır. Bunlar kötü değil, farkındalık gerektiren alanlardır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['İlişki', 'Farkındalık', 'Green Flag'],
    ),
    GlossaryEntry(
      term: 'Green Flags',
      termTr: 'Yeşil Bayraklar',
      hint: 'Olumlu işaretler',
      definition:
          'İlişkilerde veya durumlarda olumlu, sağlıklı işaretler. Astrolojik haritada görülen güçlü yönler.',
      deepExplanation:
          'Green flag\'ler doğal yetenekleri ve olumlu eğilimleri gösterir. Bunları tanımak ve geliştirmek öz güveni artırır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['İlişki', 'Güçlü Yönler', 'Red Flag'],
    ),
    GlossaryEntry(
      term: 'Inner Child',
      termTr: 'İç Çocuk',
      hint: 'Çocukluk benliği',
      definition:
          'Yetişkin içinde yaşayan çocukluk deneyimleri, duyguları ve inançlarının toplamı. Şifa çalışmasının önemli parçası.',
      deepExplanation:
          'İç çocuk hem yaralı hem de neşeli olabilir. Ay burcu ve 4. ev iç çocuk hakkında bilgi verir. Yeniden ebeveynlik pratiği şifa getirir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Ay', '4. Ev', 'Şifa'],
    ),
    GlossaryEntry(
      term: 'Projection',
      termTr: 'Projeksiyon',
      hint: 'Yansıtma mekanizması',
      definition:
          'Kendi içimizde kabul etmediğimiz özellikleri başkalarında görme savunma mekanizması.',
      deepExplanation:
          'Descendant ve 7. ev projeksiyon alanlarını gösterir. Başkalarında sinir bozan özellikler genellikle kendi gölgemizdir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Gölge Benlik', 'Descendant', '7. Ev'],
    ),
    GlossaryEntry(
      term: 'Subconscious Mind',
      termTr: 'Bilinçaltı',
      hint: 'Zihnin gizli katmanı',
      definition:
          'Farkında olmadığımız düşünceler, anılar ve programlamaların depolandığı zihin katmanı. Davranışların %95\'ini yönetir.',
      deepExplanation:
          '12. ev ve Neptün bilinçaltıyla ilişkilidir. Rüyalar, meditasyon ve hipnoz bilinçaltına erişim kapılarıdır.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['12. Ev', 'Neptün', 'Rüya'],
    ),
    GlossaryEntry(
      term: 'Intuition',
      termTr: 'Sezgi',
      hint: 'İçsel bilgelik',
      definition:
          'Mantıksal analiz olmadan doğrudan bilme yetisi. Su burçları ve Neptün sezgiyle ilişkilidir.',
      deepExplanation:
          'Sezgi, evrenle bağlantımızdır. Ay, Neptün ve üçüncü göz çakrası sezgisel kapasiteyi gösterir. Pratikle güçlendirilebilir.',
      category: GlossaryCategory.psychological,
      relatedTerms: ['Neptün', 'Üçüncü Göz', 'Su Burçları'],
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // SPİRİTÜEL KAVRAMLAR
  // ═══════════════════════════════════════════════════════════════
  static final List<GlossaryEntry> _spiritualConcepts = [
    GlossaryEntry(
      term: 'Manifestation',
      termTr: 'Manifestasyon',
      hint: 'Düşünceyi gerçeğe dönüştürme',
      definition:
          'Düşünce, niyet ve enerjinin fiziksel gerçekliğe dönüştürülmesi süreci.',
      deepExplanation:
          'Manifestasyon, netlik + niyet + his + eylem formülüne dayanır. Jüpiter ve 9. ev genişleme ve manifestasyonla ilişkilidir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Niyet', 'Çekim Yasası', 'Jüpiter'],
    ),
    GlossaryEntry(
      term: 'Cosmic Energy',
      termTr: 'Kozmik Enerji',
      hint: 'Evrensel yaşam gücü',
      definition:
          'Tüm evrende akan, yaşamı sürdüren ve birbirine bağlayan evrensel enerji.',
      deepExplanation:
          'Prana, chi, mana gibi farklı kültürlerde farklı adları vardır. Astroloji, kozmik enerjilerin bizi nasıl etkilediğini inceler.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Prana', 'Chi', 'Enerji'],
    ),
    GlossaryEntry(
      term: 'Higher Self',
      termTr: 'Yüksek Benlik',
      hint: 'Ruhsal özümüz',
      definition:
          'Fiziksel ve ego benliğin ötesindeki, evrensel bilgeliğe bağlı spiritüel kimliğimiz.',
      deepExplanation:
          'Yüksek benlik, ruhun ebedi parçasıdır. Güneş ve taç çakra yüksek benlikle bağlantılıdır. Meditasyonla iletişim kurulabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ruh', 'Taç Çakra', 'Bilgelik'],
    ),
    GlossaryEntry(
      term: 'Soul Contract',
      termTr: 'Ruh Sözleşmesi',
      hint: 'Doğum öncesi anlaşma',
      definition:
          'Doğmadan önce belirlenen yaşam dersleri, ilişkiler ve deneyimler hakkındaki spiritüel anlaşma.',
      deepExplanation:
          'Doğum haritası ruh sözleşmesinin haritasıdır. Düğümler (North/South Node) özellikle karmik sözleşmeleri gösterir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Karma', 'Düğümler', 'Yaşam Amacı'],
    ),
    GlossaryEntry(
      term: 'Abundance',
      termTr: 'Bolluk',
      hint: 'Sınırsız evrensel akış',
      definition:
          'Evrenin sınırsız kaynaklarına ve akışına açık olma durumu. Sadece maddi değil, tüm alanlarda bereket.',
      deepExplanation:
          'Bolluk bilinci kıtlık korkusunun tersidir. Jüpiter, Venüs ve 2. ev bolluk potansiyelini gösterir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Jüpiter', '2. Ev', 'Bereket'],
    ),
    GlossaryEntry(
      term: 'Transformation',
      termTr: 'Dönüşüm',
      hint: 'Köklü değişim',
      definition:
          'Derin, kalıcı ve köklü değişim süreci. Eski yapının yıkılıp yenisinin inşa edilmesi.',
      deepExplanation:
          'Pluto ve 8. ev dönüşümün ana göstergeleridir. Akrep enerjisi, ölüm-yeniden doğuş döngüsünü yönetir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Pluto', '8. Ev', 'Akrep'],
    ),
    GlossaryEntry(
      term: 'Awakening',
      termTr: 'Uyanış',
      hint: 'Spiritüel farkındalık',
      definition:
          'Bilinç seviyesinin yükselmesi, gerçekliğin daha derin katmanlarını algılamaya başlama süreci.',
      deepExplanation:
          'Uranüs transitleri ani uyanışları tetikler. Uyanış süreci bazen kriz olarak deneyimlenir ama büyümeye götürür.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Uranüs', 'Bilinç', 'Farkındalık'],
    ),
    GlossaryEntry(
      term: 'Aura',
      termTr: 'Aura',
      hint: 'Enerji alanı',
      definition:
          'Canlıları çevreleyen, çeşitli renklerde görülebilen enerji alanı. Duygusal ve spiritüel durumu yansıtır.',
      deepExplanation:
          'Auranın 7 katmanı vardır, her biri bir çakraya karşılık gelir. Aura fotoğrafçılığı ve sezgisel görüşle algılanabilir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Çakra', 'Enerji', 'Renk'],
    ),
    GlossaryEntry(
      term: 'Divine Feminine',
      termTr: 'İlahi Dişil',
      hint: 'Dişil evrensel enerji',
      definition:
          'Alıcı, sezgisel, yaratıcı ve besleyici evrensel dişil enerji. Ay, Venüs ve su elementleriyle ilişkili.',
      deepExplanation:
          'Lilith, Ceres ve asteroidler ilahi dişilin farklı yüzlerini gösterir. Modern astroloji bu enerjileri dengelemeye önem verir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Ay', 'Venüs', 'Lilith'],
    ),
    GlossaryEntry(
      term: 'Divine Masculine',
      termTr: 'İlahi Eril',
      hint: 'Eril evrensel enerji',
      definition:
          'Aktif, koruyucu, yapıcı ve yönlendirici evrensel eril enerji. Güneş, Mars ve ateş elementleriyle ilişkili.',
      deepExplanation:
          'Sağlıklı eril enerji korur, sınır koyar ve harekete geçer. Zehirli erkeklikten farklıdır, denge gerektirir.',
      category: GlossaryCategory.esoteric,
      relatedTerms: ['Güneş', 'Mars', 'Satürn'],
    ),
  ];
}
