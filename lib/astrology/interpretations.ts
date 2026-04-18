// Core planet-in-sign interpretations (Sun, Moon, Mercury, Venus, Mars)
// Kept concise — 1 sentence per placement
type I = { en: string; tr: string };

const SUN: Record<string, I> = {
  Aries:       { en: "Bold identity — you lead with action, courage, and a pioneering spirit.", tr: "Cesur kimlik — aksiyon, cesaret ve öncü ruhla liderlik edersin." },
  Taurus:      { en: "Steady identity — you ground yourself through patience, beauty, and material security.", tr: "İstikrarlı kimlik — sabır, güzellik ve maddi güvenlikle temellenirsin." },
  Gemini:      { en: "Curious identity — you express yourself through ideas, words, and constant learning.", tr: "Meraklı kimlik — fikirler, kelimeler ve sürekli öğrenmeyle ifade edersin." },
  Cancer:      { en: "Nurturing identity — you shine through emotional depth, care, and family bonds.", tr: "Besleyici kimlik — duygusal derinlik, bakım ve aile bağlarıyla parlarsın." },
  Leo:         { en: "Radiant identity — you express yourself through creativity, warmth, and personal magnetism.", tr: "Parlak kimlik — yaratıcılık, sıcaklık ve kişisel manyetizmayla ifade edersin." },
  Virgo:       { en: "Analytical identity — you shine through precision, service, and practical improvement.", tr: "Analitik kimlik — hassasiyet, hizmet ve pratik iyileştirmeyle parlarsın." },
  Libra:       { en: "Harmonious identity — you define yourself through relationships, beauty, and fairness.", tr: "Uyumlu kimlik — ilişkiler, güzellik ve adaletle kendini tanımlarsın." },
  Scorpio:     { en: "Intense identity — you transform through depth, power, and emotional truth.", tr: "Yoğun kimlik — derinlik, güç ve duygusal hakikatle dönüşürsün." },
  Sagittarius: { en: "Adventurous identity — you grow through exploration, philosophy, and boundless optimism.", tr: "Maceracı kimlik — keşif, felsefe ve sınırsız iyimserlikle büyürsün." },
  Capricorn:   { en: "Ambitious identity — you build through discipline, responsibility, and long-term vision.", tr: "Hırslı kimlik — disiplin, sorumluluk ve uzun vadeli vizyonla inşa edersin." },
  Aquarius:    { en: "Visionary identity — you innovate through originality, humanity, and intellectual freedom.", tr: "Vizyoner kimlik — özgünlük, insanlık ve entelektüel özgürlükle yenilik yaparsın." },
  Pisces:      { en: "Intuitive identity — you flow through imagination, compassion, and spiritual connection.", tr: "Sezgisel kimlik — hayal gücü, şefkat ve spiritüel bağlantıyla akarsın." },
};

const MOON: Record<string, I> = {
  Aries:       { en: "Emotionally impulsive — you process feelings through action and need independence.", tr: "Duygusal dürtüsel — duyguları aksiyonla işler, bağımsızlığa ihtiyacın var." },
  Taurus:      { en: "Emotionally steady — you need security, comfort, and sensory grounding.", tr: "Duygusal istikrarlı — güvenlik, konfor ve duyusal topraklanmaya ihtiyacın var." },
  Gemini:      { en: "Emotionally restless — you process feelings through talking, writing, and mental stimulation.", tr: "Duygusal huzursuz — duyguları konuşma, yazma ve zihinsel uyaranlarla işlersin." },
  Cancer:      { en: "Emotionally deep — you need home, family, and emotional safety above all.", tr: "Duygusal derin — ev, aile ve duygusal güvenliğe her şeyden çok ihtiyacın var." },
  Leo:         { en: "Emotionally expressive — you need to be seen, appreciated, and creatively alive.", tr: "Duygusal ifadeci — görülmeye, takdir edilmeye ve yaratıcı olarak canlı olmaya ihtiyacın var." },
  Virgo:       { en: "Emotionally contained — you show care through practical service and helpful action.", tr: "Duygusal ketum — bakımı pratik hizmet ve yardımsever eylemlerle gösterirsin." },
  Libra:       { en: "Emotionally relational — you need harmony, partnership, and aesthetic beauty.", tr: "Duygusal ilişkisel — uyum, ortaklık ve estetik güzelliğe ihtiyacın var." },
  Scorpio:     { en: "Emotionally intense — you feel everything deeply and never forget.", tr: "Duygusal yoğun — her şeyi derinden hisseder, asla unutmazsın." },
  Sagittarius: { en: "Emotionally optimistic — you need freedom, adventure, and philosophical meaning.", tr: "Duygusal iyimser — özgürlük, macera ve felsefi anlama ihtiyacın var." },
  Capricorn:   { en: "Emotionally reserved — you process feelings through structure and long-term commitment.", tr: "Duygusal mesafeli — duyguları yapı ve uzun vadeli bağlılıkla işlersin." },
  Aquarius:    { en: "Emotionally detached — you need intellectual space and unconventional expression.", tr: "Duygusal mesafeli — entelektüel alana ve alışılmadık ifadeye ihtiyacın var." },
  Pisces:      { en: "Emotionally porous — you absorb others' feelings and need creative/spiritual outlets.", tr: "Duygusal geçirgen — başkalarının duygularını emer, yaratıcı/spiritüel çıkışlara ihtiyacın var." },
};

