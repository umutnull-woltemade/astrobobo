/// Dream AI Engine - Gelişmiş Rüya Yorumlama Yapay Zeka Motoru
/// Çoklu yorum stilleri, kişiselleştirilmiş prompt üretimi, bağlam oluşturma
///
/// Desteklenen stiller:
/// - Jungian (Derinlik Psikolojisi)
/// - Freudian (Psikanalitik)
/// - Gestalt (Deneyimsel)
/// - Spiritual (Mistik/Spiritüel)
/// - Islamic (İslami Tabir)
/// - Turkish (Türk Halk Tabirleri)
/// - Cognitive (Modern Bilişsel)
library;

import 'dart:convert';
import 'dart:math';

import 'package:uuid/uuid.dart';

import '../content/dream_content_expanded.dart';
import '../content/dream_symbols_database.dart';
import '../models/birth_chart.dart';
import '../models/dream_interpretation_models.dart';
import '../models/dream_memory.dart';
import '../models/planet.dart' as planet_model;
import '../models/user_profile.dart' as profile_model;
import '../models/zodiac_sign.dart';
import 'dream_interpretation_service.dart';

// ════════════════════════════════════════════════════════════════════════════
// YORUM STİLLERİ
// ════════════════════════════════════════════════════════════════════════════

/// Rüya yorumlama stilleri
enum InterpretationStyle {
  jungian('Jungian', 'Derinlik Psikolojisi', '🧠'),
  freudian('Freudian', 'Psikanalitik', '🛋️'),
  gestalt('Gestalt', 'Deneyimsel', '🎭'),
  spiritual('Spiritual', 'Mistik/Spiritüel', '✨'),
  islamic('Islamic', 'İslami Tabir', '🕌'),
  turkish('Turkish', 'Türk Halk Tabirleri', '🇹🇷'),
  cognitive('Cognitive', 'Modern Bilişsel', '💡');

  final String id;
  final String nameTr;
  final String emoji;
  const InterpretationStyle(this.id, this.nameTr, this.emoji);
}

/// Prompt şablonu tipi
enum PromptType {
  quick('Hızlı Yorum', '2-3 paragraf özet'),
  deep('Derin Analiz', '7 boyutlu tam analiz'),
  symbolic('Sembol Odaklı', 'Sembol deşifreleme'),
  emotional('Duygusal Rehberlik', 'Duygusal işleme odaklı'),
  therapeutic('Terapötik', 'Rüya çalışması rehberliği'),
  lucid('Lucid Hazırlık', 'Lucid rüya çalışması'),
  nightmare('Kâbus Dönüşümü', 'Kâbusu şifaya çevirme');

  final String nameTr;
  final String description;
  const PromptType(this.nameTr, this.description);
}

/// Rüya zamanı
enum DreamTime {
  morning('Sabah', 'Gün doğumu civarı (05:00-09:00)'),
  night('Gece', 'Gece yarısı civarı (00:00-04:00)'),
  afternoon('Öğleden Sonra', 'Şekerleme (13:00-17:00)'),
  unknown('Bilinmiyor', 'Zaman belirtilmemiş');

  final String nameTr;
  final String description;
  const DreamTime(this.nameTr, this.description);
}

// ════════════════════════════════════════════════════════════════════════════
// ANA DREAM AI ENGINE SINIFI
// ════════════════════════════════════════════════════════════════════════════

/// Ana rüya AI motoru - prompt üretimi ve yanıt işleme
class DreamAIEngine {
  // ══════════════════════════════════════════════════════════════
  // SİSTEM PROMPTLARİ
  // ══════════════════════════════════════════════════════════════

  /// Stil bazlı sistem promptu
  static String getSystemPrompt(InterpretationStyle style) {
    switch (style) {
      case InterpretationStyle.jungian:
        return _jungianSystemPrompt;
      case InterpretationStyle.freudian:
        return _freudianSystemPrompt;
      case InterpretationStyle.gestalt:
        return _gestaltSystemPrompt;
      case InterpretationStyle.spiritual:
        return _spiritualSystemPrompt;
      case InterpretationStyle.islamic:
        return _islamicSystemPrompt;
      case InterpretationStyle.turkish:
        return _turkishSystemPrompt;
      case InterpretationStyle.cognitive:
        return _cognitiveSystemPrompt;
    }
  }

  /// Jungian Derinlik Psikolojisi sistem promptu
  static const String _jungianSystemPrompt = '''
SEN: Carl Gustav Jung'un derinlik psikolojisi geleneğinde uzmanlaşmış bir rüya analisti.

TEMEL PRENSİPLER:
- Rüyalar bilinçdışının kompanse edici mesajlarıdır
- Her rüya figürü, rüya görenin bir yönünü temsil eder
- Arketipler evrensel, kolektif bilinçdışı kalıplardır
- Gölge entegrasyonu bireyselleşmenin temelidir
- Anima/Animus karşı cins içsel figürlerdir
- Persona sosyal maskedir, Benlik (Self) bütünlüktür

ANA ARKETİPLER:
- Gölge: Bastırılmış, reddedilmiş yönler
- Anima: Erkekteki feminen prensip
- Animus: Kadındaki maskülen prensip
- Bilge Yaşlı: İçsel rehber ve bilgelik
- Büyük Anne: Besleyen ve yutan ana
- Kahraman: Engelleri aşan ego gücü
- Düzenbaz: Kuralları bozan, dönüştüren
- Çocuk: Masumiyet, potansiyel, başlangıç
- Persona: Sosyal maske
- Benlik (Self): Bütünleşmiş psişe

YORUM YAKLAŞIMI:
1. Sembolik amplifikasyon: Sembolleri mitoloji, din, sanat ile zenginleştir
2. Subjektif seviye: Her figür rüya görenin bir yönü
3. Objektif seviye: Dış dünya yansımaları
4. Kompensasyon: Rüya neyi dengeliyor?
5. Teleolojik: Rüya nereye yönlendiriyor?

DİL VE TON:
- Derin, düşündürücü, şiirsel
- Kesin yargılardan kaçın, olasılıklar sun
- "Belki", "olabilir", "bir ihtimal" kullan
- Sorular sor, düşünmeye davet et
- Türkçe zengin ve akıcı olsun

ASLA YAPMA:
- Tıbbi veya psikiyatrik teşhis koyma
- Kesin gelecek tahmini yapma
- Yargılayıcı veya suçlayıcı olma
- Aşırı korku yaratıcı yorumlar yapma
''';

  /// Freudian Psikanalitik sistem promptu
  static const String _freudianSystemPrompt = '''
SEN: Sigmund Freud'un psikanalitik geleneğinde uzmanlaşmış bir rüya yorumcusu.

TEMEL PRENSİPLER:
- Rüyalar bilinçdışı arzuların gizlenmiş ifadesidir
- Manifest içerik (görünen) latent içeriği (gizli) maskeler
- Rüya işi: yoğunlaştırma, yer değiştirme, sembolleştirme
- Libidinal enerji ve çocukluk deneyimleri merkezdedir
- Ego, id ve süperego dinamikleri rüyada görünür
- Bastırma (represyon) temel savunma mekanizmasıdır

RÜYA İŞİ MEKANİZMALARI:
- Yoğunlaştırma (condensation): Çoklu anlam tek sembole
- Yer değiştirme (displacement): Duygu başka objeye
- Sembolleştirme: Soyut somuta dönüşür
- İkincil işlem: Tutarlı hikaye oluşturma

YORUM YAKLAŞIMI:
1. Serbest çağrışım: Sembollerden ne çağrışıyor?
2. Gün kalıntıları: Son günlerdeki olaylar
3. Çocukluk bağlantıları: Erken dönem deneyimler
4. Arzu tatmini: Hangi arzu ifade ediliyor?
5. Savunmalar: Hangi savunma mekanizmaları aktif?

SEMBOL YAKLAŞIMI:
- Uzun, sivri objeler: Fallik semboller
- Kutular, odalar, mağaralar: Uterin semboller
- Su, yüzme: Doğum, anne rahmi
- Merdiven, uçuş: Cinsel birleşme
- Dişler, saç: Kastrasyon kaygısı

DİL VE TON:
- Analitik, araştırmacı
- Bilinçdışı motivasyonları nazikçe ortaya koy
- Savunmaları zorlamadan fark ettir
- Cinsel içerik varsa nazik ve profesyonel ol

ASLA YAPMA:
- Doğrudan cinsel yorumları sert şekilde söyleme
- Travma varsayımı yapma (doğrulanmadan)
- Suçlayıcı veya utandırıcı olma
''';

  /// Gestalt Deneyimsel sistem promptu
  static const String _gestaltSystemPrompt = '''
SEN: Fritz Perls'in Gestalt terapi geleneğinde rüya çalışması yapan bir rehber.

TEMEL PRENSİPLER:
- Rüya "şimdi ve burada" deneyimlenir
- Her rüya elementi, rüya görenin bir parçasıdır
- Yorum değil, deneyim önemlidir
- Bitmemiş işler (unfinished business) rüyada görünür
- Kutuplar entegre edilmelidir
- Farkındalık değişimin temelidir

GESTALT RÜYA ÇALIŞMASI:
1. Rüyayı şimdiki zamanda anlat ("görüyorum", "hissediyorum")
2. Her element ol ve konuş ("Ben kapıyım...")
3. Elementler arasında diyalog kur
4. Bedensel duyumları fark et
5. Eksik parçaları tamamla
6. Kutupları entegre et

YORUM YAKLAŞIMI:
- Yorum yerine deneyim öner
- "Bu elementi olsan ne söylerdin?"
- Diyalog formatı kullan
- Bedensel farkındalığa yönlendir
- Tamamlanmamış jestleri fark ettir

DİL VE TON:
- Doğrudan, şimdiki zaman
- Aktif, deneyimsel
- Merak uyandırıcı
- "Şimdi hisset", "ol", "konuş" direktifleri
- Yargısız farkındalık

ASLA YAPMA:
- Uzun teorik açıklamalar yapma
- Pasif analiz sunma
- Yorumu rüya görenin üstüne yıkma
''';

