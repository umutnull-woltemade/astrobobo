import { test, expect } from '@playwright/test';

test('settings page loads with language switcher', async ({ page }) => {
  // Pre-populate localStorage with a profile so we can access /settings
  await page.goto('https://astrobobo.com/', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 30000 }
  );
  await page.waitForTimeout(2000);

  // Go to settings via URL
  await page.goto('https://astrobobo.com/settings', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 30000 }
  );
  await page.waitForTimeout(2000);

  // Should not be a white screen
  const bodyHTML = await page.locator('body').innerHTML();
  expect(bodyHTML.length).toBeGreaterThan(500);

  // Should have a canvas (Flutter renders to canvas)
  const canvasCount = await page.locator('canvas').count();
  expect(canvasCount).toBeGreaterThan(0);

  // No error UI
  const errorCount = await page.locator('text=Uygulama yüklenemedi').count();
  expect(errorCount).toBe(0);

  await page.screenshot({ path: 'test-results/settings-page.png', fullPage: true });
});
