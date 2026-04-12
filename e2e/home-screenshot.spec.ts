import { test } from '@playwright/test';

test('home screen with profile', async ({ page }) => {
  // Pre-set localStorage so user is past onboarding
  await page.goto('https://astrobobo.com/', { waitUntil: 'domcontentloaded' });
  await page.evaluate(() => {
    const profile = {
      id: 'test-001',
      name: 'Test',
      birthDate: '1990-06-15T12:00:00.000',
      birthTime: '12:00',
      birthPlace: 'İstanbul',
      birthLatitude: 41.0082,
      birthLongitude: 28.9784,
      sunSign: 0,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      isPrimary: true,
    };
    // Flutter shared_preferences uses 'flutter.' prefix on web
    localStorage.setItem('flutter.user_profile', JSON.stringify(profile));
    localStorage.setItem('flutter.onboarding_complete', 'true');
  });
  await page.reload({ waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 45000 }
  );
  await page.waitForTimeout(3000);

  // Desktop home
  await page.setViewportSize({ width: 1440, height: 900 });
  await page.waitForTimeout(500);
  await page.screenshot({ path: 'test-results/home-desktop.png', fullPage: true });

  // Mobile home
  await page.setViewportSize({ width: 414, height: 896 });
  await page.waitForTimeout(500);
  await page.screenshot({ path: 'test-results/home-mobile.png', fullPage: true });
});
