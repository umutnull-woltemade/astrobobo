import '../models/zodiac_sign.dart';

/// Evrenin mesajları - Cosmic messages for daily inspiration
class CosmicMessagesContent {
  CosmicMessagesContent._();

  /// Get a cosmic message for a specific zodiac sign based on day
  static String getDailyCosmicMessage(ZodiacSign sign, {DateTime? date}) {
    final dayOfYear = (date ?? DateTime.now())
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    final messages = _cosmicMessages[sign] ?? _universalMessages;
    return messages[dayOfYear % messages.length];
  }

  /// Get a random universal cosmic message
  static String getUniversalMessage({DateTime? date}) {
    final dayOfYear = (date ?? DateTime.now())
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return _universalMessages[dayOfYear % _universalMessages.length];
  }

  /// Get morning affirmation for sign
  static String getMorningAffirmation(ZodiacSign sign) {
    final dayOfWeek = DateTime.now().weekday;
    final affirmations = _morningAffirmations[sign] ?? _universalAffirmations;
    return affirmations[dayOfWeek % affirmations.length];
  }

  /// Get evening reflection for sign
  static String getEveningReflection(ZodiacSign sign) {
    final dayOfWeek = DateTime.now().weekday;
    final reflections = _eveningReflections[sign] ?? _universalReflections;
    return reflections[dayOfWeek % reflections.length];
  }

  /// Get cosmic insight based on moon phase
  static String getMoonPhaseInsight(String moonPhase) {
    return _moonPhaseInsights[moonPhase] ??
        _moonPhaseInsights['waxing_crescent']!;
  }

  /// Get daily intention suggestion
  static String getDailyIntention(ZodiacSign sign) {
    final dayOfWeek = DateTime.now().weekday;
    final intentions = _dailyIntentions[sign] ?? _universalIntentions;
    return intentions[dayOfWeek % intentions.length];
  }

  /// Universal cosmic messages - applicable to all signs
  static final List<String> _universalMessages = [
    'Evren bugün senin yanında dans ediyor. Her nefes, kozmik bir hediye.',
    'Yıldızlar ruhunun haritasını çiziyor. Işığını paylaş, karanlığı aydınlat.',
    'Bugün, evrenin sana fısıldadığı bir sır var. Kalbini dinle.',
    'Kozmik enerji dalga dalga akıyor. Akışa teslim ol, mucizeler gelsin.',
    'Galaksilerin ötesinden gelen bir mesaj: Sen yeterlisin, tam olduğun gibi.',
    'Ay ışığı ruhunu yıkasın, güneş ışığı kalbini ısıtsın.',
    'Evrendeki her atom seninle birlikte titreşiyor. Birliğin gücünü hisset.',
    'Bugün bir kapı açılıyor. Cesaretinle adım at, yeni başlangıçlar seni bekliyor.',
    'Yıldız tozundan yaratıldın, yıldızlara döneceksin. Arada, parla.',
    'Kozmik düzen lehine çalışıyor. Güven ve bırak, evren yolunu açsın.',
    'Ruhunun melodisi bugün evrenle uyum içinde. Şarkını söyle.',
    'Karanlıktan korma, senin içindeki ışık yeterli. Parlamaya devam et.',
    'Evrenin nabzı bugün senin kalbinde atıyor. Ritmi hisset.',
    'Sonsuzluğun bir parçasısın. Sınırlarını aş, potansiyelini keşfet.',
    'Bugün, evrenin en güzel sürprizi olabilir. Gözlerini aç.',
    'Kozmik bilgelik içinden akıyor. Sezgilerine kulak ver.',
    'Yıldızlar seninle konuşuyor. Sessizlikte mesajlarını al.',
    'Her son bir başlangıç, her başlangıç bir hediye. Dönüşümü kutla.',
    'Evrenin tüm bolluğu sana açık. Almaya izin ver.',
    'Bugün bir mucize günü. Gözlerini açık tut, kalbini hazır.',
    'Kozmik aşk seni sarıyor. Sevildiğini bil, sev.',
    'Ruhun galaksiler kadar engin. Derinliklerini keşfet.',
    'Evren seninle gülüyor bugün. Neşeni paylaş.',
    'Yıldız tozu kanında akıyor. Büyünü hatırla.',
    'Bugün, evrenin en güzel versiyonun olmak için mükemmel bir gün.',
    'Kozmik zaman senin lehinede. Sabırla bekle, güzellikler gelsin.',
    'İçindeki ışık, bin güneş kadar parlak. Karartmalarına izin verme.',
    'Evrenin her köşesinde seninle aynı ışıktan ruhlar var. Yalnız değilsin.',
    'Bugün, ruhunun şarkısını söyle. Evren dinliyor.',
    'Kozmik enerjiler dönüşüm için mükemmel. Eskiyi bırak, yeniye merhaba de.',
  ];

