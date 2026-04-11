import { test, expect } from '@playwright/test';

/**
 * All Routes Smoke Test
 *
 * Visits every public route on the deployed Venus One web app and verifies
 * that the page renders content (not a white screen) and has no critical
 * JavaScript errors.
 *
 * Run against production:  BASE_URL=https://astrobobo.com npx playwright test e2e/all-routes.spec.ts
 */

const BASE_URL = process.env.BASE_URL || 'https://astrobobo.com';

const ROUTES = [
  // Core
  { path: '/', name: 'home' },
  // Birth chart & horoscope family
  { path: '/birth-chart', name: 'birth-chart' },
  { path: '/horoscope', name: 'horoscope' },
  { path: '/horoscope/weekly', name: 'weekly-horoscope' },
  { path: '/horoscope/monthly', name: 'monthly-horoscope' },
  { path: '/horoscope/yearly', name: 'yearly-horoscope' },
  { path: '/horoscope/love', name: 'love-horoscope' },
  // Compatibility
  { path: '/synastry', name: 'synastry' },
  { path: '/composite', name: 'composite' },
  { path: '/compatibility', name: 'compatibility' },
  // Predictive
  { path: '/transits', name: 'transits' },
  { path: '/progressions', name: 'progressions' },
  { path: '/solar-return', name: 'solar-return' },
  { path: '/year-ahead', name: 'year-ahead' },
  { path: '/saturn-return', name: 'saturn-return' },
  // Specialized
  { path: '/vedic', name: 'vedic' },
  { path: '/draconic', name: 'draconic' },
  { path: '/asteroids', name: 'asteroids' },
  { path: '/local-space', name: 'local-space' },
  { path: '/timing', name: 'timing' },
  // Mystical / divination
  { path: '/tarot', name: 'tarot' },
  { path: '/numerology', name: 'numerology' },
  { path: '/dreams', name: 'dreams' },
  { path: '/dream-glossary', name: 'dream-glossary' },
  { path: '/chakra', name: 'chakra' },
  { path: '/aura', name: 'aura' },
  { path: '/rituals', name: 'rituals' },
  { path: '/kabbalah', name: 'kabbalah' },
  { path: '/kozmoz', name: 'kozmoz' },
  // Reference
  { path: '/celebrities', name: 'celebrities' },
  { path: '/glossary', name: 'glossary' },
  // Account
  { path: '/profile', name: 'profile' },
  { path: '/settings', name: 'settings' },
  { path: '/premium', name: 'premium' },
];

test.describe('All Routes Smoke Test', () => {
  for (const route of ROUTES) {
    test(`${route.name} (${route.path}) renders without white screen`, async ({ page }) => {
      const errors: string[] = [];

      page.on('pageerror', (e) => errors.push(e.message));

      const response = await page.goto(`${BASE_URL}${route.path}`, {
        waitUntil: 'domcontentloaded',
        timeout: 45000,
      });

      // HTTP must be 200
      expect(response?.status(), `HTTP for ${route.path}`).toBe(200);

      // Wait for the loading splash to be removed (signals first-frame fired)
      await page.waitForFunction(
        () => {
          const loading = document.getElementById('loading');
          return loading === null || loading.style.opacity === '0' || loading.style.display === 'none';
        },
        { timeout: 45000 }
      );

      // Body must have content
      const bodyHTML = await page.locator('body').innerHTML();
      expect(bodyHTML.trim().length, `${route.path} body content`).toBeGreaterThan(500);

      // Canvas must exist (Flutter renders to canvas)
      const canvasCount = await page.locator('canvas').count();
      expect(canvasCount, `${route.path} canvas count`).toBeGreaterThan(0);

      // The error UI must NOT be showing
      const hasErrorUI = await page.locator('text=Uygulama yüklenemedi').count();
      expect(hasErrorUI, `${route.path} should not show error UI`).toBe(0);

      // No critical errors
      const fatal = errors.filter(e =>
        e.includes('TypeError') ||
        e.includes('ReferenceError') ||
        e.includes('SyntaxError')
      );
      expect(fatal, `${route.path} JS errors`).toEqual([]);
    });
  }
});
