/// Engagement-Driven Content Library for Venus One - Part 3
/// Tool Pages: Birth Chart, Tarot, Numerology, Compatibility, Aura, Kabbalah, Transits
library;

// ============================================================
// PAGE: BIRTH CHART (/birth-chart)
// ============================================================

class BirthChartContent {
  // PURPOSE & USER INTENT:
  // - Core tool, primary value proposition
  // - User seeks: self-understanding, cosmic identity
  // - Entry point for deeper exploration

  // COMPETITOR BENCHMARK:
  // - Astro-Seek: Massive data, technical depth
  // - Astro.com: Traditional, trusted, educational
  // - Co-Star: AI-driven personal insights
  // - Gap: Venus One needs more educational context + emotional resonance

  static const String heroTitle = 'Doğum Haritanız — Kozmik Parmak İziniz';

  static const String heroSubtitle =
      'Doğduğunuz anda gökyüzünün fotoğrafı. Potansiyelleriniz, eğilimleriniz ve yaşam temalarınız — hepsi bu haritada.';

  static const String introSection = '''
Doğum haritası (natal chart), astrolojinin temel taşıdır. Doğduğunuz an, belirli bir coğrafi konumdan gökyüzüne bakıldığında görülen gezegen dizilimi, sizin benzersiz kozmik imzanızdır.

**Haritanız Neden Benzersiz?**
Dünya üzerinde aynı anda, aynı yerde doğmamış hiç kimsenin haritası sizinkiyle aynı değildir. Her dakika, gökyüzü değişir. Bu yüzden ikizler bile farklı haritalar taşıyabilir.

**Ne Söyler, Ne Söylemez?**
Doğum haritası kesin bir kader çizmez. Size "şu olacak" demez. Bunun yerine, enerjileri, eğilimleri ve potansiyelleri gösterir. Haritayı nasıl yaşadığınız, sizin seçimlerinize bağlıdır.
''';

  static const String whatYouWillFindSection = '''
## Haritanızda Neler Var?

**Güneş Burcu — Özünüz**
En çok bilinen unsur. Temel kimliğiniz, yaşam enerjiniz, "ben" kavramınız. Güneş, ruhunuzun ışığıdır.

**Ay Burcu — İç Dünyanız**
Duygusal doğanız, içgüdüsel tepkileriniz, bakım alma ve verme şekliniz. Ay, bilinçaltınızın aynasıdır.

**Yükselen Burç (Ascendant) — Dış Görünümünüz**
Dünyaya nasıl görünürsünüz, ilk izleniminiz, fiziksel enerjiniz. Doğu ufkundaki burç.

**10 Gezegen**
Güneş ve Ay dahil, her gezegen farklı bir yaşam alanını temsil eder:
- Merkür: İletişim, düşünce
- Venüs: Aşk, güzellik, değerler
- Mars: Enerji, tutku, irade
- Jüpiter: Genişleme, şans, felsefe
- Satürn: Yapı, disiplin, sınırlar
- Uranüs: Yenilik, devrim, özgünlük
- Neptün: Rüyalar, sezgi, mistisizm
- Pluto: Dönüşüm, güç, yeniden doğuş

**12 Ev (House)**
Hayatın 12 farklı alanı:
1. Ev: Kimlik, beden
2. Ev: Para, değerler
3. Ev: İletişim, kardeşler
4. Ev: Ev, aile, kökler
5. Ev: Yaratıcılık, aşk, çocuklar
6. Ev: Sağlık, günlük rutinler
7. Ev: İlişkiler, ortaklıklar
8. Ev: Dönüşüm, paylaşılan kaynaklar
9. Ev: Felsefe, seyahat, yüksek öğrenim
10. Ev: Kariyer, toplumsal statü
11. Ev: Arkadaşlık, hedefler, topluluk
12. Ev: Bilinçaltı, ruhanilik, izolasyon

**Açılar (Aspects)**
Gezegenler arası geometrik ilişkiler:
- Kavuşum (0°): Birleşme, yoğunlaşma
- Karşıt (180°): Gerilim, denge arayışı
- Üçgen (120°): Uyum, akış
- Kare (90°): Meydan okuma, büyüme
- Altmışlık (60°): Fırsat, işbirliği
''';

  static const String methodologySection = '''
## Metodolojimiz

**Swiss Ephemeris**
Hesaplamalarımız, dünyanın en güvenilir astronomi hesaplama kütüphanesi olan Swiss Ephemeris'e dayanır. NASA verileriyle doğrulanmış, saniye hassasiyetinde gezegen pozisyonları.

**Ev Sistemi: Placidus**
En yaygın kullanılan ev hesaplama sistemi. Alternatif olarak Whole Sign, Koch veya Equal House seçebilirsiniz (ayarlardan değiştirilebilir).

**Zodiac Tipi: Tropical**
Batı astrolojisinin standart yaklaşımı. Mevsimsel döngülere dayalı. Vedik (Sidereal) için ayrı bir modülümüz bulunmaktadır.

**Açı Orb'ları**
Major açılar için 8°, minör açılar için 3° tolerans kullanıyoruz. Daha sıkı veya gevşek orb'lar için premium ayarlar mevcuttur.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Kader Haritası Değildir**
Haritanız sizi mahkum etmez. Potansiyeller gösterir, kesinlikler değil. Aynı haritaya sahip iki kişi tamamen farklı hayatlar yaşayabilir.

**Psikolojik Teşhis Değildir**
Astroloji, psikoloji değildir. Haritanızda "depresyon" veya "anksiyete" teşhisi koymuyoruz. Profesyonel destek için uzmanlara başvurun.

**Bilimsel Kanıt Taşımaz**
Astroloji, ampirik bilim değildir. Binlerce yıllık sembolik bir sistemdir. "Kanıtlanmış" iddiasında bulunmuyoruz.

**Tek Boyutlu Değildir**
Sadece Güneş burcunuza bakarak kendinizi tanımlamamalısınız. Harita bir bütündür, parçalar tek başına anlam taşımaz.
''';

