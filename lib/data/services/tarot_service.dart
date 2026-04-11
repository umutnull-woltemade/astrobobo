import 'dart:math';

/// Tarot kart okuma servisi
class TarotService {
  static final _random = Random();

  /// Tek kart çekimi
  static TarotCard drawSingleCard() {
    final cards = TarotCard.majorArcana;
    final index = _random.nextInt(cards.length);
    final isReversed = _random.nextBool();
    return cards[index].copyWith(isReversed: isReversed);
  }

  /// Üç kart açılımı (Geçmiş - Şimdi - Gelecek)
  static ThreeCardSpread drawThreeCards() {
    final cards = List<TarotCard>.from(TarotCard.majorArcana);
    cards.shuffle(_random);

    return ThreeCardSpread(
      past: cards[0].copyWith(isReversed: _random.nextBool()),
      present: cards[1].copyWith(isReversed: _random.nextBool()),
      future: cards[2].copyWith(isReversed: _random.nextBool()),
    );
  }

  /// Kelt Haçı açılımı (10 kart)
  static CelticCrossSpread drawCelticCross() {
    final cards = List<TarotCard>.from(TarotCard.majorArcana);
    cards.shuffle(_random);

    return CelticCrossSpread(
      significator: cards[0].copyWith(isReversed: _random.nextBool()),
      crossing: cards[1].copyWith(isReversed: _random.nextBool()),
      foundation: cards[2].copyWith(isReversed: _random.nextBool()),
      recentPast: cards[3].copyWith(isReversed: _random.nextBool()),
      crown: cards[4].copyWith(isReversed: _random.nextBool()),
      nearFuture: cards[5].copyWith(isReversed: _random.nextBool()),
      selfImage: cards[6].copyWith(isReversed: _random.nextBool()),
      environment: cards[7].copyWith(isReversed: _random.nextBool()),
      hopesAndFears: cards[8].copyWith(isReversed: _random.nextBool()),
      outcome: cards[9].copyWith(isReversed: _random.nextBool()),
    );
  }

  /// Aşk açılımı (5 kart)
  static LoveSpread drawLoveSpread() {
    final cards = List<TarotCard>.from(TarotCard.majorArcana);
    cards.shuffle(_random);

    return LoveSpread(
      youCard: cards[0].copyWith(isReversed: _random.nextBool()),
      partnerCard: cards[1].copyWith(isReversed: _random.nextBool()),
      relationshipCard: cards[2].copyWith(isReversed: _random.nextBool()),
      challengeCard: cards[3].copyWith(isReversed: _random.nextBool()),
      adviceCard: cards[4].copyWith(isReversed: _random.nextBool()),
    );
  }

  /// Günün kartı
  static TarotCard getDailyCard(DateTime date) {
    // Tarih bazlı tutarlı kart seçimi
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final random = Random(seed);
    final cards = TarotCard.majorArcana;
    final index = random.nextInt(cards.length);
    final isReversed = random.nextBool();
    return cards[index].copyWith(isReversed: isReversed);
  }

  /// Evet/Hayır sorusu için tek kart
  static YesNoReading drawYesNoCard() {
    final card = drawSingleCard();

    // Ters kartlar genelde "hayır" veya "bekle"
    // Bazı kartlar doğal olarak daha pozitif veya negatif
    final positiveCards = [
      1,
      3,
      6,
      9,
      10,
      11,
      14,
      17,
      19,
      21,
    ]; // Fool, Empress, Lovers, etc.
    final negativeCards = [
      12,
      13,
      15,
      16,
      18,
    ]; // Hanged Man, Death, Devil, Tower, Moon

    String answer;
    String explanation;

    if (card.isReversed) {
      if (positiveCards.contains(card.number)) {
        answer = 'Belki - Dikkatli ol';
        explanation =
            '${card.nameTr} ters geldi. Normalde olumlu bir enerji taşısa da, şu an engellerle karşılaşabilirsin.';
      } else {
        answer = 'Hayır - Şu an değil';
        explanation =
            '${card.nameTr} ters konumda. Bu, olumsuz enerjilerin baskın olduğunu gösteriyor. Beklemeni öneririm.';
      }
    } else {
      if (negativeCards.contains(card.number)) {
        answer = 'Dikkatli ol';
        explanation =
            '${card.nameTr} bir dönüşüm kartı. Evet mümkün, ama beklenmedik değişimlere hazır ol.';
      } else if (positiveCards.contains(card.number)) {
        answer = 'Evet';
        explanation =
            '${card.nameTr} olumlu enerji taşıyor. Yolun açık görünüyor.';
      } else {
        answer = 'Muhtemelen evet';
        explanation =
            '${card.nameTr} genel olarak olumlu bir işaret. Temkinli iyimserlik yerin de.';
      }
    }

    return YesNoReading(card: card, answer: answer, explanation: explanation);
  }
}

/// Tarot kartı modeli
class TarotCard {
  final int number;
  final String name;
  final String nameTr;
  final String keywords;
  final String keywordsTr;
  final String uprightMeaning;
  final String reversedMeaning;
  final String advice;
  final String esotericMeaning;
  final String archetype;
  final String element;
  final String astrologicalSign;
  final String hebrewLetter;
  final String pathOnTree;
  final bool isReversed;

  const TarotCard({
    required this.number,
    required this.name,
    required this.nameTr,
    required this.keywords,
    required this.keywordsTr,
    required this.uprightMeaning,
    required this.reversedMeaning,
    required this.advice,
    this.esotericMeaning = '',
    this.archetype = '',
    this.element = '',
    this.astrologicalSign = '',
    this.hebrewLetter = '',
    this.pathOnTree = '',
    this.isReversed = false,
  });