  /// Zodiac-specific cosmic messages
  static final Map<ZodiacSign, List<String>> _cosmicMessages = {
    ZodiacSign.aries: [
      'Ateş ruhun bugün savaşçı enerjisiyle parlıyor. Cesaretinle dağları yerinden oynat.',
      'Mars sana güç veriyor. Öncü ol, yol aç, arkandan gelenler teşekkür edecek.',
      'Koç enerjin bugün doruklarda. Başlamak istediğin her şey için mükemmel zaman.',
      'Evren cesur ruhları ödüllendirir. Bugün risk al, kazanç seni bekliyor.',
      'İçindeki savaşçı uyanıyor. Korkularını yenmek için mükemmel bir gün.',
      'Ateşin karanlığı eritiyor. Işığınla aydınlat, liderliğinle ilham ver.',
      'Bugün her engel bir merdiven basamağı. Tırman, zirve yakın.',
    ],
    ZodiacSign.taurus: [
      'Toprak ana bugün seni besliyor. Köklerini derinleştir, dallarını göğe uzat.',
      'Venüs güzelliğini artırıyor. Duyularını şımart, hayattan zevk al.',
      'Sabır en büyük gücün. Bekle, zamanı gelince en tatlı meyveler senin olacak.',
      'Bugün bolluk kapıları açılıyor. Güvenle al, minnetle ver.',
      'Dokunuşun şifa veriyor. Kendinle ve sevdiklerinle fiziksel bağ kur.',
      'Değerin yıldızlarda yazılı. Kimseye ispat etmene gerek yok.',
      'Topraklanma günü. Doğayla bağlan, enerjini dengele.',
    ],
    ZodiacSign.gemini: [
      'Zihnin bugün galaksiler arası bir radyo gibi. Mesajları al, bilgiyi yay.',
      'Merkür iletişimini güçlendiriyor. Kelimelerinle büyüle, fikirlerin dünyaları değiştirsin.',
      'İkili doğan merak ediyor. Sorular sor, cevaplar kendiliğinden gelecek.',
      'Bugün her konuşma bir fırsat. Network kur, bağlantılar hayat kurtarır.',
      'Zihinsel çevikliğin süper gücün. Hızlı düşün, hızlı hareket et.',
      'Çok yönlülüğün bir hediye. Bugün tüm yeteneklerini sergile.',
      'Hava elementi seni taşıyor. Hafifle, uç, özgür ol.',
    ],
    ZodiacSign.cancer: [
      'Ay ışığı bugün ruhunu okşuyor. Duygularına alan ver, akışa izin ver.',
      'Yuva içgüdün güçleniyor. Sevdiklerini koru, sıcaklığını paylaş.',
      'Sezgilerin kristal berraklığında. İç sesin seni yanıltmaz.',
      'Bugün duygusal şifa günü. Gözyaşları arındırır, gülüşler iyileştirir.',
      'Annesel enerjin evrenle akıyor. Besle, büyüt, sev.',
      'Kabuk içindeki inci sensin. Savunmalarını indir, gerçek güzelliğini göster.',
      'Ay döngüleriyle dans et. Her faz bir ders, her değişim bir hediye.',
    ],
    ZodiacSign.leo: [
      'Güneş bugün sadece senin için doğuyor. Sahnenin ortasına çık, parla.',
      'Aslan kalbin cesaretle atıyor. Kükre, sesini duyur, kraliyetini kur.',
      'Yaratıcılığın volkanik. Sanatta, hayatta, aşkta... Yaratıcı gücünü kullan.',
      'Bugün ilgi odağı olmak için mükemmel. Işığını saklamayı bırak.',
      'Cömertliğin bereketini artırıyor. Ver ve kat kat al.',
      'Asaletin doğuştan. Taç takmana gerek yok, sen zaten kralsın.',
      'Güneş enerjin şarj oluyor. Bugün karanlık yok, sadece ışık.',
    ],
    ZodiacSign.virgo: [
      'Kusursuzluk arayışın bugün evrensel düzenle buluşuyor. Detaylar sihir yaratır.',
      'Şifalı ellerin bugün güçlü. Kendine ve başkalarına iyilik yap.',
      'Analitik zekân lazer gibi. Karmaşık problemleri çöz, düzeni kur.',
      'Bugün organize et, planla, sistemleştir. Kaos düzene dönüşüyor.',
      'Mükemmeliyetçiliği bırak, ilerlemeyi kutla. Her adım önemli.',
      'Hizmet ruhun parıldıyor. Yardım et, destek ol, fark yarat.',
      'Toprak elementinin pratik büyüsü. Hayalleri gerçeğe dönüştür.',
    ],
    ZodiacSign.libra: [
      'Denge terazin bugün kozmik uyumla sallanıyor. İç huzurunu bul.',
      'Venüs güzelliğini ve çekiciliğini artırıyor. Diplomasi sanatını icra et.',
      'İlişkilerde harmoni zamanı. Köprüler kur, bağları güçlendir.',
      'Bugün estetik duyarlılığın dorukta. Güzellik yarat, güzellik çek.',
      'Adalet duygun evrensel. Doğru olanı savun, sesini yükselt.',
      'Partnerlik enerjin güçlü. Birlikte daha güçlüsünüz.',
      'Hava elementi seni yukarı taşıyor. Perspektif kazan, büyük resmi gör.',
    ],
    ZodiacSign.scorpio: [
      'Dönüşümün simyacısı, bugün karanlık altın oluyor. Gölgeleri kucakla.',
      'Pluto derinliklerden güç veriyor. Gizli hazineleri keşfet.',
      'Yoğun sezgilerin bugün zirve yapıyor. Görünmeyeni gör.',
      'Tutku ve güç birleşiyor. İstediğin her şeyi çekme kapasiten var.',
      'Ölüm ve yeniden doğuş döngüsü. Bitir, başla, dönüş.',
      'Gizemler sana açılıyor. Okült bilgelik içinden akıyor.',
      'Su elementinin en derin hali. Okyanus ol, sonsuzluğu barındır.',
    ],
    ZodiacSign.sagittarius: [
      'Okçu, bugün hedefin sonsuzluk. Okunu fırlat, yıldızlara ulaş.',
      'Jüpiter şansını ve bilgeliğini genişletiyor. Fırsatlar yağmur gibi.',
      'Macera ruhu uyanıyor. Keşfet, öğren, büyü.',
      'Bugün felsefi derinlikler seni çağırıyor. Hayatın anlamını sorgula.',
      'Özgürlük en büyük değerin. Zincirleri kır, kanatlanı aç.',
      'Optimizmin bulaşıcı. Umut taşı, ışık yay.',
      'Ateş elementi seni ileri itiyor. Dur durak bilmeden keşfet.',
    ],
    ZodiacSign.capricorn: [
      'Dağ keçisi, bugün zirveye bir adım daha yakınsın. Tırman, vazgeçme.',
      'Satürn disiplin ve yapı veriyor. Sağlam temeller, kalıcı başarılar.',
      'Uzun vadeli hedeflerin netleşiyor. Sabırla işle, zafer kaçınılmaz.',
      'Bugün otorite ve sorumluluk günü. Liderliğini göster.',
      'Pratik zekân parlıyor. Somut sonuçlar üret.',
      'Kariyer enerjin dorukta. Profesyonel alanda kendini kanıtla.',
      'Toprak elementi sağlamlık veriyor. Köklerin derin, yapın sağlam.',
    ],
    ZodiacSign.aquarius: [
      'Geleceğin vizyoneri, bugün zamanın ötesinde düşün. Devrim yarat.',
      'Uranüs ani aydınlanmalar getiriyor. Beklenmedik fikirler, radikal çözümler.',
      'İnsanlığa hizmet günü. Topluluk için çalış, kolektif bilince katkıda bulun.',
      'Bugün sıra dışı olmak süper gücün. Farklılığını kutla.',
      'Teknoloji ve yenilik alanında parlıyorsun. İcat et, yenile.',
      'Özgürlükçü ruhun evrenle rezonans halinde. Zincirleri kır.',
      'Hava elementi entelektüel yükselişler getiriyor. Düşün, paylaş, ilham ver.',
    ],
    ZodiacSign.pisces: [
      'Rüyaların gezgini, bugün gerçeklik ve hayal iç içe. Her ikisinde de yüz.',
      'Neptün sezgilerini ve yaratıcılığını besliyor. Sanatın içinden aksın.',
      'Spiritüel bağlantın güçleniyor. Evrenle bir ol.',
      'Bugün empati süper gücün. Başkalarını hisset, şifa ver.',
      'Hayal gücün sınırsız. Düşle, hayal et, yaratı.',
      'Su elementinin en mistik hali. Akışa teslim ol.',
      'Şefkat ve merhamet kalbinden akıyor. Sev, affet, kucakla.',
    ],
  };