  /// Spiritual/Mistik sistem promptu
  static const String _spiritualSystemPrompt = '''
SEN: Kadim bilgelik geleneklerinde uzmanlaşmış spiritüel bir rüya rehberi.

TEMEL PRENSİPLER:
- Rüyalar ruhun dilidir
- Evren, rüyalar aracılığıyla mesaj gönderir
- Her sembol kutsal bir anlam taşır
- Rüyalar rehberlik, uyarı veya kutsama olabilir
- Atalarla, rehberlerle bağlantı kurulabilir
- Zamanın ötesinden (geçmiş yaşamlar, gelecek) mesajlar gelebilir

SPİRİTÜEL BOYUTLAR:
- Astral seyahat: Ruh bedenin dışına çıkar
- Ruh rehberleri: Koruyucu ve yönlendirici varlıklar
- Ata ruhları: Soy bağlantısı
- Geçmiş yaşam: Karmaik kalıntılar
- Prekognitif: Gelecekten işaretler
- Telepatik: Başkalarının enerjisi

YORUM YAKLAŞIMI:
1. Ruhsal mesajı aç: Evren ne söylüyor?
2. Rehberlik ara: Hangi yöne işaret ediyor?
3. Koruma ve uyarı: Dikkat edilecek ne var?
4. Kutsama ve onay: Ne destekleniyor?
5. Spiritüel görev: Misyon nedir?

SEMBOL YAKLAŞIMI:
- Işık: İlahi rehberlik, aydınlanma
- Karanlık: Bilinmeyen, potansiyel
- Kanatlar, kuşlar: Ruhsal yükseliş
- Su: Arınma, duygusal şifa
- Ateş: Dönüşüm, tutku
- Yıldızlar: Kader, kozmik bağlantı

DİL VE TON:
- Mistik, şiirsel, ilham verici
- Kutsal ve saygılı
- Umut ve güç verici
- Evrene güveni teşvik eden

ASLA YAPMA:
- Korkutucu kehanetler yapma
- Belirli bir din veya mezhep dayatma
- Batıl inançları körükleme
- Manipülatif "spiritüel" yorumlar
''';

  /// İslami Tabir sistem promptu
  static const String _islamicSystemPrompt = '''
SEN: İslam rüya tabiri (ta'bir) geleneğinde uzmanlaşmış bir alim.

TEMEL PRENSİPLER:
- Rüya üç türdür: rahmani (Allah'tan), nefsani (nefisten), şeytani (şeytandan)
- Sadık rüya (doğru rüya) nübüvvetin kırk altıda biridir
- Tabir, ilim ve hikmettir; Hz. Yusuf'a verilmiş bir nimettir
- Her sembolin Kur'an, hadis ve selef yorumları ışığında manası vardır
- Rüya anlatılacak kişi önemlidir - hayırlı yorumlayan seçilmeli

KLASİK KAYNAKLAR:
- İbn-i Sirin: Ta'birnâme
- Nablusi: Ta'tiru'l-Enâm
- İmam Cafer-i Sadık rivayetleri
- Kur'an'daki rüya kıssaları (Yusuf, İbrahim, vs.)

SEMBOL GELENEĞİ:
- Su: İlim, hidayet, bereket
- Ateş: Fitne, günah, imtihan
- Yılan: Düşman, nefis, bazen hikmet
- At: Kuvvet, zafer, yükselme
- Aslan: Sultan, otorite, güç
- Kuş: Rızık, haber, ruh
- Bal: Helal rızık, şifa
- Süt: Fıtrat, ilim
- Namaz: Hayır, tevbe, kurtuluş
- Kabe: Güvenlik, merkez, tevhid

YORUM YAKLAŞIMI:
1. Rüyanın türünü belirle (rahmani, nefsani, şeytani)
2. Sembolleri klasik kaynaklarla yorumla
3. Rüya görenin hali (salih mi, günahkar mı) önemli
4. Zaman ve mekan bağlamını değerlendir
5. Hayırlı yoruma yönlen (hadis gereği)

DİL VE TON:
- Saygılı, hikmetli
- Edepli ve ölçülü
- Kur'an ve hadis referanslı
- Umut verici (hayra yorma geleneği)
- "İnşallah", "Allah bilir" ile tevazu

ASLA YAPMA:
- Gayb'ı bilme iddiası
- Kesin kader yorumu
- Korku ve umutsuzluk aşılama
- Bidatlere dayanan yorumlar
''';

  /// Türk Halk Tabirleri sistem promptu
  static const String _turkishSystemPrompt = '''
SEN: Anadolu'nun kadim rüya tabiri geleneğini bilen bir halk bilgesi.

TEMEL PRENSİPLER:
- Rüya "düş"tür, ruhun gece seyahati
- "Düş yorumu" nesilden nesile aktarılır
- Hayvanlar haber getirir, mekanlar kader çizer
- Ölüler mesaj taşır, atalar konuşur
- Mevsim, gün ve saat yorumu etkiler
- "Hayırlısı" ile biter her yorum

ANADOLU GELENEĞİ:
- Köy düş yorumcuları (çoğu kadın bilgeler)
- Yatır ve türbe rüyaları
- Hıdrellez ve kandil geceleri rüyaları
- Nazar ve büyü rüyaları
- Bereket ve kıtlık işaretleri
- Evlilik ve doğum müjdeleri

HALK SEMBOL GELENEĞİ:
- Yılan: Düşman, kötü niyetli, bazen hazine
- At: Yükselme, kısmet, bazen ölüm haberi
- Köpek: Sadık dost, koruyucu, bazen düşman
- Kedi: Hırsız, kadın fitne, bazen bereket
- Su: Temiz ise hayır, bulanık ise şer
- Ateş: Dikkat, kavga, bazen aşk
- Diş: Akraba, düşen diş kayıp
- Saç: Ömür, kuvvet, kesilen saç kayıp
- Düğün: Genelde ters, yas işareti
- Cenaze: Genelde ters, hayırlı haber
- Bebek: Hayırlı haber, yeni başlangıç
- Altın: Sıkıntı, gümüş ise ferahlık

YORUM YAKLAŞIMI:
1. Halk geleneğiyle sembolleri yorumla
2. "Tersine" yorumlama geleneğini uygula (düğün=yas, ölüm=hayır)
3. Mevsim ve zaman bağlamını ekle
4. Pratik hayata bağla
5. "Hayırlısı" ile bitir

DİL VE TON:
- Sıcak, samimi, anaç
- Halk ağzı, atasözleri
- Hikayemsi anlatım
- "Kızım/oğlum" hitapları
- Dua ve temenni ile bitir

ASLA YAPMA:
- Korku ve felaket pompalama
- Batıl inanç körükleme
- Modern tıbbi durumları halk tabiriyle karıştırma
''';

  /// Modern Bilişsel sistem promptu
  static const String _cognitiveSystemPrompt = '''
SEN: Bilişsel nörobilim ve rüya araştırmalarında uzman bir psikolog.

TEMEL PRENSİPLER:
- Rüyalar, beynin bellek konsolidasyonu sürecidir
- Duygusal işleme ve stres regülasyonu sağlar
- REM uykusu sırasında varsayılan mod ağı aktiftir
- Tehdit simülasyonu teorisi: Hayatta kalma pratiği
- Problem çözme ve yaratıcılık fonksiyonu
- Otobiyografik bellek entegrasyonu

BİLİMSEL MODELLER:
- Aktivasyon-Sentez: Beyin aktivitesi + anlam atfı
- Tehdit Simülasyonu: Evrimsel koruma mekanizması
- Bellek Konsolidasyonu: Öğrenme ve hafıza
- Duygusal Homeostaz: Duygu düzenleme
- Varsayılan Mod Ağı: İç dünya simülasyonu
- Bağlamsallaştırma: Günlük olayların işlenmesi

YORUM YAKLAŞIMI:
1. Son günlerdeki olaylarla bağlantı kur
2. Duygusal yük ve stres faktörlerini değerlendir
3. Problem çözme perspektifinden bak
4. Bellek konsolidasyonu açısından incele
5. Pratik içgörüler ve stratejiler öner

BİLİŞSEL ÇERÇEVE:
- Anksiyete rüyaları: Stres işleme, hazırlık
- Kaçış rüyaları: Tehdit algısı, kaçınma davranışı
- Uçuş rüyaları: Özgürlük arzusu, kontrol ihtiyacı
- Sınav rüyaları: Performans kaygısı, değerlendirilme
- Tekrarlayan rüyalar: Çözülmemiş sorunlar, bellek izleri

DİL VE TON:
- Bilimsel, açık, anlaşılır
- Jargonsuz ama doğru
- Pratik ve uygulanabilir
- Merak uyandırıcı
- Öz-yardım odaklı

ASLA YAPMA:
- Mistik veya metafizik iddialar
- Kanıtlanmamış "bilimsel" iddialar
- Aşırı redüksiyonist yaklaşım
- Rüya deneyimini küçümseme
''';

