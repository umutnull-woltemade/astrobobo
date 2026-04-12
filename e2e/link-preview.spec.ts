import { test, expect } from '@playwright/test';

/**
 * Validates that link previews (OG meta + dynamic OG image) work correctly
 * for key page types. Social platforms (WhatsApp, Telegram, Twitter, etc.)
 * scrape these meta tags to render link previews.
 */

const PAGES = [
  // SPA routes serve the same index.html — og:title is static "Venus One"
  { url: '/', expectedTitleContains: 'Venus One', hasOgImage: true },
  { url: '/horoscope', expectedTitleContains: 'Venus One', hasOgImage: true },
  { url: '/tarot', expectedTitleContains: 'Venus One', hasOgImage: true },
  // Pre-rendered SEO pages have per-page og:title
  { url: '/r/tr/ruyada-araba', expectedTitleContains: 'Araba', hasOgImage: true },
  { url: '/r/en/ruyada-araba', expectedTitleContains: 'Dreaming', hasOgImage: true },
  { url: '/r/tr/cluster-ruya', expectedTitleContains: 'Rüya', hasOgImage: true },
  { url: '/r/tr', expectedTitleContains: 'Astrobobo', hasOgImage: true },
];

test.describe('Link Preview (OG Meta) Validation', () => {
  for (const page of PAGES) {
    test(`${page.url} has valid link preview`, async ({ request }) => {
      const res = await request.get(`https://astrobobo.com${page.url}`);
      expect(res.status()).toBe(200);
      const html = await res.text();

      // og:title exists and contains expected text
      const ogTitleMatch = html.match(/og:title"\s+content="([^"]+)"/);
      expect(ogTitleMatch, `${page.url} og:title`).not.toBeNull();
      expect(ogTitleMatch![1]).toContain(page.expectedTitleContains);

      // og:description exists and is non-empty
      const ogDescMatch = html.match(/og:description"\s+content="([^"]+)"/);
      expect(ogDescMatch, `${page.url} og:description`).not.toBeNull();
      expect(ogDescMatch![1].length).toBeGreaterThan(20);

      // og:url exists
      expect(html).toContain('og:url');

      // og:image exists and points to /api/og
      if (page.hasOgImage) {
        const ogImageMatch = html.match(/og:image"\s+content="([^"]+)"/);
        expect(ogImageMatch, `${page.url} og:image`).not.toBeNull();
        expect(ogImageMatch![1]).toContain('/api/og');

        // Verify the OG image URL actually returns a valid PNG
        const imageRes = await request.get(ogImageMatch![1]);
        expect(imageRes.status()).toBe(200);
        expect(imageRes.headers()['content-type']).toContain('image/png');
      }

      // twitter:card exists
      expect(html).toContain('twitter:card');
    });
  }
});
