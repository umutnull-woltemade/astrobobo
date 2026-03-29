// ════════════════════════════════════════════════════════════════════════════
// TRANSIT INTERPRETATIONS - Planet + House combinations
// ════════════════════════════════════════════════════════════════════════════
// Each slow-moving planet has a unique meaning when transiting each house.
// These interpretations are educational and reflective in tone.
// ════════════════════════════════════════════════════════════════════════════

import { HouseNumber, Planet, TransitInterpretation } from "./types";

type InterpretationKey = `${Planet}_${HouseNumber}`;

export const transitInterpretations: Partial<
  Record<InterpretationKey, TransitInterpretation>
> = {
  // ═══════════════════════════════════════
  // SATURN TRANSITS (2.5 year cycles)
  // ═══════════════════════════════════════
  saturn_1: {
    titleEn: "Saturn in Your 1st House — Rebuilding Identity",
    titleTr: "Satürn 1. Evinde — Kimliği Yeniden İnşa Etmek",
    bodyEn:
      "Saturn is crossing your rising sign, initiating a roughly 2.5-year period of serious self-reflection. You may feel a stronger sense of responsibility, a desire to mature, or the weight of expectations you place on yourself. This is a time for building a more authentic version of who you are — shedding roles that no longer fit and stepping into greater personal authority.",
    bodyTr:
      "Satürn yükselen burcunun üzerinden geçiyor ve yaklaşık 2.5 yıllık ciddi bir öz-yansıtma dönemi başlatıyor. Daha güçlü bir sorumluluk duygusu, olgunlaşma arzusu veya kendinize yüklediğiniz beklentilerin ağırlığını hissedebilirsiniz. Bu, artık size uymayan rolleri bırakıp daha otantik bir benliğe adım atma zamanı.",
    keywordsEn: ["identity", "maturity", "self-discipline", "restructuring"],
    keywordsTr: ["kimlik", "olgunluk", "öz-disiplin", "yeniden yapılanma"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_2: {
    titleEn: "Saturn in Your 2nd House — Financial Restructuring",
    titleTr: "Satürn 2. Evinde — Mali Yeniden Yapılanma",
    bodyEn:
      "Saturn is moving through your house of finances and values. This period asks you to get real about money, resources, and what you truly value. You may feel financial restrictions or a need to budget more carefully. The deeper lesson is about self-worth — learning that your value doesn't come from what you own, but from who you are.",
    bodyTr:
      "Satürn mali durum ve değerler evinizden geçiyor. Bu dönem, para, kaynaklar ve gerçekten neye değer verdiğiniz konusunda gerçekçi olmanızı istiyor. Mali kısıtlamalar veya daha dikkatli bütçe yapma ihtiyacı hissedebilirsiniz. Derin ders öz-değerle ilgili — değerinizin sahip olduklarınızdan değil, kim olduğunuzdan geldiğini öğrenmek.",
    keywordsEn: ["finances", "self-worth", "budgeting", "values"],
    keywordsTr: ["mali durum", "öz-değer", "bütçe", "değerler"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_3: {
    titleEn: "Saturn in Your 3rd House — Deepening Communication",
    titleTr: "Satürn 3. Evinde — İletişimi Derinleştirmek",
    bodyEn:
      "Saturn transiting your third house brings a more serious tone to how you communicate, learn, and connect with your immediate environment. You may find yourself choosing words more carefully, studying with greater discipline, or restructuring your relationship with siblings or neighbors. This is a time to master a skill or subject you've been circling around.",
    bodyTr:
      "Satürn'ün üçüncü evinizden geçişi, iletişim kurma, öğrenme ve yakın çevrenizle bağlantı kurma şeklinize daha ciddi bir ton getiriyor. Kelimelerinizi daha dikkatli seçtiğinizi, daha disiplinli çalıştığınızı veya kardeşleriniz ya da komşularınızla ilişkinizi yeniden yapılandırdığınızı görebilirsiniz.",
    keywordsEn: ["communication", "learning", "mental discipline", "siblings"],
    keywordsTr: ["iletişim", "öğrenme", "zihinsel disiplin", "kardeşler"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_4: {
    titleEn: "Saturn in Your 4th House — Home & Family Foundations",
    titleTr: "Satürn 4. Evinde — Ev ve Aile Temelleri",
    bodyEn:
      "Saturn is transiting your house of home and family, bringing themes of responsibility, boundaries, and emotional maturity to your domestic life. You may be dealing with family obligations, home renovations, or deep inner work about your roots. This transit asks you to build a solid emotional foundation for the next chapter of your life.",
    bodyTr:
      "Satürn ev ve aile evinizden geçiyor, ev hayatınıza sorumluluk, sınırlar ve duygusal olgunluk temaları getiriyor. Aile yükümlülükleri, ev tadilatları veya köklerinizle ilgili derin iç çalışmalarla uğraşıyor olabilirsiniz. Bu transit, hayatınızın bir sonraki bölümü için sağlam bir duygusal temel inşa etmenizi istiyor.",
    keywordsEn: ["home", "family", "emotional roots", "foundations"],
    keywordsTr: ["ev", "aile", "duygusal kökler", "temeller"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_5: {
    titleEn: "Saturn in Your 5th House — Creative Discipline",
    titleTr: "Satürn 5. Evinde — Yaratıcı Disiplin",
    bodyEn:
      "Saturn in your fifth house brings structure to creativity, romance, and self-expression. Fun may feel more serious or purposeful. If you're creative, this is when your art gets real — moving from hobby to craft. In romance, you may seek more meaningful connections rather than casual ones. If you have children, their needs may require more of your attention.",
    bodyTr:
      "Satürn beşinci evinizde yaratıcılık, romantizm ve kendini ifade etmeye yapı getiriyor. Eğlence daha ciddi veya amaçlı hissedebilir. Yaratıcıysanız, sanatınız gerçekleşiyor — hobiden zanaata geçiş zamanı. Romantizmde, gündelik yerine daha anlamlı bağlantılar arayabilirsiniz.",
    keywordsEn: ["creativity", "romance", "self-expression", "discipline"],
    keywordsTr: ["yaratıcılık", "romantizm", "kendini ifade", "disiplin"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_6: {
    titleEn: "Saturn in Your 6th House — Work & Health Transformation",
    titleTr: "Satürn 6. Evinde — İş ve Sağlık Dönüşümü",
    bodyEn:
      "Saturn transiting your sixth house puts a spotlight on your work routines, health habits, and daily service. You may feel increased responsibility at work, or a wake-up call about your health. This is the time to build sustainable routines rather than quick fixes. Your body and your work are asking for the same thing: discipline with compassion.",
    bodyTr:
      "Satürn'ün altıncı evinizden geçişi iş rutinlerinize, sağlık alışkanlıklarınıza ve günlük hizmetinize dikkat çekiyor. İşte artan sorumluluk veya sağlığınızla ilgili bir uyandırma çağrısı hissedebilirsiniz. Bu, hızlı çözümler yerine sürdürülebilir rutinler oluşturma zamanı. Bedeniniz ve işiniz aynı şeyi istiyor: şefkatli disiplin.",
    keywordsEn: ["work", "health", "routines", "service", "discipline"],
    keywordsTr: ["iş", "sağlık", "rutinler", "hizmet", "disiplin"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_7: {
    titleEn: "Saturn in Your 7th House — Relationship Maturity",
    titleTr: "Satürn 7. Evinde — İlişki Olgunluğu",
    bodyEn:
      "Saturn is transiting your house of partnerships and marriage. Relationships are tested and strengthened during this period. You may feel the need to set clearer boundaries, commit more seriously, or let go of partnerships that lack foundation. This is not about losing love — it's about building relationships that can bear real weight.",
    bodyTr:
      "Satürn ortaklıklar ve evlilik evinizden geçiyor. İlişkiler bu dönemde test ediliyor ve güçleniyor. Daha net sınırlar koyma, daha ciddi bağlanma veya temeli olmayan ortaklıklardan vazgeçme ihtiyacı hissedebilirsiniz. Bu aşkı kaybetmekle ilgili değil — gerçek ağırlık taşıyabilecek ilişkiler inşa etmekle ilgili.",
    keywordsEn: ["partnerships", "commitment", "boundaries", "maturity"],
    keywordsTr: ["ortaklıklar", "bağlılık", "sınırlar", "olgunluk"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_8: {
    titleEn: "Saturn in Your 8th House — Deep Transformation",
    titleTr: "Satürn 8. Evinde — Derin Dönüşüm",
    bodyEn:
      "Saturn transiting your eighth house triggers deep psychological transformation. Themes of shared finances, intimacy, loss, and regeneration surface with intensity. You may need to restructure debts, face fears about vulnerability, or deal with inheritance matters. The gift of this transit is profound inner strength forged through honest confrontation with what you usually avoid.",
    bodyTr:
      "Satürn'ün sekizinci evinizden geçişi derin psikolojik dönüşümü tetikliyor. Ortak mali konular, yakınlık, kayıp ve yenilenme temaları yoğunlukla yüzeye çıkıyor. Borçları yeniden yapılandırmanız, kırılganlıkla ilgili korkularla yüzleşmeniz veya miras konularıyla ilgilenmeniz gerekebilir.",
    keywordsEn: ["transformation", "shared resources", "psychology", "depth"],
    keywordsTr: ["dönüşüm", "ortak kaynaklar", "psikoloji", "derinlik"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_9: {
    titleEn: "Saturn in Your 9th House — Philosophical Grounding",
    titleTr: "Satürn 9. Evinde — Felsefi Temellendirme",
    bodyEn:
      "Saturn in your ninth house brings a more disciplined approach to your beliefs, education, and worldview. You may pursue formal studies, question long-held beliefs, or find that travel becomes more purposeful. This transit rewards structured learning and intellectual honesty — building a philosophy of life that actually holds up under pressure.",
    bodyTr:
      "Satürn dokuzuncu evinizde inançlarınıza, eğitiminize ve dünya görüşünüze daha disiplinli bir yaklaşım getiriyor. Resmi eğitim takip edebilir, uzun süredir taşıdığınız inançları sorgulayabilir veya seyahatin daha amaçlı hale geldiğini görebilirsiniz.",
    keywordsEn: ["beliefs", "education", "travel", "philosophy"],
    keywordsTr: ["inançlar", "eğitim", "seyahat", "felsefe"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_10: {
    titleEn: "Saturn in Your 10th House — Career Restructuring",
    titleTr: "Satürn 10. Evinde — Kariyer Yeniden Yapılanması",
    bodyEn:
      "Saturn is transiting your career house — the most visible area of your chart. This is a defining period for your professional life. You may take on greater responsibilities, face career challenges that test your resolve, or fundamentally restructure your ambitions. Success during this transit is earned, not given. The pressure you feel is shaping you into someone capable of real authority.",
    bodyTr:
      "Satürn kariyer evinizden geçiyor — haritanızın en görünür alanı. Bu, profesyonel hayatınız için belirleyici bir dönem. Daha büyük sorumluluklar üstlenebilir, kararlılığınızı test eden kariyer zorluklarıyla yüzleşebilir veya hırslarınızı temelden yeniden yapılandırabilirsiniz. Bu transitte başarı verilmez, kazanılır.",
    keywordsEn: ["career", "ambition", "authority", "public image"],
    keywordsTr: ["kariyer", "hırs", "otorite", "kamusal imaj"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_11: {
    titleEn: "Saturn in Your 11th House — Community & Vision",
    titleTr: "Satürn 11. Evinde — Topluluk ve Vizyon",
    bodyEn:
      "Saturn transiting your eleventh house restructures your social circle, friendships, and future vision. Some friendships may feel heavy or fall away — the ones that remain will be more meaningful. Your hopes and dreams are being tested for realism. This is the time to join or build a community aligned with your genuine values, not superficial connections.",
    bodyTr:
      "Satürn'ün on birinci evinizden geçişi sosyal çevrenizi, arkadaşlıklarınızı ve gelecek vizyonunuzu yeniden yapılandırıyor. Bazı arkadaşlıklar ağır hissedebilir veya düşebilir — kalanlar daha anlamlı olacak. Umutlarınız ve hayalleriniz gerçekçilik açısından test ediliyor.",
    keywordsEn: ["friendships", "community", "future goals", "social circle"],
    keywordsTr: ["arkadaşlıklar", "topluluk", "gelecek hedefleri", "sosyal çevre"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },
  saturn_12: {
    titleEn: "Saturn in Your 12th House — Inner Reckoning",
    titleTr: "Satürn 12. Evinde — İç Hesaplaşma",
    bodyEn:
      "Saturn in your twelfth house is one of the most profound transits — a period of inner reckoning before Saturn returns to your first house. Hidden fears, unresolved grief, and subconscious patterns surface for integration. You may need more solitude, feel a pull toward spiritual practice, or face the consequences of past actions. This is the cocoon before the butterfly.",
    bodyTr:
      "Satürn on ikinci evinizde en derin transitlerden biri — Satürn birinci evinize dönmeden önceki iç hesaplaşma dönemi. Gizli korkular, çözülmemiş yas ve bilinçaltı kalıplar bütünleşme için yüzeye çıkıyor. Daha fazla yalnızlığa ihtiyaç duyabilir, manevi pratiğe çekilebilir veya geçmiş eylemlerin sonuçlarıyla yüzleşebilirsiniz.",
    keywordsEn: ["spirituality", "solitude", "subconscious", "release"],
    keywordsTr: ["maneviyat", "yalnızlık", "bilinçaltı", "bırakma"],
    durationEn: "~2.5 years",
    durationTr: "~2.5 yıl",
  },

  // ═══════════════════════════════════════
  // JUPITER TRANSITS (~1 year cycles)
  // ═══════════════════════════════════════
  jupiter_1: {
    titleEn: "Jupiter in Your 1st House — Personal Expansion",
    titleTr: "Jüpiter 1. Evinde — Kişisel Genişleme",
    bodyEn:
      "Jupiter entering your first house brings a wave of optimism, growth, and new opportunities to express yourself. You may feel more confident, take on a new look, or attract attention more easily. This is a year to say yes to growth — just watch for overcommitting.",
    bodyTr:
      "Jüpiter birinci evinize girerek bir iyimserlik, büyüme ve kendinizi ifade etme fırsatları dalgası getiriyor. Kendinizi daha özgüvenli hissedebilir, yeni bir görünüm benimseyebilir veya dikkatleri daha kolay çekebilirsiniz.",
    keywordsEn: ["growth", "confidence", "opportunity", "visibility"],
    keywordsTr: ["büyüme", "özgüven", "fırsat", "görünürlük"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_2: {
    titleEn: "Jupiter in Your 2nd House — Financial Growth",
    titleTr: "Jüpiter 2. Evinde — Mali Büyüme",
    bodyEn:
      "Jupiter transiting your second house can expand your income potential and deepen your sense of self-worth. New earning opportunities may arise. The key is to grow sustainably rather than spending as fast as you earn. Your values are expanding too — what matters to you may shift.",
    bodyTr:
      "Jüpiter'in ikinci evinizden geçişi gelir potansiyelinizi genişletebilir ve öz-değer duygunuzu derinleştirebilir. Yeni kazanç fırsatları ortaya çıkabilir. Anahtar, kazandığınız kadar hızlı harcamak yerine sürdürülebilir büyümektir.",
    keywordsEn: ["income", "values", "abundance", "self-worth"],
    keywordsTr: ["gelir", "değerler", "bolluk", "öz-değer"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_3: {
    titleEn: "Jupiter in Your 3rd House — Intellectual Expansion",
    titleTr: "Jüpiter 3. Evinde — Entelektüel Genişleme",
    bodyEn:
      "Jupiter in your third house expands your mental horizons. You may take up a new course, start writing, or find yourself in more stimulating conversations. Short trips bring luck. Relationships with siblings or neighbors may improve. Your mind is hungry — feed it well.",
    bodyTr:
      "Jüpiter üçüncü evinizde zihinsel ufuklarınızı genişletiyor. Yeni bir kursa başlayabilir, yazmaya yönelebilir veya daha uyarıcı sohbetler içinde bulabilirsiniz. Kısa seyahatler şans getiriyor.",
    keywordsEn: ["learning", "communication", "curiosity", "short travel"],
    keywordsTr: ["öğrenme", "iletişim", "merak", "kısa seyahat"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_4: {
    titleEn: "Jupiter in Your 4th House — Home Blessings",
    titleTr: "Jüpiter 4. Evinde — Ev Bereketi",
    bodyEn:
      "Jupiter transiting your fourth house brings warmth and growth to your home and family life. You may move to a bigger place, renovate, or experience a deeper sense of belonging. Family relationships can heal. This is an excellent time to create the living environment you've always wanted.",
    bodyTr:
      "Jüpiter'in dördüncü evinizden geçişi ev ve aile hayatınıza sıcaklık ve büyüme getiriyor. Daha büyük bir yere taşınabilir, tadilat yapabilir veya daha derin bir aidiyet duygusu yaşayabilirsiniz. Aile ilişkileri iyileşebilir.",
    keywordsEn: ["home", "family", "comfort", "belonging"],
    keywordsTr: ["ev", "aile", "konfor", "aidiyet"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_5: {
    titleEn: "Jupiter in Your 5th House — Creative Joy",
    titleTr: "Jüpiter 5. Evinde — Yaratıcı Neşe",
    bodyEn:
      "Jupiter in your fifth house is one of the most joyful transits. Creativity flows, romance sparkles, and life feels more playful. If you've been holding back your creative expression, this is the year to let it out. Children may bring special joy. Take the risk to express your authentic self.",
    bodyTr:
      "Jüpiter beşinci evinizde en neşeli transitlerden biri. Yaratıcılık akıyor, romantizm parlıyor ve hayat daha oyuncu hissediyor. Yaratıcı ifadenizi bastırıyorsanız, bu yıl onu serbest bırakma zamanı.",
    keywordsEn: ["creativity", "joy", "romance", "self-expression"],
    keywordsTr: ["yaratıcılık", "neşe", "romantizm", "kendini ifade"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_6: {
    titleEn: "Jupiter in Your 6th House — Health & Work Growth",
    titleTr: "Jüpiter 6. Evinde — Sağlık ve İş Büyümesi",
    bodyEn:
      "Jupiter in your sixth house brings positive energy to your work environment and health routines. You may find a better job, get a promotion, or discover a health practice that transforms your daily life. Helpers and opportunities appear in everyday settings. Small improvements compound into big changes.",
    bodyTr:
      "Jüpiter altıncı evinizde iş ortamınıza ve sağlık rutinlerinize pozitif enerji getiriyor. Daha iyi bir iş bulabilir, terfi alabilir veya günlük hayatınızı dönüştüren bir sağlık uygulaması keşfedebilirsiniz.",
    keywordsEn: ["health", "work", "improvement", "daily routine"],
    keywordsTr: ["sağlık", "iş", "gelişim", "günlük rutin"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_7: {
    titleEn: "Jupiter in Your 7th House — Partnership Blessings",
    titleTr: "Jüpiter 7. Evinde — Ortaklık Bereketi",
    bodyEn:
      "Jupiter transiting your seventh house expands your relationships. You may meet a significant partner, deepen an existing relationship, or benefit from collaborations. Others bring you luck during this transit. The key is to stay open to what relationships can teach you.",
    bodyTr:
      "Jüpiter'in yedinci evinizden geçişi ilişkilerinizi genişletiyor. Önemli bir partnerle tanışabilir, mevcut bir ilişkiyi derinleştirebilir veya iş birliklerinden fayda görebilirsiniz.",
    keywordsEn: ["partnership", "marriage", "collaboration", "growth"],
    keywordsTr: ["ortaklık", "evlilik", "iş birliği", "büyüme"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_8: {
    titleEn: "Jupiter in Your 8th House — Transformative Abundance",
    titleTr: "Jüpiter 8. Evinde — Dönüştürücü Bolluk",
    bodyEn:
      "Jupiter in your eighth house can bring financial benefits through others — inheritance, investments, or shared resources. On a deeper level, this transit supports psychological growth and healing. You may feel drawn to explore taboo topics, the occult, or deep therapeutic work. Transformation brings gifts.",
    bodyTr:
      "Jüpiter sekizinci evinizde başkaları aracılığıyla mali faydalar getirebilir — miras, yatırımlar veya ortak kaynaklar. Daha derin bir düzeyde, bu transit psikolojik büyüme ve iyileşmeyi destekliyor.",
    keywordsEn: ["transformation", "shared wealth", "depth", "healing"],
    keywordsTr: ["dönüşüm", "ortak servet", "derinlik", "iyileşme"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_9: {
    titleEn: "Jupiter in Your 9th House — Expansion of Horizons",
    titleTr: "Jüpiter 9. Evinde — Ufukların Genişlemesi",
    bodyEn:
      "Jupiter is at home in your ninth house, making this one of the luckiest transits. Travel, higher education, publishing, and spiritual growth are all favored. Your worldview is expanding — embrace new philosophies, cultures, and experiences. This is the year to think bigger than you normally allow yourself.",
    bodyTr:
      "Jüpiter dokuzuncu evinizde evinde, bu onu en şanslı transitlerden biri yapıyor. Seyahat, yüksek eğitim, yayıncılık ve manevi büyüme hepsi destekleniyor. Dünya görüşünüz genişliyor — yeni felsefeleri, kültürleri ve deneyimleri kucaklayın.",
    keywordsEn: ["travel", "education", "philosophy", "expansion"],
    keywordsTr: ["seyahat", "eğitim", "felsefe", "genişleme"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_10: {
    titleEn: "Jupiter in Your 10th House — Career Peak",
    titleTr: "Jüpiter 10. Evinde — Kariyer Zirvesi",
    bodyEn:
      "Jupiter transiting your tenth house is a career highlight. Professional recognition, promotions, and new opportunities come your way. Your reputation grows. This is the time to aim high and put yourself out there. The world is more receptive to your ambitions right now than it has been in years.",
    bodyTr:
      "Jüpiter'in onuncu evinizden geçişi bir kariyer doruk noktası. Profesyonel tanınma, terfiler ve yeni fırsatlar yolunuza çıkıyor. İtibarınız büyüyor. Yıllardır olmadığı kadar dünya hırslarınıza daha açık.",
    keywordsEn: ["career peak", "recognition", "promotion", "ambition"],
    keywordsTr: ["kariyer zirvesi", "tanınma", "terfi", "hırs"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_11: {
    titleEn: "Jupiter in Your 11th House — Social Expansion",
    titleTr: "Jüpiter 11. Evinde — Sosyal Genişleme",
    bodyEn:
      "Jupiter in your eleventh house expands your social circle and brings new friendships, group opportunities, and a renewed sense of hope for the future. You may join organizations, find your tribe, or see long-held wishes start to manifest. The network you build now supports your next chapter.",
    bodyTr:
      "Jüpiter on birinci evinizde sosyal çevrenizi genişletiyor ve yeni arkadaşlıklar, grup fırsatları ve gelecek için yenilenmiş bir umut duygusu getiriyor. Örgütlere katılabilir, kabilenizi bulabilir veya uzun süredir taşıdığınız dileklerin gerçekleşmeye başladığını görebilirsiniz.",
    keywordsEn: ["friendships", "groups", "wishes", "social growth"],
    keywordsTr: ["arkadaşlıklar", "gruplar", "dilekler", "sosyal büyüme"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },
  jupiter_12: {
    titleEn: "Jupiter in Your 12th House — Spiritual Growth",
    titleTr: "Jüpiter 12. Evinde — Manevi Büyüme",
    bodyEn:
      "Jupiter in your twelfth house is a quiet but powerful transit. Spiritual growth, inner peace, and behind-the-scenes blessings characterize this period. You may feel drawn to meditation, retreats, or charitable work. Hidden support comes from unexpected places. Trust the process even when growth isn't visible to others.",
    bodyTr:
      "Jüpiter on ikinci evinizde sessiz ama güçlü bir transit. Manevi büyüme, iç huzur ve perde arkası bereketler bu dönemi karakterize ediyor. Meditasyona, inzivaya veya hayır işlerine çekilebilirsiniz.",
    keywordsEn: ["spirituality", "inner peace", "hidden blessings", "retreat"],
    keywordsTr: ["maneviyat", "iç huzur", "gizli bereketler", "inziva"],
    durationEn: "~1 year",
    durationTr: "~1 yıl",
  },

  // ═══════════════════════════════════════
  // PLUTO TRANSITS (long-term generational)
  // ═══════════════════════════════════════
  pluto_1: {
    titleEn: "Pluto in Your 1st House — Total Rebirth",
    titleTr: "Plüton 1. Evinde — Tam Yeniden Doğuş",
    bodyEn:
      "Pluto transiting your first house is one of the most transformative periods of your entire life. Your identity, appearance, and personal power undergo deep metamorphosis. You are not the same person you were when this transit began — and that is the point.",
    bodyTr:
      "Plüton'un birinci evinizden geçişi tüm hayatınızın en dönüştürücü dönemlerinden biri. Kimliğiniz, görünüşünüz ve kişisel gücünüz derin bir metamorfozdan geçiyor.",
    keywordsEn: ["rebirth", "power", "identity transformation", "depth"],
    keywordsTr: ["yeniden doğuş", "güç", "kimlik dönüşümü", "derinlik"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_2: {
    titleEn: "Pluto in Your 2nd House — Value Revolution",
    titleTr: "Plüton 2. Evinde — Değer Devrimi",
    bodyEn:
      "Pluto in your second house transforms your relationship with money, possessions, and self-worth at the deepest level. Financial upheavals may occur, but they ultimately lead to a more empowered relationship with resources.",
    bodyTr:
      "Plüton ikinci evinizde para, mülkler ve öz-değerle ilişkinizi en derin düzeyde dönüştürüyor. Mali sarsıntılar yaşanabilir, ancak nihayetinde kaynaklarla daha güçlü bir ilişkiye yol açarlar.",
    keywordsEn: ["financial transformation", "values", "power over resources"],
    keywordsTr: ["mali dönüşüm", "değerler", "kaynaklar üzerinde güç"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_3: {
    titleEn: "Pluto in Your 3rd House — Mind Transformation",
    titleTr: "Plüton 3. Evinde — Zihin Dönüşümü",
    bodyEn:
      "Pluto transiting your third house transforms how you think, communicate, and process information. Your mind becomes more penetrating and investigative. Relationships with siblings may undergo intense changes. You learn to speak with power and precision.",
    bodyTr:
      "Plüton'un üçüncü evinizden geçişi düşünme, iletişim kurma ve bilgi işleme şeklinizi dönüştürüyor. Zihniniz daha keskin ve araştırmacı hale geliyor.",
    keywordsEn: ["mental power", "deep communication", "investigation"],
    keywordsTr: ["zihinsel güç", "derin iletişim", "araştırma"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_4: {
    titleEn: "Pluto in Your 4th House — Root Transformation",
    titleTr: "Plüton 4. Evinde — Kök Dönüşümü",
    bodyEn:
      "Pluto transiting your fourth house digs into the deepest layers of your emotional foundation. Family secrets may surface, your relationship to home transforms radically, and you confront inherited patterns that have shaped you unconsciously. This is the demolition and rebuilding of your inner world — painful but ultimately liberating.",
    bodyTr:
      "Plüton dördüncü evinizden geçerken duygusal temelinizin en derin katmanlarını kazıyor. Aile sırları yüzeye çıkabilir, ev ile ilişkiniz kökten dönüşür ve sizi bilinçsizce şekillendiren kalıtsal kalıplarla yüzleşirsiniz. Bu, iç dünyanızın yıkılıp yeniden inşası — acı verici ama nihayetinde özgürleştirici.",
    keywordsEn: ["family secrets", "emotional depth", "ancestral patterns", "home transformation"],
    keywordsTr: ["aile sırları", "duygusal derinlik", "atalardan gelen kalıplar", "ev dönüşümü"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_5: {
    titleEn: "Pluto in Your 5th House — Creative Rebirth",
    titleTr: "Plüton 5. Evinde — Yaratıcı Yeniden Doğuş",
    bodyEn:
      "Pluto in your fifth house transforms your creative expression, your experience of romance, and your relationship with joy itself. Creative projects become obsessions that reshape you. Romantic relationships are intense, magnetic, and sometimes all-consuming. You discover what truly brings you alive — and what was only performing happiness.",
    bodyTr:
      "Plüton beşinci evinizde yaratıcı ifadenizi, romantizm deneyiminizi ve sevinçle ilişkinizi dönüştürüyor. Yaratıcı projeler sizi yeniden şekillendiren takıntılara dönüşür. Romantik ilişkiler yoğun, manyetik ve bazen her şeyi kapsayıcı olur. Sizi gerçekten neyin canlandırdığını keşfedersiniz.",
    keywordsEn: ["creative obsession", "intense romance", "authentic joy", "self-discovery"],
    keywordsTr: ["yaratıcı tutku", "yoğun romantizm", "otantik sevinç", "kendini keşif"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_6: {
    titleEn: "Pluto in Your 6th House — Work & Health Overhaul",
    titleTr: "Plüton 6. Evinde — İş ve Sağlık Revizyonu",
    bodyEn:
      "Pluto transiting your sixth house transforms your daily existence — work, health, and routines undergo complete overhaul. You may experience health crises that force total lifestyle change, or power dynamics at work that push you to reclaim your authority. The mundane becomes the arena of your deepest transformation.",
    bodyTr:
      "Plüton altıncı evinizden geçerken günlük varoluşunuzu dönüştürüyor — iş, sağlık ve rutinler tamamen revize ediliyor. Tamamen yaşam tarzı değişikliği zorlayan sağlık krizleri veya otoritenizi geri almanızı gerektiren iş yerindeki güç dinamikleri yaşayabilirsiniz.",
    keywordsEn: ["health crisis", "work power dynamics", "lifestyle overhaul", "daily transformation"],
    keywordsTr: ["sağlık krizi", "iş güç dinamikleri", "yaşam tarzı revizyonu", "günlük dönüşüm"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_7: {
    titleEn: "Pluto in Your 7th House — Relationship Metamorphosis",
    titleTr: "Plüton 7. Evinde — İlişki Metamorfozu",
    bodyEn:
      "Pluto in your seventh house transforms partnerships at the most fundamental level. Relationships become arenas for power dynamics, deep intimacy, and personal evolution. You may attract powerful partners or need to confront control issues. The partnerships that survive this transit become unbreakable — those that don't were built on illusion.",
    bodyTr:
      "Plüton yedinci evinizde ortaklıkları en temel düzeyde dönüştürüyor. İlişkiler güç dinamikleri, derin yakınlık ve kişisel evrim arenalarına dönüşüyor. Güçlü partnerler çekebilir veya kontrol sorunlarıyla yüzleşmeniz gerekebilir. Bu transitten sağ çıkan ortaklıklar kırılmaz olur.",
    keywordsEn: ["power in relationships", "deep intimacy", "partnership evolution", "shadow work"],
    keywordsTr: ["ilişkilerde güç", "derin yakınlık", "ortaklık evrimi", "gölge çalışması"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_8: {
    titleEn: "Pluto in Your 8th House — Phoenix Rising",
    titleTr: "Plüton 8. Evinde — Anka Kuşu Yükselişi",
    bodyEn:
      "Pluto is in its natural house, making this one of the most intense transits possible. Themes of death and rebirth — literal or metaphorical — dominate. Financial entanglements, inheritance, sexuality, and psychological depth reach extremes. You descend into the underworld of your psyche and return transformed. Nothing superficial survives this transit.",
    bodyTr:
      "Plüton doğal evinde, bu onu olası en yoğun transitlerden biri yapıyor. Ölüm ve yeniden doğuş temaları — gerçek veya metaforik — hakimdir. Mali bağlar, miras, cinsellik ve psikolojik derinlik uç noktalara ulaşır. Psişenizin yeraltı dünyasına inersiniz ve dönüşmüş olarak geri dönersiniz.",
    keywordsEn: ["death and rebirth", "extreme transformation", "psychological depth", "power"],
    keywordsTr: ["ölüm ve yeniden doğuş", "uç dönüşüm", "psikolojik derinlik", "güç"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_9: {
    titleEn: "Pluto in Your 9th House — Belief System Overthrow",
    titleTr: "Plüton 9. Evinde — İnanç Sistemi Devrimi",
    bodyEn:
      "Pluto transiting your ninth house demolishes belief systems that no longer serve your evolution. Your worldview, philosophy, and relationship with truth undergo radical transformation. Travel to foreign lands may trigger profound inner changes. You emerge with convictions forged in fire rather than inherited by default.",
    bodyTr:
      "Plüton dokuzuncu evinizden geçerken evriminize artık hizmet etmeyen inanç sistemlerini yıkıyor. Dünya görüşünüz, felsefeniz ve hakikatle ilişkiniz radikal bir dönüşümden geçiyor. Yabancı ülkelere seyahat derin iç değişimler tetikleyebilir.",
    keywordsEn: ["belief transformation", "philosophical depth", "truth seeking", "worldview shift"],
    keywordsTr: ["inanç dönüşümü", "felsefi derinlik", "hakikat arayışı", "dünya görüşü değişimi"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_10: {
    titleEn: "Pluto in Your 10th House — Power & Legacy",
    titleTr: "Plüton 10. Evinde — Güç ve Miras",
    bodyEn:
      "Pluto in your tenth house transforms your career, public image, and relationship with authority. You may rise to positions of great power or face power struggles with those above you. Your ambitions become all-consuming. The question is not whether you'll be powerful — it's whether you'll use that power wisely. This transit forges leaders.",
    bodyTr:
      "Plüton onuncu evinizde kariyerinizi, kamusal imajınızı ve otoriteyle ilişkinizi dönüştürüyor. Büyük güç pozisyonlarına yükselebilir veya üstünüzdekilerle güç mücadeleleriyle yüzleşebilirsiniz. Hırslarınız her şeyi kapsar hale gelir. Bu transit liderler yaratır.",
    keywordsEn: ["career power", "authority", "legacy", "ambition"],
    keywordsTr: ["kariyer gücü", "otorite", "miras", "hırs"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_11: {
    titleEn: "Pluto in Your 11th House — Social Revolution",
    titleTr: "Plüton 11. Evinde — Sosyal Devrim",
    bodyEn:
      "Pluto transiting your eleventh house transforms your relationship with groups, friendships, and your vision for the future. Some friendships end dramatically; new alliances form around deeper shared purpose. Your hopes and dreams are purged of what was never truly yours. You discover the difference between belonging and conforming.",
    bodyTr:
      "Plüton on birinci evinizden geçerken gruplar, arkadaşlıklar ve gelecek vizyonunuzla ilişkinizi dönüştürüyor. Bazı arkadaşlıklar dramatik şekilde biter; daha derin ortak amaç etrafında yeni ittifaklar oluşur. Ait olmak ile uymak arasındaki farkı keşfedersiniz.",
    keywordsEn: ["social transformation", "group power", "future vision", "authentic belonging"],
    keywordsTr: ["sosyal dönüşüm", "grup gücü", "gelecek vizyonu", "otantik aidiyet"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },
  pluto_12: {
    titleEn: "Pluto in Your 12th House — The Great Dissolution",
    titleTr: "Plüton 12. Evinde — Büyük Çözülme",
    bodyEn:
      "Pluto in your twelfth house is the most mysterious and profound of all transits. The subconscious becomes a battlefield and a temple simultaneously. Hidden enemies, self-undoing patterns, and spiritual crises surface for final resolution. Dreams become vivid and prophetic. You are being prepared — emptied — for a complete rebirth when Pluto crosses your ascendant.",
    bodyTr:
      "Plüton on ikinci evinizde tüm transitlerin en gizemli ve derini. Bilinçaltı aynı anda bir savaş alanı ve tapınak olur. Gizli düşmanlar, kendi kendini sabote eden kalıplar ve manevi krizler nihai çözüm için yüzeye çıkar. Rüyalar canlı ve kehanet niteliğinde olur. Plüton yükseleninizi geçtiğinde tam bir yeniden doğuş için hazırlanıyorsunuz.",
    keywordsEn: ["subconscious purge", "spiritual crisis", "hidden depths", "preparation for rebirth"],
    keywordsTr: ["bilinçaltı arınma", "manevi kriz", "gizli derinlikler", "yeniden doğuşa hazırlık"],
    durationEn: "12-20 years",
    durationTr: "12-20 yıl",
  },

  // ═══════════════════════════════════════
  // NEPTUNE TRANSITS (long-term ~14 years per sign)
  // ═══════════════════════════════════════
  neptune_1: {
    titleEn: "Neptune in Your 1st House — Dissolving the Mask",
    titleTr: "Neptün 1. Evinde — Maskeyi Çözmek",
    bodyEn:
      "Neptune transiting your first house dissolves the boundaries of your identity. You may feel less certain about who you are, more sensitive to others' energy, and drawn to artistic or spiritual expression. The ego softens. This is a profoundly creative but also confusing time — you're learning to exist without rigid definitions of self.",
    bodyTr:
      "Neptün birinci evinizden geçerken kimliğinizin sınırlarını çözüyor. Kim olduğunuz konusunda daha az emin, başkalarının enerjisine daha duyarlı ve sanatsal veya manevi ifadeye çekilmiş hissedebilirsiniz. Ego yumuşar. Son derece yaratıcı ama aynı zamanda kafa karıştırıcı bir zaman.",
    keywordsEn: ["identity dissolution", "sensitivity", "spiritual awakening", "artistic flow"],
    keywordsTr: ["kimlik çözülmesi", "hassasiyet", "manevi uyanış", "sanatsal akış"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_2: {
    titleEn: "Neptune in Your 2nd House — Financial Fog",
    titleTr: "Neptün 2. Evinde — Mali Sis",
    bodyEn:
      "Neptune in your second house creates confusion around money and values. Financial boundaries become blurred — you may be overly generous, fall for scams, or simply lose track of spending. The deeper work is redefining what true wealth means to you. Material security gives way to spiritual richness as your primary value system.",
    bodyTr:
      "Neptün ikinci evinizde para ve değerler etrafında kafa karışıklığı yaratıyor. Mali sınırlar bulanıklaşır — aşırı cömert olabilir, dolandırıcılıklara düşebilir veya harcamalarınızı takip edemeyebilirsiniz. Derin çalışma, gerçek zenginliğin sizin için ne anlama geldiğini yeniden tanımlamaktır.",
    keywordsEn: ["financial confusion", "values shift", "generosity", "spiritual wealth"],
    keywordsTr: ["mali kafa karışıklığı", "değer kayması", "cömertlik", "manevi zenginlik"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_3: {
    titleEn: "Neptune in Your 3rd House — Intuitive Mind",
    titleTr: "Neptün 3. Evinde — Sezgisel Zihin",
    bodyEn:
      "Neptune transiting your third house makes your mind more intuitive, imaginative, and poetic — but also prone to confusion and miscommunication. You may struggle with details while excelling at creative writing, music, or artistic expression. Your thinking becomes less logical and more visionary. Trust your hunches, but double-check the facts.",
    bodyTr:
      "Neptün üçüncü evinizden geçerken zihninizi daha sezgisel, hayalci ve şiirsel yapıyor — ama aynı zamanda kafa karışıklığı ve yanlış iletişime de yatkın. Detaylarla zorlanırken yaratıcı yazarlık, müzik veya sanatsal ifadede parlayabilirsiniz.",
    keywordsEn: ["intuition", "creative communication", "poetic mind", "confusion"],
    keywordsTr: ["sezgi", "yaratıcı iletişim", "şiirsel zihin", "kafa karışıklığı"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_4: {
    titleEn: "Neptune in Your 4th House — Ancestral Dreams",
    titleTr: "Neptün 4. Evinde — Atalardan Gelen Rüyalar",
    bodyEn:
      "Neptune in your fourth house dissolves the foundations of your sense of home and belonging. Family illusions shatter. You may idealize your past or feel unmoored from your roots. The invitation is to build an inner home — a spiritual foundation that doesn't depend on external circumstances. Your ancestors speak through dreams during this transit.",
    bodyTr:
      "Neptün dördüncü evinizde ev ve aidiyet duygunuzun temellerini çözüyor. Aile yanılsamaları kırılır. Geçmişinizi idealleştirebilir veya köklerinizden kopmuş hissedebilirsiniz. Davet, dış koşullara bağlı olmayan manevi bir temel — bir iç ev — inşa etmektir.",
    keywordsEn: ["home dissolution", "ancestral healing", "inner foundation", "family illusions"],
    keywordsTr: ["ev çözülmesi", "ata iyileşmesi", "iç temel", "aile yanılsamaları"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_5: {
    titleEn: "Neptune in Your 5th House — Divine Creativity",
    titleTr: "Neptün 5. Evinde — İlahi Yaratıcılık",
    bodyEn:
      "Neptune transiting your fifth house floods your creative life with inspiration and imagination. Art becomes transcendent. Romance becomes idealized — beautiful but sometimes deceptive. You may fall in love with an illusion or create the most inspired work of your life. The line between fantasy and reality blurs in matters of the heart and art.",
    bodyTr:
      "Neptün beşinci evinizden geçerken yaratıcı hayatınızı ilham ve hayal gücüyle dolduruyor. Sanat aşkın hale gelir. Romantizm idealleştirilir — güzel ama bazen aldatıcı. Kalp ve sanat meselelerinde fantezi ile gerçeklik arasındaki çizgi bulanıklaşır.",
    keywordsEn: ["divine inspiration", "idealized romance", "transcendent art", "creative fantasy"],
    keywordsTr: ["ilahi ilham", "idealleştirilmiş romantizm", "aşkın sanat", "yaratıcı fantezi"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_6: {
    titleEn: "Neptune in Your 6th House — Healing Through Surrender",
    titleTr: "Neptün 6. Evinde — Teslimiyetle İyileşme",
    bodyEn:
      "Neptune in your sixth house creates mystery around health and work. Illnesses may be hard to diagnose, symptoms may be psychosomatic, and traditional medicine may not have answers. The healing path is often alternative — acupuncture, energy work, meditation. At work, boundaries dissolve: you may serve others selflessly or be exploited. Discernment is the lesson.",
    bodyTr:
      "Neptün altıncı evinizde sağlık ve iş etrafında gizem yaratıyor. Hastalıklar teşhis edilmesi zor olabilir, semptomlar psikosomatik olabilir. İyileşme yolu genellikle alternatiftir — akupunktur, enerji çalışması, meditasyon. İşte sınırlar çözülür: başkalarına özverili hizmet edebilir veya istismar edilebilirsiniz.",
    keywordsEn: ["mysterious health", "alternative healing", "service", "boundaries at work"],
    keywordsTr: ["gizemli sağlık", "alternatif iyileşme", "hizmet", "işte sınırlar"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_7: {
    titleEn: "Neptune in Your 7th House — Soul Mate or Illusion",
    titleTr: "Neptün 7. Evinde — Ruh Eşi mi Yanılsama mı",
    bodyEn:
      "Neptune transiting your seventh house dissolves the clarity of partnerships. You may meet someone who feels like a soul mate — or project your fantasies onto a partner who can't possibly live up to them. Existing relationships become more spiritual but also more confusing. The lesson: see partners as they truly are, not as you wish them to be.",
    bodyTr:
      "Neptün yedinci evinizden geçerken ortaklıkların netliğini çözüyor. Ruh eşi gibi hissettiren biriyle tanışabilirsiniz — veya fantezilerinizi asla karşılayamayacak bir partnere yansıtabilirsiniz. Mevcut ilişkiler daha manevi ama aynı zamanda daha kafa karıştırıcı hale gelir.",
    keywordsEn: ["idealized partnerships", "soul connections", "romantic fog", "projection"],
    keywordsTr: ["idealleştirilmiş ortaklıklar", "ruh bağlantıları", "romantik sis", "yansıtma"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_8: {
    titleEn: "Neptune in Your 8th House — Mystical Depths",
    titleTr: "Neptün 8. Evinde — Mistik Derinlikler",
    bodyEn:
      "Neptune in your eighth house opens portals to the mystical and unseen. Your intuition about hidden matters is heightened but can also deceive. Financial dealings with others become murky — be cautious with shared investments, insurance, and debts. Sexually and psychologically, boundaries dissolve into oceanic intimacy or dangerous merging.",
    bodyTr:
      "Neptün sekizinci evinizde mistik ve görünmeyene portallar açıyor. Gizli konulardaki sezginiz güçleniyor ama aldatıcı da olabiliyor. Başkalarıyla mali ilişkiler bulanıklaşır — ortak yatırımlar, sigorta ve borçlarda dikkatli olun.",
    keywordsEn: ["mysticism", "hidden finances", "psychic depth", "boundary dissolution"],
    keywordsTr: ["mistisizm", "gizli mali konular", "psişik derinlik", "sınır çözülmesi"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_9: {
    titleEn: "Neptune in Your 9th House — Spiritual Pilgrimage",
    titleTr: "Neptün 9. Evinde — Manevi Hac",
    bodyEn:
      "Neptune transiting your ninth house dissolves rigid belief systems and opens you to spiritual seeking. You may be drawn to pilgrimage, ashrams, or mystical traditions. Higher education in arts, healing, or spiritual subjects calls to you. Be careful not to follow false gurus — your own inner compass is the ultimate teacher.",
    bodyTr:
      "Neptün dokuzuncu evinizden geçerken katı inanç sistemlerini çözüyor ve sizi manevi arayışa açıyor. Hac, manevi merkezler veya mistik geleneklere çekilebilirsiniz. Sanat, iyileşme veya manevi konularda yüksek eğitim sizi çağırıyor.",
    keywordsEn: ["spiritual seeking", "pilgrimage", "dissolving beliefs", "mystical education"],
    keywordsTr: ["manevi arayış", "hac", "inançları çözme", "mistik eğitim"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_10: {
    titleEn: "Neptune in Your 10th House — The Dream Career",
    titleTr: "Neptün 10. Evinde — Rüya Kariyer",
    bodyEn:
      "Neptune in your tenth house blurs your career direction and public image. You may feel lost about your professional path or be drawn to artistic, healing, or spiritual vocations. Your public image becomes more glamorous but also more vulnerable to misperception. The invitation is to align your career with your soul's purpose rather than society's expectations.",
    bodyTr:
      "Neptün onuncu evinizde kariyer yönünüzü ve kamusal imajınızı bulanıklaştırıyor. Profesyonel yolunuz hakkında kaybolmuş hissedebilir veya sanatsal, şifa veya manevi mesleklere çekilebilirsiniz. Davet, kariyerinizi toplumun beklentileri yerine ruhunuzun amacıyla hizalamaktır.",
    keywordsEn: ["career confusion", "artistic vocation", "glamour", "soul purpose"],
    keywordsTr: ["kariyer kafa karışıklığı", "sanatsal meslek", "cazibe", "ruh amacı"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_11: {
    titleEn: "Neptune in Your 11th House — Collective Dreams",
    titleTr: "Neptün 11. Evinde — Kolektif Rüyalar",
    bodyEn:
      "Neptune transiting your eleventh house dissolves the boundaries between you and groups. You may be drawn to spiritual communities, artistic collectives, or charitable organizations. Friendships become more soulful but also more confusing — some friends may deceive you. Your dreams for the future become more idealistic and compassionate.",
    bodyTr:
      "Neptün on birinci evinizden geçerken siz ve gruplar arasındaki sınırları çözüyor. Manevi topluluklara, sanatsal kolektiflere veya hayır kuruluşlarına çekilebilirsiniz. Arkadaşlıklar daha ruhani ama aynı zamanda daha kafa karıştırıcı hale gelir.",
    keywordsEn: ["spiritual community", "idealistic hopes", "collective service", "friendship fog"],
    keywordsTr: ["manevi topluluk", "idealist umutlar", "kolektif hizmet", "arkadaşlık sisi"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },
  neptune_12: {
    titleEn: "Neptune in Your 12th House — The Mystic's Transit",
    titleTr: "Neptün 12. Evinde — Mistiğin Transiti",
    bodyEn:
      "Neptune is at home in your twelfth house — this is the most spiritually potent transit possible. The veil between worlds becomes paper-thin. Dreams are vivid, psychic experiences are common, and you have direct access to the collective unconscious. This can be a time of profound spiritual awakening or complete escapism. The choice is yours.",
    bodyTr:
      "Neptün on ikinci evinizde evinde — bu olası en güçlü manevi transit. Dünyalar arasındaki perde kağıt inceliğine gelir. Rüyalar canlıdır, psişik deneyimler yaygındır ve kolektif bilinçdışına doğrudan erişiminiz vardır. Derin manevi uyanış veya tam kaçış zamanı olabilir.",
    keywordsEn: ["spiritual awakening", "psychic ability", "collective unconscious", "transcendence"],
    keywordsTr: ["manevi uyanış", "psişik yetenek", "kolektif bilinçdışı", "aşkınlık"],
    durationEn: "~14 years",
    durationTr: "~14 yıl",
  },

  // ═══════════════════════════════════════
  // URANUS TRANSITS (~7 years per sign)
  // ═══════════════════════════════════════
  uranus_1: {
    titleEn: "Uranus in Your 1st House — Electric Reinvention",
    titleTr: "Uranüs 1. Evinde — Elektriksel Yeniden İcat",
    bodyEn:
      "Uranus transiting your first house electrifies your identity. You crave freedom, authenticity, and radical change. Your appearance, personality, and life direction may shift suddenly and dramatically. Others may be shocked by the new you. This is liberation from every version of yourself that was designed to please others.",
    bodyTr:
      "Uranüs birinci evinizden geçerken kimliğinizi elektrikliyor. Özgürlük, otantiklik ve radikal değişim arzularsınız. Görünüşünüz, kişiliğiniz ve yaşam yönünüz aniden ve dramatik şekilde değişebilir. Bu, başkalarını memnun etmek için tasarlanmış her versiyonunuzdan kurtuluştur.",
    keywordsEn: ["radical change", "freedom", "authenticity", "sudden shifts"],
    keywordsTr: ["radikal değişim", "özgürlük", "otantiklik", "ani değişimler"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_2: {
    titleEn: "Uranus in Your 2nd House — Financial Revolution",
    titleTr: "Uranüs 2. Evinde — Mali Devrim",
    bodyEn:
      "Uranus in your second house brings sudden changes to your financial situation and values. Income may become unpredictable — windfalls and losses come without warning. You may discover unconventional ways to earn money or completely redefine what you value. Financial freedom becomes more important than financial security.",
    bodyTr:
      "Uranüs ikinci evinizde mali durumunuzda ve değerlerinizde ani değişiklikler getiriyor. Gelir öngörülmez hale gelebilir — beklenmedik kazançlar ve kayıplar gelir. Paranın alışılmadık yollarını keşfedebilir veya neye değer verdiğinizi tamamen yeniden tanımlayabilirsiniz.",
    keywordsEn: ["financial surprises", "unconventional income", "value revolution", "freedom"],
    keywordsTr: ["mali sürprizler", "alışılmadık gelir", "değer devrimi", "özgürlük"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_3: {
    titleEn: "Uranus in Your 3rd House — Mind Lightning",
    titleTr: "Uranüs 3. Evinde — Zihin Şimşeği",
    bodyEn:
      "Uranus transiting your third house electrifies your mind with brilliant insights, unconventional ideas, and restless curiosity. You may take up coding, astrology, or avant-garde subjects. Communication becomes more direct and surprising. Your neighborhood or daily environment may change unexpectedly. Siblings bring surprises.",
    bodyTr:
      "Uranüs üçüncü evinizden geçerken zihninizi parlak içgörüler, alışılmadık fikirler ve dinmeyen merakla elektrikliyor. Kodlama, astroloji veya avangard konulara yönelebilirsiniz. İletişim daha doğrudan ve şaşırtıcı hale gelir.",
    keywordsEn: ["brilliant ideas", "unconventional learning", "restless mind", "surprises"],
    keywordsTr: ["parlak fikirler", "alışılmadık öğrenme", "huzursuz zihin", "sürprizler"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_4: {
    titleEn: "Uranus in Your 4th House — Home Revolution",
    titleTr: "Uranüs 4. Evinde — Ev Devrimi",
    bodyEn:
      "Uranus in your fourth house disrupts your domestic life and sense of security. Sudden moves, family upheavals, or a radical reimagining of what 'home' means to you are possible. You may break free from family patterns or create a completely unconventional living situation. Freedom within your private life is the theme.",
    bodyTr:
      "Uranüs dördüncü evinizde ev hayatınızı ve güvenlik duygunuzu altüst ediyor. Ani taşınmalar, aile sarsıntıları veya 'ev'in sizin için ne anlama geldiğinin radikal bir yeniden tasarımı mümkün. Aile kalıplarından kurtulabilir veya tamamen alışılmadık bir yaşam durumu yaratabilirsiniz.",
    keywordsEn: ["sudden moves", "family disruption", "domestic freedom", "breaking patterns"],
    keywordsTr: ["ani taşınmalar", "aile sarsıntısı", "ev özgürlüğü", "kalıpları kırma"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_5: {
    titleEn: "Uranus in Your 5th House — Creative Lightning",
    titleTr: "Uranüs 5. Evinde — Yaratıcı Şimşek",
    bodyEn:
      "Uranus transiting your fifth house brings sudden creative breakthroughs, unexpected romances, and a fierce need for authentic self-expression. Your creative style becomes more experimental and rebellious. Love affairs begin and end suddenly. If you have children, they may surprise you with their independence. Play becomes revolution.",
    bodyTr:
      "Uranüs beşinci evinizden geçerken ani yaratıcı atılımlar, beklenmedik romantizmler ve otantik kendini ifade için şiddetli bir ihtiyaç getiriyor. Yaratıcı tarzınız daha deneysel ve isyankar hale gelir. Aşk ilişkileri aniden başlar ve biter.",
    keywordsEn: ["creative breakthroughs", "sudden romance", "rebellion", "experimentation"],
    keywordsTr: ["yaratıcı atılımlar", "ani romantizm", "isyan", "deneysellik"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_6: {
    titleEn: "Uranus in Your 6th House — Work Revolution",
    titleTr: "Uranüs 6. Evinde — İş Devrimi",
    bodyEn:
      "Uranus in your sixth house revolutionizes your work and health routines. You may quit a conventional job for freelancing, discover biohacking, or adopt radically different health practices. The 9-to-5 becomes unbearable. Your body demands change — listen to it. Technology may transform how you work daily.",
    bodyTr:
      "Uranüs altıncı evinizde iş ve sağlık rutinlerinizi devrimleştiriyor. Geleneksel bir işi bırakıp serbest çalışmaya geçebilir, biyohacking keşfedebilir veya radikal farklı sağlık uygulamaları benimseyebilirsiniz. Bedeniniz değişim talep ediyor — onu dinleyin.",
    keywordsEn: ["work disruption", "health innovation", "routine revolution", "technology"],
    keywordsTr: ["iş sarsıntısı", "sağlık yeniliği", "rutin devrimi", "teknoloji"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_7: {
    titleEn: "Uranus in Your 7th House — Relationship Earthquake",
    titleTr: "Uranüs 7. Evinde — İlişki Depremi",
    bodyEn:
      "Uranus transiting your seventh house shakes up partnerships. Relationships that restrict your freedom may end suddenly. You may attract unusual, eccentric, or freedom-loving partners. Existing partnerships need to evolve or risk breaking. The key is creating relationships that honor both connection and individual freedom.",
    bodyTr:
      "Uranüs yedinci evinizden geçerken ortaklıkları sarsıyor. Özgürlüğünüzü kısıtlayan ilişkiler aniden bitebilir. Sıra dışı, eksantrik veya özgürlükçü partnerler çekebilirsiniz. Mevcut ortaklıkların evrilmesi gerekiyor yoksa kırılma riski var.",
    keywordsEn: ["sudden separations", "unconventional partners", "freedom in love", "evolution"],
    keywordsTr: ["ani ayrılıklar", "alışılmadık partnerler", "aşkta özgürlük", "evrim"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_8: {
    titleEn: "Uranus in Your 8th House — Sudden Transformation",
    titleTr: "Uranüs 8. Evinde — Ani Dönüşüm",
    bodyEn:
      "Uranus in your eighth house brings sudden changes in shared finances, sexuality, and psychological depth. Unexpected inheritances, tax surprises, or financial upheavals through others are possible. Your sexuality may evolve in unexpected directions. Psychologically, breakthroughs come like lightning — sudden insights that change everything.",
    bodyTr:
      "Uranüs sekizinci evinizde ortak mali konularda, cinsellikte ve psikolojik derinlikte ani değişiklikler getiriyor. Beklenmedik miraslar, vergi sürprizleri veya başkaları aracılığıyla mali sarsıntılar mümkün. Psikolojik atılımlar şimşek gibi gelir — her şeyi değiştiren ani içgörüler.",
    keywordsEn: ["sudden financial shifts", "psychological breakthroughs", "sexual evolution", "upheaval"],
    keywordsTr: ["ani mali değişimler", "psikolojik atılımlar", "cinsel evrim", "sarsıntı"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_9: {
    titleEn: "Uranus in Your 9th House — Worldview Shock",
    titleTr: "Uranüs 9. Evinde — Dünya Görüşü Şoku",
    bodyEn:
      "Uranus transiting your ninth house shatters your existing worldview and replaces it with something more expansive. You may suddenly travel to unexpected places, discover astrology or quantum physics, or have experiences that make your old beliefs impossible to maintain. Higher education takes unconventional forms. You become the heretic with the correct answer.",
    bodyTr:
      "Uranüs dokuzuncu evinizden geçerken mevcut dünya görüşünüzü parçalıyor ve daha geniş bir şeyle değiştiriyor. Aniden beklenmedik yerlere seyahat edebilir, astroloji veya kuantum fiziği keşfedebilir veya eski inançlarınızı sürdürmeyi imkansız kılan deneyimler yaşayabilirsiniz.",
    keywordsEn: ["worldview revolution", "unconventional education", "sudden travel", "paradigm shift"],
    keywordsTr: ["dünya görüşü devrimi", "alışılmadık eğitim", "ani seyahat", "paradigma değişimi"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_10: {
    titleEn: "Uranus in Your 10th House — Career Disruption",
    titleTr: "Uranüs 10. Evinde — Kariyer Sarsıntısı",
    bodyEn:
      "Uranus in your tenth house disrupts your career and public image. Sudden job changes, unexpected fame, or complete career pivots are characteristic. You can no longer tolerate doing work that doesn't reflect your authentic self. The corporate ladder breaks — you build your own staircase. Your reputation becomes associated with innovation and originality.",
    bodyTr:
      "Uranüs onuncu evinizde kariyerinizi ve kamusal imajınızı altüst ediyor. Ani iş değişiklikleri, beklenmedik şöhret veya tam kariyer dönüşleri karakteristiktir. Artık otantik benliğinizi yansıtmayan iş yapmaya tahammül edemezsiniz. İtibarınız yenilik ve özgünlükle ilişkilendirilir.",
    keywordsEn: ["career pivot", "unexpected fame", "innovation", "authenticity at work"],
    keywordsTr: ["kariyer dönüşü", "beklenmedik şöhret", "yenilik", "işte otantiklik"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_11: {
    titleEn: "Uranus in Your 11th House — Social Awakening",
    titleTr: "Uranüs 11. Evinde — Sosyal Uyanış",
    bodyEn:
      "Uranus is at home in your eleventh house, making this a powerful time for social revolution. Your friend group transforms radically — you attract visionaries, rebels, and innovators. Old social circles may feel suffocating. Your hopes for the future become more radical and humanitarian. You discover your role in the collective awakening.",
    bodyTr:
      "Uranüs on birinci evinizde evinde, bu onu sosyal devrim için güçlü bir zaman yapıyor. Arkadaş grubunuz radikal şekilde dönüşür — vizyonerler, isyancılar ve yenilikçiler çekersiniz. Gelecek umutlarınız daha radikal ve insancıl hale gelir. Kolektif uyanıştaki rolünüzü keşfedersiniz.",
    keywordsEn: ["social revolution", "visionary friends", "humanitarian ideals", "awakening"],
    keywordsTr: ["sosyal devrim", "vizyoner arkadaşlar", "insancıl idealler", "uyanış"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
  uranus_12: {
    titleEn: "Uranus in Your 12th House — Subconscious Liberation",
    titleTr: "Uranüs 12. Evinde — Bilinçaltı Kurtuluşu",
    bodyEn:
      "Uranus transiting your twelfth house liberates your subconscious mind. Hidden aspects of yourself surface unexpectedly — sudden spiritual awakenings, psychic experiences, or the breaking of self-imposed prisons. You may be drawn to meditation, lucid dreaming, or consciousness exploration. What was repressed demands freedom. This transit prepares you for radical reinvention when Uranus crosses your ascendant.",
    bodyTr:
      "Uranüs on ikinci evinizden geçerken bilinçaltınızı özgürleştiriyor. Kendinizin gizli yönleri beklenmedik şekilde yüzeye çıkar — ani manevi uyanışlar, psişik deneyimler veya kendi kendinize kurduğunuz hapishanelerin yıkılması. Bastırılan özgürlük talep ediyor.",
    keywordsEn: ["subconscious awakening", "spiritual liberation", "psychic breakthroughs", "hidden freedom"],
    keywordsTr: ["bilinçaltı uyanışı", "manevi kurtuluş", "psişik atılımlar", "gizli özgürlük"],
    durationEn: "~7 years",
    durationTr: "~7 yıl",
  },
};