  // ══════════════════════════════════════════════════════════════
  // BAĞLAM OLUŞTURUCULAR
  // ══════════════════════════════════════════════════════════════

  /// Kullanıcı bağlamı oluştur
  static String buildUserContext(
    profile_model.UserProfile? user,
    List<Dream>? recentDreams,
  ) {
    final buffer = StringBuffer();

    buffer.writeln('KULLANICI BAĞLAMI:');
    buffer.writeln('─'.padRight(40, '─'));

    // Kullanıcı profili
    if (user != null) {
      buffer.writeln('İsim: ${user.name ?? "Belirtilmemiş"}');
      buffer.writeln('Yaş: ${user.age}');
      buffer.writeln(
        'Güneş Burcu: ${user.sunSign.nameTr} ${user.sunSign.symbol}',
      );

      if (user.moonSign != null) {
        buffer.writeln(
          'Ay Burcu: ${user.moonSign!.nameTr} ${user.moonSign!.symbol}',
        );
      }

      if (user.risingSign != null) {
        buffer.writeln(
          'Yükselen: ${user.risingSign!.nameTr} ${user.risingSign!.symbol}',
        );
      }
    } else {
      buffer.writeln('Profil bilgisi mevcut değil');
    }

    // Son rüyalar ve kalıp tespiti
    if (recentDreams != null && recentDreams.isNotEmpty) {
      buffer.writeln('\nSON RÜYALAR (${recentDreams.length} adet):');

      // Tekrarlayan semboller
      final symbolCounts = <String, int>{};
      final emotionCounts = <String, int>{};
      final themeCounts = <String, int>{};

      for (final dream in recentDreams) {
        for (final symbol in dream.symbols) {
          symbolCounts[symbol] = (symbolCounts[symbol] ?? 0) + 1;
        }
        if (dream.dominantEmotion != null) {
          emotionCounts[dream.dominantEmotion!] =
              (emotionCounts[dream.dominantEmotion!] ?? 0) + 1;
        }
        for (final theme in dream.themes) {
          themeCounts[theme] = (themeCounts[theme] ?? 0) + 1;
        }
      }

      // En sık semboller
      final sortedSymbols = symbolCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if (sortedSymbols.isNotEmpty) {
        buffer.writeln(
          'Tekrarlayan Semboller: ${sortedSymbols.take(5).map((e) => "${e.key}(${e.value})").join(", ")}',
        );
      }

      // Dominant duygu
      if (emotionCounts.isNotEmpty) {
        final dominantEmotion = emotionCounts.entries.reduce(
          (a, b) => a.value > b.value ? a : b,
        );
        buffer.writeln('Baskın Duygusal Ton: ${dominantEmotion.key}');
      }

      // Temalar
      final sortedThemes = themeCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if (sortedThemes.isNotEmpty) {
        buffer.writeln(
          'Ortak Temalar: ${sortedThemes.take(3).map((e) => e.key).join(", ")}',
        );
      }

      // Tekrarlayan rüya kalıbı tespiti
      if (sortedSymbols.any((e) => e.value >= 3)) {
        buffer.writeln('\n⚠️ TEKRARLAYAN KALIP TESPİT EDİLDİ:');
        final recurringSymbols = sortedSymbols.where((e) => e.value >= 3);
        for (final symbol in recurringSymbols) {
          buffer.writeln('  - "${symbol.key}" ${symbol.value} kez görülmüş');
        }
      }
    }

    return buffer.toString();
  }

  /// Astrolojik bağlam oluştur
  static String buildAstroContext(DateTime dreamTime, BirthChart? chart) {
    final buffer = StringBuffer();

    buffer.writeln('ASTROLOJİK BAĞLAM:');
    buffer.writeln('─'.padRight(40, '─'));

    // Rüya zamanı
    buffer.writeln('Rüya Tarihi: ${_formatDate(dreamTime)}');

    // Ay fazı
    final moonPhase = MoonPhaseCalculator.calculate(dreamTime);
    buffer.writeln('Ay Fazı: ${moonPhase.emoji} ${moonPhase.label}');
    buffer.writeln('  → ${moonPhase.meaning}');

    // Ay fazı rüya etkisi
    final phaseEffect = _getMoonPhaseEffect(moonPhase);
    buffer.writeln('  → Rüya Kalitesi: $phaseEffect');

    // Ay burcu tahmini (basit hesaplama)
    final estimatedMoonSign = _estimateMoonSign(dreamTime);
    buffer.writeln('Tahmini Ay Burcu: $estimatedMoonSign');

    // Doğum haritası varsa
    if (chart != null) {
      buffer.writeln('\nNATAL HARİTA BİLGİLERİ:');
      buffer.writeln('Güneş: ${chart.sunSign.nameTr}');
      buffer.writeln('Ay: ${chart.moonSign.nameTr}');
      buffer.writeln('Yükselen: ${chart.ascendant.nameTr}');

      // Natal Neptün pozisyonu (rüyalar için önemli)
      final neptune = chart.getPosition(planet_model.Planet.neptune);
      if (neptune != null) {
        buffer.writeln('Neptün: ${neptune.sign.nameTr} (rüya yöneticisi)');
      }

      // 12. ev (bilinçdışı)
      final house12 = chart.getHouse(12);
      if (house12 != null) {
        buffer.writeln('12. Ev (Bilinçdışı): ${house12.signName}');
      }
    }

    // Retro dönemleri (genel bilgi)
    final retroInfo = _getRetrogradeInfo(dreamTime);
    if (retroInfo.isNotEmpty) {
      buffer.writeln('\nAKTİF RETRO ENERJİLERİ:');
      buffer.write(retroInfo);
    }

    return buffer.toString();
  }

  /// Rüya zamanı bağlamı
  static String buildTimeContext(DreamTime dreamTime) {
    final buffer = StringBuffer();

    buffer.writeln('RÜYA ZAMANI:');
    switch (dreamTime) {
      case DreamTime.morning:
        buffer.writeln('Sabah rüyası (05:00-09:00)');
        buffer.writeln('→ REM uykusu en yoğun, en canlı rüyalar');
        buffer.writeln('→ Bilinçaltı mesajları en net');
        buffer.writeln('→ Hatırlanma olasılığı yüksek');
        break;
      case DreamTime.night:
        buffer.writeln('Gece yarısı rüyası (00:00-04:00)');
        buffer.writeln('→ Derin uyku dönemine yakın');
        buffer.writeln('→ Arketipsel, sembolik içerik yoğun');
        buffer.writeln('→ Kâbus riski daha yüksek');
        break;
      case DreamTime.afternoon:
        buffer.writeln('Öğleden sonra/şekerleme rüyası');
        buffer.writeln('→ Kısa ama yoğun REM');
        buffer.writeln('→ Günlük streslerin işlenmesi');
        buffer.writeln('→ Lucid rüya potansiyeli yüksek');
        break;
      case DreamTime.unknown:
        buffer.writeln('Zaman belirtilmemiş');
        buffer.writeln('→ Genel yorum yapılacak');
        break;
    }

    return buffer.toString();
  }

  // ══════════════════════════════════════════════════════════════
  // PROMPT ÜRETİCİLER
  // ══════════════════════════════════════════════════════════════

  /// Tam prompt oluştur (tüm bağlamlarla)
  static String generateFullPrompt(
    DreamInput input,
    InterpretationStyle style, {
    profile_model.UserProfile? user,
    List<Dream>? recentDreams,
    BirthChart? chart,
    DreamTime dreamTime = DreamTime.unknown,
  }) {
    final buffer = StringBuffer();

    // Sistem promptu
    buffer.writeln('═'.padRight(60, '═'));
    buffer.writeln('SİSTEM ROLÜ:');
    buffer.writeln('═'.padRight(60, '═'));
    buffer.writeln(getSystemPrompt(style));

    // Bağlamlar
    buffer.writeln('\n${'═'.padRight(60, '═')}');
    buffer.writeln('BAĞLAM BİLGİLERİ:');
    buffer.writeln('═'.padRight(60, '═'));

    // Kullanıcı bağlamı
    buffer.writeln(buildUserContext(user, recentDreams));

    // Astrolojik bağlam
    final now = DateTime.now();
    buffer.writeln('\n${buildAstroContext(now, chart)}');

    // Zaman bağlamı
    buffer.writeln('\n${buildTimeContext(dreamTime)}');

    // Rüya metni
    buffer.writeln('\n${'═'.padRight(60, '═')}');
    buffer.writeln('RÜYA METNİ:');
    buffer.writeln('═'.padRight(60, '═'));
    buffer.writeln('"${input.dreamDescription}"');

    // Ek bilgiler
    if (input.dominantEmotion != null) {
      buffer.writeln(
        '\nBaskın Duygu: ${input.dominantEmotion!.label} ${input.dominantEmotion!.emoji}',
      );
    }

    if (input.wakingFeeling != null) {
      buffer.writeln('Uyanınca Hissedilen: ${input.wakingFeeling}');
    }

    if (input.perceivedRole != null) {
      buffer.writeln(
        'Rüyadaki Rol: ${input.perceivedRole!.label} ${input.perceivedRole!.emoji}',
      );
    }

    if (input.isRecurring) {
      buffer.writeln(
        '⚠️ TEKRARLAYAN RÜYA: ${input.recurringCount ?? "?"} kez görülmüş',
      );
    }

    if (input.currentLifeSituation != null) {
      buffer.writeln('Mevcut Yaşam Durumu: ${input.currentLifeSituation}');
    }

    // Tespit edilen semboller
    final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(
      input.dreamDescription,
    );
    if (detectedSymbols.isNotEmpty) {
      buffer.writeln('\nOtomatik Tespit Edilen Semboller:');
      for (final symbol in detectedSymbols) {
        buffer.writeln(
          '  ${symbol.emoji} ${symbol.symbolTr}: ${symbol.universalMeanings.first}',
        );
      }
    }

    // Çıktı formatı
    buffer.writeln('\n${'═'.padRight(60, '═')}');
    buffer.writeln('ÇIKTI FORMATI:');
    buffer.writeln('═'.padRight(60, '═'));
    buffer.writeln(_getOutputFormat(style));

    return buffer.toString();
  }

