import { test, expect } from '@playwright/test';

/**
 * Validates JSON-LD structured data on key pages.
 * Ensures Google Rich Results compatibility.
 */

const PAGES = [
  { url: 'https://astrobobo.com/r/tr/ruyada-araba', types: ['Article', 'BreadcrumbList', 'Organization', 'WebSite'] },
  { url: 'https://astrobobo.com/r/en/ruyada-araba', types: ['Article', 'BreadcrumbList', 'Organization', 'WebSite'] },
  { url: 'https://astrobobo.com/r/tr/cluster-ruya', types: ['CollectionPage', 'BreadcrumbList', 'Organization', 'WebSite'] },
  { url: 'https://astrobobo.com/r/tr', types: ['CollectionPage', 'BreadcrumbList', 'Organization', 'WebSite'] },
];

test.describe('Structured Data Validation', () => {
  for (const page of PAGES) {
    test(`${page.url} has valid JSON-LD`, async ({ request }) => {
      const res = await request.get(page.url);
      expect(res.status()).toBe(200);

      const html = await res.text();

      // Extract JSON-LD
      const ldMatch = html.match(/<script type="application\/ld\+json">([\s\S]*?)<\/script>/);
      expect(ldMatch, 'JSON-LD script tag exists').not.toBeNull();

      const ldJson = JSON.parse(ldMatch![1]);
      expect(ldJson['@context']).toBe('https://schema.org');
      expect(ldJson['@graph']).toBeDefined();
      expect(Array.isArray(ldJson['@graph'])).toBe(true);

      // Check all expected types exist
      const foundTypes = ldJson['@graph'].map((n: any) => n['@type']);
      for (const type of page.types) {
        expect(foundTypes, `${page.url} should have @type ${type}`).toContain(type);
      }

      // Organization must have name, url, logo
      const org = ldJson['@graph'].find((n: any) => n['@type'] === 'Organization');
      expect(org.name).toBe('Astrobobo');
      expect(org.url).toBe('https://astrobobo.com');
      expect(org.logo).toBeDefined();

      // BreadcrumbList must have at least 2 items
      const breadcrumb = ldJson['@graph'].find((n: any) => n['@type'] === 'BreadcrumbList');
      expect(breadcrumb.itemListElement.length).toBeGreaterThanOrEqual(2);

      // Each breadcrumb item must have position, name, item
      for (const item of breadcrumb.itemListElement) {
        expect(item['@type']).toBe('ListItem');
        expect(item.position).toBeGreaterThan(0);
        expect(item.name).toBeTruthy();
        expect(item.item).toBeTruthy();
      }
    });
  }
});
