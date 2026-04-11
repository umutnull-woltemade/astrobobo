/// MEGA Dream Symbols Combined Database
/// Tum sembolleri tek bir yerden erisim
library;

import '../models/dream_interpretation_models.dart';
import 'dream_symbols_database.dart';
import 'mega_dream_symbols_part1.dart';
import 'mega_dream_symbols_part2.dart';
import 'mega_dream_symbols_part3.dart';
import 'mega_dream_symbols_part4.dart';
import 'mega_dream_symbols_part5.dart';
import 'mega_dream_symbols_part6.dart';
import 'mega_dream_symbols_part7.dart';
import 'mega_dream_symbols_part8.dart';
import 'mega_dream_symbols_part9.dart';
import 'mega_dream_symbols_part10.dart';
import 'mega_dream_symbols_part11.dart';
import 'mega_dream_symbols_part12.dart';
import 'mega_dream_symbols_part13.dart';
import 'mega_dream_symbols_part14.dart';
import 'mega_dream_symbols_part15.dart';

/// Tum sembolleri birlestiren ana sinif
class MegaDreamSymbolsCombined {
  static List<DreamSymbolData>? _cachedSymbols;

  /// Tum sembolleri getir (cached)
  static List<DreamSymbolData> get allSymbols {
    _cachedSymbols ??= [
      ...DreamSymbolsDatabase.allSymbols,
      ...MegaDreamSymbolsPart1.symbols,
      ...MegaDreamSymbolsPart2.symbols,
      ...MegaDreamSymbolsPart3.symbols,
      ...MegaDreamSymbolsPart4.symbols,
      ...MegaDreamSymbolsPart5.symbols,
      ...MegaDreamSymbolsPart6.symbols,
      ...MegaDreamSymbolsPart7.symbols,
      ...MegaDreamSymbolsPart8.symbols,
      ...MegaDreamSymbolsPart9.symbols,
      ...MegaDreamSymbolsPart10.symbols,
      ...MegaDreamSymbolsPart11.symbols,
      ...MegaDreamSymbolsPart12.symbols,
      ...MegaDreamSymbolsPart13.symbols,
      ...MegaDreamSymbolsPart14.symbols,
      ...MegaDreamSymbolsPart15.symbols,
    ];
    return _cachedSymbols!;
  }

  /// Toplam sembol sayisi
  static int get totalCount => allSymbols.length;

  /// Sembol ara (Turkce veya Ingilizce)
  static DreamSymbolData? findSymbol(String query) {
    final lowerQuery = query.toLowerCase().trim();
    return allSymbols.cast<DreamSymbolData?>().firstWhere(
      (s) =>
          s!.symbol.toLowerCase() == lowerQuery ||
          s.symbolTr.toLowerCase() == lowerQuery,
      orElse: () => null,
    );
  }

  /// Kategoriye gore sembolleri getir
  static List<DreamSymbolData> getByCategory(SymbolCategory category) {
    return allSymbols.where((s) => s.category == category).toList();
  }

  /// En yaygin sembolleri getir
  static List<DreamSymbolData> get commonSymbols {
    final common = [
      'water',
      'flying',
      'falling',
      'snake',
      'teeth_falling',
      'house',
      'chasing',
      'death',
      'naked',
      'lost',
      'car',
      'ocean',
      'fire',
      'dog',
      'cat',
      'baby',
      'mother',
      'father',
      'school',
      'money',
    ];
    return common
        .map((s) => findSymbol(s))
        .where((s) => s != null)
        .cast<DreamSymbolData>()
        .toList();
  }