  static const String howToReadSection = '''
## Haritanızı Nasıl Okumalı?

**1. Büyük Resimle Başlayın**
Önce Güneş, Ay ve yükselen burcunuza bakın. Bu "üçlü" temel karakterinizi oluşturur.

**2. Element ve Modalite Dengesini İnceleyin**
Haritanızda hangi element (Ateş, Toprak, Hava, Su) ve modalite (Kardinal, Sabit, Değişken) baskın?

**3. Evlerdeki Yoğunlaşmalara Dikkat Edin**
Birden fazla gezegenin toplandığı evler, hayatınızın odak noktalarıdır.

**4. Açıları Değerlendirin**
Gezegenler arası ilişkiler, enerjilerin nasıl etkileştiğini gösterir.

**5. Tek Tek Değil, Birlikte Okuyun**
Her sembol, diğerleriyle bağlam içinde anlam kazanır. Parçaları izole etmeyin.

**6. Zaman İçinde Geri Dönün**
Bir harita, tek oturmada anlaşılmaz. Hayat deneyimlerinizle birlikte derinleşir.
''';

  static const String curiosityHooksSection = '''
## İnsanlar Burada Şunları da Merak Ediyor...

→ "Ay burcum neden Güneş burcumdan farklı hissettiriyor?"
→ "Yükselen burcumu nasıl hesaplarım?"
→ "Haritamda Satürn neden bu kadar vurgulu?"
→ "Partnerimle haritalarımızı karşılaştırabilir miyim?"
→ "Şu anki transitler haritamı nasıl etkiliyor?"
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Doğum saatimi bilmiyorsam ne olur?',
      'answer':
          'Güneş burcu, Ay burcu (yaklaşık) ve gezegen pozisyonları hesaplanabilir. Ancak yükselen burç ve ev yerleşimleri için kesin saat gerekir. Nüfus müdürlüğü veya doğduğunuz hastaneden doğum saatinizi öğrenebilirsiniz.',
    },
    {
      'question': 'Sezaryen doğum haritayı etkiler mi?',
      'answer':
          'Astrolojik görüşler çeşitlidir. Bazıları fiziksel doğum anını, bazıları ilk nefesi esas alır. Pratikte, bebeğin dünyaya geldiği an kullanılır — sezaryen veya normal fark etmez.',
    },
    {
      'question': 'İkizlerin haritası aynı mı?',
      'answer':
          'Dakika farkıyla bile farklı olabilir. Özellikle ev bölümleri ve yükselen derece değişebilir. Ayrıca haritayı nasıl yaşadıkları, bireysel seçimlere bağlıdır.',
    },
    {
      'question': 'Haritamdaki "kötü" açılar ne anlama geliyor?',
      'answer':
          '"Kötü" demek yerine "zorlayıcı" demeyi tercih ediyoruz. Kare ve karşıt açılar büyüme için meydan okuma sunar. En büyük dersler genellikle zorlu açılardan gelir.',
    },
    {
      'question': 'Haritamda hiç gezegen olmayan evler ne anlama geliyor?',
      'answer':
          'Boş evler sorunlu değildir. O evin yönetici gezegenine bakılır. Ayrıca boş ev, o alanın hayatınızda "drama" oluşturmadığı anlamına gelebilir.',
    },
    {
      'question': 'Retrogradlar haritamda ne ifade ediyor?',
      'answer':
          'Natal retrograd, o gezegenin enerjisinin içe dönük yaşandığını gösterir. "Kötü" değil, farklıdır. Örneğin, retrograd Merkür içsel düşünce ve yazarlık için güçlü olabilir.',
    },
  ];

  // NAVIGATION STRATEGY
  static const Map<String, String> internalLinks = {
    '/transits': 'Haritanıza şu anki transitler →',
    '/synastry': 'İlişki uyumu analizi →',
    '/solar-return': 'Yıllık güneş dönüşü haritası →',
    '/progressions': 'Progresyon analizi →',
    '/horoscope': 'Günlük burç yorumu →',
    '/glossary': 'Astroloji terimleri sözlüğü →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Haritamı Hesapla',
    'secondary': 'Örnek Harita Gör',
    'soft': 'Metodoloji hakkında daha fazla bilgi',
  };
}

// ============================================================
// PAGE: TAROT (/tarot)
// ============================================================

class TarotContent {
  static const String heroTitle = 'Tarot — Bilinçaltının Aynası';

  static const String heroSubtitle =
      'Kartlar geleceği görmez, içindeki bilgeliği yansıtır. 78 arketip, sonsuz içgörü.';

  static const String introSection = '''
Tarot, yüzyıllardır kullanılan sembolik bir sistemdir. 78 karttan oluşan deste, insan deneyiminin tüm arketiplerini taşır — sevinçler, acılar, geçişler, zaferler, kayıplar.

**Tarot Ne Yapar?**
Tarot kartları, bilinçaltınızla köprü kurar. Bir kart çektiğinizde, o an dikkatinizi çekecek semboller karşınıza çıkar. Bu, "geleceği görme" değil, şu andaki durumunuzu farklı bir perspektiften değerlendirme fırsatıdır.

**Venus One'da Tarot**
Biz tarot'u kehanet aracı olarak değil, yansıtma ve içgörü aracı olarak sunuyoruz. "Bu kart sana ne söylüyor?" sorusu, "Bu kart ne olacağını gösteriyor?" sorusundan daha değerlidir.
''';

  static const String whatYouWillFindSection = '''
## Tarot Destesi

**Major Arcana (22 Kart)**
Büyük Sırlar. Hayatın büyük temaları, arketipler, ruhsal yolculuk. 0 numaralı Deli'den 21 numaralı Dünya'ya — bir ruhun gelişim hikayesi.

Öne çıkan kartlar:
- **Deli (0):** Yeni başlangıçlar, saf potansiyel, bilinmeyene atılma
- **Büyücü (I):** İrade, manifestasyon, kaynakların kullanımı
- **Yüksek Rahibe (II):** Sezgi, gizem, bilinçaltı bilgelik
- **İmparatoriçe (III):** Bereket, annelik, yaratıcılık
- **İmparator (IV):** Yapı, otorite, düzen
- **Asılmış Adam (XII):** Bakış açısı değişikliği, fedakarlık, bekleyiş
- **Ölüm (XIII):** Dönüşüm, sonlar ve başlangıçlar (korkulmamalı!)
- **Kule (XVI):** Ani değişim, eski yapıların yıkılışı
- **Yıldız (XVII):** Umut, şifa, ilham
- **Dünya (XXI):** Tamamlanma, bütünleşme, döngünün sonu

**Minor Arcana (56 Kart)**
Küçük Sırlar. Günlük yaşamın detayları, olaylar, duygular. 4 elementle ilişkili 4 takım:

- **Asalar (Ateş):** Tutku, yaratıcılık, eylem
- **Kupalar (Su):** Duygular, ilişkiler, sezgi
- **Kılıçlar (Hava):** Düşünce, iletişim, çatışma
- **Pentaküller (Toprak):** Maddi dünya, iş, sağlık

Her takımda Ace'den 10'a kadar sayı kartları + 4 saray kartı (Page, Knight, Queen, King) bulunur.
''';

  static const String spreadTypesSection = '''
## Açılım Türleri

**Günlük Tek Kart**
Her gün bir kart çekin. Günün enerjisi, odak noktası veya düşünülecek tema için.

**Üç Kart Açılımı**
- Geçmiş — Şimdi — Gelecek
- Durum — Engel — Tavsiye
- Zihin — Beden — Ruh

**Celtic Cross (On Kart)**
Detaylı analiz için klasik açılım. Durum, zorluklar, bilinçaltı, yakın gelecek, potansiyel sonuç ve daha fazlası.

**İlişki Açılımı**
İki kişinin dinamiklerini, beklentilerini ve potansiyellerini keşfetmek için.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Kehanet Değildir**
"Yarın şu olacak" diye bir kart söylemez. Semboller, yorumlama gerektirir ve yorumlama sizin perspektifinize bağlıdır.

**Korkulacak Bir Şey Değildir**
Ölüm kartı fiziksel ölümü, Kule kartı yıkımı "kesin" göstermez. Bu semboller, dönüşüm ve değişimi temsil eder.

**Karar Verici Değildir**
"Şu işe girmeli miyim?" sorusuna tarot kesin cevap vermez. Size düşünmeniz için perspektifler sunar.

**Bağımlılık Aracı Değildir**
Her gün her konu için tarot çekmek sağlıklı değildir. Kendi sezginize güvenmeyi öğrenin.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Tarot gerçekten işe yarıyor mu?',
      'answer':
          'Eğer "geleceği görme" bekliyorsanız, kanıt yoktur. Ama öz-yansıtma, karar alma süreçlerinde farklı perspektif kazanma, bilinçaltı süreçleri keşfetme için güçlü bir araç olabilir.',
    },
    {
      'question': 'Ters çıkan kartlar ne anlama gelir?',
      'answer':
          'Ters kartlar, kartın enerjisinin bloke olduğu, içe dönük yaşandığı veya aşırıya kaçtığı anlamına gelebilir. Bazı okuyucular ters kart kullanmaz, tercih meselesidir.',
    },
    {
      'question': 'Aynı soruyu tekrar sorabilir miyim?',
      'answer':
          'Teknik olarak evet, ama beğenmediğiniz cevabı değiştirmek için sürekli sormak anlamlı değildir. Kartların ilk yanıtı genellikle en değerli olanıdır.',
    },
    {
      'question': 'Ölüm kartı kötü mü?',
      'answer':
          'Hayır. Ölüm kartı dönüşümü, bir döngünün sonunu ve yenisinin başlangıcını temsil eder. Fiziksel ölümle nadiren ilişkilidir. Değişim zor olabilir ama kötü değildir.',
    },
    {
      'question': 'Tarot ve astroloji bağlantılı mı?',
      'answer':
          'Evet. Major Arcana kartları zodyak işaretleri ve gezegenlerle, Minor Arcana elementlerle eşleşir. İkisi birlikte kullanılabilir.',
    },
    {
      'question': 'Kendi destemi mi almalıyım?',
      'answer':
          'Deste hediye edilmeli efsanesi doğru değildir. Kendinize çeken bir deste satın alabilirsiniz. Rider-Waite-Smith klasik ve öğrenmesi kolay bir seçenektir.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/horoscope': 'Günlük burç yorumu →',
    '/birth-chart': 'Natal haritanızı görün →',
    '/numerology': 'Sayıların bilgeliği →',
    '/kabbalah': 'Kabala ve tarot bağlantısı →',
    '/dreams': 'Rüya yorumlama →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Günlük Kart Çek',
    'secondary': 'Üç Kart Açılımı',
    'soft': 'Kartların anlamlarını öğren',
  };
}