  /// Morning affirmations by sign
  static final Map<ZodiacSign, List<String>> _morningAffirmations = {
    ZodiacSign.aries: [
      'Bugün cesaretimle dağları aşacağım.',
      'Liderlik enerjim her kapıyı açar.',
      'Korkusuzca ileri atılıyorum.',
      'Yeni başlangıçların gücü benimle.',
      'Ateş ruhum her engeli eritir.',
      'Bugün öncü oluyorum.',
      'Enerjim sınırsız, gücüm sonsuz.',
    ],
    ZodiacSign.taurus: [
      'Bugün bolluk ve bereket beni buluyor.',
      'Değerim tartışılmaz, özgüvenim sağlam.',
      'Sabırla beklediğim güzellikler geliyor.',
      'Toprak gibiyim: güçlü, kararlı, verimli.',
      'Bugün hayatın tadını çıkarıyorum.',
      'Güvenlik ve konfor benim hakkım.',
      'Her anın keyfini sürüyorum.',
    ],
    ZodiacSign.gemini: [
      'Zihinsel çevikliğim her problemi çözer.',
      'Bugün iletişim süper gücüm.',
      'Merakım kapıları açıyor.',
      'Çok yönlülüğüm en büyük avantajım.',
      'Her konuşma bir fırsat.',
      'Fikirlerim dünyayı değiştiriyor.',
      'Öğrenmeye her zaman açığım.',
    ],
    ZodiacSign.cancer: [
      'Bugün duygularım bana rehberlik ediyor.',
      'Sezgilerim her zaman doğru.',
      'Sevgi vermek ve almak için açığım.',
      'İç dünyam güvenli bir liman.',
      'Şefkatim dünyayı iyileştiriyor.',
      'Ailemi ve sevdiklerimi koruyorum.',
      'Duygusal zekam süper gücüm.',
    ],
    ZodiacSign.leo: [
      'Bugün tüm ışığımla parlıyorum.',
      'Yaratıcılığım sınır tanımıyor.',
      'Sahnenin ortasında yerim var.',
      'Cömertliğim bereketimi artırıyor.',
      'Kalbim aslan gibi cesur.',
      'İlham kaynağı oluyorum.',
      'Kendimi sevmek en büyük gücüm.',
    ],
    ZodiacSign.virgo: [
      'Bugün mükemmelliğe değil, ilerlemeye odaklanıyorum.',
      'Analitik zekam her detayı görüyor.',
      'Hizmet etmek beni yüceltiyor.',
      'Düzen ve sistemlerim hayatımı kolaylaştırıyor.',
      'Sağlığım en büyük zenginliğim.',
      'Pratik çözümlerim fark yaratıyor.',
      'Kendime ve başkalarına şifa veriyorum.',
    ],
    ZodiacSign.libra: [
      'Bugün iç huzurumu buluyorum.',
      'İlişkilerimde uyum yaratıyorum.',
      'Güzellik ve estetik hayatımı zenginleştiriyor.',
      'Adalet ve denge yolumda.',
      'Diplomatik yeteneklerim kapıları açıyor.',
      'Partnerliklerim beni güçlendiriyor.',
      'Sevgi ve barış yayıyorum.',
    ],
    ZodiacSign.scorpio: [
      'Bugün dönüşüm gücümü kullanıyorum.',
      'Derinliklerde hazineler beni bekliyor.',
      'Sezgilerim asla yanıltmaz.',
      'Tutkum her şeyi mümkün kılıyor.',
      'Gölgelerim aydınlanıyor.',
      'Yeniden doğuş zamanı.',
      'Gücüm içimden geliyor.',
    ],
    ZodiacSign.sagittarius: [
      'Bugün yeni ufuklara yelken açıyorum.',
      'Şansım her zaman yanımda.',
      'Macera ruhu beni ileri taşıyor.',
      'Bilgelik arayışım devam ediyor.',
      'Özgürlük en büyük değerim.',
      'İyimserliğim bulaşıcı.',
      'Her gün yeni bir keşif.',
    ],
    ZodiacSign.capricorn: [
      'Bugün hedeflerime bir adım daha yaklaşıyorum.',
      'Disiplinim beni zirveye taşıyor.',
      'Sabır ve azimle her şeyi başarıyorum.',
      'Kariyerimde yükseliyorum.',
      'Temelleri sağlam atıyorum.',
      'Otoritem saygı kazanıyor.',
      'Başarı benim için kaçınılmaz.',
    ],
    ZodiacSign.aquarius: [
      'Bugün geleceği şekillendiriyorum.',
      'Benzersizliğim en büyük gücüm.',
      'İnsanlığa katkıda bulunuyorum.',
      'Yenilikçi fikirlerim dünyayı değiştiriyor.',
      'Özgür düşünce gücümü artırıyor.',
      'Topluluk bilinci beni yönlendiriyor.',
      'Devrimci ruhumla ilham veriyorum.',
    ],
    ZodiacSign.pisces: [
      'Bugün sezgilerim rehberim.',
      'Yaratıcılığım sınırsız.',
      'Spiritüel bağlantım güçlü.',
      'Empatim dünyayı iyileştiriyor.',
      'Rüyalarım gerçeğe dönüşüyor.',
      'Koşulsuz sevgi veriyorum.',
      'Evrenle bir oluyorum.',
    ],
  };