const MERCURY: Record<string, I> = {
  Aries:       { en: "Quick, direct communication — you think fast and speak before filtering.", tr: "Hızlı, direkt iletişim — çabuk düşünür, filtrelemeden konuşursun." },
  Taurus:      { en: "Deliberate thinking — you process slowly but reach solid, practical conclusions.", tr: "Dikkatli düşünce — yavaş işlersin ama sağlam, pratik sonuçlara ulaşırsın." },
  Gemini:      { en: "Versatile mind — you juggle ideas effortlessly and love intellectual variety.", tr: "Çok yönlü zihin — fikirleri zahmetsizce çevirir, entelektüel çeşitliliği seversin." },
  Cancer:      { en: "Intuitive thinking — your mind is colored by emotion and memory.", tr: "Sezgisel düşünce — zihnin duygu ve hafızayla renklenir." },
  Leo:         { en: "Creative communication — you express ideas with flair and dramatic conviction.", tr: "Yaratıcı iletişim — fikirleri gösterişli ve dramatik inançla ifade edersin." },
  Virgo:       { en: "Precise mind — you analyze details others miss and communicate with clarity.", tr: "Hassas zihin — başkalarının kaçırdığı detayları analiz eder, netlikle iletişim kurarsın." },
  Libra:       { en: "Diplomatic thinking — you see all sides and communicate with tact.", tr: "Diplomatik düşünce — tüm tarafları görür, incelikle iletişim kurarsın." },
  Scorpio:     { en: "Probing mind — you dig beneath surfaces and communicate with strategic intensity.", tr: "Araştırıcı zihin — yüzeyin altını kazar, stratejik yoğunlukla iletişim kurarsın." },
  Sagittarius: { en: "Expansive thinking — your mind seeks big-picture meaning and philosophical truth.", tr: "Geniş düşünce — zihnin büyük resim anlamı ve felsefi hakikat arar." },
  Capricorn:   { en: "Structured mind — you think in frameworks and communicate with authority.", tr: "Yapısal zihin — çerçevelerle düşünür, otoriteyle iletişim kurarsın." },
  Aquarius:    { en: "Original thinking — you see patterns others don't and communicate unconventionally.", tr: "Orijinal düşünce — başkalarının görmediği kalıpları görür, alışılmadık biçimde iletişim kurarsın." },
  Pisces:      { en: "Imaginative mind — you think in images, metaphors, and emotional impressions.", tr: "Hayalperest zihin — imgeler, metaforlar ve duygusal izlenimlerle düşünürsün." },
};

