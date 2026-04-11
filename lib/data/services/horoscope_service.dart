import 'dart:math';
import '../models/zodiac_sign.dart';
import '../models/horoscope.dart';

class HoroscopeService {
  static final _random = Random();

  // Generate daily horoscope based on sign and date
  static DailyHoroscope generateDailyHoroscope(ZodiacSign sign, DateTime date) {
    final summaries = _getEsotericSummariesForSign(sign);
    final loveAdvices = _getEsotericLoveAdvices(sign);
    final careerAdvices = _getEsotericCareerAdvices(sign);
    final healthAdvices = _getEsotericHealthAdvices(sign);
    final moods = _getEsotericMoods();
    final colors = _getSacredColors(sign);

    // Use date as seed for consistent daily results
    final seed = date.year * 10000 + date.month * 100 + date.day + sign.index;
    final seededRandom = Random(seed);

    // Geçmiş, Şimdi, Gelecek içerikleri
    final pastInsights = _getPastInsights(sign);
    final presentEnergies = _getPresentEnergies(sign);
    final futureGuidances = _getFutureGuidances(sign);
    final cosmicMessages = _getCosmicMessages(sign);

    return DailyHoroscope(
      sign: sign,
      date: date,
      summary: summaries[seededRandom.nextInt(summaries.length)],
      loveAdvice: loveAdvices[seededRandom.nextInt(loveAdvices.length)],
      careerAdvice: careerAdvices[seededRandom.nextInt(careerAdvices.length)],
      healthAdvice: healthAdvices[seededRandom.nextInt(healthAdvices.length)],
      luckRating: seededRandom.nextInt(5) + 1,
      luckyNumber: '${seededRandom.nextInt(99) + 1}',
      luckyColor: colors[seededRandom.nextInt(colors.length)],
      mood: moods[seededRandom.nextInt(moods.length)],
      pastInsight: pastInsights[seededRandom.nextInt(pastInsights.length)],
      presentEnergy:
          presentEnergies[seededRandom.nextInt(presentEnergies.length)],
      futureGuidance:
          futureGuidances[seededRandom.nextInt(futureGuidances.length)],
      cosmicMessage:
          cosmicMessages[seededRandom.nextInt(cosmicMessages.length)],
    );
  }

  static Compatibility calculateCompatibility(
    ZodiacSign sign1,
    ZodiacSign sign2,
  ) {
    final elementMatch = _getElementCompatibility(sign1.element, sign2.element);
    final modalityMatch = _getModalityCompatibility(
      sign1.modality,
      sign2.modality,
    );

    final baseScore = ((elementMatch + modalityMatch) / 2 * 100).round();
    final variation = _random.nextInt(20) - 10;
    final overallScore = (baseScore + variation).clamp(0, 100);

    return Compatibility(
      sign1: sign1,
      sign2: sign2,
      overallScore: overallScore,
      loveScore: (overallScore + _random.nextInt(20) - 10).clamp(0, 100),
      friendshipScore: (overallScore + _random.nextInt(20) - 10).clamp(0, 100),
      communicationScore: (overallScore + _random.nextInt(20) - 10).clamp(
        0,
        100,
      ),
      summary: _getEsotericCompatibilitySummary(sign1, sign2, overallScore),
      strengths: _getEsotericCompatibilityStrengths(sign1, sign2),
      challenges: _getEsotericCompatibilityChallenges(sign1, sign2),
    );
  }

  static double _getElementCompatibility(Element e1, Element e2) {
    if (e1 == e2) return 0.9;

    // Fire + Air = Alchemical fusion
    if ((e1 == Element.fire && e2 == Element.air) ||
        (e1 == Element.air && e2 == Element.fire)) {
      return 0.85;
    }

    // Earth + Water = Sacred vessel
    if ((e1 == Element.earth && e2 == Element.water) ||
        (e1 == Element.water && e2 == Element.earth)) {
      return 0.85;
    }

    // Fire + Earth = Forging tension
    if ((e1 == Element.fire && e2 == Element.earth) ||
        (e1 == Element.earth && e2 == Element.fire)) {
      return 0.5;
    }

    // Air + Water = Mist and mystery
    if ((e1 == Element.air && e2 == Element.water) ||
        (e1 == Element.water && e2 == Element.air)) {
      return 0.5;
    }

    return 0.65;
  }

  static double _getModalityCompatibility(Modality m1, Modality m2) {
    if (m1 == m2) return 0.6;
    return 0.8;
  }

