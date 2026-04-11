import '../models/planet.dart';
import '../models/zodiac_sign.dart';
import '../models/house.dart';

/// Service for generating personalized esoteric interpretations
class EsotericInterpretationService {
  /// Get personalized sun sign interpretation
  static String getSunInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Ateş elementiyle yaratılmış ruhun, kozmik iradenin ilk kıvılcımını taşıyor. Koç enerjisi sende, evrenin "Ol!" emrini temsil ediyor - saf yaratıcı güç, başlatıcı enerji.

Ruhun bu yaşama, liderlik ve cesaret derslerini öğrenmeye geldi. Korkusuzca ilerleme, yeni başlangıçlar yapma ve kendi yolunu açma senin kozmik görevlerin arasında.

Gölgen, sabırsızlık ve dürtüsellik olabilir. Ancak bu "gölge" aslında senin yanlış anlaşılmış gücün - onu dönüştürdüğünde, vizyoner bir öncü olursun.

Ruhsal yolculuğunda, ego ile ruh arasındaki dengeyi bulmak en büyük dersin. "Ben varım" diyebilmek kutsal bir haktır - ama "Biz varız" demek ustalığa giden yoldur.
''',
      ZodiacSign.taurus: '''
Toprak elementinin en sabit, en verimli ifadesisin. Boğa enerjisi sende, Dünya Ana'nın bereketini, maddenin kutsallığını temsil ediyor.

Ruhun bu yaşama, değer ve bolluk derslerini keşfetmeye geldi. Neyin gerçekten değerli olduğunu - para ve mal ötesinde - anlamak senin spiritüel yolculuğun.

Haz alma kapasitenin yüksekliği bir lanet değil, bir armağan. Beş duyunla evreni deneyimlemen, ruhsal uyanışın bedeni aracığıdır.

Değişime direnme eğilimin, aslında özünü koruma içgüdüsü. Ama evren sürekli değişim içinde - akmayı öğrendiğinde, hem köklü hem de özgür olabilirsin.
''',
      ZodiacSign.gemini: '''
Hava elementinin en hareketli, en meraklı ifadesisin. İkizler enerjisi sende, kozmik zihnin sonsuz sorularını taşıyor.

Ruhun bu yaşama, bağlantı ve iletişim ustası olmak için geldi. Kelimelerle şifa, fikirlerle dönüşüm senin kutsal araçların.

"İki yüzlü" denilen şey, aslında senin çok boyutluluğun. Her insanda birden fazla ben var - sen sadece bunun farkındasın ve hepsine ses veriyorsun.

Zihinsel huzursuzluğun, evrenin sana verdiği sınırsız merak armağanı. Onu disiplinle birleştirdiğinde, herhangi bir konunun derinliklerine inebilirsin.
''',
      ZodiacSign.cancer: '''
Su elementinin koruyucu, besleyici ifadesisin. Yengeç enerjisi sende, Kozmik Ana'nın sevgisini, yuvanın kutsallığını taşıyor.

Ruhun bu yaşama, duygusal bilgelik ve şifa derslerini öğrenmeye geldi. Hissetme kapasitenin derinliği, senin süper gücün.

Aşırı hassasiyetin bir zayıflık değil - evrenin titreşimlerini algılayan bir anten. Bu hassasiyeti sınırlarla birleştirdiğinde, gerçek empatik şifacı olursun.

Geçmişe tutunma eğilimin, aslında ruhsal belleğinin güçlü olduğunun işareti. Atalarının bilgeliği sende yaşıyor - onurlandır ama geçmişin esiri olma.
''',
      ZodiacSign.leo: '''
Ateş elementinin en parlak, en yaratıcı ifadesisin. Aslan enerjisi sende, Güneş'in ışığını, yaratıcı ilahi kıvılcımı taşıyor.

Ruhun bu yaşama, otantik kendini ifade etme ve kalp merkezli liderlik derslerini öğrenmeye geldi. Parlamak senin doğal halin - başkalarının ışığını söndürmeden parla.

Ego ihtiyaçların, aslında tanınma ve değer görme açlığı. Bu açlık, içsel değerini keşfettiğinde doyar - dışsal onaylar bonus olur.

Drama eğilimin, hayatı yoğun yaşama arzun. Her gün bir sahne, her an bir performans olabilir - ama en derin sahne, içsel dönüşümün sahnesidir.
''',
      ZodiacSign.virgo: '''
Toprak elementinin en analitik, en arındırıcı ifadesisin. Başak enerjisi sende, kutsal düzenin, mükemmelliğe giden yolun şifresini taşıyor.

Ruhun bu yaşama, hizmet ve arınma derslerini öğrenmeye geldi. Detaylarda Tanrı'yı görmek senin mistik yolun.

Mükemmeliyetçiliğin bir hastalık değil - evrenin sana verdiği kalite standardı. Bunu kendine de başkalarına da şefkatle uyguladığında, dönüştürücü güç olursun.

Eleştiri eğilimin, aslında iyileştirme arzun. Her kusur gördüğünde, aslında potansiyeli görüyorsun. Bu vizyonu sevgiyle birleştir.
''',
      ZodiacSign.libra: '''
Hava elementinin en uyumlu, en estetik ifadesisin. Terazi enerjisi sende, kozmik dengenin, ilahi adaletin ve güzelliğin şifresini taşıyor.

Ruhun bu yaşama, ilişki ve denge ustası olmak için geldi. Her ilişki sana ayna tutuyor - kendini başkalarında keşfediyorsun.

Kararsızlığın bir zayıflık değil - tüm perspektifleri görebilme armağanı. Her seçeneğin değerini anlıyorsun, bu bilgelik.

Çatışmadan kaçınma eğilimin, aslında barış arayışın. Ama gerçek barış, bazen dürüst çatışmadan geçer. Kendi sesin için savaşmayı öğren.
''',
      ZodiacSign.scorpio: '''
Su elementinin en derin, en dönüştürücü ifadesisin. Akrep enerjisi sende, ölüm ve yeniden doğuşun, simyanın sırrını taşıyor.

Ruhun bu yaşama, derin dönüşüm ve güç ustası olmak için geldi. Karanlığa bakabilme cesaretin, en büyük armağanın.

Yoğunluğun bir lanet değil - tutkuyla yaşama kapasiten. Bu yoğunluğu kontrol etmeyi öğrendiğinde, mucizeler yaratırsın.

Kontrol ihtiyacın, aslında savunmasız hissetme korkun. Güvenmeyi ve bırakmayı öğrendiğinde, gerçek gücünü bulursun.
''',
      ZodiacSign.sagittarius: '''
Ateş elementinin en özgür, en filozof ifadesisin. Yay enerjisi sende, arayışın kutsal ateşini, hakikate olan açlığı taşıyor.

Ruhun bu yaşama, anlam ve özgürlük derslerini öğrenmeye geldi. Ufukların ötesine bakmak senin doğal halin.

Taahhüt korkun, aslında sınırsızlık arzun. Özgürlüğün taahhütle birlikte var olabileceğini keşfetmek senin büyüme alanın.

Aşırı iyimserliğin, evrene olan temel güvenin. Bu güveni gerçekçilikle dengelediğinde, hem hayalperest hem de eylem insanı olursun.
''',
      ZodiacSign.capricorn: '''
Toprak elementinin en hırslı, en disiplinli ifadesisin. Oğlak enerjisi sende, zamanın bilgeliğini, ustalığa giden yolun şifresini taşıyor.

Ruhun bu yaşama, başarı ve sorumluluk derslerini öğrenmeye geldi. Dağın zirvesine tırmanmak senin arketipik yolculuğun.

Duygusal mesafen, aslında koruma mekanizman. İçsel çocuğunla barıştığında, hem güçlü hem de yumuşak olabilirsin.

İş odaklılığın, aslında miras bırakma arzun. Ama en büyük miras, maddi başarılar değil - ruhsal olgunluğun.
''',
      ZodiacSign.aquarius: '''
Hava elementinin en vizyoner, en özgün ifadesisin. Kova enerjisi sende, geleceğin şifrelerini, kolektif uyanışın tohumlarını taşıyor.

Ruhun bu yaşama, insanlığa hizmet ve özgünlük derslerini öğrenmeye geldi. Farklı olmak senin kutsal görevin.

Duygusal kopukluk hissin, aslında evrensel bakış açın. Yakın ilişkilerde de bu geniş perspektifi koruyabilmeyi öğrenmek senin yolculuğun.

İsyankar doğan, statükonun ötesini görebilme armağanı. Yıkmak için değil, daha iyisini inşa etmek için bu gücü kullan.
''',
      ZodiacSign.pisces: '''
Su elementinin en mistik, en sınırsız ifadesisin. Balık enerjisi sende, evrensel bilincin okyanusunu, ilahi aşkın sonsuzluğunu taşıyor.

Ruhun bu yaşama, ruhsal birlik ve şefkat derslerini öğrenmeye geldi. Sınırların erimesi senin doğal halin - herkes ve her şeyle bir olabilirsin.

Kaçış eğilimin, aslında yüksek alemlere olan özlemin. Bu özlemi yaratıcılık ve ruhsal pratiklerle karşıladığında, kaçış yerine aşkınlık bulursun.

Aşırı hassasiyetin, psişik antenin güçlü olduğunun işareti. Enerjetik koruma tekniklerini öğrendiğinde, bu armağan sana ve başkalarına hizmet eder.
''',
    };

    return interpretations[sign] ?? '';
  }

  /// Get personalized moon sign interpretation
  static String getMoonInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Duygusal dünyan ateşle yanıyor - hızlı, yoğun, anlık. Hislerini bastıramazsın, onlar volkanik patlamalar gibi yükselir ve sakinleşir.

Duygusal ihtiyaçların arasında bağımsızlık ve eylem var. Pasif kalmak seni bunaltır. Duygularınla harekete geçmek, senin şifa yolun.

Öfken hızlı gelir hızlı gider - bu bir zayıflık değil. Duygusal dürüstlüğün, çoğu insanın ulaşamadığı bir seviyede.
''',
      ZodiacSign.taurus: '''
Duygusal dünyan sakin bir göl gibi - derin, durgun, besleyici. Hislerini yavaş yavaş işlersin, ama bir kez hissettiğinde çok derindir.

Güvenlik ve istikrar, duygusal sağlığın için olmazsa olmaz. Fiziksel konfor seni sakinleştirir - güzel yemekler, yumuşak dokular, huzurlu mekanlar.

Değişime duygusal direnç gösterirsin ama bu senin sadakat kapasiten. Bir kez bağlandığında, kolay kolay bırakmazsın.
''',
      ZodiacSign.gemini: '''
Duygusal dünyan zihinsel dünyayla iç içe - hislerini anlayarak, konuşarak, yazarak işlersin.

İletişim, duygusal sağlığın için hayati. Hislerini paylaşabilecek biri olmadığında bunalırsın. Günlük tutmak senin için terapötik.

Duygusal çeşitlilik seni besler - tek tip bir duygusal yaşam seni sıkar. Ama bu dağınıklık değil, zenginlik.
''',
      ZodiacSign.cancer: '''
Duygusal dünyan bir okyanus - gelgitler, derinlikler, gizemler. Hislerin ay döngüleriyle dans eder, çevrendeki enerjileri sünger gibi emersin.

Yuva ve aile, duygusal merkezin. Nerede olursan ol, bir "yuva" hissi yaratmak zorundasın. Güvenli alan senin için hayati.

Geçmiş duygusal hafızanda çok canlı yaşar. Nostalji hem şifa hem de tuzak olabilir - dengeli hatırla.
''',
      ZodiacSign.leo: '''
Duygusal dünyan bir sahne - hislerini büyük, dramatik, görünür yaşarsın. Duygusal ifade senin doğal dilin.

Takdir ve sevgi, duygusal bedeninin gıdası. Görülmemek, sevilmemek seni derinden yaralar. Ama içsel onayı geliştirdiğinde özgürleşirsin.

Cömertlik duygusal doğan - sevdiklerini şımartmak, onlar için parlamak seni mutlu eder.
''',
      ZodiacSign.virgo: '''
Duygusal dünyan düzenli ve analitik - hislerini kategorize etmeye, anlamaya çalışırsın. "Neden böyle hissediyorum?" sorusu sürekli aklında.

Faydalı olmak, hizmet etmek duygusal tatmin kaynağın. Bir şeyleri düzeltmek, iyileştirmek seni rahatlatır.

Kendine çok eleştirel olabilirsin duygusal konularda. Mükemmel hissetmene gerek yok - olduğun gibi hissetmek yeterli.
''',
      ZodiacSign.libra: '''
Duygusal dünyan ilişkilerle şekilleniyor - yalnızken bile bir "diğeri"ni düşünürsün. Duygusal dengeyi ilişkilerde ararsın.

Uyum ve güzellik, duygusal sağlığın için gerekli. Çirkin ortamlar, çatışmalı ilişkiler seni derinden etkiler.

Kendi duygularını başkalarınınkinden ayırt etmek senin öğrenme alanın. "Bu benim mi yoksa onun hissi mi?" sorusunu sor.
''',
      ZodiacSign.scorpio: '''
Duygusal dünyan bir yeraltı nehri - yüzeyde sakin görünebilirsin ama derinlerde fırtınalar kopuyor. Hislerin yoğun, dönüştürücü, bazen yıkıcı.

Duygusal dürüstlük ve derinlik, ilişkilerde olmazsa olmazın. Yüzeysel bağlantılar seni tatmin etmez.

Kontrol ihtiyacın duygusal alanda güçlü - ama bırakma sanatını öğrendiğinde, en derin iyileşmeyi deneyimlersin.
''',
      ZodiacSign.sagittarius: '''
Duygusal dünyan özgürlük arıyor - kapalı, kısıtlayıcı duygusal ortamlardan kaçarsın. Hislerini geniş ufuklarla, maceralarla, anlamla beslersin.

İyimserlik doğal duygusal halin - zor zamanlarda bile umut bulabilirsin. Bu bir kaçış değil, ruhsal dayanaklılık.

Duygusal bağımsızlığın, yakınlık korkusuyla karıştırılabilir. Özgürlük ve yakınlığın birlikte var olabileceğini keşfetmek senin yolculuğun.
''',
      ZodiacSign.capricorn: '''
Duygusal dünyan kontrollü ve yapılandırılmış - hislerini yönetmeye, bastırmaya değil ama disiplinli ifade etmeye meyillisin.

Başarı ve tanınma, beklenmedik şekilde duygusal ihtiyaçların. Değer gördüğünde, güvende hissedersin.

Duygusal savunmasızlık senin büyüme alanın. Güçlü görünmek zorunda değilsin - zayıflığın da güç olduğunu öğren.
''',
      ZodiacSign.aquarius: '''
Duygusal dünyan benzersiz - standart duygusal kalıplara uymayabilirsin ve bu tamamen normal. Hislerini fikirlerle, ideallerle bütünleştirirsin.

Bireysellik duygusal bir ihtiyaç - sürüden farklı hissetmek seni besler. Ait olmak için kendinden vazgeçmeni beklememeli kimse.

Duygusal mesafe, aslında panoramik bakış açın. Yakın ilişkilerde de bu geniş perspektifi sevgiyle birleştirmeyi öğren.
''',
      ZodiacSign.pisces: '''
Duygusal dünyan sınırsız bir okyanus - başkalarının hislerini kendi hislerinden ayırt etmek zor olabilir. Empatik kapasitenin fiyatı bu.

Ruhsal ve duygusal dünya senin için bir - meditasyon, sanat, müzik duygusal şifa araçların. Günlük ruhsal pratikler şart.

Kaçış eğilimi duygusal yüklenmelerde ortaya çıkabilir. Sınır koymayı ve "hayır" demeyi öğrenmek senin büyüme alanın.
''',
    };

    return interpretations[sign] ?? '';
  }

  /// Get personalized rising sign interpretation
  static String getRisingInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Dünyaya bir savaşçı gibi giriyorsun - enerjik, doğrudan, cesur. İlk izlenimin "güçlü biri" olarak algılanması.