  TarotCard copyWith({bool? isReversed}) {
    return TarotCard(
      number: number,
      name: name,
      nameTr: nameTr,
      keywords: keywords,
      keywordsTr: keywordsTr,
      uprightMeaning: uprightMeaning,
      reversedMeaning: reversedMeaning,
      advice: advice,
      esotericMeaning: esotericMeaning,
      archetype: archetype,
      element: element,
      astrologicalSign: astrologicalSign,
      hebrewLetter: hebrewLetter,
      pathOnTree: pathOnTree,
      isReversed: isReversed ?? this.isReversed,
    );
  }

  String get currentMeaning => isReversed ? reversedMeaning : uprightMeaning;

  /// Büyük Arkana kartları
  static const List<TarotCard> majorArcana = [
    TarotCard(
      number: 0,
      name: 'The Fool',
      nameTr: 'Deli',
      keywords: 'New beginnings, innocence, spontaneity',
      keywordsTr: 'Yeni başlangıçlar, masumiyet, spontanlık',
      uprightMeaning:
          'Yeni bir yolculuğun eşiğindesin. Korkularını bırak ve bilinmeyene atıl. Evren seni destekliyor.',
      reversedMeaning:
          'Tedbirsizlik veya korku seni engelliyor. Düşünmeden atılma, ama çok da bekleme.',
      advice:
          'Kalbin sana ne söylüyorsa onu dinle. Bazen en büyük bilgelik, bilmediğini kabul etmektir.',
      esotericMeaning:
          'Deli, ruhun madde alemine iniş öncesi saf halidir - henüz hiçbir deneyimle kirletilmemiş, sonsuz potansiyel. Kabala\'da Keter\'den Hokmah\'a giden yolu temsil eder: Saf varoluştan ilk tezahüre geçiş. Sıfır sayısı hem hiçlik hem de sonsuzluktur; tüm sayıları içinde barındırır. Deli\'nin uçuruma yaklaşması korku değil, madde alemine doğum öncesi ruhun cesaretini simgeler. Beyaz köpek içgüdüsel bilgeliği, omzundaki bohça geçmiş yaşamlardan taşınan karmaları temsil eder.',
      archetype: 'İlahi Çocuk, Trickster, Saf Ruh',
      element: 'Hava',
      astrologicalSign: 'Uranüs',
      hebrewLetter: 'Aleph (א)',
      pathOnTree: 'Keter → Hokmah',
    ),
    TarotCard(
      number: 1,
      name: 'The Magician',
      nameTr: 'Büyücü',
      keywords: 'Manifestation, willpower, skill',
      keywordsTr: 'Manifestasyon, irade gücü, beceri',
      uprightMeaning:
          'Tüm araçlar elinde. İstediğini gerçekleştirme gücün var. Niyetini netleştir ve harekete geç.',
      reversedMeaning:
          'Potansiyelini harcıyor olabilirsin. Manipülasyona veya aldatmaya dikkat et.',
      advice:
          'Dört element - düşünce, duygu, eylem ve madde - hepsini dengede tut. Yaratıcı gücünü bilinçle kullan.',
      esotericMeaning:
          'Büyücü, "Yukarıda ne varsa aşağıda da o vardır" Hermetik ilkesinin cisimleşmiş halidir. Masasındaki dört araç - asa, kılıç, kupa ve pentakl - dört elementi ve Tetragrammaton\'un harflerini temsil eder. Bir eli göğe, diğeri yere işaret eder: İlahi enerjiyi kanalize eden bir kanal. Başının üstündeki sonsuzluk sembolü (∞) kozmik bilincin aktığını gösterir. Büyücü yaratmaz, var olanı dönüştürür - bu錬 kimyanın özüdür. Hermes Trismegistus\'un arketipi olarak tüm okült bilimlerin ustasıdır.',
      archetype: 'Hermes, Thoth, Şaman, Simyacı',
      element: 'Hava',
      astrologicalSign: 'Merkür',
      hebrewLetter: 'Beth (ב)',
      pathOnTree: 'Keter → Binah',
    ),
    TarotCard(
      number: 2,
      name: 'The High Priestess',
      nameTr: 'Başrahibe',
      keywords: 'Intuition, mystery, inner knowledge',
      keywordsTr: 'Sezgi, gizem, içsel bilgi',
      uprightMeaning:
          'Sezgilerine güven. Cevaplar içinde. Sessizlikte ve dinlemede büyük güç var.',
      reversedMeaning:
          'İç sesini bastırıyor olabilirsin. Sırlar veya gizli bilgiler ortaya çıkabilir.',
      advice:
          'Meditasyon ve içsel yolculuk zamanı. Rüyalarına ve sezgilerine dikkat et.',
      esotericMeaning:
          'Başrahibe, Isis\'in peçeli yüzüdür - görünenin ardındaki gizli hakikatin bekçisi. Siyah ve beyaz sütunlar (Boaz ve Jakin) Süleyman Tapınağı\'nın girişindeki düalizmi temsil eder. Arkasındaki perde, görünen ve görünmeyen alemleri ayırır; üzerindeki nar motifleri Persephone\'un yeraltı bilgeliğine işaret eder. Kucağındaki Tora rulosu içsel bilgiyi, hilal ay tahtı değişen ama ölümsüz dişil bilgeliği simgeler. O, Şekina\'dır - İlahi\'nin dişil yüzü, sessiz ama her şeyi bilen.',
      archetype: 'Isis, Persephone, Sophia, Ay Tanrıçası',
      element: 'Su',
      astrologicalSign: 'Ay',
      hebrewLetter: 'Gimel (ג)',
      pathOnTree: 'Keter → Tiferet',
    ),
    TarotCard(
      number: 3,
      name: 'The Empress',
      nameTr: 'İmparatoriçe',
      keywords: 'Abundance, fertility, nurturing',
      keywordsTr: 'Bolluk, verimlilik, besleyicilik',
      uprightMeaning:
          'Bolluk ve bereket enerjisi güçlü. Yaratıcılık ve doğurganlık döngüsündesin.',
      reversedMeaning:
          'Kendinle ilgilen. Başkalarına bakarken kendini ihmal etme. Yaratıcı tıkanıklık olabilir.',
      advice:
          'Doğayla bağlantı kur. Güzelliği takdir et. Kendine ve başkalarına şefkat göster.',
      esotericMeaning:
          'İmparatoriçe, Toprak Ana\'nın tezahürüdür - Gaia, Demeter, Venüs\'ün birleşimi. Başrahibe\'nin gizli bilgeliği onda somutlaşır ve dünyaya doğurur. Yıldızlı tacı göklerin kraliçesi olduğunu, buğday başakları ise bolluk ve hasatın koruyucusu olduğunu gösterir. Kalp şeklindeki kalkan üzerindeki Venüs sembolü, sevgi yoluyla yaratımı temsil eder. Akan nehir yaşam enerjisinin (prana, chi) sürekli akışını simgeler. O sadece doğuran değil, besleyen ve dönüştüren güçtür -錬 Binah Sefirası\'nın dünyevi yansıması.',
      archetype: 'Gaia, Demeter, Venüs, Büyük Ana',
      element: 'Toprak',
      astrologicalSign: 'Venüs',
      hebrewLetter: 'Daleth (ד)',
      pathOnTree: 'Hokmah → Binah',
    ),
    TarotCard(
      number: 4,
      name: 'The Emperor',
      nameTr: 'İmparator',
      keywords: 'Authority, structure, control',
      keywordsTr: 'Otorite, yapı, kontrol',
      uprightMeaning:
          'Liderlik ve yapı zamanı. Disiplin ve kararlılık başarıyı getirecek.',
      reversedMeaning:
          'Aşırı kontrol veya katılık. Esnekliğe ihtiyaç var. Otorite figürleriyle çatışma.',
      advice:
          'Güçlü sınırlar koy ama diktatör olma. Sorumluluk al, ama başkalarına da alan bırak.',
      esotericMeaning:
          'İmparator, kozmik düzenin dünyevi uygulayıcısıdır - İlahi Yasa\'nın madde alemindeki koruyucusu. Koç sembolleri Mars\'ın savaşçı enerjisini, taş taht değişmez iradeyi temsil eder. Dört sayısı stabilite ve maddi dünyanın temelini simgeler: dört element, dört yön, dört mevsim. Elindeki ankh yaşam üzerindeki hakimiyeti, küre dünyevi güçü temsil eder. O, Hokmah\'ın aktif, yönlendirici enerjisidir - kaos içinde düzen yaratan, sınırlar koyan ama bu sınırları korumak için güç kullanan. Zeus-Jüpiter arketipinin dünyevi yansımasıdır.',
      archetype: 'Zeus, Mars, Kral, Baba',
      element: 'Ateş',
      astrologicalSign: 'Koç',
      hebrewLetter: 'He (ה)',
      pathOnTree: 'Hokmah → Tiferet',
    ),
    TarotCard(
      number: 5,
      name: 'The Hierophant',
      nameTr: 'Başrahip',
      keywords: 'Tradition, conformity, spirituality',
      keywordsTr: 'Gelenek, uyum, maneviyat',
      uprightMeaning:
          'Geleneksel yollar ve kurumlar önemli. Bir öğretmen veya rehber ortaya çıkabilir.',
      reversedMeaning:
          'Gelenekleri sorgulama zamanı. Kendi spiritüel yolunu bul. Dogmatizmden uzak dur.',
      advice:
          'Bilgelik her yerde bulunabilir. Hem gelenekten öğren hem de kendi hakikatini ara.',
      esotericMeaning:
          'Başrahip, Eleusis\'in büyük rahibi, gizli öğretilerin meşru aktarıcısıdır. İki sütun arasında oturması onu iki dünya arasındaki köprü yapar - profan ile kutsal, bilinç ile bilinçaltı. Üç katlı tacı üç dünyayı (fiziksel, astral, ilahi), çapraz anahtarlar sırların kilidini açma yetkisini temsil eder. Önündeki iki mürit alma ve verme, aktif ve pasif öğrenmeyi simgeler. O, inisiyasyonun bekçisidir - ezoterik bilgiyi layık olana aktaran, gizemi koruyan. Başrahibe\'nin içsel bilgisini kurumsal forma döken güçtür.',
      archetype: 'Papa, Guru, Zarathustra, Chiron',
      element: 'Toprak',
      astrologicalSign: 'Boğa',
      hebrewLetter: 'Vav (ו)',
      pathOnTree: 'Hokmah → Hesed',
    ),
    TarotCard(
      number: 6,
      name: 'The Lovers',
      nameTr: 'Aşıklar',
      keywords: 'Love, harmony, choices',
      keywordsTr: 'Aşk, uyum, seçimler',
      uprightMeaning:
          'Önemli bir seçim veya birleşme. Aşk ve uyum enerjisi güçlü. Kalbin sesini dinle.',
      reversedMeaning:
          'İlişkilerde uyumsuzluk. Değerlerinle çelişen bir seçim. İç çatışma.',
      advice:
          'Gerçek aşk kendini sevmekle başlar. Seçimlerinde hem kalbini hem aklını dinle.',
      esotericMeaning:
          'Aşıklar kartı, simyadaki "Kutsal Evlilik" (Hieros Gamos) konseptini taşır - zıtların birleşmesi yoluyla bütünlüğe ulaşma. Adem ve Havva figürleri bilinç ve bilinçaltının, rasyonel ve sezgisel olanın birleşimini temsil eder. Melek Raphael şifa ve dengeyi simgeler; onun rehberliğinde iki yarım bütünleşir. Ağaç motifleri - bilgi ağacı ve yaşam ağacı - düşüşten önceki ve sonraki bilinci gösterir. Bu kart sadece romantik aşk değil, içsel erkil-dişil dengesinin (anima-animus) kurulmasıdır.',
      archetype: 'Adem ve Havva, Eros ve Psyche, Şiva ve Şakti',
      element: 'Hava',
      astrologicalSign: 'İkizler',
      hebrewLetter: 'Zayin (ז)',
      pathOnTree: 'Binah → Tiferet',
    ),
    TarotCard(
      number: 7,
      name: 'The Chariot',
      nameTr: 'Savaş Arabası',
      keywords: 'Determination, willpower, victory',
      keywordsTr: 'Kararlılık, irade gücü, zafer',
      uprightMeaning:
          'Zafer yakın. İrade gücün ve kararlılığın seni hedefe taşıyacak. Engelleri aşacaksın.',
      reversedMeaning:
          'Kontrol kaybı veya yön karmaşası. Zıt güçler seni çekiştiriyor.',
      advice:
          'Hedefine odaklan. İç çatışmalarını dengele. Zafere giden yolda sebat et.',
      esotericMeaning:
          'Savaş Arabası, ruhun madde üzerindeki zaferini temsil eder - İsrail\'in Mısır\'dan çıkışı, Platon\'un ruh arabasının ustaca yönetilmesi. Siyah ve beyaz sfenksler düşen ve yükselen güçleri, gizli ve açık olanı simgeler; dizginlerin olmayışı iradenin onları yönettiğini gösterir. Yıldızlı gölgelik kozmik korumanın, ay sembolleri bilinçaltının fethedilmesini temsil eder. Kabala\'da Merkaba\'dır - ilahi arabanın, mistik yükselişin sembolü. Savaşçının zırhı psişik korumayı, kadeh (Holy Grail) ruhani arayışı simgeler.',
      archetype: 'Fetih Tanrısı, Helios, Arjuna',
      element: 'Su',
      astrologicalSign: 'Yengeç',
      hebrewLetter: 'Chet (ח)',
      pathOnTree: 'Binah → Gevurah',
    ),
    TarotCard(
      number: 8,
      name: 'Strength',
      nameTr: 'Güç',
      keywords: 'Courage, compassion, inner strength',
      keywordsTr: 'Cesaret, merhamet, iç güç',
      uprightMeaning:
          'Gerçek güç şefkatte yatar. İçsel cesaretinle zorlukların üstesinden geleceksin.',
      reversedMeaning:
          'Özgüven eksikliği veya bastırılmış duygular. İç gücünü yeniden keşfet.',
      advice:
          'Vahşi doğanı inkar etme, onu sev ve evcilleştir. Yumuşaklık güçsüzlük değildir.',
      esotericMeaning:
          'Güç kartı, dişil bilgeliğin hayvansal doğayı şefkatle evcilleştirmesini gösterir - Jung\'un gölge ile entegrasyonu, Tantrik tradisyonda kundalini enerjisinin ustaca yönlendirilmesi. Kadının aslanı okşaması, alt chakraların (hayvansal dürtüler) üst merkezler tarafından aydınlatılmasını simgeler. Başındaki sonsuzluk sembolü Büyücü\'nün gücünün içselleşmiş halini, çiçek çelengi sevgi yoluyla dönüşümü temsil eder. Bu fiziksel güç değil, korku üzerindeki zaferdir - karanlığı inkâr etmek yerine sevgiyle kucaklamak. Sekiz sayısı sonsuzluğun, karmanın ve kozmik dengenin sembolüdür.',
      archetype: 'Cybele, Durga, Daniel',
      element: 'Ateş',
      astrologicalSign: 'Aslan',
      hebrewLetter: 'Teth (ט)',
      pathOnTree: 'Hesed → Gevurah',
    ),
    TarotCard(
      number: 9,
      name: 'The Hermit',
      nameTr: 'Ermiş',
      keywords: 'Soul searching, introspection, solitude',
      keywordsTr: 'Ruh arayışı, içe bakış, yalnızlık',
      uprightMeaning:
          'İçe dönme ve tefekkür zamanı. Kalabalıklardan uzaklaş, kendi ışığını bul.',
      reversedMeaning:
          'Aşırı izolasyon veya içe kapanma. Ya da tam tersi - yalnızlıktan kaçış.',
      advice:
          'Sessizlikte cevaplar var. Kendi rehberin ol ama tamamen yalnız kalma.',
      esotericMeaning:
          'Ermiş, ilahi bilgeliğin arayıcısıdır - dağ tepesindeki mürşit, zamanın ötesinde olan bilge. Fenerindeki altı köşeli yıldız Süleyman\'ın mührüdür: yukarı ve aşağı üçgenlerin birleşimi, makrokozmos ile mikrokozmos\'un aynalığı. Asası kundalini enerjisinin yükseldiği omurgayı, gri cüppesi dünyevi arzulardan arınmışlığı simgeler. Karanlıkta yol gösterici olması, kendi ışığını bulmuş olanın başkalarına da yol gösterebileceğini hatırlatır. Dokuz sayısı tamamlanmayı, bir döngünün sonunu ve içsel bilgeliği temsil eder.',
      archetype: 'Diogenes, Merlin, Kronos, Satürn',
      element: 'Toprak',
      astrologicalSign: 'Başak',
      hebrewLetter: 'Yod (י)',
      pathOnTree: 'Hesed → Tiferet',
    ),
    TarotCard(
      number: 10,
      name: 'Wheel of Fortune',
      nameTr: 'Kader Çarkı',
      keywords: 'Change, cycles, fate',
      keywordsTr: 'Değişim, döngüler, kader',
      uprightMeaning:
          'Büyük değişimler kapıda. Şans dönüyor. Döngünün yukarı evresi başlıyor.',
      reversedMeaning:
          'Kötü şans veya döngünün düşüş evresi. Bu da geçecek. Sabırlı ol.',
      advice:
          'Hayatın iniş çıkışları doğal. Tepeye çıktığında şükret, düştüğünde sabret.',
      esotericMeaning:
          'Kader Çarkı, evrenin döngüsel doğasını ve karma yasasını temsil eder. Çarkın dört köşesindeki figürler (insan, aslan, boğa, kartal) sabit burçları ve dört evangelisti simgeler - değişimin ortasındaki değişmez hakikati. Sfenks tepede oturur: bilgi ve gizem üzerinde hâkimiyet. Yılan Set-Typhon olarak iniş güçlerini, Anubis yükselişi temsil eder. Simyasal sembolleri (cıva, kükürt, tuz, su) dönüşüm sürecinin aşamalarını gösterir. TARO harfleri dört yönde döner: TORA (yasa), ROTA (çark), ORAT (konuşur), ATOR (Hathor-Isis). Bu kartın mesajı: "Bu da geçecek."',
      archetype: 'Fortuna, Moirai, Norns',
      element: 'Ateş',
      astrologicalSign: 'Jüpiter',
      hebrewLetter: 'Kaph (כ)',
      pathOnTree: 'Hesed → Netsah',
    ),
    TarotCard(
      number: 11,
      name: 'Justice',
      nameTr: 'Adalet',
      keywords: 'Fairness, truth, karma',
      keywordsTr: 'Hakkaniyet, hakikat, karma',
      uprightMeaning:
          'Adalet yerini bulacak. Dürüstlük ve hakikat önemli. Karma işliyor.',
      reversedMeaning:
          'Adaletsizlik veya dengesizlik. Sorumluluktan kaçma. Öz-aldatma.',
      advice: 'Eylemlerinin sonuçlarını kabul et. Dürüst ol - önce kendinle.',
      esotericMeaning:
          'Adalet, kozmik dengenin ve karma yasasının tecessümüdür - Mısırlıların Maat\'ı, kalbin tüyle tartılması. Terazi ruhun eylemlerini ölçer; kılıç hakikati tüm illüzyonlardan ayırır. Tahtın simetrisi ve kırmızı örtü maddi dünyanın (Mars enerjisi) dengelenmesi gerektiğini hatırlatır. On bir sayısı, on (tamamlanma) sonrası yeni bir döngünün başlangıcını, usta sayısını temsil eder. Bu kart "Ne ekersen onu biçersin" evrensel yasasının hatırlatıcısıdır. Adalet kör değildir - her şeyi görür ve dengeler.',
      archetype: 'Maat, Themis, Athena, Nemesis',
      element: 'Hava',
      astrologicalSign: 'Terazi',
      hebrewLetter: 'Lamed (ל)',
      pathOnTree: 'Gevurah → Tiferet',
    ),
    TarotCard(
      number: 12,
      name: 'The Hanged Man',
      nameTr: 'Asılan Adam',
      keywords: 'Suspension, letting go, new perspective',
      keywordsTr: 'Askıda kalma, bırakma, yeni bakış açısı',
      uprightMeaning:
          'Bekle ve teslim ol. Farklı bir açıdan bak. Fedakarlık gerekebilir.',
      reversedMeaning:
          'Gereksiz fedakarlık veya kurban rolü. Ya da teslimiyete direnç.',
      advice:
          'Bazen ilerlemenin yolu durmaktır. Perspektifini değiştir, cevap görünecek.',
      esotericMeaning:
          'Asılan Adam, Odin\'in Yggdrasil\'de dokuz gün asılarak runları keşfetmesi efsanesini yansıtır - bilgelik için gönüllü fedakarlık. Tek ayaktan asılı duruş ters bakış açısını, geleneksel değerlerin sorgulanmasını temsil eder. Başın etrafındaki hale aydınlanmanın bu durağan dönemde gerçekleştiğini gösterir. Tau haçına (T şeklinde) asılması İbrani alfabesinin son harfini, bir döngünün sonunu işaret eder. Bu kart egonun teslimiyetini, zamanın askıya alınmasını ve "yapmama" yoluyla "yapma"nın gücünü öğretir. Su elementinin pasif bilgeliğini taşır.',
      archetype: 'Odin, Prometheus, Hz. Petrus',
      element: 'Su',
      astrologicalSign: 'Neptün',
      hebrewLetter: 'Mem (מ)',
      pathOnTree: 'Gevurah → Hod',
    ),
    TarotCard(
      number: 13,
      name: 'Death',
      nameTr: 'Ölüm',
      keywords: 'Transformation, endings, change',
      keywordsTr: 'Dönüşüm, sonlanmalar, değişim',
      uprightMeaning:
          'Büyük bir dönüşüm. Bir şeyin sonu, yeninin başlangıcı. Direnmek acıyı uzatır.',
      reversedMeaning: 'Değişime direnç. Bırakamama. Durağanlık.',
      advice:
          'Ölüm yeniden doğuşun kapısıdır. Eskiyi bırak ki yeniye yer açılsın.',
      esotericMeaning:
          'Ölüm kartı, fiziksel ölümü değil, simyasal "nigredo" aşamasını - eski benliğin çözülmesini temsil eder. İskelet süvari (siyah zırh içinde olmadığına dikkat edin - çıplaklık, süslemesizlik) herkesin önünde eşit olduğu hakikati simgeler. Beyaz at saflığı, güller dönüşümü, yükselen güneş yeni doğuşu temsil eder. Ayaklar altındaki kral ve dilenci, ölümün herkesi eşitlediğini gösterir. On üç sayısı geleneksel olarak "uğursuz" kabul edilse de, ezoterik olarak dönüşüm ve yeniden yapılanmanın kutsal sayısıdır. Akrep burcunun kartı olarak en derin dönüşümü simgeler.',
      archetype: 'Thanatos, Hades, Kali, Osiris',
      element: 'Su',
      astrologicalSign: 'Akrep',
      hebrewLetter: 'Nun (נ)',
      pathOnTree: 'Tiferet → Netsah',
    ),
    TarotCard(
      number: 14,
      name: 'Temperance',
      nameTr: 'Denge',
      keywords: 'Balance, moderation, patience',
      keywordsTr: 'Denge, ılımlılık, sabır',
      uprightMeaning:
          'Denge ve uyum zamanı. Sabır ve ılımlılık başarı getirir. Şifa enerjisi güçlü.',
      reversedMeaning: 'Dengesizlik veya aşırılıklar. Sabırsızlık. Uyumsuzluk.',
      advice: 'Orta yolu bul. Zıtlıkları harmanlayarak altın senteze ulaş.',
      esotericMeaning:
          'Denge, simyacının Büyük Eser\'inin aşamalarından birini gösterir - zıtların birleşimi yoluyla altın (aydınlanma) elde etme. Melek bir ayağını suda (bilinçaltı, duygular), diğerini karada (bilinç, madde) tutar: iki dünya arasında denge. İki kupa arasında dökülen su, bilinç ile bilinçaltı arasındaki sürekli akışı, simyasal "solve et coagula" (çöz ve birleştir) ilkesini temsil eder. Arka plandaki yol illuminasyona giden patikadır; güneş tacı aydınlanmış bilinci simgeler. On dört sayısı yedi\'nin iki katı olarak çift spiritüel tamamlanmayı ifade eder.',
      archetype: 'Iris, Raphael, Simyacı',
      element: 'Ateş',
      astrologicalSign: 'Yay',
      hebrewLetter: 'Samekh (ס)',
      pathOnTree: 'Tiferet → Yesod',
    ),
    TarotCard(
      number: 15,
      name: 'The Devil',
      nameTr: 'Şeytan',
      keywords: 'Bondage, addiction, materialism',
      keywordsTr: 'Esaret, bağımlılık, maddecilik',
      uprightMeaning:
          'Bağımlılıkların ve korkuların seni esir alıyor. Gölge yönlerinle yüzleş.',
      reversedMeaning:
          'Zincirleri kırma zamanı. Özgürleşme başlıyor. Bağımlılıktan kurtulma.',
      advice:
          'Zincirlerini sen taktın, sen de çıkarabilirsin. Gölgenle dans et, ama onun kölesi olma.',
      esotericMeaning:
          'Şeytan, Jung\'un "gölge" kavramının mükemmel temsilidir - bastırılmış, inkâr edilen ama entegre edilmesi gereken yönlerimiz. Baphomet figürü zıtların birleşimini (erkek/dişi, insan/hayvan, göksel/yersel) gösterir, ancak burada bu birleşim bilinçsiz ve tutsak edicidir. Zincirlerin gevşek olması, tutsaklığın gönüllü olduğunu hatırlatır. Ters pentagram ruhun maddeye mahkum olduğunu, ateşli meşale kontrol altına alınmamış arzuyu simgeler. Aşıklar kartının karanlık aynası olarak, bu kart bizi gölgemizle yüzleşmeye, illüzyonları görmeye ve özgürleşmeye çağırır.',
      archetype: 'Baphomet, Pan, Gölge, Mefisto',
      element: 'Toprak',
      astrologicalSign: 'Oğlak',
      hebrewLetter: 'Ayin (ע)',
      pathOnTree: 'Tiferet → Hod',
    ),
    TarotCard(
      number: 16,
      name: 'The Tower',
      nameTr: 'Kule',
      keywords: 'Sudden change, revelation, upheaval',
      keywordsTr: 'Ani değişim, aydınlanma, altüst oluş',
      uprightMeaning:
          'Ani ve yıkıcı değişim. Çürük temeller çöküyor. Ama bu bir arınma.',
      reversedMeaning: 'Kaçınılan felaket veya değişime direnç. İç yıkım.',
      advice:
          'Bazen her şeyin yıkılması gerekir ki gerçek olan kalabilsin. Fırtınayı kabul et.',
      esotericMeaning:
          'Kule, Babil Kulesi mitinin ve ego\'nun yapay yapılarının yıkılışını simgeler - gerçek aydınlanma öncesi zorunlu çöküş. Yıldırım Tanrısal müdahaleyi, tacın düşmesi ego\'nun tahttan indirilmesini temsil eder. Yirmi iki düşen yod (İbrani harfi) Tanrısal enerjinin dünyaya akışını, kaostan yeni düzenin doğuşunu gösterir. Düşen figürler eski inançların, sahte güvenliklerin terkedilmesidir. Bu kart, Zen geleneğindeki "büyük şüphe" anına, simyadaki ani kırılmaya denk gelir. Korkulan ama gerekli olan uyanış deneyimidir.',
      archetype: 'Babil Kulesi, Şiva\'nın Dansı, Prometheus\'un Ateşi',
      element: 'Ateş',
      astrologicalSign: 'Mars',
      hebrewLetter: 'Pe (פ)',
      pathOnTree: 'Netsah → Hod',
    ),
    TarotCard(
      number: 17,
      name: 'The Star',
      nameTr: 'Yıldız',
      keywords: 'Hope, inspiration, serenity',
      keywordsTr: 'Umut, ilham, huzur',
      uprightMeaning:
          'Umut ve ilham zamanı. Şifa ve yenilenme. Evren seninle konuşuyor.',
      reversedMeaning:
          'Umutsuzluk veya inanç kaybı. Kozmik bağlantının kesilmesi.',
      advice:
          'En karanlık geceden sonra bile yıldızlar parlar. Umudunu kaybetme.',
      esotericMeaning:
          'Yıldız, Kule\'nin yıkımından sonra gelen huzur ve şifadır - karanlık gecenin ardından gelen şafak. Çıplak kadın saf ruhun ifadesidir, utanç ve maske olmadan var oluş. Sekiz kollu yıldız Venüs\'ün sembolü, sevgi ve güzelliğin kozmik enerjisi; yedi küçük yıldız yedi chakra ve yedi gezegeni temsil eder. İki kaptaki su bilinç (kara) ve bilinçaltına (suya) dökülen yaşam enerjisidir. Kuş arkada Thoth\'un ibisi, ilahi mesajcıdır. On yedi sayısı (1+7=8) sonsuzluk ve kozmik denge ile bağlantılıdır. Bu kart "sınavdan geçtin, şimdi hediyeler geliyor" der.',
      archetype: 'Isis, Nuit, Aquarius, Yıldız Tanrıçası',
      element: 'Hava',
      astrologicalSign: 'Kova',
      hebrewLetter: 'Tzaddi (צ)',
      pathOnTree: 'Netsah → Yesod',
    ),
    TarotCard(
      number: 18,
      name: 'The Moon',
      nameTr: 'Ay',
      keywords: 'Illusion, fear, subconscious',
      keywordsTr: 'İllüzyon, korku, bilinçaltı',
      uprightMeaning:
          'Bilinçaltı yüzeye çıkıyor. Yanılsamalar ve korkularla yüzleş. Rüyalara dikkat.',
      reversedMeaning:
          'Korkuların üstesinden gelme. Yanılsamalardan uyanma. Netlik.',
      advice: 'Gölgeler gerçek değil. Karanlıkta yürürken sezgine güven.',
      esotericMeaning:
          'Ay, bilinçaltının labirentlerine inişi temsil eder - şafaktan önceki en karanlık saat. Havlayan köpek ve ulayan kurt evcilleştirilmiş ve vahşi içgüdüleri, su bilinçaltının derinliklerini simgeler. Sudan çıkan istakoz/yengeç primitif bilinci, evrimsel geçmişimizi temsil eder. İki kule geçilmesi gereken eşiği, yol ise karanlıkta bile devam eden inisiyasyon yolculuğunu gösterir. Damlaları toplayan ay, bilinçaltından bilinçe yükselen içerikleri simgeler. Bu kart rüyaların, vizyonların ve psişik algının kapısıdır; yanılsama ile sezgiyi ayırt etmeyi öğretir.',
      archetype: 'Hekate, Selene, Bilinçaltı, Rüya Zamanı',
      element: 'Su',
      astrologicalSign: 'Balık',
      hebrewLetter: 'Qoph (ק)',
      pathOnTree: 'Netsah → Malkut',
    ),
    TarotCard(
      number: 19,
      name: 'The Sun',
      nameTr: 'Güneş',
      keywords: 'Joy, success, vitality',
      keywordsTr: 'Neşe, başarı, canlılık',
      uprightMeaning:
          'Işık, neşe ve başarı zamanı. Her şey aydınlanıyor. Kutlama!',
      reversedMeaning:
          'Geçici gölgeler veya geciken başarı. İç çocuğunla bağlantını yenile.',
      advice: 'Işığını parlatmaktan korkma. Neşen bulaşıcı. Hayatı kutla!',
      esotericMeaning:
          'Güneş, Büyük Eser\'in (Magnum Opus) tamamlanmasına yaklaşmayı - simyasal altına dönüşümü temsil eder. Çıplak çocuk yeniden doğmuş bilinci, masumiyete dönüşü simgeler; beyaz at saflaştırılmış içgüdüleri ve zaferi. Ayçiçekleri (her biri bir Sefirah\'ı temsil eder) güneşe dönük olarak ilahi ışığa yönelimi gösterir. Duvar bilinç ile bilinçaltı arasındaki son bariyerin aşılmasını işaret eder. On dokuz sayısı (1+9=10=1) yeni bir döngünün başlangıcını, birliğe dönüşü temsil eder. Bu kart Güneş tanrısı Ra, Apollo, Helios\'un enerjisini taşır - aydınlanma, netlik ve yaşam sevinci.',
      archetype: 'Ra, Apollo, Helios, İç Çocuk',
      element: 'Ateş',
      astrologicalSign: 'Güneş',
      hebrewLetter: 'Resh (ר)',
      pathOnTree: 'Hod → Yesod',
    ),
    TarotCard(
      number: 20,
      name: 'Judgement',
      nameTr: 'Mahkeme',
      keywords: 'Reflection, reckoning, awakening',
      keywordsTr: 'Yansıma, hesap, uyanış',
      uprightMeaning:
          'Büyük bir uyanış ve çağrı. Geçmişle hesaplaşma. Yeniden doğuş.',
      reversedMeaning: 'Öz-şüphe veya geçmişe takılma. Çağrıyı duymamak.',
      advice:
          'Geçmişini kabul et, bugününü yaşa, geleceğini yarat. Çağrına cevap ver.',
      esotericMeaning:
          'Mahkeme, ruhun son uyanışını ve diriliş çağrısını temsil eder - Hristiyanlıktaki Son Yargı, Hinduizm\'deki Mahapralaya\'dan sonra yeni yaratılış. Gabriel\'in borusu kundalini enerjisinin tam uyanışı, üçüncü gözün açılmasıdır. Mezarlardan kalkan figürler (aile olarak: baba-ana-çocuk) tüm yaşamların, tüm yönlerin entegrasyonunu simgeler. Dağlar bilinç düzeylerini, bayrak yeni çağın başlangıcını temsil eder. Bu kart "Uyan! Zamanı geldi!" der. İç sesin çağrısına cevap verme, yüksek benliğe yükselme zamanıdır.',
      archetype: 'Gabriel, Osiris\'in Dirilişi, Phoenix',
      element: 'Ateş',
      astrologicalSign: 'Plüton',
      hebrewLetter: 'Shin (ש)',
      pathOnTree: 'Hod → Malkut',
    ),
    TarotCard(
      number: 21,
      name: 'The World',
      nameTr: 'Dünya',
      keywords: 'Completion, integration, accomplishment',
      keywordsTr: 'Tamamlanma, bütünleşme, başarı',
      uprightMeaning:
          'Döngü tamamlanıyor. Başarı ve bütünlük. Yeni bir seviyeye geçiş.',
      reversedMeaning:
          'Eksik kalan işler veya tamamlanmamış döngüler. Bir adım daha gerekiyor.',
      advice:
          'Her son yeni bir başlangıçtır. Başardıklarını kutla ve bir sonraki döngüye hazırlan.',
      esotericMeaning:
          'Dünya, Deli\'nin yolculuğunun tamamlanmasıdır - ouroboros yılanı gibi son ve başlangıcın birleşimi. Çelenk içindeki dansçı kozmik dansı, yaratılışın ritüel hareketini simgeler; iki asa dualiteyi, sonsuz döngüyü temsil eder. Dört köşedeki figürler (aslan, boğa, kartal, insan) Hayat Ağacı\'nın dört dünyasını, dört elementi, sabit burçları ve evangelistleri temsil eder. Çelengin yumurta şekli kozmik yumurtayı, sonsuz potansiyeli simgeler. Yirmi bir sayısı (3x7) üçlü yedili mükemmelliği ifade eder. Bu kart "Döngü tamamlandı, şimdi daha yüksek bir spiral başlıyor" der - Nirvana değil, spiritüel evrim.',
      archetype: 'Anima Mundi, Sophia, Kozmik Dansçı, Shiva Nataraja',
      element: 'Toprak',
      astrologicalSign: 'Satürn',
      hebrewLetter: 'Tav (ת)',
      pathOnTree: 'Yesod → Malkut',
    ),
  ];
}