  static List<String> _getEsotericSummariesForSign(ZodiacSign sign) {
    final signSpecific = {
      ZodiacSign.aries: [
        'Ateş senin içinde yanmaktan yorulmaz, çünkü sen ateşin ta kendisisin. Bugün ruhun, başlangıcın gizli sırrını hatırlamak için uyanıyor. Öncü olmak kaderindir - ama bu sefer, savaşmak yerine aydınlatmak için ileri atıl. İçindeki savaşçı şimdi bilge bir lider olarak dönüşüyor.',
        'Mars enerjisi bugün damarlarında volkanik bir güç gibi akıyor. Eski ezoterik öğretiler, Koç burcunun ruhunun "İlk Işık" olduğunu söyler - karanlıktan önce var olan, yaratımın kendisi olan ışık. Bugün o ışığı taşımak için çağırıldın. Korkusuzca parla.',
        'Kozmik savaşçı arketipi içinde uyanıyor. Cesaretinin kökü, maddi dünyada değil, ruhsal alemde yatıyor. Bugün eylemlerinin arkasındaki niyet, sonucundan daha önemli. Bilincinle hareket et.',
      ],
      ZodiacSign.taurus: [
        'Toprak ananın kutsal kızı olarak, bugün bedeninin bir tapınak olduğunu hatırla. Her nefes, her lokma, her dokunuşun içinde tanrısallık saklı. Venüs seni maddi dünyanın ötesinde bir güzelliğe çağırıyor - ruhun güzelliğine.',
        'Boğanın sabırlılığı, aslında zamansız bilgeliğe erişimin anahtarıdır. Acelenin olmadığı yerde, evren sırlarını fısıldamaya başlar. Bugün yavaşla ve dinle - toprağın altında akan kadim nehirlerin sesini duyacaksın.',
        'Değerlilik duygum bugün sıcak bir ışık gibi içinde parlayacak. Sen, evrenin en nadide hazinelerinden birisin. Bu bir ego tatmini değil - bu, Venüs\'ün sana hatırlatmak istediği kozmik bir gerçek. Kendinle barışık ol.',
      ],
      ZodiacSign.gemini: [
        'İkizlerin gizemi, birliğin içindeki çokluktadır. Bugün zihnin, bin bir gece masallarındaki sihirli halı gibi - seni farklı alemlere taşıyacak. Her düşünce bir kapı, her kelime bir anahtar. Merkür seni bilginin labirentlerinde gezintiye çıkarıyor.',
        'Simyacıların "kutsal evlilik"i, içindeki erkek ve dişi enerjilerin birleşimini temsil eder. İkizler burcu olarak, bu dengeyi doğal olarak taşıyorsun. Bugün iç sesinle dış sesin arasında köprü kur.',
        'Hafiflik senin süper gücün. Kelebeğin kanat çırpışı nasıl uzaklarda fırtınalar yaratırsa, sen de bugün küçük ama derin etkiler bırakacaksın. Konuşmalarının arkasındaki niyet, kelimelerin ötesine taşacak.',
      ],
      ZodiacSign.cancer: [
        'Ay\'ın evladı olarak, duygu okyanusunun derinliklerinde hazineler saklıyorsun. Bugün, iç dünyanı keşfetme zamanı. Kabuğunun altında, evrenin tüm sırları kodlanmış durumda. Sezgilerine güven - onlar yıldızlardan gelen mesajlar.',
        'Anne arketipi içinde canlanıyor - ama bu sadece başkalarını beslemek değil, önce kendini beslemek demek. Yengeç, geriye doğru yürür çünkü bazen ilerlemenin yolu geçmişe bakmaktan geçer. Bugün eski yaraları iyileştirme fırsatın var.',
        'Suların hafızası vardır ve sen o hafızanın taşıyıcısısın. Atalarının bilgeliği bugün rüyalarında ve sezgilerinde konuşacak. Dinle - çünkü onlar seni korumak ve yönlendirmek için buradalar.',
      ],
      ZodiacSign.leo: [
        'Güneşin kraliyet çocuğu olarak, bugün tahtına oturma zamanı. Ama bu bir ego oyunu değil - gerçek krallık, başkalarının ışığını da parlatmaktır. Senin ışığın, karanlıkta kaybolmuş ruhlara yol gösterecek.',
        'Aslanın kükremesi, evrenin yaratıcı gücünün sesidir. Bugün yaratıcılığın doruklarda - ister sanat olsun, ister bir proje, ister bir ilişki. Her yaratış, tanrısal enerjinin maddeye dönüşmesidir.',
        'Altının simyası içinde gerçekleşiyor. Ham madde altına dönüştüğü gibi, sen de bugün en yüksek potansiyeline doğru evriliyorsun. Güneş seni kutsayarak parlatıyor.',
      ],
      ZodiacSign.virgo: [
        'Kutsal bakire arketipi, saflığın ve bütünlüğün sembolüdür. Bugün detaylarda tanrıyı göreceksin - her küçük düzende, her ince ayarda ilahi bir düzen saklı. Merkür seni mükemmelliğin peşine değil, anlamlılığın peşine yönlendiriyor.',
        'Şifacı arketipi bugün güçleniyor. Ama önce kendini iyileştirmelisin. Başkalarına sunduğun hizmet, önce kendi ruhuna sunduğun sevgiden akmalı. Kendine şefkat göster.',
        'Başak burcunun gizli gücü, kaosu düzene çevirebilme yeteneğidir. Bugün zihinsel berraklık dorukta - karmaşık durumlar basitleşiyor, çözümler belirginleşiyor. Bu bir armağan - iyi kullan.',
      ],
      ZodiacSign.libra: [
        'Dengenin ustası olarak, bugün iç ve dış dünyanın uyumunu sağlamaya çağırılıyorsun. Terazinin iki kefesi, ruhun iki yarısı gibidir - birini ihmal etmek, bütünü bozmak demektir. Venüs seni güzelliğin ötesinde bir ahenke davet ediyor.',
        'İlişkiler senin aynan - ama aynanın iki yüzü var. Bugün başkalarında gördüğün, aslında kendindeki saklılığı gösteriyor. Bu bir çağrı: kendini tanımak için başkalarını kullan, ama kendini onlarda kaybetme.',
        'Harmoni arayışı asla sona ermeyen bir danstır. Bugün o dansın ritmine güven. Bazen öne çık, bazen geri çekil - ama her zaman müziği dinle. Evren senin partnerin.',
      ],
      ZodiacSign.scorpio: [
        'Ölüm ve yeniden doğuş efendisi olarak, bugün bir dönüşümün eşiğindesin. Plüton\'un karanlık suları seni çağırıyor - korkma, çünkü derinliklerde altın parlıyor. Eski benliğini bırakma zamanı.',
        'Akrebin zehri, aynı zamanda şifadır - bu paradoksu sen herkesten iyi bilirsin. Bugün gölge yanının elini tut. Onu reddetmek yerine, onu dönüştürmeyi seç. Gücün orada saklı.',
        'Tutku senin yakıt kaynağın, ama yanlış yöne aktığında yıkıcı olabilir. Bugün tutkularını bilinçli bir şekilde yönlendir. Obsesyon yerine, derin bağlılık. Kontrol yerine, teslimiyet.',
      ],
      ZodiacSign.sagittarius: [
        'Kozmik gezgin olarak, bugün fiziksel değil ruhsal bir yolculuğa çıkıyorsun. Jüpiter seni sınırların ötesine, bilinen dünyanın kenarlarına çağırıyor. Orada ne bulacaksın? Belki de her zaman aradığın cevap: kendin.',
        'Okun hedefi, sadece uzaktaki bir nokta değil - o nokta senin en yüksek potansiyelin. Bugün nişan al, ama acelenin olmadığını fark et. Okun uçuşu, hedefe varmasından daha değerlidir.',
        'Filozof arketipi içinde uyanıyor. Sorular cevaplardan daha kıymetli. Bugün "neden" diye sormaktan çekinme - evren, meraklılarına sırlarını fısıldar.',
      ],
      ZodiacSign.capricorn: [
        'Dağın zirvesine tırman, ama zirve seni bekliyor olması değil, yolculuğun seni dönüştürmesi önemlidir. Satürn sana sabır ve disiplin veriyor - ama bugün bunların ötesinde bir şey var: içsel otorite.',
        'Zamanın efendisi olarak, bugün geçmiş ve geleceğin arasındaki ince çizgide duruyorsun. Atalarının mirası omuzlarında, ama yükü taşımak değil, onu dönüştürmek senin görevin.',
        'Oğlak burcunun gizli yüzü, karanlığın içinde bile parlayan yıldızdır. Dışarıdan soğuk görünebilirsin, ama içinde bir volkan var. Bugün o içsel ateşi onurlandır.',
      ],
      ZodiacSign.aquarius: [
        'Geleceğin taşıyıcısı olarak, bugün zamanın ötesinden gelen mesajları alıyorsun. Uranüs seni konfor bölgenin dışına itiyor - orası büyümenin gerçekleştiği yer. Farklılığın senin armağanın.',
        'Kolektif bilincin çanağısın - ama önce kendi bilincini temizlemelisin. Bugün zihinsel netlik önemli. Başkalarının düşüncelerinden ayrı, kendinin düşüncelerini bul.',
        'Devrimci ruh içinde yanıyor. Ama gerçek devrim, önce iç dünyada başlar. Bugün eski kalıpları kır - ama yenilerini inşa etmeyi de unutma.',
      ],
      ZodiacSign.pisces: [
        'Rüyaların ve gerçekliğin sınırlarını eriten mistik olarak, bugün iki dünya arasında köprü kuruyorsun. Neptün seni hayalin ötesine, vizyonun alemine çağırıyor. Orada gördüklerini dünyaya getir.',
        'Okyanusun damlası olarak, tüm okyanusun bilgisini taşıyorsun. Bugün sezgilerin açık - görünmeyeni görecek, duyulmayanı duyacaksın. Bu bir lanet değil, bir armağan.',
        'Şifa veren yaralı arketipi içinde canlanıyor. Kendi acıların, başkalarını iyileştirmeni sağlayan ilaç oldu. Bugün o ilacı paylaş - ama kendine de bir doz ayır.',
      ],
    };

    return signSpecific[sign]!;
  }