Fiziksel görünümünde ateşli bir enerji var - hareketli, dinamik, bazen sabırsız görünebilirsin.

Hayata yaklaşımın "önce eylem, sonra düşünce" - bu bazen sorun çıkarır ama çoğu zaman seni herkesten önde tutar.

Yükselen Koç olarak öğrenme alanın: dürtüselliği bilgelikle, cesareti sabırla dengelemek.
''',
      ZodiacSign.taurus: '''
Dünyaya sakin bir güç gibi giriyorsun - güvenilir, istikrarlı, ayakları yere basan. İlk izlenimin "sağlam biri" olarak algılanması.

Fiziksel görünümünde toprak enerjisi var - rahatlatıcı bir varlık, belki güçlü bir beden yapısı.

Hayata yaklaşımın metodolojik ve pratik - acele etmezsin, ama bir kez karar verdiğinde ilerlersin.

Yükselen Boğa olarak öğrenme alanın: esnekliği geliştirmek, değişimi tehdit değil fırsat olarak görmek.
''',
      ZodiacSign.gemini: '''
Dünyaya meraklı bir çocuk gibi giriyorsun - konuşkan, hareketli, çok yönlü. İlk izlenimin "zeki biri" olarak algılanması.

Fiziksel görünümünde hava enerjisi var - genç görünüm, hareketli el kol hareketleri, canlı mimikler.

Hayata yaklaşımın bilgi toplama ve paylaşma odaklı - her şeyi bilmek, herkesle konuşmak istersin.

Yükselen İkizler olarak öğrenme alanın: derinleşmek, yüzeysellikten kaçınmak, odaklanmayı öğrenmek.
''',
      ZodiacSign.cancer: '''
Dünyaya koruyucu bir anne/baba gibi giriyorsun - sıcak, besleyici, hassas. İlk izlenimin "güvenilir biri" olarak algılanması.

Fiziksel görünümünde su enerjisi var - yumuşak hatlar, duygulu gözler, değişken ifadeler.

Hayata yaklaşımın duygusal ve sezgisel - mantıktan önce hislerini dinlersin.

Yükselen Yengeç olarak öğrenme alanın: aşırı korumacılıktan kaçınmak, sınır koymayı öğrenmek.
''',
      ZodiacSign.leo: '''
Dünyaya bir kral/kraliçe gibi giriyorsun - karizmatik, dikkat çekici, kendinden emin. İlk izlenimin "özel biri" olarak algılanması.

Fiziksel görünümünde ateş enerjisi var - gösterişli saç, dik duruş, çekici bir aura.

Hayata yaklaşımın yaratıcı ve dramatik - sıradan olmayı reddedersin, her şeyde özellik ararsın.

Yükselen Aslan olarak öğrenme alanın: alçakgönüllülük, dikkat merkezinde olmadan da değerli olduğunu bilmek.
''',
      ZodiacSign.virgo: '''
Dünyaya bir analist gibi giriyorsun - düzenli, detaycı, pratik. İlk izlenimin "düzgün biri" olarak algılanması.

Fiziksel görünümünde toprak enerjisi var - temiz, bakımlı, sade elegans.

Hayata yaklaşımın problem çözme odaklı - her durumda iyileştirme alanları görürsün.

Yükselen Başak olarak öğrenme alanın: kendine de başkalarına da şefkatli olmak, mükemmeliyetçiliği bırakmak.
''',
      ZodiacSign.libra: '''
Dünyaya bir diplomat gibi giriyorsun - zarif, uyumlu, çekici. İlk izlenimin "hoş biri" olarak algılanması.

Fiziksel görünümünde hava enerjisi var - simetrik hatlar, estetik giyim, tatlı bir gülümseme.

Hayata yaklaşımın ilişki ve denge odaklı - yalnız başına kararlar almakta zorlanabilirsin.

Yükselen Terazi olarak öğrenme alanın: kendi fikirlerini savunmak, çatışmadan kaçmamak.
''',
      ZodiacSign.scorpio: '''
Dünyaya bir dedektif gibi giriyorsun - gizemli, yoğun, nüfuz edici. İlk izlenimin "güçlü biri" olarak algılanması.

Fiziksel görünümünde su enerjisi var - manyetik bakışlar, hipnotik bir varlık.

Hayata yaklaşımın derin ve transformasyonel - yüzeysellik seni tatmin etmez.

Yükselen Akrep olarak öğrenme alanın: güven geliştirmek, kontrol ihtiyacını bırakmak.
''',
      ZodiacSign.sagittarius: '''
Dünyaya bir gezgin gibi giriyorsun - neşeli, iyimser, özgür ruhlu. İlk izlenimin "eğlenceli biri" olarak algılanması.

Fiziksel görünümünde ateş enerjisi var - atletik yapı, geniş hareketler, sıcak bir gülümseme.

Hayata yaklaşımın keşif ve macera odaklı - rutin seni boğar.

Yükselen Yay olarak öğrenme alanın: sorumluluk almak, sözlerin sonuçlarını düşünmek.
''',
      ZodiacSign.capricorn: '''
Dünyaya bir CEO gibi giriyorsun - ciddi, hırslı, güvenilir. İlk izlenimin "olgun biri" olarak algılanması.

Fiziksel görünümünde toprak enerjisi var - kemikli yapı, ciddi ifade, zamanla daha genç görünüm.

Hayata yaklaşımın başarı ve yapı odaklı - hedeflerin olmadan hareket etmezsin.

Yükselen Oğlak olarak öğrenme alanın: eğlenmeyi öğrenmek, başarının mutluluk değil araç olduğunu anlamak.
''',
      ZodiacSign.aquarius: '''
Dünyaya bir dahi gibi giriyorsun - farklı, orijinal, insani. İlk izlenimin "ilginç biri" olarak algılanması.

Fiziksel görünümünde hava enerjisi var - sıra dışı stil, benzersiz özellikler.

Hayata yaklaşımın yenilikçi ve bağımsız - sürüyle gitmeyi reddedersin.

Yükselen Kova olarak öğrenme alanın: duygusal yakınlık, insanlık sevgisini bireysel sevgiye çevirmek.
''',
      ZodiacSign.pisces: '''
Dünyaya bir şair gibi giriyorsun - hayalperest, empatik, mistik. İlk izlenimin "hassas biri" olarak algılanması.

Fiziksel görünümünde su enerjisi var - yumuşak hatlar, rüya gibi bakışlar.

Hayata yaklaşımın sezgisel ve yaratıcı - mantıktan çok hislerin ve ilhamlar seni yönlendirir.