/// Üç kart açılımı
class ThreeCardSpread {
  final TarotCard past;
  final TarotCard present;
  final TarotCard future;

  ThreeCardSpread({
    required this.past,
    required this.present,
    required this.future,
  });

  String get interpretation {
    return '''
**Geçmiş (${past.nameTr}${past.isReversed ? ' - Ters' : ''}):**
${past.currentMeaning}

**Şimdi (${present.nameTr}${present.isReversed ? ' - Ters' : ''}):**
${present.currentMeaning}

**Gelecek (${future.nameTr}${future.isReversed ? ' - Ters' : ''}):**
${future.currentMeaning}

**Genel Yorum:**
Geçmişte ${past.keywordsTr.split(',').first.trim().toLowerCase()} enerjisi etkindİ.
Şu an ${present.keywordsTr.split(',').first.trim().toLowerCase()} ile çalışıyorsun.
Gelecekte ${future.keywordsTr.split(',').first.trim().toLowerCase()} seni bekliyor.
''';
  }
}

/// Kelt Haçı açılımı
class CelticCrossSpread {
  final TarotCard significator; // Mevcut durum
  final TarotCard crossing; // Zorluk/engel
  final TarotCard foundation; // Temel/geçmiş
  final TarotCard recentPast; // Yakın geçmiş
  final TarotCard crown; // Olası sonuç
  final TarotCard nearFuture; // Yakın gelecek
  final TarotCard selfImage; // Kendin hakkındaki görüşün
  final TarotCard environment; // Çevre/dış etkiler
  final TarotCard hopesAndFears; // Umutlar ve korkular
  final TarotCard outcome; // Sonuç