// ============================================================
// PAGE: NUMEROLOGY (/numerology)
// ============================================================

class NumerologyContent {
  static const String heroTitle = 'Numeroloji — Sayıların Gizli Dili';

  static const String heroSubtitle =
      'Her sayı bir enerji taşır. Doğum tarihiniz ve isminiz, sizin sayısal imzanızdır.';

  static const String introSection = '''
Numeroloji, sayıların sembolik anlamlarını inceleyen kadim bir sistemdir. Pisagor'dan Kabala'ya, birçok gelenek sayıların mistik güçler taşıdığına inanmıştır.

**Temel Prensip**
Her şey titreşimdir ve sayılar bu titreşimlerin sembolik ifadesidir. Doğum tarihiniz ve isminiz, sizin kişisel sayı kodunuzu oluşturur.

**Nasıl Çalışır?**
Doğum tarihiniz toplanarak tek haneye indirilir (master sayılar hariç). İsminizdeki harfler sayıya çevrilir. Bu sayılar, kişiliğiniz, yaşam yolunuz ve potansiyelleriniz hakkında sembolik içgörüler sunar.
''';

  static const String coreNumbersSection = '''
## Temel Sayılarınız

**Yaşam Yolu Sayısı (Life Path)**
Doğum tarihinizin toplamı. En önemli sayınız — yaşam amacınız, ana temalarınız, potansiyeliniz.

**Kişilik Sayısı (Personality)**
İsminizdeki sessiz harflerin toplamı. Dış dünyanın sizi nasıl algıladığı, ilk izleniminiz.

**Ruh Sayısı (Soul Urge)**
İsminizdeki sesli harflerin toplamı. İç motivasyonunuz, gerçek arzularınız, kalbinizin sesi.

**Kader Sayısı (Destiny/Expression)**
İsminizdeki tüm harflerin toplamı. Potansiyeliniz, yetenekleriniz, hayatta ifade etmeniz gereken enerji.

**Doğum Günü Sayısı**
Sadece doğduğunuz günün sayısı. Özel bir yeteneği veya armağanı temsil eder.
''';