Yükselen Balık olarak öğrenme alanın: sınır koymak, rüyalar ile gerçekliği dengelemek.
''',
    };

    return interpretations[sign] ?? '';
  }

  /// Get esoteric interpretation for a house with planets
  static String getHouseInterpretation(
    House house,
    List<PlanetPosition> planets,
  ) {
    if (planets.isEmpty) {
      return 'Bu ev şu anda boş - ama bu "aktif değil" anlamına gelmez. Evin yönetici gezegeni ve yönetici gezegenin konumu bu alanı aktive eder.';
    }

    final planetNames = planets.map((p) => p.planet.nameTr).join(', ');

    final houseIntros = {
      1: 'Kimlik evinde $planetNames var - benlik ifaden bu gezegenlerle şekilleniyor.',
      2: 'Değerler evinde $planetNames var - neye değer verdiğin ve para ilişkin bu gezegenlerle belirleniyor.',
      3: 'İletişim evinde $planetNames var - düşünce ve ifade tarzın bu gezegenlerle renkleniyor.',
      4: 'Kök evinde $planetNames var - aile dinamiklerin ve iç dünyan bu gezegenlerle şekilleniyor.',
      5: 'Yaratıcılık evinde $planetNames var - kendin olma, romantizm ve yaratıcı ifaden bu gezegenlerle parlıyor.',
      6: 'Hizmet evinde $planetNames var - günlük rutinlerin, sağlığın ve iş anlayışın bu gezegenlerle belirleniyor.',
      7: 'İlişkiler evinde $planetNames var - partner seçimin ve ilişki dinamiklerin bu gezegenlerle şekilleniyor.',
      8: 'Dönüşüm evinde $planetNames var - derin bağlar, paylaşılan kaynaklar ve ruhsal dönüşümün bu gezegenlerle aktive oluyor.',
      9: 'Anlam evinde $planetNames var - felsefen, inançların ve yüksek öğrenim yolculuğun bu gezegenlerle şekilleniyor.',
      10: 'Kariyer evinde $planetNames var - toplumsal rolün ve profesyonel yolculuğun bu gezegenlerle belirleniyor.',
      11: 'Topluluk evinde $planetNames var - arkadaşlıkların, ideallerin ve geleceğe dair umutların bu gezegenlerle renkleniyor.',
      12: 'Bilinçaltı evinde $planetNames var - ruhsal derinliklerin, gizli güçlerin ve karma yolculuğun bu gezegenlerle şekilleniyor.',
    };

    return houseIntros[house.number] ?? '';
  }

  /// Get aspect interpretation
  static String getAspectInterpretation(
    String aspectType,
    String planet1,
    String planet2,
  ) {
    final aspectMeanings = {
      'conjunction':
          '$planet1 ve $planet2 birleşimi - bu iki enerji senin içinde kaynaşmış durumda. Birini kullandığında diğeri de aktive oluyor.',
      'opposition':
          '$planet1 ve $planet2 karşıtlığı - bu iki enerji arasında sürekli bir gerilim var. Denge noktası bulmak senin öğrenme alanın.',
      'trine':
          '$planet1 ve $planet2 üçgeni - bu iki enerji doğal uyum içinde. Kolayca birlikte çalışıyorlar, doğuştan gelen yeteneklerini temsil ediyorlar.',
      'square':
          '$planet1 ve $planet2 karesi - bu iki enerji arasında sürtüşme var. Bu gerilim seni büyümeye zorluyor.',
      'sextile':
          '$planet1 ve $planet2 altıgeni - bu iki enerji birbirini destekliyor. Fırsatları değerlendirdiğinde güzel sonuçlar alırsın.',
    };

    return aspectMeanings[aspectType] ?? '';
  }

  /// Get Mercury sign interpretation - Mind & Communication
  static String getMercuryInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Zihnin bir ok gibi hızlı ve doğrudan. Düşüncelerini anında ifade edersin, diplomasi yerine dürüstlük tercih edersin. Fikirlerini savunmaktan çekinmezsin.

İletişim tarzın canlı ve enerjik - bazen sözlerin hedefinden önce çıkabilir. Sabırlı dinlemeyi öğrenmek senin büyüme alanın.

Öğrenme stilin deneyimsel - yaparak, hareket ederek öğrenirsin. Sıkıcı dersler seni bunaltır.
''',
      ZodiacSign.taurus: '''
Zihnin metodolojik ve pratik. Düşüncelerini acele etmeden, sindire sindire ifade edersin. Sözlerin ağırlık taşır çünkü öylesine konuşmazsın.

İletişim tarzın sakin ve güvenilir. Bir kez söz verdiğinde tutarsın. Sesinin tonunda rahatlatıcı bir kalite var.

Öğrenme stilin somut ve duyusal - görerek, dokunarak, deneyimleyerek anlarsın. Soyut kavramları somutlaştırman gerekir.
''',
      ZodiacSign.gemini: '''
Zihnin kendi evinde! Hızlı, çok yönlü, sınırsız meraklı. Aynı anda birden fazla konuyu takip edebilirsin. Bilgi senin oyun alanın.

İletişim tarzın canlı, esprili, adaptif. Her ortama uyum sağlar, her konuda söyleyecek bir şeyin olur. Kelime hazinen geniş.

Öğrenme stilin zihinsel ve çeşitli - okuyarak, konuşarak, soru sorarak öğrenirsin. Rutine bağlı kalmak zor.
''',
      ZodiacSign.cancer: '''
Zihnin duygusal belleğe bağlı. Düşüncelerini hislerle birlikte işlersin. Geçmişi hatırlamada olağanüstüsün.

İletişim tarzın sıcak ve besleyici. Empati yüklü konuşursun, karşındakinin duygularını hissedersin.

Öğrenme stilin duygusal ve ilişkisel - bir şeyi seversen öğrenirsin. Öğretmenle bağ kurmak önemli.
''',
      ZodiacSign.leo: '''
Zihnin yaratıcı ve dramatik. Düşüncelerini büyük, renkli, etkileyici şekilde ifade edersin. Hikaye anlatmada ustasın.

İletişim tarzın karizmatik ve kendinden emin. Sözlerin sahne alır, dinleyicileri cezbeder.

Öğrenme stilin performans odaklı - öğrendiklerini sergileme fırsatı olunca motive olursun.
''',
      ZodiacSign.virgo: '''
Zihnin analitik ve detaycı. Düşüncelerini düzenli, mantıklı, pratik şekilde ifade edersin. Eleştirel düşünme konusunda güçlüsün.

İletişim tarzın net ve faydalı. Gereksiz laf salatası yapmaz, öz konuşursun. Düzeltmeler yapma eğilimin var.

Öğrenme stilin sistematik - listeler, notlar, kategoriler sana yardımcı olur. Dağınık bilgi seni bunaltır.
''',
      ZodiacSign.libra: '''
Zihnin dengeli ve diplomatik. Düşüncelerini zarif, uyumlu, iki tarafı da gören şekilde ifade edersin.

İletişim tarzın hoş ve uzlaştırıcı. Çatışmayı yumuşatır, orta yolu bulursun. Bazen kendi fikrini söylemekte zorlanabilirsin.

Öğrenme stilin işbirlikçi - başkalarıyla tartışarak, karşılaştırarak öğrenirsin. Diyalog seni besler.
''',
      ZodiacSign.scorpio: '''
Zihnin derin ve araştırmacı. Düşüncelerini yoğun, stratejik, bazen gizli tutarsın. Yüzeyin altını görürsün.

İletişim tarzın güçlü ve nüfuz edici. Az konuşursun ama her kelimen etki bırakır. Psikolog gibi dinlersin.

Öğrenme stilin derinlemesine - bir konuyu tam anlayana kadar bırakmazsın. Yüzeysel bilgi seni tatmin etmez.
''',
      ZodiacSign.sagittarius: '''
Zihnin geniş ve felsefi. Düşüncelerini büyük resimle, anlamla, vizyonla ifade edersin. Detaylardan çok kavramlar seni çeker.

İletişim tarzın neşeli ve ilham verici. Hikayeler, fıkralar, büyük fikirler paylaşmayı seversin.

Öğrenme stilin keşif odaklı - yeni fikirler, farklı kültürler, geniş perspektifler seni heyecanlandırır.
''',
      ZodiacSign.capricorn: '''
Zihnin stratejik ve yapılandırılmış. Düşüncelerini ciddi, sorumlu, hedef odaklı ifade edersin. Boş laf etmezsin.

İletişim tarzın otoriter ve güvenilir. Sözlerin ağırlık taşır, ciddi konularda görüşün alınır.

Öğrenme stilin pratik ve hedefe yönelik - "bunu neden öğreniyorum" sorusuna cevap alman gerekir.
''',
      ZodiacSign.aquarius: '''
Zihnin orijinal ve yenilikçi. Düşüncelerini benzersiz, sıra dışı, geleceğe yönelik ifade edersin.

İletişim tarzın entelektüel ve bağımsız. Mainstream düşüncelerle yetinmezsin, farklı açılar ararsın.

Öğrenme stilin deneysel - yeni metotlar, teknoloji, alternatif yaklaşımlar seni çeker.
''',
      ZodiacSign.pisces: '''
Zihnin sezgisel ve imgelem dolu. Düşüncelerini sanatsal, sembolik, rüya gibi ifade edersin.

İletişim tarzın empatik ve ilham dolu. Kelimelerle resim çizer, duygu aktarırsın. Şiirsel bir kaliten var.

Öğrenme stilin sezgisel ve yaratıcı - müzikle, görsellerle, hikayelerle öğrenirsin.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Venus sign interpretation - Love & Values
  static String getVenusInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Aşkta bir savaşçısın - tutkulu, doğrudan, fetihçi. İlk adımı atmaktan çekinmezsin, kovalamacayı seversin.

İlişkilerde bağımsızlığına düşkünsün. Sıkıcı rutinler seni bunaltır, spontanlık ve heyecan istersin.

Çekim tarzın yoğun ve anlık - ilk görüşte aşk senin için gerçek. Ama bu ateş hızlı sönebilir de.

Estetik anlayışın cesur - kırmızı, siyah, güçlü çizgiler. Dikkat çekici stiller sana yakışır.
''',
      ZodiacSign.taurus: '''
Aşkta bir hedonistsin - duyusal, sadık, sahiplenici. Beş duyunla seversin, fiziksel yakınlık çok önemli.

İlişkilerde güvenlik ve istikrar ararsın. Yavaş ısınırsın ama bir kez bağlanınca bırakmazsın.

Çekim tarzın doğal ve topraklanmış - doğal güzellik, kalıcı değerler, gerçek zenginlik seni çeker.

Estetik anlayışın lüks ama sade - kaliteli malzemeler, toprak tonları, zamansız klasikler.
''',
      ZodiacSign.gemini: '''
Aşkta bir kelebeksin - hafif, oyuncu, çok yönlü. Zihinsel uyum fiziksel çekimden önce gelir.

İlişkilerde sohbet ve arkadaşlık istersin. En iyi aşıkların aynı zamanda en iyi dostların.

Çekim tarzın entelektüel - zeka, espri, ilginç fikirler seni baştan çıkarır.

Estetik anlayışın değişken ve modern - trendleri takip eder, stil deneyimlersin.
''',
      ZodiacSign.cancer: '''
Aşkta bir annesin/babasın - besleyici, koruyucu, duygusal. Sevgini yemekle, ilgiyle, yuva kurmakla gösterirsin.

İlişkilerde güvenlik ve duygusal bağ ararsın. Ailenle tanıştırmak ciddi bir adım.

Çekim tarzın nostaljik - geçmişe bağlar, hatıralar, duygusal hikayeler seni derinden etkiler.

Estetik anlayışın yumuşak ve rahat - ev yapımı, vintage, sıcak atmosferler.
''',
      ZodiacSign.leo: '''
Aşkta bir kral/kraliçesin - cömert, dramatik, sadık. Sevgini büyük jestlerle, hediyelerle, övgülerle gösterirsin.

İlişkilerde hayranlık ve özel hissetmek istersin. Partner seninle gurur duymalı, sen de onunla.

Çekim tarzın gösterişli - karizmatik insanlar, özel ilgi, VIP muamelesi seni baştan çıkarır.

Estetik anlayışın lüks ve dikkat çekici - altın, parlak renkler, marka değeri.
''',
      ZodiacSign.virgo: '''
Aşkta bir şifacısın - özenli, hizmetkar, düzeltici. Sevgini küçük jestlerle, yardımla, iyileştirmelerle gösterirsin.

İlişkilerde pratik uyum ve güvenilirlik ararsın. Sözde değil özde sevgi.

Çekim tarzın sade ve özgün - kibarlık, zeka, temizlik, sağlıklı yaşam seni çeker.

Estetik anlayışın minimalist ve fonksiyonel - kaliteli malzeme, mükemmel kesim, sade elegans.
''',
      ZodiacSign.libra: '''
Aşkta bir sanatçısın - romantik, uyumlu, estetik. İlişkinin kendisi senin sanat eserin.

İlişkilerde denge ve güzellik ararsın. Çirkin çatışmalar, kaba davranışlar seni iter.

Çekim tarzın zarif - güzel insanlar, uyumlu ortamlar, kültürlü sohbetler seni çeker.

Estetik anlayışın sofistike ve dengeli - pastel tonlar, simetri, klasik güzellik.
''',
      ZodiacSign.scorpio: '''
Aşkta bir simyacısın - yoğun, dönüştürücü, bütünleştirici. Yarım ilişkiler seni ilgilendirmez, ya hep ya hiç.

İlişkilerde derin bağ ve sadakat ararsın. Yüzeysel flörtler değil, ruhsal birleşme.

Çekim tarzın manyetik - gizem, derinlik, yasaklar seni cezbeder. Yasak aşklar çekici gelebilir.

Estetik anlayışın koyu ve yoğun - siyah, bordo, deri, gizemli stiller.
''',
      ZodiacSign.sagittarius: '''
Aşkta bir maceracısın - özgür, neşeli, keşifçi. Birlikte büyümek, öğrenmek, gezmek senin aşk dilin.

İlişkilerde özgürlük ve dostluk ararsın. Kıskançlık ve bağımlılık seni kaçırır.

Çekim tarzın entelektüel ve kültürel - farklı kültürlerden insanlar, gezginler, filozoflar.

Estetik anlayışın rahat ve etnik - doğal kumaşlar, egzotik aksesuarlar, bohemian stiller.
''',
      ZodiacSign.capricorn: '''
Aşkta bir mimarısın - ciddi, planlı, uzun vadeli. İlişkiyi bir proje gibi inşa edersin.

İlişkilerde güvenilirlik ve statü ararsın. Partnerinin başarılı olması önemli.

Çekim tarzın geleneksel - olgunluk, başarı, istikrar seni çeker. Yaşça farklı ilişkiler olabilir.

Estetik anlayışın klasik ve kaliteli - zamansız parçalar, koyu renkler, statü sembolleri.
''',
      ZodiacSign.aquarius: '''
Aşkta bir devrimcisin - özgün, arkadaşça, sıra dışı. Normal ilişki kalıpları sana uymayabilir.

İlişkilerde entelektüel bağ ve özgürlük ararsın. En iyi dostun aynı zamanda aşkın olmalı.

Çekim tarzın benzersiz - farklı insanlar, sıra dışı fikirler, isyankar ruhlar.

Estetik anlayışın fütüristik ve eklektik - beklenmedik kombinasyonlar, teknolojik aksesuarlar.
''',
      ZodiacSign.pisces: '''
Aşkta bir rüyacısın - romantik, fedakar, sınırsız. Koşulsuz sevgi senin idealin.

İlişkilerde ruhsal bağ ve anlayış ararsın. Sözlere gerek kalmadan anlaşmak.

Çekim tarzın mistik - sanatçılar, kayıp ruhlar, şifa gerektiren insanlar seni çeker.

Estetik anlayışın rüya gibi - pastel, şeffaf, romantik, fairy-tale stiller.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Mars sign interpretation - Action & Desire
  static String getMarsInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
İraden bir ateş topu - hızlı, direkt, cesaretli. Engellerle karşılaştığında önce vurur sonra düşünürsün.

Motivasyonun rekabet ve zafer. İlk olmak, kazanmak seni harekete geçirir. Zorluklar seni körükler.

Öfken patlayıcı ama çabuk geçer. Kin tutmazsın, patlar ve unutursun.

Cinsel enerjin yoğun ve fetihçi. Kovalamaca heyecanı, spontanlık seni cezbeder.
''',
      ZodiacSign.taurus: '''
İraden bir bulldozer - yavaş ama durdurulamaz. Başladığın işi bitirirsin, acele etmezsin.

Motivasyonun güvenlik ve somut sonuçlar. Maddi kazanç, konfor seni harekete geçirir.

Öfken yavaş birikir ama patladığında felaket olur. Provoke etmemek gerekir.

Cinsel enerjin duyusal ve dayanıklı. Acele etmezsin, beş duyuyla deneyimlersin.
''',
      ZodiacSign.gemini: '''
İraden bir rüzgar - çok yönlü, adaptif, stratejik. Bir yol kapanırsa on yol bulursun.

Motivasyonun merak ve çeşitlilik. Yeni projeler, fikirler, meydan okumalar seni harekete geçirir.

Öfken sözeldir - keskin dil, eleştiri, ironi silahların. Fiziksel çatışmadan kaçınırsın.

Cinsel enerjin oyuncu ve zihinsel. Flört, sohbet, fantezi oyunun parçası.
''',
      ZodiacSign.cancer: '''
İraden bir anne ayı - koruyucu, duygusal, dolaylı. Sevdiklerin tehdit altındaysa vahşileşirsin.

Motivasyonun güvenlik ve aile. Yuvanı korumak için dağları devirirsin.

Öfken pasif-agresif olabilir - sessiz tedavi, küsme, duygusal manipülasyon.

Cinsel enerjin duygusal bağa bağlı. Güvende hissetmeden açılamazsın.
''',
      ZodiacSign.leo: '''
İraden bir aslan kükreyişi - güçlü, dramatik, liderlik odaklı. Sahne senin, yönetmen sensin.

Motivasyonun tanınma ve hayranlık. Alkış, övgü, başarı seni harekete geçirir.

Öfken gösterişli - sahne yaparsın, herkes duyar. Ama cömertçe affedersin de.

Cinsel enerjin performatif ve tutkulu. Övülmek, hayranlık görmek seni ateşler.
''',
      ZodiacSign.virgo: '''
İraden bir cerrah - hassas, metodolojik, mükemmeliyetçi. Her detayı planlarsın.

Motivasyonun fayda ve iyileştirme. Bir şeyi daha iyi yapmak seni harekete geçirir.

Öfken eleştirel - eksikleri sıralar, hata bulur, inceden inceden keser.

Cinsel enerjin tekniksel ve hizmetkar. Partner memnuniyeti senin için önemli.
''',
      ZodiacSign.libra: '''
İraden bir diplomat - dengeli, stratejik, işbirlikçi. Çatışmadan kaçınır, ittifak kurarsın.

Motivasyonun uyum ve adalet. Haksızlık görünce harekete geçersin.

Öfken bastırılmış olabilir - çatışmadan kaçınma pasif agresifliğe dönüşebilir.

Cinsel enerjin romantik ve estetik. Ortam, atmosfer, güzellik önemli.
''',
      ZodiacSign.scorpio: '''
İraden bir derin su bombası - stratejik, yoğun, dönüştürücü. Hedefine ulaşana kadar bırakmazsın.

Motivasyonun güç ve kontrol. Zayıf görünmemek, kontrol kaybetmemek seni harekete geçirir.

Öfken buzdağı - yüzeyde sakin, derinde kasırga. İntikam soğuk servis edilir.

Cinsel enerjin yoğun ve transformasyonel. Seks senin için güç ve birleşme.
''',
      ZodiacSign.sagittarius: '''
İraden bir ok - doğrudan, hedefe odaklı, özgür. Engellerden kaçar veya üstünden atlar.

Motivasyonun özgürlük ve anlam. Sınırlar, rutinler, kısıtlamalar seni bunaltır.

Öfken felsefik - tartışırsın, vaaz verirsin, "haklı" olman önemli.

Cinsel enerjin maceracı ve eğlenceli. Yeni deneyimler, farklı yerler, spontanlık.
''',
      ZodiacSign.capricorn: '''
İraden bir dağ keçisi - sabırlı, azimli, stratejik. Zirveye yavaş ama emin adımlarla tırmanırsın.

Motivasyonun başarı ve kontrol. Hedefler, planlar, sonuçlar seni harekete geçirir.

Öfken soğuk ve hesaplı. Patlama yerine stratejik geri çekilme.

Cinsel enerjin kontrollü ve dayanıklı. İlişkide de başarı ve ustalık istersin.
''',
      ZodiacSign.aquarius: '''
İraden bir elektrik şoku - beklenmedik, orijinal, isyankar. Standart yollardan gitmezsin.

Motivasyonun değişim ve yenilik. Statükoya meydan okumak seni harekete geçirir.

Öfken soğuk ve entelektüel - duygusal değil ideolojik savaşırsın.

Cinsel enerjin deneysel ve arkadaşça. Geleneksel roller seni sıkabilir.
''',
      ZodiacSign.pisces: '''
İraden bir dalga - akışkan, dolaylı, sezgisel. Engellerin etrafından dolanırsın.

Motivasyonun ilham ve anlam. Sıradan görevler seni motive etmez, büyük amaçlar gerekir.

Öfken kaçışa dönüşebilir - çatışma yerine geri çekilme, hayal kurma, kaçınma.

Cinsel enerjin romantik ve fantezi dolu. Duygusal ve ruhsal bağ şart.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get detailed planet in house interpretation
  static String getPlanetInHouseInterpretation(Planet planet, int houseNumber) {
    final key = '${planet.name}_$houseNumber';
    final interpretations = {
      // Sun in Houses
      'sun_1':
          'Güneşin 1. evde - Kimliğin ve benlik ifaden çok güçlü. Liderlik doğanda var, parlıyorsun.',
      'sun_2':
          'Güneşin 2. evde - Öz değerin ve para kazanma potansiyelin yüksek. Maddi güvenlik kimliğinle bağlı.',
      'sun_3':
          'Güneşin 3. evde - İletişimci doğan güçlü. Yazar, konuşmacı, öğretmen potansiyelin var.',
      'sun_4':
          'Güneşin 4. evde - Aile ve yuva senin sarayın. Köklerin güçlü, ev sana enerji veriyor.',
      'sun_5':
          'Güneşin 5. evde - Yaratıcılığın ve kendin olma kapasiten parlıyor. Sahnede parlarsın.',
      'sun_6':
          'Güneşin 6. evde - Hizmet ve iş kimliğinle bağlı. Faydalı olmak seni var ediyor.',
      'sun_7':
          'Güneşin 7. evde - İlişkiler kimliğinin aynası. Partner seçimlerinde kendini buluyorsun.',
      'sun_8':
          'Güneşin 8. evde - Dönüşüm ve derinlik senin doğan. Krizlerden güçlenerek çıkarsın.',
      'sun_9':
          'Güneşin 9. evde - Anlam arayışı ve felsefe kimliğinle bağlı. Öğretmen, gezgin ruhu.',
      'sun_10':
          'Güneşin 10. evde - Kariyer ve toplumsal başarı çok önemli. Tanınmak istiyorsun.',
      'sun_11':
          'Güneşin 11. evde - Topluluk ve idealler seni tanımlıyor. İnsanlık için bir şeyler yapmalısın.',
      'sun_12':
          'Güneşin 12. evde - Ruhsal derinlik ve gizem seni tanımlıyor. Görünmez şifacı potansiyeli.',

      // Moon in Houses
      'moon_1':
          'Ayın 1. evde - Duygularını yüzünden okurlar. Hassas, sezgisel, değişken bir dış imajın var.',
      'moon_2':
          'Ayın 2. evde - Duygusal güvenliğin paraya bağlı. Maddi konular ruh halini etkiler.',
      'moon_3':
          'Ayın 3. evde - Duygularını konuşarak işlersin. Yazı sana iyi geliyor.',
      'moon_4':
          'Ayın 4. evde - Ay kendi evinde! Aile ve yuva duygusal merkezin. Köklerin çok güçlü.',
      'moon_5':
          'Ayın 5. evde - Yaratıcılık duygusal ifaden. Çocuklarla özel bir bağın var.',
      'moon_6':
          'Ayın 6. evde - Duygusal sağlığın fiziksel sağlığını etkiler. Rutin seni rahatlatıyor.',
      'moon_7':
          'Ayın 7. evde - Duygusal ihtiyaçlarını ilişkilerde ararsın. Partner anne/baba figürü olabilir.',
      'moon_8':
          'Ayın 8. evde - Derin, yoğun, dönüştürücü duygular. Gizli dünyaları hissedersin.',
      'moon_9':
          'Ayın 9. evde - Duygusal olarak anlam ve keşfe ihtiyaç duyarsın. Yolculuklar şifa.',
      'moon_10':
          'Ayın 10. evde - Kamusal imajın duygusal. Herkes annen/baban gibi hissedebilir.',
      'moon_11':
          'Ayın 11. evde - Arkadaşlar ailen gibi. Topluluk içinde duygusal doyum bulursun.',
      'moon_12':
          'Ayın 12. evde - Derin empati ve psişik yetenekler. Yalnızlıkta şarj olursun.',

      // Mercury in Houses
      'mercury_1':
          'Merkür 1. evde - Zihinsel ve konuşkan bir dış imajın var. İlk izlenim "zeki".',
      'mercury_2':
          'Merkür 2. evde - Para zihinsel yeteneklerinden gelir. Yazı, ticaret, iletişim kazanç kaynağı.',
      'mercury_3':
          'Merkür 3. evde - Kendi evinde! İletişim yeteneğin olağanüstü. Yazar, gazeteci potansiyeli.',
      'mercury_4':
          'Merkür 4. evde - Evde çok konuşulur. Aile iletişimi önemli. Evden çalışma uygun.',
      'mercury_5':
          'Merkür 5. evde - Yaratıcı yazarlık, dramatik ifade yeteneğin var. Çocuklarla iyi iletişim.',
      'mercury_6':
          'Merkür 6. evde - Analitik iş becerileri güçlü. Detaylı çalışma sana göre.',
      'mercury_7':
          'Merkür 7. evde - İlişkilerde iletişim çok önemli. Entelektüel partner ararsın.',
      'mercury_8':
          'Merkür 8. evde - Derin araştırmacı. Gizemleri çözme yeteneğin var. Psikoloji ilgin.',
      'mercury_9':
          'Merkür 9. evde - Felsefi zihin, yabancı dil yeteneği, akademik potansiyel.',
      'mercury_10':
          'Merkür 10. evde - Kariyer iletişimle bağlı. Konuşmacı, yazar, medya yolu.',
      'mercury_11':
          'Merkür 11. evde - Sosyal ağlarda güçlüsün. Gruplarla iletişim kolay.',
      'mercury_12':
          'Merkür 12. evde - Sezgisel düşünce, meditasyonda cevaplar, gizli yazarlık yeteneği.',

      // Venus in Houses
      'venus_1':
          'Venüs 1. evde - Çekici ve sevimli bir görünümün var. İnsanlar sana doğal olarak çekiliyor.',
      'venus_2':
          'Venüs 2. evde - Kendi evinde! Para ve güzel şeylerle doğal bir ilişkin var. Çekim yasası güçlü.',
      'venus_3':
          'Venüs 3. evde - Hoş konuşursun, diplomatiğsin. Kardeşlerle güzel ilişkiler.',
      'venus_4':
          'Venüs 4. evde - Güzel bir ev çok önemli. Aile içinde barış ve uyum yaratırsın.',
      'venus_5':
          'Venüs 5. evde - Romantik ve yaratıcı. Aşk hayatın renkli, sanat yeteneğin var.',
      'venus_6':
          'Venüs 6. evde - İş yerinde sevilen biri. Güzellik/sağlık sektörlerine yatkınlık.',
      'venus_7':
          'Venüs 7. evde - Kendi evinde! İlişkilerde şanslısın. Çekici partnerler çekersin.',
      'venus_8':
          'Venüs 8. evde - Yoğun, dönüştürücü aşklar. Ortak finans konularında şans.',
      'venus_9':
          'Venüs 9. evde - Yabancı kültürler ve uzak yerlerle aşk. Yurtdışı romantizm.',
      'venus_10':
          'Venüs 10. evde - Kariyerde güzellik ve uyum. Sanatta veya diplomatik alanda başarı.',
      'venus_11':
          'Venüs 11. evde - Arkadaşlıktan aşka geçişler. Sosyal çevrede popülersin.',
      'venus_12':
          'Venüs 12. evde - Gizli aşklar, fedakarlık, ruhsal aşk. Sanat şifa aracın.',

      // Mars in Houses
      'mars_1':
          'Mars 1. evde - Güçlü fiziksel enerji, cesur görünüm, atletik yapı. Savaşçı ruhu.',
      'mars_2':
          'Mars 2. evde - Para için savaşırsın. Kazanma azmin yüksek, harcama da öyle.',
      'mars_3':
          'Mars 3. evde - Keskin dil, tartışmacı. Yazıda ve konuşmada güç.',
      'mars_4':
          'Mars 4. evde - Evde çatışmalar olabilir. Aile için savaşırsın, ev işlerine enerji.',
      'mars_5':
          'Mars 5. evde - Tutkulu romantizm, rekabetçi sporlar, cesur yaratıcılık.',
      'mars_6':
          'Mars 6. evde - İşkolik eğilim. Çalışmada çok verimli. Fiziksel aktivite şart.',
      'mars_7':
          'Mars 7. evde - İlişkilerde çatışma ve tutku bir arada. Güçlü partnerler çekersin.',
      'mars_8':
          'Mars 8. evde - Yoğun cinsel enerji. Krizlerde güçlenirsin. Dönüşüm cesareti.',
      'mars_9':
          'Mars 9. evde - İnançların için savaşırsın. Maceracı gezgin, felsefi tartışmacı.',
      'mars_10':
          'Mars 10. evde - Kariyer hırsın yüksek. Liderlik pozisyonlarına yatkınlık.',
      'mars_11':
          'Mars 11. evde - Gruplar için savaşırsın. Aktivist potansiyeli, sosyal hareketlilik.',
      'mars_12':
          'Mars 12. evde - Gizli öfke, bastırılmış enerji. Spiritüel savaşçı, şifacı güç.',

      // Jupiter in Houses
      'jupiter_1':
          'Jüpiter 1. evde - Şanslı ve iyimser bir görünümün var. İnsanlar sana doğal olarak güveniyor, fırsatlar kapına geliyor.',
      'jupiter_2':
          'Jüpiter 2. evde - Maddi bolluk potansiyelin yüksek. Para konusunda şanslısın, değer yarattığında kazanırsın.',
      'jupiter_3':
          'Jüpiter 3. evde - İletişim ve öğrenme alanında genişleme. Yazar, öğretmen, çok dil bilen potansiyeli.',
      'jupiter_4':
          'Jüpiter 4. evde - Aile ve ev konusunda şans. Geniş bir ev, bereketli bir aile yaşamı. Gayrimenkul şansı.',
      'jupiter_5':
          'Jüpiter 5. evde - Yaratıcılık ve romantizmde şans. Çocuklarla güzel ilişki, sanat ve eğlencede başarı.',
      'jupiter_6':
          'Jüpiter 6. evde - İş ve sağlık konusunda koruma. İş bulma şansın yüksek, şifa yeteneklerin olabilir.',
      'jupiter_7':
          'Jüpiter 7. evde - İlişkilerde ve ortaklıklarda şans. Zenginleştiren partnerler çekersin.',
      'jupiter_8':
          'Jüpiter 8. evde - Miras, ortak finans ve dönüşümde şans. Krizlerden güçlenerek çıkarsın.',
      'jupiter_9':
          'Jüpiter 9. evde - Kendi evinde! Yurtdışı, eğitim ve felsefede büyük şans. Öğretmen, gezgin ruhu.',
      'jupiter_10':
          'Jüpiter 10. evde - Kariyer ve toplumsal başarıda şans. Tanınma, yükselme potansiyeli yüksek.',
      'jupiter_11':
          'Jüpiter 11. evde - Arkadaşlık ve gruplardan şans. Hayırsever, topluluk lideri potansiyeli.',
      'jupiter_12':
          'Jüpiter 12. evde - Gizli koruma, spiritüel şans. Meditasyon ve içsel çalışmalardan büyüme.',

      // Saturn in Houses
      'saturn_1':
          'Satürn 1. evde - Olgun ve ciddi bir görünüm. Erken yaşta sorumluluk, ama zamanla güvenilir otorite olursun.',
      'saturn_2':
          'Satürn 2. evde - Para konusunda dersler. Erken zorluklar ama disiplinle kalıcı zenginlik yaratırsın.',
      'saturn_3':
          'Satürn 3. evde - İletişimde zorluklar veya gecikmeler. Ama zamanla bilge öğretmen, usta yazar olursun.',
      'saturn_4':
          'Satürn 4. evde - Aile konusunda karmik dersler. Kısıtlayıcı ev ortamı ama kendi sağlam temellerini kurarsın.',
      'saturn_5':
          'Satürn 5. evde - Yaratıcılık ve romantizmde engeller. Ama disiplinle ustalaşırsın, geç gelen aşk kalıcıdır.',
      'saturn_6':
          'Satürn 6. evde - İş ve sağlıkta sorumluluk. Kronik sağlık konuları olabilir ama disiplinle yönetirsin.',
      'saturn_7':
          'Satürn 7. evde - İlişkilerde gecikmeler veya karmik partnerler. Ama olgun, kalıcı ilişkiler kurarsın.',
      'saturn_8':
          'Satürn 8. evde - Dönüşüm ve ortak finans konusunda dersler. Derin korkularla yüzleşme, güç ustası olma.',
      'saturn_9':
          'Satürn 9. evde - İnanç ve eğitimde kısıtlamalar. Ama pratik bilgelik geliştirirsin, gerçek öğretmen olursun.',
      'saturn_10':
          'Satürn 10. evde - Kendi evinde! Kariyer yükselişi yavaş ama kalıcı. Otorite figürü, lider potansiyeli.',
      'saturn_11':
          'Satürn 11. evde - Arkadaşlıkta zorluklar, az ama kaliteli dostlar. Topluluk sorumluluğu alırsın.',
      'saturn_12':
          'Satürn 12. evde - Gizli korkular, bilinçaltı sınırlamalar. Ama spiritüel disiplinle derin bilgelik.',

      // Uranus in Houses
      'uranus_1':
          'Uranüs 1. evde - Benzersiz, sıra dışı bir görünüm. Orijinal, isyankar, trende karşı. Elektriksel bir varlık.',
      'uranus_2':
          'Uranüs 2. evde - Finanslarda beklenmedik iniş çıkışlar. Sıra dışı para kazanma yolları, teknoloji/yenilik sektörleri.',
      'uranus_3':
          'Uranüs 3. evde - Orijinal düşünce tarzı, sıra dışı iletişim. Parlak fikirler, mucit zihni.',
      'uranus_4':
          'Uranüs 4. evde - Aile yapısında sıra dışılık, taşınmalar, köksüzlük hissi. Alternatif ev kavramı.',
      'uranus_5':
          'Uranüs 5. evde - Yaratıcılıkta orijinallik, sıra dışı romantizm. Beklenmedik aşklar, farklı sanat.',
      'uranus_6':
          'Uranüs 6. evde - İşte özgürlük ihtiyacı, rutin düşmanı. Serbest çalışma, teknoloji sektörü uygun.',
      'uranus_7':
          'Uranüs 7. evde - İlişkilerde özgürlük ihtiyacı, sıra dışı partnerler. Geleneksel olmayan birliktelikler.',
      'uranus_8':
          'Uranüs 8. evde - Ani dönüşümler, beklenmedik krizler. Sıra dışı seksüalite, okült ilgisi.',
      'uranus_9':
          'Uranüs 9. evde - Radikal felsefe, alternatif eğitim, ani yurtdışı deneyimleri. Bağımsız düşünür.',
      'uranus_10':
          'Uranüs 10. evde - Kariyer değişiklikleri, sıra dışı meslekler. Teknoloji/yenilik alanında öncü.',
      'uranus_11':
          'Uranüs 11. evde - Kendi evinde! Sıra dışı arkadaşlıklar, radikal gruplar. Sosyal değişim öncüsü.',
      'uranus_12':
          'Uranüs 12. evde - Ani spiritüel uyanışlar, bilinçaltında devrimler. Mistik deneyimler.',

      // Neptune in Houses
      'neptune_1':
          'Neptün 1. evde - Mistik, hayalperest görünüm. Karizmatik ama anlaşılması zor. Sanatçı, şifacı aurası.',
      'neptune_2':
          'Neptün 2. evde - Para konusunda bulanıklık. Ya spiritüel zenginlik ya finansal karmaşa. Sanat/müzik geliri.',
      'neptune_3':
          'Neptün 3. evde - Sezgisel düşünce, şiirsel iletişim. Hayal gücü güçlü ama bazen net ifade zor.',
      'neptune_4':
          'Neptün 4. evde - Aile geçmişinde gizem veya kayıp. Ev spiritüel sığınak. Atalarla mistik bağ.',
      'neptune_5':
          'Neptün 5. evde - Romantizmde idealizm, hayal kırıklığı riski. Sanatsal yaratıcılık çok güçlü.',
      'neptune_6':
          'Neptün 6. evde - İş ve sağlıkta belirsizlik. Şifa meslekleri, hayır işleri uygun. Psikosomatik eğilim.',
      'neptune_7':
          'Neptün 7. evde - İlişkilerde idealizm, illüzyon riski. Ruh eşi arayışı, spiritüel partnerlik.',
      'neptune_8':
          'Neptün 8. evde - Mistik deneyimler, bilinçaltına dalış. Psişik yetenekler, ölüm ötesiyle ilgi.',
      'neptune_9':
          'Neptün 9. evde - Spiritüel arayış, mistik felsefe. Yurtdışı hayalleri, kozmik bilinç.',
      'neptune_10':
          'Neptün 10. evde - Kariyer vizyonu bulanık veya sanatsal. Şöhret illüzyonları, ideal meslek arayışı.',
      'neptune_11':
          'Neptün 11. evde - İdealist arkadaşlıklar, hayırsever gruplar. Kolektif rüyalar, ütopyacı vizyonlar.',
      'neptune_12':
          'Neptün 12. evde - Kendi evinde! Güçlü psişik yetenekler, mistik deneyimler. Spiritüel derinlik.',

      // Pluto in Houses
      'pluto_1':
          'Plüton 1. evde - Yoğun, manyetik, dönüştürücü varlık. Derin gözler, güçlü etki. Kendi kendini yeniden yaratma.',
      'pluto_2':
          'Plüton 2. evde - Para ve değerlerde dönüşüm. Finansal ölüm ve yeniden doğuş. Güç ve para ilişkisi.',
      'pluto_3':
          'Plüton 3. evde - Derin, araştırmacı zihin. Güçlü sözler, ikna kabiliyeti. Gizli bilgilere ilgi.',
      'pluto_4':
          'Plüton 4. evde - Aile karmasi, kök dönüşümü. Derin aile sırları, ev ortamında güç dinamikleri.',
      'pluto_5':
          'Plüton 5. evde - Tutkulu romantizm, yoğun yaratıcılık. Aşkta obsesyon riski, dönüştürücü sanat.',
      'pluto_6':
          'Plüton 6. evde - İş ve sağlıkta dönüşüm. Şifa güçleri, krizlerde regenerasyon. İş yerinde güç oyunları.',
      'pluto_7':
          'Plüton 7. evde - İlişkilerde derin dönüşüm. Yoğun partnerlikler, güç mücadeleleri. Terapötik ilişkiler.',
      'pluto_8':
          'Plüton 8. evde - Kendi evinde! Derin dönüşüm gücü, ölüm/yeniden doğuş uzmanlığı. Psikolog, şifacı.',
      'pluto_9':
          'Plüton 9. evde - İnanç ve felsefede radikal dönüşüm. Dogmalarla yüzleşme, hakikat arayışı.',
      'pluto_10':
          'Plüton 10. evde - Kariyer ve otoritede güç. Toplumsal dönüşüm ajanı. Liderlikte yoğunluk.',
      'pluto_11':
          'Plüton 11. evde - Gruplar ve ideallerde dönüşüm. Güçlü sosyal etki, kolektif karmayı dönüştürme.',
      'pluto_12':
          'Plüton 12. evde - Bilinçaltında derin güç. Geçmiş yaşam karması, spiritüel dönüşüm. Şifacı potansiyeli.',
    };
    return interpretations[key] ?? '';
  }

  /// Get Jupiter sign interpretation - Growth & Expansion
  static String getJupiterInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Jüpiter Koç burcunda - şansın ve büyümen cesaret, girişimcilik ve öncü olmakla bağlantılı. Risk aldığında evren seni ödüllendiriyor.

Felsefik bakış açın "yaparak öğrenmek" üzerine kurulu. Kitaplardan değil, deneyimlerden bilgelik kazanırsın. Bağımsız düşünce senin için kutsal.

Şans kapıların yeni başlangıçlarda, liderlik pozisyonlarında ve cesaret gerektiren durumlarda açılıyor. Korkmadan atıl!

Dikkat: Aşırı özgüven ve dürtüsellik abartılabilir. Jüpiter her şeyi büyütür - öfkeni de, aceleciliğini de.
''',
      ZodiacSign.taurus: '''
Jüpiter Boğa burcunda - şansın ve büyümen maddi dünya, konfor ve duyusal zevklerle bağlantılı. Bolluk senin doğal halin.

Felsefik bakış açın "yavaş ve istikrarlı kazanır" üzerine kurulu. Sabır ve kararlılık senin bilgelik yolun.

Şans kapıların finansal konularda, gayrimenkul, sanat, güzellik ve kaliteli şeylerde açılıyor. Değer yarattığında kazanırsın.

Dikkat: Aşırı maddecilik ve konfor bağımlılığı abartılabilir. Jüpiter her şeyi büyütür - hırsını da, inatçılığını da.
''',
      ZodiacSign.gemini: '''
Jüpiter İkizler burcunda - şansın ve büyümen iletişim, öğrenme ve bağlantılarla bağlantılı. Bilgi senin hazinen.

Felsefik bakış açın "her şeyi sorgula" üzerine kurulu. Tek bir doğru yok, çoklu perspektifler var.

Şans kapıların yazarlık, medya, eğitim, ticaret ve ağ kurmada açılıyor. İletişim kurduğunda büyürsün.

Dikkat: Dağınıklık ve yüzeysellik abartılabilir. Jüpiter her şeyi büyütür - merakını da, dikkat dağınıklığını da.
''',
      ZodiacSign.cancer: '''
Jüpiter Yengeç burcunda - yücelme pozisyonu! Şansın ve büyümen aile, yuva ve duygusal bağlarla bağlantılı.

Felsefik bakış açın "sevgi en büyük güç" üzerine kurulu. Şefkat ve koruma senin bilgelik yolun.

Şans kapıların aile işlerinde, gayrimenkul, yiyecek sektörü, bakım hizmetlerinde açılıyor. Besleyince büyürsün.

Jüpiter burada çok güçlü - cömertlik, şifa yeteneği ve bolluk doğal olarak akıyor. Ev ve aile konularında şanslısın.
''',
      ZodiacSign.leo: '''
Jüpiter Aslan burcunda - şansın ve büyümen yaratıcılık, kendini ifade ve liderlikle bağlantılı. Parladığında evren alkışlıyor.

Felsefik bakış açın "herkes özel ve değerli" üzerine kurulu. Kendine inanmak senin bilgelik yolun.

Şans kapıların sahne sanatları, eğlence, çocuklarla ilgili işler ve yaratıcı projelerde açılıyor. Cömertçe verdiğinde alırsın.

Dikkat: Ego ve abartı büyüyebilir. Jüpiter her şeyi büyütür - özgüvenini de, gösterişini de.
''',
      ZodiacSign.virgo: '''
Jüpiter Başak burcunda - düşüş pozisyonu ama bu "kötü" değil. Şansın ve büyümen hizmet, detay ve mükemmeliyetle bağlantılı.

Felsefik bakış açın "Tanrı detaylarda gizli" üzerine kurulu. Pratik bilgelik ve faydalı olmak senin yolun.

Şans kapıların sağlık, analiz, düzenleme ve iyileştirme işlerinde açılıyor. Faydalı olduğunda büyürsün.

Zorluk: Jüpiter genişlemek ister, Başak daraltır - bu gerilimi "kaliteli büyüme" ile çözersin.
''',
      ZodiacSign.libra: '''
Jüpiter Terazi burcunda - şansın ve büyümen ilişkiler, ortaklıklar ve dengeyle bağlantılı. İşbirliği seni zenginleştiriyor.

Felsefik bakış açın "adalet ve güzellik" üzerine kurulu. Uyum aramak senin bilgelik yolun.

Şans kapıların evlilik, iş ortaklıkları, hukuk, sanat ve diplomaside açılıyor. Dengelediğinde büyürsün.

Dikkat: Kararsızlık ve başkalarına bağımlılık abartılabilir. Jüpiter her şeyi büyütür - uyumunu da, bağımlılığını da.
''',
      ZodiacSign.scorpio: '''
Jüpiter Akrep burcunda - şansın ve büyümen derin dönüşüm, gizli bilgiler ve yoğun deneyimlerle bağlantılı.

Felsefik bakış açın "karanlıktan geçerek aydınlığa" üzerine kurulu. Ölüm ve yeniden doğuş senin bilgelik yolun.

Şans kapıların psikoloji, araştırma, miras, ortak finans ve şifa işlerinde açılıyor. Dönüştürünce büyürsün.

Dikkat: Obsesyon ve aşırı yoğunluk abartılabilir. Jüpiter her şeyi büyütür - tutkunu da, intikamını da.
''',
      ZodiacSign.sagittarius: '''
Jüpiter Yay burcunda - kendi evinde, çok güçlü! Şansın ve büyümen özgürlük, macera ve anlam arayışıyla bağlantılı.

Felsefik bakış açın "hakikat seni özgür kılar" üzerine kurulu. Öğrenmek ve öğretmek senin bilgelik yolun.

Şans kapıların yurtdışı, yüksek öğrenim, yayıncılık, felsefe ve spiritüel arayışta açılıyor. Genişledikçe büyürsün.

Doğal iyimserlik, şans ve koruma var. Evren seni seviyor - ama sorumluluk almayı da öğren.
''',
      ZodiacSign.capricorn: '''
Jüpiter Oğlak burcunda - düşüş pozisyonu ama bu "kötü" değil. Şansın ve büyümen disiplin, yapı ve uzun vadeli hedeflerle bağlantılı.

Felsefik bakış açın "yavaş ama emin" üzerine kurulu. Sabır ve çalışma senin bilgelik yolun.

Şans kapıların iş dünyası, yönetim, geleneksel kurumlar ve otorite pozisyonlarında açılıyor. İnşa ettikçe büyürsün.

Zorluk: Jüpiter genişlemek ister, Oğlak kısıtlar - bu gerilimi "disiplinli büyüme" ile çözersin.
''',
      ZodiacSign.aquarius: '''
Jüpiter Kova burcunda - şansın ve büyümen yenilik, insanlık ve özgünlükle bağlantılı. Farklı olmak seni zenginleştiriyor.

Felsefik bakış açın "herkes için özgürlük ve eşitlik" üzerine kurulu. Kolektif bilinç senin bilgelik yolun.

Şans kapıların teknoloji, sosyal hareketler, gruplar ve geleceğe yönelik projelerde açılıyor. Yenilik yaptıkça büyürsün.

Dikkat: Aşırı idealizm ve soğukluk abartılabilir. Jüpiter her şeyi büyütür - vizyonunu da, mesafeni de.
''',
      ZodiacSign.pisces: '''
Jüpiter Balık burcunda - geleneksel yönetici, çok güçlü! Şansın ve büyümen maneviyat, hayal gücü ve şefkatle bağlantılı.

Felsefik bakış açın "hepimiz biriz" üzerine kurulu. Koşulsuz sevgi senin bilgelik yolun.

Şans kapıların sanat, müzik, spiritüel işler, şifa ve hayır işlerinde açılıyor. Verdiğinde alırsın.

Doğal sezgi, spiritüel koruma ve mucize çekme gücün var. Evren seninle konuşuyor - dinle.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Saturn sign interpretation - Structure & Discipline
  static String getSaturnInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Satürn Koç burcunda - düşüş pozisyonu. Bağımsızlık ve eylem konularında karmik dersler var. Sabır öğrenme alanın.

Korkuların liderlik, girişimcilik ve kendini ortaya koymakla ilgili olabilir. "Yeterince güçlü müyüm?" sorusu.

Olgunlaşma yolun cesaret geliştirmek - ama dürtüsel değil, bilinçli cesaret. Bağımsızlığı sorumlulukla birleştirmek.

Ustalaştığında: Sakin, stratejik bir lider olursun. Öncülük edersin ama bilgece.
''',
      ZodiacSign.taurus: '''
Satürn Boğa burcunda - para, güvenlik ve değerler konusunda karmik dersler var. Maddi dünyayla sağlıklı ilişki öğrenme alanın.

Korkuların yoksulluk, yetersizlik ve maddi kayıplarla ilgili olabilir. "Yeterli var mı?" sorusu.

Olgunlaşma yolun gerçek değeri - içsel değeri - keşfetmek. Maddi güvenliği içsel güvenlikle birleştirmek.

Ustalaştığında: Sağlam, güvenilir bir kaynak olursun. Kalıcı değerler yaratırsın.
''',
      ZodiacSign.gemini: '''
Satürn İkizler burcunda - iletişim ve düşünce konusunda karmik dersler var. Zihinsel disiplin öğrenme alanın.

Korkuların anlaşılmamak, yanlış ifade ve zihinsel yetersizlikle ilgili olabilir. "Doğru mu söyledim?" sorusu.

Olgunlaşma yolun derinlemesine düşünmek - yüzeysellik yerine ustalık. Sözün ağırlığını bilmek.

Ustalaştığında: Bilge öğretmen, güvenilir yazarsın. Sözlerin etki bırakır.
''',
      ZodiacSign.cancer: '''
Satürn Yengeç burcunda - düşüş pozisyonu. Aile ve duygusal güvenlik konusunda karmik dersler var.

Korkuların reddedilme, terk edilme ve duygusal yetersizlikle ilgili olabilir. "Sevilmeyi hak ediyor muyum?" sorusu.

Olgunlaşma yolun kendi kendine anne/baba olmak - içsel güvenliği geliştirmek. Duygusal olgunluk.

Ustalaştığında: Duygusal bilgeliğe sahip, sınırları bilen ama sevgi dolu bir koruyucu olursun.
''',
      ZodiacSign.leo: '''
Satürn Aslan burcunda - kendini ifade ve yaratıcılık konusunda karmik dersler var. Otantik olmayı öğrenme alanın.

Korkuların görünmezlik, değersizlik ve beğenilmemeyle ilgili olabilir. "Yeterince özel miyim?" sorusu.

Olgunlaşma yolun içsel değeri keşfetmek - dış alkışa bağımlı olmadan parlamak. Alçakgönüllü liderlik.

Ustalaştığında: Gerçek karizmayla parlarsın. Başkalarını da parlatırsın.
''',
      ZodiacSign.virgo: '''
Satürn Başak burcunda - mükemmeliyetçilik ve hizmet konusunda karmik dersler var. Kendine şefkat öğrenme alanın.

Korkuların yetersizlik, hata yapma ve eleştirilmeyle ilgili olabilir. "Yeterince iyi miyim?" sorusu.

Olgunlaşma yolun "yeterince iyi"nin yeterli olduğunu kabullenmek. Kendine de başkalarına da merhamet.

Ustalaştığında: Detaylı ama şefkatli bir usta olursun. Gerçek hizmet bilgeliği.
''',
      ZodiacSign.libra: '''
Satürn Terazi burcunda - yücelme pozisyonu! İlişkiler ve adalet konusunda olgunluk potansiyelin yüksek.

Korkuların yalnızlık, dengesizlik ve çatışmayla ilgili olabilir. "Doğru partner var mı?" sorusu.

Olgunlaşma yolun sağlıklı sınırlarla ilişki kurmak. Kendi ayakların üzerinde durup sonra birleşmek.

Ustalaştığında: Dengeli, adil, bilge bir partner ve arabulucu olursun. İlişki ustası.
''',
      ZodiacSign.scorpio: '''
Satürn Akrep burcunda - güç, kontrol ve derin dönüşüm konusunda karmik dersler var.

Korkuların güvensizlik, ihanet ve kontrolü kaybetmeyle ilgili olabilir. "Güvenebilir miyim?" sorusu.

Olgunlaşma yolun güç oyunlarını bırakmak, gerçek gücü keşfetmek - kontrol değil, dönüşüm.

Ustalaştığında: Derin psikolojik bilgeliğe sahip bir şifacı, dönüştürücü olursun.
''',
      ZodiacSign.sagittarius: '''
Satürn Yay burcunda - inanç ve anlam konusunda karmik dersler var. Bilgelik yolculuğun.

Korkuların anlamsızlık, özgürlük kaybı ve dogmatizmle ilgili olabilir. "Neye inanmalıyım?" sorusu.

Olgunlaşma yolun körü körüne inanç yerine test edilmiş bilgelik. Özgürlükle sorumluluk dengesi.

Ustalaştığında: Gerçek bir öğretmen, bilge bir filozof olursun. Pratik spiritüalite.
''',
      ZodiacSign.capricorn: '''
Satürn Oğlak burcunda - kendi evinde, çok güçlü! Kariyer, yapı ve otorite konularında doğal yeteneğin var.

Korkuların başarısızlık, yetersizlik ve statü kaybıyla ilgili olabilir. "Başarabilir miyim?" sorusu.

Olgunlaşma yolun başarıyı dış onaydan ayırmak. İçsel otoriteyi geliştirmek.

Ustalaştığında: Gerçek bir otorite, güvenilir bir lider, kalıcı başarı yaratıcısı olursun.
''',
      ZodiacSign.aquarius: '''
Satürn Kova burcunda - geleneksel yönetici! Topluluk ve yenilik konularında yapı kurma yeteneğin var.

Korkuların dışlanma, farklı olma ve kabul görmemeyle ilgili olabilir. "Ait miyim?" sorusu.

Olgunlaşma yolun farklılığı güçle birleştirmek. Toplum için yapısal değişim yaratmak.

Ustalaştığında: Vizyoner ama pratik bir reformcu olursun. Geleceği bugünden inşa edersin.
''',
      ZodiacSign.pisces: '''
Satürn Balık burcunda - maneviyat ve hayal gücü konusunda yapı kurmayı öğrenme alanın.

Korkuların kaos, belirsizlik ve gerçeklikten kopmayla ilgili olabilir. "Gerçek ne?" sorusu.

Olgunlaşma yolun rüyaları gerçeğe dönüştürmek. Spiritüel deneyimlere pratik yapı vermek.

Ustalaştığında: Ayakları yerde bir mistik olursun. Ruhsal bilgeliği somutlaştırırsın.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Uranus sign interpretation - Innovation & Liberation
  static String getUranusInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Uranüs Koç burcunda (2010-2019) - Nesil yerleşimi. Bireysellik ve bağımsızlıkta radikal yenilik enerjisi taşıyorsun.

Bu kuşak, kimlik ve öncülük konusunda devrimci. Geleneksel liderlik kalıplarını yıkıp yeni modeller yaratma potansiyelin var.

Kolektif tema: "Ben kimim?" sorusunu yeniden tanımlamak. Bireysel özgürlük mücadelesi.

Kişisel uyanışın ani, elektriksel ve cesur. Beklenmedik başlangıçlar, sıra dışı girişimler.
''',
      ZodiacSign.taurus: '''
Uranüs Boğa burcunda (2018-2026) - Nesil yerleşimi. Para, değerler ve doğayla ilişkide radikal değişim enerjisi taşıyorsun.

Bu kuşak, ekonomik sistemleri ve değer anlayışını devrimleştiriyor. Kripto, sürdürülebilirlik, paylaşım ekonomisi.

Kolektif tema: "Gerçek değer nedir?" sorusunu yeniden tanımlamak. Maddi dünyanın dönüşümü.

Kişisel uyanışın finansal konularda, bedene bakışta ve doğayla ilişkide. Geleneksel sahiplik kavramını sorgularsın.
''',
      ZodiacSign.gemini: '''
Uranüs İkizler burcunda (2025-2033) - Nesil yerleşimi. İletişim ve bilgi paylaşımında radikal yenilik enerjisi.

Bu kuşak, iletişim teknolojilerini devrimleştirecek. Yeni diller, yeni medya, yapay zeka ile etkileşim.

Kolektif tema: "Nasıl iletişim kuruyoruz?" sorusunu yeniden tanımlamak. Bilginin demokratizasyonu.

Kişisel uyanışın düşünce ve ifade alanında. Geleneksel eğitim ve medyayı sorgularsın.
''',
      ZodiacSign.cancer: '''
Uranüs Yengeç burcunda (1949-1956, 2033-2040) - Nesil yerleşimi. Aile ve yuva kavramında radikal değişim enerjisi.

Bu kuşak, geleneksel aile yapısını sorguladı/sorgulayacak. Alternatif aile modelleri, duygusal özgürleşme.

Kolektif tema: "Aile nedir?" sorusunu yeniden tanımlamak. Duygusal güvenliğin yeniden yapılandırılması.

Kişisel uyanışın aile ve köken konularında. Geleneksel "yuva" anlayışını sorgularsın.
''',
      ZodiacSign.leo: '''
Uranüs Aslan burcunda (1955-1962) - Nesil yerleşimi. Yaratıcılık ve kendini ifadede radikal özgürleşme enerjisi.

Bu kuşak, bireysel ifade ve yaratıcılıkta devrim yaptı. Rock and roll nesli, karşı kültür, yaratıcı isyan.

Kolektif tema: "Kendimi nasıl ifade ederim?" sorusunu yeniden tanımlamak. Otantik olma cesareti.

Kişisel uyanışın yaratıcılık ve kendini göstermede. Performans ve sanat anlayışını sorgularsın.
''',
      ZodiacSign.virgo: '''
Uranüs Başak burcunda (1962-1969) - Nesil yerleşimi. Sağlık, hizmet ve iş hayatında radikal değişim enerjisi.

Bu kuşak, sağlık ve iş anlayışını devrimleştirdi. Organik gıda, alternatif tıp, iş yerinde haklar.

Kolektif tema: "Sağlıklı olmak ve hizmet etmek ne demek?" sorularını yeniden tanımlamak.

Kişisel uyanışın günlük rutinler ve sağlık konularında. Geleneksel tıp ve iş modellerini sorgularsın.
''',
      ZodiacSign.libra: '''
Uranüs Terazi burcunda (1968-1975) - Nesil yerleşimi. İlişkiler ve adalette radikal dönüşüm enerjisi.

Bu kuşak, ilişki anlayışını devrimleştirdi. Cinsiyet eşitliği, evlilik dışı birliktelikler, hukuki reformlar.

Kolektif tema: "İlişki nedir? Adalet nedir?" sorularını yeniden tanımlamak. Eşitlik mücadelesi.

Kişisel uyanışın partnerlik ve adalet konularında. Geleneksel evlilik ve ilişki kalıplarını sorgularsın.
''',
      ZodiacSign.scorpio: '''
Uranüs Akrep burcunda (1975-1981) - Nesil yerleşimi. Cinsellik, ölüm ve güç konularında radikal dönüşüm enerjisi.

Bu kuşak, tabularla yüzleşti. AIDS krizi, cinsel devrim, ölümle ilişkinin dönüşümü.

Kolektif tema: "Güç nedir? Ölüm ve seks tabuları" sorularını yeniden tanımlamak. Gölgeyle yüzleşme.

Kişisel uyanışın derin psikolojik konularda. Güç dinamiklerini ve tabularını sorgularsın.
''',
      ZodiacSign.sagittarius: '''
Uranüs Yay burcunda (1981-1988) - Nesil yerleşimi. İnanç, eğitim ve küreselleşmede radikal değişim enerjisi.

Bu kuşak, bilgiye erişimi devrimleştirdi. İnternet öncüleri, küresel bilinç, alternatif eğitim.

Kolektif tema: "Neye inanıyorum? Nasıl öğreniyorum?" sorularını yeniden tanımlamak.

Kişisel uyanışın inanç ve felsefe konularında. Geleneksel din ve eğitimi sorgularsın.
''',
      ZodiacSign.capricorn: '''
Uranüs Oğlak burcunda (1988-1996) - Nesil yerleşimi. Otorite, kurumlar ve kariyer anlayışında radikal değişim enerjisi.

Bu kuşak, geleneksel kariyer ve otorite modellerini sorguluyor. Girişimcilik, kurumsal isyan, yeni iş modelleri.

Kolektif tema: "Başarı nedir? Otoriteye nasıl yaklaşmalıyım?" sorularını yeniden tanımlamak.

Kişisel uyanışın kariyer ve toplumsal rol konularında. Geleneksel hiyerarşileri sorgularsın.
''',
      ZodiacSign.aquarius: '''
Uranüs Kova burcunda (1996-2003) - Kendi evinde, çok güçlü! Teknoloji ve topluluk anlayışında devrim enerjisi.

Bu kuşak, dijital çağın öncüleri. Sosyal medya nesli, çevrimiçi topluluklar, teknolojik dönüşüm.

Kolektif tema: "Topluluk nedir? İnsanlık nereye gidiyor?" sorularını yeniden tanımlamak.

Kişisel uyanışın son derece güçlü. Geleceği bugünden yaşıyorsun. Dijital ve sosyal yenilik DNA'nda.
''',
      ZodiacSign.pisces: '''
Uranüs Balık burcunda (2003-2011) - Nesil yerleşimi. Maneviyat, sanat ve bilinçte radikal dönüşüm enerjisi.

Bu kuşak, ruhani anlayışı devrimleştiriyor. Yeni çağ maneviyatı, dijital sanat, kolektif empati.

Kolektif tema: "Ruhaniyet nedir? Gerçeklik nedir?" sorularını yeniden tanımlamak.

Kişisel uyanışın spiritüel ve yaratıcı alanlarda. Geleneksel din ve sanat anlayışını sorgularsın.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Neptune sign interpretation - Dreams & Spirituality
  static String getNeptuneInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Neptün Koç burcunda (2025-2039) - Nesil yerleşimi. Bireysel kimlik ve öncülükte spiritüel dönüşüm başlıyor.

Bu kuşak, "ben" anlayışını spiritüel boyutta yeniden tanımlayacak. Ego ve ruh arasındaki sınırlar bulanıklaşıyor.

Kolektif rüya: Ruhsal savaşçılar, spiritüel öncüler, mistik liderler. Bireysel aydınlanma dalgası.

Dikkat alanı: Ego illüzyonları, sahte gurular, kimlik karmaşası. Gerçek benliği bulmak öğrenme alanı.
''',
      ZodiacSign.taurus: '''
Neptün Boğa burcunda (1875-1889, 2039-2052) - Nesil yerleşimi. Maddi değerler ve doğada spiritüel dönüşüm.

Bu kuşak, madde-ruh ilişkisini yeniden tanımlıyor. Doğanın kutsallığı, değerlerin spiritüelleşmesi.

Kolektif rüya: Kutsal toprak, ruhani zenginlik, doğayla birlik. Maddi dünyanın illüzyonunu görmek.

Dikkat alanı: Finansal illüzyonlar, maddeye aşırı bağlılık veya reddetme. Denge bulmak öğrenme alanı.
''',
      ZodiacSign.gemini: '''
Neptün İkizler burcunda (1889-1902) - Nesil yerleşimi. İletişim ve düşüncede spiritüel dönüşüm enerjisi.

Bu kuşak, telepati ve sezgisel iletişime ilgi duydu. Spiritüalizm akımı, medyumlar, bilinç araştırmaları.

Kolektif rüya: Sözün ötesinde iletişim, zihinler arası bağlantı, sezgisel anlayış.

Dikkat alanı: Bilgi kirliliği, yanlış bilgi, zihinsel karmaşa. Gerçeği ayırt etmek öğrenme alanı.
''',
      ZodiacSign.cancer: '''
Neptün Yengeç burcunda (1902-1915) - Nesil yerleşimi. Aile ve yuva kavramında spiritüel dönüşüm.

Bu kuşak, aile ve vatan ideallerini yoğun yaşadı. Milliyetçilik, aile kutsallığı, kök arayışı.

Kolektif rüya: Kutsal yuva, ruhani aile, atalarla bağ. Duygusal ve spiritüel güvenlik.

Dikkat alanı: Nostaljik illüzyonlar, geçmişe romantik bakış. Gerçek köklerle bağlanmak öğrenme alanı.
''',
      ZodiacSign.leo: '''
Neptün Aslan burcunda (1915-1929) - Nesil yerleşimi. Yaratıcılık ve kendini ifadede spiritüel dönüşüm.

Bu kuşak, sanat ve eğlenceyi spiritüelleştirdi. Hollywood'un doğuşu, caz çağı, yaratıcı ifade patlaması.

Kolektif rüya: Sanatla aşkınlık, performansla şifa, yaratıcı ilham. Tanrısal kıvılcımı ifade etmek.

Dikkat alanı: Şöhret illüzyonu, ego şişmesi, gerçeklikten kopuk hayaller. Alçakgönüllü yaratıcılık öğrenme alanı.
''',
      ZodiacSign.virgo: '''
Neptün Başak burcunda (1929-1943) - Düşüş pozisyonu. Hizmet ve pratiklikte spiritüel dönüşüm.

Bu kuşak, büyük buhran ve savaşla yüzleşti. Pratik hayallerin yıkılması, hizmetin kutsallığının keşfi.

Kolektif rüya: Şifa ve hizmet yoluyla ruhaniyet. Detaylarda Tanrı'yı bulmak.

Dikkat alanı: Aşırı eleştiri veya aşırı idealizm, sağlık kaygıları. Pratik maneviyat öğrenme alanı.
''',
      ZodiacSign.libra: '''
Neptün Terazi burcunda (1943-1957) - Nesil yerleşimi. İlişkiler ve güzellikte spiritüel dönüşüm.

Bu kuşak, ideal ilişki ve barış rüyasını taşıdı. Savaş sonrası ütopyalar, romantik idealler, sanat patlaması.

Kolektif rüya: Ruh eşi, mükemmel ilişki, evrensel barış ve uyum. Aşkla aşkınlık.

Dikkat alanı: İlişki illüzyonları, gerçeklikten kopuk romantizm. Gerçek ilişkilerde spiritüalite öğrenme alanı.
''',
      ZodiacSign.scorpio: '''
Neptün Akrep burcunda (1957-1970) - Nesil yerleşimi. Cinsellik ve dönüşümde spiritüel devrim.

Bu kuşak, cinsel devrimi ve psikedelik hareketi yaşadı. Tabularla spiritüel yüzleşme, karanlığın kutsallığı.

Kolektif rüya: Seksüel mistisizm, ölüm ve yeniden doğuş bilgeliği, gölge entegrasyonu.

Dikkat alanı: Bağımlılıklar, karanlık cazibe, obsesif spiritüalite. Aydınlık dönüşüm öğrenme alanı.
''',
      ZodiacSign.sagittarius: '''
Neptün Yay burcunda (1970-1984) - Nesil yerleşimi. İnanç ve anlam arayışında spiritüel dönüşüm.

Bu kuşak, New Age hareketini başlattı. Doğu felsefeleri, alternatif inançlar, küresel spiritüalite.

Kolektif rüya: Evrensel hakikat, tüm dinlerin birliği, kozmik bilinç. Anlam arayışında aşkınlık.

Dikkat alanı: Guru illüzyonları, spiritüel bypasss, dogmatik idealizm. Pratik bilgelik öğrenme alanı.
''',
      ZodiacSign.capricorn: '''
Neptün Oğlak burcunda (1984-1998) - Nesil yerleşimi. Kariyer ve otoritede spiritüel dönüşüm.

Bu kuşak, kurumsal yapıların çözülüşünü deneyimledi. Geleneksel otorite illüzyonlarının yıkılması.

Kolektif rüya: Spiritüel liderlik, ruhani iş dünyası, anlamlı kariyer. Başarının yeniden tanımı.

Dikkat alanı: Otorite illüzyonları, kariyer hayal kırıklıkları. İçsel otoriteyi bulmak öğrenme alanı.
''',
      ZodiacSign.aquarius: '''
Neptün Kova burcunda (1998-2012) - Nesil yerleşimi. Teknoloji ve toplulukta spiritüel dönüşüm.

Bu kuşak, dijital çağda spiritüaliteyi arıyor. Çevrimiçi ruhaniyet, kolektif bilinç, teknolojik mistisizm.

Kolektif rüya: Küresel birlik, dijital aydınlanma, insanlık ailesi. Teknoloji yoluyla uyanış.

Dikkat alanı: Sanal illüzyonlar, gerçeklikten kopuş, kolektif kuruntular. Topraklanmış vizyoner olmak öğrenme alanı.
''',
      ZodiacSign.pisces: '''
Neptün Balık burcunda (2012-2026) - Kendi evinde, çok güçlü! Evrensel bilinçte büyük spiritüel dönüşüm.

Bu kuşak, sınırların erimesini, birlik bilincini ve kozmik empatiyi taşıyor. Spiritüel uyanış dalgası.

Kolektif rüya: Evrensel sevgi, tüm varlıklarla birlik, koşulsuz şefkat. Okyanus gibi sınırsız bilinç.

Dikkat alanı: Gerçeklikten kaçış, bağımlılıklar, sınır problemleri. Topraklanmış spiritüalite öğrenme alanı.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get Pluto sign interpretation - Transformation & Power
  static String getPlutoInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries: '''
