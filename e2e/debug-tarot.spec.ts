import { test, expect } from '@playwright/test';

test('debug tarot route', async ({ page }) => {
  const consoleLines: string[] = [];
  const errors: string[] = [];

  page.on('console', (msg) => {
    consoleLines.push(`[${msg.type()}] ${msg.text()}`);
  });
  page.on('pageerror', (e) => {
    errors.push(`PAGE ERROR: ${e.message}`);
  });

  await page.goto('https://astrobobo.com/tarot', {
    waitUntil: 'domcontentloaded',
    timeout: 30000,
  });

  // Wait for either Flutter to render OR error UI
  await page.waitForTimeout(25000);

  console.log('\n========= CONSOLE LOG =========');
  consoleLines.forEach(l => console.log(l));
  console.log('\n========= PAGE ERRORS =========');
  errors.forEach(e => console.log(e));
  console.log('\n========= URL =========');
  console.log(page.url());
  console.log('\n========= TITLE =========');
  console.log(await page.title());

  await page.screenshot({ path: 'test-results/debug-tarot.png', fullPage: true });
});
