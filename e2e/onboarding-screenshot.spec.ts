import { test } from '@playwright/test';

/**
 * Captures the new premium onboarding screen at multiple viewport sizes
 * to verify no overflow and the layout looks great.
 */

const VIEWPORTS = [
  { name: 'desktop-wide', width: 1440, height: 900 },
  { name: 'desktop-narrow', width: 1024, height: 768 },
  { name: 'tablet', width: 768, height: 1024 },
  { name: 'mobile', width: 414, height: 896 },
  { name: 'mobile-small', width: 375, height: 667 },
];

for (const vp of VIEWPORTS) {
  test(`onboarding @ ${vp.name} (${vp.width}x${vp.height})`, async ({ page }) => {
    const errors: string[] = [];
    page.on('console', (msg) => {
      if (msg.type() === 'error') errors.push(msg.text());
    });

    await page.setViewportSize({ width: vp.width, height: vp.height });
    await page.goto('https://astrobobo.com/', { waitUntil: 'domcontentloaded' });

    // Wait for Flutter first frame
    await page.waitForFunction(
      () => {
        const loading = document.getElementById('loading');
        return loading === null || loading.style.opacity === '0';
      },
      { timeout: 30000 }
    );

    await page.waitForTimeout(1500);
    await page.screenshot({
      path: `test-results/onboarding-${vp.name}.png`,
      fullPage: true,
    });

    const overflowMessages = errors.filter(e =>
      e.toLowerCase().includes('overflow') || e.toLowerCase().includes('overflowed')
    );
    if (overflowMessages.length > 0) {
      console.log(`\n!!! ${vp.name} OVERFLOW:`);
      overflowMessages.forEach(m => console.log('   ' + m));
    } else {
      console.log(`\n✓ ${vp.name} no overflow`);
    }
  });
}