  /// Ruya metninden sembolleri tespit et
  static List<DreamSymbolData> detectSymbolsInText(String dreamText) {
    final text = dreamText.toLowerCase();
    final detected = <DreamSymbolData>[];

    // Genisletilmis Turkce keyword patterns
    final patterns = <String, List<String>>{
      // Su & Sivilar
      'water': ['su ', 'suda', 'suya', 'suyu', 'sular'],
      'ocean': ['deniz', 'okyanus', 'denizde'],
      'rain': ['yagmur', 'yagiyor', 'yagdi'],
      'flood': ['sel', 'taskin', 'su baskini'],
      'river': ['nehir', 'irmak', 'cay', 'dere'],
      'lake': ['gol', 'golde', 'golu'],
      'swimming': ['yuzuyordum', 'yuzdim', 'yuzmek'],
      'drowning': ['boguldum', 'boguluyordum', 'bogulmak'],

      // Hayvanlar
      'snake': ['yilan', 'yilan', 'kobra', 'engerek'],
      'dog': ['kopek', 'it ', 'kopekler'],
      'cat': ['kedi', 'kediler'],
      'bird': ['kus', 'kuslar', 'guverçin', 'kartal'],
      'fish': ['balik', 'baliklar'],
      'spider': ['orumcek', 'orumcekler'],
      'horse': ['at ', 'ata ', 'ati', 'atlar'],
      'wolf': ['kurt', 'kurtlar'],
      'lion': ['aslan', 'aslanlar'],
      'bear': ['ayi', 'ayilar'],
      'elephant': ['fil', 'filler'],
      'mouse': ['fare', 'fareler', 'sican'],
      'butterfly': ['kelebek', 'kelebekler'],
      'bee': ['ari', 'arilar', 'bal arisi'],
      'dragon': ['ejderha', 'ejder'],

      // Mekanlar
      'house': ['ev ', 'evde', 'evim', 'evimde'],
      'room': ['odada', 'odasi', 'oda '],
      'basement': ['bodrum', 'mahzen', 'bodrumda'],
      'attic': ['cati', 'tavan arasi', 'catida'],
      'forest': ['orman', 'ormanda', 'agaclar'],
      'school': ['okul', 'sinif', 'ders', 'okulda'],
      'hospital': ['hastane', 'hastanede', 'doktor'],
      'church': ['kilise', 'cami', 'mabet', 'ibadethane'],
      'cemetery': ['mezarlik', 'kabir', 'mezar'],
      'prison': ['hapishane', 'cezaevi', 'hapis'],
      'bridge': ['kopru', 'koprude', 'kopruyu'],
      'mountain': ['dag', 'dagda', 'dagi', 'daglar'],
      'beach': ['sahil', 'kumsal', 'plaj', 'deniz kenari'],
      'cave': ['magara', 'magarada', 'in'],
      'road': ['yol', 'yolda', 'yolu'],

      // Eylemler
      'flying': ['ucuyordum', 'uctum', 'ucmak', 'havada', 'ucus'],
      'falling': ['dustum', 'dusuyordum', 'dusmek', 'dusus'],
      'chasing': ['kovaliyordu', 'kovalandim', 'kaciyordum', 'kovalama'],
      'running': ['kosuyordum', 'kostum', 'kosmak'],
      'climbing': ['tirmaniyordum', 'tirmandim', 'tirmanma'],
      'dancing': ['dans', 'dans ediyordum', 'oynuyordum'],
      'fighting': ['dovusuyordum', 'kavga', 'savasiyordum'],
      'hiding': ['saklaniyordum', 'gizlendim', 'saklanmak'],
      'searching': ['ariyordum', 'aradim', 'aramak'],
      'driving': ['araba', 'suruyordum', 'arac', 'sofor'],
      'walking': ['yuruyordum', 'yurudim', 'yurumek'],

      // Fiziksel durumlar
      'teeth_falling': ['dislerim', 'dis dokuldu', 'disler', 'dis dustu'],
      'naked': ['ciplak', 'ustum acik', 'cogunluk'],
      'lost': ['kayboldum', 'yolumu bulamadim', 'kayip'],
      'paralyzed': ['hareket edemiyordum', 'dondum', 'felc'],
      'pregnant': ['hamile', 'gebe', 'hamilelik'],
      'dying': ['oluyordum', 'oldum', 'olmek'],
      'giving_birth': ['dogum', 'dogurdum', 'dogum yapiyordum'],

      // Insanlar
      'mother': ['annem', 'anne', 'annemi'],
      'father': ['babam', 'baba', 'babami'],
      'child': ['cocuk', 'cocuklar'],
      'baby': ['bebek', 'bebekler'],
      'stranger': ['tanimadiguim biri', 'yabanci', 'tanimadigim'],
      'ex_partner': ['eski sevgilim', 'manita', 'ex', 'eski esim'],
      'deceased': ['olen', 'vefat', 'rahmetli', 'olmus'],
      'teacher': ['ogretmen', 'hoca', 'ogretmenim'],
      'doctor': ['doktor', 'hekim', 'doktora'],
      'celebrity': ['unlu', 'star', 'sarkici', 'oyuncu'],

      // Doga olaylari
      'fire': ['ates', 'yangin', 'alev', 'yaniyordu'],
      'earthquake': ['deprem', 'sarsinti', 'sallanti'],
      'storm': ['firtina', 'kasirga', 'bora'],
      'moon': ['ay ', 'dolunay', 'gece', 'ay isigi'],
      'sun': ['gunes', 'gunduz', 'gunes isigi'],
      'lightning': ['yildirim', 'simsk', 'gok gurultusu'],
      'snow': ['kar', 'kar yagiyordu', 'karli'],
      'wind': ['ruzgar', 'firtina', 'esiyordu'],

      // Nesneler
      'door': ['kapi', 'kapiyi', 'kapida'],
      'key': ['anahtar', 'anahtari'],
      'mirror': ['ayna', 'aynaya', 'aynada'],
      'phone': ['telefon', 'caldi', 'ariyordu'],
      'money': ['para', 'cuzdan', 'paralar'],
      'car': ['araba', 'otomobil', 'arac'],
      'airplane': ['ucak', 'ucakta', 'ucaga'],
      'train': ['tren', 'trende', 'tren istasyonu'],
      'ship': ['gemi', 'gemide', 'tekne'],
      'book': ['kitap', 'kitaplar', 'okuyordum'],
      'clock': ['saat', 'zaman', 'saati'],
      'ring': ['yuzuk', 'nisan', 'evlilik'],
      'knife': ['bicak', 'bicakla', 'bicagi'],
      'gun': ['silah', 'tabanca', 'tufek'],
      'gift': ['hediye', 'hediyeler', 'paket'],
      'clothes': ['kiyafet', 'elbise', 'giysi'],
      'shoes': ['ayakkabi', 'ayakkabilar'],

      // Soyut kavramlar
      'death': ['olum', 'oldum', 'oldu', 'cenaze', 'oldurme'],
      'wedding': ['dugun', 'evlilik', 'nikah', 'gelin'],
      'exam': ['sinav', 'test', 'imtihan', 'sinava'],
      'war': ['savas', 'kavga', 'dovus', 'mucadele'],
      'freedom': ['ozgurluk', 'serbest', 'kurtuldum'],
      'love': ['ask', 'sevgi', 'seviyordum'],
      'fear': ['korku', 'korkuyordum', 'korktum'],

      // Spiritüel
      'angel': ['melek', 'melekler', 'koruyucu melek'],
      'devil': ['seytan', 'iblis', 'seytanlar'],
      'god': ['tanri', 'allah', 'ilahi'],
      'ghost': ['hayalet', 'hayaletler', 'ruh'],
      'monster': ['canavar', 'yaratik', 'ucube'],
    };

    for (final entry in patterns.entries) {
      for (final keyword in entry.value) {
        if (text.contains(keyword)) {
          final symbol = findSymbol(entry.key);
          if (symbol != null && !detected.contains(symbol)) {
            detected.add(symbol);
          }
          break;
        }
      }
    }

    return detected;
  }

