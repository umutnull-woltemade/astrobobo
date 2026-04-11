/// Synastry Mega Content - İlişki Uyumu Derinlemesine Analizi
/// Gezegen açıları, ev örtüşmeleri, kompozit harita yorumları
library;

// ════════════════════════════════════════════════════════════════════════════
// SİNASTRİ TEMELLERİ
// ════════════════════════════════════════════════════════════════════════════

class SynastryFundamentals {
  static const String introduction = '''
Sinastri, iki kişinin doğum haritalarını üst üste bindirerek aralarındaki
kozmik bağlantıları analiz eden astroloji dalıdır. Bu teknik, romantik
ilişkilerden iş ortaklıklarına, aile bağlarından dostluklara kadar her
türlü insan ilişkisini derinlemesine anlamaya yardımcı olur.

İki harita arasındaki açılar (aspektler), bir ilişkinin doğasını ortaya koyar:
- Uyumlu açılar (trigon, sekstil) kolay akan enerjiyi gösterir
- Zorlu açılar (kare, karşıt) büyüme potansiyeli taşıyan gerilimleri işaret eder
- Kavuşumlar (konjunksiyon) güçlü birleşim noktalarını belirler

Unutulmamalıdır ki "zor" açılar kötü değildir - en tutkulu, dönüştürücü
ilişkiler genellikle zorlu açılar içerir. Önemli olan bilinçli farkındalıktır.
''';

  static const Map<String, AspectTypeInfo> aspectTypes = {
    'conjunction': AspectTypeInfo(
      name: 'Kavuşum',
      symbol: '☌',
      degrees: 0,
      orb: 8,
      nature: 'Birleştirici',
      description: '''
Kavuşum, iki gezegenin aynı burç derecesinde buluşmasıdır. Bu, enerjilerin
tam olarak birleştiği, ayrıştırılamaz hale geldiği güçlü bir bağlantıdır.

İlişkilerde kavuşumlar:
- Güçlü çekim ve tanışıklık hissi yaratır
- "Bu kişiyi tanıyormuşum gibi" duygusu verir
- Enerjiler iç içe geçer, birbirini yoğunlaştırır
- Hem uyumlu hem zorlu olabilir (gezegenlere bağlı)

Örneğin: Güneş-Ay kavuşumu derin duygusal bağ ve karşılıklı anlayış gösterir.
Mars-Mars kavuşumu ya güçlü cinsel çekim ya da sürtüşme yaratır.
''',
    ),
    'opposition': AspectTypeInfo(
      name: 'Karşıt',
      symbol: '☍',
      degrees: 180,
      orb: 8,
      nature: 'Kutupsal',
      description: '''
Karşıtlık, iki gezegenin tam karşı burçlarda konumlanmasıdır. Bu açı
çekim ve itme arasında salınım yaratır - "karşıtlar birbirini çeker"
ilkesinin astrolojik karşılığıdır.

İlişkilerde karşıtlıklar:
- Güçlü manyetik çekim oluşturur
- Projeksiyon riski taşır (kendi özelliklerimizi başkasında görmek)
- Denge ve tamamlama potansiyeli sunar
- Güç mücadeleleri ve çatışmalar yaratabilir
- Bilinçli çalışmayla büyüme ve bütünleşme sağlar

Venüs-Mars karşıtlığı klasik romantik gerilimdir - aşk ve arzu dansı.
''',
    ),
    'trine': AspectTypeInfo(
      name: 'Trigon',
      symbol: '△',
      degrees: 120,
      orb: 8,
      nature: 'Uyumlu',
      description: '''
Trigon, aynı elementteki (ateş, toprak, hava, su) burçlar arasındaki
120 derecelik açıdır. En uyumlu aspekt olarak kabul edilir.

İlişkilerde trigonlar:
- Doğal uyum ve anlayış sağlar
- Kolay iletişim ve kabul yaratır
- Benzer değerler ve yaklaşımları gösterir
- Bazen fazla rahatlık "tembellik" getirebilir
- Birbirini destekleyen, besleyen enerji akışı

Ay-Venüs trigonu duygusal uyum ve sevgi dillerinin örtüşmesini gösterir.
''',
    ),
    'square': AspectTypeInfo(
      name: 'Kare',
      symbol: '□',
      degrees: 90,
      orb: 8,
      nature: 'Zorlayıcı',
      description: '''
Kare açı, farklı modalitelerdeki (kardinal-sabit veya sabit-değişken)
burçlar arasındaki 90 derecelik gerilimdir.

İlişkilerde kareler:
- Sürtüşme ve meydan okuma yaratır
- Büyüme için motivasyon sağlar
- Tutku ve dinamizm getirir
- Çatışma ve güç savaşları riski taşır
- Bilinçli çalışmayla çok güçlü bağlar oluşturur

Mars-Satürn karesi: Aksiyon vs. sabır gerginliği, ama birlikte büyük
başarılar mümkün.
''',
    ),
    'sextile': AspectTypeInfo(
      name: 'Sekstil',
      symbol: '⚹',
      degrees: 60,
      orb: 6,
      nature: 'Destekleyici',
      description: '''
Sekstil, uyumlu elementler (ateş-hava veya toprak-su) arasındaki
60 derecelik açıdır. Fırsatlar ve kolaylıklar sunar.

İlişkilerde sekstiller:
- Arkadaşça enerji ve karşılıklı destek verir
- İletişim kanallarını açar
- Birlikte öğrenme ve gelişme fırsatları sunar
- Trigon kadar güçlü değil ama tutarlı destek sağlar
- Çaba gösterilirse potansiyel aktive edilir

Merkür-Jüpiter sekstili: Fikir alışverişi, birlikte öğrenme keyfi.
''',
    ),
    'quincunx': AspectTypeInfo(
      name: 'Quincunx/Inconjunct',
      symbol: '⚻',
      degrees: 150,
      orb: 3,
      nature: 'Ayarlama Gerektiren',
      description: '''
Quincunx, hiçbir ortak noktası olmayan (element, modalite) burçlar
arasındaki 150 derecelik açıdır. Sürekli ayarlama gerektirir.

İlişkilerde quincunxlar:
- "Farklı dilleri konuşuyoruz" hissi yaratır
- Sürekli adaptasyon ve esneklik gerektirir
- Anlaşılmama ve kafa karışıklığı riski
- Bilinçli çabayla benzersiz tamamlanma mümkün
- Sağlık ve rutinlerde uyumsuzluk

Güneş-Ay quincunxu: Ego ve duygular arasında sürekli denge arayışı.
''',
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// GEZEGEN SİNASTRİ ANALİZİ
// ════════════════════════════════════════════════════════════════════════════

class PlanetarySynastry {
  // GÜNEŞ SİNASTRİSİ
  static const Map<String, SynastryAspectInterpretation> sunAspects = {
    'sun_sun_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Güneş',
      aspect: 'Kavuşum',
      theme: 'Kimlik Birleşimi',
      attraction: 5,
      harmony: 4,
      growth: 3,
      challenge: 2,
      interpretation: '''
İki Güneş kavuşumu, benzer temel kimlik ve yaşam amacı paylaşımını gösterir.
Bu çift "ayna" gibi çalışır - birbirlerinde kendilerini görürler.

Olumlu yönleri:
• Karşılıklı anlayış ve tanınmışlık hissi
• Benzer hedefler ve yaşam vizyonu
• Birbirinin ışığını güçlendirme
• Doğal saygı ve kabul

Dikkat edilecek noktalar:
• Ego çatışmaları riski (kim daha parlak?)
• Aynılık sıkıcılığa dönüşebilir
• Kör noktalar paylaşılabilir
• Bireysellik alanı bırakmak önemli

Bu kombinasyon güçlü bir temel sağlar ama her iki tarafın da
kendi ışığını söndürmeden birlikte parlaması gerekir.
''',
      advice:
          'Işığınızı paylaşın ama gölgede kalmayı da kabul edin. Birbirinizi yükseltmek için yarışmak yerine işbirliği yapın.',
    ),

    'sun_moon_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Ay',
      aspect: 'Kavuşum',
      theme: 'Ruh Eşi Bağlantısı',
      attraction: 5,
      harmony: 5,
      growth: 4,
      challenge: 2,
      interpretation: '''
Güneş-Ay kavuşumu, sinastrinin en önemli göstergelerinden biridir ve
genellikle "ruh eşi" bağlantısı olarak yorumlanır. Bir kişinin bilinçli
kimliği (Güneş) diğerinin duygusal iç dünyasıyla (Ay) mükemmel uyum içindedir.

Bu bağlantının derinliği:
• Güneş kişisi Ay kişisini "aydınlatır" ve güvende hissettirir
• Ay kişisi Güneş kişisine duygusal yuva ve destek sunar
• Doğal roller: Güneş koruyucu, Ay besleyici
• Evlilik ve uzun süreli ilişkiler için mükemmel temel

Dikkat edilmesi gerekenler:
• Roller katılaşabilir (bağımlılık riski)
• Ay kişisi Güneş'e fazla bağımlı olabilir
• Güneş kişisi duygusal yükü ihmal edebilir
• Denge için her iki tarafın da rollerini bazen değiştirmesi önemli

Bu kombinasyon, iki kişinin bir bütün oluşturduğu nadir bağlantılardandır.
''',
      advice:
          'Bu bağlantının değerini bilin ama birbirinize bağımlılık yerine karşılıklı bağlılık geliştirin.',
    ),

    'sun_venus_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Venüs',
      aspect: 'Kavuşum',
      theme: 'Aşk ve Hayranlık',
      attraction: 5,
      harmony: 5,
      growth: 3,
      challenge: 1,
      interpretation: '''
Güneş-Venüs kavuşumu güçlü romantik çekim ve karşılıklı hayranlık gösterir.
Venüs kişisi Güneş kişisini çekici bulur, Güneş kişisi Venüs'ün sevgisinden
beslenir.

Bu kombinasyonun güzellikleri:
• Doğal çekim ve "göz göze gelme" anları
• Birlikte estetik zevkler paylaşma
• Karşılıklı övgü ve takdir
• Romantik ifade kolaylığı
• Sosyal uyum ve birlikte görünme keyfi

Potansiyel zorluklar:
• Yüzeysel kalabilir (sadece çekime dayalı)
• Venüs kişisi Güneş'in gölgesinde kalabilir
• "Pembe gözlük" gerçekliği bulanıklaştırabilir
• Pratik konularda uyumsuzluk gizlenebilir

Estetik ve romantik boyut güçlü - pratik uyumu kontrol edin.
''',
      advice: 'Hayranlığın ötesine geçin, birbirinizi gerçek haliyle tanıyın.',
    ),

    'sun_mars_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Mars',
      aspect: 'Kavuşum',
      theme: 'Ateşli Enerji',
      attraction: 5,
      harmony: 3,
      growth: 4,
      challenge: 4,
      interpretation: '''
Güneş-Mars kavuşumu yoğun, ateşli ve enerjik bir bağlantıdır. Bu kombinasyon
güçlü cinsel çekim, rekabet ve birlikte aksiyon alma potansiyeli taşır.

Güçlü yönler:
• Yoğun fiziksel çekim ve cinsel kimya
• Birbirini harekete geçirme, motive etme
• Birlikte projeler başlatma enerjisi
• Koruyuculuk ve savunma içgüdüsü
• Atletik ve macera paylaşımı

Zorluklar:
• Ego savaşları ve güç mücadeleleri
• Öfke patlamaları ve tartışmalar
• Rekabet dostluğu gölgeleyebilir
• Sabırsızlık ve aceleci davranışlar
• Fiziksel enerjinin yıkıcı hale gelmesi

Bu kombinasyon "birlikte dağ taşıyabilir" ama öfke yönetimi kritik.
''',
      advice:
          'Enerjinizi birlikte yapıcı hedeflere yönlendirin. Fiziksel aktiviteler ve ortak projeler çatışmayı önler.',
    ),

