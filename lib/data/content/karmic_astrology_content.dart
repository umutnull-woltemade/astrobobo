/// KARMIC ASTROLOGY CONTENT - KARMİK ASTROLOJİ BİLGELİĞİ
///
/// Rahu/Ketu (Ay Düğümleri), Satürn Karması, Retrograd Gezegenler,
/// 12. Ev Sırları, Chiron, Karmik İlişkiler, Evrimsel Astroloji
///
/// Derin ezoterik ve tantrik içerikler - Türkçe mistik dilde yazılmıştır.
library;

// ════════════════════════════════════════════════════════════════════════════
// MODELLER
// ════════════════════════════════════════════════════════════════════════════

class NodePlacement {
  final String sign;
  final String northNodeTitle;
  final String southNodeTitle;
  final String pastLifeThemes;
  final String karmicLessons;
  final String soulEvolutionPath;
  final String tantricImplications;
  final String healingPractices;
  final String shadowWork;
  final String giftFromPastLives;
  final String currentLifeMission;
  final List<String> affirmations;

  const NodePlacement({
    required this.sign,
    required this.northNodeTitle,
    required this.southNodeTitle,
    required this.pastLifeThemes,
    required this.karmicLessons,
    required this.soulEvolutionPath,
    required this.tantricImplications,
    required this.healingPractices,
    required this.shadowWork,
    required this.giftFromPastLives,
    required this.currentLifeMission,
    required this.affirmations,
  });
}

class NodeInHouse {
  final int house;
  final String northNodeMeaning;
  final String southNodeMeaning;
  final String karmicLesson;
  final String lifeAreaFocus;
  final String spiritualGrowth;
  final String practicalGuidance;

  const NodeInHouse({
    required this.house,
    required this.northNodeMeaning,
    required this.southNodeMeaning,
    required this.karmicLesson,
    required this.lifeAreaFocus,
    required this.spiritualGrowth,
    required this.practicalGuidance,
  });
}

class SaturnPlacement {
  final String sign;
  final String karmicDebt;
  final String lifeLessons;
  final String maturationProcess;
  final String saturnReturnThemes;
  final String masteringEnergy;
  final String shadowAspects;
  final String rewards;

  const SaturnPlacement({
    required this.sign,
    required this.karmicDebt,
    required this.lifeLessons,
    required this.maturationProcess,
    required this.saturnReturnThemes,
    required this.masteringEnergy,
    required this.shadowAspects,
    required this.rewards,
  });
}

class SaturnInHouse {
  final int house;
  final String lifeLesson;
  final String challenges;
  final String mastery;
  final String karmicTheme;
  final String growthPath;

  const SaturnInHouse({
    required this.house,
    required this.lifeLesson,
    required this.challenges,
    required this.mastery,
    required this.karmicTheme,
    required this.growthPath,
  });
}

class RetroPlanet {
  final String planet;
  final String karmicMeaning;
  final String pastLifeBusiness;
  final String innerWorkRequired;
  final String giftsFromPastLives;
  final String currentLifeExpression;
  final String healingJourney;
  final List<String> affirmations;

  const RetroPlanet({
    required this.planet,
    required this.karmicMeaning,
    required this.pastLifeBusiness,
    required this.innerWorkRequired,
    required this.giftsFromPastLives,
    required this.currentLifeExpression,
    required this.healingJourney,
    required this.affirmations,
  });
}

class ChironPlacement {
  final String sign;
  final String coreWound;
  final String woundOrigin;
  final String healingPath;
  final String giftToOthers;
  final String integrationProcess;
  final String wisdomGained;

  const ChironPlacement({
    required this.sign,
    required this.coreWound,
    required this.woundOrigin,
    required this.healingPath,
    required this.giftToOthers,
    required this.integrationProcess,
    required this.wisdomGained,
  });
}

class ChironInHouse {
  final int house;
  final String woundArea;
  final String healingPath;
  final String teachingGift;
  final String integrationKey;

  const ChironInHouse({
    required this.house,
    required this.woundArea,
    required this.healingPath,
    required this.teachingGift,
    required this.integrationKey,
  });
}

class KarmicRelationshipIndicator {
  final String name;
  final String aspect;
  final String meaning;
  final String pastLifeConnection;
  final String currentLifePurpose;
  final String challenges;
  final String healingPotential;