  static const String numberMeaningsSection = '''
## Sayıların Anlamları

**1 — Lider, Öncü**
Bağımsızlık, özgünlük, irade. Başlatıcı enerji. Gölge: Bencillik, inatçılık.

**2 — Diplomat, Ortak**
İşbirliği, denge, hassasiyet. Köprü kurma enerjisi. Gölge: Bağımlılık, kararsızlık.

**3 — Yaratıcı, İfade**
Yaratıcılık, iletişim, neşe. Sanatsal enerji. Gölge: Dağınıklık, yüzeysellik.

**4 — İnşaatçı, Temel**
Disiplin, yapı, güvenilirlik. Somut enerji. Gölge: Katılık, sıkılganlık.

**5 — Maceracı, Özgür**
Değişim, özgürlük, adaptasyon. Hareket enerjisi. Gölge: Sorumsuzluk, aşırılık.

**6 — Bakıcı, Uyumcu**
Aile, sorumluluk, estetik. Sevgi enerjisi. Gölge: Fedakarlık obsesyonu, kontrol.

**7 — Mistik, Araştırmacı**
Ruhanilik, analiz, içe dönüklük. Bilgelik enerjisi. Gölge: İzolasyon, şüphecilik.

**8 — Güç Sahibi, Manifestör**
Maddi başarı, otorite, karma. Güç enerjisi. Gölge: Materyalizm, kontrol.

**9 — Hümanist, Tamamlayıcı**
Hizmet, bilgelik, evrensel aşk. Kapanış enerjisi. Gölge: Kayıp korkusu, bırakamama.

**Master Sayılar (11, 22, 33)**
Tek haneye indirilmez. Daha yoğun, daha zorlayıcı, daha yüksek potansiyel taşıyan özel sayılar.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Bilimsel Değildir**
Numeroloji, ampirik bilim değildir. Sembolik bir sistemdir, kanıtlanmış iddialar taşımaz.

**Kader Okuyucu Değildir**
Sayılarınız size "şu olacak" demez. Eğilimler ve potansiyeller gösterir.

**Matematikle Karıştırılmamalı**
Numerolojik "hesaplama" matematik değil, sembolik indirgeme sistemidir.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Evlendikten sonra ismim değişirse sayılarım değişir mi?',
      'answer':
          'Evet, yeni isminizin sayıları farklı olacaktır. Bazıları doğum ismi ile şu anki ismi birlikte değerlendirir. Doğum ismi "potansiyel", kullanılan isim "aktif enerji" olarak yorumlanabilir.',
    },
    {
      'question': 'Master sayı (11, 22, 33) taşımak özel mi?',
      'answer':
          'Master sayılar daha yoğun enerji taşır ama bu "üstünlük" değil, "daha fazla sorumluluk" anlamına gelir. Potansiyel yüksek, ama beklentiler de öyle.',
    },
    {
      'question': 'Şanssız sayı var mı?',
      'answer':
          'Numerolojide "kötü" sayı yoktur. Her sayının ışık ve gölge yönleri vardır. 13 veya 4 gibi kültürel olarak "şanssız" görülen sayılar bile güçlü enerjiler taşır.',
    },
    {
      'question': 'Numeroloji ve astroloji nasıl birlikte kullanılır?',
      'answer':
          'Birbirini tamamlarlar. Astroloji kozmik kalıpları, numeroloji sayısal kalıpları inceler. Örneğin, Yaşam Yolu sayınız ile Güneş burcunuz benzer temalar taşıyabilir.',
    },
    {
      'question': 'Günlük/aylık/yıllık sayılar nasıl hesaplanır?',
      'answer':
          'Kişisel Yıl Sayınız: Doğum gününüz + doğum ayınız + şu anki yıl. Kişisel Ay: Kişisel Yıl + şu anki ay. Döngüsel enerji akışını gösterir.',
    },
    {
      'question': 'Hangi sayı en iyisidir?',
      'answer':
          'Hiçbiri "en iyi" değildir. Her sayı benzersiz bir enerji taşır. Önemli olan, kendi sayılarınızın ışık yönlerini geliştirmek, gölge yönlerinin farkında olmaktır.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/birth-chart': 'Astrolojik haritanız →',
    '/kabbalah': 'Kabala ve sayılar →',
    '/tarot': 'Tarot kartları →',
    '/compatibility': 'Sayısal uyum analizi →',
    '/horoscope': 'Günlük burç yorumu →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Sayılarımı Hesapla',
    'secondary': 'Kişisel Yıl Sayım',
    'soft': 'Sayı anlamlarını öğren',
  };
}

// ============================================================
// PAGE: COMPATIBILITY (/compatibility)
// ============================================================

class CompatibilityContent {
  static const String heroTitle = 'İlişki Uyumu — Kozmik Bağlantılar';

  static const String heroSubtitle =
      'İki harita buluştuğunda ne olur? Synastry, uyumun ve meydan okumaların haritasıdır.';

  static const String introSection = '''
İlişki uyumu analizi (synastry), iki kişinin doğum haritalarını karşılaştırarak kozmik etkileşimlerini inceler.

**Synastry Nedir?**
İki haritayı üst üste koyduğunuzda, gezegenler birbirleriyle açılar yapar. Bu açılar, ilişkinin güçlü ve zorlayıcı noktalarını sembolik olarak gösterir.

**Önemli Uyarı**
Hiçbir synastry analizi bir ilişkinin "başarılı" veya "başarısız" olacağını söyleyemez. Haritalar potansiyelleri gösterir, ama ilişkiler iki bireyin bilinçli çabalarıyla şekillenir.
''';

  static const String whatWeAnalyzeSection = '''
## Analiz Ettiğimiz Unsurlar

**Güneş-Güneş Uyumu**
İki kimliğin buluşması. Benzer mi, zıt mı? Birbirlerini nasıl etkiler?

**Ay-Ay Uyumu**
Duygusal dil. Birbirlerinin ihtiyaçlarını anlıyorlar mı?

**Venüs-Mars Açıları**
Romantik ve fiziksel çekim. Tutku ve uyum.

**Merkür Etkileşimleri**
İletişim kalitesi. Birbirlerini anlıyorlar mı?

**Satürn Açıları**
Uzun vadeli potansiyel. Taahhüt ve sınırlar.

**Kuzey Düğüm Bağlantıları**
Karmik tema. Birlikte büyüme potansiyeli.
''';

  static const String compatibilityTypesSection = '''
## Uyum Analizi Türleri

**Romantik Synastry**
Aşk ilişkileri için. Çekim, duygusal bağ, uzun vadeli potansiyel.

**Arkadaşlık Synastry**
Dostluklar için. Ortak değerler, iletişim, destek dinamikleri.

**İş Ortaklığı Synastry**
Profesyonel ilişkiler için. Hedef uyumu, güç dengesi, karar alma.

**Aile Synastry**
Ebeveyn-çocuk, kardeş ilişkileri için. Karma dinamikler, roller.

**Kompozit Harita**
İki haritanın ortalaması — ilişkinin kendi haritası. İlişkinin "kimliği".
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Eşleştirme Servisi Değildir**
"Bu kişiyle evlen" veya "Bu kişiden uzak dur" demiyoruz.

**Kesin Sonuç Vermez**
Zor açılar = kötü ilişki değildir. Kolay açılar = mükemmel ilişki değildir.

**Bireysel Çabayı Değiştirmez**
En uyumlu haritalar bile iletişim, saygı ve emek olmadan çalışmaz.

**Tek Kriter Değildir**
Harita uyumu, ilişkinin sadece bir boyutudur. Yaşam koşulları, değerler, iletişim kalitesi çok daha belirleyicidir.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Partnerimle hiç uyumlu değiliz mi?',
      'answer':
          'Zorlayıcı açılar "uyumsuzluk" değil, "büyüme alanları" anlamına gelir. En başarılı ilişkiler genellikle bazı gerilim açıları taşır — bu dinamik enerji sağlar.',
    },
    {
      'question': 'Sadece burç uyumuna bakılabilir mi?',
      'answer':
          'Güneş burcu uyumu sadece bir parçadır. Ay, Venüs, Mars, yükselen burç ve diğer açılar çok daha kapsamlı bir resim sunar.',
    },
    {
      'question': 'Kompozit harita nedir?',
      'answer':
          'İki haritanın matematiksel ortalamasıdır. Synastry "iki kişinin etkileşimini", kompozit "ilişkinin kendisini" gösterir.',
    },
    {
      'question': 'Zıt burçlar çekilir mi?',
      'answer':
          'Zıt burçlar (Koç-Terazi, Boğa-Akrep vb.) genellikle güçlü çekim taşır ama aynı zamanda meydan okuma sunar. "Opposites attract" gerçek olabilir ama sürdürmek çaba gerektirir.',
    },
    {
      'question': 'Eski partnerimle neden bu kadar yoğun bir bağ vardı?',
      'answer':
          'Pluto, Kuzey Düğüm veya 8. Ev bağlantıları yoğun, karmik hisseden ilişkiler oluşturabilir. Bu "soul mate" deneyimi olabilir ama her zaman uzun vadeli uyum anlamına gelmez.',
    },
    {
      'question': 'Ebeveynlerimle synastry bakmak mantıklı mı?',
      'answer':
          'Evet. Aile synastry\'si, ebeveyn-çocuk dinamiklerini, miras alınan kalıpları ve aile karmalarını anlamaya yardımcı olabilir.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/synastry': 'Detaylı synastry analizi →',
    '/composite': 'Kompozit harita →',
    '/birth-chart': 'Kendi haritanızı görün →',
    '/horoscope': 'Günlük burç uyumu →',
    '/tarot': 'İlişki tarot açılımı →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Uyum Analizi Yap',
    'secondary': 'Burç Uyumu Karşılaştır',
    'soft': 'Synastry nasıl çalışır?',
  };
}

