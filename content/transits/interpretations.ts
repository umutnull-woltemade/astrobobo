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
};