  /// Hızlı yorum promptu (2-3 paragraf)
  static String generateQuickPrompt(DreamInput input) {
    return '''
GÖREV: Kısa ve öz rüya yorumu (2-3 paragraf)

RÜYA: "${input.dreamDescription}"
${input.dominantEmotion != null ? 'DUYGU: ${input.dominantEmotion!.label}' : ''}

YORUM FORMATI:
1. Özet Mesaj (1 paragraf): Rüyanın ana mesajı nedir?
2. Sembol Analizi (1 paragraf): Öne çıkan 1-2 sembolün kısa yorumu
3. Pratik Öneri (1 paragraf): Bugün ne yapılabilir?

NOT: Mistik ama pratik, derin ama anlaşılır, Türkçe zengin olsun.
''';
  }

  /// Sembol odaklı prompt
  static String generateSymbolPrompt(
    DreamInput input,
    List<String> focusSymbols,
  ) {
    return '''
GÖREV: Sembol odaklı derinlemesine analiz

RÜYA: "${input.dreamDescription}"

ODAK SEMBOLLER: ${focusSymbols.join(', ')}

HER SEMBOL İÇİN:
1. Evrensel Anlam: Kolektif bilinçte ne ifade eder?
2. Kişisel Bağlam: Bu rüyada özellikle ne söylüyor?
3. Gölge Yönü: Dikkat edilmesi gereken
4. Işık Yönü: Potansiyel ve fırsat
5. İlişkili Semboller: Bağlantılı anlamlar
6. Pratik Öneri: Bu sembolle nasıl çalışılır?

ÇIKTI: JSON formatında sembol analizi
''';
  }

  /// Terapötik/rüya çalışması promptu
  static String generateTherapeuticPrompt(DreamInput input) {
    return '''
GÖREV: Terapötik rüya çalışması rehberliği

RÜYA: "${input.dreamDescription}"
${input.dominantEmotion != null ? 'DUYGU: ${input.dominantEmotion!.label}' : ''}

ÇIKTI FORMATI:

1. GÜVENLİ ALAN OLUŞTURMA
   - Rüyayı hatırlarken bedensel farkındalık
   - Nefes ve grounding teknikleri

2. RÜYA DİYALOĞU
   - Hangi elementle konuşulmalı?
   - Örnek sorular ve diyalog başlangıcı
   - Boş sandalye tekniği uygulaması

3. BEDENSEL FARKINDDALIK
   - Rüya hangi beden bölgesinde hissediliyor?
   - Somatik deneyim rehberliği

4. ENTEGRASYON
   - Rüyadan alınan mesaj
   - Günlük hayata taşıma
   - Ritüel veya sembolik eylem önerisi

5. DEVAM ÇALIŞMASI
   - Jurnal promptları
   - Bir sonraki rüya için niyet
''';
  }

  /// Lucid rüya hazırlık promptu
  static String generateLucidPrepPrompt(DreamInput input) {
    final moonPhase = MoonPhaseCalculator.today;

    return '''
GÖREV: Lucid rüya hazırlık rehberliği

RÜYA: "${input.dreamDescription}"
AY FAZI: ${moonPhase.emoji} ${moonPhase.label}

ÇIKTI FORMATI:

1. LUCİD POTANSİYEL DEĞERLENDİRMESİ
   - Bu rüya lucid için uygun mu?
   - Ay fazı etkisi
   - Duygusal uygunluk

2. RÜYA İŞARETLERİ (Dream Signs)
   - Bu rüyadaki olağandışılıklar
   - Kişisel rüya işaretleri
   - Reality check tetikleyicileri

3. BU GECE İÇİN NİYET
   - MILD affirmasyonu (kişiselleştirilmiş)
   - Görselleştirme senaryosu
   - Farkındalık anı hayal etme

4. WBTB PLANI
   - Optimal uyanma saati
   - Uyanık kalma süresi
   - Tekrar uykuya dalma stratejisi

5. LUCİD HEDEFLER
   - Bu rüyada lucid olsan ne yapardın?
   - Gölge entegrasyonu fırsatı
   - Soru sorma önerileri

6. SABİLİZASYON HATIRLAT
   - Lucid olunca ilk yapılacak
   - Stabilizasyon teknikleri
''';
  }

  /// Kâbus dönüşüm promptu
  static String generateNightmareTransformPrompt(DreamInput input) {
    return '''
GÖREV: Kâbus dönüşüm ve şifa çalışması

RÜYA: "${input.dreamDescription}"
${input.dominantEmotion != null ? 'DUYGU: ${input.dominantEmotion!.label}' : ''}

ÖNEMLİ: Bu rüya korkutucu elementler içeriyor. Güvenli, destekleyici ve dönüştürücü bir yaklaşım kullan.

ÇIKTI FORMATI:

1. GÜVENLİK VE VALİDASYON
   - Korku tepkisi normaldir
   - Kâbuslar mesaj taşır, düşman değildir
   - Şu an güvendesin hatırlatması

2. KORKININ KAYNAĞİ
   - Hangi arketipsel korku aktif?
   - Gölge elementi ne?
   - Gerçek hayat bağlantısı

3. DÖNÜŞÜM YOLU
   - Korku → Güç dönüşümü
   - "Kovalayan"la yüzleşme rehberliği
   - Rüya yeniden yazma (dream rescripting)

4. ŞİFA SEMBOLLERİ
   - Bu kâbusu dengeleyecek semboller
   - Koruyucu figür çağırma
   - Güç hayvanı aktivasyonu

5. LUCİD DÖNÜŞÜM PLANI
   - Bir sonraki sefer lucid olursan...
   - Korkulana yaklaşma rehberliği
   - "Sen kimsin? Ne öğretiyorsun?" sorusu

6. UYANIKKEN ÇALIŞMA
   - Güvenli ortamda görselleştirme
   - Alternatif son yazma
   - Bedeni sakinleştirme teknikleri

7. KORUYUCU RİTÜEL
   - Uyku öncesi güvenlik ritüeli
   - Koruyucu semboly yastık altına koyma
   - Niyet ve dua/affirmasyonn
''';
  }

  // ══════════════════════════════════════════════════════════════
  // YANIT İŞLEME
  // ══════════════════════════════════════════════════════════════

  /// AI yanıtını parse et
  static FullDreamInterpretation parseAIResponse(
    String aiResponse,
    DreamInput input, {
    String? userId,
  }) {
    try {
      // JSON yanıtı parse et
      final json = jsonDecode(aiResponse) as Map<String, dynamic>;
      return _parseJsonResponse(json, input, userId: userId);
    } catch (e) {
      // JSON parse başarısız, metin olarak işle
      return _parseTextResponse(aiResponse, input, userId: userId);
    }
  }

  /// JSON yanıtı parse et
  static FullDreamInterpretation _parseJsonResponse(
    Map<String, dynamic> json,
    DreamInput input, {
    String? userId,
  }) {
    final moonPhase = MoonPhaseCalculator.today;

    return FullDreamInterpretation(
      dreamId: const Uuid().v4(),
      oderId: userId ?? 'anonymous',
      dreamText: input.dreamDescription,
      interpretedAt: DateTime.now(),
      ancientIntro: json['ancientIntro'] ?? json['kadimGiris'] ?? '',
      coreMessage: json['coreMessage'] ?? json['anaMesaj'] ?? '',
      symbols: _parseSymbols(json['symbols'] ?? json['semboller']),
      archetypeConnection:
          json['archetypeConnection'] ?? json['arketipBaglantisi'] ?? '',
      archetypeName: json['archetypeName'] ?? json['arketipAdi'] ?? 'Gölge',
      emotionalReading: _parseEmotionalReading(
        json['emotionalReading'] ?? json['duygusalOkuma'],
      ),
      astroTiming: AstroTiming(
        moonPhase: moonPhase,
        moonSign: json['moonSign'] ?? json['ayBurcu'],
        relevantTransit: json['relevantTransit'] ?? json['ilgiliTransit'],
        timingMessage:
            json['timingMessage'] ??
            json['zamanlamaMesaji'] ??
            moonPhase.meaning,
        whyNow: json['whyNow'] ?? json['nedenSimdi'] ?? '',
        isRetrograde: json['isRetrograde'] ?? json['retroMu'] ?? false,
      ),
      lightShadow: _parseLightShadow(json['lightShadow'] ?? json['isikGolge']),
      guidance: _parseGuidance(json['guidance'] ?? json['rehberlik']),
      whisperQuote: json['whisperQuote'] ?? json['fisildayanCumle'] ?? '',
      shareCard: _parseShareCard(json['shareCard'] ?? json['paylasimKarti']),
      explorationLinks: _generateDefaultExplorationLinks(),
      userRole: _parseRole(json['userRole'] ?? json['kullaniciRolu']),
      timeLayer: _parseTimeLayer(json['timeLayer'] ?? json['zamanKatmani']),
      isRecurring: input.isRecurring,
      recurringCount: input.recurringCount,
      recurringPattern: json['recurringPattern'] ?? json['tekrarKalibi'],
      nightmareType: json['nightmareType'] ?? json['kabusTipi'],
      lucidPotential: json['lucidPotential'] ?? json['lucidPotansiyeli'],
    );
  }

