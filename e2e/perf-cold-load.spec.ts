import { test } from '@playwright/test';

test('cold load performance', async ({ browser }) => {
  // Fresh context — no cache, no service worker
  const ctx = await browser.newContext({ serviceWorkers: 'block' });
  const page = await ctx.newPage();

  const start = Date.now();
  let firstFrameMs = 0;

  page.on('console', (msg) => {
    if (msg.text().includes('First frame rendered')) {
      firstFrameMs = Date.now() - start;
    }
  });

  await page.goto('https://astrobobo.com/', { waitUntil: 'load', timeout: 60000 });

  // Wait for Flutter first frame
  await page.waitForFunction(
    () => {
      const loading = document.getElementById('loading');
      return loading === null || loading.style.opacity === '0';
    },
    { timeout: 60000 }
  );

  const totalMs = Date.now() - start;

  console.log('\n========= COLD LOAD PERF =========');
  console.log(`navigation start  → first frame: ${firstFrameMs > 0 ? firstFrameMs + 'ms' : 'not measured'}`);
  console.log(`navigation start  → loading removed: ${totalMs}ms`);

  // Get transferred bytes
  const transferStats = await page.evaluate(() => {
    const entries = performance.getEntriesByType('resource') as PerformanceResourceTiming[];
    let totalBytes = 0;
    let count = 0;
    let largest = { name: '', size: 0 };
    for (const e of entries) {
      const size = e.transferSize || e.encodedBodySize || 0;
      totalBytes += size;
      count++;
      if (size > largest.size) largest = { name: e.name.split('/').pop() || e.name, size };
    }
    return { totalBytes, count, largest };
  });
  console.log(`total transferred: ${(transferStats.totalBytes / 1024 / 1024).toFixed(2)} MB across ${transferStats.count} resources`);
  console.log(`largest resource:  ${transferStats.largest.name} (${(transferStats.largest.size / 1024).toFixed(0)} KB)`);
});