Plüton Koç burcunda (1822-1853, 2023-2044) - Nesil yerleşimi. Kimlik ve bireysellikte radikal dönüşüm başlıyor.

Bu kuşak, "ben" kavramını kökten dönüştürecek. Ego ölümü ve yeniden doğuşu, bireysel güç devrimi.

Kolektif dönüşüm: Liderlik anlayışının ölümü ve yeniden doğuşu. Bireysel egemenlik.

Gölge çalışması: Öfke, saldırganlık, ego patlamaları. Güçle sağlıklı ilişki kurmak.
''',
      ZodiacSign.taurus: '''
Plüton Boğa burcunda (1852-1884) - Nesil yerleşimi. Değerler ve ekonomide kökten dönüşüm enerjisi.

Bu kuşak, sanayi devrimini yaşadı. Maddi dünyanın radikal dönüşümü, ekonomik güç yapılarının yeniden şekillenmesi.

Kolektif dönüşüm: Para ve mülkiyet anlayışının ölümü ve yeniden doğuşu.

Gölge çalışması: Açgözlülük, sahiplenme, maddi bağımlılık. Gerçek değeri bulmak.
''',
      ZodiacSign.gemini: '''
Plüton İkizler burcunda (1884-1914) - Nesil yerleşimi. İletişim ve bilgide kökten dönüşüm enerjisi.

