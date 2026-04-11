/// Birth Chart Mega Content - Doğum Haritası Derinlemesine Analizi
/// Evler, Açılar, Desenler ve Yorumlar
library;

// ════════════════════════════════════════════════════════════════════════════
// 12 EV SİSTEMİ - HAYATIN ALANLARI
// ════════════════════════════════════════════════════════════════════════════

class HouseSystemContent {
  static const String introduction = '''
Doğum haritasındaki 12 ev, hayatın farklı alanlarını temsil eder.
Her ev belirli temaları, deneyimleri ve yaşam konularını yönetir.
Bir evde bulunan gezegenler, o alanın nasıl deneyimleneceğini gösterir.
Evlerin başlangıç noktası (cusp) hangi burçtaysa, o burcun enerjisi o alanı renklendirir.
''';

  static const Map<int, HouseContent> houses = {
    1: HouseContent(
      number: 1,
      name: 'Yükselen Ev / Ascendant',
      latinName: 'Vita',
      keywords: [
        'Benlik',
        'Görünüm',
        'İlk izlenim',
        'Fiziksel beden',
        'Başlangıçlar',
      ],
      lifeArea: 'Kim olduğunuz ve dünyaya nasıl göründüğünüz',
      naturalSign: 'Koç',
      naturalRuler: 'Mars',
      bodyParts: ['Baş', 'Yüz', 'Genel fiziksel görünüm'],
      description: '''
1. Ev, doğum haritasının en kişisel noktasıdır. Yükselen burcunuz (Ascendant)
burada başlar. Bu ev, dünyaya nasıl göründüğünüzü, ilk izlenimi, fiziksel
görünümünüzü ve spontan tepkilerinizi temsil eder.

1. Evdeki gezegenler kişiliğinizin "ön yüzünü" oluşturur. İnsanların sizi
ilk gördüğünde algıladığı enerji budur. Güneş işaretiniz iç dünyanızı
gösterirken, yükselen işaretiniz dış dünyanıza açılan kapıdır.

Bu ev aynı zamanda tüm yeni başlangıçları, kişisel projeleri ve
"ben" ile ilgili her şeyi kapsar.
''',
      planetsInHouse: {
        'Sun': PlanetInHouseInterpretation(
          planet: 'Güneş',
          interpretation: '''
Güneş 1. evde doğal liderlik ve güçlü özgüven verir. Kişi dikkat çeker,
merkeze oturma eğilimindedir. Kimlik ve benlik hayatın merkezindedir.
Bazen ego şişkinliği veya kibirle mücadele gerekebilir.
''',
          strengths: ['Karizmatik', 'Özgüvenli', 'Lider', 'Canlı enerji'],
          challenges: ['Ego sorunları', 'Dikkat ihtiyacı', 'Bencillik riski'],
          advice:
              'Işığınızı paylaşın ama başkalarının da parlamasına izin verin.',
        ),
        'Moon': PlanetInHouseInterpretation(
          planet: 'Ay',
          interpretation: '''
Ay 1. evde duygusal, sezgisel ve değişken bir kişilik verir. Duygular
yüzeyde, herkes tarafından okunabilir. Bakım verici ama aşırı hassas.
''',
          strengths: ['Empatik', 'Sezgisel', 'Bakım verici', 'Adaptif'],
          challenges: [
            'Duygu dalgalanmaları',
            'Aşırı hassasiyet',
            'Kimlik değişkenliği',
          ],
          advice:
              'Duygusal sınırlar koymayı öğrenin, her şeyi içselleştirmeyin.',
        ),
        'Mercury': PlanetInHouseInterpretation(
          planet: 'Merkür',
          interpretation: '''
Merkür 1. evde zeki, meraklı ve iletişimci bir kişilik verir. Sürekli
konuşan, soru soran, öğrenen biri. Genç görünüm ve genç enerji.
''',
          strengths: ['Zeki', 'Konuşkan', 'Adaptif', 'Genç enerji'],
          challenges: ['Sinirlilik', 'Yerinde duramama', 'Yüzeysellik'],
          advice: 'Derinleşmeyi öğrenin, sadece bilgi toplamakla yetinmeyin.',
        ),
        'Venus': PlanetInHouseInterpretation(
          planet: 'Venüs',
          interpretation: '''
Venüs 1. evde çekici, şık ve uyumlu bir görünüm verir. Estetik duyarlılık
yüksek. İnsanlar bu kişiyi sever, onun yanında rahat ederler.
''',
          strengths: ['Çekici', 'Şık', 'Diplomatik', 'Sevimli'],
          challenges: ['Onay bağımlılığı', 'Yüzeysellik', 'Karar verememe'],
          advice: 'İç güzelliğinizi dış güzellik kadar geliştirin.',
        ),
        'Mars': PlanetInHouseInterpretation(
          planet: 'Mars',
          interpretation: '''
Mars 1. evde güçlü, enerjik, rekabetçi ve cesur bir kişilik verir.
Atletik görünüm, hızlı tepkiler, bazen saldırgan tavırlar.
''',
          strengths: ['Enerjik', 'Cesur', 'Atletik', 'Girişimci'],
          challenges: ['Öfke sorunları', 'Sabırsızlık', 'Çatışmacı'],
          advice: 'Enerjinizi yapıcı kanallara yönlendirin.',
        ),
        'Jupiter': PlanetInHouseInterpretation(
          planet: 'Jüpiter',
          interpretation: '''
Jüpiter 1. evde iyimser, cömert ve şanslı bir kişilik verir. Büyük
düşünen, genişleyen, bolluğu çeken biri. Fiziksel olarak iri olabilir.
''',
          strengths: ['İyimser', 'Cömert', 'Şanslı', 'Vizyoner'],
          challenges: ['Aşırılık', 'Kilo sorunu', 'Abartma'],
          advice: 'Genişlemenizi dengeli tutun, aşırılığa kaçmayın.',
        ),
        'Saturn': PlanetInHouseInterpretation(
          planet: 'Satürn',
          interpretation: '''
Satürn 1. evde ciddi, sorumlu ama kendine güvensiz bir başlangıç verir.
Çocukluk zor geçmiş olabilir. Yaşla birlikte özgüven artar.
''',
          strengths: ['Disiplinli', 'Sorumlu', 'Olgun', 'Dayanıklı'],
          challenges: ['Özgüven eksikliği', 'Çekingenlik', 'Depresyon eğilimi'],
          advice: 'Kendinize karşı daha az sert olun. Zamana güvenin.',
        ),
        'Uranus': PlanetInHouseInterpretation(
          planet: 'Uranüs',
          interpretation: '''
Uranüs 1. evde özgün, sıra dışı, isyankar bir kişilik verir. Toplumsal
normlara uymayan, farklı olan, yenilikçi biri.
''',
          strengths: ['Özgün', 'Yenilikçi', 'Bağımsız', 'Karizmatik'],
          challenges: ['İstikrarsızlık', 'Yabancılaşma', 'Şok edicilik'],
          advice: 'Farklılığınızı kutlayın ama bağlantı kurmayı da öğrenin.',
        ),
        'Neptune': PlanetInHouseInterpretation(
          planet: 'Neptün',
          interpretation: '''
Neptün 1. evde mistik, sanatsal, hassas ama tanımsız bir kişilik verir.
Bukalemun gibi ortama uyum sağlar. Spiritüel aura taşır.
''',
          strengths: ['Sezgisel', 'Sanatsal', 'Şefkatli', 'İlham verici'],
          challenges: ['Kimlik karışıklığı', 'Aldatılma', 'Kaçış eğilimi'],
          advice:
              'Kim olduğunuzu net tanımlayın, başkalarının sizi tanımlamasına izin vermeyin.',
        ),
        'Pluto': PlanetInHouseInterpretation(
          planet: 'Plüton',
          interpretation: '''
Plüton 1. evde yoğun, manyetik, dönüştürücü bir kişilik verir. Derin
bakışlar, güçlü varlık. İnsanları rahatsız edebilir veya büyüleyebilir.
''',
          strengths: ['Güçlü', 'Dönüştürücü', 'Manyetik', 'Dayanıklı'],
          challenges: ['Kontrol ihtiyacı', 'Yoğunluk', 'Güven sorunları'],
          advice: 'Gücünüzü farkında olarak kullanın, bilinçli dönüşümü seçin.',
        ),
      },
      signsOnCusp: {
        'Koç': 'Enerjik, cesur, impulsif görünüm. Atletik. Hızlı tepki.',
        'Boğa':
            'Sakin, güvenilir, sağlam görünüm. Güzel ses. Yavaş ama kararlı.',
        'İkizler': 'Genç, hareketli, konuşkan görünüm. İnce yapı. Meraklı.',
        'Yengeç': 'Bakım verici, duygusal, değişken görünüm. Yuvarlak yüz.',
        'Aslan': 'Gösterişli, karizmatik, dikkat çekici görünüm. Gür saç.',
        'Başak': 'Temiz, düzenli, mütevazı görünüm. Detaycı. Kritik bakış.',
        'Terazi': 'Şık, uyumlu, çekici görünüm. Diplomatik. Kararsız.',
        'Akrep': 'Yoğun, manyetik, gizemli görünüm. Delici bakış.',
        'Yay': 'Neşeli, sportif, özgür görünüm. Uzun yapı. İyimser.',
        'Oğlak': 'Ciddi, profesyonel, olgun görünüm. Kemikli yapı.',
        'Kova': 'Farklı, sıra dışı, mesafeli görünüm. Beklenmedik stil.',
        'Balık': 'Rüya gibi, yumuşak, mistik görünüm. Hassas. Adaptif.',
      },
    ),

    7: HouseContent(
      number: 7,
      name: 'İlişkiler Evi / Descendant',
      latinName: 'Uxor',
      keywords: [
        'Evlilik',
        'Ortaklık',
        'Birebir ilişkiler',
        'Açık düşmanlar',
        'Sözleşmeler',
      ],
      lifeArea: 'Ciddi ilişkiler ve nasıl partner seçtiğiniz',
      naturalSign: 'Terazi',
      naturalRuler: 'Venüs',
      bodyParts: ['Böbrekler', 'Bel altı', 'Cilt'],
      description: '''
7. Ev, ilişkilerinizin ve ortaklıklarınızın evi. Descendant (batı ufku)
burada başlar ve 1. evin tam karşısındadır. "Ben" ile "Öteki" arasındaki
dengeyi temsil eder.

Bu ev evliliği, iş ortaklıklarını, danışmanları (avukat, terapist) ve
paradoks olarak "açık düşmanları" da kapsar. Karşınıza kim çıkıyor?
Onlarda kendinizin hangi yönünü görüyorsunuz?

7. Evdeki gezegenler, ne tür partnerlere çekildiğinizi ve ilişkilerde
nasıl bir dinamik yarattığınızı gösterir.
''',
      planetsInHouse: {
        'Sun': PlanetInHouseInterpretation(
          planet: 'Güneş',
          interpretation: '''
Güneş 7. evde kimliğin ilişkiler yoluyla bulunduğunu gösterir. Partner
olmak hayatın merkezi. Güçlü, parlak partnerlere çekilim.
''',
          strengths: ['İlişki odaklı', 'İşbirlikçi', 'Diplomatik'],
          challenges: ['Partner bağımlılığı', 'Kimliği partnere bağlama'],
          advice: 'Kendi kimliğinizi ilişkiden bağımsız geliştirin.',
        ),
        'Moon': PlanetInHouseInterpretation(
          planet: 'Ay',
          interpretation: '''
Ay 7. evde duygusal güvenliğin ilişkilerden geldiğini gösterir. Bakım
veren/alan partnerlere çekilim. Duygusal bağımlılık riski.
''',
          strengths: ['Şefkatli partner', 'Duygusal destek', 'Ev kurmak'],
          challenges: [
            'Bağımlılık',
            'Ruh hali partnere bağlı',
            'Klinger davranış',
          ],
          advice: 'Duygusal bağımsızlığı koruyun.',
        ),
        'Venus': PlanetInHouseInterpretation(
          planet: 'Venüs',
          interpretation: '''
Venüs 7. evde güçlü bir konumdur (Terazi'nin doğal evi). İlişkilerde
uyum, güzellik ve aşk arayışı. Çekici partnerlere çekilim.
''',
          strengths: ['Uyumlu ilişkiler', 'Çekici partnerler', 'Evlilik şansı'],
          challenges: [
            'İlişki bağımlılığı',
            'Yüzeysel seçimler',
            'Karar verememe',
          ],
          advice: 'İçsel değerleri dış güzellik kadar değerlendirin.',
        ),
        'Mars': PlanetInHouseInterpretation(
          planet: 'Mars',
          interpretation: '''
Mars 7. evde tutkulu, çatışmalı, rekabetçi ilişkiler. Güçlü partnerlere
çekilim ama güç savaşları riski.
''',
          strengths: [
            'Tutkulu ilişkiler',
            'Koruyucu partner',
            'Aktif ortaklık',
          ],
          challenges: ['Çatışma', 'Güç savaşları', 'Saldırgan partnerler'],
          advice: 'Çatışmayı yapıcı kanallara yönlendirin.',
        ),
        'Saturn': PlanetInHouseInterpretation(
          planet: 'Satürn',
          interpretation: '''
Satürn 7. evde ciddi, geç gelen ama kalıcı ilişkiler. Yaşça büyük
partnerlere çekilim. İlişkilerde sorumluluk ve zorluklar.
''',
          strengths: ['Kalıcı evlilik', 'Olgun partnerler', 'Sadakat'],
          challenges: ['Geç evlilik', 'Yalnızlık', 'Aşırı ciddiyet'],
          advice: 'İlişkilerde eğlenceyi de unutmayın.',
        ),
      },
      signsOnCusp: {
        'Koç': 'Cesur, bağımsız, meydan okuyan partnerlere çekilim.',
        'Boğa': 'Güvenilir, sağlam, duyusal partnerlere çekilim.',
        'İkizler': 'Zeki, konuşkan, çok yönlü partnerlere çekilim.',
        'Yengeç': 'Bakım veren, duygusal, aile odaklı partnerlere çekilim.',
        'Aslan': 'Karizmatik, cömert, gösterişli partnerlere çekilim.',
        'Başak': 'Pratik, detaycı, yardımsever partnerlere çekilim.',
        'Terazi': 'Uyumlu, şık, diplomatik partnerlere çekilim.',
        'Akrep': 'Yoğun, güçlü, dönüştürücü partnerlere çekilim.',
        'Yay': 'Maceraperest, felsefi, özgür partnerlere çekilim.',
        'Oğlak': 'Hırslı, başarılı, olgun partnerlere çekilim.',
        'Kova': 'Farklı, bağımsız, entelektüel partnerlere çekilim.',
        'Balık': 'Sanatsal, spiritüel, hassas partnerlere çekilim.',
      },
    ),

    10: HouseContent(
      number: 10,
      name: 'Kariyer Evi / Midheaven',
      latinName: 'Regnum',
      keywords: ['Kariyer', 'Statü', 'Toplumsal imaj', 'Başarı', 'Amaçlar'],
      lifeArea: 'Kariyer, toplumsal konum ve kamusal imaj',
      naturalSign: 'Oğlak',
      naturalRuler: 'Satürn',
      bodyParts: ['Dizler', 'Kemikler', 'Deri'],
      description: '''
10. Ev, haritanın en görünür noktası - Midheaven (MC). Kariyer, toplumsal
statü, şöhret, başarı ve kamusal imajı temsil eder. İnsanların sizi
toplum içinde nasıl gördüğü.

Bu ev aynı zamanda hayat amaçlarını, mirası ve "bırakacağınız iz"i
kapsar. 4. Evin (aile, kökler) karşısında durur - nereden geldiğiniz
ile nereye gittiğiniz arasındaki denge.

10. Evdeki gezegenler kariyer yönelimini ve toplumsal başarı potansiyelini gösterir.
''',
      planetsInHouse: {
        'Sun': PlanetInHouseInterpretation(
          planet: 'Güneş',
          interpretation: '''
Güneş 10. evde kariyer odaklı, hırslı, toplumda tanınmak isteyen biri.
Liderlik pozisyonları, otorite, şöhret potansiyeli.
''',
          strengths: ['Kariyer başarısı', 'Tanınma', 'Liderlik', 'Otorite'],
          challenges: [
            'İş bağımlılığı',
            'Özel hayat ihmali',
            'Statü takıntısı',
          ],
          advice: 'Başarı tanımınızı genişletin, sadece iş değil.',
        ),
        'Moon': PlanetInHouseInterpretation(
          planet: 'Ay',
          interpretation: '''
Ay 10. evde kamusal hayatta duygusal yatırım. Halkla ilgili işler,
bakım/beslenme kariyerleri. Kamusal imaj değişken.
''',
          strengths: [
            'Halkla bağlantı',
            'Bakım kariyerleri',
            'Duygusal liderlik',
          ],
          challenges: [
            'Duyguların iş yerinde görünmesi',
            'İstikrarsız kariyer',
          ],
          advice: 'Duygusal zekayı profesyonel alanda kullanın.',
        ),
        'Jupiter': PlanetInHouseInterpretation(
          planet: 'Jüpiter',
          interpretation: '''
Jüpiter 10. evde kariyer şansı, büyük başarı potansiyeli. Yurtdışı
bağlantılar, eğitim, hukuk, yayıncılık alanlarında parlama.
''',
          strengths: [
            'Kariyer şansı',
            'Genişleme',
            'Tanınma',
            'Uluslararası başarı',
          ],
          challenges: ['Aşırı büyüme', 'Çok vaatte bulunma', 'Kibirlenme'],
          advice: 'Şansınızı akıllıca kullanın, sürdürülebilir büyüyün.',
        ),
        'Saturn': PlanetInHouseInterpretation(
          planet: 'Satürn',
          interpretation: '''
Satürn 10. evde güçlü bir konumdur (kendi evi). Yavaş ama kalıcı kariyer
inşası. Geç gelen ama sağlam başarı. Otorite figürü olma.
''',
          strengths: ['Kalıcı başarı', 'Disiplin', 'Otorite', 'Güvenilirlik'],
          challenges: ['Yavaş ilerleme', 'Aşırı sorumluluk', 'İş baskısı'],
          advice: 'Sabırlı olun, her adım sizi zirveye taşıyor.',
        ),
      },
      signsOnCusp: {
        'Koç': 'Girişimci, öncü, bağımsız kariyer. Kendi işini kurma.',
        'Boğa':
            'İstikrarlı, finansal odaklı kariyer. Sanat, güzellik sektörleri.',
        'İkizler': 'İletişim, medya, eğitim kariyerleri. Çok yönlü iş hayatı.',
        'Yengeç': 'Bakım, gıda, emlak kariyerleri. Aile işi potansiyeli.',
        'Aslan': 'Yaratıcı, liderlik, eğlence kariyerleri. Tanınma arzusu.',
        'Başak': 'Sağlık, hizmet, analitik kariyerler. Detay odaklı iş.',
        'Terazi': 'Hukuk, diplomasi, sanat kariyerleri. Ortaklıkla başarı.',
        'Akrep': 'Araştırma, psikoloji, finans kariyerleri. Güç pozisyonları.',
        'Yay': 'Eğitim, yayıncılık, seyahat kariyerleri. Uluslararası iş.',
        'Oğlak': 'Yönetim, devlet, kurumsal kariyer. Geleneksel başarı.',
        'Kova': 'Teknoloji, bilim, sosyal hareket kariyerleri. Yenilikçi iş.',
        'Balık': 'Sanat, şifa, spiritüel kariyerler. Yaratıcı sektörler.',
      },
    ),
    // Diğer evler benzer detayda devam...
  };
}

