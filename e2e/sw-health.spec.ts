import { test } from '@playwright/test';

test('service worker registration health', async ({ browser }) => {
  const ctx = await browser.newContext();
  const page = await ctx.newPage();

  const errors: string[] = [];
  const warnings: string[] = [];
  const swMessages: string[] = [];

  page.on('console', (msg) => {
    const text = msg.text();
    if (msg.type() === 'error') errors.push(text);
    if (msg.type() === 'warning') warnings.push(text);
    if (text.toLowerCase().includes('service worker') || text.toLowerCase().includes('cache')) {
      swMessages.push(`[${msg.type()}] ${text}`);
    }
  });

  await page.goto('https://astrobobo.com/', { waitUntil: 'networkidle' });
  await page.waitForTimeout(8000);

  const swState = await page.evaluate(async () => {
    if (!('serviceWorker' in navigator)) return { supported: false };
    const regs = await navigator.serviceWorker.getRegistrations();
    return {
      supported: true,
      registrationCount: regs.length,
      controllers: regs.map(r => ({
        scope: r.scope,
        active: r.active?.scriptURL || null,
        waiting: r.waiting?.scriptURL || null,
      })),
    };
  });

  console.log('\n========= SW HEALTH =========');
  console.log(JSON.stringify(swState, null, 2));
  console.log('\n========= SW-RELATED CONSOLE =========');
  swMessages.forEach(m => console.log(m));
  console.log('\n========= ALL ERRORS =========');
  errors.forEach(e => console.log('  ERROR: ' + e));
  console.log('\n========= ALL WARNINGS =========');
  warnings.slice(0, 10).forEach(w => console.log('  WARN: ' + w));
});
