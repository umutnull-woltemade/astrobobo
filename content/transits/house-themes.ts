// ════════════════════════════════════════════════════════════════════════════
// HOUSE THEMES - What each astrological house represents
// ════════════════════════════════════════════════════════════════════════════

import { HouseNumber, HouseTheme } from "./types";

export const houseThemes: Record<HouseNumber, HouseTheme> = {
  1: {
    en: "identity, self-image, new beginnings",
    tr: "kimlik, benlik, yeni başlangıçlar",
  },
  2: {
    en: "finances, values, self-worth",
    tr: "maddi durum, değerler, öz-değer",
  },
  3: {
    en: "communication, learning, siblings, short journeys",
    tr: "iletişim, öğrenme, kardeşler, kısa yolculuklar",
  },
  4: {
    en: "home, family, roots, emotional foundations",
    tr: "ev, aile, kökler, duygusal temel",
  },
  5: {
    en: "creativity, romance, children, self-expression",
    tr: "yaratıcılık, romantizm, çocuklar, kendini ifade",
  },
  6: {
    en: "work, health, daily routines, service",
    tr: "iş, sağlık, günlük rutinler, hizmet",
  },
  7: {
    en: "partnerships, marriage, one-on-one relationships",
    tr: "ortaklıklar, evlilik, birebir ilişkiler",
  },
  8: {
    en: "transformation, shared resources, deep psychology",
    tr: "dönüşüm, ortak kaynaklar, derin psikoloji",
  },
  9: {
    en: "higher education, travel, philosophy, expansion",
    tr: "yüksek eğitim, uzak yolculuklar, felsefe, genişleme",
  },
  10: {
    en: "career, public image, ambition, authority",
    tr: "kariyer, kamusal imaj, hırs, otorite",
  },
  11: {
    en: "friendships, community, hopes, future vision",
    tr: "arkadaşlıklar, topluluk, umutlar, gelecek vizyonu",
  },
  12: {
    en: "spirituality, solitude, subconscious, letting go",
    tr: "maneviyat, yalnızlık, bilinçaltı, bırakma",
  },
};