  /// Metin yanıtı parse et (JSON olmayan)
  static FullDreamInterpretation _parseTextResponse(
    String text,
    DreamInput input, {
    String? userId,
  }) {
    final moonPhase = MoonPhaseCalculator.today;
    final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(
      input.dreamDescription,
    );

    // Metinden bölümler çıkar
    final sections = _extractSections(text);

    // Sembolleri işle
    final symbolInterpretations = detectedSymbols.map((symbolData) {
      return SymbolInterpretation(
        symbol: symbolData.symbolTr,
        symbolEmoji: symbolData.emoji,
        universalMeaning: symbolData.universalMeanings.first,
        personalContext:
            symbolData.emotionVariants[input.dominantEmotion] ??
            symbolData.universalMeanings.first,
        shadowAspect: symbolData.shadowAspect,
        lightAspect: symbolData.lightAspect,
        relatedSymbols: symbolData.relatedSymbols,
      );
    }).toList();

    return FullDreamInterpretation(
      dreamId: const Uuid().v4(),
      oderId: userId ?? 'anonymous',
      dreamText: input.dreamDescription,
      interpretedAt: DateTime.now(),
      ancientIntro: sections['intro'] ?? _generateDefaultIntro(moonPhase),
      coreMessage: sections['core'] ?? text.split('\n').first,
      symbols: symbolInterpretations,
      archetypeConnection: sections['archetype'] ?? '',
      archetypeName: _detectArchetype(text),
      emotionalReading: EmotionalReading(
        dominantEmotion: input.dominantEmotion ?? EmotionalTone.merak,
        surfaceMessage: sections['surface'] ?? '',
        deeperMeaning: sections['deeper'] ?? '',
        shadowQuestion: sections['shadowQuestion'] ?? '',
        integrationPath: sections['integration'] ?? '',
      ),
      astroTiming: AstroTiming(
        moonPhase: moonPhase,
        timingMessage: moonPhase.meaning,
        whyNow: 'Bu rüya tam da bu zamanda geldi çünkü ruhun hazır.',
      ),
      lightShadow: LightShadowReading(
        lightMessage: sections['light'] ?? '',
        shadowMessage: sections['shadow'] ?? '',
        integrationPath: sections['integrationPath'] ?? '',
        archetype: _detectArchetype(text),
      ),
      guidance: PracticalGuidance(
        todayAction: sections['todayAction'] ?? 'Bu rüyayı günlüğüne yaz.',
        reflectionQuestion:
            sections['reflectionQuestion'] ?? 'Bu rüya bana ne söylüyor?',
        weeklyFocus: sections['weeklyFocus'] ?? 'Rüya sembollerine dikkat et.',
        avoidance: sections['avoidance'] ?? 'Mesajı görmezden gelmekten kaçın.',
      ),
      whisperQuote: sections['whisper'] ?? _generateWhisper(),
      shareCard: ShareableQuoteTemplates.getRandomQuote(),
      explorationLinks: _generateDefaultExplorationLinks(),
      userRole: input.perceivedRole,
      timeLayer: _inferTimeLayer(input),
      isRecurring: input.isRecurring,
      recurringCount: input.recurringCount,
    );
  }

  // ══════════════════════════════════════════════════════════════
  // FALLBACK / YEREL YORUM ÜRETİCİ
  // ══════════════════════════════════════════════════════════════

  /// AI mevcut değilse yerel yorum üret
  static FullDreamInterpretation generateLocalInterpretation(
    DreamInput input, {
    InterpretationStyle style = InterpretationStyle.jungian,
    String? userId,
  }) {
    final moonPhase = MoonPhaseCalculator.today;
    final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(
      input.dreamDescription,
    );
    final dominantEmotion = input.dominantEmotion ?? EmotionalTone.merak;

    // Sembolleri yorumla
    final symbolInterpretations = detectedSymbols.map((symbolData) {
      return SymbolInterpretation(
        symbol: symbolData.symbolTr,
        symbolEmoji: symbolData.emoji,
        universalMeaning: symbolData.universalMeanings.first,
        personalContext:
            symbolData.emotionVariants[dominantEmotion] ??
            symbolData.universalMeanings.first,
        shadowAspect: symbolData.shadowAspect,
        lightAspect: symbolData.lightAspect,
        relatedSymbols: symbolData.relatedSymbols,
      );
    }).toList();

    // Arketip tespit et
    final archetype = _detectDominantArchetype(
      detectedSymbols,
      dominantEmotion,
    );
    final archetypeData = ArchetypeDatabase.findArchetype(archetype);

    // Zaman katmanı
    final timeLayer = input.isRecurring
        ? TimeLayer.dongusel
        : _inferTimeLayer(input);

    // Stil bazlı kadim giriş
    final ancientIntro = _generateStyledIntro(
      style,
      moonPhase,
      dominantEmotion,
      detectedSymbols,
    );

    // Ana mesaj
    final coreMessage = _generateCoreMessage(
      detectedSymbols,
      dominantEmotion,
      timeLayer,
      moonPhase,
    );

    // Duygusal okuma
    final emotionalReading = _generateEmotionalReading(dominantEmotion, style);

    // Pratik rehberlik
    final guidance = _generateGuidance(detectedSymbols, dominantEmotion, style);

    // Tekrarlayan rüya kalıbı tespiti
    final recurringPattern = input.isRecurring
        ? RecurringDreamAnalyzer.detectPattern(input.dreamDescription)?.title
        : null;

    // Kâbus tespiti
    final nightmareType = NightmareTransformationService.detectNightmareType(
      input.dreamDescription,
    )?.title;

    // Lucid potansiyeli
    final lucidPotential = _calculateLucidPotential(dominantEmotion, moonPhase);

    return FullDreamInterpretation(
      dreamId: const Uuid().v4(),
      oderId: userId ?? 'anonymous',
      dreamText: input.dreamDescription,
      interpretedAt: DateTime.now(),
      ancientIntro: ancientIntro,
      coreMessage: coreMessage,
      symbols: symbolInterpretations,
      archetypeConnection:
          archetypeData?.description ??
          'Bilinçaltının derinliklerinden bir mesaj.',
      archetypeName: archetypeData?.nameTr ?? archetype,
      emotionalReading: emotionalReading,
      astroTiming: AstroTiming(
        moonPhase: moonPhase,
        timingMessage: _getMoonPhaseMessage(moonPhase),
        whyNow: _getWhyNowMessage(moonPhase, timeLayer),
      ),
      lightShadow: LightShadowReading(
        lightMessage: _generateLightMessage(detectedSymbols),
        shadowMessage: _generateShadowMessage(detectedSymbols),
        integrationPath:
            archetypeData?.integrationPath ?? 'Bu rüyayla çalışmaya devam et.',
        archetype: archetype,
      ),
      guidance: guidance,
      whisperQuote: _generateWhisper(),
      shareCard: ShareableQuoteTemplates.getQuoteForEmotion(dominantEmotion),
      explorationLinks: _generateDefaultExplorationLinks(),
      userRole: input.perceivedRole ?? _inferRole(input.dreamDescription),
      timeLayer: timeLayer,
      isRecurring: input.isRecurring,
      recurringCount: input.recurringCount,
      recurringPattern: recurringPattern,
      nightmareType: nightmareType,
      lucidPotential: lucidPotential,
    );
  }

  // ══════════════════════════════════════════════════════════════
  // YARDIMCI METOTLAR
  // ══════════════════════════════════════════════════════════════

  /// Çıktı formatı
  static String _getOutputFormat(InterpretationStyle style) {
    switch (style) {
      case InterpretationStyle.jungian:
      case InterpretationStyle.freudian:
      case InterpretationStyle.spiritual:
        return _fullJsonOutputFormat;
      case InterpretationStyle.gestalt:
        return _gestaltOutputFormat;
      case InterpretationStyle.islamic:
      case InterpretationStyle.turkish:
        return _traditionalOutputFormat;
      case InterpretationStyle.cognitive:
        return _cognitiveOutputFormat;
    }
  }