const VENUS: Record<string, I> = {
  Aries:       { en: "Passionate in love — you pursue desire boldly and need excitement in relationships.", tr: "Aşkta tutkulu — arzuyu cesurca kovalar, ilişkilerde heyecana ihtiyacın var." },
  Taurus:      { en: "Sensual in love — you value loyalty, physical touch, and lasting beauty.", tr: "Aşkta duyusal — sadakat, fiziksel dokunuş ve kalıcı güzelliğe değer verirsin." },
  Gemini:      { en: "Playful in love — you need mental stimulation and witty conversation.", tr: "Aşkta oyuncu — zihinsel uyarıma ve esprili sohbete ihtiyacın var." },
  Cancer:      { en: "Devoted in love — you nurture deeply and need emotional security.", tr: "Aşkta adanmış — derinden besler, duygusal güvenliğe ihtiyacın var." },
  Leo:         { en: "Generous in love — you give dramatically and need admiration in return.", tr: "Aşkta cömert — dramatik şekilde verir, karşılığında hayranlığa ihtiyacın var." },
  Virgo:       { en: "Devoted in love — you show care through acts of service and attention to detail.", tr: "Aşkta özverili — bakımı hizmet eylemleri ve detaylara dikkatle gösterirsin." },
  Libra:       { en: "Romantic in love — you seek beauty, balance, and deep partnership.", tr: "Aşkta romantik — güzellik, denge ve derin ortaklık ararsın." },
  Scorpio:     { en: "Intense in love — all-or-nothing devotion with transformative emotional depth.", tr: "Aşkta yoğun — ya hep ya hiç adanmışlık, dönüştürücü duygusal derinlik." },
  Sagittarius: { en: "Free in love — you need adventure, honesty, and space to grow together.", tr: "Aşkta özgür — macera, dürüstlük ve birlikte büyüme alanına ihtiyacın var." },
  Capricorn:   { en: "Committed in love — you build slowly but your bonds are unshakeable.", tr: "Aşkta bağlı — yavaş inşa edersin ama bağların sarsılmaz." },
  Aquarius:    { en: "Independent in love — you value friendship, mental connection, and freedom.", tr: "Aşkta bağımsız — arkadaşlık, zihinsel bağlantı ve özgürlüğe değer verirsin." },
  Pisces:      { en: "Transcendent in love — you love without boundaries and seek soul-level union.", tr: "Aşkta aşkın — sınırsız sever, ruh düzeyinde birleşme ararsın." },
};

const MARS: Record<string, I> = {
  Aries:       { en: "Direct drive — you act immediately, compete naturally, and fight for what you want.", tr: "Direkt dürtü — anında harekete geçer, doğal rekabet eder, istediğin için savaşırsın." },
  Taurus:      { en: "Persistent drive — slow to start but unstoppable once moving.", tr: "Kalıcı dürtü — başlaması yavaş ama hareket ettikten sonra durdurulamaz." },
  Gemini:      { en: "Mental drive — you act through words, ideas, and multitasking.", tr: "Zihinsel dürtü — kelimeler, fikirler ve çoklu görevlerle harekete geçersin." },
  Cancer:      { en: "Protective drive — you fight fiercely for home, family, and emotional safety.", tr: "Koruyucu dürtü — ev, aile ve duygusal güvenlik için şiddetle savaşırsın." },
  Leo:         { en: "Creative drive — you act with flair, courage, and dramatic determination.", tr: "Yaratıcı dürtü — gösterişli, cesur ve dramatik kararlılıkla harekete geçersin." },
  Virgo:       { en: "Precise drive — you act methodically and improve systems with surgical accuracy.", tr: "Hassas dürtü — metodik harekete geçer, sistemleri cerrahi doğrulukla iyileştirirsin." },
  Libra:       { en: "Diplomatic drive — you act through negotiation and seek fair outcomes.", tr: "Diplomatik dürtü — müzakereyle harekete geçer, adil sonuçlar ararsın." },
  Scorpio:     { en: "Strategic drive — you act with intensity, patience, and transformative power.", tr: "Stratejik dürtü — yoğunluk, sabır ve dönüştürücü güçle harekete geçersin." },
  Sagittarius: { en: "Adventurous drive — you chase freedom, truth, and big-picture goals.", tr: "Maceracı dürtü — özgürlük, hakikat ve büyük resim hedeflerini kovalar." },
  Capricorn:   { en: "Disciplined drive — you climb steadily, strategically, and never give up.", tr: "Disiplinli dürtü — istikrarlı, stratejik tırmanır, asla pes etmezsin." },
  Aquarius:    { en: "Revolutionary drive — you act for change, progress, and collective benefit.", tr: "Devrimci dürtü — değişim, ilerleme ve kolektif fayda için harekete geçersin." },
  Pisces:      { en: "Intuitive drive — you act on feeling, imagination, and compassionate impulse.", tr: "Sezgisel dürtü — duygu, hayal gücü ve şefkatli dürtüyle harekete geçersin." },
};

