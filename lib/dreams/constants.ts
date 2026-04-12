/** Featured dream topics — single source of truth for all dream cross-links. */
export const FEATURED_DREAMS = [
  { slug: 'ruyada-araba', tr: 'Araba', en: 'Car' },
  { slug: 'ruyada-bebek', tr: 'Bebek', en: 'Baby' },
  { slug: 'ruyada-dusmek', tr: 'Düşmek', en: 'Falling' },
  { slug: 'ruyada-ucmak', tr: 'Uçmak', en: 'Flying' },
  { slug: 'ruyada-yilan', tr: 'Yılan', en: 'Snake' },
  { slug: 'ruyada-su', tr: 'Su', en: 'Water' },
  { slug: 'ruyada-olum', tr: 'Ölüm', en: 'Death' },
  { slug: 'ruyada-ev', tr: 'Ev', en: 'House' },
  { slug: 'ruyada-para', tr: 'Para', en: 'Money' },
  { slug: 'ruyada-kovalanmak', tr: 'Kovalanmak', en: 'Being Chased' },
] as const;

/** Build the path to the dream hub for a given locale. */
export function dreamHubPath(locale: string): string {
  return `/r/${locale}`;
}

/** Build the path to a specific dream article. */
export function dreamArticlePath(locale: string, slug: string): string {
  return `/r/${locale}/${slug}`;
}