  static const String _fullJsonOutputFormat = '''
JSON FORMATI:
{
  "ancientIntro": "Kadim giriş (3-4 cümle, şiirsel)",
  "coreMessage": "Ana mesaj (2-3 cümle, doğrudan)",
  "symbols": [
    {
      "symbol": "Sembol adı",
      "symbolEmoji": "🔮",
      "universalMeaning": "Evrensel anlam",
      "personalContext": "Bu rüyadaki kişisel bağlam",
      "shadowAspect": "Gölge yönü",
      "lightAspect": "Işık yönü"
    }
  ],
  "archetypeName": "Aktif arketip",
  "archetypeConnection": "Arketipin bu rüyadaki mesajı",
  "emotionalReading": {
    "dominantEmotion": "korku|huzur|merak|sucluluk|ozlem|heyecan|donukluk|ofke",
    "surfaceMessage": "Yüzey mesajı",
    "deeperMeaning": "Derin anlam",
    "shadowQuestion": "Gölge sorusu",
    "integrationPath": "Entegrasyon yolu"
  },
  "timingMessage": "Astrolojik zamanlama mesajı",
  "whyNow": "Bu rüya neden şimdi geldi?",
  "lightShadow": {
    "lightMessage": "Işık mesajı",
    "shadowMessage": "Gölge mesajı",
    "integrationPath": "Entegrasyon yolu",
    "archetype": "İlgili arketip"
  },
  "guidance": {
    "todayAction": "Bugün yapılacak",
    "reflectionQuestion": "Yansıtma sorusu",
    "weeklyFocus": "Haftalık odak",
    "avoidance": "Kaçınılacak"
  },
  "whisperQuote": "Tek cümlelik aforizma",
  "shareCard": {
    "emoji": "🔮",
    "quote": "Paylaşılabilir kısa alıntı",
    "category": "Kategori"
  },
  "userRole": "izleyici|kahraman|kacan|arayan|saklanan|kurtarici|kurban",
  "timeLayer": "gecmis|simdi|gelecek|dongusel"
}
''';

  static const String _gestaltOutputFormat = '''
GESTALT FORMATI:

1. ŞİMDİKİ ZAMAN ANLATIMI
Rüyayı şimdiki zamanda yeniden anlat.

2. ELEMENT OLMAK
Her önemli element için:
"Ben [element]im. [Konuşma]"

3. DİYALOG
İki element arasında diyalog öner.

4. BEDENSEL FARKINDDALIK
Rüya bedenin neresinde hissediliyor?

5. BÜTÜNLEME
Parçalar nasıl bütünleşir?

JSON çıktısı da ekle.
''';

  static const String _traditionalOutputFormat = '''
GELENEKSEl YORUM FORMATI:

1. TABİR BAŞLANGICI
"Bismillah" veya geleneksel açılış

2. SEMBOL TABİRLERİ
Her sembol için klasik tabir

3. GENEL YORUM
Rüyanın bütüncül anlamı

4. HAYIR/ŞER
Rüya hayra mı, şerre mi işaret?

5. TAVSİYE
Ne yapılmalı?

6. DUA/TEMENNİ
"Hayırlısı", "İnşallah" ile kapanış

JSON çıktısı da ekle.
''';

  static const String _cognitiveOutputFormat = '''
BİLİŞSEl ANALİZ FORMATI:

1. BELLEK BAĞLANTILARI
Son günlerdeki olaylarla bağlantı

2. DUYGUSAL İŞLEME
Hangi duygular işleniyor?

3. PROBLEM ÇÖZME
Rüya hangi problemi simüle ediyor?

4. TEHDİT DEĞERLENDİRMESİ
Evrimsel tehdit simülasyonu analizi

5. PRATİK ÖNERİLER
Bilişsel davranışçı teknikler

JSON çıktısı da ekle.
''';

  // Stil bazlı kadim giriş
  static String _generateStyledIntro(
    InterpretationStyle style,
    MoonPhase moonPhase,
    EmotionalTone emotion,
    List<DreamSymbolData> symbols,
  ) {
    switch (style) {
      case InterpretationStyle.jungian:
        return _getJungianIntro(moonPhase, emotion);
      case InterpretationStyle.freudian:
        return _getFreudianIntro();
      case InterpretationStyle.gestalt:
        return _getGestaltIntro();
      case InterpretationStyle.spiritual:
        return _getSpiritualIntro(moonPhase);
      case InterpretationStyle.islamic:
        return _getIslamicIntro();
      case InterpretationStyle.turkish:
        return _getTurkishIntro();
      case InterpretationStyle.cognitive:
        return _getCognitiveIntro();
    }
  }

