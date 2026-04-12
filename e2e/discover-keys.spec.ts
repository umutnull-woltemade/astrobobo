import { test } from '@playwright/test';

test('discover Flutter localStorage keys', async ({ page }) => {
  await page.goto('https://astrobobo.com/', { waitUntil: 'domcontentloaded' });
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 30000 }
  );
  await page.waitForTimeout(3000);

  const keys = await page.evaluate(() => Object.keys(localStorage));
  console.log('\n>>> Flutter localStorage keys after onboarding render:');
  keys.forEach(k => console.log(`  - ${k}`));
});