Bu kuşak, iletişim devrimini yaşadı. Telefon, radyo, gazete - bilgi güç oldu.

Kolektif dönüşüm: Bilgi paylaşımının ölümü ve yeniden doğuşu. Propaganda ve gerçek.

Gölge çalışması: Manipülasyon, bilgi silahı, zihinsel kontrol. Dürüst iletişim.
''',
      ZodiacSign.cancer: '''
Plüton Yengeç burcunda (1914-1939) - Nesil yerleşimi. Aile ve vatan kavramında kökten dönüşüm.

Bu kuşak, dünya savaşlarını, göçleri ve aile yapısının dönüşümünü yaşadı. Kök travmaları.

Kolektif dönüşüm: Aile ve ulus kavramlarının ölümü ve yeniden doğuşu. Duygusal güvenlik krizi.

Gölge çalışması: Aile travmaları, bağımlılık, aşırı korumacılık. Sağlıklı bağlar kurmak.
''',
      ZodiacSign.leo: '''
Plüton Aslan burcunda (1939-1958) - Nesil yerleşimi. Yaratıcılık ve otoritede kökten dönüşüm.

Bu kuşak, atom bombası, soğuk savaş ve süper güç yarışını yaşadı. Güç gösterileri, ego savaşları.

Kolektif dönüşüm: Liderlik ve yaratıcı gücün ölümü ve yeniden doğuşu. Yıldızların doğuşu.