  static final List<String> _universalAffirmations = [
    'Bugün hayatımın en güzel günü.',
    'Evren benim yanımda.',
    'Her şey yolunda gidiyor.',
    'Sevgi ve ışık içindeyim.',
    'Bolluk ve bereket beni buluyor.',
    'Gücüm içimden geliyor.',
    'Her an için minnettarım.',
  ];

  /// Evening reflections by sign
  static final Map<ZodiacSign, List<String>> _eveningReflections = {
    ZodiacSign.aries: [
      'Bugün cesaretinle neler başardın? Kendini kutla.',
      'Hangi engelleri aştın? Gücünü hatırla.',
      'Sabır gösterebildin mi? İlerlemen için önemli.',
    ],
    ZodiacSign.taurus: [
      'Bugün hangi güzelliklerden zevk aldın?',
      'Kendine nasıl değer verdin?',
      'Minnettarlık listeni gözden geçir.',
    ],
    ZodiacSign.gemini: [
      'Bugün ne öğrendin? Bilgi ruhunu besler.',
      'Hangi bağlantıları kurdun?',
      'Fikirlerini kimlerle paylaştın?',
    ],
    ZodiacSign.cancer: [
      'Bugün duygularınla nasıl bağ kurdun?',
      'Sevdiklerine nasıl baktın?',
      'İç dünyan huzurlu mu?',
    ],
    ZodiacSign.leo: [
      'Bugün nasıl parladın?',
      'Yaratıcılığını nasıl ifade ettin?',
      'Kimlere ışık oldun?',
    ],
    ZodiacSign.virgo: [
      'Bugün kendine nasıl hizmet ettin?',
      'Hangi detaylar fark yarattı?',
      'Sağlığına nasıl baktın?',
    ],
    ZodiacSign.libra: [
      'Bugün dengeyi nasıl buldun?',
      'İlişkilerinde uyum sağladın mı?',
      'Güzellik nasıl hayatına dokundu?',
    ],
    ZodiacSign.scorpio: [
      'Bugün hangi derinliklere indin?',
      'Neyi dönüştürdün?',
      'Hangi gizli güçleri keşfettin?',
    ],
    ZodiacSign.sagittarius: [
      'Bugün ne keşfettin?',
      'Hangi bilgeliği buldun?',
      'Özgürlük nasıl bir his?',
    ],
    ZodiacSign.capricorn: [
      'Bugün hedeflerine nasıl yaklaştın?',
      'Hangi temelleri attın?',
      'Disiplininden memnun musun?',
    ],
    ZodiacSign.aquarius: [
      'Bugün nasıl fark yarattın?',
      'Topluma nasıl katkıda bulundun?',
      'Hangi yenilikçi fikirler geldi?',
    ],
    ZodiacSign.pisces: [
      'Bugün sezgilerin seni nereye götürdü?',
      'Hangi rüyalar gerçeğe dönüştü?',
      'Spiritüel bağlantın nasıl?',
    ],
  };

  static final List<String> _universalReflections = [
    'Bugün için minnettarlık listeni gözden geçir.',
    'Hangi anlar seni gülümsetti?',
    'Yarın için bir niyet belirle.',
  ];

