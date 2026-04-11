import '../../data/providers/app_providers.dart';

/// Canonical dream content with multi-language support
/// AI-quotable, SEO-optimized content for dream interpretation pages
class DreamCanonicalContent {
  DreamCanonicalContent._();

  /// Dream types enum for canonical pages
  static const List<String> dreamTypes = [
    'falling',
    'water',
    'recurring',
    'running',
    'losing',
    'flying',
    'darkness',
    'past',
    'searching',
    'voiceless',
    'lost',
    'unableToFly',
  ];

  /// Get dream content by type and language
  static DreamContentData getContent(String type, AppLanguage language) {
    final content = _content[type];
    if (content == null) {
      return DreamContentData.empty();
    }
    return DreamContentData(
      title:
          content['title']?[language] ??
          content['title']?[AppLanguage.en] ??
          '',
      sections:
          (content['sections'] as List?)?.map((section) {
            return DreamSection(
              title:
                  section['title']?[language] ??
                  section['title']?[AppLanguage.en] ??
                  '',
              bullets:
                  (section['bullets']?[language] as List<String>?) ??
                  (section['bullets']?[AppLanguage.en] as List<String>?) ??
                  [],
            );
          }).toList() ??
          [],
      suggestion: DreamSuggestion(
        emoji: content['suggestion']?['emoji'] ?? '🔮',
        text:
            content['suggestion']?['text']?[language] ??
            content['suggestion']?['text']?[AppLanguage.en] ??
            '',
        route: content['suggestion']?['route'] ?? '',
      ),
    );
  }