    'sun_jupiter_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Jüpiter',
      aspect: 'Kavuşum',
      theme: 'Bolluk ve Genişleme',
      attraction: 4,
      harmony: 5,
      growth: 5,
      challenge: 1,
      interpretation: '''
Güneş-Jüpiter kavuşumu en şanslı ve bereketli sinastri kombinasyonlarından
biridir. Bu ikili birlikte olduğunda her şey daha büyük, daha iyi, daha
iyimser görünür.

Bu bağlantının hediyeleri:
• Jüpiter kişisi Güneş'in özgüvenini artırır
• Birlikte büyüme ve genişleme
• Cömertlik ve karşılıklı destek
• Macera ve keşif paylaşımı
• Felsefi ve spiritüel bağlantı
• İş ortaklıklarında başarı potansiyeli

Dikkat edilecekler:
• Aşırı iyimserlik gerçekçiliği zedeleyebilir
• "Çok fazla iyi şey" sorunları (aşırılık)
• Birbirini şımartma, sorumsuzluk
• Detaylara dikkat eksikliği

Şans ve bolluk enerjisi güçlü - ayakları yere sağlam basın.
''',
      advice: 'Birlikte hayallerin peşinden gidin ama pratik planlar yapın.',
    ),

    'sun_saturn_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Satürn',
      aspect: 'Kavuşum',
      theme: 'Karma Bağ',
      attraction: 2,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Güneş-Satürn kavuşumu karmaşık bir bağlantıdır. Genellikle "karmik" olarak
yorumlanır - bu iki kişinin birlikte tamamlaması gereken bir ders vardır.

Bu kombinasyonun dinamiği:
• Satürn kişisi Güneş'e "öğretmen" veya "otorite" olarak görünür
• Güneş kişisi Satürn'ün onayını kazanmaya çalışabilir
• Ciddiyet, sorumluluk ve yapı vurgusu
• Uzun vadeli taahhüt ve sadakat potansiyeli
• Olgunlaştırıcı ve disipline edici etki

Zorluklar:
• Satürn Güneş'in parlamasını engelleyebilir
• Eleştiri ve kısıtlama hissi
• Soğukluk ve mesafe
• Performans baskısı
• Yaş/otorite dinamikleri

Bu ilişki kolay değil ama bilinçli çalışmayla derin olgunluk getirir.
''',
      advice:
          'Satürn\'ün derslerini kabul edin ama kimliğinizi koruyun. Yapıcı eleştiri ile yıkıcı eleştiriyi ayırt edin.',
    ),

    'sun_uranus_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Uranüs',
      aspect: 'Kavuşum',
      theme: 'Elektrik ve Özgürlük',
      attraction: 4,
      harmony: 3,
      growth: 4,
      challenge: 4,
      interpretation: '''
Güneş-Uranüs kavuşumu elektriklenmiş, heyecan verici ve öngörülemeyen bir
bağlantıdır. Bu ikili birbirini uyandırır, şok eder ve dönüştürür.

Heyecan veren yönler:
• "Yıldırım çarpması" gibi ani çekim
• Birbirini uyandırma ve özgürleştirme
• Geleneklere meydan okuma
• Entellektüel stimülasyon
• Benzersiz ve alışılmadık ilişki
• Birlikte yenilik ve devrim

Zorluklar:
• İstikrarsızlık ve öngörülemezlik
• Ani kopmalar ve geri dönüşler
• Taahhüt korkusu
• Mesafe ihtiyacı çatışması
• Sıradanlığa tahammülsüzlük

Bu ilişki sıkıcı olmayacak - soru ne kadar süreceği.
''',
      advice:
          'Özgürlük alanı tanıyın ama temel istikrarı koruyun. Sürprizlere açık olun.',
    ),

    'sun_neptune_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Neptün',
      aspect: 'Kavuşum',
      theme: 'Rüya ve İlüzyon',
      attraction: 4,
      harmony: 3,
      growth: 3,
      challenge: 4,
      interpretation: '''
Güneş-Neptün kavuşumu büyülü, romantik ve spiritüel bir bağlantıdır.
Bu ikili birbirini idealize eder, bir rüya içinde gibi hisseder.

Büyülü yönler:
• Ruhani ve mistik bağlantı
• Birbirini "kurtarma" ve "ilham verme"
• Sanatsal ve yaratıcı işbirliği
• Koşulsuz sevgi potansiyeli
• Telepati benzeri sezgisel bağ
• Romantik idealin gerçekleşmesi

Dikkat edilmesi gerekenler:
• İlüzyon ve hayal kırıklığı riski
• Birbirini idealize etme, gerçeği görmeme
• Kaçış ve bağımlılık eğilimleri
• Sınırların belirsizleşmesi
• Kim kim? karmaşası