  /// Kategorilere gore sembol sayilari
  static Map<SymbolCategory, int> get categoryStats {
    final stats = <SymbolCategory, int>{};
    for (final category in SymbolCategory.values) {
      stats[category] = getByCategory(category).length;
    }
    return stats;
  }

  /// Rastgele semboller getir
  static List<DreamSymbolData> getRandomSymbols(int count) {
    final shuffled = List<DreamSymbolData>.from(allSymbols)..shuffle();
    return shuffled.take(count).toList();
  }

  /// Belirli bir duygu tonuna gore sembolleri filtrele
  static List<DreamSymbolData> getSymbolsForEmotion(EmotionalTone tone) {
    return allSymbols
        .where((s) => s.emotionVariants.containsKey(tone))
        .toList();
  }

  /// Arketipe gore sembolleri getir
  static List<DreamSymbolData> getSymbolsForArchetype(String archetype) {
    final lowerArchetype = archetype.toLowerCase();
    return allSymbols
        .where(
          (s) =>
              s.archetypes.any((a) => a.toLowerCase().contains(lowerArchetype)),
        )
        .toList();
  }

  /// Iliskili sembolleri getir
  static List<DreamSymbolData> getRelatedSymbols(DreamSymbolData symbol) {
    final related = <DreamSymbolData>[];
    for (final relatedName in symbol.relatedSymbols) {
      final found = findSymbol(relatedName);
      if (found != null) {
        related.add(found);
      }
    }
    return related;
  }
}
