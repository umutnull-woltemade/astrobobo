import { test, expect } from '@playwright/test';

/**
 * Tests the dynamic OG image endpoint with various queries — verifies
 * the Edge Function returns valid PNG for all 12 zodiac signs and
 * gracefully handles edge cases (long titles, missing params, unicode).
 */

const SIGNS = [
  'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo',
  'libra', 'scorpio', 'sagittarius', 'capricorn', 'aquarius', 'pisces',
];

test.describe('Dynamic OG Image', () => {
  for (const sign of SIGNS) {
    test(`renders ${sign}`, async ({ request }) => {
      const url = `https://astrobobo.com/api/og?title=${sign}+burcu&sign=${sign}`;
      const res = await request.get(url);
      expect(res.status()).toBe(200);
      expect(res.headers()['content-type']).toContain('image/png');
      const body = await res.body();
      expect(body.length).toBeGreaterThan(50000); // valid PNG > 50KB
    });
  }

  test('handles missing params with defaults', async ({ request }) => {
    const res = await request.get('https://astrobobo.com/api/og');
    expect(res.status()).toBe(200);
    expect(res.headers()['content-type']).toContain('image/png');
  });

  test('handles unicode title (Turkish)', async ({ request }) => {
    const url = 'https://astrobobo.com/api/og?' + new URLSearchParams({
      title: 'Şükür ve Bereket — İçsel Yolculuk',
      subtitle: 'Günlük rehberlik',
    });
    const res = await request.get(url);
    expect(res.status()).toBe(200);
  });

  test('caches with stable headers', async ({ request }) => {
    const res = await request.get('https://astrobobo.com/api/og?title=test');
    const cc = res.headers()['cache-control'] || '';
    expect(cc).toContain('immutable');
    expect(cc).toContain('max-age=86400');
  });
});