Büyülü ama ayakları yere basmalı - rüya gerçekliği karşıladığında ne olur?
''',
      advice:
          'Büyüyü koruyun ama gerçekçi kalın. Birbirinizi olduğu gibi görmeye çalışın.',
    ),

    'sun_pluto_conjunction': SynastryAspectInterpretation(
      planet1: 'Güneş',
      planet2: 'Plüton',
      aspect: 'Kavuşum',
      theme: 'Güç ve Dönüşüm',
      attraction: 5,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Güneş-Plüton kavuşumu sinastrinin en yoğun ve dönüştürücü bağlantılarından
biridir. Bu kombinasyon obsesif, kompulsif ve derinden değiştirici.

Bu bağın gücü:
• Hipnotik, karşı konulamaz çekim
• Derin psikolojik bağ
• Birbirini "çıplak" görme
• Kişisel dönüşüm katalizörü
• Tutku ve yoğunluk
• "Asla aynı kalmayacaksın" ilişkisi

Karanlık yönler:
• Kontrol ve manipülasyon eğilimleri
• Obsesyon ve sahiplenme
• Güç oyunları ve psikolojik savaş
• Gölge projeksiyonları
• Toksik bağımlılık riski

Bu ilişki ya sizi dönüştürür ya yok eder - orta yol yok.
''',
      advice:
          'Gücü bilinçli kullanın. Kontrol yerine dönüşümü hedefleyin. Gerekirse profesyonel destek alın.',
    ),
  };

  // AY SİNASTRİSİ
  static const Map<String, SynastryAspectInterpretation> moonAspects = {
    'moon_moon_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Ay',
      aspect: 'Kavuşum',
      theme: 'Duygusal Ayna',
      attraction: 4,
      harmony: 5,
      growth: 3,
      challenge: 2,
      interpretation: '''
İki Ay kavuşumu, duygusal dünyaların mükemmel örtüşmesini gösterir.
Bu çift birbirinin duygularını anında anlar, hatta hisseder.

Duygusal senkronizasyon:
• Aynı şeylere aynı şekilde tepki verme
• Ev ve aile konusunda benzer değerler
• Beslenme ve bakım stillerinde uyum
• Geçmiş ve nostalji paylaşımı
• Güvenlik ihtiyaçlarında örtüşme

Dikkat edilecekler:
• Duygusal tepkiler yoğunlaşabilir
• Birbirinin ruh halini "bulaştırma"
• Kör noktaları paylaşma
• Duygusal bağımlılık
• Rasyonellik eksikliği

Duygusal bağ güçlü - mantıksal denge önemli.
''',
      advice: 'Duygusal akışı koruyun ama birbirinizin ruh haline kapılmayın.',
    ),

    'moon_venus_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Venüs',
      aspect: 'Kavuşum',
      theme: 'Şefkat ve Güzellik',
      attraction: 5,
      harmony: 5,
      growth: 3,
      challenge: 1,
      interpretation: '''
Ay-Venüs kavuşumu romantik ilişkiler için en güzel kombinasyonlardan biridir.
Sevgi, şefkat ve güzellik birleşir.

Bu bağın güzellikleri:
• Doğal sevgi ve şefkat akışı
• Birbirini güzel hissettirme
• Ev hayatında uyum ve estetik
• Fiziksel temas ve dokunmanın önemi
• Romantik ve nazik ifadeler
• Yemek ve konfor paylaşımı

Potansiyel zorluklar:
• Çatışmalardan kaçınma
• Aşırı uyum sağlama (kendi ihtiyaçlarını bastırma)
• Tembellik ve konfora sığınma
• Zorluklar karşısında kırılganlık

Aşk kolay akar - zorluklar karşısında dayanıklılık geliştirin.
''',
      advice: 'Güzelliği koruyun ama zor konuşmaları ertelemeyin.',
    ),

    'moon_mars_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Mars',
      aspect: 'Kavuşum',
      theme: 'Tutku ve Koruma',
      attraction: 5,
      harmony: 3,
      growth: 4,
      challenge: 4,
      interpretation: '''
Ay-Mars kavuşumu yoğun, tutkulu ve bazen patlayıcı bir bağlantıdır.
Duygular ve eylem bir araya gelir.

Bu kombinasyonun dinamiği:
• Mars kişisi Ay'ı korur ve savunur
• Ay kişisi Mars'ın yumuşak tarafını ortaya çıkarır
• Cinsel kimya ve fiziksel çekim
• Duygusal tepkiler güçlenir
• Birlikte harekete geçme motivasyonu

Zorluklar:
• Duygusal patlamalar ve kavgalar
• Mars'ın Ay'ı incitmesi (sertlik)
• Ay'ın Mars'ı manipüle etmesi (suçluluk)
• Öfke ve kırgınlık döngüleri
• Savunmacılık

Tutku güçlü - öfke yönetimi kritik.
''',
      advice:
          'Tutkunuzu besleyin ama birbirinizi incitmeden ifade etmeyi öğrenin.',
    ),

    'moon_jupiter_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Jüpiter',
      aspect: 'Kavuşum',
      theme: 'Duygusal Bolluk',
      attraction: 4,
      harmony: 5,
      growth: 4,
      challenge: 1,
      interpretation: '''
Ay-Jüpiter kavuşumu sıcak, cömert ve genişletici bir bağlantıdır.
Bu kombinasyon duygusal bolluk ve karşılıklı destek getirir.

Bu bağın bereketleri:
• Jüpiter kişisi Ay'ın duygusal dünyasını genişletir
• Karşılıklı cömertlik ve destek
• İyimserlik ve umut paylaşımı
• Aile ve ev konusunda büyük vizyonlar
• Yurt dışı ve kültürler arası bağlantı
• Spiritüel ve felsefi derinlik

Dikkat edilecekler:
• Aşırı vaatler ve beklentiler
• Duygusal abartı
• Sınırların ihlali (iyi niyetle)
• Mali aşırılıklar

Bereket akar - ölçülü olmayı öğrenin.
''',
      advice: 'Cömertliği koruyun ama pratik sınırları hatırlayın.',
    ),

    'moon_saturn_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Satürn',
      aspect: 'Kavuşum',
      theme: 'Duygusal Sorumluluk',
      attraction: 2,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Ay-Satürn kavuşumu zorlu ama olgunlaştırıcı bir bağlantıdır.
Duygular ve sorumluluk bir araya gelir.

Bu kombinasyonun dinamiği:
• Satürn kişisi Ay'a güvenlik ve yapı sunar
• Ciddiyet ve uzun vadeli taahhüt
• Duygusal olgunluk zorlanması
• Sadakat ve güvenilirlik
• Aile ve geleneklere bağlılık

Zorluklar:
• Satürn'ün Ay'ı soğuk ve mesafeli bulması
• Ay'ın Satürn tarafından bastırılmış hissetmesi
• Duygusal kısıtlama ve ketlenme
• Eleştiri ve onay eksikliği
• "Yeterli değilim" hissi