// ============================================================
// PAGE: AURA (/aura)
// ============================================================

class AuraContent {
  static const String heroTitle = 'Aura — Enerji Alanınızın Haritası';

  static const String heroSubtitle =
      'Her varlık bir enerji alanı yayar. Auranız, görünmez ama hissedilir kimliğinizdir.';

  static const String introSection = '''
Aura, fiziksel bedenin etrafındaki enerji alanı olarak tanımlanır. Birçok spiritüel gelenekte, auranın renkleri ve yoğunluğu kişinin duygusal, mental ve ruhsal durumunu yansıttığına inanılır.

**Aura Nedir?**
Biyoenerji alanı kavramı, Doğu'dan Batı'ya birçok kültürde bulunur. Çin tıbbında "chi", Hindistan'da "prana", Batı'da "biyoenerji" olarak adlandırılır.

**Bilimsel Yaklaşım**
Aura fotoğrafçılığı (Kirlian) bazı enerji kalıplarını görselleştirse de, "aura okuması" bilimsel olarak kanıtlanmış bir pratik değildir. Biz bunu sembolik ve meditasyonel bir araç olarak sunuyoruz.
''';

  static const String auraColorsSection = '''
## Aura Renkleri ve Anlamları

**Kırmızı**
Fiziksel enerji, tutku, kök chakra. Güçlü yaşam gücü. Dikkat: Öfke veya stres de olabilir.

**Turuncu**
Yaratıcılık, duygusal denge, sakral chakra. Sosyallik ve neşe.

**Sarı**
Zihinsel aktivite, güneş pleksusu chakra. Entelektüel enerji, iyimserlik.

**Yeşil**
Şifa, kalp chakra, doğa bağlantısı. Denge ve uyum.

**Mavi**
İletişim, boğaz chakra, sakinlik. Hassasiyet ve ifade.

**Çivit (Indigo)**
Sezgi, üçüncü göz chakra. Derin algı, spiritüel görüş.

**Mor/Eflatun**
Ruhanilik, taç chakra. Yüksek bilinç, kozmik bağlantı.

**Beyaz**
Saflık, koruma, spiritüel olgunluk.

**Siyah veya Gri**
Enerji blokajı, yorgunluk, korunma ihtiyacı. Negatif değil, farkındalık gerektiren.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Tıbbi Teşhis Değildir**
Aura renkleri sağlık durumu hakkında tıbbi bilgi vermez.

**Kesin Kişilik Analizi Değildir**
Aura geçici duygusal durumları yansıtabilir, sabit kişilik değil.

**Bilimsel Kanıt Taşımaz**
Aura okuması, subjektif bir pratiktir.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Auramı görebilir miyim?',
      'answer':
          'Bazı insanlar meditasyon ve pratikle aura görmeyi öğrendiğini söyler. Başlangıç için yumuşak ışıkta, nötr bir arka plan önünde elinize veya aynada kendinize yumuşak bakışla bakmayı deneyebilirsiniz.',
    },
    {
      'question': 'Aura rengi değişir mi?',
      'answer':
          'Evet. Aura, anlık duygusal ve enerji durumunuzu yansıtır. Meditasyon, duygu değişimi, hatta yemek bile rengi etkileyebilir.',
    },
    {
      'question': 'Aura temizliği nasıl yapılır?',
      'answer':
          'Doğada zaman geçirme, meditasyon, tuz banyosu, tütsü (adaçayı) gibi pratikler enerji temizliği için kullanılır. Bunlar sembolik ritüellerdir, bilimsel değil.',
    },
    {
      'question': 'Negatif aura bulaşır mı?',
      'answer':
          'Bazı gelenekler enerji transferine inanır. Kendinizi yorgun veya "ağır" hissettiğinizde, sınır koymak ve öz-bakım yapmak faydalı olabilir.',
    },
    {
      'question': 'Aura fotoğrafı gerçek mi?',
      'answer':
          'Kirlian fotoğrafçılığı elektrik alanlarını yakalar, ama bunun "aura" olup olmadığı tartışmalıdır. Eğlenceli bir deneyim olabilir ama kesin sonuçlar çıkarmak güçtür.',
    },
    {
      'question': 'Aura okumaya nasıl başlarım?',
      'answer':
          'Kendi enerji durumunuzu fark etmeye başlayın. Farklı ortamlarda, farklı insanlarla nasıl hissettiğinizi gözlemleyin. Meditasyon pratiği, enerji farkındalığını artırabilir.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/chakra': 'Chakra analizi →',
    '/birth-chart': 'Astrolojik haritanız →',
    '/tarot': 'Tarot okuması →',
    '/rituals': 'Enerji ritüelleri →',
    '/dreams': 'Rüya yorumlama →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Aura Analizi Yap',
    'secondary': 'Chakra Dengeni Gör',
    'soft': 'Renk anlamlarını öğren',
  };
}

// ============================================================
// PAGE: KABBALAH (/kabbalah)
// ============================================================

class KabbalahContent {
  static const String heroTitle = 'Kabala — Hayat Ağacının Bilgeliği';

  static const String heroSubtitle =
      'Yahudi mistisizminin kadim haritası. 10 sefirah, 22 patika, sonsuz derinlik.';

  static const String introSection = '''
Kabala (Kabbalah), Yahudi mistisizminin ezoterink geleneğidir. Hayat Ağacı (Etz Chaim), evrenin ve insan ruhunun yapısını temsil eden sembolik bir diyagramdır.

**Hayat Ağacı Nedir?**
10 sefirah (sefira) ve bunları birbirine bağlayan 22 patikadan oluşur. Her sefirah, ilahi enerjinin farklı bir tezahürünü, farklı bir bilinç seviyesini temsil eder.

**Venus One'da Kabala**
Biz Kabala'yı öz-keşif için bir araç olarak sunuyoruz. Derin teolojik veya dini iddialar taşımıyoruz. Bu, meditasyonel bir harita olarak kullanılabilir.
''';

  static const String sefirotSection = '''
## 10 Sefirah

**1. Keter (Taç)**
Saf irade, birlik noktası, kaynakla bağlantı. Düşüncenin ötesinde.

**2. Hokmah (Bilgelik)**
İlham, fikir kıvılcımı, eril yaratıcı güç.

**3. Binah (Anlayış)**
Kavrayış, şekil verme, dişil alıcı güç.

**4. Hesed (Merhamet)**
Genişleme, cömertlik, koşulsuz sevgi.

**5. Gevurah (Güç)**
Sınırlar, disiplin, adalet.

**6. Tiferet (Güzellik)**
Denge, uyum, kalbin merkezi.

**7. Netzach (Zafer)**
Azim, tutku, duygusal güç.

**8. Hod (İhtişam)**
Zihin, iletişim, analiz.

**9. Yesod (Temel)**
Bilinçaltı, rüyalar, enerji temeli.

**10. Malkut (Krallık)**
Fiziksel dünya, tezahür, beden.
''';

  static const String kabbalahNumerologySection = '''
## Kabala ve Numeroloji

İbranice harfler sayı değerleri taşır (gematria). Bu sistemde isim ve kelimeler sayısal değerlere çevrilir, aralarındaki bağlantılar keşfedilir.

**Kabalistik Sayı Hesaplama**
İsminiz İbranice harflere çevrilir ve toplamı hesaplanır. Bu toplam, belirli bir sefirah veya arketip ile ilişkilendirilir.

**Dikkat:** Otantik Kabala çalışması yoğun eğitim gerektirir. Bizim sunduğumuz, popüler adaptasyonlardır.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Dini Öğreti Değildir**
Kabala derin bir Yahudi geleneğidir. Biz dini öğreti sunmuyoruz, sembolik sistem olarak kullanıyoruz.

**Hızlı Tüketim Değildir**
Gerçek Kabala öğrenimi yıllar alır. Burada sunulan, giriş seviyesi tanıtımdır.

**Sihir Değildir**
Popüler kültürdeki "Kabala sihri" yanıltıcıdır. Bu bir bilgelik yoludur, sihir değil.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Kabala öğrenmek için Yahudi olmam gerekir mi?',
      'answer':
          'Geleneksel olarak Kabala, belirli gereksinimleri olan eğitimli Yahudi erkeklerine öğretilirdi. Modern zamanlarda daha açık hale geldi, ama otantik çalışma hâlâ Yahudi geleneği bağlamında yürütülür.',
    },
    {
      'question': 'Kabala bilekliği işe yarıyor mu?',
      'answer':
          'Kırmızı ip bilekliği pop-kültür Kabala\'sının sembolüdür. Geleneksel Kabala\'da bu pratik yoktur. Sembolik değeri, kişisel niyetinize bağlıdır.',
    },
    {
      'question': 'Kabala ve tarot bağlantılı mı?',
      'answer':
          'Evet. 22 Major Arcana kartı, Hayat Ağacı\'nın 22 patikasıyla eşleştirilir. Bu bağlantı 19. yüzyılda Batı okültizminde sistemleştirildi.',
    },
    {
      'question': 'Sefirot meditasyonu nasıl yapılır?',
      'answer':
          'Hayat Ağacı üzerinde yolculuk, sefirot\'un enerjilerini deneyimleme meditasyonlarıdır. Başlangıç için Malkut\'tan (fiziksel) Keter\'e (ruhani) yükselme pratiği yapılabilir.',
    },
    {
      'question': 'Kabala astroloji ile bağlantılı mı?',
      'answer':
          'Evet. Sefirot, gezegenlerle eşleştirilir. Örneğin: Binah-Satürn, Hesed-Jüpiter, Gevurah-Mars. Zodiak işaretleri de patikalarla ilişkilendirilir.',
    },
    {
      'question': 'Kendi sefirah\'ımı nasıl bulurum?',
      'answer':
          'Kabalistik numeroloji ile doğum tarihinden veya isimden hesaplanır. Ama "tek bir sefirah\'a ait olmak" yerine, hepsini içeren bir yolculuk daha anlamlıdır.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/numerology': 'Numeroloji →',
    '/tarot': 'Tarot ve Kabala →',
    '/birth-chart': 'Astrolojik harita →',
    '/aura': 'Enerji alanı →',
    '/glossary': 'Mistik terimler →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Kabala Sayımı Hesapla',
    'secondary': 'Hayat Ağacını Keşfet',
    'soft': 'Sefirot hakkında daha fazla',
  };
}