  static List<String> _getEsotericLoveAdvices(ZodiacSign sign) {
    return [
      'Aşk, ruhun aynaya bakışıdır. Bugün partnerinde gördüğün, aslında kendi iç dünyanın yansımasıdır. Bu yansımaya sevgiyle bak - çünkü kendini sevmeden başkasını sevemezsin.',
      'Kalpten kalbe uzanan görünmez ipler var. Bugün o ipleri hisset - kimi çekiyor, kimi itiyor? Çekimi takip et, ama bilincini kaybetme. Aşk bir teslimiyet, ama bilinçli bir teslimiyet.',
      'Kutsal birleşme, iki yarının bütün olması değil - iki bütünün birleşmesidir. Önce kendin bütün ol. Sonra başka bir bütünle dans et. Bu, gerçek aşkın simyası.',
      'Venüs bugün kalbini okşuyor. Eski yaralar iyileşiyor, yeni kapılar açılıyor. Aşk kapına geldiğinde, onu tanıyacak mısın? Bazen aşk, beklediğimiz kılıkta gelmez.',
      'Ruh eşinin arayışı, aslında kendi ruhunun arayışıdır. Dışarıda aradığın, içinde zaten var. Bugün iç denize dal - orada seni bekleyen bir hazine var.',
      'Bağ kurmak, zincirlemek değil - köprü inşa etmektir. Bugün ilişkilerindeki köprüleri güçlendir. Ama köprünün iki ucunun da sağlam olması gerek.',
      'Aşkın alevi, kontrol edilmezse yakar. Ama bilinçli alev, aydınlatır ve ısıtır. Bugün tutkunu bilinçle harmanla. Sonuç: dönüştürücü bir ilişki.',
      'Kalp çakran bugün aktif. Yeşilin şifa gücünü hisset. Geçmişte kırılmış kalbin artık kaynıyor. Yeni bağlar kurmaya hazırsın.',
    ];
  }

  static List<String> _getEsotericCareerAdvices(ZodiacSign sign) {
    return [
      'İş hayatın, ruhani yolculuğunun bir yansımasıdır. Bugün yaptığın işin arkasındaki derin anlamı keşfet. Para kazanmak değil, değer yaratmak - işte gerçek zenginlik.',
      'Yeteneklerin, evrenin sana verdiği hediyelerdir. Bugün o hediyeleri dünyayla paylaş. Korku değil, cömertlik rehberin olsun. Verdikçe alacaksın.',
      'Liderlik, önde yürümek değil - ışık tutmaktır. Bugün başkalarına yol gösterme fırsatın var. Ama önce kendi yolunu aydınlat.',
      'Maddi dünya, ruhani dünyanın aynasıdır. Kariyer hedeflerin, ruhani hedeflerinle uyumlu mu? Bugün bu soruyu kendine sor. Cevap seni şaşırtabilir.',
      'Başarının gerçek ölçüsü, ne kadar kazandığın değil - ne kadar anlamlı iş yaptığındır. Bugün anlam ara. Onu bulduğunda, başarı peşinden gelecek.',
      'Bolluk bilinci bugün aktive oluyor. Kıtlık korkusunu bırak. Evren sonsuz bolluk sunuyor - seni sınırlayan sadece inançların.',
      'Yaratıcılığının profesyonel alandaki gücünü keşfet. Bugün alışıldık yolları terk et. Yenilikçi fikirlerin, seni farklı kılacak.',
      'Sabır ve zamanlama her şey. Bugün aceleci kararlar verme. Bekle, gözle, sonra hareket et. Evrenin ritmiyle uyumlu ol.',
    ];
  }

  static List<String> _getEsotericHealthAdvices(ZodiacSign sign) {
    return [
      'Bedenin, ruhunun tapınağıdır. Bugün o tapınağı onurlandır. Her lokma bir ayin, her nefes bir dua, her hareket bir dans olsun.',
      'Enerji bedenin bugün hassas. Çevrendeki enerjilere dikkat et. Seni tüketen ortamlardan uzaklaş, seni besleyen ortamlara yakın dur.',
      'Topraklama bugün önemli. Çıplak ayaklarını toprağa bas, ellerini sulara değdir. Doğayla bağlanmak, en güçlü şifadır.',
      'Nefes, yaşam gücünün taşıyıcısıdır. Bugün bilinçli nefes al. Her nefesle ışık al, her verişle karanlık bırak.',
      'Uyku, küçük ölümdür - ve her uyku, yeniden doğuştur. Bugün uyku düzenine dikkat et. Rüyaların mesajlar taşıyor.',
      'Su elementiyle çalışmak bugün şifa getirecek. Banyo yap, yüz, ya da sadece suyu izle. Su, duygu bedenini arındırıyor.',
      'Hareket meditasyonu bugün sana uygun. Yoga, dans, ya da sadece yürüyüş - bedenini bilinçle hareket ettir.',
      'Kök çakra bugün dikkat istiyor. Güvenlik, istikrar, topraklanma - bunlara odaklan. Temeller sağlam olunca, üst katlar güvende.',
    ];
  }