  /// Moon phase insights
  static final Map<String, String> _moonPhaseInsights = {
    'new_moon':
        'Yeni Ay zamanı - yeni başlangıçlar için tohum ek. Niyetlerini netleştir, içe dön, planla.',
    'waxing_crescent':
        'Hilal Ay - niyetlerini eyleme dönüştür. İnanç ve umut zamanı.',
    'first_quarter':
        'İlk Dördün - engellerle yüzleş, kararlı ol. Aksiyon zamanı.',
    'waxing_gibbous':
        'Kabaran Ay - ince ayar yap, sabırlı ol. Sonuçlar yaklaşıyor.',
    'full_moon':
        'Dolunay - enerji doruğunda! Manifestasyonlar gerçekleşiyor, şükret ve kutla.',
    'waning_gibbous':
        'Azalan Ay - bilgeliği paylaş, minnettarlık prat. Hasat zamanı.',
    'last_quarter':
        'Son Dördün - bırakma ve affetme zamanı. Eskiyi serbest bırak.',
    'waning_crescent':
        'Son Hilal - dinlen, rüya gör, arın. Döngü tamamlanıyor.',
  };

  /// Daily intentions by sign
  static final Map<ZodiacSign, List<String>> _dailyIntentions = {
    ZodiacSign.aries: [
      'Bugün sabırla hareket ediyorum.',
      'Cesaretimi pozitif yönde kullanıyorum.',
      'Liderliğimi sevgiyle gösteriyorum.',
      'Her engeli fırsat olarak görüyorum.',
      'Enerjimi bilinçli yönlendiriyorum.',
      'Yeni başlangıçlara açığım.',
      'Gücümü başkalarını yükseltmek için kullanıyorum.',
    ],
    ZodiacSign.taurus: [
      'Bugün bolluğa açılıyorum.',
      'Hayatın küçük zevklerinin tadını çıkarıyorum.',
      'Sabırla güzel şeylerin gelmesine izin veriyorum.',
      'Değerimi biliyorum ve savunuyorum.',
      'Güvenlik içinde özgürüm.',
      'Doğayla bağlantı kuruyorum.',
      'Minnettarlık pratik yapıyorum.',
    ],
    ZodiacSign.gemini: [
      'Bugün bilinçli iletişim kuruyorum.',
      'Öğrenmeye açık bir zihinle yaklaşıyorum.',
      'Merakımı pozitif yönde kullanıyorum.',
      'Fikirlerimi netleştiriyorum.',
      'Dinlemeye odaklanıyorum.',
      'Çok yönlülüğümü kutluyorum.',
      'Bağlantılarımı derinleştiriyorum.',
    ],
    ZodiacSign.cancer: [
      'Bugün duygularıma alan tanıyorum.',
      'Sezgilerime güveniyorum.',
      'Sevdiklerime sevgimi gösteriyorum.',
      'Kendime şefkatle davranıyorum.',
      'Güvenli sınırlar oluşturuyorum.',
      'Geçmişi iyileştiriyorum.',
      'Yuva enerjisi yaratıyorum.',
    ],
    ZodiacSign.leo: [
      'Bugün otantik ben oluyorum.',
      'Yaratıcılığımı ifade ediyorum.',
      'Başkalarının ışımasına alan açıyorum.',
      'Cömertlikle veriyorum.',
      'Kendimi sevgiyle kutluyorum.',
      'İlham kaynağı oluyorum.',
      'Kalbimden konuşuyorum.',
    ],
    ZodiacSign.virgo: [
      'Bugün mükemmeliyetçiliği bırakıyorum.',
      'Kendime şefkat gösteriyorum.',
      'Detaylarda anlam buluyorum.',
      'Sağlığıma öncelik veriyorum.',
      'Hizmet ederken sınır koyuyorum.',
      'İlerlemeyi kutluyorum.',
      'Düzeni sevgiyle yaratıyorum.',
    ],
    ZodiacSign.libra: [
      'Bugün iç dengeyi buluyorum.',
      'İlişkilerimde sınır koyuyorum.',
      'Güzellik yaratıyorum.',
      'Kararlarımda kendime güveniyorum.',
      'Uyumu içeriden başlatıyorum.',
      'Adalet için sesimi yükseltiyorum.',
      'Barışı yayıyorum.',
    ],
    ZodiacSign.scorpio: [
      'Bugün dönüşüme açığım.',
      'Derinliği kucaklıyorum.',
      'Gölgelerimi aydınlatıyorum.',
      'Tutkumu bilinçli yönlendiriyorum.',
      'Güvenmeyi öğreniyorum.',
      'Yeniden doğuşu kutluyorum.',
      'Gücümü bilgelikle kullanıyorum.',
    ],
    ZodiacSign.sagittarius: [
      'Bugün yeni ufuklar arıyorum.',
      'Bilgelik arayışımı sürdürüyorum.',
      'Özgürlüğümü sorumlulukla kullanıyorum.',
      'İyimserliği yayıyorum.',
      'Maceraya evet diyorum.',
      'Büyük resmi görüyorum.',
      'İnancımı güçlendiriyorum.',
    ],
    ZodiacSign.capricorn: [
      'Bugün hedeflerime odaklanıyorum.',
      'Sabırla ilerliyorum.',
      'Disiplinimi sevgiyle uyguluyorum.',
      'Başarıyı kutluyorum.',
      'Dinlenmeye de izin veriyorum.',
      'Sorumluluklarımı dengeliyorum.',
      'Zirveye yaklaşıyorum.',
    ],
    ZodiacSign.aquarius: [
      'Bugün benzersizliğimi kutluyorum.',
      'İnsanlığa hizmet ediyorum.',
      'Yenilikçi düşünüyorum.',
      'Toplulukla bağ kuruyorum.',
      'Geleceği şekillendiriyorum.',
      'Özgür düşünceyi savunuyorum.',
      'Değişimi kucaklıyorum.',
    ],
    ZodiacSign.pisces: [
      'Bugün sezgilerime güveniyorum.',
      'Spiritüel bağlantımı derinleştiriyorum.',
      'Yaratıcılığımı ifade ediyorum.',
      'Empatiyle sınır koyuyorum.',
      'Rüyalarıma dikkat ediyorum.',
      'Evrenle bir oluyorum.',
      'Koşulsuz sevgi veriyorum.',
    ],
  };