// ============================================================
// PAGE: TRANSITS (/transits)
// ============================================================

class TransitsContent {
  static const String heroTitle = 'Gezegen Transitleri — Kozmik Hava Durumu';

  static const String heroSubtitle =
      'Gökyüzü sürekli hareket halinde. Şu anki gezegenler, haritanıza nasıl dokunuyor?';

  static const String introSection = '''
Transitler, gökyüzündeki şu anki gezegen pozisyonlarının doğum haritanızla yaptığı açılardır. Doğum haritanız sabit bir fotoğrafken, transitler sürekli değişen bir film gibidir.

**Transit Nasıl Çalışır?**
Bir gezegen, haritanızdaki hassas bir noktayı (gezegen, açı, ev ucu) aspekt yaptığında, o alanla ilgili temalar aktifleşir. Bu, "olay" anlamına gelmez, ama enerji yoğunlaşması demektir.

**Hızlı ve Yavaş Transitler**
- **Hızlı:** Ay (2.5 gün/burç), Merkür, Venüs, Mars — kısa vadeli etkiler
- **Yavaş:** Jüpiter (1 yıl/burç), Satürn (2.5 yıl/burç), Uranüs, Neptün, Pluto — uzun vadeli dönüşümler
''';

  static const String majorTransitsSection = '''
## Major Transitler

**Satürn Transiti**
En önemli transitlerden biri. Satürn haritanızda nereye dokunuyorsa, orada "sınav" zamanıdır. Yapılanma, disiplin, olgunlaşma.

- Satürn-Güneş: Kimlik ve amaç testi
- Satürn-Ay: Duygusal olgunlaşma
- Satürn-Satürn (Satürn Dönüşü): ~29 yaş, büyük yaşam kriteri

**Jüpiter Transiti**
Genişleme, fırsat ve şans zamanları. Jüpiter nereye değerse, orada büyüme potansiyeli var.

- Jüpiter-Güneş: Özgüven artışı, fırsatlar
- Jüpiter-Ay: Duygusal zenginleşme

**Uranüs Transiti**
Beklenmedik değişimler, özgürleşme, elektriksel uyanışlar. Uzun sürer (7 yıl/burç), köklü dönüşümler.

**Neptün Transiti**
Sis, karışıklık, ama aynı zamanda spiritüel açılma. Gerçeklik bulanıklaşabilir.

**Pluto Transiti**
En yoğun dönüşüm. Ölüm ve yeniden doğuş temaları. Bir kuşak boyu sürer.
''';