const JUPITER: Record<string, I> = {
  Aries:       { en: "Growth through bold action, leadership, and pioneering ventures.", tr: "Cesur eylem, liderlik ve öncü girişimlerle büyüme." },
  Taurus:      { en: "Growth through material security, patience, and sensory abundance.", tr: "Maddi güvenlik, sabır ve duyusal bollukla büyüme." },
  Gemini:      { en: "Growth through ideas, communication, learning, and social connections.", tr: "Fikirler, iletişim, öğrenme ve sosyal bağlantılarla büyüme." },
  Cancer:      { en: "Growth through home, family, emotional security, and nurturing others.", tr: "Ev, aile, duygusal güvenlik ve başkalarını beslemekle büyüme." },
  Leo:         { en: "Growth through creativity, self-expression, generosity, and play.", tr: "Yaratıcılık, kendini ifade, cömertlik ve oyunla büyüme." },
  Virgo:       { en: "Growth through service, health, precision, and practical improvement.", tr: "Hizmet, sağlık, hassasiyet ve pratik iyileştirmeyle büyüme." },
  Libra:       { en: "Growth through partnerships, diplomacy, art, and social harmony.", tr: "Ortaklıklar, diplomasi, sanat ve sosyal uyumla büyüme." },
  Scorpio:     { en: "Growth through transformation, depth, research, and emotional honesty.", tr: "Dönüşüm, derinlik, araştırma ve duygusal dürüstlükle büyüme." },
  Sagittarius: { en: "Growth through travel, philosophy, higher education, and adventure.", tr: "Seyahat, felsefe, yüksek eğitim ve macerayla büyüme." },
  Capricorn:   { en: "Growth through discipline, career building, and long-term strategy.", tr: "Disiplin, kariyer inşası ve uzun vadeli stratejiyle büyüme." },
  Aquarius:    { en: "Growth through innovation, community, technology, and humanitarian ideals.", tr: "Yenilik, topluluk, teknoloji ve insani ideallerle büyüme." },
  Pisces:      { en: "Growth through spirituality, compassion, imagination, and surrender.", tr: "Maneviyat, şefkat, hayal gücü ve teslimiyetle büyüme." },
};

const SATURN: Record<string, I> = {
  Aries:       { en: "Life lesson: patience with self, balancing action with caution.", tr: "Yaşam dersi: kendine sabır, eylemi ihtiyatla dengeleme." },
  Taurus:      { en: "Life lesson: true security vs material attachment, slow persistence.", tr: "Yaşam dersi: gerçek güvenlik vs maddi bağımlılık, yavaş ısrar." },
  Gemini:      { en: "Life lesson: depth over breadth in communication and learning.", tr: "Yaşam dersi: iletişim ve öğrenmede genişlik yerine derinlik." },
  Cancer:      { en: "Life lesson: emotional boundaries, responsible nurturing, inner strength.", tr: "Yaşam dersi: duygusal sınırlar, sorumlu beslenme, iç güç." },
  Leo:         { en: "Life lesson: authentic vs performative self-expression.", tr: "Yaşam dersi: otantik vs performatif kendini ifade." },
  Virgo:       { en: "Life lesson: perfectionism vs good enough, healthy routines.", tr: "Yaşam dersi: mükemmeliyetçilik vs yeterince iyi, sağlıklı rutinler." },
  Libra:       { en: "Life lesson: equality in partnerships, standing alone when needed.", tr: "Yaşam dersi: ortaklıklarda eşitlik, gerektiğinde tek başına durma." },
  Scorpio:     { en: "Life lesson: power and control, transforming fear into trust.", tr: "Yaşam dersi: güç ve kontrol, korkuyu güvene dönüştürme." },
  Sagittarius: { en: "Life lesson: grounding beliefs in experience, focused expansion.", tr: "Yaşam dersi: inançları deneyimle temellendirme, odaklı genişleme." },
  Capricorn:   { en: "Life lesson: authority without tyranny, building with integrity.", tr: "Yaşam dersi: tiranlık olmadan otorite, dürüstlükle inşa." },
  Aquarius:    { en: "Life lesson: individuality within community, responsibility to the group.", tr: "Yaşam dersi: topluluk içinde bireysellik, gruba karşı sorumluluk." },
  Pisces:      { en: "Life lesson: boundaries in compassion, spiritual discipline.", tr: "Yaşam dersi: şefkatte sınırlar, spiritüel disiplin." },
};

export const PLANET_SIGN_INTERPS: Record<string, Record<string, I>> = {
  '☉': SUN, '☽': MOON, '☿': MERCURY, '♀': VENUS, '♂': MARS, '♃': JUPITER, '♄': SATURN,
};

export function getInterpretation(planetSymbol: string, signEn: string): I | null {
  return PLANET_SIGN_INTERPS[planetSymbol]?.[signEn] || null;
}