Gölge çalışması: Kibir, güç sarhoşluğu, diktatörlük. Alçakgönüllü liderlik.
''',
      ZodiacSign.virgo: '''
Plüton Başak burcunda (1958-1972) - Nesil yerleşimi. Sağlık ve hizmette kökten dönüşüm.

Bu kuşak, çevre hareketi, sağlık devrimi ve iş gücü dönüşümünü yaşadı. Mükemmeliyetçilik krizi.

Kolektif dönüşüm: İş ve sağlık anlayışının ölümü ve yeniden doğuşu.

Gölge çalışması: Eleştiri, obsesif düzen, sağlık kaygısı. Kabul ve akış.
''',
      ZodiacSign.libra: '''
Plüton Terazi burcunda (1972-1984) - Nesil yerleşimi. İlişkiler ve adalette kökten dönüşüm.

Bu kuşak, cinsiyet rollerinin dönüşümünü, boşanma patlamasını ve eşitlik mücadelesini yaşadı.

Kolektif dönüşüm: İlişki ve evlilik anlayışının ölümü ve yeniden doğuşu.

Gölge çalışması: Güç oyunları ilişkilerde, manipülasyon, pasif saldırganlık. Sağlıklı denge.
''',
      ZodiacSign.scorpio: '''
Plüton Akrep burcunda (1984-1995) - Kendi evinde, çok güçlü! Her alanda radikal dönüşüm gücü.