  static const String retrogradesSection = '''
## Retrogradlar

Bir gezegen retrograd göründüğünde, o gezegenin temsil ettiği alanlarda "geri dönüş", "gözden geçirme" enerjisi aktifleşir.

**Merkür Retrograd**
Yılda 3-4 kez, yaklaşık 3 hafta. İletişim, teknoloji, seyahat aksaklıkları söylentisi. Gerçekte: İletişimi netleştirme, eski konuları tamamlama zamanı.

**Venüs Retrograd**
18 ayda bir, 40 gün. Aşk ve para konularında geri dönüşler. Eski sevgililer, eski değerler gündeme gelebilir.

**Mars Retrograd**
İki yılda bir, 2 ay. Enerji ve motivasyonda düşüş. Yeni girişimler yerine, devam eden projeleri tamamlama zamanı.
''';

  static const String whatThisIsNotSection = '''
## Bu Ne DEĞİLDİR?

**Kader Okuma Değildir**
Transitler "şu olacak" demez. Enerji akışlarını, olası temaları gösterir.

**Panik Sebebi Değildir**
"Pluto üzerimden geçiyor" demek "hayatım mahvolacak" demek değildir. Transitler fırsattır.

**Karar Alıcı Değildir**
"Bu transit kötü, bekle" yerine, transite uygun hareket etmeyi öğrenin.
''';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'Transit ne kadar sürer?',
      'answer':
          'Gezegene bağlı. Ay transiti saatler, Pluto transiti yıllar sürer. Orb\'a (açının geçerli olduğu derece aralığı) göre değişir.',
    },
    {
      'question': 'Zor transit geçiriyorum, ne yapmalıyım?',
      'answer':
          'Önce paniklemeyin. Transitin temasını anlayın, o alanda bilinçli çalışın. Zor transitler genellikle en büyük büyüme dönemleridir.',
    },
    {
      'question': 'Aynı anda birden fazla transit olabilir mi?',
      'answer':
          'Evet, ve genellikle öyle. Transitler katmanlar halinde çalışır. Bazı dönemler daha yoğun, bazıları daha sakin olabilir.',
    },
    {
      'question': 'Transit takvimi nasıl takip edilir?',
      'answer':
          'Venus One\'da kişisel transit takviminizi görebilirsiniz. Önemli transitler için bildirim ayarlayabilirsiniz.',
    },
    {
      'question': 'Herkes aynı transitleri yaşar mı?',
      'answer':
          'Kolektif transitler (örn. Pluto burç değişimi) herkesi etkiler, ama bireysel etki doğum haritanıza bağlıdır. Jüpiter sizin 7. evinizi geçiyorsa, partnerlik teması sizin için aktiftir.',
    },
    {
      'question': 'Electional astroloji nedir?',
      'answer':
          'Önemli eylemler için en uygun zamanları seçme sanatıdır. Transitler kullanılarak "iyi" zamanlar belirlenir. Örneğin iş başlangıcı, evlilik, ameliyat.',
    },
  ];

  static const Map<String, String> internalLinks = {
    '/birth-chart': 'Natal haritanızı görün →',
    '/solar-return': 'Yıllık harita →',
    '/progressions': 'Progresyonlar →',
    '/horoscope': 'Günlük burç yorumu →',
    '/timing': 'Electional astroloji →',
  };

  static const Map<String, String> ctas = {
    'primary': 'Kişisel Transitlerim',
    'secondary': 'Şu Anki Gökyüzü',
    'soft': 'Transit takvimi',
  };
}
