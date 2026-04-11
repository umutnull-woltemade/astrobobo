import '../models/reference_content.dart';
import '../models/zodiac_sign.dart';

/// Comprehensive celebrity birth charts collection
class CelebritiesContent {
  static List<CelebrityChart> getAllCelebrities() {
    return [
      // HISTORICAL FIGURES (1-10)
      CelebrityChart(
        name: 'Mustafa Kemal Atatürk',
        profession: 'Devlet Adamı, Kurtuluş Savaşı Lideri',
        birthDate: DateTime(1881, 5, 19),
        birthPlace: 'Selanik, Osmanlı İmparatorluğu',
        sunSign: ZodiacSign.taurus,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            '''Atatürk'ün Boğa Güneşi, kararlılık, sabır ve pratik liderliği gösterir. Değişmez hedeflere odaklanma yeteneği bu burçtan gelir. Aslan Ayı, güçlü irade, halkını koruma içgüdüsü ve doğal liderlik karizmasını vurgular. Akrep yükseleni ise stratejik zeka, dönüştürücü güç ve engellenemez kararlılığı işaret eder.

Haritasındaki Mars-Pluto kavuşumu, devrimci enerji ve köklü değişim yapabilme kapasitesini gösterir. Güneş'in 10. evde olması, kamusal alanda liderlik ve tarihsel miras bırakma potansiyelini belirtir. Jüpiter'in 9. evdeki konumu, vizyon, idealizm ve yabancı kültürlerle etkileşimi işaret eder.''',
        notableAspects: [
          'Güneş 10. evde - Kamusal liderlik, tarihsel miras',
          'Mars-Pluto kavuşumu - Dönüştürücü güç ve devrimci enerji',
          'Jüpiter 9. evde - Vizyon, idealizm, reform',
          'Aslan Ay - Halkın kalbi, karizmatik lider',
          'Akrep yükselen - Stratejik deha, kararlılık',
        ],
        category: CelebrityCategory.historical,
      ),

      CelebrityChart(
        name: 'Albert Einstein',
        profession: 'Teorik Fizikçi, Nobel Ödüllü Bilim İnsanı',
        birthDate: DateTime(1879, 3, 14),
        birthPlace: 'Ulm, Almanya',
        sunSign: ZodiacSign.pisces,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.cancer,
        imageUrl: '',
        chartAnalysis:
            '''Einstein'ın Balık Güneşi, sezgisel ve hayal gücü yüksek doğasını gösterir. Balık burcu, soyut düşünce ve evrensel gerçekleri kavrama yeteneği verir. Yay Ayı, felsefi düşünce, büyük resmi görme ve özgür düşünce yatkınlığını vurgular.

Yengeç yükseleni, güvenli bir çevrede çalışma ihtiyacını ve duygusal zekayı işaret eder. Uranüs'ün 3. evdeki güçlü konumu, devrimci fikirler ve norm dışı düşünce kapasitesini gösterir. Merkür-Güneş kavuşumu, parlak zihin ve karmaşık kavramları basitleştirme yeteneğini belirtir.''',
        notableAspects: [
          'Güneş-Merkür kavuşumu - Parlak, derin düşünen zihin',
          'Uranüs 3. evde - Devrimci fikirler, norm dışı düşünce',
          'Jüpiter-Satürn üçgeni - Sabırlı genişleme, kalıcı başarı',
          'Balık Güneş - Sezgisel, evrensel düşünce',
          'Neptün güçlü - Hayal gücü ve soyut kavrama',
        ],
        category: CelebrityCategory.scientists,
      ),

      CelebrityChart(
        name: 'Leonardo da Vinci',
        profession: 'Rönesans Sanatçısı, Mucit, Bilim İnsanı',
        birthDate: DateTime(1452, 4, 15),
        birthPlace: 'Vinci, Floransa Cumhuriyeti',
        sunSign: ZodiacSign.aries,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.sagittarius,
        imageUrl: '',
        chartAnalysis:
            '''Da Vinci'nin Koç Güneşi, öncü ve cesur doğasını, sürekli yeni alanlara girme tutkusunu gösterir. Balık Ayı, derin sanatsal sezgi ve sınırsız hayal gücünü temsil eder. Bu kombinasyon, eylem ile hayal gücünün mükemmel birleşimidir.

Yay yükseleni, çok yönlülük ve sürekli öğrenme tutkusunu işaret eder. Merkür-Venüs kavuşumu, estetik zeka ve el becerisi birleşimini gösterir. Mars'ın 5. evdeki konumu, yaratıcı enerji ve sanatsal ifadede cesaret verir.''',
        notableAspects: [
          'Merkür-Venüs kavuşumu - Estetik zeka, sanatsal yetenek',
          'Mars 5. evde - Yaratıcı enerji, üretkenlik',
          'Neptün güçlü - Spiritüel ilham, vizyon',
          'Koç Güneş - Öncü ruh, cesaret',
          'Yay yükselen - Çok yönlülük, merak',
        ],
        category: CelebrityCategory.artists,
      ),

      CelebrityChart(
        name: 'Marie Curie',
        profession: 'Fizikçi, Kimyager, İki Nobel Ödüllü Bilim İnsanı',
        birthDate: DateTime(1867, 11, 7),
        birthPlace: 'Varşova, Polonya',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Curie'nin Akrep Güneşi, araştırmacı ruhu ve derinlere inme tutkusunu gösterir. Görünmeyeni keşfetme arzusu bu burçtan kaynaklanır. Balık Ayı, sezgisel anlayış ve bilim için fedakarlık kapasitesini vurgular.

Başak yükseleni, bilimsel titizlik ve analitik yaklaşımı işaret eder. Pluto'nun güçlü konumu, radyoaktivite keşfi ile sembolik bağlantı kurar. Merkür'ün 8. evdeki konumu, gizli olanı araştırma ve dönüştürücü keşifler yapma yeteneğini gösterir.''',
        notableAspects: [
          'Güneş-Pluto açısı - Dönüştürücü keşifler, güç',
          'Merkür 8. evde - Gizli olanı araştırma',
          'Satürn 10. evde - Kalıcı miras, başarı',
          'Akrep Güneş - Araştırmacı ruh',
          'Başak yükselen - Bilimsel titizlik',
        ],
        category: CelebrityCategory.scientists,
      ),

      CelebrityChart(
        name: 'Fatih Sultan Mehmet',
        profession: 'Osmanlı Padişahı, Fatih',
        birthDate: DateTime(1432, 3, 30),
        birthPlace: 'Edirne, Osmanlı İmparatorluğu',
        sunSign: ZodiacSign.aries,
        moonSign: ZodiacSign.capricorn,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            '''Fatih'in Koç Güneşi, savaşçı ruhu, cesaret ve fetih tutkusunu gösterir. 21 yaşında İstanbul'u fethetmesi bu öncü enerjinin somut ifadesidir. Oğlak Ayı, stratejik düşünce, uzun vadeli planlama ve disiplinli yaklaşımı vurgular.

Akrep yükseleni, güçlü irade ve rakiplerini yıldıran kararlılığı işaret eder. Mars'ın güçlü konumu, askeri deha ve liderlik kapasitesini gösterir. Jüpiter'in yükselene açısı, büyük vizyonlar ve genişleme tutkusunu belirtir.''',
        notableAspects: [
          'Koç Güneş - Savaşçı ruh, fetih tutkusu',
          'Oğlak Ay - Stratejik planlama, disiplin',
          'Akrep yükselen - Güçlü irade, kararlılık',
          'Mars güçlü - Askeri deha',
          'Jüpiter açısı - Genişleme, imparatorluk vizyonu',
        ],
        category: CelebrityCategory.historical,
      ),

      CelebrityChart(
        name: 'Kleopatra',
        profession: 'Mısır Firavunu, Diplomat',
        birthDate: DateTime(-69, 1, 15), // BCE olarak
        birthPlace: 'İskenderiye, Antik Mısır',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.scorpio,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Kleopatra'nın Oğlak Güneşi, stratejik zeka, politik hırs ve güç arayışını gösterir. Tahtını korumak için gösterdiği kararlılık bu burçtan gelir. Akrep Ayı, derin duygusal zeka, etkileme yeteneği ve tutkulu doğayı vurgular.

Aslan yükseleni, kraliyet havası, karizmatik çekim ve dramatik varlığı işaret eder. Venüs'ün güçlü konumu, güzelliği silah olarak kullanma ve diplomasi yeteneğini gösterir. Pluto açıları, güç dinamikleri ve dönüştürücü liderliği belirtir.''',
        notableAspects: [
          'Oğlak Güneş - Stratejik zeka, politik hırs',
          'Akrep Ay - Etkileme gücü, tutku',
          'Aslan yükselen - Kraliyet karizması',
          'Venüs güçlü - Diplomasi, çekim gücü',
          'Pluto açıları - Güç ve dönüşüm',
        ],
        category: CelebrityCategory.historical,
      ),

      CelebrityChart(
        name: 'Napoleon Bonaparte',
        profession: 'Fransız İmparator, Askeri Deha',
        birthDate: DateTime(1769, 8, 15),
        birthPlace: 'Ajaccio, Korsika',
        sunSign: ZodiacSign.leo,
        moonSign: ZodiacSign.capricorn,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            '''Napoleon'un Aslan Güneşi, doğal liderlik, güçlü ego ve görkemli hedefler koymayı gösterir. Kendisini imparator ilan etmesi bu burç enerjisinin yansımasıdır. Oğlak Ayı, stratejik planlama, disiplin ve uzun vadeli düşünceyi vurgular.

Akrep yükseleni, yoğun irade, rakipleri yok etme kararlılığı ve dönüştürücü gücü işaret eder. Mars-Jupiter kavuşumu, askeri şansı ve genişleme tutkusunu gösterir. Satürn'ün 10. evdeki konumu, kalıcı miras ama sonunda düşüşü belirtir.''',
        notableAspects: [
          'Aslan Güneş - İmparatorluk vizyonu, ego',
          'Oğlak Ay - Stratejik deha',
          'Akrep yükselen - Yoğun irade',
          'Mars-Jüpiter kavuşumu - Askeri şans',
          'Satürn 10. evde - Yükseliş ve düşüş',
        ],
        category: CelebrityCategory.historical,
      ),

      CelebrityChart(
        name: 'Hz. Mevlana',
        profession: 'Sufi Şair, Mistik, Düşünür',
        birthDate: DateTime(1207, 9, 30),
        birthPlace: 'Belh, Horasan',
        sunSign: ZodiacSign.libra,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.sagittarius,
        imageUrl: '',
        chartAnalysis:
            '''Mevlana'nın Terazi Güneşi, denge arayışı, güzellik ve uyumu gösterir. Şiirlerindeki estetik mükemmellik bu burçtan kaynaklanır. Balık Ayı, derin spiritüellik, mistik deneyimler ve evrensel aşkı vurgular.

Yay yükseleni, felsefi arayış, öğretmenlik ve yüksek hakikat arayışını işaret eder. Neptün'ün güçlü konumu, mistik deneyimler ve ilahi aşkla bağlantıyı gösterir. Jüpiter'in yükselen yöneticisi olarak gücü, spiritüel genişleme ve öğretiyi belirtir.''',
        notableAspects: [
          'Terazi Güneş - Uyum, güzellik, denge',
          'Balık Ay - Mistik derinlik, evrensel aşk',
          'Yay yükselen - Spiritüel öğretmen',
          'Neptün güçlü - İlahi bağlantı',
          'Jüpiter güçlü - Bilgelik, genişleme',
        ],
        category: CelebrityCategory.historical,
      ),

      CelebrityChart(
        name: 'Nikola Tesla',
        profession: 'Mucit, Elektrik Mühendisi, Vizyoner',
        birthDate: DateTime(1856, 7, 10),
        birthPlace: 'Smiljan, Hırvatistan',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.libra,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Tesla'nın Yengeç Güneşi, güçlü hayal gücü ve sezgisel zekayı gösterir. Buluşlarını çoğunlukla zihninde "gördüğü" söylenir. Terazi Ayı, denge arayışı ve estetik düşünceyi vurgular. AC/DC tartışmasında denge arayışı bu enerjiden gelir.

Başak yükseleni, detaylara dikkat, teknik mükemmellik ve analitik yaklaşımı işaret eder. Uranüs'ün son derece güçlü konumu, elektrik ve yenilik ile derin bağlantıyı gösterir. Neptün açıları, vizyoner düşünce ve zamanının ötesinde görme yeteneğini belirtir.''',
        notableAspects: [
          'Uranüs çok güçlü - Elektrik, yenilik dehası',
          'Yengeç Güneş - Sezgisel görselleştirme',
          'Başak yükselen - Teknik mükemmellik',
          'Neptün açıları - Vizyoner düşünce',
          'Merkür güçlü - Zihinsel parlantı',
        ],
        category: CelebrityCategory.scientists,
      ),

      CelebrityChart(
        name: 'Frida Kahlo',
        profession: 'Ressam, Sanatçı, İkon',
        birthDate: DateTime(1907, 7, 6),
        birthPlace: 'Coyoacán, Meksika',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.taurus,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Frida'nın Yengeç Güneşi, derin duygusallık ve yaralarını sanata dönüştürme yeteneğini gösterir. Otoportreleri bu iç dünya yolculuğunun yansımasıdır. Boğa Ayı, güzelliğe bağlılık ve acı içinde bile zevk bulma kapasitesini vurgular.

Aslan yükseleni, dramatik kendini ifade ve göze çarpan bir tarzı işaret eder. Kiron'un güçlü konumu, "yaralı şifacı" arketipini ve acıyı sanata dönüştürmeyi gösterir. Mars-Uranüs açısı, kaza ve fiziksel travmayı ama aynı zamanda devrimci sanatı belirtir.''',
        notableAspects: [
          'Yengeç Güneş - Duygusal derinlik, öz ifade',
          'Kiron güçlü - Acıyı sanata dönüştürme',
          'Aslan yükselen - Dramatik ifade, stil',
          'Mars-Uranüs - Travma ve devrimci sanat',
          'Venüs 12. evde - Gizli güzellik, acı',
        ],
        category: CelebrityCategory.artists,
      ),

      // MUSICIANS (11-18)
      CelebrityChart(
        name: 'Barış Manço',
        profession: 'Rock Müzisyeni, Şarkıcı, TV Sunucusu',
        birthDate: DateTime(1943, 1, 2),
        birthPlace: 'İstanbul, Türkiye',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.gemini,
        ascendant: ZodiacSign.sagittarius,
        imageUrl: '',
        chartAnalysis:
            '''Barış Manço'nun Oğlak Güneşi, kararlılık, uzun vadeli kariyer planlaması ve gelenekle modernin birleşimini gösterir. Anadolu rock'ın öncüsü olması bu yapıcı enerjinin ürünüdür. İkizler Ayı, iletişim yeteneği ve merakı vurgular.

Yay yükseleni, kültürel keşif, dünya müziği ve TV programlarıyla uluslararası ulaşımı işaret eder. Neptün'ün müzik eviyle güçlü bağlantısı, müzikal ilham ve sanatsal vizyonu gösterir. Jüpiter'in yükselen yöneticisi olması, genişleme ve büyük kitlelerle bağlantıyı belirtir.''',
        notableAspects: [
          'Oğlak Güneş - Kalıcı miras, yapıcılık',
          'İkizler Ay - İletişim yeteneği, merak',
          'Yay yükselen - Kültür elçisi, keşifçi',
          'Neptün güçlü - Müzikal ilham',
          'Jüpiter yönetici - Geniş kitleler',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Freddie Mercury',
        profession: 'Queen Solisti, Şarkıcı, Söz Yazarı',
        birthDate: DateTime(1946, 9, 5),
        birthPlace: 'Zanzibar',
        sunSign: ZodiacSign.virgo,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Mercury'nin Başak Güneşi, mükemmeliyetçiliği ve müzikal detaycılığını gösterir. Şarkılarındaki karmaşık yapılar bu burçtan gelir. Yay Ayı, sahne performansındaki coşku ve özgürlük tutkusunu vurgular.

Aslan yükseleni, karizmatik sahne varlığı ve dramatik ifadeyi işaret eder. Venüs-Mars kavuşumu, tutkulu sanatsal ifade ve performans enerjisini gösterir. Neptün'ün 5. evdeki konumu, yaratıcı ilham ve müzikal dehayı belirtir.''',
        notableAspects: [
          'Aslan yükselen - Sahne karizması, star gücü',
          'Venüs-Mars kavuşumu - Tutkulu performans',
          'Neptün 5. evde - Müzikal ilham, yaratıcılık',
          'Başak Güneş - Mükemmeliyetçi sanatçı',
          'Yay Ay - Özgür ruh, coşku',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Tarkan',
        profession: 'Pop Star, Şarkıcı',
        birthDate: DateTime(1972, 10, 17),
        birthPlace: 'Alzey, Almanya',
        sunSign: ZodiacSign.libra,
        moonSign: ZodiacSign.cancer,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            '''Tarkan'ın Terazi Güneşi, estetik hassasiyet, uyum ve güzellik arayışını gösterir. Şarkılarındaki melodik yapı ve sahne estetiği bu burçtan kaynaklanır. Yengeç Ayı, halkıyla derin duygusal bağ ve nostaljik melodileri vurgular.

Akrep yükseleni, manyetik çekim, yoğun sahne varlığı ve gizem havasını işaret eder. Venüs'ün güçlü konumu, çekicilik ve sanatsal yeteneği gösterir. Pluto açıları, dönüştürücü müzik ve kitleler üzerindeki etkiyi belirtir.''',
        notableAspects: [
          'Terazi Güneş - Estetik, uyum, güzellik',
          'Akrep yükselen - Manyetik çekim, gizem',
          'Yengeç Ay - Duygusal bağ, nostalji',
          'Venüs güçlü - Çekicilik, sanat',
          'Pluto açıları - Kitlesel etki',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Sezen Aksu',
        profession: 'Şarkıcı, Söz Yazarı, Minik Serçe',
        birthDate: DateTime(1954, 7, 13),
        birthPlace: 'Sarayköy, Denizli',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.virgo,
        ascendant: ZodiacSign.libra,
        imageUrl: '',
        chartAnalysis:
            '''Sezen Aksu'nun Yengeç Güneşi, derin duygusallık ve halkın kalbine dokunma yeteneğini gösterir. Şarkıları nesilleri birleştiren duygusal köprüler kurar. Başak Ayı, söz yazarlığındaki incelik ve detaycılığı vurgular.

Terazi yükseleni, estetik hassasiyet ve uyum arayışını işaret eder. Neptün'ün güçlü konumu, müzikal ilham ve poetik ifadeyi gösterir. Ay'ın yaratıcılık eviyle bağlantısı, duygusal yaratıcılık ve sanatsal üretkenliği belirtir.''',
        notableAspects: [
          'Yengeç Güneş - Duygusal derinlik, halkın kalbi',
          'Başak Ay - İnce söz yazarlığı',
          'Terazi yükselen - Estetik, uyum',
          'Neptün güçlü - Müzikal ilham',
          'Yaratıcılık evi güçlü - Üretkenlik',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Michael Jackson',
        profession: "Pop'un Krali, Sarkici, Dansci",
        birthDate: DateTime(1958, 8, 29),
        birthPlace: 'Gary, Indiana, ABD',
        sunSign: ZodiacSign.virgo,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.pisces,
        imageUrl: '',
        chartAnalysis:
            '''Michael Jackson'ın Başak Güneşi, mükemmeliyetçiliği ve her detaya gösterdiği özeni gösterir. Dans hareketlerindeki hassasiyet bu burçtan gelir. Balık Ayı ve yükseleni, duygusal derinlik, artistik sezgi ve mistik havayı vurgular.

Neptün'ün yükselen yöneticisi olarak gücü, dünya çapında etkiyi ve neredeyse gerçeküstü popülariteyi işaret eder. Venüs-Uranüs açısı, benzersiz sanatsal ifade ve devrimci müziği gösterir. Pluto'nun güçlü konumu, transformasyonu ve karanlık temaları belirtir.''',
        notableAspects: [
          'Başak Güneş - Mükemmeliyetçi performans',
          'Balık Ay/Yükselen - Duygusal, mistik hava',
          'Neptün yönetici - Dünya çapında etki',
          'Venüs-Uranüs - Benzersiz sanatsal ifade',
          'Pluto güçlü - Dönüşüm, karanlık temalar',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Zeki Müren',
        profession: 'Sanat Güneşi, Şarkıcı, Besteci',
        birthDate: DateTime(1931, 12, 6),
        birthPlace: 'Bursa, Türkiye',
        sunSign: ZodiacSign.sagittarius,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Zeki Müren'in Yay Güneşi, geniş vizyonu, kültürel zenginliği kucaklamasını ve sınırları aşan sanatı gösterir. Aslan Ayı ve yükseleni, dramatik sahne varlığı, cömertlik ve görkemli tarzı vurgular.

Güneş-Jüpiter açısı, büyüklük, şöhret ve sanat güneşi ünvanını işaret eder. Venüs'ün güçlü konumu, ses güzelliği ve estetik mükemmelliği gösterir. Neptün'ün müzik eviyle bağlantısı, eşsiz vokal yeteneğini belirtir.''',
        notableAspects: [
          'Aslan Ay/Yükselen - Dramatik varlık, karizma',
          'Yay Güneş - Sınırları aşan sanat',
          'Güneş-Jüpiter - Sanat Güneşi ünvanı',
          'Venüs güçlü - Ses güzelliği',
          'Neptün müzik bağlantısı - Vokal dehası',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'David Bowie',
        profession: 'Rock Yıldızı, Sanatçı, Aktör',
        birthDate: DateTime(1947, 1, 8),
        birthPlace: 'Londra, İngiltere',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.aquarius,
        imageUrl: '',
        chartAnalysis:
            '''Bowie'nin Oğlak Güneşi, kariyer stratejisi ve uzun ömürlü mirası gösterir. Sürekli yeniden icat etmesi planlı değişimin ürünüdür. Aslan Ayı, dramatik sahne personaları (Ziggy Stardust) ve yaratıcı cesareti vurgular.

Kova yükseleni, radikal özgünlük ve zamanının ötesinde olmayı işaret eder. Mars-Venüs kavuşumu, androjen estetik ve sanatsal ifadede sınır tanımazlığı gösterir. Uranüs'ün güçlü konumu, devrimci müzik ve sürekli evrimleşmeyi belirtir.''',
        notableAspects: [
          'Kova yükselen - Radikal özgünlük, geleceğe yönelik',
          'Aslan Ay - Dramatik personalar',
          'Mars-Venüs kavuşumu - Androjen estetik',
          'Uranüs güçlü - Devrimci sanat',
          'Oğlak Güneş - Stratejik kariyer',
        ],
        category: CelebrityCategory.musicians,
      ),

      CelebrityChart(
        name: 'Ajda Pekkan',
        profession: 'Süperstar, Pop Şarkıcısı',
        birthDate: DateTime(1946, 2, 12),
        birthPlace: 'İstanbul, Türkiye',
        sunSign: ZodiacSign.aquarius,
        moonSign: ZodiacSign.virgo,
        ascendant: ZodiacSign.taurus,
        imageUrl: '',
        chartAnalysis:
            '''Ajda Pekkan'ın Kova Güneşi, zamanının ötesinde olmayı ve trendleri belirlemeyi gösterir. "Süperstar" ünvanı bu benzersiz konumun yansımasıdır. Başak Ayı, detaycılık ve uzun kariyerde tutarlılığı vurgular.

Boğa yükseleni, güzellik, lüks ve kalıcılığı işaret eder. Venüs'ün ev sahibi olarak gücü, estetik mükemmelliği ve çekiciliği gösterir. Satürn'ün güçlü konumu, disiplin ve onlarca yıl süren kariyeri belirtir.''',
        notableAspects: [
          'Kova Güneş - Trend belirleyici, benzersiz',
          'Boğa yükselen - Güzellik, kalıcılık',
          'Venüs güçlü - Estetik mükemmellik',
          'Başak Ay - Detaycılık, tutarlılık',
          'Satürn güçlü - Uzun kariyer, disiplin',
        ],
        category: CelebrityCategory.musicians,
      ),

      // ACTORS (19-26)
      CelebrityChart(
        name: 'Kemal Sunal',
        profession: 'Sinema Oyuncusu, Yeşilçam Efsanesi',
        birthDate: DateTime(1944, 11, 11),
        birthPlace: 'İstanbul, Türkiye',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.cancer,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Kemal Sunal'ın Akrep Güneşi, derinlik, gözlem gücü ve karakterlerin içine girme yeteneğini gösterir. Komedilerinin altındaki toplumsal eleştiri bu derin bakıştan kaynaklanır. Yengeç Ayı, halkla duygusal bağ ve sıradan insanı temsil etmeyi vurgular.

Başak yükseleni, mütevazı görünüm ve "küçük adam" karakterlerini işaret eder. Jüpiter'in komedi eviyle bağlantısı, doğal mizah yeteneğini gösterir. Satürn'ün güçlü konumu, toplumsal eleştiri ve kalıcı mirası belirtir.''',
        notableAspects: [
          'Akrep Güneş - Derin gözlem, toplumsal eleştiri',
          'Yengeç Ay - Halkla bağ, sıradan insan',
          'Başak yükselen - Mütevazı, küçük adam',
          'Jüpiter komedi bağlantısı - Doğal mizah',
          'Satürn güçlü - Kalıcı miras',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Türkan Şoray',
        profession: 'Sinema Oyuncusu, Yeşilçam Sultanı',
        birthDate: DateTime(1945, 6, 28),
        birthPlace: 'İstanbul, Türkiye',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.libra,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            '''Türkan Şoray'ın Yengeç Güneşi, duygusal derinlik ve izleyicinin kalbini fethetme yeteneğini gösterir. Melodramlardaki güçlü performanslar bu duygusal zekadan kaynaklanır. Terazi Ayı, güzellik ve estetik dengeyi vurgular.

Akrep yükseleni, manyetik çekim ve yoğun ekran varlığını işaret eder. Venüs'ün güçlü konumu, zamansız güzelliği gösterir. Neptün'ün film eviyle bağlantısı, sinematik büyüyü ve "Sultan" ünvanını belirtir.''',
        notableAspects: [
          'Yengeç Güneş - Duygusal derinlik',
          'Akrep yükselen - Manyetik çekim',
          'Terazi Ay - Güzellik, estetik',
          'Venüs güçlü - Zamansız güzellik',
          'Neptün film bağlantısı - Sinema büyüsü',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Meryl Streep',
        profession: 'Oscar Ödüllü Aktris',
        birthDate: DateTime(1949, 6, 22),
        birthPlace: 'Summit, New Jersey, ABD',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.taurus,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Meryl Streep'in Yengeç Güneşi, duygusal derinlik ve karakterlere tam empati kurma yeteneğini gösterir. Her rolde farklı bir insana dönüşmesi bu duygusal esneklikten gelir. Boğa Ayı, istikrar ve uzun kariyeri vurgular.

Aslan yükseleni, güçlü sahne varlığı ve star kalitesini işaret eder. Neptün'ün güçlü konumu, bukalemun gibi dönüşüm yeteneğini gösterir. Merkür'ün aksan ustası olmasını sağlayan konumu belirgindir.''',
        notableAspects: [
          'Yengeç Güneş - Empatik oyunculuk',
          'Aslan yükselen - Star kalitesi',
          'Neptün güçlü - Dönüşüm ustası',
          'Boğa Ay - Kariyer istikrarı',
          'Merkür güçlü - Aksan ustalığı',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Leonardo DiCaprio',
        profession: 'Oscar Ödüllü Aktör, Çevreci',
        birthDate: DateTime(1974, 11, 11),
        birthPlace: 'Los Angeles, ABD',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.libra,
        ascendant: ZodiacSign.libra,
        imageUrl: '',
        chartAnalysis:
            '''DiCaprio'nun Akrep Güneşi, yoğun karakterlere bürünme ve derin dönüşüm rollerini gösterir. "The Revenant" ve "Wolf of Wall Street" bu yoğunluğun yansımasıdır. Terazi Ay ve yükseleni, estetik duyarlılık ve çekiciliği vurgular.

Venüs'ün yükselen yöneticisi olarak gücü, star imajını işaret eder. Pluto'nun güçlü konumu, karanlık ve karmaşık karakterlere çekimi gösterir. Neptün'ün çevre aktivizmine yönelten spiritüel bağlantıyı belirtir.''',
        notableAspects: [
          'Akrep Güneş - Yoğun karakterler, dönüşüm',
          'Terazi Ay/Yükselen - Estetik, çekicilik',
          'Venüs yönetici - Star imajı',
          'Pluto güçlü - Karanlık roller',
          'Neptün - Çevre aktivizmi',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Kıvanç Tatlıtuğ',
        profession: 'Oyuncu, Model, Dizi Yıldızı',
        birthDate: DateTime(1983, 10, 27),
        birthPlace: 'Adana, Türkiye',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Kıvanç Tatlıtuğ'un Akrep Güneşi, yoğun ekran varlığı ve karmaşık karakterleri canlandırma yeteneğini gösterir. Koç Ayı, cesaret ve aksiyona yatkınlığı vurgular.

Aslan yükseleni, karizmatik görünüm ve star kalitesini işaret eder. Mars'ın güçlü konumu, fiziksel çekicilik ve enerjik performansları gösterir. Venüs'ün romantik rolleri ve uluslararası çekiciliği belirtir.''',
        notableAspects: [
          'Akrep Güneş - Yoğun ekran varlığı',
          'Aslan yükselen - Star karizması',
          'Koç Ay - Cesaret, dinamizm',
          'Mars güçlü - Fiziksel çekicilik',
          'Venüs - Romantik roller',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Angelina Jolie',
        profession: 'Oscar Ödüllü Aktris, Yönetmen, İnsancıl Aktivist',
        birthDate: DateTime(1975, 6, 4),
        birthPlace: 'Los Angeles, ABD',
        sunSign: ZodiacSign.gemini,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.cancer,
        imageUrl: '',
        chartAnalysis:
            '''Angelina Jolie'nin İkizler Güneşi, çok yönlülük ve değişkenliği gösterir. Oyunculuktan yönetmenliğe, aktivizme geçişleri bu enerjidir. Koç Ayı, cesaret ve bağımsızlığı vurgular.

Yengeç yükseleni, annelik ve insancıl aktivizmi işaret eder. Mars'ın çok güçlü konumu (Koç), aksiyon rolleri ve cesur kararları gösterir. Jüpiter'in genişleme açıları, BM aktivizmini belirtir.''',
        notableAspects: [
          'İkizler Güneş - Çok yönlülük',
          'Koç Ay - Cesaret, bağımsızlık',
          'Yengeç yükselen - Annelik, aktivizm',
          'Mars çok güçlü - Aksiyon rolleri',
          'Jüpiter genişleme - BM aktivizmi',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Beren Saat',
        profession: 'Oyuncu, Dizi Yıldızı',
        birthDate: DateTime(1984, 2, 26),
        birthPlace: 'Ankara, Türkiye',
        sunSign: ZodiacSign.pisces,
        moonSign: ZodiacSign.gemini,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Beren Saat'in Balık Güneşi, duygusal derinlik ve karakterlere empati kurma yeteneğini gösterir. Dramatik rollerdeki başarısı bu sezgisellikten kaynaklanır. İkizler Ayı, uyum sağlama ve farklı karakterlere geçişi vurgular.

Başak yükseleni, detaylara dikkat ve mükemmeliyetçiliği işaret eder. Neptün'ün güçlü konumu, ekran büyüsü ve uluslararası çekiciliği gösterir. Venüs'ün romantik rollere yatkınlığı belirtir.''',
        notableAspects: [
          'Balık Güneş - Duygusal derinlik, empati',
          'Başak yükselen - Detaycılık',
          'İkizler Ay - Karakter çeşitliliği',
          'Neptün güçlü - Ekran büyüsü',
          'Venüs - Romantik roller',
        ],
        category: CelebrityCategory.actors,
      ),

      CelebrityChart(
        name: 'Johnny Depp',
        profession: 'Karakter Oyuncusu, Hollywood Yıldızı',
        birthDate: DateTime(1963, 6, 9),
        birthPlace: 'Owensboro, Kentucky, ABD',
        sunSign: ZodiacSign.gemini,
        moonSign: ZodiacSign.capricorn,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Johnny Depp'in İkizler Güneşi, çok yönlülük ve sınırsız karakter yelpazesini gösterir. Jack Sparrow'dan Edward Scissorhands'e kadar geçişler bu enerjidir. Oğlak Ayı, gizli ciddiyet ve iş disiplinini vurgular.

Aslan yükseleni, göz alıcı görünüm ve star kalitesini işaret eder. Uranüs'ün güçlü konumu, eksantrik karakterlere çekimi gösterir. Neptün açıları, fantazi dünyalara dalma yeteneğini belirtir.''',
        notableAspects: [
          'İkizler Güneş - Karakter çeşitliliği',
          'Aslan yükselen - Star görünümü',
          'Uranüs güçlü - Eksantrik karakterler',
          'Oğlak Ay - Gizli ciddiyet',
          'Neptün - Fantazi dünyalar',
        ],
        category: CelebrityCategory.actors,
      ),

      // ATHLETES (27-30)
      CelebrityChart(
        name: 'Arda Güler',
        profession: 'Futbolcu, Real Madrid Yıldızı',
        birthDate: DateTime(2005, 2, 25),
        birthPlace: 'İstanbul, Türkiye',
        sunSign: ZodiacSign.pisces,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.gemini,
        imageUrl: '',
        chartAnalysis:
            '''Arda Güler'in Balık Güneşi, yaratıcı futbol vizyonu ve sezgisel oyun okumayı gösterir. Sahada "görmediği" pasları vermesi bu enerjinin yansımasıdır. Koç Ayı, rekabetçi ruhu ve gol atma içgüdüsünü vurgular.

İkizler yükseleni, hız, çeviklik ve adapte olma yeteneğini işaret eder. Mars'ın güçlü konumu, atletik yeteneği gösterir. Jüpiter'in şans açıları, erken yaşta büyük başarıları belirtir.''',
        notableAspects: [
          'Balık Güneş - Yaratıcı vizyon',
          'Koç Ay - Rekabetçi ruh, gol içgüdüsü',
          'İkizler yükselen - Hız, çeviklik',
          'Mars güçlü - Atletizm',
          'Jüpiter şans - Erken başarı',
        ],
        category: CelebrityCategory.athletes,
      ),

      CelebrityChart(
        name: 'Cristiano Ronaldo',
        profession: 'Futbolcu, Dünya Yıldızı',
        birthDate: DateTime(1985, 2, 5),
        birthPlace: 'Funchal, Madeira, Portekiz',
        sunSign: ZodiacSign.aquarius,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Cristiano Ronaldo'nun Kova Güneşi, benzersiz olmak ve rekorlar kırmak tutkusunu gösterir. Aslan Ayı, star olma ihtiyacı ve karizmatik varlığı vurgular.

Başak yükseleni, fiziksel mükemmeliyetçilik ve sağlıklı yaşam takıntısını işaret eder. Mars-Satürn açısı, disiplin ve sınırsız çalışma ahlakını gösterir. Jüpiter'in güçlü konumu, uluslararası başarıyı belirtir.''',
        notableAspects: [
          'Kova Güneş - Rekor kırma tutkusu',
          'Aslan Ay - Star olma ihtiyacı',
          'Başak yükselen - Fiziksel mükemmeliyetçilik',
          'Mars-Satürn - Disiplin, çalışma ahlakı',
          'Jüpiter güçlü - Uluslararası başarı',
        ],
        category: CelebrityCategory.athletes,
      ),

      CelebrityChart(
        name: 'Lionel Messi',
        profession: 'Futbolcu, Dünya Şampiyonu',
        birthDate: DateTime(1987, 6, 24),
        birthPlace: 'Rosario, Arjantin',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.gemini,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            '''Lionel Messi'nin Yengeç Güneşi, takıma ve ülkesine bağlılığı gösterir. Dünya Kupası'nı kazanma tutkusu bu duygusal bağın yansımasıdır. İkizler Ayı, hız, çeviklik ve değişken oyun tarzını vurgular.

Başak yükseleni, mütevazı kişilik ve teknik mükemmelliği işaret eder. Neptün'ün güçlü konumu, neredeyse doğaüstü dribling yeteneğini gösterir. Satürn'ün fiziksel engellere rağmen azmi belirtir.''',
        notableAspects: [
          'Yengeç Güneş - Takıma ve ülkeye bağlılık',
          'İkizler Ay - Hız, çeviklik',
          'Başak yükselen - Mütevazılık, teknik',
          'Neptün güçlü - Büyülü ayak işleri',
          'Satürn - Engellere rağmen azim',
        ],
        category: CelebrityCategory.athletes,
      ),

      CelebrityChart(
        name: 'Serena Williams',
        profession: 'Tenisçi, Grand Slam Şampiyonu',
        birthDate: DateTime(1981, 9, 26),
        birthPlace: 'Saginaw, Michigan, ABD',
        sunSign: ZodiacSign.libra,
        moonSign: ZodiacSign.virgo,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            '''Serena Williams'ın Terazi Güneşi, denge ve estetik arayışını gösterir. Tenis kortundaki zarafet bu enerjidir. Başak Ayı, mükemmeliyetçilik ve teknik detaycılığı vurgular.

Aslan yükseleni, güçlü fiziksel varlık ve dominant sahne enerjisini işaret eder. Mars'ın çok güçlü konumu, atletik güç ve rekabetçi ateşi gösterir. Pluto açıları, dominans ve dönüştürücü gücü belirtir.''',
        notableAspects: [
          'Terazi Güneş - Zarafet, denge',
          'Aslan yükselen - Dominant varlık',
          'Mars çok güçlü - Atletik güç',
          'Başak Ay - Teknik mükemmellik',
          'Pluto - Dominans, dönüşüm',
        ],
        category: CelebrityCategory.athletes,
      ),
    ];
  }
}
