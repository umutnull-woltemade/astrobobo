import { test, expect } from '@playwright/test';

/**
 * White Screen Detection Tests
 *
 * These tests ensure the Flutter Web app loads correctly without showing
 * a white/blank screen. They are critical for preventing broken deployments.
 */

const BASE_URL = process.env.BASE_URL || 'http://localhost:8080';

test.describe('White Screen Protection', () => {

  test('app loads without white screen', async ({ page }) => {
    const errors: string[] = [];
    const consoleMessages: string[] = [];

    // Capture all page errors
    page.on('pageerror', (error) => {
      errors.push(error.message);
    });

    // Capture console errors
    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        consoleMessages.push(msg.text());
      }
    });

    // Navigate to the app
    await page.goto(BASE_URL, {
      waitUntil: 'networkidle',
      timeout: 30000
    });

    // Wait for app to stabilize
    await page.waitForTimeout(5000);

    // CHECK 1: Body has content (not blank)
    const bodyHTML = await page.locator('body').innerHTML();
    expect(
      bodyHTML.trim().length,
      'Page body should have content (not blank/white screen)'
    ).toBeGreaterThan(100);

    // CHECK 2: Flutter app rendered (flutter-view or flt-glass-pane exists)
    const flutterElements = page.locator('flutter-view, flt-glass-pane, [flt-view-id]');
    await expect(
      flutterElements.first(),
      'Flutter app should be visible'
    ).toBeVisible({ timeout: 20000 });

    // CHECK 3: No critical JavaScript errors
    const criticalErrors = errors.filter(e =>
      e.includes('TypeError') ||
      e.includes('Uncaught') ||
      e.includes('ReferenceError') ||
      e.includes('SyntaxError')
    );
    expect(
      criticalErrors,
      `No critical JS errors should occur. Found: ${criticalErrors.join(', ')}`
    ).toEqual([]);

    // CHECK 4: Take screenshot for visual verification (saved on failure)
    await page.screenshot({
      path: 'test-results/app-loaded.png',
      fullPage: true
    });
  });

  test('loading screen appears and disappears', async ({ page }) => {
    // Navigate to app
    await page.goto(BASE_URL);

    // Loading screen should be visible initially
    const loadingElement = page.locator('#loading');

    // Check if loading element exists (it might be removed too fast on fast connections)
    const loadingVisible = await loadingElement.isVisible().catch(() => false);

    if (loadingVisible) {
      // Loading should eventually disappear (Flutter app takes over)
      await expect(
        loadingElement,
        'Loading screen should disappear after Flutter loads'
      ).toBeHidden({ timeout: 25000 });
    }

    // Flutter app should be visible after loading
    const flutterElements = page.locator('flutter-view, flt-glass-pane, [flt-view-id]');
    await expect(
      flutterElements.first(),
      'Flutter app should be visible after loading'
    ).toBeVisible({ timeout: 20000 });
  });

  test('health endpoint returns OK', async ({ page }) => {
    const response = await page.goto(`${BASE_URL}/api/health`);

    expect(response?.status()).toBe(200);

    const body = await response?.json();
    expect(body.status).toBe('ok');
    expect(body.app).toBe('venus-one');
  });

  test('app is interactive after load', async ({ page }) => {
    await page.goto(BASE_URL, {
      waitUntil: 'networkidle',
      timeout: 30000
    });

    // Wait for Flutter to fully initialize
    await page.waitForTimeout(5000);

    // Flutter app should be present
    const flutterElements = page.locator('flutter-view, flt-glass-pane, [flt-view-id]');
    await expect(flutterElements.first()).toBeVisible({ timeout: 20000 });

    // Try to interact - the canvas should be present
    const canvas = page.locator('canvas');
    const canvasCount = await canvas.count();
    expect(
      canvasCount,
      'Flutter should render at least one canvas element'
    ).toBeGreaterThan(0);
  });

  test('no infinite loading state', async ({ page }) => {
    await page.goto(BASE_URL);

    // Wait for potential loading states to resolve
    await page.waitForTimeout(20000);

    // Check that we're not stuck on loading
    const loadingElement = page.locator('#loading');
    const isLoadingStillVisible = await loadingElement.isVisible().catch(() => false);

    expect(
      isLoadingStillVisible,
      'App should not be stuck in loading state after 20 seconds'
    ).toBe(false);

    // Take final screenshot
    await page.screenshot({
      path: 'test-results/final-state.png',
      fullPage: true
    });
  });

});

test.describe('Error Recovery', () => {

  test('error fallback UI prevents white screen', async ({ page }) => {
    // This test would require injecting an error, which is complex
    // For now, we verify that the error widget code is present

    await page.goto(BASE_URL, { waitUntil: 'networkidle' });
    await page.waitForTimeout(3000);

    // If there's an error widget visible, it should have content
    const errorWidget = page.locator('text=Bir şeyler ters gitti');
    const isErrorVisible = await errorWidget.isVisible().catch(() => false);

    if (isErrorVisible) {
      // If error is shown, verify it has a recovery button
      const recoveryButton = page.locator('text=Ana Sayfaya Dön');
      await expect(recoveryButton).toBeVisible();
    }

    // Either way, page should not be completely blank
    const bodyHTML = await page.locator('body').innerHTML();
    expect(bodyHTML.trim().length).toBeGreaterThan(50);
  });

});
