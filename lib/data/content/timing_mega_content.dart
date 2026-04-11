/// Timing & Electional Astrology Mega Content
/// En uygun zamanı seçme sanatı - Elektional Astroloji
library;

// ════════════════════════════════════════════════════════════════════════════
// ELEKTİONAL ASTROLOJİ TEMELLERİ
// ════════════════════════════════════════════════════════════════════════════

class ElectionalAstrologyBasics {
  static const String introduction = '''
Elektional astroloji (seçim astrolojisi), önemli girişimler için en uygun
zamanı seçme sanatıdır. Evlilik, iş kurma, ameliyat, seyahat, sözleşme
imzalama gibi önemli olaylar için kozmik desteği maksimize eder.

Temel prensip basittir: Her anın kendine özgü bir astrolojik imzası vardır.
Bu imza, o anda başlayan her şeyin "doğum haritası"dır. Doğru zamanı seçerek,
girişiminize en iyi başlangıcı verebilirsiniz.
''';

  static const Map<String, ElectionalRule> fundamentalRules = {
    'moon_application': ElectionalRule(
      name: 'Ay\'ın Aplikasyonu',
      importance: 'Kritik',
      description: '''
Ay'ın hangi gezegenlere aspekt yaptığı, girişimin geleceğini gösterir.

ALTIN KURAL:
Ay'ın son yaptığı aspekt girişimin sonucunu gösterir.
- Jüpiter veya Venüs'e aspekt: Başarı ve bereket
- Mars veya Satürn'e aspekt: Zorluklar ve engeller
- Güneş'e aspekt: Görünürlük ve tanınma

Ay'ın void of course (boşlukta) olmadığından emin olun!
Boşluktaki Ay = Hiçbir şey gerçekleşmez.
''',
      tips: [
        'Ay\'nın son aspektini kontrol et',
        'Void of course dönemlerinden kaçın',
        'Ay\'ın faydalı gezegenlere aspekt yapmasını bekle',
      ],
    ),
    'rising_sign': ElectionalRule(
      name: 'Yükselen Burç Seçimi',
      importance: 'Çok Önemli',
      description: '''
Girişimin yükseleni, girişimin "yüzü"dür. Doğru yükselen seçimi kritiktir.

EV VE YÜKSELENLERİ:
• Mali işler için: Boğa, Terazi, Yay yükseleni
• İletişim işleri için: İkizler, Başak, Kova yükseleni
• Liderlik ve güç için: Aslan, Koç, Akrep yükseleni
• Yaratıcı projeler için: Aslan, Balık, Terazi yükseleni
• Sağlık işleri için: Başak, Koç, Oğlak yükseleni
• Spiritüel konular için: Balık, Yengeç, Akrep yükseleni

1. VE 7. EV YÖNETICILERINI KONTROL ET:
Her iki ev yöneticisi de güçlü ve olumlu olmalı.
''',
      tips: [
        'İşin doğasına uygun yükselen seç',
        '1. ve 7. ev yöneticileri güçlü olsun',
        'Kötü gezegenleri (Mars, Satürn) açılardan uzak tut',
      ],
    ),
    'planetary_hours': ElectionalRule(
      name: 'Gezegen Saatleri',
      importance: 'Önemli',
      description: '''
Her saat belirli bir gezegen tarafından yönetilir. İşin doğasına
uygun gezegen saatini seçmek önemlidir.

GEZEGEN SAATLERİ:
☉ Güneş saati: Liderlik, terfi, tanınma, sağlık, otorite
☽ Ay saati: Ev, aile, seyahat, kadın işleri, kamuoyu
♂ Mars saati: Cerrahi, rekabet, atletik etkinlik, savaş
☿ Merkür saati: İletişim, yazı, sözleşmeler, seyahat, öğrenme
♃ Jüpiter saati: Hukuki işler, eğitim, din, yayıncılık, şans
♀ Venüs saati: Aşk, evlilik, sanat, güzellik, sosyal etkinlik
♄ Satürn saati: Emlak, yaşlılar, disiplin (dikkatli kullan!)

GÜNLER VE GEZEGENLER:
Pazar = Güneş, Pazartesi = Ay, Salı = Mars, Çarşamba = Merkür
Perşembe = Jüpiter, Cuma = Venüs, Cumartesi = Satürn
''',
      tips: [
        'İşin doğasına uygun gezegen saatini seç',
        'Gün ve saat gezegenlerini uyumla',
        'Satürn saatinden genel olarak kaçın',
      ],
    ),
    'benefic_aspects': ElectionalRule(
      name: 'Faydalı Aspektler',
      importance: 'Çok Önemli',
      description: '''
Faydalı gezegenler (Jüpiter, Venüs) ve faydalı aspektler
(trigon, sekstil, kavuşum) girişimi destekler.

EN İYİ ASPEKTLER:
• Güneş trigon/sekstil Jüpiter: Başarı ve genişleme
• Ay trigon/sekstil Venüs: Uyum ve sevilme
• Merkür trigon/sekstil Jüpiter: İyi haberler ve fırsatlar
• Venüs kavuşum/trigon Jüpiter: "Büyük Fayda" - en şanslı aspekt

KAÇINILACAK ASPEKTLER:
• Mars kare/karşıt Satürn: Engeller ve gecikmeler
• Güneş kare/karşıt Plüton: Güç savaşları
• Ay kare Mars: Duygusal çatışmalar
''',
      tips: [
        'Faydalı aspektleri maksimize et',
        'Zararlı aspektlerden kaçın',
        'Özellikle Ay\'ın aspektlerine dikkat et',
      ],
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// VOID OF COURSE AY
// ════════════════════════════════════════════════════════════════════════════

class VoidOfCourseMoon {
  static const String explanation = '''
Void of Course (VOC) Ay, Ay'ın mevcut burcundaki son aspektini yaptıktan
sonra, yeni burca geçene kadarki dönemdir. Bu dönemde "hiçbir şey olmaz".

NEGATIF ETKİLERİ:
• Başlanan işler sonuç vermez
• Kararlar değişir veya iptal edilir
• Planlanan şeyler gerçekleşmez
• Randevular iptal olur

POZİTİF KULLANIMI:
• Rutin işler için idealdir (değişiklik istemediğiniz şeyler)
• Meditasyon ve içsel çalışma
• Dinlenme ve yenilenme
• Tamamlanmış işlerin bakımı

VOC SIRASINDA YAPILMAMASI GEREKENLER:
✗ Yeni iş kurmak
✗ Evlilik veya nişan
✗ Sözleşme imzalamak
✗ Önemli alımlar
✗ İş görüşmesi
✗ Yeni ilişki başlatmak
✗ Hukuki işlemler

VOC SIRASINDA YAPILABİLECEKLER:
✓ Rutin ev işleri
✓ Meditasyon
✓ Kitap okuma
✓ Hobi aktiviteleri
✓ Uyku ve dinlenme
✓ Değişiklik istemediğiniz rutinler
''';

  static const Map<String, VocSignEffect> vocBySign = {
    'aries': VocSignEffect(
      sign: 'Koç',
      duration: 'Ortalama 2-3 saat',
      effect: 'Enerjik ama sonuçsuz eylemler',
      advice: 'Fiziksel aktivite için iyi, yeni başlangıçlar için değil',
    ),
    'taurus': VocSignEffect(
      sign: 'Boğa',
      duration: 'Ortalama 2.5 gün',
      effect: 'Yavaşlama ve gecikme',
      advice: 'Dinlenme ve keyif için ideal, mali kararlar için değil',
    ),
    'gemini': VocSignEffect(
      sign: 'İkizler',
      duration: 'Ortalama 2-3 saat',
      effect: 'Dağınık düşünceler, yarım kalan iletişim',
      advice: 'Hafif okuma için iyi, önemli konuşmalar için değil',
    ),
    'cancer': VocSignEffect(
      sign: 'Yengeç',
      duration: 'Ortalama 2.5 gün',
      effect: 'Duygusal belirsizlik',
      advice: 'Ev temizliği için iyi, aile kararları için değil',
    ),
    'leo': VocSignEffect(
      sign: 'Aslan',
      duration: 'Ortalama 2-3 saat',
      effect: 'Yaratıcı enerji ama takdir yok',
      advice: 'Hobi için iyi, tanınma bekleyen işler için değil',
    ),
    'virgo': VocSignEffect(
      sign: 'Başak',
      duration: 'Ortalama 2.5 gün',
      effect: 'Detaylara takılma, mükemmeliyetçilik',
      advice: 'Organize etmek için iyi, sağlık kararları için değil',
    ),
    'libra': VocSignEffect(
      sign: 'Terazi',
      duration: 'Ortalama 2-3 saat',
      effect: 'Karar verememe',
      advice: 'Sanat ve güzellik için iyi, ortaklık kararları için değil',
    ),
    'scorpio': VocSignEffect(
      sign: 'Akrep',
      duration: 'Ortalama 2.5 gün',
      effect: 'Derin ama sonuçsuz araştırma',
      advice: 'Meditasyon için ideal, finansal işler için değil',
    ),
    'sagittarius': VocSignEffect(
      sign: 'Yay',
      duration: 'Ortalama 2-3 saat',
      effect: 'Abartılı planlar, gerçekleşmeyen vaatler',
      advice: 'Felsefe ve öğrenme için iyi, seyahat planları için değil',
    ),
    'capricorn': VocSignEffect(
      sign: 'Oğlak',
      duration: 'Ortalama 2.5 gün',
      effect: 'Kariyer engelleri',
      advice: 'Planlama için iyi, iş kararları için değil',
    ),
    'aquarius': VocSignEffect(
      sign: 'Kova',
      duration: 'Ortalama 2-3 saat',
      effect: 'Beklenmedik değişiklikler iptal olur',
      advice: 'Sosyal medya için iyi, inovasyon için değil',
    ),
    'pisces': VocSignEffect(
      sign: 'Balık',
      duration: 'Ortalama 2.5 gün',
      effect: 'Karmaşa ve belirsizlik',
      advice: 'Rüya ve meditasyon için ideal, önemli kararlar için değil',
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// SPESIFIK ETKİNLİKLER İÇİN ZAMANLAMA
// ════════════════════════════════════════════════════════════════════════════

class EventTimingGuides {
  /// Evlilik için en iyi zamanlar
  static const TimingGuide marriageTiming = TimingGuide(
    event: 'Evlilik',
    icon: '💒',
    importance: '''
Evlilik, hayatın en önemli kararlarından biridir. Düğün tarihi seçimi,
evliliğin "doğum haritasını" belirler. Dikkatli seçim kritiktir.
''',
    idealConditions: [
      'Venüs güçlü ve olumlu aspektli olmalı',
      'Ay büyüyen fazda olmalı (Yeni Ay\'dan Dolunay\'a)',
      'Ay faydalı burçlarda: Boğa, Yengeç, Terazi, Balık',
      '7. ev ve yöneticisi güçlü olmalı',
      'Satürn ve Mars 1. ve 7. evlerden uzak olmalı',
      'Ay void of course olmamalı',
      'Merkür retrosu döneminden kaçının',
      'Venüs retrosu döneminden kaçınmanız önerilir',
    ],
    avoidConditions: [
      'Ay azalan fazda (Dolunay\'dan Yeni Ay\'a) - birliktelik azalır',
      'Ay Koç, Akrep veya Oğlak\'ta - çatışma ve zorluk',
      'Venüs yanık (Güneş\'e çok yakın)',
      'Mars 7. evde veya 7. ev yöneticisine kare/karşıt',
      'Satürn 1. veya 7. evde',
      'Ay son aspektini Mars veya Satürn\'e yapıyor',
      'Tutulma dönemleri (2 hafta öncesi/sonrası)',
    ],
    bestMonths: 'Haziran (İkizler/Yengeç), Eylül (Başak/Terazi)',
    bestDays: 'Cuma (Venüs günü) veya Perşembe (Jüpiter günü)',
    additionalTips: '''
EVLİLİK İÇİN ÖZEL KURALLAR:

1. VENÜS KRİTİKTİR:
   Venüs güçlü, görünür ve olumlu aspektli olmalı. Venüs retrosu
   veya yanık Venüs döneminde evlenmeyin!

2. AY FAZI:
   Büyüyen Ay evliliğin büyümesini sembolize eder.
   İlk dördünden Dolunay'a kadar en ideal dönemdir.

3. 7. EV:
   Evlilik evi. Boş veya faydalı gezegenle dolu olmalı.
   Mars veya Satürn'ü buradan uzak tutun.

4. YÜKSELEN BURÇ:
   Terazi (ilişki burcu) veya Boğa (Venüs yönetiminde) ideal.
   Akrep, Oğlak veya Koç yükselenden kaçının.

5. KARŞILIKLI RESEPSİYON:
   Venüs ve Ay arasında olumlu bağlantı (trigon/sekstil)
   duygusal uyum ve sevgi akışı sağlar.
''',
  );

  /// İş kurma için en iyi zamanlar
  static const TimingGuide businessStartTiming = TimingGuide(
    event: 'İş Kurma',
    icon: '🏢',
    importance: '''
Bir işin kuruluş tarihi, şirketin "doğum haritası"dır. Bu harita işin
karakterini, zorluklarını ve potansiyelini belirler. Resmi tescil tarihi
veya ilk ticari faaliyet tarihi dikkate alınır.
''',
    idealConditions: [
      'Jüpiter güçlü ve olumlu aspektli - genişleme ve şans',
      'Güneş güçlü - liderlik ve görünürlük',
      '10. ev (kariyer) ve yöneticisi güçlü',
      '2. ev (para) ve yöneticisi olumlu',
      'Merkür güçlü ve direkt - iletişim ve sözleşmeler',
      'Ay büyüyen fazda ve faydalı burçta',
      'Satürn aspektlerden uzak (gecikme)',
    ],
    avoidConditions: [
      'Merkür retrosu - sözleşmeler ve iletişim sorunlu',
      'Mars retrosu - enerji ve aksiyon engellenir',
      'Jüpiter retrosu - büyüme yavaşlar',
      'Ay void of course - iş sonuç vermez',
      'Tutulma dönemleri - istikrarsızlık',
      'Satürn 1. veya 10. evde - engeller ve gecikmeler',
    ],
    bestMonths: 'Yay sezonu (Kasım-Aralık) veya Koç sezonu (Mart-Nisan)',
    bestDays: 'Perşembe (Jüpiter) veya Pazar (Güneş)',
    additionalTips: '''
İŞ KURMA İÇİN ÖZEL KURALLAR:

1. İŞİN TÜRÜNE GÖRE YÜKSELEN:
   • Finans/bankacılık: Boğa veya Oğlak
   • Teknoloji: Kova veya İkizler
   • Sağlık: Başak veya Akrep
   • Yaratıcı: Aslan veya Balık
   • Hukuk/eğitim: Yay veya Terazi
   • Emlak: Yengeç veya Boğa

2. GEZEGEN SAATLERİ:
   • Genel iş: Jüpiter veya Güneş saati
   • İletişim işleri: Merkür saati
   • Sanat/güzellik: Venüs saati
   • Sanayi/teknoloji: Mars saati (dikkatli)

3. AY POZİSYONU:
   Ay'ın 2. (para), 6. (çalışanlar), 10. (kariyer) evlerdeki
   konumu önemlidir. Faydalı aspektler arayın.

4. ORTAKLIK İŞİ İSE:
   7. ev ve yöneticisi de güçlü olmalı.
   Venüs-Jüpiter aspekti ortaklık için idealdir.
''',
  );

  /// Ameliyat için en iyi zamanlar
  static const TimingGuide surgeryTiming = TimingGuide(
    event: 'Ameliyat',
    icon: '🏥',
    importance: '''
Elektif (planlanabilir) ameliyatlar için doğru zamanlama, iyileşmeyi
hızlandırabilir ve komplikasyonları azaltabilir. Acil ameliyatlar
bu kurallara tabi değildir.
''',
    idealConditions: [
      'Ay azalan fazda (Dolunay\'dan Yeni Ay\'a) - kanama riski azalır',
      'Ay ameliyat yapılacak organın burcu dışında',
      'Mars güçlü ama 1. ve 6. evlerden uzak',
      'Ay Satürn\'e aspekt yapmıyor',
      'Cerrahın natal Mars\'ı ile uyumlu transit',
    ],
    avoidConditions: [
      'Ay büyüyen fazda - şişme ve kanama artabilir',
      'Ay ameliyat organının burcunda (aşağıdaki listeye bak)',
      'Mars 1. evde - kazalar ve komplikasyonlar',
      'Mars retrosu - cerrahi hatalar',
      'Ay void of course - sonuçsuz müdahale',
    ],
    bestMonths: 'Ameliyat türüne göre değişir',
    bestDays: 'Cumartesi (Satürn - disiplin) veya Salı (Mars - cerrahi)',
    additionalTips: '''
AMELİYAT İÇİN ORGAN-BURÇ İLİŞKİSİ:

⛔ Ay bu burçlardayken o organı ameliyat ETMEYİN:

♈ Koç: Baş, yüz, göz, beyin ameliyatları
♉ Boğa: Boğaz, boyun, tiroid ameliyatları
♊ İkizler: Omuz, kol, el, akciğer ameliyatları
♋ Yengeç: Mide, göğüs, uterus ameliyatları
♌ Aslan: Kalp, omurga, sırt ameliyatları
♍ Başak: Bağırsak, pankreas, dalak ameliyatları
♎ Terazi: Böbrek, mesane ameliyatları
♏ Akrep: Üreme organları, rektum ameliyatları
♐ Yay: Kalça, uyluk, karaciğer ameliyatları
♑ Oğlak: Diz, kemik, eklem ameliyatları
♒ Kova: Ayak bileği, baldır, damar ameliyatları
♓ Balık: Ayak, lenf sistemi ameliyatları

EK KURALLAR:
• Dolunay civarı (2 gün öncesi/sonrası) kaçının - maksimum sıvı
• Mars-Satürn kare/karşıt aspektinden kaçının
• Cerrahın iyi bir gün geçirmesi de önemli!
''',
  );

  /// Sözleşme imzalama için en iyi zamanlar
  static const TimingGuide contractTiming = TimingGuide(
    event: 'Sözleşme İmzalama',
    icon: '📝',
    importance: '''
Sözleşme ve anlaşmalar Merkür'ün alanıdır. Hukuki belgeler, iş anlaşmaları
ve yazılı taahhütler için Merkür'ün durumu kritiktir.
''',
    idealConditions: [
      'Merkür direkt ve güçlü burçta (İkizler, Başak, Kova)',
      'Merkür faydalı aspektli (Jüpiter trigon ideal)',
      'Ay büyüyen fazda',
      '3. ve 9. evler (iletişim ve hukuk) güçlü',
      'Satürn olumlu aspektli (bağlayıcılık)',
    ],
    avoidConditions: [
      'Merkür retrosu - yanlış anlaşılmalar, değişiklikler',
      'Merkür yanık (Güneş\'e 8° içinde) - görünmezlik',
      'Ay void of course - sözleşme sonuçsuz',
      'Neptün aspektleri - aldatma veya karmaşa',
      'Mars-Merkür kare - tartışmalar',
    ],
    bestMonths: 'İkizler veya Başak sezonu',
    bestDays: 'Çarşamba (Merkür günü)',
    additionalTips: '''
SÖZLEŞME İÇİN EK KURALLAR:

1. MERKÜR RETROSUNDAKİ SÖZLEŞMELER:
   Retroda imzalanması gereken sözleşmeler varsa:
   • Her şeyi iki kez kontrol edin
   • Belirsiz maddeler netleştirin
   • Revizyon beklentisi ile imzalayın
   • Mümkünse 3 gün sonrasına erteleyin

2. UZUN VADELİ SÖZLEŞMELER:
   • Satürn olumlu olmalı (bağlayıcılık)
   • 10. ev güçlü (profesyonellik)
   • Jüpiter desteği (büyüme)

3. ORTAKLIK SÖZLEŞMELERİ:
   • 7. ev ve yöneticisi güçlü
   • Venüs olumlu (uyum)
   • Mars-Satürn çatışması YOK

4. TİCARİ SÖZLEŞMELER:
   • 2. ve 8. evler (para akışı) olumlu
   • Jüpiter 2. veya 8. evde ideal
''',
  );

  /// Seyahat için en iyi zamanlar
  static const TimingGuide travelTiming = TimingGuide(
    event: 'Seyahat',
    icon: '✈️',
    importance: '''
Seyahat zamanlaması hem güvenlik hem de keyif açısından önemlidir.
Kısa yolculuklar 3. ev, uzun yolculuklar 9. ev ile ilişkilidir.
''',
    idealConditions: [
      'Merkür direkt (özellikle uçak seyahati)',
      '3. ev (kısa) veya 9. ev (uzun) güçlü',
      'Ay Yay veya İkizler\'de (seyahat burçları)',
      'Jüpiter olumlu aspektli (şans ve koruma)',
      'Mars sakin (kazaları önler)',
    ],
    avoidConditions: [
      'Merkür retrosu - gecikmeler, kayıplar, hatalar',
      'Mars 3. veya 9. evde - kazalar',
      'Ay void of course - seyahat amacı gerçekleşmez',
      'Mars-Uranüs aspekti - ani kazalar',
      'Tutulma dönemleri - kaos ve değişiklikler',
    ],
    bestMonths: 'Yay sezonu (macera) veya İkizler sezonu (hareket)',
    bestDays: 'Çarşamba (Merkür) veya Perşembe (Jüpiter)',
    additionalTips: '''
SEYAHAT ZAMANLAMA EK KURALLARI:

1. UÇAK YOLCULUĞU:
   • Merkür direkt olması önerilir
   • Uranüs sakin (teknik arızalar)
   • Ay hava elementinde (İkizler, Terazi, Kova) idealdir

2. ARABA YOLCULUĞU:
   • Mars sakin ve olumlu
   • Ay Koç'ta değil (acelecilik)
   • Satürn-Mars çatışması yok

3. DENİZ YOLCULUĞU:
   • Ay su burcunda iyi (Yengeç, Akrep, Balık)
   • Neptün olumlu aspektli
   • Dolunay etrafında dikkatli (dalgalar)

4. İŞ SEYAHATİ:
   • 10. ev güçlü
   • Güneş olumlu (başarı)
   • Merkür-Jüpiter aspekti (fırsatlar)

5. TATİL SEYAHATİ:
   • Venüs olumlu (keyif)
   • 5. ev destekli (eğlence)
   • Ay büyüyen fazda (enerji)
''',
  );

  /// Para işleri için en iyi zamanlar
  static const TimingGuide financialTiming = TimingGuide(
    event: 'Finansal İşlemler',
    icon: '💰',
    importance: '''
Para kazanma, harcama, yatırım ve borçlanma gibi finansal işlemler için
2. ev (kişisel para) ve 8. ev (ortak para, yatırım) kritiktir.
''',
    idealConditions: [
      'Jüpiter güçlü ve olumlu (bolluk)',
      '2. ev ve yöneticisi güçlü (gelir)',
      'Venüs olumlu (değer ve çekim)',
      'Ay Boğa\'da (finansal istikrar)',
      'Güneş-Jüpiter aspekti (başarı)',
    ],
    avoidConditions: [
      'Merkür retrosu - hatalar ve yanlış anlaşılmalar',
      'Neptün aspektleri - aldatma veya karmaşa',
      'Satürn 2. evde - kısıtlamalar',
      'Mars 2. veya 8. evde - ani kayıplar',
      'Ay void of course - işlem sonuçsuz',
    ],
    bestMonths: 'Boğa sezonu veya Yay sezonu',
    bestDays: 'Perşembe (Jüpiter) veya Cuma (Venüs)',
    additionalTips: '''
FİNANSAL İŞLEMLER İÇİN DETAYLAR:

1. YATIRIM YAPMA:
   • Jüpiter güçlü ve direkt
   • 8. ev ve yöneticisi olumlu
   • Plüton sakin (büyük dalgalanmalar yok)
   • Ay büyüyen fazda (büyüme)

2. BORÇ ALMA:
   • 8. ev güçlü
   • Satürn olumlu (ödeme kapasitesi)
   • Mars sakin (çatışma yok)
   • Ay Boğa veya Oğlak'ta (sorumluluk)

3. MAAŞ PAZARLIĞI:
   • Güneş güçlü (özgüven)
   • Mars olumlu (iddialılık)
   • Jüpiter 2. veya 10. evde
   • Merkür direkt (iletişim)

4. BÜYÜK ALIMLAR:
   • Venüs güçlü ve direkt
   • Ay büyüyen fazda
   • Satürn olumlu (kalıcılık)
   • Merkür direkt (sözleşme)

5. SATIŞLAR:
   • Merkür güçlü (pazarlık)
   • 7. ev olumlu (alıcılar)
   • Mars hafif aktif (motivasyon)
''',
  );
}

// ════════════════════════════════════════════════════════════════════════════
// GEZEGEN SAATLERİ HESAPLAMA
// ════════════════════════════════════════════════════════════════════════════

class PlanetaryHours {
  static const String explanation = '''
Gezegen saatleri, gün doğumundan gün batımına (gündüz) ve gün batımından
gün doğumuna (gece) 12'şer eşit parçaya bölünerek hesaplanır.

Her saatin uzunluğu mevsime göre değişir:
• Yaz: Gündüz saatleri uzun, gece saatleri kısa
• Kış: Gece saatleri uzun, gündüz saatleri kısa
• Ekinoks: Tüm saatler eşit (60 dakika)

İLK SAAT KURALI:
Gün doğumundaki ilk saat, o günün yönetici gezegenine aittir.
Pazar = Güneş, Pazartesi = Ay, Salı = Mars, vb.
''';

  static const List<String> chaldeanOrder = [
    'Satürn', // En yavaş
    'Jüpiter',
    'Mars',
    'Güneş',
    'Venüs',
    'Merkür',
    'Ay', // En hızlı
  ];

  static const Map<String, DayPlanetarySequence> dailySequences = {
    'sunday': DayPlanetarySequence(
      day: 'Pazar',
      ruler: 'Güneş',
      dayHours: [
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
      ],
      nightHours: [
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
      ],
    ),
    'monday': DayPlanetarySequence(
      day: 'Pazartesi',
      ruler: 'Ay',
      dayHours: [
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
      ],
      nightHours: [
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
      ],
    ),
    'tuesday': DayPlanetarySequence(
      day: 'Salı',
      ruler: 'Mars',
      dayHours: [
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
      ],
      nightHours: [
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
      ],
    ),
    'wednesday': DayPlanetarySequence(
      day: 'Çarşamba',
      ruler: 'Merkür',
      dayHours: [
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
      ],
      nightHours: [
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
      ],
    ),
    'thursday': DayPlanetarySequence(
      day: 'Perşembe',
      ruler: 'Jüpiter',
      dayHours: [
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
      ],
      nightHours: [
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
      ],
    ),
    'friday': DayPlanetarySequence(
      day: 'Cuma',
      ruler: 'Venüs',
      dayHours: [
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
      ],
      nightHours: [
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
      ],
    ),
    'saturday': DayPlanetarySequence(
      day: 'Cumartesi',
      ruler: 'Satürn',
      dayHours: [
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
      ],
      nightHours: [
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
        'Güneş',
        'Venüs',
        'Merkür',
        'Ay',
        'Satürn',
        'Jüpiter',
        'Mars',
      ],
    ),
  };

  /// Her gezegen saatinin uygun aktiviteleri
  static const Map<String, PlanetaryHourActivities> hourActivities = {
    'sun': PlanetaryHourActivities(
      planet: 'Güneş',
      symbol: '☉',
      color: 'Altın',
      activities: [
        'Liderlik görevleri',
        'Terfi ve tanınma işleri',
        'Otorite figürleriyle görüşme',
        'Sağlık ve vitalite işleri',
        'Yaratıcı projeler başlatma',
        'Karizmatik sunumlar',
      ],
      avoid: ['Gizli işler', 'Alçakgönüllülük gerektiren durumlar'],
    ),
    'moon': PlanetaryHourActivities(
      planet: 'Ay',
      symbol: '☽',
      color: 'Gümüş',
      activities: [
        'Ev ve aile işleri',
        'Kadınlarla ilgili işler',
        'Kamuoyuna açıklama',
        'Seyahat (özellikle deniz)',
        'Sezgisel kararlar',
        'Çocuk bakımı',
      ],
      avoid: ['Uzun vadeli planlar', 'Riskli girişimler'],
    ),
    'mars': PlanetaryHourActivities(
      planet: 'Mars',
      symbol: '♂',
      color: 'Kırmızı',
      activities: [
        'Fiziksel aktiviteler',
        'Cerrahi müdahaleler',
        'Rekabetçi işler',
        'Yeni başlangıçlar (dikkatli)',
        'Savunma ve koruma',
        'Mekanik işler',
      ],
      avoid: [
        'Diplomatik görüşmeler',
        'Hassas müzakereler',
        'Yangınla ilgili aktiviteler',
      ],
    ),
    'mercury': PlanetaryHourActivities(
      planet: 'Merkür',
      symbol: '☿',
      color: 'Sarı',
      activities: [
        'Yazışmalar ve iletişim',
        'Sözleşme görüşmeleri',
        'Eğitim ve öğrenme',
        'Kısa yolculuklar',
        'Ticaret ve satış',
        'Teknoloji işleri',
      ],
      avoid: ['Uzun vadeli kararlar', 'Duygusal konuşmalar'],
    ),
    'jupiter': PlanetaryHourActivities(
      planet: 'Jüpiter',
      symbol: '♃',
      color: 'Mor',
      activities: [
        'Hukuki işlemler',
        'Eğitim ve akademi',
        'Yayıncılık',
        'Din ve felsefe',
        'Uzun yolculuklar',
        'Banka işleri',
        'Genişleme planları',
      ],
      avoid: ['Detay işleri', 'Kısıtlama gerektiren konular'],
    ),
    'venus': PlanetaryHourActivities(
      planet: 'Venüs',
      symbol: '♀',
      color: 'Pembe',
      activities: [
        'Aşk ve romantizm',
        'Evlilik ve nişan',
        'Sanat ve güzellik',
        'Moda ve estetik',
        'Sosyal etkinlikler',
        'Para kazanma',
        'Barış ve uzlaşma',
      ],
      avoid: ['Savaş ve rekabet', 'Cerrahi müdahaleler'],
    ),
    'saturn': PlanetaryHourActivities(
      planet: 'Satürn',
      symbol: '♄',
      color: 'Siyah',
      activities: [
        'Emlak işleri',
        'Yaşlılarla görüşme',
        'Uzun vadeli planlama',
        'Disiplin gerektiren işler',
        'Yapısal düzenlemeler',
        'Tarımsal işler',
      ],
      avoid: [
        'Yeni başlangıçlar',
        'Risk alma',
        'Eğlence ve şenlik',
        'Hızlı kararlar',
      ],
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// RETRO DÖNEMLERI
// ════════════════════════════════════════════════════════════════════════════

class RetrogradePeriods {
  static const Map<String, RetrogradeGuide> guides = {
    'mercury': RetrogradeGuide(
      planet: 'Merkür',
      frequency: 'Yılda 3-4 kez',
      duration: '3 hafta',
      shadow: 'Öncesi 2 hafta, sonrası 2 hafta',
      themes: [
        'İletişim',
        'Teknoloji',
        'Seyahat',
        'Sözleşmeler',
        'Kardeşler',
        'Kısa yolculuklar',
      ],
      effects: '''
Merkür retrosu en sık yaşanan ve en bilinen retro dönemdir.
İletişim, teknoloji ve seyahatte aksaklıklar yaşanır.

TİPİK SENARYOLAR:
• E-postalar kaybolur veya yanlış kişiye gider
• Telefonlar bozulur, yanlış numaralar aranır
• Uçaklar rötar yapar, bagajlar kaybolur
• Sözleşmelerde hatalar çıkar
• Eski arkadaşlar, eski sevgililer ortaya çıkar

POZİTİF KULLANIM:
• Geçmişi gözden geçir
• Yarım kalan projeleri tamamla
• Eski dostlara ulaş
• Yedekleme yap
• Detayları kontrol et
''',
      doList: [
        'İki kez kontrol et',
        'Yedekleme yap',
        'Eski projeleri bitir',
        'Geçmişi gözden geçir',
        'Esnek planlar yap',
      ],
      dontList: [
        'Yeni sözleşmeler imzalama',
        'Yeni teknoloji satın alma',
        'Önemli seyahatler planlama',
        'Yeni projeler başlatma',
        'Büyük kararlar verme',
      ],
    ),
    'venus': RetrogradeGuide(
      planet: 'Venüs',
      frequency: '18 ayda bir',
      duration: '6 hafta',
      shadow: 'Öncesi 2 hafta, sonrası 2 hafta',
      themes: ['Aşk', 'İlişkiler', 'Para', 'Değerler', 'Güzellik', 'Sanat'],
      effects: '''
Venüs retrosu aşk, para ve değerler konusunda yeniden değerlendirme zamanıdır.

TİPİK SENARYOLAR:
• Eski aşklar geri döner
• Mevcut ilişkiler sorgulanır
• Finansal durumlar yeniden değerlendirilir
• Estetik zevkler değişir
• Değerler sorgulanır

POZİTİF KULLANIM:
• İlişkileri yeniden değerlendir
• Gerçek değerlerini keşfet
• Sanat ve yaratıcılıkla ilgilen
• Öz-sevgi çalışmaları yap
''',
      doList: [
        'İlişkileri gözden geçir',
        'Değerlerini sorgula',
        'Sanatla uğraş',
        'Öz-bakım yap',
        'Geçmiş ilişkilerden ders çıkar',
      ],
      dontList: [
        'Yeni ilişki başlatma',
        'Evlenme',
        'Büyük alışverişler',
        'Estetik operasyonlar',
        'Yeni iş ortaklıkları',
      ],
    ),
    'mars': RetrogradeGuide(
      planet: 'Mars',
      frequency: '2 yılda bir',
      duration: '2.5 ay',
      shadow: 'Öncesi 2 hafta, sonrası 3 hafta',
      themes: ['Eylem', 'Enerji', 'Öfke', 'Motivasyon', 'Seks', 'Rekabet'],
      effects: '''
Mars retrosu enerji ve eylem konusunda içe dönüş zamanıdır.

TİPİK SENARYOLAR:
• Yorgunluk ve motivasyon düşüklüğü
• Bastırılmış öfke yüzeye çıkar
• Cinsel enerji değişir
• Fiziksel aktivitede azalma
• Eski rekabetler tekrar canlanır

POZİTİF KULLANIM:
• Strateji geliştir
• Enerji biriktir
• Öfke yönetimi öğren
• Sabır pratik yap
''',
      doList: [
        'Dinlen ve şarj ol',
        'Strateji geliştir',
        'Sabırlı ol',
        'Eski projeleri tamamla',
        'Yoga ve meditasyon',
      ],
      dontList: [
        'Yeni savaşlar başlatma',
        'Riskli sporlar',
        'Öfkeyle hareket etme',
        'Cerrahi müdahaleler (elektif)',
        'Yeni rekabetlere girme',
      ],
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// MODEL SINIFLAR
// ════════════════════════════════════════════════════════════════════════════

class ElectionalRule {
  final String name;
  final String importance;
  final String description;
  final List<String> tips;

  const ElectionalRule({
    required this.name,
    required this.importance,
    required this.description,
    required this.tips,
  });
}

class VocSignEffect {
  final String sign;
  final String duration;
  final String effect;
  final String advice;

  const VocSignEffect({
    required this.sign,
    required this.duration,
    required this.effect,
    required this.advice,
  });
}

class TimingGuide {
  final String event;
  final String icon;
  final String importance;
  final List<String> idealConditions;
  final List<String> avoidConditions;
  final String bestMonths;
  final String bestDays;
  final String additionalTips;

  const TimingGuide({
    required this.event,
    required this.icon,
    required this.importance,
    required this.idealConditions,
    required this.avoidConditions,
    required this.bestMonths,
    required this.bestDays,
    required this.additionalTips,
  });
}

class DayPlanetarySequence {
  final String day;
  final String ruler;
  final List<String> dayHours;
  final List<String> nightHours;

  const DayPlanetarySequence({
    required this.day,
    required this.ruler,
    required this.dayHours,
    required this.nightHours,
  });
}

class PlanetaryHourActivities {
  final String planet;
  final String symbol;
  final String color;
  final List<String> activities;
  final List<String> avoid;

  const PlanetaryHourActivities({
    required this.planet,
    required this.symbol,
    required this.color,
    required this.activities,
    required this.avoid,
  });
}

class RetrogradeGuide {
  final String planet;
  final String frequency;
  final String duration;
  final String shadow;
  final List<String> themes;
  final String effects;
  final List<String> doList;
  final List<String> dontList;

  const RetrogradeGuide({
    required this.planet,
    required this.frequency,
    required this.duration,
    required this.shadow,
    required this.themes,
    required this.effects,
    required this.doList,
    required this.dontList,
  });
}