Bu kuşak, AIDS krizi, duvarların yıkılışı ve tabularla yüzleşmeyi yaşadı. Derin psikolojik güç.

Kolektif dönüşüm: Tüm gizli güç yapılarının ölümü ve yeniden doğuşu. Gölgenin yükselişi.

Gölge çalışması: Obsesyon, intikam, kontrolcülük. Bırakma ve dönüşüm.
''',
      ZodiacSign.sagittarius: '''
Plüton Yay burcunda (1995-2008) - Nesil yerleşimi. İnanç ve küreselleşmede kökten dönüşüm.

Bu kuşak, 11 Eylül, din savaşları ve küreselleşme krizini yaşadı. İnanç sistemlerinin çatışması.

Kolektif dönüşüm: Din ve felsefe anlayışının ölümü ve yeniden doğuşu. Hakikat arayışı.

Gölge çalışması: Fanatizm, dogmatizm, ahlaki üstünlük. Alçakgönüllü bilgelik.
''',
      ZodiacSign.capricorn: '''
Plüton Oğlak burcunda (2008-2024) - Nesil yerleşimi. Otorite ve kurumlarda kökten dönüşüm.

Bu kuşak, finansal krizler, kurumsal çöküşler ve otorite krizini yaşıyor. Eski yapılar çöküyor.