class HouseContent {
  final int number;
  final String name;
  final String latinName;
  final List<String> keywords;
  final String lifeArea;
  final String naturalSign;
  final String naturalRuler;
  final List<String> bodyParts;
  final String description;
  final Map<String, PlanetInHouseInterpretation> planetsInHouse;
  final Map<String, String> signsOnCusp;

  const HouseContent({
    required this.number,
    required this.name,
    required this.latinName,
    required this.keywords,
    required this.lifeArea,
    required this.naturalSign,
    required this.naturalRuler,
    required this.bodyParts,
    required this.description,
    required this.planetsInHouse,
    required this.signsOnCusp,
  });
}

class PlanetInHouseInterpretation {
  final String planet;
  final String interpretation;
  final List<String> strengths;
  final List<String> challenges;
  final String advice;

  const PlanetInHouseInterpretation({
    required this.planet,
    required this.interpretation,
    required this.strengths,
    required this.challenges,
    required this.advice,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// AÇILAR (ASPECTS)
// ════════════════════════════════════════════════════════════════════════════

class AspectContent {
  static const Map<String, AspectInterpretation> planetaryAspects = {
    'sun_moon_conjunction': AspectInterpretation(
      aspect: 'Güneş - Ay Kavuşum',
      angle: 0,
      nature: 'Güçlü, birleşik',
      orb: 10,
      description: '''
Yeniay doğumu. Ego ve duygular birleşir. Güçlü irade ama tek boyutlu
bakış açısı riski. Yeni başlangıçlar için doğal yetenek.
''',
      strengths: [
        'Güçlü irade',
        'Tutarlılık',
        'Odaklanma',
        'Yeni başlangıçlar',
      ],
      challenges: [
        'Tek boyutlu',
        'Objektiflik zorluğu',
        'Kendi kendini görememe',
      ],
      advice: 'Başkalarının perspektifini almayı öğrenin.',
    ),
    'sun_moon_opposition': AspectInterpretation(
      aspect: 'Güneş - Ay Karşıt',
      angle: 180,
      nature: 'Gerilim, denge arayışı',
      orb: 10,
      description: '''
Dolunay doğumu. İç dünya ile dış dünya arasında gerilim. İlişkilerde
denge arayışı. Objektif bakış ama iç çatışma.
''',
      strengths: ['Objektiflik', 'İlişki farkındalığı', 'Denge potansiyeli'],
      challenges: ['İç çatışma', 'Kararsızlık', 'İlişki bağımlılığı'],
      advice: 'İç dengenizi dışarıda aramayın.',
    ),
    'sun_mars_conjunction': AspectInterpretation(
      aspect: 'Güneş - Mars Kavuşum',
      angle: 0,
      nature: 'Enerjik, aktif',
      orb: 8,
      description: '''
Güçlü irade, fiziksel enerji, rekabet ruhu. Doğal atlet veya savaşçı.
Cesaret ama saldırganlık riski.
''',
      strengths: ['Enerji', 'Cesaret', 'Liderlik', 'Fiziksel güç'],
      challenges: ['Öfke', 'Saldırganlık', 'Sabırsızlık', 'Çatışmacılık'],
      advice: 'Enerjiyi yapıcı alanlara kanalize edin.',
    ),
    'venus_mars_conjunction': AspectInterpretation(
      aspect: 'Venüs - Mars Kavuşum',
      angle: 0,
      nature: 'Tutkulu, çekici',
      orb: 8,
      description: '''
Feminen ve maskülen enerjilerin birleşimi. Yoğun cinsel çekim, yaratıcılık,
sanatsal tutku. Çekicilik ve karizma.
''',
      strengths: ['Çekicilik', 'Tutku', 'Yaratıcılık', 'Karizma'],
      challenges: ['Aşırı tutku', 'İlişki draması', 'Possessiflik'],
      advice: 'Tutkuyu dengeli ifade edin.',
    ),
    'saturn_pluto_conjunction': AspectInterpretation(
      aspect: 'Satürn - Plüton Kavuşum',
      angle: 0,
      nature: 'Yoğun, dönüştürücü',
      orb: 8,
      description: '''
Nesil açısı. Derin yapısal dönüşümler. Güç ve kontrol temaları.
Dayanıklılık ama sertlik. Büyük sorumluluk.
''',
      strengths: ['Dayanıklılık', 'Dönüşüm gücü', 'Disiplin', 'Derinlik'],
      challenges: ['Kontrol ihtiyacı', 'Sertlik', 'Güç mücadeleleri'],
      advice: 'Gücü bilgelikle kullanın, diğerlerini de yükseltin.',
    ),
  };
}

class AspectInterpretation {
  final String aspect;
  final int angle;
  final String nature;
  final int orb;
  final String description;
  final List<String> strengths;
  final List<String> challenges;
  final String advice;

  const AspectInterpretation({
    required this.aspect,
    required this.angle,
    required this.nature,
    required this.orb,
    required this.description,
    required this.strengths,
    required this.challenges,
    required this.advice,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// AÇI DESENLERİ (ASPECT PATTERNS)
// ════════════════════════════════════════════════════════════════════════════

class AspectPatternContent {
  static const Map<String, AspectPattern> patterns = {
    'grand_trine': AspectPattern(
      name: 'Büyük Üçgen (Grand Trine)',
      shape: 'Üçgen (3 x 120°)',
      nature: 'Uyumlu, yetenekli, doğal akış',
      description: '''
Üç gezegen birbirine üçgen açı yapar. Büyük yetenek ve doğal kolaylık alanı.
Ancak bu kolaylık "tembel" de yapabilir - çaba gerektirmediği için
gelişim durabilir.

Eğer üçgen aynı element buruçlarındaysa:
- Ateş: Yaratıcı, coşkulu, ilham dolu
- Toprak: Pratik, üretken, maddi başarı
- Hava: Entelektüel, sosyal, iletişim
- Su: Duygusal, sezgisel, şifalı
''',
      strengths: ['Doğal yetenek', 'Kolay akış', 'Şans', 'Armoni'],
      challenges: [
        'Tembellik',
        'Potansiyeli kullanmama',
        'Meydan okuma eksikliği',
      ],
      advice: 'Yeteneklerinizi aktif olarak kullanın, konfor alanından çıkın.',
    ),
    't_square': AspectPattern(
      name: 'T-Kare (T-Square)',
      shape: 'T şekli (2 x 90° + 1 x 180°)',
      nature: 'Gerilim, motivasyon, mücadele',
      description: '''
İki gezegen karşıt, üçüncüsü her ikisine kare. Sürekli gerilim ve mücadele
alanı. Ancak bu gerilim büyük başarıların motorudur.

Odak noktası (apex - kare yapan gezegen) en çok dikkat gerektiren alandır.
Bu alan hayat boyunca "dönerek" çalışılır.

Eksik bacak (4. işaret) bilinçli olarak geliştirilebilir.
''',
      strengths: ['Motivasyon', 'Başarı dürtüsü', 'Dinamizm', 'Meydan okuma'],
      challenges: ['Sürekli gerilim', 'Stres', 'Çatışma', 'Tükenmişlik'],
      advice: 'Gerilimi itici güç olarak kullanın, aşırı germeyin.',
    ),
    'grand_cross': AspectPattern(
      name: 'Büyük Haç (Grand Cross)',
      shape: 'Artı/Haç (4 x 90° + 2 x 180°)',
      nature: 'Zorlayıcı, güçlü, transformatif',
      description: '''
Dört gezegen kare ve karşıt açılarla birbirine bağlı. Hayatın en zorlayıcı
ama en dönüştürücü deseni. Sürekli çatışma ama büyük güç potansiyeli.

Modaliteye göre:
- Kardinal: Eylem krizi, liderlik mücadelesi
- Sabit: Direnç, inatla tutma
- Değişken: Dağılma, odak sorunu
''',
      strengths: [
        'Büyük güç',
        'Dönüşüm kapasitesi',
        'Dayanıklılık',
        'Çok yönlülük',
      ],
      challenges: ['Sürekli kriz', 'Dağılma', 'Aşırı stres', 'Çatışma'],
      advice: 'Merkez bulun, dengeyi koruyun, bir seferde bir şeye odaklanın.',
    ),
    'yod': AspectPattern(
      name: 'Yod (Tanrının Parmağı)',
      shape: 'Üçgen (2 x 150° + 1 x 60°)',
      nature: 'Kadersel, özel görev, ayarlama',
      description: '''
İki gezegen sextile, üçüncüsü her ikisine quincunx. "Tanrının Parmağı"
veya "Kader Üçgeni" olarak bilinir. Özel bir hayat görevi işaret eder.

Apex gezegeni (quincunx yapan) hayatın kritik noktası. Sürekli ayarlama
ve adaptasyon gerektirir. Kadersel karşılaşmalar ve görevler.
''',
      strengths: ['Özel görev', 'Kadersel yol', 'Benzersiz yetenekler'],
      challenges: ['Uyumsuzluk hissi', 'Sürekli ayarlama', 'Belirsizlik'],
      advice: 'Özel görevinizi keşfedin, farklılığınızı kucaklayın.',
    ),
    'kite': AspectPattern(
      name: 'Uçurtma (Kite)',
      shape: 'Uçurtma şekli (Grand Trine + karşıt)',
      nature: 'Yetenekli ve odaklı',
      description: '''
Büyük Üçgen'e bir karşıtlık eklenir. Üçgenin doğal akışına odak ve
motivasyon kazandırır. En yapıcı desenlerden biri.

Karşıt gezegen "uçurtmanın kuyruğu" gibi yön verir. Yetenekler
somut başarılara dönüşür.
''',
      strengths: ['Yetenek + motivasyon', 'Somut başarı', 'Dengeli güç'],
      challenges: ['Karşıtlığın gerginliği', 'Aşırı odaklanma'],
      advice: 'Yeteneklerinizi odaklı şekilde kullanın.',
    ),
    'mystic_rectangle': AspectPattern(
      name: 'Mistik Dikdörtgen',
      shape: 'Dikdörtgen (2 x karşıt + 2 x trine + 2 x sextile)',
      nature: 'Dengeli, harmonik, pratik mistisizm',
      description: '''
İki karşıtlık trine ve sextile ile birbirine bağlı. Gerilim ve uyum
dengesi. Mistik yetenekleri pratik şekilde kullanma.

Nadir ve güçlü bir desen. Spiritüel yetenekleri dünyevi başarıya çevirebilir.
''',
      strengths: ['Denge', 'Pratik bilgelik', 'Mistik yetenekler'],
      challenges: ['Karşıtlıkların gerginliği'],
      advice: 'Spiritüel ve maddi dünyayı birleştirin.',
    ),
  };
}

class AspectPattern {
  final String name;
  final String shape;
  final String nature;
  final String description;
  final List<String> strengths;
  final List<String> challenges;
  final String advice;

  const AspectPattern({
    required this.name,
    required this.shape,
    required this.nature,
    required this.description,
    required this.strengths,
    required this.challenges,
    required this.advice,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// GEZEGEN GÜÇLERİ (DIGNITIES)
// ════════════════════════════════════════════════════════════════════════════

class PlanetaryDignityContent {
  static const String introduction = '''
Her gezegen bazı burçlarda güçlü (domicile, exaltation), bazılarında zayıf
(detriment, fall) konumdadır. Bu "essential dignity" sistemi gezegenin
ne kadar rahat veya zorlayıcı çalıştığını gösterir.
''';

  static const Map<String, DignityTable> dignities = {
    'sun': DignityTable(
      planet: 'Güneş',
      domicile: 'Aslan',
      exaltation: 'Koç',
      detriment: 'Kova',
      fall: 'Terazi',
      domicileDescription:
          'Güneş Aslan\'da evindedir. Tam gücüyle parlar. Özgüven, yaratıcılık, liderlik doğal akar.',
      exaltationDescription:
          'Güneş Koç\'ta yüceltilir. Cesaret, girişimcilik ve bireysellik zirvededir.',
      detrimentDescription:
          'Güneş Kova\'da zorlanır. Bireysellik ve toplum arasında gerilim. Ego farklılıkla ifade bulur.',
      fallDescription:
          'Güneş Terazi\'de düşüşte. Kimlik başkalarına bağlı. Özgüven ilişkilerden gelir.',
    ),
    'moon': DignityTable(
      planet: 'Ay',
      domicile: 'Yengeç',
      exaltation: 'Boğa',
      detriment: 'Oğlak',
      fall: 'Akrep',
      domicileDescription:
          'Ay Yengeç\'te evindedir. Duygusal zeka, bakım verme, sezgi doğal akar.',
      exaltationDescription:
          'Ay Boğa\'da yüceltilir. Duygusal istikrar, konfor, güvenlik hissi güçlü.',
      detrimentDescription:
          'Ay Oğlak\'ta zorlanır. Duygular bastırılır, sorumluluk ağır basar.',
      fallDescription:
          'Ay Akrep\'te düşüşte. Yoğun, obsesif duygular. Duygusal dönüşüm zorunlu.',
    ),
    'venus': DignityTable(
      planet: 'Venüs',
      domicile: 'Boğa, Terazi',
      exaltation: 'Balık',
      detriment: 'Akrep, Koç',
      fall: 'Başak',
      domicileDescription:
          'Venüs Boğa\'da duyusal zevkler, Terazi\'de ilişki uyumunda güçlü.',
      exaltationDescription:
          'Venüs Balık\'ta yüceltilir. Koşulsuz sevgi, romantizm, sanatsal ilham doruğunda.',
      detrimentDescription:
          'Venüs Koç\'ta aceleci aşk, Akrep\'te obsesif tutku ile zorlanır.',
      fallDescription:
          'Venüs Başak\'ta eleştirel, mükemmeliyetçi. Sevgiyi koşullara bağlar.',
    ),
  };
}

class DignityTable {
  final String planet;
  final String domicile;
  final String exaltation;
  final String detriment;
  final String fall;
  final String domicileDescription;
  final String exaltationDescription;
  final String detrimentDescription;
  final String fallDescription;

  const DignityTable({
    required this.planet,
    required this.domicile,
    required this.exaltation,
    required this.detriment,
    required this.fall,
    required this.domicileDescription,
    required this.exaltationDescription,
    required this.detrimentDescription,
    required this.fallDescription,
  });
}
