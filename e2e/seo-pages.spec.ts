import { test, expect } from '@playwright/test';

/**
 * SEO Landing Pages Quality Test
 *
 * The "SEO machine" commit (0d56893f) added 137 pre-rendered HTML pages
 * under /r/{lang}/{slug}.html. This suite verifies they're discoverable
 * by Google: status 200, valid structured data, canonical URL, hreflang.
 */

const SAMPLE_SEO_PAGES = [
  '/r/tr/ruyada-araba',
  '/r/tr/ruyada-bebek',
  '/r/tr/ruyada-bogulmak',
  '/r/tr/ruyada-dis-dokulmesi',
  '/r/tr/ruyada-dusmek',
  '/r/tr/ruyada-eski-sevgili',
  '/r/tr/ruyada-ev',
  '/r/tr/ruyada-kaybolmak',
  '/r/tr/ruyada-kopek',
  '/r/tr/ruyada-kovalanmak',
  '/r/tr/ruyada-olum',
  '/r/tr/ruyada-para',
  '/r/tr/ruyada-su',
  '/r/tr/ruyada-ucmak',
  '/r/tr/ruyada-yilan',
  '/r/en/ruyada-araba',  // English version exists
  '/r/de/ruyada-araba',  // German
  '/r/es/ruyada-araba',  // Spanish
];

test.describe('SEO Landing Pages Quality', () => {
  for (const path of SAMPLE_SEO_PAGES) {
    test(`${path} has valid SEO markup`, async ({ request }) => {
      const res = await request.get(`https://astrobobo.com${path}`);
      expect(res.status(), `${path} status`).toBe(200);

      const html = await res.text();

      // Has canonical
      expect(html, `${path} canonical`).toContain('rel="canonical"');

      // Has hreflang
      expect(html, `${path} hreflang`).toContain('hreflang="tr"');
      expect(html, `${path} hreflang en`).toContain('hreflang="en"');

      // Has Open Graph
      expect(html, `${path} og:title`).toContain('og:title');
      expect(html, `${path} og:description`).toContain('og:description');

      // Has Twitter Card
      expect(html, `${path} twitter:card`).toContain('twitter:card');

      // Has structured data
      expect(html, `${path} JSON-LD`).toContain('application/ld+json');
      expect(html, `${path} schema.org Article`).toContain('"@type":"Article"');
      expect(html, `${path} schema.org BreadcrumbList`).toContain('"@type":"BreadcrumbList"');
      expect(html, `${path} schema.org Organization`).toContain('"@type":"Organization"');

      // Has robots index
      expect(html, `${path} robots`).toContain('index,follow');

      // Body content not empty
      expect(html.length, `${path} content length`).toBeGreaterThan(8000);
    });
  }

  test('sitemap.xml lists 145 URLs', async ({ request }) => {
    const res = await request.get('https://astrobobo.com/sitemap.xml');
    expect(res.status()).toBe(200);
    expect(res.headers()['content-type']).toContain('xml');
    const xml = await res.text();
    const urlCount = (xml.match(/<loc>/g) || []).length;
    expect(urlCount).toBeGreaterThanOrEqual(140);
  });

  test('robots.txt allows AI crawlers', async ({ request }) => {
    const res = await request.get('https://astrobobo.com/robots.txt');
    expect(res.status()).toBe(200);
    const text = await res.text();
    expect(text).toContain('GPTBot');
    expect(text).toContain('ClaudeBot');
    expect(text).toContain('PerplexityBot');
    expect(text).toContain('Sitemap:');
  });

  test('llms.txt advertises content for AI crawlers', async ({ request }) => {
    const res = await request.get('https://astrobobo.com/llms.txt');
    expect(res.status()).toBe(200);
    expect(res.headers()['content-type']).toContain('text');
  });
});
