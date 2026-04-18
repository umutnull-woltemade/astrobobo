type I = { en: string; tr: string };

export const HOUSE_THEMES: Record<number, I> = {
  1:  { en: "Self, identity, appearance, first impressions", tr: "Benlik, kimlik, görünüş, ilk izlenimler" },
  2:  { en: "Money, possessions, values, self-worth", tr: "Para, sahiplikler, değerler, öz değer" },
  3:  { en: "Communication, siblings, short trips, learning", tr: "İletişim, kardeşler, kısa yolculuklar, öğrenme" },
  4:  { en: "Home, family, roots, emotional foundation", tr: "Ev, aile, kökler, duygusal temel" },
  5:  { en: "Creativity, romance, children, pleasure, play", tr: "Yaratıcılık, romantizm, çocuklar, zevk, oyun" },
  6:  { en: "Health, daily routine, service, work habits", tr: "Sağlık, günlük rutin, hizmet, çalışma alışkanlıkları" },
  7:  { en: "Partnerships, marriage, contracts, open enemies", tr: "Ortaklıklar, evlilik, sözleşmeler, açık düşmanlar" },
  8:  { en: "Transformation, shared resources, death/rebirth, sex", tr: "Dönüşüm, paylaşılan kaynaklar, ölüm/yeniden doğuş, cinsellik" },
  9:  { en: "Higher education, travel, philosophy, beliefs, law", tr: "Yüksek eğitim, seyahat, felsefe, inançlar, hukuk" },
  10: { en: "Career, reputation, public image, authority, legacy", tr: "Kariyer, itibar, kamu imajı, otorite, miras" },
  11: { en: "Friends, community, hopes, groups, humanitarian ideals", tr: "Arkadaşlar, topluluk, umutlar, gruplar, insani idealler" },
  12: { en: "Solitude, spirituality, hidden matters, self-undoing", tr: "Yalnızlık, maneviyat, gizli meseleler, kendi kendini baltalama" },
};

export function getPlanetsInHouses(
  planets: Array<{ name: string; symbol: string; longitude: number }>,
  houses: Array<{ house: number; cusp: number }>
): Record<number, Array<{ name: string; symbol: string }>> {
  if (houses.length < 12) return {};
  const result: Record<number, Array<{ name: string; symbol: string }>> = {};
  for (let i = 1; i <= 12; i++) result[i] = [];

  for (const p of planets) {
    const lon = p.longitude;
    let houseNum = 12;
    for (let i = 0; i < 12; i++) {
      const start = houses[i].cusp;
      const end = houses[(i + 1) % 12].cusp;
      if (end > start) {
        if (lon >= start && lon < end) { houseNum = i + 1; break; }
      } else {
        if (lon >= start || lon < end) { houseNum = i + 1; break; }
      }
    }
    result[houseNum].push({ name: p.name, symbol: p.symbol });
  }
  return result;
}