  static final List<String> _universalIntentions = [
    'Bugün farkındalıkla yaşıyorum.',
    'Her ana teşekkür ediyorum.',
    'Sevgi ve ışık yayıyorum.',
    'Potansiyelimi keşfediyorum.',
    'Şu anda kalıyorum.',
    'Kendimle barışık oluyorum.',
    'Evrene güveniyorum.',
  ];

  /// Get extended cosmic wisdom for deeper readings
  static String getExtendedCosmicWisdom(ZodiacSign sign, {DateTime? date}) {
    final dayOfYear = (date ?? DateTime.now())
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    final wisdoms = _extendedCosmicWisdoms[sign] ?? _universalExtendedWisdoms;
    return wisdoms[dayOfYear % wisdoms.length];
  }

  /// Get planet-based daily guidance
  static String getPlanetaryGuidance(String planet) {
    return _planetaryGuidance[planet.toLowerCase()] ??
        _planetaryGuidance['sun']!;
  }

  /// Get element-based message
  static String getElementMessage(String element) {
    return _elementMessages[element.toLowerCase()] ?? _elementMessages['fire']!;
  }

  /// Get house-based daily insight
  static String getHouseInsight(int houseNumber) {
    return _houseInsights[houseNumber] ?? _houseInsights[1]!;
  }