Olgunluk getirir ama duygusal sıcaklığı ihmal etmeyin.
''',
      advice: 'Sorumluluğu koruyun ama sevginin sıcaklığını da gösterin.',
    ),

    'moon_pluto_conjunction': SynastryAspectInterpretation(
      planet1: 'Ay',
      planet2: 'Plüton',
      aspect: 'Kavuşum',
      theme: 'Duygusal Dönüşüm',
      attraction: 5,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Ay-Plüton kavuşumu sinastrinin en yoğun duygusal bağlantılarından biridir.
Bu kombinasyon derinden dönüştürücü, obsesif ve karşı konulamaz.

Bu bağın derinliği:
• Plüton kişisi Ay'ın en derin duygularını ortaya çıkarır
• Yoğun duygusal bağ ve bağımlılık
• Geçmiş yaraların iyileşme potansiyeli
• Psikolojik derinlik ve anlayış
• Birbirini "çıplak" görme
• Tam güven veya tam güvensizlik

Karanlık yönler:
• Duygusal manipülasyon ve kontrol
• Kıskançlık ve sahiplenme
• Obsesif düşünceler ve davranışlar
• Duygusal şantaj
• Toksik bağımlılık

Bu bağ ya iyileştirir ya yıkar - orta yol yok.
''',
      advice: 'Dönüşümü kucaklayın ama kontrol yerine güveni seçin.',
    ),
  };

  // VENÜS SİNASTRİSİ
  static const Map<String, SynastryAspectInterpretation> venusAspects = {
    'venus_venus_conjunction': SynastryAspectInterpretation(
      planet1: 'Venüs',
      planet2: 'Venüs',
      aspect: 'Kavuşum',
      theme: 'Değerler ve Zevkler',
      attraction: 5,
      harmony: 5,
      growth: 2,
      challenge: 1,
      interpretation: '''
İki Venüs kavuşumu mükemmel değer ve zevk uyumunu gösterir. Bu çift
aynı şeyleri sever, aynı şeyleri güzel bulur.

Bu uyumun güzellikleri:
• Estetik ve güzellik anlayışında örtüşme
• Sevgi dillerinin uyumu
• Sosyal hayat ve arkadaşlıklarda uyum
• Finansal değerlerde benzerlik
• Romantik ifade stillerinde uyum
• Birlikte keyif alma kapasitesi

Dikkat edilecekler:
• Çok fazla benzerlik sıkıcılık getirebilir
• Büyüme için yeterli meydan okuma olmayabilir
• Çatışma çözümünde zorluk (ikisi de uyumu sever)
• Karar vermede zorluk

Uyum mükemmel - biraz renk ve gerilim ekleyin.
''',
      advice: 'Uyumu koruyun ama birbirinizi zorlayan aktiviteler de ekleyin.',
    ),

    'venus_mars_conjunction': SynastryAspectInterpretation(
      planet1: 'Venüs',
      planet2: 'Mars',
      aspect: 'Kavuşum',
      theme: 'Manyetik Çekim',
      attraction: 5,
      harmony: 4,
      growth: 3,
      challenge: 2,
      interpretation: '''
Venüs-Mars kavuşumu romantik ve cinsel çekimin klasik göstergesidir.
Dişil ve eril enerjilerin birleşimi güçlü manyetizm yaratır.

Bu kombinasyonun büyüsü:
• Karşı konulamaz fiziksel çekim
• Romantik ve cinsel kimyanın mükemmel dengesi
• Flört ve kur yapma keyfi
• Birbirini tamamlayan enerjiler
• Yaratıcı ve üretken ortaklık
• Doğal dans ve hareket uyumu

Dikkat edilecekler:
• Sadece fiziksel çekime dayalı kalabilir
• Mars'ın agresifliği Venüs'ü incitebilir
• Venüs'ün pasifliği Mars'ı hayal kırıklığına uğratabilir
• Cinsellik dışındaki uyumu kontrol edin

Cinsel kimya mükemmel - diğer alanlarda da bağlantı kurun.
''',
      advice:
          'Fiziksel çekimi koruyun ama duygusal ve entelektüel bağı da geliştirin.',
    ),

    'venus_jupiter_conjunction': SynastryAspectInterpretation(
      planet1: 'Venüs',
      planet2: 'Jüpiter',
      aspect: 'Kavuşum',
      theme: 'Aşk ve Şans',
      attraction: 4,
      harmony: 5,
      growth: 4,
      challenge: 1,
      interpretation: '''
Venüs-Jüpiter kavuşumu "şanslı aşk" göstergesidir. Bu kombinasyon
bolluk, neşe ve genişleme getirir.

Bu bağın bereketleri:
• Birlikte olduklarında şans gelir
• Cömertlik ve hediye alışverişi
• Sosyal hayatta parlama
• Seyahat ve macera paylaşımı
• Birbirini yükseltme ve destekleme
• Finansal bolluk potansiyeli

Dikkat edilecekler:
• Aşırı harcama ve savurganlık
• Birbirini şımartma
• Gerçekçilikten uzaklaşma
• "Çok iyi" şüphesi

Bereket akar - ayakları yerde tutun.
''',
      advice: 'Bolluğu paylaşın ama pratik sınırları koruyun.',
    ),

    'venus_saturn_conjunction': SynastryAspectInterpretation(
      planet1: 'Venüs',
      planet2: 'Satürn',
      aspect: 'Kavuşum',
      theme: 'Kalıcı Aşk',
      attraction: 2,
      harmony: 3,
      growth: 4,
      challenge: 4,
      interpretation: '''
Venüs-Satürn kavuşumu yavaş ama kalıcı aşkın göstergesidir.
Bu kombinasyon ciddiyet, taahhüt ve sadakat vurgular.

Bu bağın özellikleri:
• Yavaş gelişen ama derin bağ
• Uzun vadeli taahhüt ve sadakat
• Pratik ve gerçekçi aşk anlayışı
• Maddi güvenlik ve planlama
• Sorumluluk ve güvenilirlik
• Yaşla birlikte güçlenen ilişki

Zorluklar:
• Başlangıçta soğuk veya mesafeli görünebilir
• Romantizm eksikliği
• Venüs'ün özgürlük ihtiyacı ile Satürn'ün kısıtlaması
• Sevgi ifadesinde ketlenme
• Eleştiri ve mükemmeliyetçilik

Kalıcılık güçlü - sıcaklığı ve romantizmi ihmal etmeyin.
''',
      advice: 'Taahhüdü koruyun ama romantik ifadeleri sürdürün.',
    ),

    'venus_pluto_conjunction': SynastryAspectInterpretation(
      planet1: 'Venüs',
      planet2: 'Plüton',
      aspect: 'Kavuşum',
      theme: 'Obsesif Aşk',
      attraction: 5,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Venüs-Plüton kavuşumu sinastrinin en yoğun romantik bağlantılarından
biridir. Aşk ve obsesyon birleşir.

Bu bağın yoğunluğu:
• Hipnotik ve karşı konulamaz çekim
• Derin tutku ve arzu
• Birbirini tamamen isteme
• Transformatif aşk deneyimi
• Hiç kimseyi bu kadar sevmemiş hissi
• Hayat boyu iz bırakan ilişki

Karanlık yönler:
• Obsesyon ve sahiplenme
• Kıskançlık ve kontrol
• Manipülasyon ve güç oyunları
• "Sensiz yaşayamam" bağımlılığı
• Ayrılık travması

Bu aşk ya sizi dönüştürür ya sizi yakar - bilinçli olun.
''',
      advice: 'Tutkunuzu kucaklayın ama sağlıklı sınırlar koruyun.',
    ),
  };

  // MARS SİNASTRİSİ
  static const Map<String, SynastryAspectInterpretation> marsAspects = {
    'mars_mars_conjunction': SynastryAspectInterpretation(
      planet1: 'Mars',
      planet2: 'Mars',
      aspect: 'Kavuşum',
      theme: 'Eylem Ortaklığı',
      attraction: 4,
      harmony: 3,
      growth: 3,
      challenge: 4,
      interpretation: '''
İki Mars kavuşumu güçlü, enerjik ve potansiyel olarak patlayıcı bir
bağlantıdır. Aynı eylem tarzına sahip iki güç bir araya gelir.

Bu kombinasyonun dinamiği:
• Güçlü fiziksel enerji ve cinsel çekim
• Birlikte aksiyon alma, projeler başlatma
• Spor ve rekabet paylaşımı
• Birbirini harekete geçirme
• Koruyuculuk ve savunma

Zorluklar:
• Güç mücadeleleri ve ego çatışmaları
• "Ben daha güçlüyüm" rekabeti
• Öfke patlamaları ve kavgalar
• Sabırsızlık ve aceleci davranışlar
• Fiziksel çatışma riski

Enerji güçlü - yapıcı kanallara yönlendirin.
''',
      advice:
          'Enerjinizi birlikte pozitif hedeflere yönlendirin. Spor ve fiziksel aktiviteler öfkeyi dönüştürür.',
    ),

    'mars_jupiter_conjunction': SynastryAspectInterpretation(
      planet1: 'Mars',
      planet2: 'Jüpiter',
      aspect: 'Kavuşum',
      theme: 'Genişleyen Eylem',
      attraction: 4,
      harmony: 4,
      growth: 5,
      challenge: 2,
      interpretation: '''
Mars-Jüpiter kavuşumu başarı ve genişleme potansiyeli taşıyan güçlü bir
kombinasyondur. Eylem ve vizyon birleşir.

Bu bağın potansiyeli:
• Birlikte büyük hedefler koyma ve başarma
• İş ortaklığında başarı potansiyeli
• Macera ve keşif enerjisi
• Birbirini motive etme
• Spor ve fiziksel aktivitelerde uyum
• Cesaret ve risk alma kapasitesi

Dikkat edilecekler:
• Aşırı özgüven ve pervasızlık
• Abartılı planlar ve vaatler
• Kaynakları aşan girişimler
• Sabırsızlık ve aceleci davranışlar

Başarı potansiyeli yüksek - gerçekçi kalın.
''',
      advice: 'Büyük hedeflerin peşinden gidin ama pratik planlar yapın.',
    ),

    'mars_saturn_conjunction': SynastryAspectInterpretation(
      planet1: 'Mars',
      planet2: 'Satürn',
      aspect: 'Kavuşum',
      theme: 'Disiplinli Güç',
      attraction: 2,
      harmony: 2,
      growth: 5,
      challenge: 5,
      interpretation: '''
Mars-Satürn kavuşumu zorlu ama potansiyel olarak çok güçlü bir
kombinasyondur. Eylem ve disiplin bir araya gelir.

Bu kombinasyonun dinamiği:
• Birlikte zorlu hedefler başarma potansiyeli
• Disiplin ve kararlılık
• Uzun vadeli projeler için ideal
• Satürn'ün Mars'ı yönlendirmesi
• Yapıcı enerji kullanımı

Zorluklar:
• Mars'ın Satürn tarafından kısıtlanmış hissetmesi
• Satürn'ün Mars'ı tehlikeli veya pervasız bulması
• Engelleme ve hayal kırıklığı
• Bastırılmış öfke ve kızgınlık
• Güç mücadeleleri

Zorlukların üstesinden gelirseniz çok güçlü bir ekip olursunuz.
''',
      advice: 'Disiplini kabul edin ama özgürlük alanı da bırakın.',
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// EV ÖRTÜŞMELERİ (OVERLAY)
// ════════════════════════════════════════════════════════════════════════════

class HouseOverlays {
  static const String introduction = '''
Ev örtüşmeleri (overlay), bir kişinin gezegenlerinin diğer kişinin hangi
evlerine düştüğünü analiz eder. Bu, ilişkide hangi hayat alanlarının
aktive edildiğini gösterir.

Örneğin: Partnerinizin Güneş'i sizin 7. evinize düşüyorsa, o kişi sizin
ilişki alanınızı "aydınlatır" - evlilik ve ortaklık konuları öne çıkar.
''';

  static const Map<int, HouseOverlayContent> overlays = {
    1: HouseOverlayContent(
      house: 1,
      theme: 'Kimlik ve Görünüm',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 1. evinize düşüyorsa:
• Bu kişi sizi "aydınlatır" ve görünür kılar
• Varlığında daha canlı ve kendinden emin hissedersiniz
• Sizi kim olduğunuz konusunda farkındalığa yöneltir
• Kişisel gelişiminizi teşvik eder
• Dikkat: Ego çatışmaları olabilir

Bu yerleşim "seni seninle tanıştırıyorum" der.
''',
        'Moon': '''
Partnerinizin Ay'ı 1. evinize düşüyorsa:
• Bu kişi yanında duygusal olarak rahat hissedersiniz
• Bakım ve beslenme alırsınız
• Sezgisel bir anlayış vardır
• Aile ve yuva hissi yaratır
• Dikkat: Duygusal bağımlılık riski

Bu yerleşim "seni evde hissettiriyorum" der.
''',
        'Venus': '''
Partnerinizin Venüs'ü 1. evinize düşüyorsa:
• Bu kişi sizi çekici bulur
• Yanında güzel hissedersiniz
• Sevgi ve hayranlık alırsınız
• Sosyal becerileriniz gelişir
• Dikkat: Yüzeysel kalabilir

Bu yerleşim "seni güzel buluyorum" der.
''',
        'Mars': '''
Partnerinizin Mars'ı 1. evinize düşüyorsa:
• Bu kişi sizi harekete geçirir
• Fiziksel çekim güçlüdür
• Enerjiniz artar
• Cesaret ve girişimcilik gelişir
• Dikkat: Çatışma potansiyeli yüksek

Bu yerleşim "seni harekete geçiriyorum" der.
''',
      },
    ),

    5: HouseOverlayContent(
      house: 5,
      theme: 'Romantizm ve Yaratıcılık',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 5. evinize düşüyorsa:
• Romantik çekim güçlüdür
• Birlikte eğlence ve oyun
• Yaratıcı projeler paylaşımı
• Çocuklar konusunda uyum
• Bu yerleşim "seninle oynamak istiyorum" der

Kalıcılık için diğer faktörlere bakın.
''',
        'Venus': '''
Partnerinizin Venüs'ü 5. evinize düşüyorsa:
• Romantik cennet! Aşk şiiri gibi bir bağ
• Sanatsal ve yaratıcı işbirliği
• Flört ve kur yapma keyfi
• Romantik ifadeler bolca akar
• Dikkat: Sadece eğlence mi kalıcı mı?

Bu yerleşim "seninle aşık olmak istiyorum" der.
''',
        'Mars': '''
Partnerinizin Mars'ı 5. evinize düşüyorsa:
• Güçlü cinsel çekim
• Tutkulu ve heyecanlı ilişki
• Rekabet ve oyunlarda enerji
• Yaratıcılığı harekete geçirme
• Dikkat: Sahiplenme ve kıskançlık

Bu yerleşim "seninle tutkulu olmak istiyorum" der.
''',
      },
    ),

    7: HouseOverlayContent(
      house: 7,
      theme: 'Evlilik ve Ortaklık',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 7. evinize düşüyorsa:
• Bu kişi "ideal eş" imajınızı yansıtır
• Evlilik ve ciddi ortaklık potansiyeli yüksek
• Birlikte olmak doğal ve kolay hissedilir
• Kamu önünde birlikte parlama
• Dikkat: İdealizasyon riski

Bu yerleşim "seninle evlenmek istiyorum" der.
''',
        'Moon': '''
Partnerinizin Ay'ı 7. evinize düşüyorsa:
• Duygusal ortaklık ve aile kurma isteği
• Birlikte yuva yapmak doğal gelir
• Karşılıklı bakım ve destek
• Güvenlik ve aidiyet hissi
• Dikkat: Duygusal bağımlılık

Bu yerleşim "seninle ev kurmak istiyorum" der.
''',
        'Venus': '''
Partnerinizin Venüs'ü 7. evinize düşüyorsa:
• Romantik ortaklık potansiyeli çok güçlü
• Evlilik ve ciddi ilişki için ideal
• Uyum ve denge arayanlar için mükemmel
• Sosyal hayatta birlikte parlama
• Dikkat: Çatışmadan kaçınma eğilimi

Bu yerleşim "seninle uyumlu olmak istiyorum" der.
''',
        'Saturn': '''
Partnerinizin Satürn'ü 7. evinize düşüyorsa:
• Karmik bağ ve ciddi taahhüt
• Uzun vadeli, kalıcı ortaklık
• Sorumluluk ve olgunluk gerektiren ilişki
• Zorluklar yoluyla büyüme
• Dikkat: Ağırlık ve kısıtlama hissi

Bu yerleşim "seninle sorumluluğu paylaşmak istiyorum" der.
''',
      },
    ),

    8: HouseOverlayContent(
      house: 8,
      theme: 'Dönüşüm ve Yakınlık',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 8. evinize düşüyorsa:
• Derin, dönüştürücü bağlantı
• Psikolojik derinlik ve anlayış
• Finansal birleşim (ortak kaynaklar)
• Cinsel yoğunluk
• Dikkat: Güç mücadeleleri

Bu yerleşim "seni derinden tanımak istiyorum" der.
''',
        'Venus': '''
Partnerinizin Venüs'ü 8. evinize düşüyorsa:
• Yoğun cinsel çekim ve yakınlık
• Finansal kazanç potansiyeli (miras, ortak varlıklar)
• Derin duygusal bağ
• Dönüşüm yoluyla sevgi
• Dikkat: Obsesyon ve sahiplenme

Bu yerleşim "seninle birleşmek istiyorum" der.
''',
        'Mars': '''
Partnerinizin Mars'ı 8. evinize düşüyorsa:
• Güçlü cinsel çekim ve tutku
• Dönüştürücü deneyimler
• Güç mücadeleleri ve kontrol
• Finansal ortaklıkta enerji
• Dikkat: Manipülasyon ve çatışma

Bu yerleşim "seninle derinlere inmek istiyorum" der.
''',
        'Pluto': '''
Partnerinizin Plüton'u 8. evinize düşüyorsa:
• Sinastrinin en yoğun yerleşimlerinden biri
• Karşılıklı obsesyon ve dönüşüm
• Hiç kimseyle yaşamadığınız derinlik
• Psişik ve ruhsal bağ
• Dikkat: Toksik potansiyel çok yüksek

Bu yerleşim "seninle yeniden doğmak istiyorum" der.
''',
      },
    ),

    10: HouseOverlayContent(
      house: 10,
      theme: 'Kariyer ve Statü',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 10. evinize düşüyorsa:
• Bu kişi kariyerinizi destekler ve yükseltir
• Profesyonel ortaklık potansiyeli
• Toplumda birlikte yükselme
• İtibar ve statü kazancı
• Dikkat: İş ve aşkı karıştırma

Bu yerleşim "seninle başarmak istiyorum" der.
''',
        'Jupiter': '''
Partnerinizin Jüpiter'i 10. evinize düşüyorsa:
• Kariyer şansı ve büyüme getiren ilişki
• Profesyonel fırsatlar
• Toplumda genişleme ve tanınırlık
• Mentor-öğrenci dinamiği olabilir
• Dikkat: Beklentileri yönetin

Bu yerleşim "seninle büyümek istiyorum" der.
''',
        'Saturn': '''
Partnerinizin Satürn'ü 10. evinize düşüyorsa:
• Ciddi, profesyonel ortaklık
• Kariyer sorumluluğu ve yapı
• Uzun vadeli başarı potansiyeli
• Birlikte çalışma disiplini
• Dikkat: Baskı ve kısıtlama hissi

Bu yerleşim "seninle yapılar kurmak istiyorum" der.
''',
      },
    ),

    12: HouseOverlayContent(
      house: 12,
      theme: 'Ruhsal ve Bilinçaltı',
      planetsInPartnerHouse: {
        'Sun': '''
Partnerinizin Güneş'i 12. evinize düşüyorsa:
• Ruhsal ve mistik bağlantı
• Geçmiş yaşam hissi
• Bilinçaltı dinamiklerini ortaya çıkarır
• Yalnızlık ve izolasyon temaları
• Dikkat: Gizlilik ve kafa karışıklığı

Bu yerleşim "seninle ruhsal boyutta bağlanmak istiyorum" der.
''',
        'Moon': '''
Partnerinizin Ay'ı 12. evinize düşüyorsa:
• Derin duygusal ve psişik bağ
• Rüyalarda buluşma
• Bilinçaltı iletişim
• Şifa ve bakım potansiyeli
• Dikkat: Duygusal karmaşa

Bu yerleşim "seninle rüyada buluşmak istiyorum" der.
''',
        'Neptune': '''
Partnerinizin Neptün'ü 12. evinize düşüyorsa:
• Mistik, ruhsal, transcendent bağ
• Telepatik iletişim
• Sanatsal ve yaratıcı ilham
• Koşulsuz sevgi potansiyeli
• Dikkat: İlüzyon ve kaçış

Bu yerleşim "seninle sonsuzlukta kaybolmak istiyorum" der.
''',
      },
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// KOMPOZİT HARİTA
// ════════════════════════════════════════════════════════════════════════════

class CompositeChartContent {
  static const String introduction = '''
Kompozit harita, iki kişinin doğum haritalarının orta noktasından oluşturulan
"ilişkinin haritası"dır. Bu harita ilişkinin kendisini - amacını, potansiyelini
ve zorluklarını - gösterir.

Kompozit Güneş: İlişkinin özü ve amacı
Kompozit Ay: İlişkinin duygusal temeli
Kompozit Venüs: İlişkide sevgi ve değerler
Kompozit Mars: İlişkide eylem ve enerji
Kompozit Satürn: İlişkinin yapısı ve zorlukları
''';

  static const Map<int, CompositeHouseContent> compositeHouses = {
    1: CompositeHouseContent(
      house: 1,
      theme: 'İlişkinin Kimliği',
      sunInterpretation: '''
Kompozit Güneş 1. evde: İlişki güçlü bir kimliğe sahip
• Birlikte görünür ve tanınır olmak
• İlişki her iki partnerin de kimliğini şekillendirir
• "Biz" kimliği güçlü
• Liderlik yapan, öne çıkan çift
• Dikkat: Bireyselliği korumak önemli
''',
      moonInterpretation: '''
Kompozit Ay 1. evde: İlişki duygusal ifadeye dayalı
• Duyguları açıkça gösteren çift
• Bakım ve beslenme ilişkinin temelidir
• Değişken ve reaktif ilişki
• Dikkat: Duygusal istikrar gerekli
''',
    ),

    5: CompositeHouseContent(
      house: 5,
      theme: 'Yaratıcılık ve Romantizm',
      sunInterpretation: '''
Kompozit Güneş 5. evde: Romantik ve yaratıcı ilişki
• Aşk ve eğlence odaklı bağ
• Çocuklar ve yaratıcı projeler önemli
• Neşeli ve oyuncu dinamik
• Dikkat: Ciddi konuları ihmal etmeyin
''',
      moonInterpretation: '''
Kompozit Ay 5. evde: Duygusal romantizm
• Birlikte eğlenme ve oynama ihtiyacı
• Çocuklarla duygusal bağ
• Yaratıcı ifade yoluyla duygusal doyum
• Dikkat: Sorumluluklar arasında denge
''',
    ),

    7: CompositeHouseContent(
      house: 7,
      theme: 'Ortaklık ve Evlilik',
      sunInterpretation: '''
Kompozit Güneş 7. evde: Evlilik ve ortaklık için ideal
• İlişkinin amacı ortaklık ve denge
• Birbirini tamamlayan enerji
• Toplum tarafından tanınan çift
• Dikkat: Bağımsızlığı koruyun
''',
      moonInterpretation: '''
Kompozit Ay 7. evde: Duygusal ortaklık
• Birbirinin duygusal ihtiyaçlarını karşılama
• Ev ve aile kurma motivasyonu
• Kamuya açık duygusal ifade
• Dikkat: Dış dünyaya bağımlılık
''',
    ),

    8: CompositeHouseContent(
      house: 8,
      theme: 'Dönüşüm ve Birleşme',
      sunInterpretation: '''
Kompozit Güneş 8. evde: Dönüştürücü ilişki
• İlişkinin amacı derin dönüşüm
• Yoğun, tutkulu ve transformatif bağ
• Finansal birleşim önemli
• Dikkat: Güç mücadelelerini yönetin
''',
      moonInterpretation: '''
Kompozit Ay 8. evde: Derin duygusal bağ
• Bilinçaltı ve psikolojik birleşme
• Duygusal şifa potansiyeli
• Yoğun ve bazen zorlayıcı duygular
• Dikkat: Sağlıklı sınırlar koruyun
''',
    ),

    10: CompositeHouseContent(
      house: 10,
      theme: 'Kamusal İmaj ve Başarı',
      sunInterpretation: '''
Kompozit Güneş 10. evde: Başarı odaklı ilişki
• Birlikte kariyer ve statü hedefleri
• Toplumda tanınan ve saygı duyulan çift
• Profesyonel ortaklık potansiyeli
• Dikkat: Özel hayatı ihmal etmeyin
''',
      moonInterpretation: '''
Kompozit Ay 10. evde: Kamusal duygusal ifade
• Toplum tarafından görülen ilişki
• Kariyer ve aile dengesinde duygusal yatırım
• Dikkat: Gizlilik ve mahremiyet ihtiyacı
''',
    ),

    12: CompositeHouseContent(
      house: 12,
      theme: 'Ruhsal Birlik',
      sunInterpretation: '''
Kompozit Güneş 12. evde: Ruhsal ve karmik ilişki
• İlişkinin amacı manevi büyüme
• Gizli veya özel ilişki dinamikleri
• Geçmiş yaşam bağlantısı hissi
• Dikkat: Kaçış ve izolasyon eğilimi
''',
      moonInterpretation: '''
Kompozit Ay 12. evde: Mistik duygusal bağ
• Telepatik ve sezgisel iletişim
• Bilinçaltı düzeyde derin bağ
• Şifa ve kurtuluş potansiyeli
• Dikkat: Gerçeklikten kopma riski
''',
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// BURÇ UYUMLARI
// ════════════════════════════════════════════════════════════════════════════

class ZodiacCompatibility {
  static const Map<String, Map<String, CompatibilityProfile>> compatibility = {
    'aries': {
      'aries': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Koç',
        overallScore: 75,
        romanticScore: 80,
        friendshipScore: 85,
        workScore: 60,
        sexualScore: 90,
        shortDescription: 'İki ateş, büyük tutku ama güç mücadelesi',
        detailedAnalysis: '''
İki Koç bir araya geldiğinde, yangın kaçınılmazdır - ister tutku ateşi,
ister öfke ateşi. Bu kombinasyon yoğun enerji, rekabet ve heyecan vaat eder.

GÜÇLÜ YÖNLER:
• Karşılıklı anlayış - aynı dili konuşuyorlar
• Macera ve spontanlık paylaşımı
• Fiziksel çekim ve cinsel kimya
• Birbirini harekete geçirme
• Cesaret ve girişimcilik

ZORLUKLAR:
• Ego savaşları - kim patron?
• Öfke patlamaları ve kavgalar
• Sabırsızlık ve aceleci kararlar
• Uzlaşmada zorluk
• Her ikisi de lider olmak istiyor

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Dönüşümlü liderlik yapın
2. Öfke yönetimi öğrenin
3. Bireysel alanlar bırakın
4. Rekabeti dışarıya yönlendirin
5. Özür dilemeyi öğrenin
''',
        tips: [
          'Yarışmak yerine takım olun',
          'Öfkeyi spor veya fiziksel aktiviteyle boşaltın',
          'Her ikisinin de kazanabileceği alanlar yaratın',
          'Soğumak için zaman ayırın',
        ],
      ),
      'taurus': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Boğa',
        overallScore: 60,
        romanticScore: 65,
        friendshipScore: 55,
        workScore: 70,
        sexualScore: 75,
        shortDescription: 'Ateş toprakla buluşuyor - zıt çekim',
        detailedAnalysis: '''
Koç'un ateşi Boğa'nın toprağıyla buluştuğunda, farklı dünyaların
çarpışması yaşanır. Ama bu farklılıklar tamamlayıcı da olabilir.

GÜÇLÜ YÖNLER:
• Koç başlatır, Boğa tamamlar
• Cinsel çekim güçlü (Venüs-Mars dinamiği)
• Koç'un enerjisi, Boğa'nın sabrı
• Birbirini dengeleme potansiyeli
• İş ortaklığında güçlü kombine

ZORLUKLAR:
• Hız farkı - Koç aceleci, Boğa yavaş
• Koç değişim ister, Boğa istikrar
• İnatçılık çatışması
• Koç sıkılabilir, Boğa bunalabilir
• Farklı öncelikler (macera vs güvenlik)

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Hız farkını kabul edin
2. Boğa'nın güvenlik ihtiyacına saygı gösterin
3. Koç'un özgürlük ihtiyacını karşılayın
4. Orta yol bulmayı öğrenin
5. Duyusal zevkleri paylaşın
''',
        tips: [
          'Sabır erdemdir - her iki taraf için de',
          'Fiziksel temas ve yemek paylaşımı bağlar',
          'Finansal konularda uzlaşın',
          'Rutinleri değişimle dengeleyin',
        ],
      ),
      'gemini': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'İkizler',
        overallScore: 80,
        romanticScore: 75,
        friendshipScore: 90,
        workScore: 75,
        sexualScore: 80,
        shortDescription: 'Ateş ve hava - birbirini alevlendirir',
        detailedAnalysis: '''
Koç ve İkizler, zodyakın en eğlenceli kombinasyonlarından birini oluşturur.
Ateş havayı tutuşturur, hava ateşi besler.

GÜÇLÜ YÖNLER:
• İkisi de hızlı ve spontan
• Sıkılmak imkansız
• Entellektüel ve fiziksel uyum
• Macera ve keşif paylaşımı
• Birbirini eğlendirme

ZORLUKLAR:
• Her ikisi de kararsız olabilir
• Derinlik eksikliği
• Koç'un doğrudanlığı İkizler'i şaşırtabilir
• İkizler'in çoklu ilgileri Koç'u kızdırabilir
• Taahhüt sorunları

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Yeni şeyler denemeye devam edin
2. İletişimi açık tutun
3. Birbirinin sosyal çevresine saygı gösterin
4. Derinleşmek için zaman ayırın
5. Bireysel meraklarınızı destekleyin
''',
        tips: [
          'Birlikte seyahat edin ve keşfedin',
          'Entellektüel tartışmaları canlı tutun',
          'Sosyal hayatı paylaşın',
          'Duygusal bağı ihmal etmeyin',
        ],
      ),
      'cancer': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Yengeç',
        overallScore: 55,
        romanticScore: 60,
        friendshipScore: 50,
        workScore: 55,
        sexualScore: 65,
        shortDescription: 'Ateş ve su - buharlaşma veya ılıma',
        detailedAnalysis: '''
Koç'un ateşi Yengeç'in suyuyla buluştuğunda, karmaşık bir dinamik oluşur.
Birbirlerinden çok şey öğrenebilirler ama uyum zaman alır.

GÜÇLÜ YÖNLER:
• Koç korur, Yengeç besler
• Karşılıklı sadakat potansiyeli
• Aile kurma motivasyonu
• Tamamlayıcı güçler
• Derin duygusal bağ potansiyeli

ZORLUKLAR:
• Duygusal dil farkı
• Koç patlar, Yengeç içine çekilir
• Hassasiyet farklılıkları
• Koç sıkılabilir, Yengeç incinnebilir
• Çatışma çözümünde zorluk

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Duygusal güvenlik yaratın
2. Koç yumuşamayı öğrensin
3. Yengeç cesaret kazansın
4. Ev ve macera dengesini bulun
5. Birbirinin ailesiyle bağ kurun
''',
        tips: [
          'Duygusal empatiye çalışın',
          'Ev bir sığınak olsun',
          'Geçmişe saygı gösterin',
          'Birlikte yemek yapın',
        ],
      ),
      'leo': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Aslan',
        overallScore: 90,
        romanticScore: 95,
        friendshipScore: 90,
        workScore: 85,
        sexualScore: 95,
        shortDescription: 'Ateş ve ateş - görkemli birliktelik',
        detailedAnalysis: '''
Koç ve Aslan, zodyakın en güçlü ve gösterişli kombinasyonlarından birini
oluşturur. İki ateş işareti birlikte parlar.

GÜÇLÜ YÖNLER:
• Karşılıklı hayranlık ve saygı
• Güçlü fiziksel çekim
• Birlikte liderlik yapma
• Cömertlik ve sıcaklık
• Macera ve drama paylaşımı

ZORLUKLAR:
• İki büyük ego
• Kim sahnede olacak?
• Kıskançlık ve rekabet
• Her ikisi de dikkat ister
• Drama aşırıya kaçabilir

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Birbirinizi övmeyi öğrenin
2. Sahnede dönüşümlü parlayın
3. Karşılıklı saygıyı koruyun
4. Birlikte büyük hedefler koyun
5. Gururunuzu yönetin
''',
        tips: [
          'Birbirinize taç giydirin',
          'Büyük kutlamalar yapın',
          'Birlikte yaratıcı projeler',
          'Cömertliği paylaşın',
        ],
      ),
      'virgo': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Başak',
        overallScore: 50,
        romanticScore: 45,
        friendshipScore: 55,
        workScore: 65,
        sexualScore: 55,
        shortDescription: 'Ateş ve toprak - zor ama öğretici',
        detailedAnalysis: '''
Koç'un cesur atılganlığı Başak'ın dikkatli analizi ile çatışır.
Bu zor ama öğretici bir kombinasyondur.

GÜÇLÜ YÖNLER:
• Koç vizyonu, Başak detayı
• Birbirini dengeleme potansiyeli
• Koç başlatır, Başak mükemmelleştirir
• Her ikisi de zeki ve çalışkan
• İş ortaklığında potansiyel

ZORLUKLAR:
• Hız ve yaklaşım farkı
• Koç aceleci, Başak detaycı
• Eleştiri hassasiyeti
• Başak düzeltir, Koç kızar
• Spontanlık vs planlama

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Farklılıkları güç olarak görün
2. Eleştiriyi yapıcı tutun
3. Orta yol bulmayı öğrenin
4. Birbirinin güçlerine değer verin
5. Sabırlı olun
''',
        tips: [
          'Eleştiri yerine öneri sunun',
          'Detaylara saygı gösterin',
          'Spontan anlar yaratın',
          'Birlikte organize olun',
        ],
      ),
      'libra': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Terazi',
        overallScore: 70,
        romanticScore: 80,
        friendshipScore: 65,
        workScore: 60,
        sexualScore: 85,
        shortDescription: 'Karşıt burçlar - manyetik çekim',
        detailedAnalysis: '''
Koç ve Terazi, zodyakın karşıt burçlarıdır. Bu "karşıtlar çeker" ilkesinin
en net örneğidir.

GÜÇLÜ YÖNLER:
• Güçlü manyetik çekim
• Tamamlayıcı özellikler
• Koç'un cesareti, Terazi'nin diplomatiliği
• Birbirini dengeleyen güçler
• Romantik potansiyel yüksek

ZORLUKLAR:
• Koç ben-odaklı, Terazi biz-odaklı
• Karar verme tarzı farklılıkları
• Koç hızlı, Terazi tereddütlü
• Çatışma vs uyum yaklaşımları
• Bağımsızlık vs birliktelik

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Farklılıkları kucaklayın
2. Orta noktada buluşun
3. Her ikisinin de ihtiyaçlarını karşılayın
4. Birbirinden öğrenin
5. Dengeyi birlikte bulun
''',
        tips: [
          'Uzlaşmayı öğrenin',
          'Sosyal hayatı paylaşın',
          'Romantik jestler yapın',
          'Adaleti birlikte arayın',
        ],
      ),
      'scorpio': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Akrep',
        overallScore: 75,
        romanticScore: 85,
        friendshipScore: 65,
        workScore: 70,
        sexualScore: 95,
        shortDescription: 'Mars iki farklı formda - yoğun tutku',
        detailedAnalysis: '''
Her iki burç da Mars tarafından yönetilir (Akrep geleneksel olarak).
Bu yoğun, tutkulu ve bazen patlayıcı bir kombinasyondur.

GÜÇLÜ YÖNLER:
• Güçlü cinsel kimya
• Tutkulu ve yoğun bağ
• Karşılıklı saygı ve güç
• Birlikte dağ taşıma kapasitesi
• Derin sadakat potansiyeli

ZORLUKLAR:
• Güç mücadeleleri
• Kontrol savaşları
• Koç açık, Akrep gizli
• Kıskançlık ve sahiplenme
• Öfke patlamaları

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Güveni inşa edin
2. Kontrol bırakmayı öğrenin
3. Dürüstlüğü koruyun
4. Tutkuyu yapıcı kanallara yönlendirin
5. Birbirinin sınırlarına saygı gösterin
''',
        tips: [
          'Gizleri paylaşın',
          'Cinsel bağı besleyin',
          'Kıskançlığı yönetin',
          'Birlikte dönüşün',
        ],
      ),
      'sagittarius': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Yay',
        overallScore: 90,
        romanticScore: 85,
        friendshipScore: 95,
        workScore: 80,
        sexualScore: 90,
        shortDescription: 'Ateş ve ateş - macera ortakları',
        detailedAnalysis: '''
Koç ve Yay, zodyakın en uyumlu ateş kombinasyonlarından birini oluşturur.
Macera, özgürlük ve neşe paylaşırlar.

GÜÇLÜ YÖNLER:
• Doğal uyum ve anlayış
• Macera ve keşif tutkusu
• Özgürlüğe karşılıklı saygı
• İyimserlik ve umut
• Fiziksel aktiviteler ve spor

ZORLUKLAR:
• Taahhütten kaçınma
• İkisi de sıkılabilir
• Detaylara dikkat eksikliği
• Abartma ve aşırıya kaçma
• Yerleşik düzen kurmada zorluk

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Maceraya devam edin
2. Özgürlük alanları bırakın
3. Birlikte öğrenin ve büyüyün
4. Bazen dinlenmeyi öğrenin
5. Birlikte seyahat edin
''',
        tips: [
          'Dünyayı birlikte keşfedin',
          'Felsefe ve anlam tartışın',
          'Birbirinize alan verin',
          'Birlikte spor yapın',
        ],
      ),
      'capricorn': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Oğlak',
        overallScore: 55,
        romanticScore: 50,
        friendshipScore: 50,
        workScore: 75,
        sexualScore: 65,
        shortDescription: 'Kardinal güçler - liderlik çatışması',
        detailedAnalysis: '''
Her iki burç da kardinaldir - liderlik ve başlatma enerjisi taşırlar.
Bu güç çatışması veya güçlü ortaklık anlamına gelebilir.

GÜÇLÜ YÖNLER:
• Her ikisi de hedef odaklı
• İş ve kariyer uyumu
• Karşılıklı saygı potansiyeli
• Birlikte başarı kapasitesi
• Güçlü irade ve kararlılık

ZORLUKLAR:
• Liderlik çatışması
• Koç aceleci, Oğlak planlı
• Yaklaşım farkları
• Koç eğlenceli, Oğlak ciddi
• Duygusal ifade farkları

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Rolleri netleştirin
2. Birbirinin yaklaşımına saygı gösterin
3. İş ve eğlence dengesini bulun
4. Ortak hedefler belirleyin
5. Sabırlı olun
''',
        tips: [
          'Kariyer hedeflerini paylaşın',
          'Birbirini profesyonel olarak destekleyin',
          'Eğlence zamanı ayırın',
          'Somut başarıları kutlayın',
        ],
      ),
      'aquarius': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Kova',
        overallScore: 80,
        romanticScore: 75,
        friendshipScore: 90,
        workScore: 80,
        sexualScore: 75,
        shortDescription: 'Ateş ve hava - yenilikçi ortaklar',
        detailedAnalysis: '''
Koç ve Kova, birbirini entelektüel ve sosyal olarak besleyen yenilikçi
bir kombinasyondur.

GÜÇLÜ YÖNLER:
• Her ikisi de bağımsız ve özgün
• Yenilik ve devrim tutkusu
• Entelektüel stimülasyon
• Sosyal aktivizm paylaşımı
• Birbirinin özgürlüğüne saygı

ZORLUKLAR:
• Her ikisi de inatçı
• Duygusal bağlanma zorlukları
• Kova mesafeli olabilir
• Koç daha tutkulu isteyebilir
• Taahhüt konusunda tereddüt

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Ortak vizyonlar geliştirin
2. Bireyselliğe saygı gösterin
3. Duygusal bağı ihmal etmeyin
4. Birlikte insanlığa hizmet edin
5. Benzersiz ilişki kuralları oluşturun
''',
        tips: [
          'Sosyal aktivitelere birlikte katılın',
          'Entelektüel tartışmalar yapın',
          'Geleceği birlikte planlayın',
          'Alışılmadık aktiviteler deneyin',
        ],
      ),
      'pisces': CompatibilityProfile(
        sign1: 'Koç',
        sign2: 'Balık',
        overallScore: 60,
        romanticScore: 70,
        friendshipScore: 55,
        workScore: 50,
        sexualScore: 75,
        shortDescription: 'Ateş ve su - zıt dünyalar',
        detailedAnalysis: '''
Koç'un cesareti Balık'ın hassasiyetiyle buluştuğunda, ilginç bir dinamik
oluşur. Koruyucu ve korunan ilişkisi gelişebilir.

GÜÇLÜ YÖNLER:
• Koç korur, Balık yumuşatır
• Romantik potansiyel
• Sanatsal ve yaratıcı işbirliği
• Ruhsal ve manevi bağlantı
• Tamamlayıcı güçler

ZORLUKLAR:
• Dünya görüşü farkları
• Koç sert, Balık hassas
• İletişim zorlukları
• Balık kaçışçı, Koç yüzleşmeci
• Pratik konularda uyumsuzluk

BU İLİŞKİYİ ÇALIŞTIRMAK İÇİN:
1. Yumuşaklık ve güç dengesini bulun
2. Sanatsal aktiviteler paylaşın
3. Manevi boyutu keşfedin
4. Koç sabırlı, Balık cesaretli olsun
5. Rüyaları gerçeğe dönüştürün
''',
        tips: [
          'Sanat ve müzik paylaşın',
          'Doğada vakit geçirin',
          'Birbirinin dünyasına girin',
          'Hassasiyete saygı gösterin',
        ],
      ),
    },
    // Diğer burçlar için uyumluluk profilleri eklenecek...
  };
}