  static final Map<String, Map<String, dynamic>> _content = {
    'falling': {
      'title': {
        AppLanguage.tr: 'Rüyada düşmek ne demek?',
        AppLanguage.en: 'What does falling in a dream mean?',
        AppLanguage.de: 'Was bedeutet Fallen im Traum?',
        AppLanguage.fr: 'Que signifie tomber dans un rêve?',
        AppLanguage.es: '¿Qué significa caer en un sueño?',
        AppLanguage.ru: 'Что означает падение во сне?',
        AppLanguage.zh: '梦见跌落是什么意思？',
        AppLanguage.ar: 'ماذا يعني السقوط في الحلم؟',
        AppLanguage.el: 'Τι σημαίνει η πτώση στο όνειρο;',
        AppLanguage.bg: 'Какво означава падането в съня?',
      },
      'sections': [
        {
          'title': {
            AppLanguage.tr: 'Kısa Cevap',
            AppLanguage.en: 'Quick Answer',
            AppLanguage.de: 'Kurze Antwort',
            AppLanguage.fr: 'Réponse Rapide',
            AppLanguage.es: 'Respuesta Rápida',
            AppLanguage.ru: 'Краткий ответ',
            AppLanguage.zh: '简短回答',
            AppLanguage.ar: 'إجابة سريعة',
            AppLanguage.el: 'Γρήγορη Απάντηση',
            AppLanguage.bg: 'Кратък отговор',
          },
          'bullets': {
            AppLanguage.tr: [
              'Düşme rüyası genellikle kontrol kaybı hissini yansıtır.',
              'Hayatta bir şeylerin elimizden kaydığını düşündüğümüzde ortaya çıkar.',
              'Düşerken uyanmak, bilinçaltının seni uyandırma refleksidir.',
            ],
            AppLanguage.en: [
              'Falling dreams usually reflect a feeling of losing control.',
              'They appear when we feel something is slipping away in life.',
              'Waking up while falling is your subconscious reflex to wake you.',
            ],
            AppLanguage.de: [
              'Fallträume spiegeln meist ein Gefühl des Kontrollverlusts wider.',
              'Sie treten auf, wenn wir das Gefühl haben, dass etwas entgleitet.',
              'Das Aufwachen beim Fallen ist ein Reflex des Unterbewusstseins.',
            ],
            AppLanguage.fr: [
              'Les rêves de chute reflètent généralement une perte de contrôle.',
              'Ils apparaissent quand nous sentons que quelque chose nous échappe.',
              'Se réveiller en tombant est un réflexe de votre subconscient.',
            ],
            AppLanguage.es: [
              'Los sueños de caída suelen reflejar una sensación de pérdida de control.',
              'Aparecen cuando sentimos que algo se nos escapa en la vida.',
              'Despertar mientras caes es un reflejo de tu subconsciente.',
            ],
            AppLanguage.ru: [
              'Сны о падении обычно отражают чувство потери контроля.',
              'Они появляются, когда мы чувствуем, что что-то ускользает.',
              'Просыпание во время падения — это рефлекс подсознания.',
            ],
            AppLanguage.zh: [
              '跌落的梦通常反映失控的感觉。',
              '当我们感到生活中有什么在溜走时，它们就会出现。',
              '跌落时醒来是你潜意识的反射。',
            ],
            AppLanguage.ar: [
              'أحلام السقوط عادة تعكس شعور فقدان السيطرة.',
              'تظهر عندما نشعر أن شيئاً ما يفلت منا في الحياة.',
              'الاستيقاظ أثناء السقوط هو رد فعل لا شعوري لإيقاظك.',
            ],
            AppLanguage.el: [
              'Τα όνειρα πτώσης συνήθως αντανακλούν την αίσθηση απώλειας ελέγχου.',
              'Εμφανίζονται όταν αισθανόμαστε ότι κάτι μας ξεφεύγει.',
              'Το ξύπνημα κατά την πτώση είναι αντανακλαστικό του υποσυνείδητου.',
            ],
            AppLanguage.bg: [
              'Сънищата за падане обикновено отразяват чувство за загуба на контрол.',
              'Те се появяват, когато чувстваме, че нещо ни се изплъзва.',
              'Събуждането при падане е рефлекс на подсъзнанието.',
            ],
          },
        },
        {
          'title': {
            AppLanguage.tr: 'Ne Anlama Gelir?',
            AppLanguage.en: 'What Does It Mean?',
            AppLanguage.de: 'Was bedeutet es?',
            AppLanguage.fr: 'Que signifie-t-il?',
            AppLanguage.es: '¿Qué significa?',
            AppLanguage.ru: 'Что это значит?',
            AppLanguage.zh: '这意味着什么？',
            AppLanguage.ar: 'ماذا يعني؟',
            AppLanguage.el: 'Τι σημαίνει;',
            AppLanguage.bg: 'Какво означава?',
          },
          'bullets': {
            AppLanguage.tr: [
              'Belirsizlik dönemlerinde daha sık görülür.',
              'İş, ilişki veya sağlık konusunda endişe taşıyor olabilirsin.',
              'Düşüşün hızı, kaygının yoğunluğunu gösterir.',
            ],
            AppLanguage.en: [
              'More common during periods of uncertainty.',
              'You may be worried about work, relationships, or health.',
              'The speed of the fall indicates the intensity of anxiety.',
            ],
            AppLanguage.de: [
              'Häufiger in Zeiten der Unsicherheit.',
              'Sie könnten sich um Arbeit, Beziehungen oder Gesundheit sorgen.',
              'Die Fallgeschwindigkeit zeigt die Intensität der Angst.',
            ],
            AppLanguage.fr: [
              'Plus fréquent pendant les périodes d\'incertitude.',
              'Vous pourriez être inquiet pour le travail, les relations ou la santé.',
              'La vitesse de la chute indique l\'intensité de l\'anxiété.',
            ],
            AppLanguage.es: [
              'Más común durante períodos de incertidumbre.',
              'Puedes estar preocupado por el trabajo, las relaciones o la salud.',
              'La velocidad de la caída indica la intensidad de la ansiedad.',
            ],
            AppLanguage.ru: [
              'Чаще встречается в периоды неопределённости.',
              'Вы можете беспокоиться о работе, отношениях или здоровье.',
              'Скорость падения указывает на интенсивность тревоги.',
            ],
            AppLanguage.zh: ['在不确定时期更常见。', '你可能在担心工作、关系或健康。', '下落的速度表示焦虑的强度。'],
            AppLanguage.ar: [
              'أكثر شيوعاً خلال فترات عدم اليقين.',
              'قد تكون قلقاً بشأن العمل أو العلاقات أو الصحة.',
              'سرعة السقوط تشير إلى شدة القلق.',
            ],
            AppLanguage.el: [
              'Πιο συχνά σε περιόδους αβεβαιότητας.',
              'Μπορεί να ανησυχείτε για τη δουλειά, τις σχέσεις ή την υγεία.',
              'Η ταχύτητα της πτώσης δείχνει την ένταση του άγχους.',
            ],
            AppLanguage.bg: [
              'По-чести в периоди на несигурност.',
              'Може да се притеснявате за работа, връзки или здраве.',
              'Скоростта на падане показва интензивността на тревогата.',
            ],
          },
        },
        {
          'title': {
            AppLanguage.tr: 'Hangi Duyguyu Taşır?',
            AppLanguage.en: 'What Emotion Does It Carry?',
            AppLanguage.de: 'Welche Emotion trägt es?',
            AppLanguage.fr: 'Quelle émotion porte-t-il?',
            AppLanguage.es: '¿Qué emoción lleva?',
            AppLanguage.ru: 'Какую эмоцию несёт?',
            AppLanguage.zh: '它承载什么情感？',
            AppLanguage.ar: 'ما المشاعر التي يحملها؟',
            AppLanguage.el: 'Τι συναίσθημα φέρει;',
            AppLanguage.bg: 'Каква емоция носи?',
          },
          'bullets': {
            AppLanguage.tr: [
              'Güvensizlik veya yetersizlik hissi.',
              'Başarısızlık korkusu.',
              'Destek arayışı.',
            ],
            AppLanguage.en: [
              'Feelings of insecurity or inadequacy.',
              'Fear of failure.',
              'Seeking support.',
            ],
            AppLanguage.de: [
              'Gefühle von Unsicherheit oder Unzulänglichkeit.',
              'Angst vor dem Scheitern.',
              'Suche nach Unterstützung.',
            ],
            AppLanguage.fr: [
              'Sentiments d\'insécurité ou d\'insuffisance.',
              'Peur de l\'échec.',
              'Recherche de soutien.',
            ],
            AppLanguage.es: [
              'Sentimientos de inseguridad o inadecuación.',
              'Miedo al fracaso.',
              'Búsqueda de apoyo.',
            ],
            AppLanguage.ru: [
              'Чувство неуверенности или неполноценности.',
              'Страх неудачи.',
              'Поиск поддержки.',
            ],
            AppLanguage.zh: ['不安全感或不足感。', '害怕失败。', '寻求支持。'],
            AppLanguage.ar: [
              'مشاعر عدم الأمان أو عدم الكفاءة.',
              'الخوف من الفشل.',
              'البحث عن الدعم.',
            ],
            AppLanguage.el: [
              'Αισθήματα ανασφάλειας ή ανεπάρκειας.',
              'Φόβος αποτυχίας.',
              'Αναζήτηση υποστήριξης.',
            ],
            AppLanguage.bg: [
              'Чувство на несигурност или неадекватност.',
              'Страх от провал.',
              'Търсене на подкрепа.',
            ],
          },
        },
        {
          'title': {
            AppLanguage.tr: 'Tekrar Ediyorsa',
            AppLanguage.en: 'If It Recurs',
            AppLanguage.de: 'Wenn es sich wiederholt',
            AppLanguage.fr: 'Si cela se répète',
            AppLanguage.es: 'Si se repite',
            AppLanguage.ru: 'Если повторяется',
            AppLanguage.zh: '如果反复出现',
            AppLanguage.ar: 'إذا تكرر',
            AppLanguage.el: 'Αν επαναλαμβάνεται',
            AppLanguage.bg: 'Ако се повтаря',
          },
          'bullets': {
            AppLanguage.tr: [
              'Çözülmemiş bir kaygı işaret eder.',
              'Hayatında neyin seni dengesiz hissettirdiğine bak.',
              'Kontrol edemediğin durumları kabul etmek rahatlatabilir.',
            ],
            AppLanguage.en: [
              'It points to unresolved anxiety.',
              'Look at what makes you feel unbalanced in life.',
              'Accepting situations you can\'t control may help.',
            ],
            AppLanguage.de: [
              'Es deutet auf ungelöste Ängste hin.',
              'Schauen Sie, was Sie im Leben aus dem Gleichgewicht bringt.',
              'Das Akzeptieren unkontrollierbarer Situationen kann helfen.',
            ],
            AppLanguage.fr: [
              'Cela indique une anxiété non résolue.',
              'Regardez ce qui vous déséquilibre dans la vie.',
              'Accepter les situations incontrôlables peut aider.',
            ],
            AppLanguage.es: [
              'Indica ansiedad no resuelta.',
              'Mira qué te hace sentir desequilibrado en la vida.',
              'Aceptar situaciones que no puedes controlar puede ayudar.',
            ],
            AppLanguage.ru: [
              'Указывает на неразрешённую тревогу.',
              'Посмотрите, что выбивает вас из равновесия.',
              'Принятие неконтролируемых ситуаций может помочь.',
            ],
            AppLanguage.zh: [
              '它指向未解决的焦虑。',
              '看看生活中是什么让你感到不平衡。',
              '接受你无法控制的情况可能会有帮助。',
            ],
            AppLanguage.ar: [
              'يشير إلى قلق لم يُحل.',
              'انظر إلى ما يجعلك تشعر بعدم التوازن في الحياة.',
              'قبول المواقف التي لا يمكنك التحكم بها قد يساعد.',
            ],
            AppLanguage.el: [
              'Υποδεικνύει αδιευκρίνιστο άγχος.',
              'Δείτε τι σας κάνει να νιώθετε ανισόρροπος.',
              'Η αποδοχή καταστάσεων που δεν ελέγχετε μπορεί να βοηθήσει.',
            ],
            AppLanguage.bg: [
              'Посочва неразрешена тревожност.',
              'Вижте какво ви кара да се чувствате неустойчиви.',
              'Приемането на неконтролируеми ситуации може да помогне.',
            ],
          },
        },
      ],
      'suggestion': {
        'emoji': '💧',
        'text': {
          AppLanguage.tr: 'Rüyada su görmek ne anlama gelir?',
          AppLanguage.en: 'What does water in a dream mean?',
          AppLanguage.de: 'Was bedeutet Wasser im Traum?',
          AppLanguage.fr: 'Que signifie l\'eau dans un rêve?',
          AppLanguage.es: '¿Qué significa el agua en un sueño?',
          AppLanguage.ru: 'Что означает вода во сне?',
          AppLanguage.zh: '梦见水是什么意思？',
          AppLanguage.ar: 'ماذا يعني الماء في الحلم؟',
          AppLanguage.el: 'Τι σημαίνει το νερό στο όνειρο;',
          AppLanguage.bg: 'Какво означава вода в съня?',
        },
        'route': '/ruya/su-gormek',
      },
    },
    'water': {
      'title': {
        AppLanguage.tr: 'Rüyada su görmek ne anlama gelir?',
        AppLanguage.en: 'What does water in a dream mean?',
        AppLanguage.de: 'Was bedeutet Wasser im Traum?',
        AppLanguage.fr: 'Que signifie l\'eau dans un rêve?',
        AppLanguage.es: '¿Qué significa el agua en un sueño?',
        AppLanguage.ru: 'Что означает вода во сне?',
        AppLanguage.zh: '梦见水是什么意思？',
        AppLanguage.ar: 'ماذا يعني الماء في الحلم؟',
        AppLanguage.el: 'Τι σημαίνει το νερό στο όνειρο;',
        AppLanguage.bg: 'Какво означава вода в съня?',
      },
      'sections': [
        {
          'title': {
            AppLanguage.tr: 'Kısa Cevap',
            AppLanguage.en: 'Quick Answer',
            AppLanguage.de: 'Kurze Antwort',
            AppLanguage.fr: 'Réponse Rapide',
            AppLanguage.es: 'Respuesta Rápida',
            AppLanguage.ru: 'Краткий ответ',
            AppLanguage.zh: '简短回答',
            AppLanguage.ar: 'إجابة سريعة',
            AppLanguage.el: 'Γρήγορη Απάντηση',
            AppLanguage.bg: 'Кратък отговор',
          },
          'bullets': {
            AppLanguage.tr: [
              'Su, bilinçaltını ve duyguları simgeler.',
              'Suyun durumu, iç dünyanın durumunu yansıtır.',
              'Durgun su huzuru, dalgalı su karmaşayı gösterir.',
            ],
            AppLanguage.en: [
              'Water symbolizes the subconscious and emotions.',
              'The state of water reflects your inner world.',
              'Still water shows peace, turbulent water shows turmoil.',
            ],
            AppLanguage.de: [
              'Wasser symbolisiert das Unterbewusstsein und Emotionen.',
              'Der Zustand des Wassers spiegelt Ihre innere Welt wider.',
              'Ruhiges Wasser zeigt Frieden, unruhiges Wasser Aufruhr.',
            ],
            AppLanguage.fr: [
              'L\'eau symbolise le subconscient et les émotions.',
              'L\'état de l\'eau reflète votre monde intérieur.',
              'L\'eau calme montre la paix, l\'eau agitée le tumulte.',
            ],
            AppLanguage.es: [
              'El agua simboliza el subconsciente y las emociones.',
              'El estado del agua refleja tu mundo interior.',
              'Agua tranquila muestra paz, agua turbulenta muestra tormento.',
            ],
            AppLanguage.ru: [
              'Вода символизирует подсознание и эмоции.',
              'Состояние воды отражает ваш внутренний мир.',
              'Спокойная вода — мир, бурная вода — смятение.',
            ],
            AppLanguage.zh: [
              '水象征潜意识和情感。',
              '水的状态反映你的内心世界。',
              '平静的水显示和平，汹涌的水显示动荡。',
            ],
            AppLanguage.ar: [
              'الماء يرمز إلى اللاوعي والمشاعر.',
              'حالة الماء تعكس عالمك الداخلي.',
              'الماء الهادئ يظهر السلام، الماء المضطرب يظهر الاضطراب.',
            ],
            AppLanguage.el: [
              'Το νερό συμβολίζει το υποσυνείδητο και τα συναισθήματα.',
              'Η κατάσταση του νερού αντανακλά τον εσωτερικό σας κόσμο.',
              'Ήρεμο νερό δείχνει γαλήνη, ταραγμένο νερό αναταραχή.',
            ],
            AppLanguage.bg: [
              'Водата символизира подсъзнанието и емоциите.',
              'Състоянието на водата отразява вътрешния ви свят.',
              'Спокойна вода показва мир, бурна вода показва смут.',
            ],
          },
        },
      ],
      'suggestion': {
        'emoji': '🔄',
        'text': {
          AppLanguage.tr: 'Tekrar eden rüyalar neden olur?',
          AppLanguage.en: 'Why do recurring dreams happen?',
          AppLanguage.de: 'Warum treten wiederkehrende Träume auf?',
          AppLanguage.fr: 'Pourquoi les rêves récurrents se produisent-ils?',
          AppLanguage.es: '¿Por qué ocurren los sueños recurrentes?',
          AppLanguage.ru: 'Почему снятся повторяющиеся сны?',
          AppLanguage.zh: '为什么会做重复的梦？',
          AppLanguage.ar: 'لماذا تحدث الأحلام المتكررة؟',
          AppLanguage.el: 'Γιατί συμβαίνουν επαναλαμβανόμενα όνειρα;',
          AppLanguage.bg: 'Защо се случват повтарящи се сънища?',
        },
        'route': '/ruya/tekrar-eden',
      },
    },
  };
}

