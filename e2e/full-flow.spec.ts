import { test } from '@playwright/test';

test('home screen with pre-set profile', async ({ page }) => {
  const consoleLines: string[] = [];
  const errors: string[] = [];

  page.on('console', (msg) => {
    consoleLines.push(`[${msg.type()}] ${msg.text()}`);
  });
  page.on('pageerror', (e) => errors.push(e.message));

  // Pre-set profile and onboarding flag in localStorage so router lets us in
  await page.goto('https://astrobobo.com/', { waitUntil: 'domcontentloaded' });
  await page.evaluate(() => {
    const profile = {
      id: 'test-id',
      name: 'Test User',
      birthDate: '1995-06-15T12:00:00.000',
      birthTime: '12:00',
      birthPlace: 'İstanbul',
      birthLatitude: 41.0082,
      birthLongitude: 28.9784,
      sunSign: 0,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      isPrimary: true,
    };
    localStorage.setItem('user_profile', JSON.stringify(profile));
    localStorage.setItem('onboarding_complete', 'true');
  });

  // Reload to pick up profile
  await page.reload({ waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 45000 }
  );
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'test-results/flow-home-after-onboarding.png', fullPage: true });

  // Now navigate to /tarot
  await page.goto('https://astrobobo.com/tarot', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 45000 }
  );
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'test-results/flow-tarot.png', fullPage: true });

  // Try /horoscope
  await page.goto('https://astrobobo.com/horoscope', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 45000 }
  );
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'test-results/flow-horoscope.png', fullPage: true });

  // Try /birth-chart
  await page.goto('https://astrobobo.com/birth-chart', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 45000 }
  );
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'test-results/flow-birth-chart.png', fullPage: true });

  console.log('\n========= CONSOLE =========');
  consoleLines.slice(-30).forEach(l => console.log(l));
  console.log('\n========= ERRORS =========');
  errors.forEach(e => console.log(e));
});