  /// Extended cosmic wisdoms for deeper readings
  static final Map<ZodiacSign, List<String>> _extendedCosmicWisdoms = {
    ZodiacSign.aries: [
      'Koç burcu, içindeki savaşçı bugün uyanıyor. Mars enerjin dorukta, cesaretinle yeni kapılar açacaksın. Ancak unutma, gerçek güç kontrollü güçtür. Sabırsızlığın seni yanlış yöne çekmesin. Bugün başlattığın her şey uzun vadeli sonuçlar doğuracak.',
      'Ateş elementinin öncüsü olarak, bugün liderlik enerjin etrafındakileri etkiliyor. Yeni projeler, yeni ilişkiler, yeni başlangıçlar için evren sana yeşil ışık yakıyor. Korkuyu bir kenara bırak ve kalbinin gösterdiği yöne doğru cesurca ilerle.',
      'Kozmik enerjiler bugün sana "harekete geç" diyor. Beklemek için zaman yok, düşünmek için zaman yok. Sezgilerin seni doğru yola götürecek. İçgüdülerine güven, çünkü evren senin yanında.',
    ],
    ZodiacSign.taurus: [
      'Boğa burcu, Venüs\'ün çocuğu olarak bugün güzellik ve bolluk enerjisi seni sarıyor. Maddi dünya seninle uyum içinde. Ancak gerçek zenginlik içsel huzurda yatıyor. Bugün hem maddi hem manevi bolluğa açıl.',
      'Toprak elementinin en istikrarlı temsilcisi olarak, bugün sabır ve kararlılığın meyvelerini toplamaya hazırsın. Hızlı koşanlar yorulur, ama sen adım adım zirveye ulaşırsın. Güven kendine, zamanlaması mükemmel.',
      'Duyusal zevkler bugün seni çağırıyor. Güzel bir yemek, hoş bir müzik, sevilen birinin dokunuşu... Bunlar sadece zevk değil, ruhunu besleyen iksirler. Kendini şımartmaya izin ver.',
    ],
    ZodiacSign.gemini: [
      'İkizler burcu, Merkür\'ün hareketli çocuğu olarak bugün zihinsel çevikliğin doruklarda. Bilgi seni bekliyor, bağlantılar kapıda. Her konuşma bir fırsat, her karşılaşma bir ders taşıyor.',
      'Çok yönlülüğün bugün süper gücün. Aynı anda birçok projeyi yönetebilir, farklı insanlarla farklı konularda derinlemesine sohbet edebilirsin. Bu senin doğal halin, bunu kutla.',
      'Merak ediyor musun? İyi, çünkü merak bilgeliğin kapısıdır. Bugün soru sor, araştır, öğren. Evren senin öğrenci olmana bayılıyor, çünkü öğrendiklerini paylaşarak öğretmen olursun.',
    ],
    ZodiacSign.cancer: [
      'Yengeç burcu, Ay\'ın hassas çocuğu olarak bugün duygusal radar sezgilerinin en güçlü olduğu gün. İç sesin sana ne fısıldıyor? Dinle, çünkü evrenin mesajı orada gizli.',
      'Yuva, aile, kökler... Bunlar senin için sadece kelimeler değil, ruhunun demir atma noktaları. Bugün sevdiklerine zaman ayır, onları koru, sıcaklığını paylaş. Şefkatin şifa verir.',
      'Duygularından korkma. Gözyaşları zayıflık değil, arınma. Gülüşler mutluluk değil, şifa. Bugün duygularına alan ver, onları yaşa ve bırak. Özgürleşeceksin.',
    ],
    ZodiacSign.leo: [
      'Aslan burcu, Güneş\'in görkemli çocuğu olarak bugün ışığın karanlığı eritiyor. Parlamak senin doğan hakkın, saklanmak ise en büyük günahın. Sahneye çık ve dünyaya kim olduğunu göster.',
      'Yaratıcılığın bugün volkanik. Sanat, müzik, dans, yazı... Her türlü yaratıcı ifade senin için enerji kanalı. Yarattığın her şey ruhunun bir parçasını taşıyor.',
      'Cömertliğin bereketini artırıyor. Verdiğin her şey kat kat geri dönecek. Bugün paylaş - sevgini, zamanını, kaynaklarını. Evren cömert ruhlara cömertçe karşılık verir.',
    ],
    ZodiacSign.virgo: [
      'Başak burcu, analitik zekanın en keskin olduğu gün bugün. Detaylar seni çağırıyor, düzen seni bekliyor. Ancak unutma, mükemmellik bir hedef değil, bir yolculuk. İlerlemen mükemmelliğinden daha değerli.',
      'Şifa ellerin bugün aktif. Kendine ve başkalarına iyilik yapma zamanı. Küçük yardımlar büyük farklar yaratır. Hizmet etmek seni küçültmez, yüceltir.',
      'Pratik zekân bugün süper güç. Karmaşık problemlere basit çözümler bulabilirsin. Sistemler kur, düzen oluştur, verimlilik artır. Dünya senin organize edici gücüne ihtiyaç duyuyor.',
    ],
    ZodiacSign.libra: [
      'Terazi burcu, Venüs\'ün dengeli çocuğu olarak bugün harmoni enerjisi etrafını sarıyor. İlişkilerde barış, sanatta güzellik, hayatta denge... Bunlar senin doğal halin.',
      'Diplomasi yeteneğin bugün zirve yapıyor. Çatışmaları çözebilir, köprüler kurabilir, insanları bir araya getirebilirsin. Bu bir yetenek değil, bir misyon.',
      'Estetik duyarlılığın bugün dorukta. Güzellik sadece görsel değil, ruhsal. Etrafına güzellik yay, güzel düşün, güzel konuş. Evren sana güzellikle karşılık verecek.',
    ],
    ZodiacSign.scorpio: [
      'Akrep burcu, dönüşümün simyacısı olarak bugün karanlık altına dönüşüyor. Gölgelerden korkma, çünkü en değerli hazineler orada gizli. Derinliklere dal, cesurca.',
      'Sezgilerin bugün lazer gibi keskin. Görünmeyeni görebilir, bilinmeyeni bilebilirsin. Bu güce saygıyla yaklaş, çünkü bilgi güçtür ve güç sorumluluk getirir.',
      'Tutku ve yoğunluk senin doğal enerjin. Bugün bu enerjiyi yaratıcı ve dönüştürücü yollarla kullan. İstediğin her şeyi çekme kapasiten var, niyetine dikkat et.',
    ],
    ZodiacSign.sagittarius: [
      'Yay burcu, Jüpiter\'in maceraperest çocuğu olarak bugün yeni ufuklar seni çağırıyor. Fiziksel, zihinsel veya ruhsal... Her türlü yolculuk için mükemmel zaman.',
      'Bilgelik arayışın bugün güçleniyor. Felsefe, din, spiritüellik... Hayatın büyük sorularına cevap arıyorsun. Cevaplar içinde, dışarıda sadece işaretler var.',
      'İyimserliğin bulaşıcı. Bugün umut taşı, ışık yay, insanlara inanmayı öğret. Karanlık zamanlarda bile güneşin doğacağını bilen sen, diğerlerine hatırlat.',
    ],
    ZodiacSign.capricorn: [
      'Oğlak burcu, Satürn\'ün disiplinli çocuğu olarak bugün zirveye bir adım daha yakınsın. Hedeflerine odaklan, planını takip et, vazgeçme. Başarı senin için kaçınılmaz.',
      'Uzun vadeli düşünme yeteneğin bugün avantaj. Herkes bugünü düşünürken, sen yarını planlıyorsun. Temelleri sağlam atan her zaman kazanır.',
      'Otorite ve sorumluluk seni korkutmasın, bunlar senin doğal alanın. Liderlik etmeye, yönetmeye, organize etmeye hazırsın. Dünya senin yapıcı enerjine ihtiyaç duyuyor.',
    ],
    ZodiacSign.aquarius: [
      'Kova burcu, Uranüs\'ün devrimci çocuğu olarak bugün geleceği şekillendiriyorsun. Vizyoner bakış açın, yenilikçi fikirlerin dünyayı değiştirebilir. Hayal et ve cesurca paylaş.',
      'İnsanlığa hizmet bugün önceliğin. Bireysel başarılar güzel ama kolektif ilerleme daha anlamlı. Topluluk bilinci senin güç kaynağın.',
      'Benzersizliğin süper gücün. Herkes gibi olmak zorunda değilsin, zaten herkes olmak istemiyor. Farklılığını kutla, özgünlüğünle gurur duy.',
    ],
    ZodiacSign.pisces: [
      'Balık burcu, Neptün\'ün mistik çocuğu olarak bugün perde aralanıyor. Görünmeyen dünyalar, duyulmayan sesler, hissedilmeyen enerjiler... Hepsine erişimin var.',
      'Yaratıcılığın bugün okyanus gibi derin. Sanat, müzik, şiir, dans... Her türlü yaratıcı ifade ruhundan akıyor. Yarattığın her şey evrenle bir olmanın kanıtı.',
      'Empatin bugün hem güç hem de yük. Başkalarının duygularını hissedebilirsin ama kendi sınırlarını koru. Şifa vermek güzel, ama önce kendini iyileştir.',
    ],
  };