/// Data class for dream content
class DreamContentData {
  final String title;
  final List<DreamSection> sections;
  final DreamSuggestion suggestion;

  const DreamContentData({
    required this.title,
    required this.sections,
    required this.suggestion,
  });

  factory DreamContentData.empty() => const DreamContentData(
    title: '',
    sections: [],
    suggestion: DreamSuggestion(emoji: '', text: '', route: ''),
  );
}

/// Data class for dream section
class DreamSection {
  final String title;
  final List<String> bullets;

  const DreamSection({required this.title, required this.bullets});
}

/// Data class for dream suggestion
class DreamSuggestion {
  final String emoji;
  final String text;
  final String route;

  const DreamSuggestion({
    required this.emoji,
    required this.text,
    required this.route,
  });
}

/// UI helper translations
class DreamUIStrings {
  DreamUIStrings._();

  static String getExploreAlso(AppLanguage language) {
    return _exploreAlso[language] ?? _exploreAlso[AppLanguage.en]!;
  }

  static String getBrandText(AppLanguage language) {
    return _brandText[language] ?? _brandText[AppLanguage.en]!;
  }

  static const Map<AppLanguage, String> _exploreAlso = {
    AppLanguage.tr: 'Bunu da keşfet',
    AppLanguage.en: 'Explore also',
    AppLanguage.de: 'Entdecke auch',
    AppLanguage.fr: 'Découvrez aussi',
    AppLanguage.es: 'Explora también',
    AppLanguage.ru: 'Также исследуйте',
    AppLanguage.zh: '也探索',
    AppLanguage.ar: 'اكتشف أيضاً',
    AppLanguage.el: 'Εξερευνήστε επίσης',
    AppLanguage.bg: 'Открийте също',
  };

  static const Map<AppLanguage, String> _brandText = {
    AppLanguage.tr: 'Rüya İzi — Venus One',
    AppLanguage.en: 'Dream Trace — Venus One',
    AppLanguage.de: 'Traumspur — Venus One',
    AppLanguage.fr: 'Trace de Rêve — Venus One',
    AppLanguage.es: 'Huella del Sueño — Venus One',
    AppLanguage.ru: 'След Сна — Venus One',
    AppLanguage.zh: '梦迹 — Venus One',
    AppLanguage.ar: 'أثر الحلم — Venus One',
    AppLanguage.el: 'Ίχνος Ονείρου — Venus One',
    AppLanguage.bg: 'Следа от Сън — Venus One',
  };
}