  CelticCrossSpread({
    required this.significator,
    required this.crossing,
    required this.foundation,
    required this.recentPast,
    required this.crown,
    required this.nearFuture,
    required this.selfImage,
    required this.environment,
    required this.hopesAndFears,
    required this.outcome,
  });
}

/// Aşk açılımı
class LoveSpread {
  final TarotCard youCard;
  final TarotCard partnerCard;
  final TarotCard relationshipCard;
  final TarotCard challengeCard;
  final TarotCard adviceCard;

  LoveSpread({
    required this.youCard,
    required this.partnerCard,
    required this.relationshipCard,
    required this.challengeCard,
    required this.adviceCard,
  });

  String get interpretation {
    return '''
**Sen (${youCard.nameTr}${youCard.isReversed ? ' - Ters' : ''}):**
${youCard.currentMeaning}

**Partner/Potansiyel Partner (${partnerCard.nameTr}${partnerCard.isReversed ? ' - Ters' : ''}):**
${partnerCard.currentMeaning}

**İlişkinin Enerjisi (${relationshipCard.nameTr}${relationshipCard.isReversed ? ' - Ters' : ''}):**
${relationshipCard.currentMeaning}

**Zorluk (${challengeCard.nameTr}${challengeCard.isReversed ? ' - Ters' : ''}):**
${challengeCard.currentMeaning}

**Tavsiye (${adviceCard.nameTr}${adviceCard.isReversed ? ' - Ters' : ''}):**
${adviceCard.advice}
''';
  }
}

/// Evet/Hayır okuma sonucu
class YesNoReading {
  final TarotCard card;
  final String answer;
  final String explanation;

  YesNoReading({
    required this.card,
    required this.answer,
    required this.explanation,
  });
}