// ════════════════════════════════════════════════════════════════════════════
// MODEL SINIFLAR
// ════════════════════════════════════════════════════════════════════════════

class AspectTypeInfo {
  final String name;
  final String symbol;
  final int degrees;
  final int orb;
  final String nature;
  final String description;

  const AspectTypeInfo({
    required this.name,
    required this.symbol,
    required this.degrees,
    required this.orb,
    required this.nature,
    required this.description,
  });
}

class SynastryAspectInterpretation {
  final String planet1;
  final String planet2;
  final String aspect;
  final String theme;
  final int attraction; // 1-5
  final int harmony; // 1-5
  final int growth; // 1-5
  final int challenge; // 1-5
  final String interpretation;
  final String advice;

  const SynastryAspectInterpretation({
    required this.planet1,
    required this.planet2,
    required this.aspect,
    required this.theme,
    required this.attraction,
    required this.harmony,
    required this.growth,
    required this.challenge,
    required this.interpretation,
    required this.advice,
  });
}

class HouseOverlayContent {
  final int house;
  final String theme;
  final Map<String, String> planetsInPartnerHouse;

  const HouseOverlayContent({
    required this.house,
    required this.theme,
    required this.planetsInPartnerHouse,
  });
}

class CompositeHouseContent {
  final int house;
  final String theme;
  final String sunInterpretation;
  final String moonInterpretation;

  const CompositeHouseContent({
    required this.house,
    required this.theme,
    required this.sunInterpretation,
    required this.moonInterpretation,
  });
}

class CompatibilityProfile {
  final String sign1;
  final String sign2;
  final int overallScore;
  final int romanticScore;
  final int friendshipScore;
  final int workScore;
  final int sexualScore;
  final String shortDescription;
  final String detailedAnalysis;
  final List<String> tips;

  const CompatibilityProfile({
    required this.sign1,
    required this.sign2,
    required this.overallScore,
    required this.romanticScore,
    required this.friendshipScore,
    required this.workScore,
    required this.sexualScore,
    required this.shortDescription,
    required this.detailedAnalysis,
    required this.tips,
  });
}