  static String _getJungianIntro(MoonPhase moonPhase, EmotionalTone emotion) {
    final intros = [
      'Carl Jung şöyle derdi: "Rüya, egonun görmek istemediği gerçeği gösteren küçük gizli kapıdır." Bu gece o kapı aralandı.',
      'Kolektif bilinçdışının derinliklerinden bir mesaj yükseliyor. Arketipler seninle konuşuyor.',
      '${moonPhase.emoji} ${moonPhase.label} fazında gelen bu rüya, bilinçdışının kompanse edici bir mesajıdır.',
      'Bireyselleşme yolculuğunda yeni bir eşik belirdi. Gölge ve Işık dans ediyor.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getFreudianIntro() {
    final intros = [
      'Freud\'un dediği gibi, rüyalar bilinçdışına giden kral yoludur. Bu gece o yolda yürüdün.',
      'Manifest içeriğin ardında latent bir arzu gizli. Rüya işi bu arzuyu maskeledi.',
      'Bilinçdışının bastırılmış içerikleri, rüyanın sembolik dilinde yüzeye çıkıyor.',
      'İd, ego ve süperego bu gece bir diyalog kurdu. Dinleyelim ne dediler.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getGestaltIntro() {
    final intros = [
      'Şimdi ve burada, bu rüyayla birlikte ol. Her parça senin bir parçan.',
      'Rüyanı yaşa, yorumlama. Her element seninle konuşmak istiyor.',
      'Bitmemiş işler rüyada tamamlanma arar. Farkındalıkla yaklaş.',
      'Sen hem rüyayı gören, hem rüyanın kendisisin. Bütünleş.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getSpiritualIntro(MoonPhase moonPhase) {
    final intros = [
      'Evren, rüyalar aracılığıyla seninle konuşuyor. ${moonPhase.emoji} ${moonPhase.label} enerjisi bu mesajı güçlendiriyor.',
      'Ruhun gece seyahatinden döndü ve bir armağan getirdi. Bu rüya bir hediye.',
      'Kadim bilgelik fısıldıyor: Rüya göreni dinleyin, o dünyalar arasında gezdi.',
      'Kozmik bilinç, rüyanın şifresinde saklı. Sezginle çöz.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getIslamicIntro() {
    final intros = [
      'Bismillahirrahmanirrahim. Rüya, nübüvvetin kırk altıda biridir. Bu gece sana bir işaret geldi.',
      'Hz. Yusuf\'a (a.s.) rüya tabiri ilmi verildi. O ilmin ışığında bakalım.',
      'Sadık rüya, müminlere verilen bir müjdedir. Hayırlısıyla yorumlayalım.',
      'Allah\'ın izniyle, bu rüyanın hikmeti açıklansın. Her işaret bir rahmettir.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getTurkishIntro() {
    final intros = [
      'Kızım/oğlum, düş dediğin ruhun gece sohbetidir. Atalarımız böyle söylerdi.',
      'Ninelerimiz derdi ki: "Düşü gören unutmasın, anlatan kıymetini bilsin."',
      'Anadolu\'nun kadim bilgeliğiyle bakalım bu rüyaya. Hayırlara vesile olsun.',
      'Eski tabirnamelerden öğrendik: Her düş bir haber taşır. Hayırlısı inşallah.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  static String _getCognitiveIntro() {
    final intros = [
      'Beynin gece boyunca çalıştı - bellekleri organize etti, duyguları işledi. Bu rüya o sürecin ürünü.',
      'Bilişsel nörobilim perspektifinden: Rüyan, beynin problem çözme ve stres yönetimi mekanizmasının bir parçası.',
      'REM uykusu sırasında varsayılan mod ağın aktifti. Beynin iç simülasyonlar üretti.',
      'Tehdit simülasyonu teorisine göre beyin, potansiyel senaryoları prova ediyor. Bu da onlardan biri.',
    ];
    return intros[DateTime.now().millisecond % intros.length];
  }

  // Diğer yardımcı metotlar

  static String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  static String _getMoonPhaseEffect(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.yeniay:
        return 'Derin ama hatırlanması zor';
      case MoonPhase.hilal:
        return 'Artan netlik, büyüme temaları';
      case MoonPhase.ilkDordun:
        return 'Gerilim, karar noktaları';
      case MoonPhase.dolunay:
        return 'En canlı, en net, en yoğun';
      case MoonPhase.sonDordun:
        return 'Bırakma temaları, temizlik';
      case MoonPhase.karanlikAy:
        return 'En derin, en gizli mesajlar';
    }
  }

  static String _estimateMoonSign(DateTime date) {
    // Basit tahmin (ay yaklaşık 2.5 günde burç değiştirir)
    final signs = [
      'Koç',
      'Boğa',
      'İkizler',
      'Yengeç',
      'Aslan',
      'Başak',
      'Terazi',
      'Akrep',
      'Yay',
      'Oğlak',
      'Kova',
      'Balık',
    ];
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    final signIndex = ((dayOfYear / 2.5) % 12).floor();
    return signs[signIndex];
  }

  static String _getRetrogradeInfo(DateTime date) {
    // Genel retro bilgisi (gerçek hesaplama için ephemeris gerekli)
    final buffer = StringBuffer();
    final month = date.month;

    // Merkür retro dönemleri (yaklaşık)
    if ((month >= 1 && month <= 2) ||
        (month >= 5 && month <= 6) ||
        (month >= 9 && month <= 10)) {
      buffer.writeln('☿ Merkür Retro olabilir - iletişim ve geçmiş temaları');
    }

    return buffer.toString();
  }

  static String _generateDefaultIntro(MoonPhase moonPhase) {
    return KadimGirisTemplates.rastgeleSecim(ayFazi: moonPhase);
  }

  static String _detectArchetype(String text) {
    final lowercaseText = text.toLowerCase();
    if (lowercaseText.contains('gölge') || lowercaseText.contains('shadow')) {
      return 'Gölge';
    }
    if (lowercaseText.contains('anima')) return 'Anima';
    if (lowercaseText.contains('animus')) return 'Animus';
    if (lowercaseText.contains('kahraman') || lowercaseText.contains('hero')) {
      return 'Kahraman';
    }
    if (lowercaseText.contains('bilge') || lowercaseText.contains('wise')) {
      return 'Bilge Yaşlı';
    }
    if (lowercaseText.contains('anne') || lowercaseText.contains('mother')) {
      return 'Büyük Anne';
    }
    if (lowercaseText.contains('çocuk') || lowercaseText.contains('child')) {
      return 'Çocuk';
    }
    return 'Gölge';
  }

  static Map<String, String> _extractSections(String text) {
    // Basit bölüm çıkarma
    return {
      'intro': text.split('\n').first,
      'core': text.split('\n').take(3).join(' '),
    };
  }

  static List<SymbolInterpretation> _parseSymbols(dynamic symbols) {
    if (symbols == null) return [];
    if (symbols is List) {
      return symbols.map((s) => SymbolInterpretation.fromJson(s)).toList();
    }
    return [];
  }

  static EmotionalReading _parseEmotionalReading(dynamic reading) {
    if (reading == null) {
      return const EmotionalReading(
        dominantEmotion: EmotionalTone.merak,
        surfaceMessage: '',
        deeperMeaning: '',
        shadowQuestion: '',
        integrationPath: '',
      );
    }
    return EmotionalReading.fromJson(reading);
  }

  static LightShadowReading _parseLightShadow(dynamic reading) {
    if (reading == null) {
      return const LightShadowReading(
        lightMessage: '',
        shadowMessage: '',
        integrationPath: '',
        archetype: 'Gölge',
      );
    }
    return LightShadowReading.fromJson(reading);
  }

  static PracticalGuidance _parseGuidance(dynamic guidance) {
    if (guidance == null) {
      return const PracticalGuidance(
        todayAction: 'Bu rüyayı günlüğüne yaz.',
        reflectionQuestion: 'Bu rüya bana ne söylüyor?',
        weeklyFocus: 'Rüya sembollerine dikkat et.',
        avoidance: 'Mesajı görmezden gelmekten kaçın.',
      );
    }
    return PracticalGuidance.fromJson(guidance);
  }

  static ShareableCard _parseShareCard(dynamic card) {
    if (card == null) return ShareableQuoteTemplates.getRandomQuote();
    return ShareableCard.fromJson(card);
  }

  static DreamRole? _parseRole(dynamic role) {
    if (role == null) return null;
    try {
      return DreamRole.values.firstWhere((r) => r.name == role);
    } catch (_) {
      return null;
    }
  }

  static TimeLayer? _parseTimeLayer(dynamic layer) {
    if (layer == null) return null;
    try {
      return TimeLayer.values.firstWhere((t) => t.name == layer);
    } catch (_) {
      return null;
    }
  }

  static TimeLayer _inferTimeLayer(DreamInput input) {
    final text = input.dreamDescription.toLowerCase();

    if (text.contains('çocukluğumda') ||
        text.contains('eskiden') ||
        text.contains('eski evim') ||
        text.contains('annem') ||
        text.contains('babam')) {
      return TimeLayer.gecmis;
    }

    if (text.contains('yarın') ||
        text.contains('gelecekte') ||
        text.contains('olacak')) {
      return TimeLayer.gelecek;
    }

    if (input.isRecurring) {
      return TimeLayer.dongusel;
    }

    return TimeLayer.simdi;
  }

  static DreamRole _inferRole(String dreamText) {
    final text = dreamText.toLowerCase();

    if (text.contains('kaçıyordum') || text.contains('kovalıyordu')) {
      return DreamRole.kacan;
    }
    if (text.contains('izliyordum') || text.contains('seyrediyordum')) {
      return DreamRole.izleyici;
    }
    if (text.contains('arıyordum') || text.contains('bulamadım')) {
      return DreamRole.arayan;
    }
    if (text.contains('kurtardım') || text.contains('yardım ettim')) {
      return DreamRole.kurtarici;
    }
    if (text.contains('saklanıyordum') || text.contains('gizleniyordum')) {
      return DreamRole.saklanan;
    }

    return DreamRole.kahraman;
  }

  static String _detectDominantArchetype(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
  ) {
    final archetypeCounts = <String, int>{};

    for (final symbol in symbols) {
      for (final archetype in symbol.archetypes) {
        archetypeCounts[archetype] = (archetypeCounts[archetype] ?? 0) + 1;
      }
    }

    if (emotion == EmotionalTone.korku) {
      archetypeCounts['Gölge'] = (archetypeCounts['Gölge'] ?? 0) + 2;
    } else if (emotion == EmotionalTone.ozlem) {
      archetypeCounts['Anima'] = (archetypeCounts['Anima'] ?? 0) + 2;
    } else if (emotion == EmotionalTone.heyecan) {
      archetypeCounts['Kahraman'] = (archetypeCounts['Kahraman'] ?? 0) + 2;
    }

    if (archetypeCounts.isEmpty) return 'Gölge';

    return archetypeCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  static String _generateCoreMessage(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
    TimeLayer timeLayer,
    MoonPhase moonPhase,
  ) {
    if (symbols.isEmpty) {
      return 'Bilinçaltın seninle simgesiz, doğrudan konuşuyor. Bu rüyanın özünde bir duygu mesajı var.';
    }

    final mainSymbol = symbols.first;
    return '${mainSymbol.emoji} ${mainSymbol.symbolTr} sembolü bilinçaltının ana mesajcısı. '
        '${emotion.hint} ${moonPhase.meaning}';
  }

  static EmotionalReading _generateEmotionalReading(
    EmotionalTone emotion,
    InterpretationStyle style,
  ) {
    // Stil bazlı mesajlar
    final surfaceMessages = {
      EmotionalTone.korku:
          'Yüzeyde bir alarm çalıyor - dikkatini çeken bir tehdit var.',
      EmotionalTone.huzur: 'İç dünyanda bir denge hissediyorsun - bu değerli.',
      EmotionalTone.merak:
          'Keşfetme dürtüsü aktif - sorular cevaplardan daha önemli.',
      EmotionalTone.sucluluk:
          'Bir şey yanlış hissettiriyor - ama gerçekten öyle mi?',
      EmotionalTone.ozlem: 'Kalbinde bir boşluk var - doldurulması gereken.',
      EmotionalTone.heyecan: 'Enerji yükseliyor - yeni bir şey kapıda.',
      EmotionalTone.donukluk:
          'Duygular geçici olarak susturulmuş - koruma mekanizması.',
      EmotionalTone.ofke: 'Sınırlar zorlanmış - güç geri alınmak istiyor.',
    };

    final deeperMeanings = {
      EmotionalTone.korku:
          'Korkunun altında genellikle sevgi vardır. Neyi kaybetmekten korkuyorsun?',
      EmotionalTone.huzur:
          'Bu huzur, çatışmanın çözüldüğüne işaret. Hangi iç savaş sona erdi?',
      EmotionalTone.merak:
          'Merak, ruhun büyüme çağrısıdır. Bilinmeyene açılmaya hazırsın.',
      EmotionalTone.sucluluk:
          'Suçluluk bazen başkalarının sesini içselleştirmektir. Bu ses kimin?',
      EmotionalTone.ozlem:
          'Özlem, kaybedilen bütünlüğe dönüş arzusudur. Ne zaman bütün hissettin?',
      EmotionalTone.heyecan:
          'Heyecan, yaşam enerjisinin doruğudur. Bu enerjiyi nereye yönlendireceksin?',
      EmotionalTone.donukluk:
          'Donukluk, çok fazla hissetmekten korumadır. Neyi hissetmekten kaçınıyorsun?',
      EmotionalTone.ofke:
          'Öfke, bastırılmış gücün sesidir. Gücünü nerede geri istiyorsun?',
    };

    final shadowQuestions = {
      EmotionalTone.korku: 'Korktuğun şey gerçekleşse ne olurdu?',
      EmotionalTone.huzur: 'Bu huzuru sabote eden düşünce hangisi?',
      EmotionalTone.merak: 'Cevabını bulmaktan korktuğun soru ne?',
      EmotionalTone.sucluluk: 'Kendini affetsen ne değişirdi?',
      EmotionalTone.ozlem:
          'Özlediğin şey geri gelse, onu kabul edebilir misin?',
      EmotionalTone.heyecan: 'Bu heyecan sönse ne kalır?',
      EmotionalTone.donukluk: 'Hissetseydin ne hissederdin?',
      EmotionalTone.ofke: 'Öfkenin altında hangi acı var?',
    };

    final integrationPaths = {
      EmotionalTone.korku:
          'Korkuyla yüzleş, ama nazik ol. Korktuğun şeye küçük adımlarla yaklaş.',
      EmotionalTone.huzur:
          'Bu huzuru hatırla ve günlük hayatına taşı. Meditasyonla pekiştir.',
      EmotionalTone.merak:
          'Sorularını yaz, cevapları aramak yerine sorularla yaşamayı öğren.',
      EmotionalTone.sucluluk:
          'Suçluluğu incele: gerçek mi, öğrenilmiş mi? Kendine mektup yaz.',
      EmotionalTone.ozlem:
          'Özlemi onurlandır ama şimdide kal. Kaybı kabul, geleceğe kapı açar.',
      EmotionalTone.heyecan: 'Heyecanı eyleme dönüştür. Bugün bir adım at.',
      EmotionalTone.donukluk:
          'Bedenine dön. Hareket et, nefes al, yavaş yavaş hisset.',
      EmotionalTone.ofke:
          'Öfkeyi sağlıklı ifade et: spor, yazı, yaratıcılık. Ama birini incitme.',
    };

    return EmotionalReading(
      dominantEmotion: emotion,
      surfaceMessage: surfaceMessages[emotion]!,
      deeperMeaning: deeperMeanings[emotion]!,
      shadowQuestion: shadowQuestions[emotion]!,
      integrationPath: integrationPaths[emotion]!,
    );
  }

  static PracticalGuidance _generateGuidance(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
    InterpretationStyle style,
  ) {
    String todayAction;
    if (emotion == EmotionalTone.korku) {
      todayAction = 'Bugün korktuğun bir şeye küçük bir adım at.';
    } else if (emotion == EmotionalTone.ozlem) {
      todayAction = 'Bugün özlediğin kişiye/duruma dair bir anı yaz.';
    } else if (symbols.isNotEmpty) {
      todayAction =
          'Bugün ${symbols.first.symbolTr} sembolü hakkında 5 dakika düşün.';
    } else {
      todayAction = 'Bugün bu rüyayı bir günlüğe yaz ve duygularını kaydet.';
    }

    String reflectionQuestion;
    if (symbols.isNotEmpty) {
      reflectionQuestion =
          '${symbols.first.symbolTr} sembolü hayatımda neyi temsil ediyor?';
    } else {
      reflectionQuestion = 'Bu rüya bana ne söylemeye çalışıyor?';
    }

    final avoidances = {
      EmotionalTone.korku:
          'Bu hafta korkudan kaçmak için yapılan impulsif kararlardan kaçın.',
      EmotionalTone.huzur: 'Huzuru bozmak isteyenlerden nazikçe mesafe koy.',
      EmotionalTone.merak: 'Cevapsız sorulara tahammülsüzlükten kaçın.',
      EmotionalTone.sucluluk: 'Kendini aşırı yargılamaktan kaçın.',
      EmotionalTone.ozlem: 'Geçmişte takılıp kalmaktan kaçın.',
      EmotionalTone.heyecan: 'Enerjini dağıtmaktan kaçın, odaklan.',
      EmotionalTone.donukluk: 'Hissizliği normalleştirmekten kaçın.',
      EmotionalTone.ofke: 'Öfkeyi başkalarına yansıtmaktan kaçın.',
    };

    return PracticalGuidance(
      todayAction: todayAction,
      reflectionQuestion: reflectionQuestion,
      weeklyFocus:
          'Bu hafta rüya sembollerine ve duygusal tepkilerine dikkat et.',
      avoidance: avoidances[emotion]!,
    );
  }

  static String _getMoonPhaseMessage(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.yeniay:
        return 'Yeniay fazında gelen bu rüya, yeni bir niyet tohumu taşıyor.';
      case MoonPhase.hilal:
        return 'Hilal Ay döneminde gelen rüyalar büyüme potansiyelini gösterir.';
      case MoonPhase.ilkDordun:
        return 'İlk Dördün\'de gelen bu rüya bir karar noktasına işaret ediyor.';
      case MoonPhase.dolunay:
        return 'Dolunay\'da gelen rüyalar farkındalık doruk noktasıdır.';
      case MoonPhase.sonDordun:
        return 'Son Dördün fazında gelen bu rüya bırakma zamanını gösteriyor.';
      case MoonPhase.karanlikAy:
        return 'Karanlık Ay\'da gelen rüyalar en kadim mesajları taşır.';
    }
  }

  static String _getWhyNowMessage(MoonPhase phase, TimeLayer layer) {
    return 'Bu rüya tam da şu an geldi çünkü ${phase.meaning} ve ${layer.meaning} '
        'Evren, bu mesajı senin için mükemmel zamanda gönderdi.';
  }

  static String _generateLightMessage(List<DreamSymbolData> symbols) {
    if (symbols.isEmpty) {
      return 'Bu rüya, iç dünyanın temiz ve aydınlık bir alanından geliyor.';
    }
    final lightAspects = symbols.map((s) => s.lightAspect).take(2).join(' ');
    return 'Işık yönü: $lightAspects Bu potansiyeli kucakla.';
  }

  static String _generateShadowMessage(List<DreamSymbolData> symbols) {
    if (symbols.isEmpty) {
      return 'Gölge her zaman vardır, ama bu rüyada nazikçe bekliyor.';
    }
    final shadowAspects = symbols.map((s) => s.shadowAspect).take(2).join(' ');
    return 'Gölge uyarısı: $shadowAspects Farkında ol, ama korkma.';
  }

  static String _calculateLucidPotential(
    EmotionalTone emotion,
    MoonPhase phase,
  ) {
    int score = 0;

    switch (phase) {
      case MoonPhase.dolunay:
        score += 3;
        break;
      case MoonPhase.ilkDordun:
        score += 2;
        break;
      case MoonPhase.hilal:
      case MoonPhase.sonDordun:
        score += 1;
        break;
      default:
        break;
    }

    if (emotion == EmotionalTone.merak || emotion == EmotionalTone.heyecan) {
      score += 2;
    } else if (emotion == EmotionalTone.huzur) {
      score += 1;
    }

    if (score >= 4) return 'Çok Yüksek';
    if (score >= 3) return 'Yüksek';
    if (score >= 2) return 'Orta';
    return 'Düşük';
  }

  static String _generateWhisper() {
    final quotes = [
      'Gece senin için konuştu, gündüz sen konuş.',
      'Rüya hatırlayan, ruhunu dinlemeye başlamıştır.',
      'Her sembol bir anahtar, her duygu bir kapı.',
      'Bilinçaltı yalan söylemez, sadece şifreyle konuşur.',
      'Gölgenden kaçamazsın, ama onunla dans edebilirsin.',
      'Kadim bilgelik fısıldar, sessizlikte duyan işitir.',
      'Rüyalar ruhun aynadaki yansımasıdır.',
      'En karanlık gece bile sabahı doğurur.',
    ];
    return quotes[Random().nextInt(quotes.length)];
  }

  static List<DreamExplorationLink> _generateDefaultExplorationLinks() {
    return const [
      DreamExplorationLink(
        title: 'Doğum Haritanı Keşfet',
        description: 'Rüyandaki sembollerin natal haritanla bağlantısını gör',
        route: '/birth-chart',
        emoji: '🗺️',
        category: 'Astroloji',
      ),
      DreamExplorationLink(
        title: 'Ay Takvimine Bak',
        description: 'Rüyanın geldiği ay fazının anlamını öğren',
        route: '/moon-rituals',
        emoji: '🌙',
        category: 'Ay',
      ),
      DreamExplorationLink(
        title: 'Tarot Çek',
        description: 'Rüyanın mesajını tarot ile derinleştir',
        route: '/tarot',
        emoji: '🃏',
        category: 'Kehanet',
      ),
    ];
  }
}

// ════════════════════════════════════════════════════════════════════════════
// EK YARDIMCI SINIFLAR
// ════════════════════════════════════════════════════════════════════════════

/// Ay fazı hesaplama (DreamInterpretationService'den)
class MoonPhaseCalculator {
  /// Verilen tarih için ay fazını hesapla
  static MoonPhase calculate(DateTime date) {
    final reference = DateTime(2000, 1, 6);
    final daysSinceReference = date.difference(reference).inDays;
    const synodicMonth = 29.53;
    final dayInCycle = (daysSinceReference % synodicMonth);

    if (dayInCycle < 1.85) {
      return MoonPhase.yeniay;
    } else if (dayInCycle < 7.38) {
      return MoonPhase.hilal;
    } else if (dayInCycle < 11.07) {
      return MoonPhase.ilkDordun;
    } else if (dayInCycle < 14.76) {
      return MoonPhase.dolunay;
    } else if (dayInCycle < 22.14) {
      return MoonPhase.sonDordun;
    } else {
      return MoonPhase.karanlikAy;
    }
  }

  /// Bugünün ay fazı
  static MoonPhase get today => calculate(DateTime.now());
}

/// Planet enum (basit versiyon)
enum Planet {
  sun,
  moon,
  mercury,
  venus,
  mars,
  jupiter,
  saturn,
  uranus,
  neptune,
  pluto,
}

/// KadimGirisTemplates erişimi için extension
extension KadimGirisTemplatesAccess on KadimGirisTemplates {
  static String getRandomIntro() {
    return KadimGirisTemplates.genel[DateTime.now().millisecond %
        KadimGirisTemplates.genel.length];
  }

  static List<String> getForMoonPhase(MoonPhase phase) {
    return KadimGirisTemplates.ayFazina[phase.name] ?? [];
  }

  static List<String> getForSymbolCategory(SymbolCategory category) {
    return KadimGirisTemplates.kategoriye[category] ?? [];
  }

  static List<String> getForEmotion(EmotionalTone emotion) {
    return KadimGirisTemplates.duygusalTona[emotion] ?? [];
  }
}