  const KarmicRelationshipIndicator({
    required this.name,
    required this.aspect,
    required this.meaning,
    required this.pastLifeConnection,
    required this.currentLifePurpose,
    required this.challenges,
    required this.healingPotential,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// RAHU VE KETU - AY DÜĞÜMLERİ GİRİŞ
// ════════════════════════════════════════════════════════════════════════════

class LunarNodesIntroduction {
  static const String title = 'Ay Düğümleri: Ruhun Kozmik Pusolası';

  static const String introduction = '''
Kadim Vedik bilgeliğinde Rahu ve Ketu, ruhun ebedi yolculuğunun en derin
sırlarını taşıyan gölge gezegenlerdir. Bunlar fiziksel cisimler değil,
Ay'ın yörüngesinin Ekliptik düzlemiyle kesiştiği matematiksel noktalardır -
ama astrolojik güçleri fiziksel gezegenlerden bile daha derin ve dönüştürücüdür.

Mitolojide anlatılır ki, tanrılar ve asuralar ölümsüzlük iksiri için
okyanusu çalkaladıklarında, Svarbhanu adlı bir asura tanrı kılığına girip
iksirden içti. Güneş ve Ay onu fark edip Vishnu'ya haber verince, Vishnu'nun
çarkı asura'nın boğazını kesti - ama iksir çoktan içilmişti. Böylece başı
Rahu, gövdesi Ketu olarak ölümsüzleşti. O günden beri Rahu ve Ketu, Güneş
ve Ay'ı yutarak tutulmalar yaratır - kozmik öç ve karmik döngünün sembolü.

RAHU (Kuzey Ay Düğümü) - GELECEK KADERİ
Rahu, ruhun bu yaşamda deneyimlemesi gereken yeni toprakları temsil eder.
O, bilinmeyene olan açlık, büyüme arzusu ve evrimsel dürtüdür. Rahu'nun
bulunduğu burç ve ev, bu yaşamda ustalaşmamız gereken enerjiyi gösterir.

Rahu enerjisi:
- Obsesif çekim ve arzu
- Yeni deneyimlere açlık
- Bilinmeyene atılma cesareti
- Konfor alanından çıkış
- Maddi dünya ile bağ
- İllüzyon ve maya

KETU (Güney Ay Düğümü) - GEÇMİŞ YAŞAM MİRASI
Ketu, geçmiş yaşamlardan getirdiğimiz ustalıkları, yetenekleri ve aynı
zamanda bırakmamız gereken kalıpları temsil eder. O, ruhsal ayrılık,
içsel bilgelik ve maddi dünyadan özgürleşme enerjisidir.

Ketu enerjisi:
- Doğuştan gelen yetenekler
- Geçmiş yaşam hafızası
- Bırakma ve vazgeçme
- Ruhsal arayış
- İçsel bilgelik
- Ayrılık ve özgürleşme

TANTRİK PERSPEKTIF:
Tantra'da Rahu ve Ketu, Kundalini yılanının iki ucunu temsil eder.
Ketu kök çakrada uyuyan kadim bilgelik, Rahu ise taç çakrasına
yükselen evrimsel dürtüdür. Bu iki gücü dengelemek, tantrik uyanışın
ve bireyselleşmenin (individuation) anahtarıdır.

Düğümler her 18.6 yılda bir burçlar kuşağını tamamlar. Düğüm dönüşleri
(18-19, 37-38, 55-56 yaşları) ruhun evriminde kritik dönüm noktalarıdır -
kaderin kapılarının açıldığı, karmik hesaplaşmaların yaşandığı zamanlar.
''';

  static const String rahuDetailedMeaning = '''
RAHU - KUZEY DÜĞÜMÜ DERİNLEMESİNE

Rahu, Sanskrit'te "kavrayan, yakalayan" anlamına gelir. O, doyumsuz açlığın,
bitmeyen arzunun ve maddi dünyanın büyüsüne kapılmanın sembolüdür. Ama aynı
zamanda evrimsel büyümenin, sınırları aşmanın ve yeni ufuklara açılmanın
da enerjisidir.

Rahu'nun Gölge Yüzü:
- Obsesyon ve bağımlılık
- Doyumsuzluk ve açgözlülük
- İllüzyon ve kendini kandırma
- Toplumsal statü takıntısı
- Kısa yoldan zenginlik arzusu
- Sahtecilik ve manipülasyon

Rahu'nun Işık Yüzü:
- Cesaret ve yenilikçilik
- Sınırları zorlama gücü
- Kültürler arası köprü kurma
- Teknoloji ve modernlikle bağ
- Toplumsal tabuları yıkma
- Evrimsel sıçrama potansiyeli

Rahu'nun Ev Konumu:
Rahu hangi evdeyse, o yaşam alanında yoğun arzu ve çekim hissederiz.
Bu alan bizim için yeni, heyecan verici ama aynı zamanda dengesizliğe
açık bir bölgedir. Burada ustalaşmak, bu yaşamın ana derslerinden biridir.

Rahu'nun Burç Konumu:
Rahu'nun bulunduğu burç, geliştirmemiz gereken yeni nitelikleri gösterir.
Bu nitelikler başlangıçta yabancı, hatta rahatsız edici gelebilir -
ama ruhun evrimi için zorunludur.
''';

  static const String ketuDetailedMeaning = '''
KETU - GÜNEY DÜĞÜMÜ DERİNLEMESİNE

Ketu, Sanskrit'te "bayrak, işaret" anlamına gelir. O, geçmişin izlerini,
ruhsal mirasımızı ve bırakmamız gereken eski kalıpları temsil eder.
Ketu, maddi dünyadan ayrılış, içsel bilgelik ve moksha (kurtuluş)
enerjisini taşır.

Ketu'nun Gölge Yüzü:
- Aşırı kayıtsızlık ve ilgisizlik
- Dünyadan kopukluk
- Geçmişe takılı kalma
- Kaçış ve inkar
- Kritik anlarda geri çekilme
- Potansiyeli değerlendirmeme

Ketu'nun Işık Yüzü:
- Derin sezgisel bilgelik
- Doğuştan gelen yetenekler
- Ruhsal uyanış kapasitesi
- Bağımlılıklardan özgürleşme
- İçsel huzur ve kabul
- Şifacılık ve rehberlik gücü

Ketu'nun Ev Konumu:
Ketu hangi evdeyse, o yaşam alanında doğal bir ustalık ama aynı zamanda
bir tür kayıtsızlık hissederiz. Bu alana fazla tutunmamamız gerekir -
Ketu bize buradaki bağımlılıklarımızı bırakmayı öğretir.

Ketu'nun Burç Konumu:
Ketu'nun bulunduğu burç, geçmiş yaşamlardan getirdiğimiz ustalıkları
ama aynı zamanda aşırıya kaçabileceğimiz eski kalıpları gösterir.
Bu nitelikler bizim için tanıdık ve rahat, ama artık sınırlayıcıdır.
''';
}

// ════════════════════════════════════════════════════════════════════════════
// DÜĞÜMLER BURÇLARDA - 12 BURÇ YERLEŞİMİ
// ════════════════════════════════════════════════════════════════════════════

final Map<String, NodePlacement> nodesInSigns = {
  'aries_libra': const NodePlacement(
    sign: 'Koç/Terazi Ekseni',
    northNodeTitle: 'Kuzey Düğüm Koç\'ta - Savaşçının Uyanışı',
    southNodeTitle: 'Güney Düğüm Terazi\'de - Diplomatın Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen ilişkilerin, diplomasinin ve uyumun ustasıydın.
Belki bir saray danışmanı, evlilik aracısı, barış elçisi ya da sanatçıydın.
Başkalarının ihtiyaçlarını kendi ihtiyaçlarının önüne koyarak hayatını
şekillendirdin. Güzellik, denge ve adalet arayışı ruhunun derinliklerine
işledi.

Ama bu yaşamlarda bir şey eksik kaldı: KENDİN. Sürekli başkalarını
memnun etme çabası, kendi sesini, kendi arzularını, kendi kimliğini
gölgede bıraktı. "Ben ne istiyorum?" sorusu hep ertelendi.

Ruhun şimdi bu dengesizliği düzeltmek için burada. Artık başkalarının
gözünde onay aramadan, kendi yolunu çizme zamanı geldi.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. BENLİK BİLİNCİ GELİŞTİRME
Başkalarının beklentilerinden bağımsız olarak "Ben kimim?" sorusunu
cevaplayabilmek. Kendi değerlerini, arzularını ve sınırlarını tanımak.

2. SAĞLIKLI BENCİLLİK
"Bencillik" kelimesi sana kötü gelebilir ama sağlıklı bir ego, sağlıklı
ilişkilerin temelidir. Önce kendi maskeni takmayı öğren.

3. ÇATIŞMADAN KAÇMAMAK
Uyum uğruna kendi gerçeğinden vazgeçmemeyi öğrenmek. Bazen tartışmak,
hayır demek, savaşmak gerekir - ve bu da sevginin bir parçasıdır.

4. ÖNCÜLÜK VE LİDERLİK
Başkalarının kararlarını beklemeden harekete geçmek. Kendi vizyonunu
takip etmek. İlk adımı atmaya cesaret etmek.

5. BAĞIMSIZ KİMLİK
İlişki içinde bile bireyselliğini korumak. "Biz" olmadan önce "Ben" olmak.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Terazi'nin ilişkisel bilgeliğini Koç'un bireysel
cesaretine dönüştürmekten geçiyor. Bu demek değil ki ilişkilerden
vazgeçeceksin - aksine, gerçek bir birey olarak ilişkilere daha
değerli katkılar sunabileceksin.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK (0-7 yaş, düğüm döngüsü)
Başkalarını memnun etme kalıplarının farkına varmak. "Neden hep
ben uyum sağlıyorum?" sorusunu sormaya başlamak.

AŞAMA 2 - DİRENİŞ (7-18 yaş)
İlk kez "hayır" demeyi denemek. Çatışmadan korkmadan sınır koymak.
Başlangıçta beceriksiz ve aşırı olabilir - bu normal.

AŞAMA 3 - ENTEGRASYON (18-37 yaş)
Bireysellik ve ilişkisellik arasında denge kurmak. Hem "ben" hem
"biz" olabilmenin yollarını keşfetmek.

AŞAMA 4 - USTALAMA (37+ yaş)
Koç cesaretini Terazi zarafetiyle birleştirmek. Diplomatik ama
otantik bir lider olmak. İlişkilerde eşit partner olmak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Kundalini ve Bireyselleşme

Bu düğüm ekseninde tantrik çalışma, bireysel iradenin (Koç) ve
ilişkisel birliğin (Terazi) kutsal evliliğini içerir.

Manipura (Solar Pleksus) Çakra Çalışması:
Koç enerjisi güneş sinir ağıyla ilişkilidir. Bu çakra bloke olduğunda
özgüven eksikliği, başkalarına bağımlılık ve karar verememe yaşanır.
Açıldığında kişisel güç, irade ve kendine güven gelişir.

Pratik: Her sabah güneşe dönerek, ellerini solar pleksusa koyarak
"Ben varım, ben güçlüyüm, ben kendi yolumu seçiyorum" mantrası.

Shiva-Shakti Dengesi:
Koç (Mars) aktif, dışa dönük Shiva enerjisidir. Terazi (Venüs) alıcı,
ilişkisel Shakti enerjisidir. Bu iki gücü içinde dengelemek, hem
harekete geçme hem de kabul etme kapasitesini geliştirmek tantrik
bütünleşmenin temelidir.

Cinsel Enerji Çalışması:
Koç-Terazi ekseni doğrudan cinsel enerjiyle bağlantılıdır. Cinsel
birleşmede hem verici (Koç) hem alıcı (Terazi) olmayı öğrenmek,
bu eksenin tantrik derslerinden biridir. Dominasyon-teslimiyet
dinamiklerini bilinçli keşfetmek şifa getirebilir.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. MARS NEFES TEKNİĞİ (Kapalabhati)
Hızlı, güçlü nefes çıkışlarıyla Mars enerjisini aktive et.
Her sabah 3 set x 30 nefes. Solar pleksusa odaklan.

2. SAVAŞÇI DURUŞLARI (Virabhadrasana)
Yoga savaşçı pozlarını günlük pratiğine ekle. Bu duruşlar
cesareti, kararlılığı ve topraklanmayı güçlendirir.

3. KIRMIZI TERAPİ
Kırmızı giysiler giy, kırmızı yiyecekler tüket (domates, kırmızı
biber, nar), yaşam alanında kırmızı aksan kullan.

4. YENİ BAŞLANGIÇLAR RİTÜELİ
Her yeni ay döneminde, tamamen kendin için bir şey başlat.
Kimseye danışmadan, kimsenin onayını almadan.

5. HAYIR DEME MEDİTASYONU
Her gün en az bir kez bilinçli olarak "hayır" de. Küçük şeylerle
başla. Her "hayır" bir "evet" - kendine "evet".

6. SOLO MACERALAR
Ayda en az bir kez, tamamen yalnız bir maceraya çık. Yeni bir
yer keşfet, yeni bir şey dene - başkalarının eşliği olmadan.

7. ÖFKE ÇALIŞMASI
Öfkeni bastırma, onu bilinçli şekilde ifade et. Yastığa vur,
ormanda bağır, boks yap. Öfke bastırılmış Koç enerjisidir.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Terazi Gölgesi (Bırakılması Gereken):
- Çatışmadan kaçarak sahte uyum yaratma
- Başkalarının fikirlerini kendi fikrın gibi benimseme
- İlişki uğruna kimliğinden vazgeçme
- Karar vermekten kaçınma, "sen bilirsin" demek
- Pasif-agresif davranışlar
- Onay bağımlılığı

Koç Gölgesi (Aşırıya Kaçmamak Gereken):
- Düşüncesiz saldırganlık
- Başkalarını ezmek pahasına ileri gitmek
- Sabırsızlık ve öfke patlamaları
- "Benim yolum ya da hiçbir yol" tutumu
- Dinlemeden konuşma
- Yarışma takıntısı

Denge Noktası:
Hem kendi sesini yükseltmek hem başkalarını dinlemek. Hem öncülük
etmek hem işbirliği yapmak. Hem bağımsız olmak hem bağ kurabilmek.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Diplomatik zeka ve arabuluculuk yeteneği
• Estetik duyarlılık ve güzellik anlayışı
• İnsan ilişkilerinde derin kavrayış
• Adalet ve denge duygusu
• Çatışmaları yumuşatma becerisi
• Sosyal zerafet ve incelik
• Sanatsal yetenekler
• Dinleme ve empati kapasitesi

Bu armağanları reddetme - onları Koç cesaretiyle birleştir.
Hem diplomasi hem doğrudanlık. Hem zarafet hem güç.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata otantik bireyselliğin ne demek olduğunu öğrenmek ve
öğretmek için geldin. Görevin, başkalarını memnun etme bağımlılığından
özgürleşerek kendi yolunu cesurca yürümek.

Ama bu solo bir yolculuk değil. Gerçek bireyselliğe ulaştığında,
ilişkilerine çok daha değerli katkılar sunabileceksin. Çünkü artık
ihtiyaçtan değil, seçimden seveceksin. Bağımlılıktan değil,
özgürlükten paylaşacaksın.

Somut Misyon Alanları:
- Liderlik ve girişimcilik
- Bireysel sporlar ve rekabet
- Kişisel markalaşma
- Cesaret gerektiren kariyer adımları
- Bağımsız yaşam ve karar alma
- Başkalarına özgüven aşılama
''',
    affirmations: [
      'Ben kendi yolumu seçme gücüne sahibim.',
      'Benim ihtiyaçlarım da değerli ve önemlidir.',
      'Hayır demek, kendime evet demektir.',
      'Başkalarının onayına ihtiyacım yok, kendi onayım yeterli.',
      'Çatışma büyümenin bir parçasıdır, ondan kaçmıyorum.',
      'Ben hem sevgi dolu hem güçlü olabilirim.',
      'Bireyselliğim, ilişkilerime değer katıyor.',
      'Cesaretle ilk adımı atıyorum.',
    ],
  ),

  'taurus_scorpio': const NodePlacement(
    sign: 'Boğa/Akrep Ekseni',
    northNodeTitle: 'Kuzey Düğüm Boğa\'da - Topraklanmanın Şifası',
    southNodeTitle: 'Güney Düğüm Akrep\'te - Dönüşüm Ustasının Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen dönüşümün, krizlerin ve derin psikolojik
süreçlerin içinde yaşadın. Belki bir şaman, bir büyücü, bir gizli
örgüt üyesi, bir dedektif ya da ölümle yakın çalışan biriydin.
Hayatın karanlık yüzünü tanıdın - ihanet, kayıp, yeniden doğuş
döngülerini defalarca deneyimledin.

Başkalarının sırlarını, gölgelerini, bastırılmış yanlarını görme
yeteneğin olağanüstüydü. Derin duygusal bağlar, tutku ve yoğunluk
senin için normaldi. Ama bu yoğunluk bazen yakıcıydı - hem kendini
hem başkalarını yaktın.

Ruhun şimdi bu yoğunluğu dengelemek, hayatın basit güzelliklerinde
huzur bulmak için burada. Sürekli kriz modundan çıkıp, topraklanmış
bir varlık halini deneyimleme zamanı.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. SADELİĞİN DEĞERİ
Her şeyin derin, yoğun ve karmaşık olması gerekmiyor. Basit zevkler,
gündelik güzellikler, sakin anlar da kutsal.

2. MADDEYLE BARIŞ
Akrep enerjisi maddi dünyayı küçümser, "daha derin" şeyler arar.
Ama beden bir tapınak, para bir araç, doğa bir şifacı. Maddeyle
savaşmayı bırak.

3. GÜVEN VE TESLİMİYET
Sürekli kontrol etmeye, her şeyin altındaki gizli gündemi aramaya
son ver. Bazen insanlar gerçekten iyi niyetli. Hayat her zaman
bir güç oyunu değil.

4. KEND DEĞERİN DIŞSAL KAYNAKLAR
Değerin, başkalarıyla olan derin bağlardan ya da krizleri atlat-
maktan gelmiyor. Sen zaten değerlisin - hiçbir şey yapmasan da.

5. BEDENE YERLEŞME
Sürekli zihinsel ve duygusal yoğunluktan çıkıp bedene in.
Fiziksel zevkler, duyusal deneyimler senin şifa kaynağın.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Akrep'in dönüştürücü gücünü Boğa'nın topraklayıcı
huzuruna dönüştürmekten geçiyor. Bu, yoğunluğu reddetmek değil -
onu gündelik hayatın içinde dengelemek.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Kriz bağımlılığını fark etmek. "Neden her şey drama olmak zorunda?"
sorusunu sormak. Yoğunluk olmadan kendini canlı hissedememe kalıbı.

AŞAMA 2 - RAHATSIZLIK
Sakin, basit anları rahatsız edici bulmak. "Çok sıkıcı" hissi.
Bu rahatsızlık, değişimin başladığının işareti.

AŞAMA 3 - DENEME
Basit zevkleri keşfetmeye başlamak. Yemek pişirme, bahçecilik,
yürüyüş, masaj - bedensel ve duyusal aktiviteler.

AŞAMA 4 - ENTEGRASYON
Hem derinlik hem sadelik. Hem tutku hem huzur. Hem dönüşüm hem
istikrar. İkisini de kucaklayan bir yaşam.
''',
    tantricImplications: '''
TANTRİK BOYUT: Bedenin Kutsallığı

Bu düğüm ekseninde tantrik çalışma, bedenin ve maddenin kutsallığını
keşfetmeyi içerir. Akrep enerjisi bedeni aşmak ister, Boğa onu kutsar.

Svadhisthana (Sakral) ve Muladhara (Kök) Çakra Çalışması:
Bu iki alt çakra, cinsel enerji ve topraklanmayla ilgilidir.
Akrep'in yoğun cinsel enerjisini Boğa'nın duyusal zevkine
dönüştürmek, tantrik şifanın temelidir.

Pratik: Yavaş, duyusal dokunma meditasyonu. Partnerin bedenini
(ya da kendi bedenini) acele etmeden, tamamen şimdiki anda
kalarak keşfetmek. Amaç orgazm değil, duyumsamak.

Maddi Dünyayla Tantrik İlişki:
Yemek yerken tam dikkat, her lokmanın tadını almak.
Doğada yürürken ayakların toprağı hissetmesi.
Para kazanırken ve harcarken şükran hissi.

Kundalini Topraklaması:
Akrep enerjisi Kundalini'yi yukarı çeker, Boğa onu topraklar.
Yükselmiş enerjiyi köklere indirmek, dengeyi sağlar.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. TOPRAKLAMA MEDİTASYONU
Her gün en az 10 dakika çıplak ayakla toprağa bas.
Enerji bedeninden toprağa akışını hisset.

2. DUYUSAL ŞÖLEN RİTÜELİ
Haftada bir, tüm duyularını şımartacak bir deneyim yarat.
Güzel yemek, güzel müzik, güzel kokular, yumuşak dokular.

3. BEDEN FARKINDALIĞI
Yoga, tai chi ya da basitçe germe hareketleri. Her gün
bedeninle iletişim kur, gerginlikleri fark et.

4. DOĞA BANYOSU
Haftada en az bir kez uzun bir doğa yürüyüşü. Acele etme,
sadece ol. Kuşları dinle, çiçekleri kokla.

5. MADDİ DÜNYAYLA BARIŞ
Paranla, eşyalarınla, bedeninin ihtiyaçlarıyla barış yap.
Madde düşman değil, ruhun bu dünyadaki aracı.

6. SADELİK PRATİĞİ
Hayatını sadeleştir. Gereksiz dramaları, karmaşık durumları,
toksik ilişkileri temizle. Less is more.

7. ŞÜKRAN GÜNLÜĞÜ
Her gece yatmadan önce, o günün 5 basit güzelliğini yaz.
Kahvenin kokusu, güneşin sıcaklığı, rahat bir yatak...
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Akrep Gölgesi (Bırakılması Gereken):
- Kontrol takıntısı ve manipülasyon
- Sürekli kriz ve drama yaratma
- İntikam ve kin tutma
- Güvensizlik ve paranoya
- Başkalarının sırlarını silah olarak kullanma
- Cinsel enerjinin karanlık kullanımı
- "Ya hep ya hiç" yaklaşımı

Boğa Gölgesi (Aşırıya Kaçmamak Gereken):
- İnatçılık ve değişime direnç
- Maddi bağımlılık ve açgözlülük
- Konfor alanına hapsolma
- Tembellik ve durgunluk
- Sahip olma takıntısı
- Değişimden aşırı korku

Denge Noktası:
Hem dönüşüme açık hem istikrarlı. Hem derin hem basit.
Hem tutkulu hem huzurlu. Yaşamın tüm boyutlarını kucaklamak.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Psikolojik derinlik ve insanları okuma yeteneği
• Krizlerde soğukkanlılık ve dayanıklılık
• Dönüşüm süreçlerini yönetme kapasitesi
• Gizli bilgilere erişim ve sezgi gücü
• Ölüm-yeniden doğuş döngülerini anlama
• Şifa ve terapi yeteneği
• Tabuları yıkma cesareti
• Derin duygusal bağlar kurabilme

Bu armağanları reddetme - onları Boğa huzuruyla birleştir.
Hem derinlik hem istikrar. Hem şifa hem güvenlik.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata topraklanmış huzurun değerini öğrenmek ve öğretmek
için geldin. Görevin, sürekli kriz ve dönüşüm modundan çıkarak
hayatın basit güzelliklerinde anlam bulmak.

Bu, derin yanını reddetmek demek değil. Aksine, o derinliği
gündelik hayatın içine taşımak. Bir fincan çay içerken bile
tam orada, tam şimdide olmak. Basitliğin içindeki kutsallığı
görmek.

Somut Misyon Alanları:
- Sanat, zanaat ve el becerileri
- Doğa ve çevre çalışmaları
- Finansal istikrar ve güvenlik oluşturma
- Duyusal terapiler (masaj, aromaterapi)
- Yemek ve beslenme
- Başkalarına topraklanma öğretme
''',
    affirmations: [
      'Hayat basit olduğunda da değerli ve anlamlıdır.',
      'Bedenim kutsal bir tapınak, ona iyi bakıyorum.',
      'Güvenmeyi ve teslim olmayı seçiyorum.',
      'Huzur, zayıflık değil güç işaretidir.',
      'Bugünün basit güzellikleri için şükrediyorum.',
      'Kontrol etmeye değil, akışa güveniyorum.',
      'Kendi değerimi biliyorum, kanıtlamam gerekmiyor.',
      'Toprağa kök salıyorum, göğe dal uzatıyorum.',
    ],
  ),

  'gemini_sagittarius': const NodePlacement(
    sign: 'İkizler/Yay Ekseni',
    northNodeTitle: 'Kuzey Düğüm İkizler\'de - Merakın Dansı',
    southNodeTitle: 'Güney Düğüm Yay\'da - Bilge Gezginin Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen büyük resimlerin, evrensel hakikatlerin ve
yüce ideallerin peşinde koştun. Belki bir filozof, bir din adamı,
bir gezgin, bir öğretmen ya da bir yayıncıydın. Uzak diyarları
keşfettin, farklı kültürleri tanıdın, büyük sistemler ve teoriler
geliştirdin.

Bilgeliğe susuzluğun doyurulamazdı. Her zaman "daha büyük anlam"
aradın. Doğruyu bulduğuna inandığında onu herkese yaymak istedin -
bazen biraz fazla coşkuyla, bazen başkalarının bakış açılarını
göz ardı ederek.

Ruhun şimdi bu büyük resim tutkusunu dengelemek, küçük detayların
ve gündelik iletişimin değerini keşfetmek için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. DİNLEMENİN BİLGELİĞİ
Sürekli öğretmek yerine öğrenmeye açık olmak. Senin hakikatin,
tek hakikat olmayabilir. Merak, cevaplardan daha değerli.

2. KÜÇÜK DETAYLARIN ÖNEMİ
Büyük resme takılıp detayları kaçırma. Hayat, büyük anlardan
çok küçük anların toplamıdır.

3. YEREL VE YAKIN
Hep uzaklara bakmak yerine, yakınındakileri gerçekten tanımak.
Komşun, en uzak ülke kadar ilginç olabilir.

4. ESNEK DÜŞÜNCE
"Bu kesinlikle böyle" yerine "belki böyle olabilir". Dogmadan
merakA, kesinlikten olasılığa geçiş.

5. İLETİŞİM SANATI
Bilgiyi aktarmak kadar, diyalog kurabilmek. Monologdan
sohbete, vaazdan paylaşıma.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Yay'ın büyük bilgeliğini İkizler'in meraklı
iletişimine dönüştürmekten geçiyor. Bilge olmak yetmez,
gerçek bağlantı kurmak gerekir.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
"Her şeyi biliyorum" tutumunu fark etmek. Başkalarının
gözlerindeki bıkkınlığı görmek. Neden kimse sormuyor?

AŞAMA 2 - MERAK PRATIĞI
Bildiklerini bir kenara koyup gerçekten sormayı denemek.
"Anlat bakalım, sen ne düşünüyorsun?"

AŞAMA 3 - ÇİFT YÖNLÜ İLETİŞİM
Hem konuşmak hem dinlemek. Hem öğretmek hem öğrenmek.
Diyaloğun dans gibi olduğunu keşfetmek.

AŞAMA 4 - BİLGELİĞİN MERAKLA EVLİLİĞİ
Derin bilgiyi hafif, erişilebilir, meraklı bir tarzda
paylaşabilmek. Guru değil, arkadaş olmak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Nefes ve Söz

Bu düğüm ekseninde tantrik çalışma, nefesin ve sözün kutsal
gücünü keşfetmeyi içerir. İkizler hava burcu - prana, nefes,
iletişim burada birleşir.

Vishuddha (Boğaz) Çakra Çalışması:
Boğaz çakrası, otantik ifade ve dinleme merkezidir. Bu çakra
dengelendiğinde hem konuşmak hem dinlemek doğal akar.

Pratik: Boğaz çakrasına odaklı nefes. Nefes alırken mavi ışık
boğazı dolduruyor, verirken sesle "HAM" mantrası.

Kutsal Sohbet Pratiği:
Tantrada "satsang" - hakikat sohbeti. Ama bu tek yönlü vaaz
değil, karşılıklı keşif. Bir konuyu partneinle birlikte
araştır, her ikiniz de öğretmen ve öğrenci.

Nefes Senkronizasyonu:
Partnerinle yüz yüze oturup nefesleri senkronize etmek.
Sözsüz iletişimin gücünü deneyimlemek. Bazen kelimeler
engel, nefes köprü.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. AKTİF DİNLEME PRATIĞI
Her gün en az bir sohbette, cevap vermeden önce 3 saniye
bekle. Gerçekten ne dediğini anladığından emin ol.

2. MERAK SORULARI
"Bu konuda daha fazla anlat" "Nasıl hissettirdi bu sana?"
"Ne düşündürdü?" Kendi fikrini söylemeden sor.

3. YEREL KEŞİF
Her hafta yaşadığın şehirde yeni bir yer keşfet. Uzak
diyarları hayal etmek yerine, yakınındakini tanı.

4. KISA YAZILAR
Büyük kitap yazmak yerine, kısa notlar, tweetler, mesajlar.
Az sözle çok şey söyleme pratiği.

5. ÇİFT YÖNLÜ ÖĞRENME
Bir şey öğretirken, karşındakinden de bir şey öğren.
Her etkileşim karşılıklı keşif olsun.

6. FARKLI BAKIŞ AÇILARI
Kendi inançlarının tam tersini savunan bir kitap oku.
"Eğer yanılıyorsam?" sorusunu sor.

7. GÜNLÜK SOHBETLER
Derin felsefi tartışmalar yerine, hafif gündelik sohbetler.
Hava durumunu konuşmak da bağlantı kurmaktır.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Yay Gölgesi (Bırakılması Gereken):
- Dogmatizm ve "ben haklıyım" tutumu
- Başkalarına vaaz verme, öğüt yağdırma
- Aşırı iyimserlik ve gerçeklikten kopukluk
- Kültürel üstünlük taslama
- Dinlemeden konuşma
- Her şeyi genelleme
- Uzağa bakıp yakını kaçırma

İkizler Gölgesi (Aşırıya Kaçmamak Gereken):
- Yüzeysellik ve derinlikten kaçınma
- Dedikodu ve boş laf
- Odak eksikliği, çok fazla ilgi alanı
- Tutarsızlık ve değişkenlik
- Bilgiyi manipülasyon için kullanma
- Duygusal mesafe

Denge Noktası:
Hem bilge hem meraklı. Hem öğretmen hem öğrenci. Hem derin
hem erişilebilir. Hem vizyoner hem detaycı.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Büyük resmi görme yeteneği
• Farklı kültürleri ve felsfeleri anlama
• İlham verici konuşma ve öğretme kapasitesi
• İyimserlik ve inanç gücü
• Macera ruhu ve cesaret
• Anlamlandırma ve sentez yeteneği
• Vizyon ve strateji geliştirme
• Doğruluk ve etik anlayışı

Bu armağanları reddetme - onları İkizler merakıyla birleştir.
Hem bilgelik hem öğrenmeye açıklık. Hem vizyon hem detay.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata merakın bilgeliğini öğrenmek ve öğretmek için
geldin. Görevin, "bilge guru" pozisyonundan inerek gerçek
bağlantı kurmak, dinlemek, sormak, birlikte keşfetmek.

Bu, bilgeliğini reddetmek demek değil. Aksine, onu daha
erişilebilir, daha insani, daha diyaloğa açık bir şekilde
paylaşmak. Cevapları vermek yerine soruları birlikte sormak.

Somut Misyon Alanları:
- İletişim ve medya
- Yazarlık ve gazetecilik
- Eğitim ve koçluk (interaktif)
- Sosyal medya ve içerik üretimi
- Çeviri ve arabuluculuk
- Yerel topluluk çalışmaları
''',
    affirmations: [
      'Sormak, söylemek kadar değerlidir.',
      'Herkesin öğretecek bir şeyi var, herkesten öğrenebilirim.',
      'Küçük anlar da büyük anlam taşır.',
      'Merak, bilgiden daha değerli bir hazinedir.',
      'Yakınımdaki dünya da keşfedilmeye değer.',
      'Bilmediğimi kabul etmek özgürlüktür.',
      'Diyalog, monologdan daha güçlüdür.',
      'Hafiflik ve derinlik bir arada olabilir.',
    ],
  ),

  'cancer_capricorn': const NodePlacement(
    sign: 'Yengeç/Oğlak Ekseni',
    northNodeTitle: 'Kuzey Düğüm Yengeç\'te - Eve Dönüş',
    southNodeTitle: 'Güney Düğüm Oğlak\'ta - Yapı Ustasının Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen başarının, otoritenin ve toplumsal statünün
peşinde koştun. Belki bir yönetici, bir politikacı, bir iş insanı,
bir askeri lider ya da bir köklü ailenin reisiydin. Yapı kurmak,
hedeflere ulaşmak, zirveye tırmanmak senin doğandı.

Disiplin ve kararlılık sayesinde büyük başarılara imza attın. Ama
bu başarılar için bedeller ödendi - belki ailenle bağını kaybettin,
belki duygularını bastırdın, belki "güçlü" görünmek için savunmasız
olmaktan kaçındın.

Ruhun şimdi bu başarı odaklı yaklaşımı dengelemek, duygusal dünyasını
onurlandırmak ve "eve" dönmek için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. SAVUNMASIZLIĞIN GÜCÜ
Güçlü görünmek için duygularını bastırmayı bırak. Gözyaşları
zayıflık değil, insan olmanın işareti.

2. AİLE VE KÖK
Kariyer ne kadar önemli olursa olsun, gerçek tatmin yakın
ilişkilerde ve ait olma duygusunda yatıyor.

3. BAKIM VE BESLENME
Sadece üretmek, başarmak değil - beslemek, büyütmek, korumak
da var. Annelik enerjisi (cinsiyetten bağımsız).

4. DUYGUSAL ZEKA
IQ kadar EQ da önemli. Duyguları yönetmek, değil bastırmak.
Empati ve şefkat geliştirmek.

5. EV VE GÜVENLIK
Dış dünyada ne kadar başarılı olursan ol, içte güvende
hissetmezsen anlamsız. İç huzuru bulmak.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Oğlak'ın yapıcı disiplinini Yengeç'in besleyici
şefkatine dönüştürmekten geçiyor. Başarmak kadar ait olmak da önemli.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
İş-yaşam dengesizliğini fark etmek. Başarı için neler feda
edildi? Kimler ihmal edildi?

AŞAMA 2 - RAHATSIZLIK
Duygusal yakınlıktan rahatsız olmak. Savunmasızlık korkusu.
"Bağımlı" görünme endişesi.

AŞAMA 3 - YUMUŞAMA
Duvarları yavaş yavaş indirmek. Güvenilir insanlara açılmak.
Gözyaşlarına izin vermek.

AŞAMA 4 - ENTEGRASYON
Hem güçlü hem yumuşak. Hem başarılı hem bağlı. Hem disiplinli
hem şefkatli. İkisini de kucaklamak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Ay Enerjisi ve Şefkat

Bu düğüm ekseninde tantrik çalışma, ay enerjisini (Yengeç) ve
kalp merkezini dengelemek içerir.

Anahata (Kalp) Çakra Çalışması:
Kalp çakrası sevgi ve şefkatin merkezidir. Oğlak gölgesi kalbi
kapatır - "zayıf görünmemek için". Şifa, kalbi yeniden açmakta.

Pratik: Kalp çakrasına eller. Nefesle yeşil ışık kalbe akıyor.
"YAM" mantrası. Kendine şefkat gönder - "Ben sevilmeye değerim".

Ay Döngüsü Çalışması:
Yengeç Ay tarafından yönetilir. Ay döngülerini takip etmek,
duygusal döngüleri anlamak ve onurlandırmak şifa getirir.
Dolunay'da duygusal salıverim, yeni ay'da içe dönüş.

İç Çocuk Çalışması:
Tantrada "kumara" - içimizdeki çocuk. Oğlak enerjisi çocuğu
erken olgunlaştırır. Şifa, iç çocukla yeniden bağ kurmakta.
Oynamak, gülmek, saçmalamak.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. EV RİTÜELLERİ
Evini kutsal bir alan haline getir. Mumlar, bitkiler, sıcak
renkler. Eve döndüğünde derin bir nefes al - "Evdeyim."

2. AİLE BAĞLARI
Ailenle (kan bağı ya da seçilmiş) düzenli zaman geçir.
Birlikte yemek, sohbet, anılar.

3. DUYGUSAL GÜNLÜK
Her gün duygularını yaz. Ne hissediyorsun? Neden? Duyguları
analiz etme, sadece tanı ve kabul et.

4. BAKIM PRATIĞI
Başka bir canlıya bak - bitki, hayvan, insan. Beslemek,
büyütmek, korumak pratiği.

5. İÇ ÇOCUK ÇALIŞMASI
Çocukluğundaki evin fotoğraflarına bak. O çocuğa mektup yaz.
Küçükken sevdiğin aktiviteleri yeniden yap.

6. AY MEDİTASYONU
Dolunay gecelerinde dışarıda otur, ay ışığında banyo yap.
Ay enerjisinin seni beslediğini hisset.

7. AĞLAMA PRATIĞI
Gözyaşlarına izin ver. Hüzünlü bir film izle, müzik dinle.
Ağlamak arınmadır, zayıflık değil.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Oğlak Gölgesi (Bırakılması Gereken):
- İş-aholizm ve başarı takıntısı
- Duygusal soğukluk ve mesafe
- Kontrol ihtiyacı
- "Zayıf" görünme korkusu
- Statü ve imaj odaklılık
- Aşırı ciddiyet
- Duygusal ihtiyaçları küçümseme

Yengeç Gölgesi (Aşırıya Kaçmamak Gereken):
- Aşırı duygusallık ve alınganlık
- Yapışkan ve bağımlı ilişkiler
- Geçmişe takılma
- Aşırı korumacılık
- Pasif-agresif davranışlar
- Kurban rolü

Denge Noktası:
Hem güçlü hem yumuşak. Hem bağımsız hem bağlı. Hem başarılı
hem şefkatli. Kariyer ve aile, yapı ve yuva birlikte.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Yapı kurma ve organizasyon yeteneği
• Hedef belirleme ve gerçekleştirme kapasitesi
• Disiplin ve kararlılık
• Liderlik ve yönetim becerileri
• Uzun vadeli düşünme
• Sorumluluk bilinci
• Toplumsal saygınlık oluşturma
• Pratik zeka ve problem çözme

Bu armağanları reddetme - onları Yengeç şefkatiyle birleştir.
Hem yapıcı hem besleyici. Hem başarılı hem bağlantılı.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata duygusal zekanın ve ait olmanın değerini öğrenmek
ve öğretmek için geldin. Görevin, başarı ve kariyer odaklı
yaklaşımı dengeleyerek gerçek bağlar kurmak, savunmasız olmaya
cesaret etmek, "eve dönmek".

Bu, başarıyı reddetmek demek değil. Aksine, gerçek başarının
ne olduğunu yeniden tanımlamak. Bir zirve ama yalnız mı?
Yoksa sevdiklerinle birlikte bir yaşam mı?

Somut Misyon Alanları:
- Aile ve çocuk bakımı
- Ev ve gayrimenkul
- Psikoterapi ve danışmanlık
- Topluluk oluşturma
- Gastronomi ve beslenme
- Kadın ve anne sağlığı
''',
    affirmations: [
      'Duygularım değerli ve geçerlidir.',
      'Savunmasız olmak güç gerektirir.',
      'Eve ait olmak başarının kendisidir.',
      'Sevgi ve bağlantı için zaman ayırıyorum.',
      'İç çocuğumu sevgiyle kucaklıyorum.',
      'Başarı ve şefkat bir arada olabilir.',
      'Gözyaşlarım beni arındırıyor.',
      'Ailem (kan ya da seçilmiş) benim köklerim.',
    ],
  ),

  'leo_aquarius': const NodePlacement(
    sign: 'Aslan/Kova Ekseni',
    northNodeTitle: 'Kuzey Düğüm Aslan\'da - Kalbin Tahtı',
    southNodeTitle: 'Güney Düğüm Kova\'da - Visyonerin Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen toplumsal davaların, kolektif ideallerin ve
insanlığın geleceğinin savunucusuydum. Belki bir devrimci, bir icatçı,
bir sosyal reformcu, bir bilim insanı ya da bir topluluk lideriydin.
Bireysel arzulardan çok grubun iyiliğini, kişisel dramalardan çok
evrensel ilkeleri önemsedin.

Objektiflik ve tarafsızlık senin için erdemdi. Duygusal "drama"dan
uzak durarak büyük resmi gördün, sistemler tasarladın, toplumsal
değişim için çalıştın.

Ama bu süreçte bir şey eksik kaldı: SENİN kalbin. Kendi arzuların,
kendi parıltın, kendi benzersiz ifaden. Ruhun şimdi bu bireyselliği
kutlamak için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. KENDİ IŞIĞINI PARLATMA
Kolektife karışıp kaybolmak yerine, kendi benzersiz ışığını
parlatmaya cesaret et. Sen özelsin - bunu kutla.

2. KALP MERKEZLİ YAŞAM
Sadece akıl ve ideallerle değil, kalple de yaşamak. Sevgi,
tutku, yaratıcılık - duygusal ifade.

3. SAHNEYE ÇIKMA
Geri planda kalmak yerine öne çıkmak. Alkış almaktan, takdir
edilmekten korkmamak. Sen bunu hak ediyorsun.

4. ÇOCUKSU NEŞE
Ciddi dünya sorunlarından bir mola verip oynamak, eğlenmek,
yaratmak. İç çocuğunu özgürleştirmek.

5. ROMANTIK AŞK
Arkadaşlık güzel ama romantik tutku da var. Aşkın ateşine
atılmaya cesaret etmek.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Kova'nın vizyoner zekasını Aslan'ın kalp ateşine
dönüştürmekten geçiyor. İnsanlığı sevmek yetmez, birey olarak
da sevilmeli ve sevmelisin.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
"Ben önemsiz, davamız önemli" inancını sorgulamak. Neden kendi
ışığından kaçıyorsun? Neden görünür olmaktan korkuyorsun?

AŞAMA 2 - RAHATSIZLIK
İlgi odağı olmak rahatsız edici. "Bu kadar ego mu?" Ama belki
de sağlıklı bir ego, sağlıklı katkının temelidir.

AŞAMA 3 - İFADE
Yaratıcılığınla kendini ifade etmeye başlamak. Sanat, performans,
liderlik - ne olursa olsun, SEN ol.

AŞAMA 4 - ENTEGRASYON
Hem bireysel parıltı hem toplumsal katkı. Hem ego hem hizmet.
Işığını parlatarak başkalarını da aydınlatmak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Kalp Ateşi ve Yaratıcı Enerji

Bu düğüm ekseninde tantrik çalışma, kalp çakrasının ateş
elementini ve yaratıcı/cinsel enerjiyi içerir.

Anahata ve Manipura Birliği:
Aslan kalp (Anahata) ve solar pleksus (Manipura) arasında köprü
kurar. Her iki merkezi de aktive etmek - sevgi ile gücün birliği.

Pratik: Kalbe el koy, güneş ışığı gibi altın bir ışık kalbi
dolduruyor. "Ben parlamaya değerim" mantrası.

Yaratıcı Cinsel Enerji:
Tantrada cinsel enerji, saf yaratıcı güçtür. Aslan bu enerjiyi
sanatsal ve performatif ifadeye dönüştürür. Cinsel enerjiyi
bastırma, onu yarat, dans et, şarkı söyle.

İç Çocuk ve Oyun:
Aslan, burclar kuşağının çocuğudur. Tantrik şifa, bu iç çocukla
oynamayı içerir. Ciddiyet bırak, eğlen, saçmala, yaratıcı ol.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. YARATICI İFADE
Resim yap, dans et, şarkı söyle, tiyatro oyna, yazı yaz -
ne olursa olsun, yaratıcılığını özgürleştir. Sonuç önemli değil.

2. SAHNE PRATIĞI
Küçük de olsa "sahneye çık". Toplantıda söz al, karaoke yap,
bir etkinlik düzenle. Görünür olmayı pratik et.

3. AYNADAKI SEN
Her sabah aynada kendine gülümse ve de ki: "Sen harikasın.
Bugün ışığını parlat."

4. ÇOCUKSU OYUN
Bir çocuk gibi oyna - park, oyun hamuru, boyama kitabı.
Ciddiyeti bir kenara bırak.

5. ROMANTİZM
Hayatına romantizm ekle - kendine çiçek al, mum ışığında
yemek ye, aşk filmleri izle.

6. İLTİFAT ALMA PRATIĞI
Biri seni övdüğünde "teşekkür ederim" de ve hisset.
Küçümseme, reddetme, sadece al.

7. GÜNEŞ BANYOSU
Her gün güneşte vakit geçir. Güneş Aslan'ın yöneticisi -
ışığını emip içine al.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Kova Gölgesi (Bırakılması Gereken):
- Duygusal mesafe ve soğukluk
- "Ben önemli değilim, davamız önemli" tutumu
- Bireyselliği küçümseme
- İnatçı entelektüalizm
- Samimiyetten kaçınma
- Aşırı bağımsızlık, bağlanamama
- Kalabalıkta kaybolma

Aslan Gölgesi (Aşırıya Kaçmamak Gereken):
- Aşırı ego ve kibirlilik
- Dikkat çekme takıntısı
- Eleştiriye tahammülsüzlük
- Herkesin kendine hayran olmasını bekleme
- Drama kraliçesi/kralı olmak
- Başkalarını gölgede bırakma

Denge Noktası:
Hem birey hem toplumun parçası. Hem özel hem evrensel. Hem
parlak hem mütevazı. Işığını paylaşarak herkesi aydınlatmak.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Vizyoner düşünce ve geleceği görme yeteneği
• Toplumsal sistemleri anlama kapasitesi
• Objektiflik ve tarafsızlık
• İnsanlık için çalışma tutkusu
• Yenilikçilik ve özgün fikirler
• Arkadaşlık ve topluluk kurma
• Farklılıkları kucaklama
• Teknoloji ve bilim anlayışı

Bu armağanları reddetme - onları Aslan kalbiyle birleştir.
Hem vizyoner hem tutkulu. Hem toplumsal hem bireysel.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata kendi ışığını parlatmanın suç olmadığını öğrenmek
ve öğretmek için geldin. Görevin, kolektifin içinde kaybolmaktan
çıkarak benzersiz kendini dünyaya sunmak.

Bu, toplumsal ideallerden vazgeçmek demek değil. Aksine, gerçek
katkının ancak otantik bireylerden gelebileceğini göstermek.
Sen benzersizsin - bu armağanı saklamak, onu dünyadan çalmaktır.

Somut Misyon Alanları:
- Performans sanatları
- Liderlik ve yönetim
- Çocuklarla çalışma
- Yaratıcı girişimcilik
- Moda ve tasarım
- Eğlence sektörü
''',
    affirmations: [
      'Işığımı parlatmak benim hakkım ve görevimdir.',
      'Ben benzersizim ve bu dünyaya katkım özel.',
      'Kalbimin ateşini özgürce ifade ediyorum.',
      'Sevilmeyi ve takdir edilmeyi hak ediyorum.',
      'Yaratıcılığım özgürce akıyor.',
      'Sahneye çıkmak benim için güvenli.',
      'İç çocuğum özgürce oynuyor.',
      'Bireyselliğim, kolektife katkımı güçlendiriyor.',
    ],
  ),

  'virgo_pisces': const NodePlacement(
    sign: 'Basak/Balık Ekseni',
    northNodeTitle: 'Kuzey Düğüm Başak\'ta - Kutsalın Gündeliği',
    southNodeTitle: 'Güney Düğüm Balık\'ta - Mistik Rüyacının Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen ruhani dünyanın, mistik deneyimlerin ve sınırları
aşmanın ustasıydın. Belki bir derviş, bir keşiş, bir şaman, bir sanatçı
ya da bir şifacıydın. Maddi dünyanın ötesinde, görünmeyenin peşinde
yaşadın. Meditasyon, trans, sanat, müzik - bunlar senin aracındı.

Sınırları eritmek, evrenle birleşmek, egoyu aşmak senin uzmanlığındı.
Ama bazen o kadar "ötede" yaşadın ki, "burada" olamadın. Gündelik
hayat, pratik sorumluluklar, detaylar - bunlar seni sıktı.

Ruhun şimdi bu mistik yetenekleri topraklamak, ruhaniliği gündelik
hayata taşımak için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. TOPRAKLANMIŞ SPİRİTÜELLİK
Bulutların üstünde yaşamak yerine, ayakları yere basmış bir
ruhanilik. Gündelik hayat da kutsal.

2. DETAYLARIN ÖNEMİ
Büyük resimde kaybolmak yerine, küçük parçalara dikkat.
Tanrı detaylarda gizli.

3. HİZMET PRATIĞI
Soyut sevgi yerine, somut hizmet. Fiilen bir şeyler yapmak,
elle tutulur yardım.

4. SAĞLIK VE BEDEN
Bedeni aşmak yerine, bedenle çalışmak. Sağlık rutinleri,
beslenme, egzersiz.

5. ANALİZ VE AYIRT ETME
Her şeyi kabul etmek yerine, ayırt etmek. Neyin işe yarayıp
neyin yaramadığını görmek.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Balık'ın mistik bilgeliğini Başak'ın pratik
hizmetine dönüştürmekten geçiyor. Rüya görmek yetmez, onu
gerçekliğe taşımak gerekir.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Kaçış kalıplarını fark etmek. Neden gerçeklikten uzaklaşıyorsun?
Hangi sorumluluklardan kaçıyorsun?

AŞAMA 2 - RAHATSIZLIK
Rutin ve detaylar bunaltıcı. "Bu kadar sıradan" olmak istemiyorsun.
Ama belki sıradanlıkta da kutsallık var.

AŞAMA 3 - PRATIK ADIMLAR
Küçük ama somut adımlar atmaya başlamak. Günlük rutinler,
sağlık alışkanlıkları, organize olmak.

AŞAMA 4 - ENTEGRASYON
Hem mistik hem pratik. Hem rüyacı hem gerçekçi. Gündelik
hayatı kutsal bir hizmet olarak yaşamak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Kutsalın Gündeliği

Bu düğüm ekseninde tantrik çalışma, sıradanlığın içindeki
kutsallığı keşfetmeyi içerir.

Karma Yoga (Eylem Yogası):
Başak enerjisi, her eylemin bir ibadet olabileceğini öğretir.
Bulaşık yıkamak, evi temizlemek, işe gitmek - her şey kutsal
hizmet olabilir.

Pratik: Her gün bir "sıradan" aktiviteyi tam dikkatle yap.
Çay demlerken sadece çay demle. Her adımı kutsal bir ritüel gibi.

Beden Tapınağı:
Balık bedeni aşmak ister, Başak onu onurlandırır. Beden bir
yük değil, ruhun evi. Sağlıklı beslenme, temizlik, egzersiz -
bunlar tantrik pratiklerdir.

Hizmet Meditasyonu:
Birine yardım ederken, o kişide ilahiyi gör. Hizmet, ego
tatmini için değil, birliği deneyimlemek için.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. GÜNLÜK RUTİNLER
Sabah ve akşam rutinleri oluştur. Aynı saatlerde kalk ve yat.
Düzen, kaotik Balık enerjisini topraklar.

2. BEDEN DETOKS
Beslenme detoksu, dijital detoks, ortam temizliği. Bedenini
ve çevreni arındır.

3. HİZMET PRATIĞI
Haftada en az bir kez somut bir hizmet yap - gönüllülük,
yardım, destek. Fiili, elle tutulur.

4. LİSTE YAPMA
Yapılacaklar listesi tut. Her gün üç öncelikli iş belirle
ve tamamla. Küçük başarıları kutla.

5. SAĞLIK KONTROLLERİ
Düzenli sağlık kontrolleri, diş hekimi, göz doktoru.
Bedenine dikkat et.

6. BİLİNÇLİ BESLENME
Ne yediğine dikkat et. Organik, doğal, besleyici gıdalar.
Yemek yemeyi bir meditasyon yap.

7. DOĞA YÜRÜYÜŞÜ
Haftada en az bir doğa yürüyüşü. Mistik deneyimi toprakla
buluştur. Ağaçlara dokun, toprağı kokla.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Balık Gölgesi (Bırakılması Gereken):
- Kaçışçılık (uyku, madde, fantezi)
- Kurban rolü ve şikayet
- Sınır koyamama
- Gerçeklikten kopukluk
- Sorumluluktan kaçınma
- Aşırı duygusallık ve ağlama krizleri
- "Kimse anlamıyor" tutumu

Başak Gölgesi (Aşırıya Kaçmamak Gereken):
- Aşırı eleştirellik ve mükemmeliyetçilik
- Detaylarda boğulma
- Obsesif düzen takıntısı
- Sağlık kaygısı
- Başkalarını yargılama
- İş-aholizm

Denge Noktası:
Hem mistik hem pratik. Hem rüyacı hem gerçekçi. Hem şefkatli
hem ayırt edici. Ruhaniliği gündelik hayata taşımak.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Derin sezgi ve psişik yetenekler
• Sanatsal ve müzikal duyarlılık
• Şefkat ve empati kapasitesi
• Mistik deneyimlere açıklık
• Şifa enerjisi ve el gücü
• İlham ve vizyon
• Koşulsuz sevgi anlayışı
• Ego ötesi bilinç deneyimi

Bu armağanları reddetme - onları Başak pratikliğiyle birleştir.
Hem ilham hem eylem. Hem vizyon hem uygulama.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata ruhaniliği gündelik hayata taşımayı öğrenmek
ve öğretmek için geldin. Görevin, mistik deneyimleri pratik
hizmete dönüştürmek, kutsal olanı sıradan olanda bulmak.

Bu, mistik yanını reddetmek demek değil. Aksine, onu
topraklamak, somutlaştırmak, başkalarına ulaştırmak.
Bir derviş gibi değil, bir terzi gibi - her dikişte ibadet.

Somut Misyon Alanları:
- Sağlık ve şifa meslekleri
- Organizasyon ve planlama
- Gönüllü çalışma
- Beslenme ve diyet danışmanlığı
- Veterinerlik ve hayvan bakımı
- Çevre ve sürdürülebilirlik
''',
    affirmations: [
      'Gündelik hayat da kutsal ve değerli.',
      'Küçük adımlar büyük yolculukların başlangıcıdır.',
      'Bedenime iyi bakmak ruhani bir pratiktir.',
      'Her hizmet, ilahiye bir dua.',
      'Detaylar benim dostum, düşmanım değil.',
      'Topraklanmış olmak, ruhani olmamak değildir.',
      'Rutin ve düzen bana güvenlik veriyor.',
      'Pratik olmak, rüyalarımı gerçeğe taşıyor.',
    ],
  ),

  'libra_aries': const NodePlacement(
    sign: 'Terazi/Koç Ekseni',
    northNodeTitle: 'Kuzey Düğüm Terazi\'de - İlişkinin Aynası',
    southNodeTitle: 'Güney Düğüm Koç\'ta - Savaşçının Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen bağımsızlığın, bireyselliğin ve öncülüğün
ustasıydın. Belki bir savaşçı, bir kaşif, bir atlet, bir lider ya
da kendi yolunu tek başına açan biriydin. Kendi gücüne güvenmek,
risk almak, ilk adımı atmak senin doğandı.

"Ben" her zaman ön plandaydı. Kararlarını kimseye danışmadan verdin,
yoluna tek başına devam ettin, rakiplerini geçtin. Ama bu süreçte
bir şey eksik kaldı: BAŞKALARI. Birlikte olmanın, uzlaşmanın,
paylaşmanın değeri.

Ruhun şimdi bu bireyselliği dengelemek, ilişki aracılığıyla kendini
tanımak, "biz" olmayı öğrenmek için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. İLİŞKİDE KENDİNİ BULMAK
"Ben kimim?" sorusunu "biz" bağlamında cevaplamak. İlişki
bir hapishane değil, kendini tanımanın aynası.

2. UZLAŞMA SANATI
Her zaman kazanmak zorunda değilsin. Bazen geri adım atmak,
orta yol bulmak gerçek güçtür.

3. BAŞKASINI DÜŞÜNMEK
Kendi ihtiyaçlarından önce (bazen) başkasının ihtiyaçlarını
görmek. Empati ve şefkat.

4. DİPLOMASİ VE ZARAFET
Kaba kuvvet yerine incelik. Savaşmak yerine müzakere.
Kazanmak yerine birlikte kazan-kazan.

5. GÜZELLİK VE UYUM
Sürekli eylem ve mücadele yerine, güzelliği ve uyumu
takdir etmeye zaman ayırmak.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Koç'un cesur bireyselliğini Terazi'nin zarif
ilişkiselliğine dönüştürmekten geçiyor. Tek başına güçlü olmak
yetmez, birlikte güçlü olmayı da öğrenmelisin.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
İlişkilerdeki kalıpları fark etmek. Neden hep ayrılıyorsun?
Neden uzun süreli bağ kuramıyorsun?

AŞAMA 2 - RAHATSIZLIK
Bağımlı hissetme korkusu. "Özgürlüğümü kaybediyorum" hissi.
Ama belki bağlılık, tutsaklık değil.

AŞAMA 3 - DENEME
İlişkide kalmayı denemek. Uzlaşmayı, dinlemeyi, paylaşmayı
pratik etmek. Zor ama öğretici.

AŞAMA 4 - ENTEGRASYON
Hem birey hem partner. Hem bağımsız hem bağlı. İlişki içinde
bireyselliği korumak, bireyselliği ilişkiye taşımak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Kutsal Birlik ve Ayna

Bu düğüm ekseninde tantrik çalışma, ilişkinin kutsal ayna
olarak kullanılmasını içerir.

Shiva-Shakti Birliği:
Koç (Shiva) ve Terazi (Shakti) enerjilerinin birleşimi.
Tek başına var olmak ile birlikte var olmak arasındaki dans.

Pratik: Partner meditasyonu. Yüz yüze oturup birbirinizin
gözlerine bakın. Ayrı iki varlık olarak başla, sonra ortak
nefesle birliği hisset.

Ayna Pratiği:
Partnerinde seni rahatsız eden şeyler, senin gölgendir.
Partnerinde sevdiğin şeyler, senin potansiyelin.
Her ilişki, kendini tanımak için bir fırsat.

Cinsel Birlik:
Tantrada cinsel birleşme, iki enerjinin dans ederek birliğe
ulaşması. Sadece fiziksel değil, enerjetik birleşme.
Koç hızını Terazi zarafetine dönüştürmek.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. DİNLEME PRATİĞİ
Birisiyle konuşurken, cevap vermeden önce gerçekten dinle.
Ne söylüyor? Ne hissediyor? Sadece dinle.

2. UZLAŞMA DENEYİMİ
Her tartışmada "ikimiz de kazanabilir miyiz?" sor. Orta
yol ara. Her zaman haklı olmak zorunda değilsin.

3. GÜZELLIK TAKDIRI
Her gün bir güzelliği fark et ve takdir et - bir tablo,
bir çiçek, bir gülümseme. Güzellik meditasyonu.

4. İLİŞKİ NİYETİ
Her ilişkiye (romantik olmasa bile) bir niyet koy:
"Bu kişiden ne öğrenebilirim?"

5. DANS PRATIĞI
Partner dansı öğren - tango, salsa, vals. Birlikte hareket
etmeyi, liderliği paylaşmayı deneyimle.

6. İLTİFAT VERME
Her gün en az üç kişiye samimi iltifat et. Başkalarında
güzeli görme pratiği.

7. BARIŞMA RİTÜELİ
Bir tartışmadan sonra, kırgınlığı bırakma ritüeli.
Sarılmak, "özür dilerim" demek, yeniden başlamak.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Koç Gölgesi (Bırakılması Gereken):
- Aşırı bencillik ve ben-merkezcilik
- Her şeyi rekabet olarak görme
- Öfke ve saldırganlık
- Sabırsızlık ve acelecilik
- Başkalarını ezme eğilimi
- "Ben bilirim" tutumu
- Yalnız kurt sendromu

Terazi Gölgesi (Aşırıya Kaçmamak Gereken):
- Kararsızlık ve bağımlılık
- Onay arayışı
- Çatışmadan kaçma
- Sahte uyum
- Kendini kaybetme
- Başkası için yaşama

Denge Noktası:
Hem birey hem partner. Hem güçlü hem nazik. Hem lider hem
takım oyuncusu. Bireyselliği ilişkiye, ilişkiyi bireyselliğe
taşımak.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Cesaret ve risk alma kapasitesi
• Liderlik ve öncülük yeteneği
• Bağımsız düşünme ve karar verme
• Fiziksel güç ve dayanıklılık
• Hızlı refleksler ve tepki
• Girişimcilik ruhu
• Kendi yolunu açma cesareti
• Özgüven ve kararlılık

Bu armağanları reddetme - onları Terazi zarafetiyle birleştir.
Hem cesur hem diplomatik. Hem lider hem partner.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata ilişkinin değerini ve birlikte var olmanın
güzelliğini öğrenmek ve öğretmek için geldin. Görevin,
"ben" ile "biz" arasında köprü kurmak, bağımsızlığı
bağlılıkla dengelemek.

Bu, bireyselliğini kaybetmek demek değil. Aksine, ilişki
aracılığıyla daha derin bir kendini tanımak. Başkası sana
ayna tutuyor - o aynada ne görüyorsun?

Somut Misyon Alanları:
- İlişki koçluğu ve danışmanlık
- Arabuluculuk ve müzakere
- Sanat ve tasarım
- Hukuk ve adalet
- Moda ve estetik
- Ortaklık ve işbirlikleri
''',
    affirmations: [
      'İlişkiler beni zayıflatmıyor, güçlendiriyor.',
      'Uzlaşmak, kaybetmek değildir.',
      'Başkasının ihtiyaçlarını görmek beni zenginleştirir.',
      'Birlikte daha güzeliz.',
      'Dinlemek, konuşmak kadar değerli.',
      'İlişki, kendimi tanımamın aynası.',
      'Zarafet ve güç bir arada olabilir.',
      'Bağlılık, özgürlüğün bir başka yüzü.',
    ],
  ),

  'scorpio_taurus': const NodePlacement(
    sign: 'Akrep/Boğa Ekseni',
    northNodeTitle: 'Kuzey Düğüm Akrep\'te - Dönüşümün Ateşi',
    southNodeTitle: 'Güney Düğüm Boğa\'da - Toprağın Bilgeliği',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen maddi dünyanın, istikrarın ve güvenliğin
ustasıydın. Belki bir banker, bir çiftçi, bir zanaatkar, bir sanatçı
ya da toprak sahibi biriydin. Biriktirmek, sahip olmak, korumak
senin doğandı.

Konfor alanın geniş ve güvenliydi. Değişimden kaçındın çünkü
bildiklerini kaybetmekten korktun. "Eldeki bir kuş..." felsefesi
hayatına yön verdi.

Ruhun şimdi bu güvenlik arayışını aşmak, dönüşümün ateşinde
yeniden doğmak, derinlere dalmaya cesaret etmek için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. BIRAKMA SANATI
Tutunmayı bırakmak. Sahip olduklarını gevşek tut -
insanları, eşyaları, konfor alanını.

2. DERİNLİĞE DALMA
Yüzeyde kalmak yerine derinlere inmek. Rahatsız edici
gerçeklerle yüzleşmek.

3. DÖNÜŞÜMÜ KUCAKLAMAK
Değişimden kaçmak yerine onu davet etmek. Ölüm-yeniden
doğuş döngülerinin doğallığını kabul etmek.

4. PSİKOLOJİK DERİNLİK
Sadece görünene değil, görünmeyene bakmak. Motivasyonları,
gölgeleri, bilinçdışını anlamak.

5. KAYNAKLARI PAYLAŞMAK
Biriktirmek yerine paylaşmak. Başkalarının kaynaklarıyla
birleşmek. Güvenin sıçrayışı.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Boğa'nın istikrar sevgisini Akrep'in dönüştürücü
gücüne dönüştürmekten geçiyor. Güvenliği içeride bulmak,
dışarıdaki değişimlere açık olmak.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Tutunma kalıplarını fark etmek. Neden değişimden bu kadar
korkuyorsun? Ne kaybetmekten korkuyorsun?

AŞAMA 2 - SARSINTI
Hayat zorla değişim getiriyor. Kayıplar, krizler, beklenmedik
dönüşümler. Direnmek acıyı artırıyor.

AŞAMA 3 - TESLİMİYET
Değişime teslim olmayı denemek. "Bu da geçer" bilgeliği.
Eski kabuğu bırakıp yenisine hazırlanmak.

AŞAMA 4 - YENİDEN DOĞUŞ
Ateşten geçip daha güçlü çıkmak. Dönüşümü bir tehdit değil,
fırsat olarak görmek. Anka kuşu gibi yeniden doğmak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Ölüm ve Yeniden Doğuş

Bu düğüm ekseninde tantrik çalışma, ölüm-yeniden doğuş
döngülerini bilinçli deneyimlemeyi içerir.

Kundalini Uyanışı:
Akrep, Kundalini enerjisinin en yoğun olduğu bölgedir.
Bu enerji kök çakradan yükseldiğinde, tüm sistemi
dönüştürür - ego ölümü ve ruhsal yeniden doğuş.

Pratik: Kundalini nefes tekniği. Derin nefesle enerjiyi
kök çakradan taç çakrasına yükselt. Dikkat: Bu güçlü
bir pratiktir, hazırlıksız yapma.

Cinsel Dönüşüm:
Tantrada cinsel enerji, dönüşümün yakıtıdır. Orgazmı
sadece fiziksel değil, enerjetik ve ruhsal bir ölüm-
yeniden doğuş olarak deneyimlemek.

Gölge Entegrasyonu:
Akrep gölgeyle çalışır. İçindeki karanlığı reddetme,
onu tanı ve dönüştür. Her gölge, ışığa çevrilebilecek
bir enerji taşır.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. BIRAKMA RİTÜELİ
Her ay dolunay'da, bırakmak istediğin bir şeyi yaz ve
yak. Sembolik olarak ateşe ver.

2. DERİN TERAPİ
Psikoterapi, gölge çalışması, EMDR - yüzeyin altına
inmek için profesyonel destek al.

3. ÖLÜM MEDİTASYONU
Maranasati - ölüm üzerine meditasyon. Her gün "bugün
ölebilirdim" gerçeğiyle otur. Önceliklerin netleşir.

4. KAYNAK PAYLAŞIMI
Biriktirdiğin bir şeyi paylaş - para, zaman, bilgi.
Tutunmayı gevşetme pratiği.

5. DERİN SOHBETLER
Yüzeysel sohbetler yerine, derin ve kişisel konuşmalar.
Maskeni indir, gerçek ol.

6. KRİZ YÖNETIMI
Bir sonraki krizde, panik yerine merak: "Bu bana ne
öğretiyor? Bu beni nasıl dönüştürüyor?"

7. SIR TUTMA
Başkalarının sırlarını güvenle tut. Güvenilir bir kişi
ol. Derinliğin onur boyutu.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Boğa Gölgesi (Bırakılması Gereken):
- Maddi bağımlılık ve açgözlülük
- Değişime direnç ve inatçılık
- Konfor alanına hapsolma
- Sahip olma takıntısı
- Tembellik ve durgunluk
- Yüzeysellik ve derinlikten kaçınma
- Kıskançlık ve sahiplenicilik

Akrep Gölgesi (Aşırıya Kaçmamak Gereken):
- Manipülasyon ve kontrol
- İntikamcılık ve kin
- Obsesyon ve takıntı
- Aşırı şüphecilik ve paranoya
- Yıkıcılık
- Duygusal şantaj

Denge Noktası:
Hem istikrarlı hem dönüşüme açık. Hem topraklı hem derin.
Hem sahip hem paylaşan. Güvenliği içeride bulup dışarıda
özgürce dans etmek.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Maddi dünyada ustalık ve pratik zeka
• İstikrar ve güvenlik oluşturma kapasitesi
• Sabır ve kararlılık
• Duyusal farkındalık ve estetik anlayış
• Kaynak yönetimi ve birikim
• Doğa ile bağ
• Sadakat ve güvenilirlik
• Bedensel farkındalık

Bu armağanları reddetme - onları Akrep derinliğiyle birleştir.
Hem istikrarlı hem dönüştürücü. Hem topraklı hem psişik.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata dönüşümün gücünü ve ateşten geçmenin
değerini öğrenmek ve öğretmek için geldin. Görevin,
güvenlik arayışını aşarak derinlere dalmak, değişimi
kucaklamak, ölüm-yeniden doğuş döngülerinde ustalaşmak.

Bu, istikrarı tamamen reddetmek demek değil. Aksine,
gerçek istikrarın dışarıda değil içeride olduğunu
keşfetmek. İçsel güvenlik bulunduğunda, dış değişimler
tehdit olmaktan çıkar.

Somut Misyon Alanları:
- Psikoterapi ve danışmanlık
- Kriz yönetimi ve dönüşüm koçluğu
- Dedektiflik ve araştırma
- Finans ve yatırım (dönüştürücü)
- Şifa ve alternatif tıp
- Ölüm ve yas danışmanlığı
''',
    affirmations: [
      'Değişim, büyümenin doğal yoludur.',
      'Bırakmak, kaybetmek değil özgürleşmektir.',
      'Derinlere inmek beni korkutmuyor, dönüştürüyor.',
      'Her kriz, yeniden doğuş fırsatıdır.',
      'Güvenliğim içimde, dışarda değil.',
      'Gölgeme bakma cesaretim var.',
      'Dönüşümün ateşi beni arındırıyor.',
      'Anka kuşu gibi küllerimden yükseliyorum.',
    ],
  ),

  'sagittarius_gemini': const NodePlacement(
    sign: 'Yay/İkizler Ekseni',
    northNodeTitle: 'Kuzey Düğüm Yay\'da - Bilgeliğin Yolcusu',
    southNodeTitle: 'Güney Düğüm İkizler\'de - Meraklı Zihnin Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen bilginin, iletişimin ve merakın ustasıydın.
Belki bir öğretmen, bir yazar, bir tacir, bir haberci ya da bir
dil uzmanıydın. Bilgi toplamak, paylaşmak, aktarmak senin doğandı.

Zihnin hızlı ve çevikti - her şeyle ilgilendin, her konuda bir şeyler
bildin. Ama bu süreçte bir şey eksik kaldı: DERİNLİK. Çok şey bildin
ama hiçbir şeyde uzmanlaşmadın. Bilgi parçacıklarını bir araya getirip
ANLAM çıkaramadın.

Ruhun şimdi bu bilgi bolluğunu bilgeliğe dönüştürmek, detaylardan
büyük resme bakmak için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. DERİNLEŞMEK
Her şeyden biraz değil, bir şeyden çok bilmek.
Uzmanlık ve derinlik geliştirmek.

2. ANLAM ARAMAK
Bilgiyi bilgeliğe dönüştürmek. "Ne?" değil "Neden?"
ve "Ne anlama geliyor?" sorularını sormak.

3. İNANÇ SİSTEMİ
Rastgele fikirler yerine tutarlı bir dünya görüşü
oluşturmak. Neye inanıyorsun?

4. UZAĞA BAKMAK
Sadece bugün ve burada değil, uzun vadeli ve geniş
perspektifle düşünmek.

5. ÖĞRETMEK
Sadece bilgi toplamak değil, onu sentezleyip
başkalarıyla paylaşmak. Öğretmen olmak.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, İkizler'in meraklı zekasını Yay'ın bilge
vizyonuna dönüştürmekten geçiyor. Bilgi yetmez, bilgelik gerekir.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Dağınıklığı fark etmek. Çok şey biliyor ama hiçbir şeyde
derin olmamak. Zihinsel yorgunluk.

AŞAMA 2 - ODAKLANMA
Bir şeye odaklanmaya çalışmak. Zor, çünkü her şey ilginç.
Ama seçim yapmak özgürlüktür.

AŞAMA 3 - DERİNLEŞME
Seçilen alanda ustalaşmak. Bilgiyi bilgeliğe dönüştürmek.
Büyük resmi görmeye başlamak.

AŞAMA 4 - ÖĞRETİM
Edinilen bilgeliği başkalarıyla paylaşmak. Öğretmen,
mentor, rehber olmak. Vizyonu yaymak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Üst Zihin ve Genişleme

Bu düğüm ekseninde tantrik çalışma, üst zihin merkezlerini
aktive etmeyi ve bilinç genişlemesini içerir.

Ajna (Üçüncü Göz) ve Sahasrara (Taç) Çalışması:
Yay enerjisi üst çakralarla ilişkilidir. Alt zihin (İkizler)
üst zihne (Yay) bağlandığında, bilgi bilgeliğe dönüşür.

Pratik: Üçüncü göz meditasyonu. Kaşların arasındaki noktaya
odaklanarak "OM" mantrası. Görüşün netleşmesini hisset.

Guru Prensip:
Yay, guru (öğretmen) enerjisi taşır. İçindeki guru'yu
aktive etmek - hem öğrenci hem öğretmen olmak.

Dharma Araştırması:
"Benim dharma'm ne?" Yaşam amacını, ruhsal yolculuğunu
keşfetmek. Yay, anlam arayışının burcudur.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. DERİN OKUMA
Bir konuda derinleş. Yüzlerce makale yerine, birkaç
temel kitap oku. Ustalar kimler, onları öğren.

2. SEYAHAT
Fiziksel ya da zihinsel seyahat. Farklı kültürler,
farklı bakış açıları. Ufkunu genişlet.

3. FELSEFE ÇALIŞMASI
Büyük düşünürleri oku. Senin inançlarını sorgula.
Tutarlı bir dünya görüşü oluştur.

4. ÖĞRETME PRATİĞİ
Bildiğin bir şeyi birine öğret. Öğretmek, en iyi
öğrenme yoludur.

5. VİZYON TAHTASI
Büyük resmi gösteren bir vizyon tahtası yap.
Uzun vadeli hedefler, yaşam amacı.

6. DOĞRULUK PRATİĞİ
Her gün bir doğruyu daha derinden incele. "Bu gerçekten
doğru mu?" Yüzeysel kabulleri sorgula.

7. RITÜEL VE GELENEK
Bir ruhani geleneğe bağlan. İster yoga, ister Sufilik,
ister Budizm. Derinleş, yayılma.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

İkizler Gölgesi (Bırakılması Gereken):
- Yüzeysellik ve derinlikten kaçınma
- Çok fazla ilgi alanı, hiçbirinde ustalık yok
- Dedikodu ve boş konuşma
- Tutarsızlık ve değişkenlik
- Odak eksikliği ve dağınıklık
- Gerçeği esnetme eğilimi
- Dinlemeden konuşma

Yay Gölgesi (Aşırıya Kaçmamak Gereken):
- Dogmatizm ve bilgiçlik
- Aşırı iyimserlik ve gerçeklikten kopukluk
- Vaaz verme ve öğüt yağdırma
- Küçük detayları ihmal etme
- Sabırsızlık
- Kendi hakikatinin tek hakikat olduğunu sanma

Denge Noktası:
Hem meraklı hem bilge. Hem esnek hem tutarlı. Hem detaycı
hem vizyoner. Bilgiyi bilgeliğe, merakı anlama dönüştürmek.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Hızlı öğrenme ve adaptasyon yeteneği
• İletişim ve dil becerileri
• Merak ve açık fikirlilik
• Çok yönlülük ve esneklik
• Sosyal zeka ve bağlantı kurma
• Yazma ve konuşma kapasitesi
• Bilgi toplama ve organize etme
• Farklı bakış açılarını anlama

Bu armağanları reddetme - onları Yay bilgeliğiyle birleştir.
Hem meraklı hem derin. Hem bilgi dolu hem anlamlı.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata bilgiyi bilgeliğe dönüştürmeyi ve büyük resmi
görmeyi öğrenmek ve öğretmek için geldin. Görevin, detaylardan
anlama, bilgiden bilgeliğe yükselmek.

Bu, merakını kaybetmek demek değil. Aksine, merakı derinleştirmek.
Bir konu hakkında yüz şey bilmek yerine, bir konunun derinliklerine
inmek. Ve bu derinliği başkalarıyla paylaşmak.

Somut Misyon Alanları:
- Yükseköğretim ve akademi
- Yayıncılık ve kitap yazarlığı
- Din ve felsefe
- Uluslararası ilişkiler
- Hukuk ve etik
- Koçluk ve mentorluk
''',
    affirmations: [
      'Bilgi bilgeliğe dönüşüyor içimde.',
      'Büyük resmi görmek beni özgürleştiriyor.',
      'Derinleşmek, genişlemektir.',
      'Anlam aramak benim doğal halim.',
      'İçimdeki öğretmeni aktive ediyorum.',
      'Bir konuda ustalaşmak, tüm konuları anlamaktır.',
      'Vizyonum net, yolum aydınlık.',
      'Hakikatin peşinde yürüyorum.',
    ],
  ),

  'capricorn_cancer': const NodePlacement(
    sign: 'Oğlak/Yengeç Ekseni',
    northNodeTitle: 'Kuzey Düğüm Oğlak\'ta - Dağın Zirvesi',
    southNodeTitle: 'Güney Düğüm Yengeç\'te - Yuvanın Sıcaklığı',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen ev, aile ve duygusal güvenliğin ustasıydın.
Belki bir anne, bir bakıcı, bir ev kadını, bir aşçı ya da bir
aile reisiydin. İnsanlara bakmak, beslemek, korumak senin doğandı.

Duygusal bağlar, aile, anılar - bunlar senin için her şeydi.
Ama bu süreçte bir şey eksik kaldı: DIŞ DÜNYA. Kariyer, toplumsal
katkı, kalıcı bir miras bırakmak.

Ruhun şimdi bu duygusal temeli koruyarak dışarı çıkmak, toplumda
bir rol üstlenmek, dağın zirvesine tırmanmak için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. SORUMLULUK ÜSTLENMEK
Sadece kendi ailenin değil, toplumun da sorumluluğunu
almak. Liderlik ve otorite.

2. DİSİPLİN VE YAPILANDIRMA
Duygusal akışın ötesinde, yapı kurmak. Hedefler, planlar,
stratejiler.

3. UZUN VADELİ DÜŞÜNMEK
Anlık duygusal tepkiler yerine, uzun vadeli sonuçları
görmek. Sabır ve kararlılık.

4. TOPLUMSAL KATKI
Evden çıkıp dünyaya bir şeyler vermek. Kalıcı bir miras,
somut bir başarı.

5. DUYGUSAL OLGUNLUK
Duygulara yenik düşmeden onlarla çalışmak. Profesyonellik
ve olgunluk.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Yengeç'in besleyici şefkatini Oğlak'ın yapıcı
disiplinine dönüştürmekten geçiyor. İçeride güçlü, dışarıda etkili.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Konfor alanına hapsolduğunu fark etmek. Evin dışında bir
dünya var ve orada seni bekleyen bir misyon.

AŞAMA 2 - İLK ADIMLAR
Dış dünyaya adım atmak. Kariyer, toplumsal roller, sorumluluklar.
Başlangıçta korkutucu ama öğretici.

AŞAMA 3 - DENGELİ İLERLEME
Hem ev hem iş. Hem aile hem kariyer. İkisini de onurlandıran
bir yaşam kurmak.

AŞAMA 4 - MİRAS BIRAKMAK
Topluma kalıcı bir katkı bırakmak. Aile ötesinde bir aile -
topluluk, kurum, miras.
''',
    tantricImplications: '''
TANTRİK BOYUT: İç ve Dış Dengeleme

Bu düğüm ekseninde tantrik çalışma, iç dünya (Yengeç) ile
dış dünya (Oğlak) arasında köprü kurmayı içerir.

Kök (Muladhara) ve Taç (Sahasrara) Aksı:
Yengeç kök çakra ile, Oğlak taç çakra ile ilişkilendirilebilir.
Bu eksenin dengesi, yerden göğe uzanan omurga boyunca enerji
akışını içerir.

Pratik: Ayakta durarak köklerin toprağa, taç çakranın göğe
uzandığını hisset. İç güvenlik ve dış başarı aynı anda.

Baba-Anne Arketipi:
Oğlak baba (Satürn), Yengeç anne (Ay) enerjisi taşır. Her iki
ebeveyn arketipini içinde dengelemek, bütünleşmenin anahtarı.

Dharma ve Karma:
Oğlak dharma'yı (görev), Yengeç karma'yı (geçmiş) temsil eder.
Geçmişin üzerine geleceği inşa etmek.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. HEDEF BELİRLEME
Uzun vadeli kariyer hedefleri koy. 5 yıl, 10 yıl sonra
nerede olmak istiyorsun?

2. DİSİPLİN PRATİĞİ
Her gün aynı saatte yapılan bir rutin oluştur. Küçük
ama tutarlı adımlar.

3. MENTOR BULMA
Başarılı birinden öğren. Rol modeller, mentorlar,
kariyerde senden önde olanlar.

4. TOPLULUK SORUMLULUĞU
Ailen dışında bir topluluğa katkıda bulun. Gönüllülük,
liderlik, organizasyon.

5. DUYGUSAL SINIRLAR
İş yerinde profesyonel duygusal sınırlar koy. Her şeyi
kişisel almamayı öğren.

6. BAŞARI KUTLAMASI
Her başarını, küçük de olsa kutla. Tırmanışın tadını çıkar.

7. MİRAS DÜŞÜNMEK
"Arkamda ne bırakmak istiyorum?" sorusunu sor. Sadece
aile değil, topluma ne veriyorsun?
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Yengeç Gölgesi (Bırakılması Gereken):
- Aşırı duygusallık ve alınganlık
- Geçmişe takılma
- Bağımlı ilişkiler
- Aşırı korumacılık
- Kabuğuna çekilme
- Kurban rolü
- Konfor alanına hapsolma

Oğlak Gölgesi (Aşırıya Kaçmamak Gereken):
- İş-aholizm ve soğukluk
- Başarı takıntısı
- Duygusal mesafe
- Aşırı ciddiyet
- Statü odaklılık
- Başkalarını kullanma

Denge Noktası:
Hem sıcak hem profesyonel. Hem besleyici hem yapıcı. Hem aile
hem kariyer. İç dünyayı dış dünyaya taşımak, dış başarıyı iç
huzurla dengelemek.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Duygusal zeka ve empati
• Bakım ve beslenme kapasitesi
• Aile ve ev kurma yeteneği
• Sezgi ve duygusal okuma
• Hafıza ve geçmişle bağ
• Koruma ve güvenlik sağlama
• Sadakat ve bağlılık
• Rahatlatma ve şifa verme

Bu armağanları reddetme - onları Oğlak disipliniyle birleştir.
Hem şefkatli hem güçlü. Hem besleyici hem yapıcı.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata duygusal temelinin üzerine somut bir yapı
inşa etmeyi ve topluma kalıcı bir katkı bırakmayı öğrenmek
ve öğretmek için geldin. Görevin, evden dünyaya çıkmak,
sorumluluk almak, dağın zirvesine tırmanmak.

Bu, aileyi ve duyguları reddetmek demek değil. Aksine,
iç güvenliğin üzerine dış başarıyı inşa etmek. Sevgiyle
dolu bir kalple, disiplinli adımlar atmak.

Somut Misyon Alanları:
- Yönetim ve liderlik
- Girişimcilik ve iş kurma
- Politika ve kamu yönetimi
- Mühendislik ve yapı
- Finans ve bankacılık
- Kurumsallaşma ve organizasyon
''',
    affirmations: [
      'İç güvenliğim, dış başarımın temelidir.',
      'Sorumluluk almak beni güçlendiriyor.',
      'Disiplin, sevginin bir ifadesidir.',
      'Topluma kalıcı bir katkı bırakıyorum.',
      'Hem sıcak hem profesyonel olabilirim.',
      'Dağın zirvesine kararlı adımlarla tırmanıyorum.',
      'Başarım, ailem ve toplumum içindir.',
      'Yapı kuruyorum, miras bırakıyorum.',
    ],
  ),

  'aquarius_leo': const NodePlacement(
    sign: 'Kova/Aslan Ekseni',
    northNodeTitle: 'Kuzey Düğüm Kova\'da - İnsanlığın Hizmeti',
    southNodeTitle: 'Güney Düğüm Aslan\'da - Kralın Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen parıltının, performansın ve bireysel
ifadenin ustasıydın. Belki bir kral, bir aktör, bir sanatçı,
bir lider ya da bir yıldızdın. Sahne senindi, ışıklar sana
dönüktü, alkışlar senin için çalıyordu.

Ego güçlü ve canlıydı. Kendini ifade etmek, görünür olmak,
takdir edilmek senin için doğaldı. Ama bu süreçte bir şey
eksik kaldı: BAŞKALARI. Kolektif, toplum, insanlık.

Ruhun şimdi bu bireysel parıltıyı kolektife sunmak, "ben"den
"biz"e geçiş yapmak için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. KOLEKTİF HİZMET
Bireysel alkış yerine, toplu fayda. "Ben" değil "biz".
İnsanlık için çalışmak.

2. FARKLILIK KUCAKLAMAK
Herkesin sana benzememesi gerektiğini kabul etmek.
Farklılık zenginlik, çeşitlilik güzellik.

3. OBJEKTİF OLMAK
Duygusal tepkilerden sıyrılıp objektif bakmak. Büyük
resim, evrensel ilkeler.

4. İNOVASYON VE GELECEK
Geçmişin şanına takılmak yerine, geleceği inşa etmek.
Yenilikçilik ve ilerleme.

5. ARKADAŞLIK VE TOPLULUK
Hayran kitlesi yerine, gerçek arkadaşlar ve topluluklar.
Eşitler arasında olmak.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Aslan'ın yaratıcı parıltısını Kova'nın insani
vizyonuna dönüştürmekten geçiyor. Işığını herkes için parlatmak.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Ego merkezliliğini fark etmek. Neden her şey sana dönmeli?
Başkaları da önemli değil mi?

AŞAMA 2 - RAHATSIZLIK
Kalabalıkta kaybolma korkusu. "Özel olmak" yerine "birçok
kişiden biri olmak" rahatsızlığı.

AŞAMA 3 - DENEME
Kolektif projelere katılmak. Ekip çalışması, gönüllülük,
toplumsal hareketler. Ego'yu bir kenara koymak.

AŞAMA 4 - ENTEGRASYON
Bireysel parıltıyı kolektif hizmete sunmak. Hem benzersiz
hem evrensel. Işığını insanlık için kullanmak.
''',
    tantricImplications: '''
TANTRİK BOYUT: Evrensel Bilinç

Bu düğüm ekseninde tantrik çalışma, bireysel bilinçten
evrensel bilince genişlemeyi içerir.

Sahasrara (Taç) Çakra Çalışması:
Kova evrensel bilinçle ilişkilidir. Taç çakra açıldığında,
bireysel ben evrensel benle birleşir.

Pratik: "Aham Brahmasmi" - Ben evrensel bilinçle birim.
Meditasyonda kişisel sınırları eriterek evrenle birleşmeyi
hisset.

Sangha (Topluluk) Pratiği:
Tantrada sangha - ruhani topluluk - önemli bir pratiktir.
Tek başına değil, birlikte yürümek. Ego'yu topluluğa sunmak.

Hizmet Yogası (Seva):
Karşılık beklemeden hizmet. Ego tatmini için değil,
evrensel akış için. "Ben"i "biz"e dönüştürmek.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. GÖNÜLLÜLÜK
Hiçbir tanınma beklemeden, bir topluluk için çalış.
Anonim iyilik, görünmez hizmet.

2. GRUP ÇALIŞMASI
Ekip projelerine katıl. Liderlik yerine takım oyuncusu ol.
Başkalarının parlamasına alan aç.

3. FARKLILIK KEŞFİ
Senden çok farklı birini tanı. Farklı kültür, farklı
inanç, farklı yaşam tarzı. Öğren ve takdir et.

4. GELECEK VİZYONU
10, 50, 100 yıl sonrası için düşün. İnsanlığın geleceğine
nasıl katkıda bulunabilirsin?

5. TEKNOLOJİ VE İNOVASYON
Yeni teknolojileri öğren. Geleceğin araçlarıyla tanış.
İnovasyona açık ol.

6. ARKADAŞLIK KALİTESİ
Hayran değil, arkadaş edin. Eşitler arasında, karşılıklı
saygı ve sevgi.

7. OBJEKTİF GÖZLEM
Duygusal tepki vermeden önce dur ve gözlemle. Objektif
bakış açısı geliştir.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Aslan Gölgesi (Bırakılması Gereken):
- Aşırı ego ve kibirlilik
- Dikkat çekme takıntısı
- Drama yaratma eğilimi
- Eleştiriye tahammülsüzlük
- Herkesin kendine hayran olmasını bekleme
- Başkalarını gölgede bırakma
- "Ben en özelim" tutumu

Kova Gölgesi (Aşırıya Kaçmamak Gereken):
- Duygusal soğukluk ve mesafe
- Aşırı entelektüalizm
- İnsanlığı severken insanları sevememek
- Aşırı bağımsızlık
- "Özel olmamak" korkusu
- Bireyselliği tamamen reddetme

Denge Noktası:
Hem birey hem toplumun parçası. Hem özel hem evrensel. Hem
yaratıcı hem hizmetkar. Işığını insanlık için parlatmak.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Yaratıcılık ve sanatsal ifade
• Liderlik ve karizm
• Kendini ifade etme cesareti
• Performans ve sahne becerileri
• Kalp sıcaklığı ve cömertlik
• İlham verme kapasitesi
• Özgüven ve kendine değer verme
• Çocuksu neşe ve oyunbazlık

Bu armağanları reddetme - onları Kova vizyonuyla birleştir.
Hem yaratıcı hem toplumcu. Hem parlak hem mütevazı.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata bireysel parıltını insanlığın hizmetine sunmayı
ve kolektif bilinci yükseltmeyi öğrenmek ve öğretmek için
geldin. Görevin, "ben"den "biz"e geçiş yapmak, ışığını
herkes için parlatmak.

Bu, bireyselliğini kaybetmek demek değil. Aksine, onu daha
büyük bir amaca bağlamak. Kral değil, toplumun hizmetkarı.
Yıldız değil, rehber.

Somut Misyon Alanları:
- Sosyal girişimcilik ve aktivizm
- Teknoloji ve inovasyon
- İnsani yardım ve STK'lar
- Topluluk organizasyonu
- Bilim ve araştırma
- Gelecek planlaması
''',
    affirmations: [
      'Işığım, insanlığın hizmetindedir.',
      'Ben özelim ve herkes de özel.',
      'Kolektife katkıda bulunmak beni tatmin ediyor.',
      'Farklılık zenginlik, çeşitlilik güzellik.',
      'Geleceği birlikte inşa ediyoruz.',
      'Arkadaşlık, hayran kitlesinden daha değerli.',
      '"Biz" bilinci beni özgürleştiriyor.',
      'Evrensel sevgi içimden akıyor.',
    ],
  ),

  'pisces_virgo': const NodePlacement(
    sign: 'Balık/Başak Ekseni',
    northNodeTitle: 'Kuzey Düğüm Balık\'ta - Sınırsız Okyanusa Dalış',
    southNodeTitle: 'Güney Düğüm Başak\'ta - Mükemmeliyetçinin Mirası',
    pastLifeThemes: '''
Geçmiş yaşamlarında sen düzenin, analitik düşüncenin ve pratik
hizmetin ustasıydın. Belki bir hekim, bir bilim insanı, bir
muhasebeci, bir hizmetkar ya da bir zanaatkardın. Detaylara
dikkat, mükemmeliyetçilik, pratik çözümler senin doğandı.

Her şeyi analiz ettin, kategorize ettin, düzeltmeye çalıştın.
"Doğru" ve "yanlış" arasındaki çizgi sana net görünüyordu.
Ama bu süreçte bir şey eksik kaldı: SIRLARIN GİZEMİ. Mantığın
açıklayamadığı, analizin çözemediği, teslimiyetin gerektirdiği.

Ruhun şimdi bu pratik zemini koruyarak sınırsıza açılmak,
mantığı aşıp sezgiye güvenmek için burada.
''',
    karmicLessons: '''
Bu yaşamın karmik dersleri:

1. TESLİMİYET
Kontrolü bırakmak, akışa güvenmek. Her şeyi düzeltmek
senin görevin değil.

2. MİSTİK DENEYİM
Mantığın ötesine geçmek. Açıklanamayan ama hissedilen.
Sezgi, ilham, vizyon.

3. ŞEFKAT
Yargılamak yerine kabul etmek. Kusurları düzeltmeye
çalışmak yerine, olduğu gibi sevmek.

4. YARATICI AKIŞ
Analiz etmek yerine yaratmak. Sanat, müzik, şiir -
mantık dışı ifade.

5. BİRLİK BİLİNCİ
Ayrıntıları görürken bütünü kaçırmamak. Her şey birbiriyle
bağlı, ayrılık illüzyon.
''',
    soulEvolutionPath: '''
Ruhunun evrimi, Başak'ın analitik hassasiyetini Balık'ın mistik
teslimiyetine dönüştürmekten geçiyor. Mantık kadar sezgiye de güvenmek.

Evrim Aşamaları:

AŞAMA 1 - FARKINDALIK
Aşırı analiz ve mükemmeliyetçiliğin farkına varmak. Neden
her şeyi düzeltmeye çalışıyorsun? Neden rahatlamıyorsun?

AŞAMA 2 - KAOS KORKUSU
Kontrolü bırakma korkusu. "Ya her şey dağılırsa?" Ama
belki dağılması gereken şeyler dağılmalı.

AŞAMA 3 - TESLİMİYET DENEMELERİ
Küçük alanlarda teslim olmayı denemek. Akışa bırakmak,
müdahale etmemek. Zor ama rahatlatıcı.

AŞAMA 4 - MİSTİK UYANIS
Mantığın ötesinde bir bilgelik olduğunu deneyimlemek.
Sezgiye güvenmek, ilhama açılmak, birliği hissetmek.
''',
    tantricImplications: '''
TANTRİK BOYUT: Okyanusla Birleşme

Bu düğüm ekseninde tantrik çalışma, bireysel damlayı
okyanusu ile birleştirmeyi içerir.

Sahasrara Ötesi:
Balık, taç çakranın ötesine, saf bilince işaret eder.
Tüm çakraların ötesinde, sınırsız farkındalık.

Pratik: "Dalmak" meditasyonu. Derin nefesle sınırsız bir
okyanusa dalıyormuşsun gibi hisset. Bireysel sınırlar
eriyor, evrenle bir oluyorsun.

Yoga Nidra:
Yogik uyku - bilinçli teslimiyet pratiği. Bedeni tamamen
bırakırken bilinci açık tutmak. Ego'nun çözüldüğü alan.

Koşulsuz Şefkat:
Balık, koşulsuz sevginin burcudur. Yargılamadan, düzeltmeden,
analiz etmeden - sadece sevmek. Metta (sevgi-şefkat) meditasyonu.
''',
    healingPractices: '''
ŞİFA PRATİKLERİ:

1. YARATICI SANATLAR
Analiz etmeden yaratmaya bırak kendini. Resim, müzik, dans,
yazı - akışa güven.

2. SU TERAPISI
Su ile vakit geçir - yüzme, banyo, deniz kenarı. Suyun
akışkanlığını ve teslimiyetini hisset.

3. MEDİTASYON
Düşünceleri kontrol etmeye çalışmadan, sadece gözlemle.
Gelip gitsinler, sen sadece şahit ol.

4. ŞEFKAT PRATİĞİ
Bugün kimseyi yargılama. Herkesin en iyisini yaptığını
varsay. Koşulsuz kabul.

5. UYKU VE RÜYALAR
Rüyalarına dikkat et, onları kaydet. Bilinçdışının
mesajlarını dinle.

6. DOĞAÜSTÜne AÇIKLIK
Açıklanamayan deneyimlere açık ol. Senkronisite, sezgiler,
"garip" hisler - onları reddetme.

7. HİZMET
Karşılık beklemeden hizmet et. Koşulsuz ver, sonucu
bırak. Teslimiyet pratiği.
''',
    shadowWork: '''
GÖLGE ÇALIŞMASI:

Başak Gölgesi (Bırakılması Gereken):
- Aşırı mükemmeliyetçilik ve eleştirellik
- Kaygı ve endişe takıntısı
- Kontrol ihtiyacı
- Detaylarda boğulma
- Yargılama ve suçlama
- Sağlık kaygısı
- Spontanlık eksikliği

Balık Gölgesi (Aşırıya Kaçmamak Gereken):
- Kaçışçılık ve gerçeklikten kopma
- Kurban rolü
- Sınır koyamama
- Bağımlılık eğilimi
- Hayalperestlik
- Sorumluluktan kaçınma

Denge Noktası:
Hem analitik hem sezgisel. Hem pratik hem mistik. Hem hizmetkar
hem teslim olmuş. Detaylarda ustalaşırken bütünü görmek.
''',
    giftFromPastLives: '''
GEÇMİŞ YAŞAMLARDAN GETİRDİĞİN ARMAĞANLAR:

• Analitik zeka ve detay dikkati
• Pratik problem çözme yeteneği
• Hizmet odaklılık ve yardımseverlik
• Sağlık ve beslenme bilgisi
• Organizasyon ve düzen kapasitesi
• Eleştirel düşünme
• Mesleki ustalık
• Güvenilirlik ve tutarlılık

Bu armağanları reddetme - onları Balık mistisizmiyle birleştir.
Hem pratik hem ruhani. Hem analitik hem sezgisel.
''',
    currentLifeMission: '''
BU YAŞAMIN MİSYONU:

Sen bu hayata teslimiyetin bilgeliğini ve mistik deneyimin
değerini öğrenmek ve öğretmek için geldin. Görevin, kontrol
ve analiz ihtiyacını aşarak akışa güvenmek, sezgiye açılmak,
birlik bilincini deneyimlemek.

Bu, pratikliğini kaybetmek demek değil. Aksine, onu daha
derin bir bilgelikle birleştirmek. Hem ayakları yerde hem
başı gökte. Topraklı bir mistik.

Somut Misyon Alanları:
- Sanat ve yaratıcı ifade
- Şifa ve alternatif tıp
- Ruhani danışmanlık
- Psikoterapi ve hipnoterapi
- Sosyal hizmetler ve yardım
- Meditasyon ve yoga öğretmenliği
''',
    affirmations: [
      'Teslim olmak güç gerektirir.',
      'Akışa güveniyorum, kontrol etmiyorum.',
      'Mantığın ötesinde bilgelik var.',
      'Sezgim benim rehberim.',
      'Her şeyin mükemmel olması gerekmiyor.',
      'Ben büyük okyanusun bir damlasıyım.',
      'Koşulsuz şefkat içimden akıyor.',
      'Gizemle barış içindeyim.',
    ],
  ),
};

// ════════════════════════════════════════════════════════════════════════════
// DÜĞÜMLER EVLERDE - 12 EV YERLEŞİMİ
// ════════════════════════════════════════════════════════════════════════════

final Map<int, NodeInHouse> nodesInHouses = {
  1: const NodeInHouse(
    house: 1,
    northNodeMeaning:
        'Kuzey Düğüm 1. Evde - Benliğin keşfi, bireysellik ve öz güven geliştirme. Kendi yolunu çizme cesareti.',
    southNodeMeaning:
        'Güney Düğüm 7. Evde - İlişki mirası, başkalarına bağımlılık kalıplarını bırakma.',
    karmicLesson: 'Birlikte olmayı biliyorsun, şimdi tek başına olmayı öğren.',
    lifeAreaFocus: 'Benlik, fiziksel beden, kişisel imaj, yeni başlangıçlar',
    spiritualGrowth: 'Başkalarının aynasında değil kendi içinde kendini bul.',
    practicalGuidance: 'Her gün kendinle vakit geçir, solo projeler dene.',
  ),
  2: const NodeInHouse(
    house: 2,
    northNodeMeaning:
        'Kuzey Düğüm 2. Evde - Öz değer keşfi, maddi güvenlik, kendi kaynaklarını geliştirme.',
    southNodeMeaning:
        'Güney Düğüm 8. Evde - Dönüşüm mirası, başkalarının kaynaklarına bağımlılığı bırakma.',
    karmicLesson: 'Derinliği biliyorsun, şimdi basitliği öğren.',
    lifeAreaFocus: 'Para, değerler, yetenekler, güvenlik',
    spiritualGrowth: 'Maddi dünyayı ruhani yolculuğun parçası olarak kabul et.',
    practicalGuidance:
        'Bütçe yap, yetenek geliştir, basit zevklerin tadını çıkar.',
  ),
  3: const NodeInHouse(
    house: 3,
    northNodeMeaning:
        'Kuzey Düğüm 3. Evde - İletişim güzelliği, öğrenme, yakın çevre ilişkileri.',
    southNodeMeaning:
        'Güney Düğüm 9. Evde - Bilgelik mirası, dogmatizmi bırakma.',
    karmicLesson: 'Bilgeliği biliyorsun, şimdi merakı öğren.',
    lifeAreaFocus: 'İletişim, kısa yolculuklar, kardeşler, öğrenme',
    spiritualGrowth: 'Her sohbetin bir öğretmen olduğunu gör.',
    practicalGuidance: 'Her gün yeni şey öğren, aktif dinleme pratiği yap.',
  ),
  4: const NodeInHouse(
    house: 4,
    northNodeMeaning:
        'Kuzey Düğüm 4. Evde - Köklere dönüş, ev-aile, duygusal güvenlik.',
    southNodeMeaning:
        'Güney Düğüm 10. Evde - Kariyer mirası, iş-aholizmi bırakma.',
    karmicLesson: 'Başarmayı biliyorsun, şimdi ait olmayı öğren.',
    lifeAreaFocus: 'Ev, aile, kökler, iç dünya',
    spiritualGrowth: 'Dış başarı yerine iç huzuru bul.',
    practicalGuidance: 'Evini yuva yap, aileyle vakit geçir.',
  ),
  5: const NodeInHouse(
    house: 5,
    northNodeMeaning:
        'Kuzey Düğüm 5. Evde - Yaratıcılık sevinci, kendini ifade, aşk.',
    southNodeMeaning:
        'Güney Düğüm 11. Evde - Topluluk mirası, grup içinde kaybolmayı bırakma.',
    karmicLesson: 'Grup içinde olmayı biliyorsun, şimdi parlamayı öğren.',
    lifeAreaFocus: 'Yaratıcılık, romantizm, çocuklar, eğlence',
    spiritualGrowth: 'İçindeki yaratıcı kıvılcımı özgürleştir.',
    practicalGuidance: 'Sanat yap, romantizme zaman ayır, oyna.',
  ),
  6: const NodeInHouse(
    house: 6,
    northNodeMeaning:
        'Kuzey Düğüm 6. Evde - Hizmetin anlamı, sağlık, günlük rutinler.',
    southNodeMeaning:
        'Güney Düğüm 12. Evde - Mistik miras, kaçışçılığı bırakma.',
    karmicLesson: 'Mistik olmayı biliyorsun, şimdi pratik olmayı öğren.',
    lifeAreaFocus: 'Sağlık, iş, günlük rutinler, hizmet',
    spiritualGrowth: 'Her gündelik eylemi ibadet olarak yap.',
    practicalGuidance: 'Sağlık rutinleri oluştur, pratik yardım sun.',
  ),
  7: const NodeInHouse(
    house: 7,
    northNodeMeaning:
        'Kuzey Düğüm 7. Evde - İlişkinin aynası, ortaklık, işbirliği.',
    southNodeMeaning:
        'Güney Düğüm 1. Evde - Bireysellik mirası, yalnız kurt olmayı bırakma.',
    karmicLesson:
        'Tek başına güçlü olmayı biliyorsun, şimdi birlikte güçlü ol.',
    lifeAreaFocus: 'Evlilik, ortaklıklar, ilişkiler',
    spiritualGrowth: 'Başkasında kendini gör, ilişkiyi ayna olarak kullan.',
    practicalGuidance: 'İlişkiye zaman yatır, uzlaşmayı pratik et.',
  ),
  8: const NodeInHouse(
    house: 8,
    northNodeMeaning:
        'Kuzey Düğüm 8. Evde - Dönüşüm ateşi, psikolojik derinlik, paylaşım.',
    southNodeMeaning:
        'Güney Düğüm 2. Evde - Maddi güvenlik mirası, tutunmayı bırakma.',
    karmicLesson: 'Biriktirmeyi biliyorsun, şimdi bırakmayı öğren.',
    lifeAreaFocus: 'Dönüşüm, paylaşılan kaynaklar, cinsellik',
    spiritualGrowth: 'Ego ölümüne izin ver, yeniden doğ.',
    practicalGuidance: 'Derin terapi yap, açıl, paylaş.',
  ),
  9: const NodeInHouse(
    house: 9,
    northNodeMeaning:
        'Kuzey Düğüm 9. Evde - Bilgelik yolculuğu, anlam arayışı, uzak ufuklar.',
    southNodeMeaning:
        'Güney Düğüm 3. Evde - İletişim mirası, yüzeyselliği bırakma.',
    karmicLesson: 'Bilgi toplamayı biliyorsun, şimdi bilgeliğe dönüştür.',
    lifeAreaFocus: 'Yükseköğrenim, felsefe, uzak yolculuklar',
    spiritualGrowth: 'Hayatın anlamını ara ve paylaş.',
    practicalGuidance: 'Derinlemesine kurs al, seyahat et, öğret.',
  ),
  10: const NodeInHouse(
    house: 10,
    northNodeMeaning:
        'Kuzey Düğüm 10. Evde - Toplumsal misyon, kariyer, kalıcı miras.',
    southNodeMeaning:
        'Güney Düğüm 4. Evde - Aile mirası, konfor alanını bırakma.',
    karmicLesson: 'Yuva kurmayı biliyorsun, şimdi dünyada yer edin.',
    lifeAreaFocus: 'Kariyer, toplumsal statü, otorite',
    spiritualGrowth: 'Topluma kalıcı katkıda bulun.',
    practicalGuidance: 'Kariyer hedefleri belirle, liderlik al.',
  ),
  11: const NodeInHouse(
    house: 11,
    northNodeMeaning:
        'Kuzey Düğüm 11. Evde - İnsanlık hizmeti, topluluk, arkadaşlık.',
    southNodeMeaning:
        'Güney Düğüm 5. Evde - Yaratıcılık mirası, ego odaklılığı bırakma.',
    karmicLesson: 'Parlamayı biliyorsun, şimdi ışığını başkaları için kullan.',
    lifeAreaFocus: 'Arkadaşlar, gruplar, idealler',
    spiritualGrowth: 'Bireysel egodan evrensel bilince geç.',
    practicalGuidance: 'Gruplara katıl, sosyal davalara destek ver.',
  ),
  12: const NodeInHouse(
    house: 12,
    northNodeMeaning:
        'Kuzey Düğüm 12. Evde - Sırların kapısı, ruhanilik, teslimiyet.',
    southNodeMeaning: 'Güney Düğüm 6. Evde - Hizmet mirası, kontrolü bırakma.',
    karmicLesson: 'Kontrol etmeyi biliyorsun, şimdi teslim olmayı öğren.',
    lifeAreaFocus: 'Ruhanilik, bilinçdışı, yalnızlık, şifa',
    spiritualGrowth: 'Ego sınırlarını eriterek evrensel bilinçle birleş.',
    practicalGuidance: 'Günlük meditasyon, rüya kaydı, karşılıksız hizmet.',
  ),
};

// ════════════════════════════════════════════════════════════════════════════
// SATÜRN - KARMA LORDU
// ════════════════════════════════════════════════════════════════════════════

class SaturnKarmaContent {
  static const String introduction = '''
SATÜRN: KARMANİN BÜYÜK ÖĞRETMENİ

Kadim astrolojide Satürn "Malefic" - kötücül gezegen olarak bilinirdi.
Ama ezoterik astrolojide Satürn'ün rolü çok daha derin: O, karmik
öğretmen, olgunlaşma ustası ve ruhsal disiplinin lordudur.

Satürn, sınırların, yapının ve zamanın gezegenidir. Ama asıl işlevi,
bizi olgunlaştırmak, öğretmek ve gerçek potansiyelimize ulaştırmaktır.

SATÜRN DÖNÜŞÜ (SATURN RETURN):
Yaklaşık 29.5 yılda bir Satürn doğum haritasındaki konumuna döner.
Bu dönemler (27-30, 57-60, 85-88 yaşları) büyük inisiyasyonlardır.

İlk Satürn Dönüşü (27-30): Yetişkinliğe geçiş, büyük kararlar.
İkinci Satürn Dönüşü (57-60): Bilge yaşlı, miras sorusu.
Üçüncü Satürn Dönüşü (85-88): Yaşamın tamamlanması.
''';
}

// ════════════════════════════════════════════════════════════════════════════
// RETROGRAD GEZEGENLER - GEÇMİŞ YAŞAM İŞLERİ
// ════════════════════════════════════════════════════════════════════════════

final Map<String, RetroPlanet> retrogradePlanets = {
  'mercury': const RetroPlanet(
    planet: 'Merkür Retrograd',
    karmicMeaning: '''
Doğum haritasında Merkür retrograd, geçmiş yaşamlarda iletişim,
düşünce ve öğrenme konularında tamamlanmamış işler olduğunu gösterir.
Belki sözlerin yanlış kullanıldı, bilgi saklandı ya da gerçek ifade edilmedi.
''',
    pastLifeBusiness: '''
- Söylenmemiş sözler ve iletişim hataları
- Yanlış bilgi paylaşımı ya da manipülasyon
- Öğrenme fırsatlarının kaçırılması
- Kardeş ya da komşu ilişkilerinde sorunlar
- Yazılı anlaşmalarda problemler
''',
    innerWorkRequired: '''
- Düşüncelerini netleştirmek
- İletişimde doğruluk ve açıklık
- Dinleme becerilerini geliştirmek
- Geçmiş iletişim yaralarını iyileştirmek
- Bilgiyi etik kullanmak
''',
    giftsFromPastLives: '''
- Derin düşünce kapasitesi
- Gizli bilgilere erişim
- Sezgisel iletişim
- Geçmişi anlama yeteneği
- İç diyalog ve meditasyon gücü
''',
    currentLifeExpression: '''
Bu yaşamda Merkür retrograd, düşüncenin içe dönmesi ve
derinleşmesiyle ifade bulur. Hızlı değil derin düşünürsün.
İletişimde bazen yanlış anlaşılabilirsin ama özgün fikirlerin var.
''',
    healingJourney: '''
Şifa, önce kendini anlamaktan geçer. İç sesin ne diyor?
Düşüncelerini yazarak netleştir. Meditasyon ve günlük tutma
önemli araçlar. Geçmişteki iletişim yaralarını kabul et ve affet.
''',
    affirmations: [
      'Düşüncelerim netleşiyor, sözlerim gerçeği yansıtıyor.',
      'İç bilgeliğime güveniyorum.',
      'İletişimimde sabırlı ve açık oluyorum.',
      'Geçmiş iletişim hatalarını affediyorum.',
    ],
  ),
  'venus': const RetroPlanet(
    planet: 'Venüs Retrograd',
    karmicMeaning: '''
Doğum haritasında Venüs retrograd, geçmiş yaşamlarda aşk, ilişkiler,
değerler ve güzellik konularında tamamlanmamış işler olduğunu gösterir.
Belki kalp kırıldı, sevgi reddedildi ya da değerler ihlal edildi.
''',
    pastLifeBusiness: '''
- Tamamlanmamış aşk hikayeleri
- Kalp kırıklıkları ve ihanetler
- Öz değer sorunları
- Maddi dünyanın yanlış kullanımı
- Güzelliğin istismarı
''',
    innerWorkRequired: '''
- Öz değeri içeride bulmak
- Geçmiş aşk yaralarını iyileştirmek
- Sağlıklı ilişki kalıpları geliştirmek
- Değerleri yeniden tanımlamak
- İç güzelliği keşfetmek
''',
    giftsFromPastLives: '''
- Derin sevgi kapasitesi
- Sanatsal hassasiyet
- Geçmiş aşk deneyimlerinden bilgelik
- İçsel güzellik
- Değerlere duyarlılık
''',
    currentLifeExpression: '''
Bu yaşamda Venüs retrograd, sevginin içe dönmesiyle ifade bulur.
İlişkilerde temkinli olabilirsin, ama derinliğin var. Öz değer
konusunda çalışman gerekebilir. Geçmişten dönen ilişkiler olabilir.
''',
    healingJourney: '''
Şifa, önce kendini sevmekten geçer. "Ben sevilmeye değerim"
affirmasyonu önemli. Geçmiş ilişkileri inceleyerek kalıpları
anla. Sanat ve güzellik terapi araçları olabilir.
''',
    affirmations: [
      'Ben sevilmeye ve değer görmeye layığım.',
      'Geçmiş kalp kırıklıklarını şefkatle affediyorum.',
      'İçimdeki güzelliği görüyorum ve kutluyorum.',
      'Sağlıklı ve besleyici ilişkilere açığım.',
    ],
  ),
  'mars': const RetroPlanet(
    planet: 'Mars Retrograd',
    karmicMeaning: '''
Doğum haritasında Mars retrograd, geçmiş yaşamlarda irade, öfke,
cinsellik ve eylem konularında tamamlanmamış işler olduğunu gösterir.
Belki güç kötüye kullanıldı, öfke patlamaları yaşandı ya da eylem
eksik kaldı.
''',
    pastLifeBusiness: '''
- Güç istismarı ya da kurban olma
- Kontrol edilmemiş öfke ve şiddet
- Cinsel enerji sorunları
- Yarım kalan eylemler ve projeler
- Savaş ve çatışma travmaları
''',
    innerWorkRequired: '''
- Öfkeyi sağlıklı kanalize etmek
- Gücü etik kullanmak
- Cinsel enerjiyi dengelemek
- Eyleme geçme cesaretini bulmak
- Saldırganlık ve pasiflik arasında denge
''',
    giftsFromPastLives: '''
- İç güç ve dayanıklılık
- Stratejik düşünme
- Cinsel enerjinin dönüştürücü kullanımı
- Sabırlı eylem kapasitesi
- İçsel savaşçı bilgeliği
''',
    currentLifeExpression: '''
Bu yaşamda Mars retrograd, enerjinin içe dönmesiyle ifade bulur.
Dışa vurmak yerine içsel güç biriktirirsin. Eyleme geçmekte
tereddüt olabilir ama harekete geçtiğinde etkilisin.
''',
    healingJourney: '''
Şifa, öfkeyle sağlıklı bir ilişki kurmaktan geçer. Öfken
geçerli ama ifade şekli önemli. Fiziksel aktivite, dövüş
sanatları ya da dans enerjiyi kanalize etmeye yardımcı olur.
''',
    affirmations: [
      'Gücümü etik ve yapıcı şekilde kullanıyorum.',
      'Öfkem geçerli, onu sağlıklı ifade ediyorum.',
      'Eyleme geçme cesaretim var.',
      'İçimdeki savaşçı bilge ve dengeli.',
    ],
  ),
  'jupiter': const RetroPlanet(
    planet: 'Jüpiter Retrograd',
    karmicMeaning: '''
Doğum haritasında Jüpiter retrograd, geçmiş yaşamlarda inanç,
bilgelik, bolluk ve genişleme konularında tamamlanmamış işler
olduğunu gösterir. Belki fırsatlar kaçırıldı, inançlar sorgulandı
ya da aşırılıklar yaşandı.
''',
    pastLifeBusiness: '''
- İnanç krizleri ya da dogmatizm
- Kaçırılan fırsatlar ve büyüme şansları
- Aşırılıklar ve abartılar
- Öğretmenlik ya da rehberlik sorunları
- Adalet ve etik ihlalleri
''',
    innerWorkRequired: '''
- Kendi iç öğretmenini bulmak
- İnançları sorgulamak ve yenilemek
- Fırsatları tanımayı öğrenmek
- Aşırılıklardan kaçınmak
- İç bilgeliğe güvenmek
''',
    giftsFromPastLives: '''
- Derin içsel bilgelik
- Felsefe ve anlam arayışı
- Kendi kendine öğrenme kapasitesi
- Sezgisel rehberlik
- Manevi derinlik
''',
    currentLifeExpression: '''
Bu yaşamda Jüpiter retrograd, bilgeliğin içe dönmesiyle ifade bulur.
Dış otoritelere değil iç rehberliğine güvenirsin. Manevi arayış
kişisel ve derin. Şans dışarıdan değil içeriden gelir.
''',
    healingJourney: '''
Şifa, kendi inançlarını oluşturmaktan geçer. Başkalarının
hakikatlerini körü körüne kabul etme. Kendi deneyimlerinden
öğren. Meditasyon ve iç yolculuk önemli araçlar.
''',
    affirmations: [
      'İçimdeki bilgeliğe güveniyorum.',
      'Kendi inançlarımı oluşturuyorum.',
      'Fırsatları görüyorum ve değerlendiriyorum.',
      'Bolluğu içimden dışarıya taşıyorum.',
    ],
  ),
  'saturn': const RetroPlanet(
    planet: 'Satürn Retrograd',
    karmicMeaning: '''
Doğum haritasında Satürn retrograd, geçmiş yaşamlarda sorumluluk,
otorite, yapı ve karmik borçlar konusunda tamamlanmamış işler
olduğunu gösterir. Belki sorumluluktan kaçıldı ya da aşırı otoriter
olundu.
''',
    pastLifeBusiness: '''
- Kaçınılan sorumluluklar
- Otorite sorunları (ezilme ya da ezme)
- Yarım kalan yapılar ve projeler
- Karmik borçlar ve cezalar
- Baba figürü ile ilişkiler
''',
    innerWorkRequired: '''
- İç otorite geliştirmek
- Sorumluluğu gönüllü kabul etmek
- Kendi yapını oluşturmak
- Karmik borçları bilinçli ödemek
- İç disiplini geliştirmek
''',
    giftsFromPastLives: '''
- Derin sorumluluk bilinci
- Kendi otoritesi olmak
- Sabır ve dayanıklılık
- Yapı oluşturma kapasitesi
- Karma anlayışı
''',
    currentLifeExpression: '''
Bu yaşamda Satürn retrograd, otoritenin içe dönmesiyle ifade bulur.
Dış otoritelere değil iç disipline güvenirsin. Sorumlulukların
ağırlığını hissedebilirsin ama ustalaştığında özgürleşirsin.
''',
    healingJourney: '''
Şifa, sorumluluğu sevgiyle kabul etmekten geçer. Kaçmak işe
yaramaz - yüzleşmek gerekir. Kendi kurallarını belirle,
kendi yapını kur. Baba figürü ile ilişkini iyileştir.
''',
    affirmations: [
      'Sorumluluğu gönüllü ve sevgiyle kabul ediyorum.',
      'Kendi otoritemi oluşturuyorum.',
      'Karmik derslerimi bilinçle öğreniyorum.',
      'İç disiplinim beni özgürleştiriyor.',
    ],
  ),
};

// ════════════════════════════════════════════════════════════════════════════
// 12. EV SIRLARI
// ════════════════════════════════════════════════════════════════════════════

class TwelfthHouseSecrets {
  static const String introduction = '''
12. EV: RUHANİ SIRIN KAPISI

12. Ev, astrolojinin en gizemli ve anlaşılması güç evidir. O,
görünmeyen dünyanın, bilinçdışının, geçmiş yaşamların ve ruhsal
bağlantının kapısıdır.

Antik astrologlar 12. Evi "kötü kader evi" olarak görürlerdi -
çünkü burada ego çözülür, sınırlar erir, kontrol kaybolur. Ama
ezoterik perspektiften 12. Ev, en yüce potansiyeli taşır: Ego'nun
ötesine geçiş, evrensel bilinçle birleşme, moksha (kurtuluş).

12. EV TEMLERİ:
• Bilinçdışı ve gizli düşmanlar
• Yalnızlık ve içe çekilme
• Hapishane, hastane, manastır
• Kaçış ve bağımlılık
• Ruhsal pratik ve meditasyon
• Geçmiş yaşam hafızası
• Kurban ve şehitlik
• Sınırları eritme
• Evrensel sevgi ve şefkat
• Kayıp ve teslimiyet
''';

  static const String hiddenKarma = '''
GİZLİ KARMA - 12. EV'DE NE SAKLANIYOR?

12. Ev, görünür karmadan çok gizli karmayı temsil eder. Bunlar,
bilinçli olarak hatırlamadığımız ama hayatımızı etkileyen
geçmiş yaşam izleridir.

12. Evdeki gezegenler, geçmiş yaşamlarda o gezegen enerjisiyle
ilgili tamamlanmamış işleri gösterir:

GÜNEŞ 12. EVDE: Geçmiş yaşamlarda kimlik ve ego sorunları.
Belki güneş ışığından gizlenmek zorunda kaldın - kaçak, sürgün,
gizli hayat. Bu yaşamda görünürlük zor gelebilir. Işığını
paylaşmayı öğren.

AY 12. EVDE: Geçmiş yaşamlarda duygusal yaralar ve anne karması.
Belki terkedilme, kayıp ya da duygusal yalnızlık yaşandı. Bu
yaşamda duygusal ihtiyaçlar gizli kalabilir. İç çocuğu şifala.

MERKÜR 12. EVDE: Geçmiş yaşamlarda iletişim gizlilikleri.
Belki bilgi saklamak zorunda kaldın ya da sözlerin ters döndü.
Bu yaşamda düşünceler gizemli akabilir. Sezgisel bilgiye güven.

VENÜS 12. EVDE: Geçmiş yaşamlarda gizli aşklar ve kayıp sevgiler.
Belki yasak aşk, ayrılık acısı ya da sevginin inkârı yaşandı.
Bu yaşamda ilahi aşka açıl. Koşulsuz sevmeyi öğren.

MARS 12. EVDE: Geçmiş yaşamlarda bastırılmış öfke ve şiddet.
Belki gücünü sakladın ya da saldırıya maruz kaldın. Bu yaşamda
enerjin gizli akabilir. Ruhsal savaşçı ol, barış için savaş.

JÜPİTER 12. EVDE: Geçmiş yaşamlarda gizli bilgelik ve inançlar.
Belki ezoterik öğretilere eriştin ya da inanç yüzünden ceza aldın.
Bu yaşamda iç bilgelik güçlü. Manevi öğretmen potansiyeli var.

SATÜRN 12. EVDE: Geçmiş yaşamlarda ağır karmik borçlar.
Belki yalnızlık, hapis ya da dışlanma yaşandı. Bu yaşamda
gizli korkular olabilir. Karmayı bilinçle öde ve özgürleş.

URANÜS 12. EVDE: Geçmiş yaşamlarda devrimci ya da aykırı olma.
Belki toplumdan dışlandın ya da fikirlerini gizlemek zorunda kaldın.
Bu yaşamda sezgiler ani ve güçlü. Kolektif bilinçaltına erişim var.

NEPTÜN 12. EVDE: Geçmiş yaşamlarda güçlü ruhani bağlantı.
Belki bir mistik, şaman ya da medyumdun. Bu yaşamda sınırlar
zayıf olabilir ama psişik yetenekler güçlü. Koruma önemli.

PLUTO 12. EVDE: Geçmiş yaşamlarda derin dönüşümler ve güç sırları.
Belki okült çalışmalar, gizli örgütler ya da büyük krizler yaşandı.
Bu yaşamda bilinçdışı dönüşüm gücü var. Gölgeyle barış yap.
''';

  static const String pastLifeMemories = '''
GEÇMİŞ YAŞAM HATIRALARI

12. Ev, bilinçli hafızanın ötesindeki kayıtlara erişim sağlar.
Geçmiş yaşam hatıraları genellikle şu şekillerde ortaya çıkar:

RÜYALAR: En yaygın erişim yolu. Tekrarlayan rüyalar, başka
dönemlerde geçen rüyalar, tanımadığın yerleri bilen rüyalar
geçmiş yaşam izleri olabilir.

DÉJÀ VU: "Bunu daha önce yaşadım" hissi. Özellikle belirli
yerler, kişiler ya da durumlarla güçlü tanışıklık hissi.

FOBILER: Mantıksal açıklaması olmayan derin korkular. Örneğin
su korkusu, kapalı alan korkusu, belirli silahlardan korku.

YETENEKLER: Hiç öğrenmeden sahip olunan yetenekler. Bir müzik
aletini hemen çalabilmek, bir dili kolayca öğrenmek, bir
konuda doğuştan ustalık.

BEDENSEL İZLER: Açıklanamayan doğum lekeleri, hassas bölgeler,
kronik ağrılar geçmiş yaşam yaralarının izi olabilir.

12. Evi Aktive Etme:
- Meditasyon ve hipnoz
- Rüya çalışması ve rüya günlüğü
- Regresyon terapisi
- Aktif imajinasyon
- Yalnızlıkta zaman geçirme
''';

  static const String spiritualGifts = '''
RUHANİ ARMAĞANLAR

12. Ev, zorluklarla birlikte büyük armağanlar da taşır:

PSİŞİK HASSASIYET: 12. Ev güçlü olanlar, görünmeyen enerjileri,
duyguları ve bilgileri algılayabilir. Bu bazen bunaltıcı olabilir
ama geliştirildikinde değerli bir armağandır.

ŞİFA GÜCÜ: 12. Ev, şifa enerjisiyle doğrudan bağlantı sağlar.
Eller aracılığıyla, sesle ya da sadece mevcudiyetle şifa verme
potansiyeli.

SANATSAL İLHAM: 12. Ev, kolektif bilinçdışına erişim sağlar.
Bu, büyük sanatsal ilham kaynağıdır - müzik, şiir, dans,
görsel sanatlar.

MİSTİK DENEYİM: 12. Ev, ego sınırlarının eridiği, birlik
bilincinin deneyimlendiği mistik hallere açıktır. Meditasyon,
trans, vizyon.

EVRENSEL ŞEFKAT: 12. Ev, tüm varlıklara koşulsuz sevgi
gönderebilen bir kalp geliştirir. Kurtuluş, sadece kendisi
için değil, tüm varlıklar için.
''';

  static const String selfUndoing = '''
KENDİ KENDİNİ SABOTAJ (SELF-UNDOING)

12. Ev'in geleneksel adı "self-undoing" - kendi kendini yıkımdır.
Bu, bilinçdışı kalıpların bizi nasıl sabote ettiğini gösterir:

KAÇIŞ MEKANİZMALARI:
- Uyku ve aşırı dinlenme
- Madde kullanımı (alkol, uyuşturucu)
- Fantezi dünyasına çekilme
- Sosyal izolasyon
- Kronik hastalıklar

KURBAN ROLÜ:
- "Ben zavallıyım" inancı
- Başkalarını suçlama
- Yardımsızlık hissi
- Şikayet döngüsü

GİZLİ DÜŞMANLAR:
- Kendi bilinçdışı kalıpların en büyük düşmanın
- Bastırılmış duygular
- Kabul edilmemiş gölge
- İnkâr edilen ihtiyaçlar

ŞİFA YOLU:
Kendini sabotajdan kurtuluş, bilinçdışını bilinçli yapmaktan
geçer. Terapi, meditasyon, gölge çalışması, rüya analizi -
bunlar karanlığı aydınlatan araçlardır.
''';

  static const String liberation = '''
KURTULUŞ POTANSİYELİ (MOKSHA)

12. Ev, Hint astrolojisinde "Moksha Bhava" - kurtuluş evi olarak
bilinir. Bu, ruhun bağlarından özgürleşme potansiyelidir.

EGO'NUN ÖTESİNE GEÇMEK:
12. Ev, ego'nun çözüldüğü yerdir. Bu korkutucu olabilir ama
aynı zamanda en büyük özgürlüktür. Ben-lik'in illüzyonundan
uyanmak, gerçek doğamızı görmektir.

EVRENİLE BİRLEŞME:
Bireysel dalganın okyanusla bir olduğunu fark etmek. Ayrılık
illüzyonunun son bulması. "Ben" ve "evren" ayrımının erimesi.

KOŞULSUZ TESLİMİYET:
Kontrolü bırakmak, evrensel akışa güvenmek. "Senin iraden
olsun" - ego iradesinin ilahi iradeyle uyumlanması.

HİZMET:
Kurtuluş, sadece kendimiz için değil. Gerçek özgürlük,
başkalarının da özgürleşmesine hizmet etmeyi içerir.
Bodhisattva ideali - tüm varlıklar özgürleşene kadar
kalmak.

PRATİKLER:
- Günlük meditasyon
- Karma yoga (karşılıksız hizmet)
- Rüya çalışması
- Yalnızlık retreat'leri
- Mantra ve dua
- Doğada zaman geçirme
''';
}

// ════════════════════════════════════════════════════════════════════════════
// CHIRON - YARALI ŞİFACI
// ════════════════════════════════════════════════════════════════════════════

class ChironContent {
  static const String introduction = '''
CHIRON: YARALI ŞİFACI

Yunan mitolojisinde Chiron, ölümlü bir anne ve ölümsüz bir babadan
doğan yarı at yarı insan bir varlıktı. Apollon tarafından tıp,
şifalı otlar, astroloji ve müzik öğretildi. Birçok kahramana
öğretmenlik yaptı - Aşil, Herakles, Asklepios.

Ama trajik bir kader yaşadı: Herakles'in zehirli okuyla yaralandı.
Ölümsüz olduğu için ölemedi ama yarası da iyileşmedi. Sonunda
acısından kurtulmak için ölümlülüğünü Prometheus'a verdi.

Chiron'un hikayesi, yaralı şifacı arketipini mükemmel temsil eder:
En derin yaramız, en büyük armağanımız olabilir. Kendi iyileşemez
yaramız aracılığıyla başkalarını şifaya yönlendirebiliriz.

Astrolojide Chiron, 1977'de keşfedildi - Satürn ve Uranüs arasında
yörüngesi olan küçük bir gök cismi. Keşif zamanı, psikoterapi ve
alternatif şifanın yükselişine denk geldi.
''';

  static const Map<String, ChironPlacement> chironInSigns = {
    'aries': ChironPlacement(
      sign: 'Koç',
      coreWound:
          'Kimlik ve var olma hakkı yarası. "Ben var olmaya değer miyim?"',
      woundOrigin: '''
Bu yara, erken çocuklukta ya da geçmiş yaşamlarda kimliğin,
bireyselliğin ya da var olma hakkının sorgulandığı deneyimlerden
kaynaklanır. Belki varlığın istenmeyen, ya da bireyselliğin
bastırılan bir ortamda büyüdün.
''',
      healingPath: '''
Şifa, var olma hakkını talep etmekten geçer. "Ben buradayım ve
değerliyim" - bu basit ama güçlü bir gerçeklik. Bireyselliğini
ifade etme cesareti bul. Sınırlarını koy. Kendi yolunu çiz.
''',
      giftToOthers: '''
Başkalarının kimlik ve özgüven sorunlarını derinden anlarsın.
Onlara var olma haklarını hatırlatabilirsin. Liderlik, koçluk
ya da bireysel güçlenme alanlarında şifa sunabilirsin.
''',
      integrationProcess: 'Cesaret ve savunmasızlık arasında denge kurmak.',
      wisdomGained: 'Gerçek güç, savunmasızlığı kucaklamaktan gelir.',
    ),
    'taurus': ChironPlacement(
      sign: 'Boğa',
      coreWound: 'Değer ve güvenlik yarası. "Ben yeterince değerli miyim?"',
      woundOrigin: '''
Bu yara, maddi güvensizlik, değersizlik hissi ya da bedenle
ilgili sorunlardan kaynaklanır. Belki yoksulluk, fiziksel
istismar ya da "yeterince iyi olmama" mesajları aldın.
''',
      healingPath: '''
Şifa, öz değeri içeride bulmaktan geçer. Maddi koşullar ne olursa
olsun, sen değerlisin. Bedenini onurlandır, duyularını kutla.
İç güvenliği geliştir.
''',
      giftToOthers: '''
Başkalarının değer ve güvenlik sorunlarını anlarsın. Onlara
kendi değerlerini keşfetmelerinde yardım edebilirsin. Finansal
koçluk, beden terapisi ya da sanat şifası sunabilirsin.
''',
      integrationProcess: 'Maddi ve manevi değerleri dengelemek.',
      wisdomGained: 'Gerçek zenginlik içeridedir.',
    ),
    'gemini': ChironPlacement(
      sign: 'İkizler',
      coreWound: 'İletişim ve anlaşılma yarası. "Sesim duyuluyor mu?"',
      woundOrigin: '''
Bu yara, iletişim zorlukları, yanlış anlaşılma ya da sesin
bastırılması deneyimlerinden kaynaklanır. Belki konuşma güçlüğü,
öğrenme zorluğu ya da fikirlerin küçümsendiği bir ortam yaşandı.
''',
      healingPath: '''
Şifa, sesin değerini keşfetmekten geçer. Fikirlerin önemli,
sözlerin değerli. İletişim becerilerini geliştir ama özün
önemli, mükemmellik değil.
''',
      giftToOthers: '''
Başkalarının iletişim ve ifade sorunlarını anlarsın. Onlara
seslerini bulmalarında yardım edebilirsin. Yazarlık, öğretmenlik
ya da konuşma terapisi alanlarında şifa sunabilirsin.
''',
      integrationProcess: 'Konuşmak ve dinlemek arasında denge kurmak.',
      wisdomGained: 'Sessizlik de bir iletişimdir.',
    ),
    'cancer': ChironPlacement(
      sign: 'Yengeç',
      coreWound: 'Ait olma ve bakım yarası. "Bir yere ait miyim?"',
      woundOrigin: '''
Bu yara, aile sorunları, erken dönem terkedilme ya da duygusal
ihmal deneyimlerinden kaynaklanır. Belki güvensiz bir ev ortamı,
anne yarası ya da kök eksikliği yaşandı.
''',
      healingPath: '''
Şifa, içsel yuvayı kurmaktan geçer. Aile seçilebilir, kökler
içeride olabilir. Kendi kendine anne-baba olmayı öğren. İç
çocuğu şefkatle kucakla.
''',
      giftToOthers: '''
Başkalarının aile ve aidiyet sorunlarını anlarsın. Onlara
güvenli bir alan sunabilirsin. Aile terapisi, çocuk bakımı
ya da ev/yuva danışmanlığı alanlarında şifa verebilirsin.
''',
      integrationProcess: 'Bağımlılık ve bağımsızlık arasında denge kurmak.',
      wisdomGained: 'Ev bir yer değil, bir duygudur.',
    ),
    'leo': ChironPlacement(
      sign: 'Aslan',
      coreWound: 'Yaratıcılık ve görünürlük yarası. "Parlamaya hakkım var mı?"',
      woundOrigin: '''
Bu yara, yaratıcılığın bastırılması, görünür olmanın cezalandırılması
ya da özgüvenin kırılması deneyimlerinden kaynaklanır. Belki
yeteneklerin küçümsendi, başarıların görmezden gelindi.
''',
      healingPath: '''
Şifa, içsel ışığı kucaklamaktan geçer. Parlamaya hakkın var.
Yaratıcılığın değerli. Alkış beklemeden yarat, ama takdiri de
kabul et.
''',
      giftToOthers: '''
Başkalarının yaratıcılık ve özgüven sorunlarını anlarsın. Onlara
ışıklarını bulmalarında yardım edebilirsin. Sanat terapisi,
çocuklarla çalışma ya da performans koçluğu sunabilirsin.
''',
      integrationProcess: 'Ego ve alçakgönüllülük arasında denge kurmak.',
      wisdomGained: 'Işık paylaşıldıkça çoğalır.',
    ),
    'virgo': ChironPlacement(
      sign: 'Başak',
      coreWound: 'Mükemmellik ve yeterlilik yarası. "Yeterince iyi miyim?"',
      woundOrigin: '''
Bu yara, aşırı eleştiri, mükemmeliyetçi beklentiler ya da "asla
yeterli olmama" mesajlarından kaynaklanır. Belki hatalar şiddetle
cezalandırıldı, ya da sürekli yetersizlik hissettirildi.
''',
      healingPath: '''
Şifa, kusurları kucaklamaktan geçer. Mükemmel olmak zorunda
değilsin. Hatalar öğrenme fırsatı. Kendine şefkat göster,
içindeki eleştirmeni yumuşat.
''',
      giftToOthers: '''
Başkalarının mükemmeliyetçilik ve kaygı sorunlarını anlarsın.
Onlara kendilerini kabul etmelerinde yardım edebilirsin. Sağlık,
beslenme ya da organizasyon danışmanlığı sunabilirsin.
''',
      integrationProcess: 'Çaba ve kabul arasında denge kurmak.',
      wisdomGained: 'Kusursuzluk, kusurları sevmekten gelir.',
    ),
    'libra': ChironPlacement(
      sign: 'Terazi',
      coreWound: 'İlişki ve denge yarası. "Sevilmeye layık mıyım?"',
      woundOrigin: '''
Bu yara, ilişki sorunları, reddetme ya da adaletsizlik
deneyimlerinden kaynaklanır. Belki terk edilme, ihanet ya
da ilişkilerde sürekli dengesizlik yaşandı.
''',
      healingPath: '''
Şifa, önce kendini sevmekten geçer. İlişki ihtiyaç değil seçim
olmalı. Tek başına tam ol, sonra birlikte ol. Adil ol ama
adalet takıntısından kurtul.
''',
      giftToOthers: '''
Başkalarının ilişki ve denge sorunlarını anlarsın. Onlara sağlıklı
ilişkiler kurmalarında yardım edebilirsin. İlişki terapisi,
arabuluculuk ya da adalet çalışmaları sunabilirsin.
''',
      integrationProcess: 'Verme ve alma arasında denge kurmak.',
      wisdomGained: 'Gerçek ilişki, iki bütün insanın birleşimidir.',
    ),
    'scorpio': ChironPlacement(
      sign: 'Akrep',
      coreWound: 'Güç ve güven yarası. "Güvenebilir miyim?"',
      woundOrigin: '''
Bu yara, ihanet, istismar ya da güç mücadeleleri deneyimlerinden
kaynaklanır. Belki derin bir ihanet, cinsel travma ya da güç
istismarı yaşandı.
''',
      healingPath: '''
Şifa, karanlıkla yüzleşmekten geçer. Gölgeyi reddetme, onu tanı
ve dönüştür. Güven yavaş yavaş yeniden inşa edilebilir. Gücünü
şifa için kullan.
''',
      giftToOthers: '''
Başkalarının travma ve güç sorunlarını anlarsın. Onlara en karanlık
yerlerinde eşlik edebilirsin. Travma terapisi, kriz müdahalesi
ya da dönüşüm koçluğu sunabilirsin.
''',
      integrationProcess: 'Kontrol ve teslimiyet arasında denge kurmak.',
      wisdomGained: 'En derin yara, en büyük dönüşümü doğurur.',
    ),
    'sagittarius': ChironPlacement(
      sign: 'Yay',
      coreWound: 'Anlam ve inanç yarası. "Hayatın anlamı nedir?"',
      woundOrigin: '''
Bu yara, inanç krizleri, anlam kaybı ya da yönelim eksikliği
deneyimlerinden kaynaklanır. Belki din/inanç travması, özgürlük
kısıtlaması ya da vizyon engellemesi yaşandı.
''',
      healingPath: '''
Şifa, kendi anlamını yaratmaktan geçer. Başkalarının hakikatlerine
bağımlı olmak zorunda değilsin. Kendi yolunu keşfet, kendi
inancını oluştur.
''',
      giftToOthers: '''
Başkalarının anlam ve inanç sorunlarını anlarsın. Onlara kendi
hakikatlerini bulmalarında yardım edebilirsin. Ruhani danışmanlık,
felsefe öğretimi ya da yaşam koçluğu sunabilirsin.
''',
      integrationProcess: 'İnanç ve şüphe arasında denge kurmak.',
      wisdomGained: 'Anlam arayışı, anlamın kendisidir.',
    ),
    'capricorn': ChironPlacement(
      sign: 'Oğlak',
      coreWound: 'Başarı ve otorite yarası. "Başarısız mıyım?"',
      woundOrigin: '''
Bu yara, başarı baskısı, otorite sorunları ya da yetersizlik
duygusu deneyimlerinden kaynaklanır. Belki baba yarası, kariyer
başarısızlıkları ya da aşırı sorumluluk yaşandı.
''',
      healingPath: '''
Şifa, başarıyı yeniden tanımlamaktan geçer. Dış başarı tek ölçüt
değil. Kendi otoriten ol. Sorumluluğu sev ama altında ezilme.
''',
      giftToOthers: '''
Başkalarının kariyer ve otorite sorunlarını anlarsın. Onlara
gerçek başarıyı bulmalarında yardım edebilirsin. Kariyer koçluğu,
liderlik eğitimi ya da iş danışmanlığı sunabilirsin.
''',
      integrationProcess: 'Hırs ve kabul arasında denge kurmak.',
      wisdomGained: 'Gerçek başarı, kendini tanımaktır.',
    ),
    'aquarius': ChironPlacement(
      sign: 'Kova',
      coreWound: 'Aidiyet ve farklılık yarası. "Bir yere ait miyim?"',
      woundOrigin: '''
Bu yara, dışlanma, yabancılaşma ya da "farklı olma" deneyimlerinden
kaynaklanır. Belki toplumdan dışlandın, fikirlerin reddedildi
ya da "garip" etiketlendin.
''',
      healingPath: '''
Şifa, farklılığı kucaklamaktan geçer. Herkes gibi olmak zorunda
değilsin. Kendi kabileni bul. Benzersizliğin armağanın.
''',
      giftToOthers: '''
Başkalarının aidiyet ve farklılık sorunlarını anlarsın. Onlara
benzersizliklerini kutlamalarında yardım edebilirsin. Topluluk
organizasyonu, sosyal aktivizm ya da inovasyon alanlarında
şifa sunabilirsin.
''',
      integrationProcess: 'Bireysellik ve topluluk arasında denge kurmak.',
      wisdomGained: 'Gerçek aidiyet, önce kendine ait olmaktır.',
    ),
    'pisces': ChironPlacement(
      sign: 'Balık',
      coreWound: 'Ruhsal bağlantı ve sınırlar yarası. "Gerçek nedir?"',
      woundOrigin: '''
Bu yara, ruhsal kafa karışıklığı, sınır ihlalleri ya da gerçeklikten
kopma deneyimlerinden kaynaklanır. Belki psişik hassasiyet
bastırıldı, ya da sınırlar sürekli aşıldı.
''',
      healingPath: '''
Şifa, sağlıklı sınırlar ve ruhani bağlantı arasında denge kurmaktan
geçer. Hassasiyetin armağan ama korunma gerekli. Topraklan ve uç.
''',
      giftToOthers: '''
Başkalarının ruhsal ve sınır sorunlarını anlarsın. Onlara hassasiyetle
yaşamayı öğretebilirsin. Şifa çalışması, sanat terapisi ya da
ruhani danışmanlık sunabilirsin.
''',
      integrationProcess: 'Teslimiyet ve sınırlar arasında denge kurmak.',
      wisdomGained: 'Okyanus damlada, damla okyanusta.',
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// KARMİK İLİŞKİLER
// ════════════════════════════════════════════════════════════════════════════

class KarmicRelationshipsContent {
  static const String introduction = '''
KARMİK İLİŞKİLER: RUH BAĞLANTILARI

Bazı ilişkiler sıradan karşılaşmalardan fazlasıdır. İlk görüşte
tanışıklık hissi, açıklanamaz çekim, yoğun duygular - bunlar
karmik bir bağlantının işaretleri olabilir.

Karmik ilişki türleri:

RUHSAL ARKADAŞLAR (Soul Friends):
Ruhsal aile üyeleri. Birlikte büyüdüğünüz, birbirinizi desteklediğiniz
ruhlar. Rahat, besleyici, karşılıklı.

KARMİK ORTAKLAR (Karmic Partners):
Geçmiş yaşamlardan tamamlanmamış işler. Bazen zorlayıcı, bazen
büyütücü. Ders tamamlanınca ilişki de tamamlanabilir.

RUHEŞLER (Soulmates):
Derin sevgi ve uyum. Genellikle romantik ama her zaman değil.
Birbirini tamamlayan ruhlar.

İKİZ ALEVLER (Twin Flames):
En yoğun bağlantı. Aynı ruhun iki yarısı inancı. Çok güçlü
ama çok zorlu. Birleşim ve ayrılık döngüleri.
''';

  static const List<KarmicRelationshipIndicator> soulmateIndicators = [
    KarmicRelationshipIndicator(
      name: 'Güneş-Ay Aspektleri',
      aspect: 'Konjunksiyon, Trigon, Karşıt',
      meaning: 'Temel enerji uyumu, karşılıklı anlayış',
      pastLifeConnection:
          'Muhtemelen eş, aile ya da yakın partner olarak birlikte yaşamlar',
      currentLifePurpose: 'Birbirini dengelemek ve tamamlamak',
      challenges: 'Karşıtlıkta projeksiyon, konjunksiyonda birleşme',
      healingPotential: 'Derin duygusal şifa ve kabul',
    ),
    KarmicRelationshipIndicator(
      name: 'Venüs-Mars Aspektleri',
      aspect: 'Konjunksiyon, Kare, Karşıt',
      meaning: 'Güçlü cinsel ve romantik çekim',
      pastLifeConnection: 'Tutkulu aşıklar, bazen tamamlanmamış aşk',
      currentLifePurpose: 'Aşk ve arzu dengesini öğrenmek',
      challenges: 'Yoğun tutku bazen yakıcı olabilir',
      healingPotential: 'Cinsel ve duygusal bütünleşme',
    ),
    KarmicRelationshipIndicator(
      name: 'Kuzey Düğüm Aspektleri',
      aspect: 'Konjunksiyon özellikle',
      meaning: 'Kader bağlantısı, büyüme ortaklığı',
      pastLifeConnection: 'Ruhsal evrim için bir araya gelmiş ruhlar',
      currentLifePurpose: 'Birbirinin büyümesini desteklemek',
      challenges: 'Bazen rahatsız edici büyüme zorlukları',
      healingPotential: 'Evrimsel sıçrama, potansiyel aktivasyonu',
    ),
    KarmicRelationshipIndicator(
      name: 'Satürn Aspektleri',
      aspect: 'Konjunksiyon, Kare, Karşıt',
      meaning: 'Karmik borç ya da sorumluluk',
      pastLifeConnection: 'Geçmiş yaşamda yarım kalan işler',
      currentLifePurpose: 'Karmik döngüyü tamamlamak',
      challenges: 'Ağır, sınırlayıcı hissedebilir',
      healingPotential: 'Olgunlaşma ve sorumluluk bilinci',
    ),
    KarmicRelationshipIndicator(
      name: 'Pluto Aspektleri',
      aspect: 'Konjunksiyon, Kare, Karşıt',
      meaning: 'Dönüştürücü, yoğun bağlantı',
      pastLifeConnection: 'Derin güç dinamikleri, bazen travma',
      currentLifePurpose: 'Birbirini dönüştürmek',
      challenges: 'Güç mücadeleleri, obsesyon riski',
      healingPotential: 'Derin dönüşüm ve yeniden doğuş',
    ),
  ];

  static const String twinFlameContent = '''
İKİZ ALEV (TWIN FLAME) İLİŞKİSİ

İkiz alev kavramı, iki kişinin aynı ruhun iki yarısı olduğu
inancına dayanır. Bu ilişki, en yoğun ve en zorlu olanıdır.

İKİZ ALEV İŞARETLERİ:
• İlk görüşte derin tanışıklık hissi
• "Eve dönmüş" gibi hissetme
• Ayna etkisi - birbirinin gölgesini yansıtma
• Yoğun çekim ve itme döngüleri
• Telepatik bağlantı
• Benzer yaşam deneyimleri
• Ruhsal uyanışı tetikleme

İKİZ ALEV AŞAMALARI:
1. TANIMA: Şok edici tanışıklık, güçlü çekim
2. BALIAY: Yoğun birliktelik, mutluluk
3. KRİZ: Gölgelerin yüzeye çıkması, çatışmalar
4. KAÇIŞ/KOVALAMA: Bir taraf kaçar, diğeri kovalar
5. TESLİMİYET: Bireysel şifa çalışması
6. AYDINLANMA: İç birliğin keşfi
7. BİRLEŞİM: Olgun birliktelik (garanti değil)

UYARI:
İkiz alev kavramı, sağlıksız ilişkileri romantize etmek için
kullanılabilir. Gerçek ikiz alev ilişkisi bile bireysel şifa
olmadan sürdürülemez. Hiçbir ilişki kendi kendini tanımaktan
daha önemli değildir.
''';

  static const String karmicPartnerContent = '''
ZOR KARMİK ORTAKLAR

Bazı ilişkiler büyütücü değil, öğretici zorluklar getirir.
Bu "zor" karmik ortaklıklar, geçmiş yaşam borçlarını temizler.

İŞARETLER:
• Tekrarlayan çatışma kalıpları
• "Neden bu kişiyle birlikteyim?" sorusu
• Ayrılamama, güçlü bağ ama mutsuzluk
• Ders tamamlanana kadar döngü

BU İLİŞKİLERDE:
- Ders nedir, onu anla
- Sınırları koy
- Kurban rolünden çık
- Affetmeyi öğren (ilişkiyi sürdürmek zorunda değilsin)
- Ders tamamlandığında bırakmaya hazır ol

HATIRLA:
Karmik borç, istismarı meşrulaştırmaz. "Ders öğrenmek" adına
kendine zarar verdirmek karmik değil, travmatiktir. Güvende ol.
''';
}

// ════════════════════════════════════════════════════════════════════════════
// EVRİMSEL ASTROLOJİ
// ════════════════════════════════════════════════════════════════════════════

class EvolutionaryAstrologyContent {
  static const String introduction = '''
EVRİMSEL ASTROLOJİ: RUHUN YOLCULUĞU

Evrimsel astroloji, doğum haritasını ruhun uzun yolculuğunun
bir anlık fotoğrafı olarak görür. Bu bakış açısına göre, harita
sadece bu yaşamı değil, geçmiş yaşamları ve ruhsal evrimi de
yansıtır.

TEMEL İLKELER:

1. RUH TEKRARLAYAN ENKARNASYONLAR YAŞAR
Her yaşam, ruhun evriminde bir adımdır. Öğrenilen dersler,
geliştirilen yetenekler, tamamlanan karmalar yaşamdan yaşama taşınır.

2. DOĞUM HARİTASI RUHSAL EVRİMİ YANSITIR
Pluto'nun konumu ruhun evrimsel amacını, Kuzey Düğüm mevcut
yaşamın yönünü, Güney Düğüm geçmiş yaşam mirasını gösterir.

3. SERBEST İRADE VE KADERİN BİRLEŞİMİ
Harita potansiyelleri gösterir, kader değil. Nasıl yaşayacağın
sana bağlı. Ama bazı deneyimler, ruhsal evrim için "zorunlu"dur.

4. BİLİNÇ EVRİMİN TEMELİ
Astrolojik enerjiler, bilinç düzeyine göre farklı ifade bulur.
Aynı harita, farklı bilinç düzeylerinde çok farklı yaşanır.
''';

  static const String plutoAsSoulDesire = '''
PLUTO: RUHUN DERİN ARZUSU

Evrimsel astrolojide Pluto, ruhun en derin arzusunu ve evrimsel
amacını temsil eder. Pluto'nun burç ve ev konumu, bu yaşamda
dönüştürülmesi gereken alanları gösterir.

PLUTO BURÇLARDA (JENERASYONEL):
Pluto yavaş hareket ettiği için, aynı kuşakların ortak dönüşüm
temaları vardır.

PLUTO EVLERDE (BİREYSEL):
Pluto'nun ev konumu, kişisel dönüşüm alanını gösterir.

1. EV: Kimlik ve benlik dönüşümü
2. EV: Değerler ve kaynaklar dönüşümü
3. EV: Düşünce ve iletişim dönüşümü
4. EV: Aile ve kökler dönüşümü
5. EV: Yaratıcılık ve ifade dönüşümü
6. EV: Sağlık ve hizmet dönüşümü
7. EV: İlişkiler dönüşümü
8. EV: Güç ve paylaşım dönüşümü (kendi evi)
9. EV: İnanç ve anlam dönüşümü
10. EV: Kariyer ve toplumsal rol dönüşümü
11. EV: Topluluk ve idealler dönüşümü
12. EV: Ruhanilik ve bilinçdışı dönüşümü

PLUTO VE GEÇMİŞ YAŞAMLAR:
Pluto'nun aspektleri, geçmiş yaşamlarda güçle ilgili deneyimleri
gösterir. Güç istismarı, kurban olma, dönüşüm krizleri - bunlar
Pluto aspektlerinde kodlanmıştır.
''';

  static const String soulJourney = '''
RUHUN ENKARNASYONLAR ÜZERİNDEN YOLCULUĞU

Her ruh, tekrarlayan yaşamlar boyunca bir evrim yolculuğu yaşar.
Bu yolculuğun aşamaları:

1. GENÇ RUH AŞAMASI
Dünya deneyimi yeni, fiziksel dünya keşfediliyor.
- Hayatta kalma odaklı
- Materyalist değerler
- Somut düşünce
- Kabile mentalitesi

2. OLGUNLAŞAN RUH AŞAMASI
Sosyal yapılar ve kurallar öğreniliyor.
- Toplumsal başarı odaklı
- Konvansiyonel değerler
- Statü ve güç arayışı
- Dış onaya bağımlılık

3. OLGUN RUH AŞAMASI
İç dünya keşfediliyor, ilişkiler derinleşiyor.
- Duygusal derinlik
- İlişki odaklı
- Kimlik sorgulaması
- Psikolojik farkındalık

4. YAŞLI RUH AŞAMASI
Ruhsal boyut ön plana çıkıyor.
- Manevi arayış
- Bilgelik ve kabul
- Yaşam döngülerini anlama
- Hizmet odaklı

5. TRANSANDANT RUH AŞAMASI
Aydınlanmaya yaklaşım.
- Ego çözülmesi
- Birlik bilinci
- Koşulsuz sevgi
- Moksha/Kurtuluş

Her aşamada farklı karmik dersler ve evrimsel zorluklar yaşanır.
Doğum haritası, ruhun şu anki evrim aşamasını ve bu yaşamın
özel derslerini gösterir.
''';

  static const String evolutionaryIntent = '''
EVRİMSEL NİYET: BU YAŞAMIN AMACI

Evrimsel astrolojiye göre, her yaşam belirli bir amaçla
planlanır. Bu amacı anlamak için bakılacak noktalar:

1. PLUTO'NUN KUTBU
Pluto'nun konumu (burç, ev, aspektler) ruhun bu yaşamda
dönüştürmesi gereken temel alanı gösterir.

2. KUZEY DÜĞÜM YÖNELİMİ
Kuzey Düğüm, bu yaşamda geliştirilmesi gereken yeni
yetenekleri ve deneyimlenmesi gereken alanları gösterir.

3. GÜNEY DÜĞÜM MİRASI
Güney Düğüm, geçmiş yaşamlardan getirilen ustalıkları
ama aynı zamanda bırakılması gereken kalıpları gösterir.

4. SATÜRN DERSLERİ
Satürn'ün konumu, bu yaşamda ustalaşılması gereken
disiplin ve olgunluk alanlarını gösterir.

5. CHIRON YARASI
Chiron, şifa yoluyla öğretmenliğe dönüşecek temel
yarayı gösterir.

BU YAŞAMIN SORULARI:
- Ruhum bu yaşamda ne öğrenmek istiyor?
- Hangi yetenekler geliştirilmeli?
- Hangi kalıplar bırakılmalı?
- Şifam başkalarına nasıl hizmet edebilir?
- Bu yaşamın armağanı nedir?
''';
}