  static List<String> _getEsotericMoods() {
    return [
      'Sezgisel',
      'Dönüşümde',
      'Aydınlanmış',
      'Topraklı',
      'Akışta',
      'Uyanan',
      'Alıcı',
      'Yaratıcı',
      'Mistik',
      'Bütünleşmiş',
      'Ateşli',
      'Dingin',
    ];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GEÇMİŞİN YANKISI - Dünden gelen mesajlar ve tamamlanmamış enerjiler
  // ═══════════════════════════════════════════════════════════════════════════
  static List<String> _getPastInsights(ZodiacSign sign) {
    final signSpecific = {
      ZodiacSign.aries: [
        'Geçmişte attığın cesur adımların meyvelerini bugün topluyorsun. O zaman göze aldığın riskler, şimdi seni güçlendiren deneyimlere dönüştü. Ancak geçmişte yarım bıraktığın bir proje veya ilişki, hâlâ ruhunda iz bırakmış olabilir. Bu enerjiyi temizlemek için, o döneme şükranla bak ve öğrendiklerini kabul et.',
        'Mars enerjisinin geçmişteki izleri bugün belirginleşiyor. Bir zamanlar savaştığın ama kazanamadığını düşündüğün bir mücadele var mı? Evren sana şunu fısıldıyor: O savaş aslında kazanılmıştı, sadece zaferin farklı bir biçimde geldi. Geçmişe minnetle bak.',
        'Atalarından gelen savaşçı ruhu taşıyorsun. Onların cesareti, senin damarlarında akıyor. Bugün, geçmişten gelen bu güç seni destekliyor. Ama aynı zamanda, onların tamamlayamadığı bir misyonun parçası olabilirsin. Bu mirası onurlandır.',
      ],
      ZodiacSign.taurus: [
        'Geçmişte ektiğin tohumlar artık filizleniyor. Sabırla beklediğin zamanlar boşa gitmedi; evren her şeyi kayıt altına aldı. Maddi veya manevi olarak geçmişte yaptığın yatırımlar, bugün karşılığını veriyor. Ama geçmişte bırakmakta zorlandığın bir şey var mı? Onu serbest bırakma zamanı.',
        'Venüs\'ün geçmişteki izleri kalbinde hâlâ canlı. Bir zamanlar çok değer verdiğin ama kaybettiğini düşündüğün bir şey - bir ilişki, bir yer, bir his - aslında hiç kaybolmadı. O enerji dönüşerek senin bir parçan oldu. Şimdi onu yeni biçimlerde ifade edebilirsin.',
        'Toprak hafızası atalarının bilgeliğini taşır. Onların el emeği, alın teri, sabırla inşa ettikleri her şey senin DNA\'nda kodlu. Bugün bu kadim bilgeliğe eriş. Geçmişin sana öğrettiği en değerli ders: Sağlam temeller her şeyin başlangıcıdır.',
      ],
      ZodiacSign.gemini: [
        'Geçmişte söylediğin veya söyleyemediğin kelimeler bugün yankılanıyor. İletişimin gücünü o zaman tam anlamamış olabilirsin, ama şimdi her kelimenin yarattığı titreşimi görüyorsun. Tamamlanmamış konuşmalar, açıklanmamış duygular - bunları artık serbest bırakabilirsin.',
        'Merkür\'ün hafızasında saklı sırlar var. Geçmişte öğrendiğin ama kullanmadığın bir bilgi, bugün hayatına anlam katacak. O eski kitap, o yarıda kalan kurs, o unutulmuş yetenek - hepsi hâlâ seninle. Onları hatırla.',
        'Zihnin bir zaman makinesi gibi çalışıyor. Geçmişe seyahat ettiğinde, oradan sadece nostalji değil, bilgelik de getir. Dün yaptığın hatalar, bugünün öğretmenleridir. Onlara teşekkür et ve ilerle.',
      ],
      ZodiacSign.cancer: [
        'Ay\'ın kadim hafızası, geçmişin tüm duygusal izlerini taşır. Çocukluğundan gelen bir his, bir koku, bir melodi bugün ani bir şekilde geri gelebilir. Bu bir tesadüf değil; ruhun sana bir şey hatırlatmak istiyor. O anıya nazikçe dokun ve içindeki mesajı al.',
        'Aile ağacının kökleri derinlere uzanıyor. Atalarının sevinçleri, acıları, umutları ve korkuları senin hücrelerinde yaşıyor. Bugün bu kadim bağın farkına var. Geçmişten gelen bir yara varsa, onu şefkatle iyileştirme zamanı.',
        'Duygusal hafızan bir hazine sandığı gibi. İçinde hem ışıltılı mücevherler hem de eski yaralar var. Bugün o sandığı aç, ama dikkatli ol - her parçaya sevgiyle dokun. Geçmişi reddetmek yerine, onu bütünleştir.',
      ],
      ZodiacSign.leo: [
        'Geçmişte parlak bir yıldız gibi ışıdığın anlar var. O anların enerjisi hâlâ seninle. Ama belki de geçmişte, ışığının farkında olmadan söndüğü zamanlar da oldu. Bugün o karanlık anları affet - onlar da senin bir parçan ve seni güçlendirdiler.',
        'Güneş\'in kadim hafızası, kralların ve kraliçelerin bilgeliğini taşır. Geçmiş hayatlarında belki de tahtlarda oturdun, belki de tahtlar için savaştın. Bu karmaşık miras bugün sana liderlik dersleri veriyor.',
        'Bir zamanlar sahip olduğun ama kaybettiğini düşündüğün bir güç var. Belki özgüvenin, belki yaratıcılığın, belki de sevme kapasiten. Ama hiçbir şey gerçekten kaybolmaz; sadece dönüşür. O gücü yeniden keşfetme zamanı.',
      ],
      ZodiacSign.virgo: [
        'Geçmişte mükemmeliyetçiliğin seni yorduğu zamanlar oldu. Her detayı kontrol etmeye çalışırken, büyük resmi kaçırmış olabilirsin. Bugün o deneyimlerden öğren: Kusursuzluk hedef değil, yolculuğun kendisi değerlidir.',
        'Merkür\'ün analitik hafızası, geçmişin her detayını kaydetmiş. Ama bu kayıtlar seni hapsetmek için değil, özgürleştirmek için var. Geçmişteki hataların, bugünün bilgeliğidir. Onları yargılamak yerine, onlardan öğren.',
        'Şifacı arketipinin geçmişi derin. Belki de geçmişte başkalarını iyileştirirken kendini ihmal ettin. O yaralar hâlâ var mı? Bugün önce kendi yaralarına bak. Kendini iyileştirmeden başkalarını iyileştiremezsin.',
      ],
      ZodiacSign.libra: [
        'Geçmişte kurduğun dengeler ve bozulan dengeler, bugünün temelini oluşturuyor. Bir zamanlar çok önem verdiğin bir ilişki, bir ortaklık, bir uyum - bunların hepsi sana bir şeyler öğretti. Şimdi o dersleri yeni dengeler kurmak için kullan.',
        'Venüs\'ün geçmişteki izleri, güzellik arayışının tarihçesidir. Geçmişte güzel bulduğun şeyler değişti mi? Bu değişim, senin evriminin işareti. Estetik anlayışın derinleşti, yüzeyin ötesini görmeye başladın.',
        'Adalet terazisinin geçmişi ağır. Belki de geçmişte haksızlığa uğradın veya farkında olmadan haksızlık ettin. Bugün bu dengesizlikleri düzeltme fırsatın var. Affeyle başla - kendini ve başkalarını.',
      ],
      ZodiacSign.scorpio: [
        'Geçmişte öldüğün ve yeniden doğduğun kaç kez oldu? Her dönüşüm seni daha güçlü kıldı, ama aynı zamanda derin izler bıraktı. Bugün o izlere bak - onlar zafiyet değil, hayatta kalmanın kanıtı. Geçmişin savaşçısına saygı duy.',
        'Plüton\'un karanlık hafızası, gizli sırlar ve derin dönüşümler barındırıyor. Geçmişte gömülmüş bir gerçek, bugün yüzeye çıkmak istiyor olabilir. Korkma - karanlıktan korkan sen değilsin, karanlık senden korkuyor.',
        'Bir zamanlar büyük bir kayıp yaşadın - belki bir ilişki, belki bir parça benliğin, belki bir hayalin. O kayıp seni şekillendirdi. Bugün o kaybın aslında bir kazanç olduğunu görebilirsin. Anka kuşu gibi, küllerinden doğdun.',
      ],
      ZodiacSign.sagittarius: [
        'Geçmişte çıktığın yolculuklar - fiziksel veya ruhsal - bugün senin kim olduğunun haritasını çizdi. Her macera, her keşif, her hata seni buraya getirdi. Geçmişe bak ve gördüğün manzaraya şükret.',
        'Jüpiter\'in genişleyen hafızası, sınırları aşma çabalarının tarihidir. Geçmişte ulaşmak isteyip ulaşamadığın bir hedef var mı? Belki o hedef değişti, belki sen değiştin. Ama arayış ruhu hâlâ içinde yanıyor.',
        'Okçunun geçmişi, attığı okların izini taşır. Her ok bir niyet, bir umut, bir hayaldi. Bazıları hedefe ulaştı, bazıları kayboldu. Bugün kayıp oklara üzülme - onlar da bir yerlere ulaştı, sadece sen görmedin.',
      ],
      ZodiacSign.capricorn: [
        'Geçmişte tırmandığın dağlar, bugünkü zirvenin temeli. Her zorlu adım, her soğuk gece, her yalnız an seni güçlendirdi. Geçmişin çilesi, bugünün bilgeliğidir. O yolculuğa saygı duy.',
        'Satürn\'ün ağır hafızası, zamanın ve sınırların bilincini taşır. Geçmişte çok erken yaşlanmış gibi hissettin mi? O olgunluk, şimdi senin en büyük gücün. Zamanı yönetmeyi öğrendin, çünkü zamanla savaştın.',
        'Atalarının inşa ettikleri - evler, aileler, gelenekler - senin mirasın. Bu miras bazen ağır gelebilir, ama aynı zamanda seni taşıyan temeldir. Geçmişin yükünü onurlandır, ama onu dönüştürme hakkın da var.',
      ],
      ZodiacSign.aquarius: [
        'Geçmişte farklı olduğun için dışlandığın zamanlar oldu mu? O anlar seni kırmadı, aksine benzersizliğini keşfetmeni sağladı. Bugün o farklılık, dünyanın ihtiyacı olan şey. Geçmişteki yalnızlık, bugünün özgürlüğü.',
        'Uranüs\'ün devrimci hafızası, kırılan zincirlerin ve yıkılan duvarların tarihidir. Geçmişte neye isyan ettin? O isyan hâlâ içinde mi? Şimdi onu bilinçli bir dönüşüme çevir.',
        'Kolektif bilinçle bağın, geçmişte bazen bunaltıcı oldu. Herkesin acısını hissetmek yorucu. Bugün sınırlarını koru, ama bağını kesme. Geçmişin duyarlılığı, geleceğin vizyonunu besliyor.',
      ],
      ZodiacSign.pisces: [
        'Geçmişte rüyalar ve gerçeklik arasında kaybolduğun zamanlar oldu. O bulanık sınırlar seni korkutmuş olabilir, ama aslında en büyük armağanın orada saklı. Geçmişin hayalcisi, bugünün vizyoneri.',
        'Neptün\'ün sisli hafızası, geçmiş hayatların ve paralel gerçekliklerin izlerini taşır. Déjà vu hislerin boşuna değil; sen zaman ve mekanın ötesinde var oluyorsun. Geçmiş sadece geçmiş değil, hâlâ seninle.',
        'Okyanusun hafızası sonsuz. Geçmişte akıttığın her gözyaşı, yaşadığın her duygu o okyanusu besledi. Bugün o derin sulardan bilgelik çek. Geçmişin acıları, şifanın kaynağı olabilir.',
      ],
    };

    return signSpecific[sign]!;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ŞİMDİNİN ENERJİSİ - Bu anın gücü ve potansiyeli
  // ═══════════════════════════════════════════════════════════════════════════
  static List<String> _getPresentEnergies(ZodiacSign sign) {
    final signSpecific = {
      ZodiacSign.aries: [
        'Şu an, içindeki ateş en parlak haliyle yanıyor. Bu an, harekete geçme zamanı. Düşünmek için değil, yapmak için doğdun. Evrenin enerjisi seninle paralel akıyor; her adımın destekleniyor. Cesaretini topla ve sıçra - ağ görünecek.',
        'Mars enerjisi tam şu an zirvede. Bedeninde bir titreşim, bir hazırlık hissi var mı? Bu, evrenin sana verdiği sinyal: Şimdi hareket et. Erteleme, fırsatı kaçırmak demek. Ama bilinçli hareket et - kör cesaret değil, bilge cesaret.',
        'Bu an, öncü ruhunun sahneye çıkma zamanı. Çevrende herkes beklerken, sen ilk adımı at. Korku mu hissediyorsun? Güzel, bu korku seni durdurmak için değil, seni hazırlamak için var. Korkuyla birlikte ilerle.',
      ],
      ZodiacSign.taurus: [
        'Şu an, beş duyunun en keskin olduğu zaman. Dokunduğun her şey, tattığın her lokma, duyduğun her ses - hepsi sana mesaj veriyor. Bu an, bedende ol. Zihin değil, kalp değil; tam olarak burada, bu bedende, bu nefeste.',
        'Venüs enerjisi şu an seni sarmalıyor. Güzellik her yerde, ama onu görmek için yavaşlamalısın. Bu an, acele etme zamanı değil. Sabırla, dikkatle, şükranla - şimdiye tanık ol.',
        'Toprak elementi şu an seni destekliyor. Ayaklarının altındaki sağlamlığı hisset. Ne olursa olsun, bu zemin seni taşıyacak. Bu an güvende olduğunu bil. Bu güvenlik, dışarıdan değil, içeriden geliyor.',
      ],
      ZodiacSign.gemini: [
        'Şu an, zihnin bin kanatlı bir kelebek gibi. Fikirler, bağlantılar, olasılıklar her yerde. Bu zenginliği kucakla, ama dağılma. Şimdinin gücü, odaklanmakta. Bir düşünceyi seç ve derinleş.',
        'Merkür tam şu an seninle konuşuyor. Kulak ver - kelimeler, işaretler, rastlantılar hepsi anlam taşıyor. Bu an, evrenin sana mesaj yağmuru yaptığı an. Dikkatli ol, en önemli mesajı kaçırma.',
        'İletişim kanalların şu an sonuna kadar açık. Söylemek istediğin bir şey var mı? Şimdi söyle. Sormak istediğin bir soru var mı? Şimdi sor. Bu an, sesini duyurma zamanı.',
      ],
      ZodiacSign.cancer: [
        'Şu an, duygusal okyanusun sakin bir koy gibi. Bu dinginlikte derin ol. İçine bak - orada ne görüyorsun? Bu an, iç dünyanla buluşma zamanı. Dışarısı bekleyebilir.',
        'Ay enerjisi şu an seni koruyor. Kabuğunun içinde güvende hisset, ama kapıyı tamamen kapatma. Bu an, seçici açıklık zamanı. Kim ve ne içeri girebilir, sen karar ver.',
        'Sezgilerin şu an zirve yapıyor. Mantık bir kenarda, içgüdüler ön planda. Bu ana güven. Bedenin, kalbinin ne söylediğini dinle. Zihnin karıştırmasına izin verme.',
      ],
      ZodiacSign.leo: [
        'Şu an, Güneş senin için doğuyor. Işığın her zamankinden parlak. Bu an, görünme zamanı. Saklanma, küçülme, sönme - bunlar sana yakışmıyor. Sahneye çık ve ışıldıyor.',
        'Yaratıcı enerjin şu an volkanik. İçinden bir şey dışarı çıkmak istiyor - bir fikir, bir sanat eseri, bir ifade. Bu ana izin ver. Yaratım şu an gerçekleşiyor, sadece kanalı aç.',
        'Kraliyet enerjisi şu an zirvede. Liderlik etme, ilham verme, yol gösterme zamanı. Ama gerçek krallık, başkalarını küçülterek değil, onları yükselterek olur. Işığını paylaş.',
      ],
      ZodiacSign.virgo: [
        'Şu an, detaylar netleşiyor. Daha önce görmediğin şeyleri görüyorsun. Bu berraklık bir armağan - onu iyi kullan. Ama her detayda boğulma; büyük resmi de gör.',
        'Merkür\'ün analitik gücü şu an seninle. Karmaşık durumlar basitleşiyor, çözümler beliriyor. Bu an, düşünme ve planlama zamanı. Ama düşünmekte takılma - eylem de lazım.',
        'Şifacı enerjin şu an aktif. Kendinde veya başkalarında iyileştirme fırsatı var. Bu an, şefkat zamanı. Yargılamak değil, anlamak. Eleştirmek değil, desteklemek.',
      ],
      ZodiacSign.libra: [
        'Şu an, denge noktasındasın. Ne geçmişte ne gelecekte - tam burada, tam şimdi. Bu denge hassas ama güçlü. Bu anın ortasında dur ve her iki tarafa da eşit mesafede ol.',
        'Venüs enerjisi şu an ilişkilerini aydınlatıyor. Çevrendeki insanları gerçekten gör. Bu an, bağlanma zamanı. Yüzeysel değil, derin. Sosyal değil, samimi.',
        'Estetik duyarlılığın şu an keskin. Güzellik her yerde, ama çirkinlik de görünür. Bu an, güzeli seç. Neye odaklanırsan onu büyütürsün.',
      ],
      ZodiacSign.scorpio: [
        'Şu an, dönüşümün tam ortasındasın. Bir şey ölüyor, bir şey doğuyor. Bu geçiş zonunda rahat ol. Karanlık ve ışık aynı anda var - ikisini de kucakla.',
        'Plüton enerjisi şu an yoğun. Derinlerde bir şeyler kıpırdıyor. Bu an, yüzleşme zamanı. Kaçınmak, ertelemek, inkar etmek - bunlar işe yaramaz. Doğrudan bak.',
        'Tutku ve güç şu an zirve yapıyor. Bu enerjiyi bilinçli yönlendir. Kontrolsüz bırakırsan yıkıcı, bilinçli kullanırsan dönüştürücü. Seçim senin.',
      ],
      ZodiacSign.sagittarius: [
        'Şu an, ufuklar sonsuza açılıyor. Her yön bir olasılık, her yol bir macera. Bu an, seçim zamanı. Ama seçememek de bir seçim - hareketsizlik. Ok gerili, bırak gitsin.',
        'Jüpiter enerjisi şu an seni genişletiyor. Sınırların esniyorsun, yeni alanlara uzanıyorsun. Bu an, büyüme zamanı. Konfor zonunun dışına çık.',
        'Felsefi zihnin şu an aktif. Büyük sorular, derin düşünceler. Bu an, anlam arama zamanı. Cevaplar önemli değil, sorular önemli. Sormaya devam et.',
      ],
      ZodiacSign.capricorn: [
        'Şu an, dağın tam yamacındasın. Ne başlangıç ne zirve - yolculuğun ortası. Bu an, kararlılık zamanı. Bir adım daha, bir nefes daha. Durma.',
        'Satürn enerjisi şu an seni disipline çağırıyor. Yapı, düzen, sorumluluk. Bu an, gevşeme zamanı değil. Ama zorla da değil - bilinçli çabayla.',
        'İçsel otorite şu an güçleniyor. Dışarıdan onay aramayı bırak. Bu an, kendi otoriteni tanıma zamanı. Sen kendi efendinsin.',
      ],
      ZodiacSign.aquarius: [
        'Şu an, sıradışı olan normal. Farklılığın, benzersizliğin, tuhaflığın - hepsi şu an kabul görüyor. Bu an, kendin olma zamanı. Filtreler yok, maskeler yok.',
        'Uranüs enerjisi şu an elektrik gibi. Ani fikirler, beklenmedik bağlantılar, sürpriz çözümler. Bu an, ilhama açık ol. Nereden geleceği belli olmaz.',
        'Kolektif bilinçle bağın şu an güçlü. İnsanlığın nabzını hissediyorsun. Bu an, bireyselliğin ötesine geçme zamanı. Sen bir parçasısın, ama parçadan fazlasısın.',
      ],
      ZodiacSign.pisces: [
        'Şu an, iki dünya arasında köprüdesin. Görünen ve görünmeyen, maddi ve ruhani, rüya ve gerçek. Bu an, her ikisinde de ol. Birini seçmek zorunda değilsin.',
        'Neptün enerjisi şu an buğulu bir perde gibi. Her şey biraz silik, biraz belirsiz. Bu an, netlik arama zamanı değil. Belirsizliğe teslim ol.',
        'Sezgisel kapasiten şu an sonuna kadar açık. Hissettiğin her şey gerçek - mantık onaylamasa bile. Bu an, içsel bilgine güvenme zamanı.',
      ],
    };

    return signSpecific[sign]!;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GELECEĞİN FISILTISI - Önündeki potansiyeller ve olasılıklar
  // ═══════════════════════════════════════════════════════════════════════════
  static List<String> _getFutureGuidances(ZodiacSign sign) {
    final signSpecific = {
      ZodiacSign.aries: [
        'Gelecek, senin için yeni savaş alanları değil, yeni zafer alanları hazırlıyor. Ama bu zaferlerin doğası değişiyor - artık dışarıdaki düşmanları yenmek değil, içerideki korkuları dönüştürmek. Önümüzdeki dönem, iç savaşçının olgunlaşma zamanı. Cesaretini içe yönlendir.',
        'Ufukta parlayan ışık, yeni başlangıçların habercisi. Ama bu sefer acele etme; sabırla hazırlan. Gelecekteki fırsatlar, hazırlıklı olanı bekliyor. Şimdi tohumları ek, hasat vakti gelecek.',
        'Mars önümüzdeki dönemde seni destekleyecek, ama farklı bir şekilde. Ham güç yerine, rafine güç. Saldırı yerine, strateji. Gelecek, bilge savaşçının zamanı.',
      ],
      ZodiacSign.taurus: [
        'Gelecek, bolluk vaadediyor - ama bu bolluk sadece maddi değil. Ruhsal zenginlik, duygusal doygunluk, ilişkisel derinlik. Şimdiden bu alanlara yatırım yap; gelecekte karşılığını alacaksın.',
        'Venüs önümüzdeki dönemde sana güzellik ve uyum getirecek. Ama bu güzellik için zemin hazırlamalısın. Kaosları temizle, gereksizleri bırak. Gelecek, sadelikte saklı.',
        'Toprak elementi gelecekte seni taşımaya devam edecek, ama yeni bir biçimde. Esneklik öğren, değişime direnme. Gelecek, köklü ama akışkan olmayı gerektiriyor.',
      ],
      ZodiacSign.gemini: [
        'Gelecek, senin için bilgi ve bilgeliğin birleştiği bir dönem. Şimdiye kadar topladığın bilgiler, önümüzdeki dönemde anlam kazanacak. Parçalar birleşecek, büyük resim ortaya çıkacak.',
        'Merkür gelecekte sana yeni iletişim kanalları açacak. Belki yeni bir dil, belki yeni bir ifade biçimi, belki yeni bağlantılar. Şimdiden hazır ol, kapılar açılıyor.',
        'İkili doğan gelecekte bütünleşme fırsatı bulacak. İç çatışmalar çözülecek, parçalanmışlık iyileşecek. Ama bu çalışma gerektiriyor; evren yardım edecek, ama sen de çabala.',
      ],
      ZodiacSign.cancer: [
        'Gelecek, evinin - hem fiziksel hem ruhsal - dönüşümünü getiriyor. Güvenli alanın genişleyecek, ama önce bazı duvarları yıkman gerekebilir. Değişimden korkma; yeni ev, eski evden daha sıcak olacak.',
        'Ay döngüleri önümüzdeki dönemde seni destekleyecek. Duygusal dalgalanmalar azalacak, iç huzur artacak. Şimdiden meditasyon ve öz-bakım pratikleri başlat.',
        'Aile bağların gelecekte yeni bir biçim alacak. Bazı bağlar güçlenecek, bazıları çözülecek. Her iki durum da doğru; gelecek, otantik bağların zamanı.',
      ],
      ZodiacSign.leo: [
        'Gelecek, senin için yaratıcı patlama zamanı. İçinde biriken tüm o fikirler, projeler, hayaller - onları dışa vurmak için uygun koşullar oluşuyor. Şimdiden hazırlan, sahne seninle dolacak.',
        'Güneş önümüzdeki dönemde seni özel bir şekilde aydınlatacak. Görünürlüğün artacak, etki alanın genişleyecek. Ama bu güçle birlikte sorumluluk da gelecek. Işığını nasıl kullanacaksın?',
        'Liderlik rolün gelecekte evrilecek. Otoriter değil, ilham verici. Kontrol eden değil, güçlendiren. Bu dönüşüme şimdiden başla.',
      ],
      ZodiacSign.virgo: [
        'Gelecek, senin için mükemmeliyetçiliğin rahatladığı bir dönem. Kontrol ihtiyacı azalacak, akışa güven artacak. Bu sana özgürlük getirecek - beklediğinden fazlasını.',
        'Merkür önümüzdeki dönemde pratik zekana destek verecek. Projeler tamamlanacak, hedeflere ulaşılacak. Ama süreç de önemli; sadece sonuca odaklanma.',
        'Şifacı rolün gelecekte derinleşecek. Belki bir eğitim, belki bir deneyim, belki bir uyanış. Şimdiden bu alana niyetini yönelt.',
      ],
      ZodiacSign.libra: [
        'Gelecek, ilişkilerinde köklü değişiklikler getiriyor. Bazıları derinleşecek, bazıları sona erecek. Her iki durum da denge için gerekli. Şimdiden hangi bağların seni besleyip hangilerinin tükettiğini gör.',
        'Venüs önümüzdeki dönemde aşk alanını canlandıracak. İster mevcut ilişki olsun, ister yeni bir bağ - romantizm yükselişte. Kalbini açık tut.',
        'Adalet arayışın gelecekte karşılık bulacak. Haksızlıklar düzelecek, dengeler kurulacak. Ama sabır gerekli; evrenin zamanlaması seninkinden farklı.',
      ],
      ZodiacSign.scorpio: [
        'Gelecek, senin için büyük dönüşümün tamamlandığı dönem. Yıllardır içinden geçtiğin süreç sonuçlanıyor. Anka kuşu artık uçmaya hazır. Geçmişin küllerinden tamamen yüksel.',
        'Plüton önümüzdeki dönemde sana güç ve derinlik verecek. Ama bu güç, kontrol için değil, dönüştürmek için. Yıkıcı değil, yaratıcı bir güç.',
        'Gizli yeteneklerin gelecekte ortaya çıkacak. Şimdiye kadar bastırdığın veya fark etmediğin kapasiteler uyanıyor. Şimdiden içe bak, neler saklı?',
      ],
      ZodiacSign.sagittarius: [
        'Gelecek, uzun zamandır hayal ettiğin macerayı getiriyor. Bir yolculuk, bir keşif, bir genişleme. Fiziksel veya ruhsal - belki ikisi birden. Şimdiden hazırlan, yola çıkmak üzeresin.',
        'Jüpiter önümüzdeki dönemde kapıları ardına kadar açacak. Fırsatlar, bağlantılar, olasılıklar yağmur gibi yağacak. Ama hepsine evet demek zorunda değilsin; seçici ol.',
        'Öğretmen rolün gelecekte belirginleşecek. Biriktirdiğin bilgeliği paylaşma zamanı. Belki formal bir öğretim, belki sadece yaşam örneği. Her iki şekilde de etkili olacaksın.',
      ],
      ZodiacSign.capricorn: [
        'Gelecek, zirveye ulaşmanın zamanı. Yıllarca tırmandığın dağın tepesi görünüyor. Ama zirve, son durak değil - yeni bir başlangıç. Orada ne yapacaksın? Şimdiden düşün.',
        'Satürn önümüzdeki dönemde ödülleri dağıtacak. Sabır, disiplin, çabalarının karşılığı. Ama bu ödüller maddi olmayabilir - belki iç tatmin, belki tanınma, belki ruh huzuru.',
        'Miras ve gelenek konuları gelecekte önem kazanacak. Ne bırakacaksın? Neyi sürdüreceksin? Ataların sana ne verdi, sen gelecek nesillere ne vereceksin?',
      ],
      ZodiacSign.aquarius: [
        'Gelecek, vizyonlarının gerçekleşme zamanı. Yıllardır gördüğün, hayal ettiğin, planladığın şeyler maddeye dönüşüyor. Evren nihayet seninle aynı sayfada. Şimdiden detayları netleştir.',
        'Uranüs önümüzdeki dönemde beklenmedik kapılar açacak. Planlamadığın, hayal etmediğin fırsatlar. Bu sürprizlere açık ol; bazen en iyi şeyler planlanmamış olur.',
        'Topluluk ve kolektif çalışma gelecekte öne çıkacak. Yalnız deha dönemi bitiyor; birlikte yaratma zamanı. Şimdiden kabileni bul.',
      ],
      ZodiacSign.pisces: [
        'Gelecek, rüyalarının gerçeğe dönüştüğü dönem. Hayalci demesinler - sen vizyoner olduğunu kanıtlayacaksın. Ama bu dönüşüm için topraklanmak gerekli; sadece rüya görmek yetmez.',
        'Neptün önümüzdeki dönemde ilhamı artıracak. Sanatsal, ruhsal, sezgisel kapasitelerin zirve yapacak. Bu dalgayı yakala ve yaratıma dönüştür.',
        'Şifa yolculuğun gelecekte tamamlanmaya yaklaşıyor. Yıllardır taşıdığın yaralar kapanıyor. Ama iyileştikten sonra ne olacak? Şimdiden düşün - çünkü yeni bir sen doğuyor.',
      ],
    };

    return signSpecific[sign]!;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // EVRENİN MESAJI - Günün özünü taşıyan kısa ve güçlü mesaj
  // ═══════════════════════════════════════════════════════════════════════════
  static List<String> _getCosmicMessages(ZodiacSign sign) {
    final signSpecific = {
      ZodiacSign.aries: [
        '🔥 Bugün cesaretin rehberin, kalbin pusulan olsun.',
        '⚔️ İçindeki savaşçı bilge, dışındaki dünya hazır.',
        '🌟 Işığını yakma zamanı - dünya seni görmeyi bekliyor.',
      ],
      ZodiacSign.taurus: [
        '🌿 Sabır en güçlü büyün, şükran en derin şifan.',
        '💎 Değerini bil, çünkü evren senin değerini biliyor.',
        '🌸 Güzellik peşinde koşma, güzellik zaten sensin.',
      ],
      ZodiacSign.gemini: [
        '🦋 Değişim seni korkutmasın, sen değişimin kendisisin.',
        '💫 Her düşünce bir tohum, dikkatli seç ve ek.',
        '🌬️ Kelimelerinle dünyalar yarat, bilgeliğinle köprüler kur.',
      ],
      ZodiacSign.cancer: [
        '🌙 Duygularını kucakla, onlar senin süper gücün.',
        '🏠 İç evin güvende, dış dünyaya oradan bak.',
        '🌊 Akışa güven, dalga seni doğru kıyıya taşıyacak.',
      ],
      ZodiacSign.leo: [
        '☀️ Parladığında dünya daha aydınlık bir yer oluyor.',
        '👑 Gerçek krallık kalplerde hüküm sürmektir.',
        '🎭 Sahne seninle dolsun, ama başrolü egona verme.',
      ],
      ZodiacSign.virgo: [
        '🌾 Mükemmel olan sensin, mükemmeliyetçilik değil.',
        '💚 Önce kendini iyileştir, sonra dünyayı.',
        '✨ Detaylarda kaybolma, büyük resmi de gör.',
      ],
      ZodiacSign.libra: [
        '⚖️ Denge içeride başlar, dışarısı yansıma.',
        '🌹 Güzellik gözlerinde, harmoni kalbinde.',
        '🤝 İlişkilerin aynan - kendini orda gör.',
      ],
      ZodiacSign.scorpio: [
        '🦂 Karanlık seni korkutmaz, sen karanlığı aydınlatırsın.',
        '🔮 Dönüşüm senin doğan, her gün yeniden doğ.',
        '💜 Tutkunun gücü seni yakar veya aydınlatır - sen seç.',
      ],
      ZodiacSign.sagittarius: [
        '🏹 Hedefine odaklan, ok çoktan yaydan çıktı.',
        '🗺️ Yolculuk varış noktasından değerli.',
        '🔥 Özgürlük içeride, dışarıdaki zincirler yanılsama.',
      ],
      ZodiacSign.capricorn: [
        '🏔️ Zirve sabırlıları bekler, sen zaten yoldasın.',
        '⏳ Zaman senin müttefikin, ona karşı değil onunla çalış.',
        '🏛️ İnşa ettiğin her şey miras, bilinçle yap.',
      ],
      ZodiacSign.aquarius: [
        '⚡ Farklılığın armağanın, normallik senin için değil.',
        '🌐 Kolektif kalbinde, ama bireysel ışığını koru.',
        '🚀 Geleceği görmek yetmez, onu yaratmak da gerek.',
      ],
      ZodiacSign.pisces: [
        '🐟 İki dünya arasında köprüsün, her ikisinde de evdesin.',
        '🌌 Rüyaların gerçeğin tohumları, onları sulamayı unutma.',
        '💙 Sezgilerin pusulandan keskin, ona güven.',
      ],
    };

    return signSpecific[sign]!;
  }

  static List<String> _getSacredColors(ZodiacSign sign) {
    final signColors = {
      ZodiacSign.aries: ['Ateş Kırmızısı', 'Altın', 'Turuncu', 'Mercan'],
      ZodiacSign.taurus: [
        'Zümrüt Yeşili',
        'Gül Pembesi',
        'Toprak Tonları',
        'Bakır',
      ],
      ZodiacSign.gemini: ['Lavanta', 'Gök Mavisi', 'Sarı', 'Gümüş'],
      ZodiacSign.cancer: ['İnci Beyazı', 'Ay Gümüşü', 'Deniz Mavisi', 'Sedef'],
      ZodiacSign.leo: [
        'Güneş Altını',
        'Kraliyet Kırmızısı',
        'Turuncu',
        'Bronz',
      ],
      ZodiacSign.virgo: ['Orman Yeşili', 'Bej', 'Krem', 'Buğday Rengi'],
      ZodiacSign.libra: ['Gül Kuvarsi', 'Pastel Mavi', 'Fildişi', 'Bakır'],
      ZodiacSign.scorpio: ['Bordo', 'Siyah', 'Koyu Mor', 'Kan Kırmızısı'],
      ZodiacSign.sagittarius: [
        'Kraliyet Moru',
        'Turkuaz',
        'Safir Mavisi',
        'İndigo',
      ],
      ZodiacSign.capricorn: [
        'Derin Kahve',
        'Koyu Yeşil',
        'Antrasit',
        'Obsidyen',
      ],
      ZodiacSign.aquarius: ['Elektrik Mavisi', 'Mor', 'Teal', 'Platin'],
      ZodiacSign.pisces: ['Deniz Yeşili', 'Lavanta', 'Akuamarin', 'Opal'],
    };

    return signColors[sign]!;
  }

  static String _getEsotericCompatibilitySummary(
    ZodiacSign sign1,
    ZodiacSign sign2,
    int score,
  ) {
    final name1 = sign1.nameTr;
    final name2 = sign2.nameTr;

    if (score >= 80) {
      return '$name1 ve $name2 arasında kadim bir bağ var - sanki ruhlarınız farklı hayatlarda birçok kez karşılaşmış gibi. Bu bağlantı tesadüf değil; evrenin sizi bir araya getirmesinin derin bir anlamı var. Birbirinizi aydınlatan, dönüştüren ve yücelten bir enerji akışı söz konusu. Bu ilişki, her ikinizin de en yüksek potansiyeline ulaşması için bir katalizör.';
    } else if (score >= 60) {
      return '$name1 ve $name2, farklı melodilerin harmonik bir kompozisyon oluşturabileceği bir eşleşmede. Zorluklar var, ama bu zorluklar büyüme fırsatıdır. Her ikiniz de bu ilişkiden dönüşmüş olarak çıkabilirsiniz - yeter ki, birbirinizi değiştirmeye değil, anlamaya odaklanın. Ayrılıklar, birleşmenin dansının bir parçasıdır.';
    } else if (score >= 40) {
      return '$name1 ve $name2 arasındaki enerji, alev ve su gibi - birbirini söndürebilir veya buhar oluşturabilir. Bu bir karmik ilişki olabilir; geçmişte tamamlanmamış bir iş için bir araya gelmiş olabilirsiniz. Bilinçli çaba gösterirseniz, bu ilişki derin bir öğreti kaynağı olabilir. Ama kolay olmayacak - ve belki de öyle olması gerekmiyor.';
    } else {
      return '$name1 ve $name2, evrenin size bir ayna tuttuğu bir kombinasyon. Birbirinizde gördüğünüz, aslında kendi gölge yanınızdır. Bu ilişki kolay değil, ama en zor ilişkiler bazen en büyük öğretileri taşır. Soru şu: Bu aynayla yüzleşmeye hazır mısınız? Cevap "evet" ise, bu ilişki sizi derinden dönüştürebilir.';
    }
  }

  static List<String> _getEsotericCompatibilityStrengths(
    ZodiacSign sign1,
    ZodiacSign sign2,
  ) {
    final strengths = <String>[];

    if (sign1.element == sign2.element) {
      final elementName = ElementExtension(sign1.element).nameTr;
      strengths.add(
        'Aynı $elementName elementini paylaşmak, kelimesiz bir anlayış yaratıyor - sanki aynı dili konuşuyorsunuz.',
      );
    }

    if (sign1.modality != sign2.modality) {
      strengths.add(
        'Farklı modaliteler, eksik parçaları tamamlıyor. Birinin başladığı yerde diğeri devam edebilir.',
      );
    }

    if (sign1.element == Element.fire && sign2.element == Element.air ||
        sign1.element == Element.air && sign2.element == Element.fire) {
      strengths.add(
        'Ateş ve Hava\'nın simyasal birleşimi: fikirler alev alıyor, tutkular kanat açıyor.',
      );
    }

    if (sign1.element == Element.earth && sign2.element == Element.water ||
        sign1.element == Element.water && sign2.element == Element.earth) {
      strengths.add(
        'Toprak ve Su\'yun kutsal evliliği: duygular somutlaşıyor, hayaller gerçekleşiyor.',
      );
    }

    strengths.addAll([
      'Ruhsal büyüme için güçlü bir potansiyel - birbirinizi yükseltiyorsunuz.',
      'Karşılıklı saygı ve hayranlık temeli var.',
      'Birbirinizin gizli potansiyellerini görebilme yeteneği.',
    ]);

    return strengths.take(4).toList();
  }

  static List<String> _getEsotericCompatibilityChallenges(
    ZodiacSign sign1,
    ZodiacSign sign2,
  ) {
    final challenges = <String>[];

    if (sign1.element != sign2.element) {
      challenges.add(
        'Farklı elementler, farklı ihtiyaçlar demek. Birinin ateşine diğer dayanabilir mi? Su soğutmak mı istiyor, beslemek mi?',
      );
    }

    if (sign1.modality == sign2.modality) {
      challenges.add(
        'Aynı modalite, iktidar mücadelesi riski taşıyor. Kim yön belirleyecek? Kim takip edecek?',
      );
    }

    if (sign1.element == Element.fire && sign2.element == Element.water ||
        sign1.element == Element.water && sign2.element == Element.fire) {
      challenges.add(
        'Ateş ve Su\'yun dansı tehlikeli olabilir - ya birbirinizi söndürürsünüz, ya da buhar olup uçarsınız.',
      );
    }

    challenges.addAll([
      'İletişim farklılıkları: Aynı kelimelere farklı anlamlar yükleyebilirsiniz.',
      'Gölge yansımaları: Birbirinizde görmek istemediğiniz yanları görebilirsiniz.',
    ]);

    return challenges.take(3).toList();
  }
}