  static final List<String> _universalExtendedWisdoms = [
    'Evren bugün seninle dans ediyor. Her nefes, kozmik bir hediye. Her kalp atışı, evrensel ritimle uyum içinde. Farkındalıkla yaşa, her anın değerini bil.',
    'Yıldızlar ruhunun haritasını çiziyor. Geçmiş, şimdi ve gelecek... Hepsi şu anda buluşuyor. Zamanın ötesinde bir perspektifle hayata bak.',
    'Kozmik enerji bugün dönüşüm için mükemmel. Eskiyi bırak, yeniye merhaba de. Değişim korkunç değil, doğal. Değişime direnmek yorar, akışa teslim ol.',
  ];

  /// Planetary guidance messages
  static final Map<String, String> _planetaryGuidance = {
    'sun':
        'Güneş enerjisi bugün kimliğini ve yaşam gücünü aydınlatıyor. Kendini ifade et, parla, merkezinde kal. Güneş gibi etrafına ışık ve sıcaklık yay.',
    'moon':
        'Ay bugün duygusal dünyani aktive ediyor. Sezgilerine güven, iç sesini dinle, hislerini kabul et. Ay döngüleriyle uyum içinde hareket et.',
    'mercury':
        'Merkür iletişim ve düşünce kanallarını açıyor. Konuş, yaz, öğren, öğret. Fikirlerini paylaş, bilgi al ver. Zihinsel çevikliğini kullan.',
    'venus':
        'Venüs sevgi, güzellik ve değerler konusunda rehberlik ediyor. Aşkı kabul et, güzellik yarat, kendine değer ver. Hayatın tadını çıkar.',
    'mars':
        'Mars aksiyon ve enerji veriyor. Harekete geç, cesaretini kullan, hedeflerine doğru ilerle. Tutkunla motive ol, ama öfkeni kontrol et.',
    'jupiter':
        'Jüpiter şans ve genişleme getiriyor. Fırsatlara açık ol, risk al, büyük düşün. Bolluk ve bilgelik kapıları açılıyor.',
    'saturn':
        'Satürn disiplin ve yapı öğretiyor. Sabırlı ol, sorumlu davran, uzun vadeli düşün. Sınırlamalar aslında koruma.',
    'uranus':
        'Uranüs ani değişimler ve aydınlanmalar getiriyor. Beklenmedik olaylara açık ol, eski kalıpları kır, özgür düşün.',
    'neptune':
        'Neptün spiritüel bağlantıyı güçlendiriyor. Rüyalara dikkat et, sezgilerine güven, yaratıcılığını kullan. Görünmeyeni gör.',
    'pluto':
        'Pluto derin dönüşümü tetikliyor. Gölgelerle yüzleş, ölüp yeniden doğ, gücünü keşfet. Korkularının ötesine geç.',
  };

  /// Element-based messages
  static final Map<String, String> _elementMessages = {
    'fire':
        'Ateş elementi bugün tutkunu, cesaretini ve yaşam enerjini ateşliyor. Harekete geç, risk al, parla. Ateş gibi dönüştürücü ol, ama kontrolü elden bırakma.',
    'earth':
        'Toprak elementi bugün pratikliğini, istikrarını ve maddi bilincini güçlendiriyor. Temelleri sağlam at, sabırla çalış, somut sonuçlar üret.',
    'air':
        'Hava elementi bugün zihinsel çevikliğini, iletişimini ve sosyal bağlantılarını destekliyor. Düşün, konuş, bağlan. Fikirlerini paylaş, öğren.',
    'water':
        'Su elementi bugün duygusal derinliğini, sezgilerini ve empati gücünü aktive ediyor. Hisset, sezgilerine güven, akışa teslim ol.',
  };

  /// House-based daily insights
  static final Map<int, String> _houseInsights = {
    1: '1. Ev bugün aktif - Kişisel kimliğin, fiziksel görünümün ve yeni başlangıçlar enerjin güçleniyor. Kendini göster, inisiyatif al.',
    2: '2. Ev bugün aktif - Para, değerler ve öz-değer konuları ön planda. Maddi güvenliğine odaklan, yeteneklerini değerlendir.',
    3: '3. Ev bugün aktif - İletişim, kısa yolculuklar ve öğrenme zamanı. Konuş, yaz, kardeşlerinle iletişim kur, yeni şeyler öğren.',
    4: '4. Ev bugün aktif - Ev, aile ve duygusal kökler günü. Yuvanı düzenle, aileyle zaman geçir, iç huzurunu bul.',
    5: '5. Ev bugün aktif - Yaratıcılık, romantizm ve eğlence zamanı. Sanatla uğraş, aşkın tadını çıkar, çocuk gibi oyna.',
    6: '6. Ev bugün aktif - Sağlık, günlük rutinler ve hizmet günü. Sağlığına dikkat et, işlerini organize et, yardımsever ol.',
    7: '7. Ev bugün aktif - İlişkiler ve ortaklıklar odakta. Partnerine zaman ayır, iş birliği yap, dengeli ilişkiler kur.',
    8: '8. Ev bugün aktif - Dönüşüm, ortak kaynaklar ve derin bağlantılar günü. Değişimi kucakla, paylaş, derinlere dal.',
    9: '9. Ev bugün aktif - Felsefe, uzak yolculuklar ve yüksek öğrenim zamanı. Bilgelik ara, yeni kültürler keşfet, büyük resmi gör.',
    10: '10. Ev bugün aktif - Kariyer, toplumsal statü ve hedefler günü. Profesyonel alanda parla, hedeflerine odaklan, liderlik et.',
    11: '11. Ev bugün aktif - Arkadaşlıklar, gruplar ve idealler zamanı. Sosyal çevrende aktif ol, toplulukla bağlan, geleceği planla.',
    12: '12. Ev bugün aktif - Bilinçaltı, spiritüellik ve arınma günü. Meditasyon yap, rüyalarına dikkat et, geçmişi bırak.',
  };
}
