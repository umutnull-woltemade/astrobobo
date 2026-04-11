/**
 * Astrobobo Web Pro — Turkish tone pack.
 *
 * Imported lazily via `registerLocalePack("tr", trTonePack)` during
 * client bootstrap. Only Pro-specific strings belong here; the cosmic
 * site's i18n dictionaries remain the source of truth for everything else.
 */

import type { CopyEntry } from "../copy-registry";

export const trTonePack: Record<string, CopyEntry> = {
  "hero.eyebrow": {
    default: "Astrobobo / Pro",
    calm: "Astrobobo / Pro",
    mystical: "Bir alan uyanıyor",
    direct: "Astrobobo Pro",
    oracle: "Çekirdek / Pro / v0",
  },
  "hero.title": {
    default: "Bir site açmadın. Bir evrene girdin.",
    calm: "Hoş geldin. Aceleye gerek yok.",
    mystical:
      "Buraya tesadüfen gelmedin.\nAlan seni hatırlıyor.",
    direct: "Bu bir site değil, bir evren.",
    oracle: "Alan aktif. Yön canlı. Hareket et.",
  },
  "hero.subtitle": {
    default:
      "Arayüz senin hareketlerini izliyor. Dur, sadeleşir. Keşfet, açılır.",
    calm: "Her şey senin hızında nefes alıyor. Acele etmene gerek yok.",
    mystical:
      "Alan, dikkatinin etrafında kıvrılır. Her jest bir sinyaldir; her sinyal geri döner.",
    direct:
      "Arayüz hareketine, bakışına ve tıklamana gerçek zamanlı tepki verir.",
    oracle:
      "Duygu vektörü → yön → düzen ağacı @ 60Hz. Etkileşim revealLevel'ı yükseltir.",
  },
  "hero.ctaPrimary": {
    default: "Alana gir",
    calm: "Nazikçe başla",
    mystical: "Alana gir",
    direct: "Başla",
    oracle: "Bağlan",
  },
  "hero.ctaSecondary": {
    default: "Gözlemle",
    calm: "Sadece bak",
    mystical: "Akışı izle",
    direct: "Tur",
    oracle: "İncele",
  },

  "section.orbit.title": {
    default: "Yörüngesel navigasyon",
    calm: "Nazik navigasyon",
    mystical: "Yörünge dinler",
    direct: "Navigasyon",
    oracle: "Yörüngesel graf",
  },
  "section.orbit.subtitle": {
    default: "Öğeler en çok dokunduğun şeye doğru çekilir.",
    calm: "En çok sevdiğin yollar her seferinde biraz daha yaklaşır.",
    mystical:
      "Döndüğün şey, sana döner. Halka hatırlar.",
    direct: "En çok kullanılan öğeler içe doğru hareket eder.",
    oracle: "focusNodeId halka ofsetini yönlendirir. gravitate=true etkin.",
  },

  "section.adaptive.title": {
    default: "Uyarlanabilir katman",
    calm: "Sana uyum sağlar",
    mystical: "Geometri yanıt verir",
    direct: "Uyarlanabilir katman",
    oracle: "Uyum hattı",
  },
  "section.adaptive.subtitle": {
    default: "Izgara yoğunluğu, boşluk ve açılış seviyesi seninle değişir.",
    calm: "Alan, rahatladığında açılır.",
    mystical:
      "Yoğunluk merakınla akar. Hava, durakladığında açılır.",
    direct:
      "Yoğunluk, boşluk ve açılış seviyesi gerçek zamanlı olarak davranışa tepki verir.",
    oracle:
      "Yoğunluk · hava · revealLevel ∈ yön. Her RAF'ta güncellenir.",
  },

  "section.pulse.title": {
    default: "Nabız girişi",
    calm: "Nazik giriş",
    mystical: "Alana konuş",
    direct: "Girişler",
    oracle: "Nabız I/O",
  },
  "section.pulse.subtitle": {
    default: "Canlı kaplar, nefes alan odak.",
    calm: "Yazmadan önce bir nefes al.",
    mystical: "Kap, almadan önce dinler.",
    direct: "Odağa tepki veren kaplar.",
    oracle: "Odak + yoğunluğa bağlı kaplar.",
  },

  "input.name.label": {
    default: "Adın",
    calm: "Sana nasıl seslenelim?",
    mystical: "Cevap verdiğin isim",
    direct: "İsim",
    oracle: "Tanımlayıcı",
  },
  "input.birth.label": {
    default: "Doğum tarihi",
    calm: "Ne zaman doğdun?",
    mystical: "Göğün seni işaretlediği gün",
    direct: "Doğum tarihi",
    oracle: "DOB (ISO)",
  },

  "footer.tagline": {
    default: "astrobobo · pro evren · v0",
    calm: "astrobobo · yavaş yavaş",
    mystical: "astrobobo · alan hatırlar",
    direct: "astrobobo pro · v0",
    oracle: "astrobobo::pro::v0",
  },
};