Kolektif dönüşüm: Kapitalizm, hükümet ve şirket yapılarının ölümü ve yeniden doğuşu.

Gölge çalışması: Güç hırsı, korumazlık, sistemsel baskı. Yeni yapılar inşa etmek.
''',
      ZodiacSign.aquarius: '''
Plüton Kova burcunda (2024-2044) - Nesil yerleşimi. Teknoloji ve toplumda kökten dönüşüm başlıyor.

Bu kuşak, yapay zeka devrimi, toplumsal yeniden yapılanma ve insanlık dönüşümünü yaşayacak.

Kolektif dönüşüm: Toplum ve teknoloji anlayışının ölümü ve yeniden doğuşu. İnsanlık 2.0.

Gölge çalışması: Soğukluk, aşırı rasyonellik, insansızlaşma. Kalp ve teknoloji dengesi.
''',
      ZodiacSign.pisces: '''
Plüton Balık burcunda (2044-2068) - Nesil yerleşimi. Maneviyat ve bilinçte kökten dönüşüm gelecek.

Bu kuşak, spiritüel devrim ve bilinç evrimini yaşayacak. Eski ruhani yapıların çözülmesi.

Kolektif dönüşüm: Din ve ruhaniyet anlayışının ölümü ve yeniden doğuşu. Kozmik bilinç.

Gölge çalışması: Kaçış, illüzyon, kurban psikolojisi. Topraklanmış aşkınlık.
''',
    };
    return interpretations[sign] ?? '';
  }

  /// Get element balance interpretation
  static String getElementBalanceInterpretation(
    Map<Element, int> elementCounts,
  ) {
    final total = elementCounts.values.fold(0, (sum, count) => sum + count);
    if (total == 0) return '';

    final dominant = elementCounts.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
    final lacking = elementCounts.entries
        .where((e) => e.value == 0)
        .map((e) => e.key)
        .toList();

    String result = '';

    // Dominant element
    final dominantMeanings = {
      Element.fire:
          'Ateş elementi baskın - tutkulu, enerjik, girişimci bir doğan var. Eylem odaklısın.',
      Element.earth:
          'Toprak elementi baskın - pratik, güvenilir, somut düşünen bir doğan var. Sonuç odaklısın.',
      Element.air:
          'Hava elementi baskın - zihinsel, iletişimci, sosyal bir doğan var. Fikir odaklısın.',
      Element.water:
          'Su elementi baskın - duygusal, sezgisel, empatik bir doğan var. His odaklısın.',
    };

    result += dominantMeanings[dominant.key] ?? '';

    // Lacking elements
    if (lacking.isNotEmpty) {
      final lackingMeanings = {
        Element.fire:
            'Ateş eksikliği - motivasyon ve enerji bulma konusunda bazen zorlanabilirsin.',
        Element.earth:
            'Toprak eksikliği - pratik konular ve somut sonuçlar alma konusunda ekstra çaba gerekebilir.',
        Element.air:
            'Hava eksikliği - iletişim ve zihinsel analiz konusunda bilinçli çalışman gerekebilir.',
        Element.water:
            'Su eksikliği - duygusal ifade ve empati konusunda farkındalık geliştirmen gerekebilir.',
      };

      for (var element in lacking) {
        result += '\n\n${lackingMeanings[element]}';
      }
    }

    return result;
  }
}
