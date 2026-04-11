-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — Phase 3 cron schedules
-- ═══════════════════════════════════════════════════════════════════════════
-- Adds: translator, og-image-gen, monetization-injector
-- Reschedules trend-scan + content-gen for multi-lang load
-- ═══════════════════════════════════════════════════════════════════════════

-- Reschedule existing scan/gen for multi-lang capacity
select cron.unschedule('seo-trend-scan')   where exists(select 1 from cron.job where jobname='seo-trend-scan');
select cron.unschedule('seo-content-gen')  where exists(select 1 from cron.job where jobname='seo-content-gen');

-- 02:00 — refill keyword queue (all 7 langs)
select cron.schedule('seo-trend-scan', '0 2 * * *',
  $$select seo_invoke('trend-scanner',
    '{"langs":["tr","en","es","de","fr","it","pt-br"]}'::jsonb);$$);

-- 02:30 — generate batch (auto-distributed across langs by priority)
select cron.schedule('seo-content-gen', '30 2 * * *',
  $$select seo_invoke('content-generator', '{"batch":35}'::jsonb);$$);

-- ───────────────────────────────────────────────────────────────────────────
-- NEW PHASE 3 SCHEDULES
-- ───────────────────────────────────────────────────────────────────────────

-- 04:00 — translator: TR → other langs (5 posts, 5 langs each = 25/day)
select cron.schedule('seo-translator-tr', '0 4 * * *',
  $$select seo_invoke('translator',
    '{"source_lang":"tr","target_langs":["es","de","fr","it","pt-br"],"max":5}'::jsonb);$$);

-- 04:15 — translator: EN → other langs
select cron.schedule('seo-translator-en', '15 4 * * *',
  $$select seo_invoke('translator',
    '{"source_lang":"en","target_langs":["es","de","fr","it","pt-br"],"max":5}'::jsonb);$$);

-- 04:45 — og-image-gen for new posts
select cron.schedule('seo-og-image', '45 4 * * *',
  $$select seo_invoke('og-image-gen', '{"max":15}'::jsonb);$$);

-- 06:30 — monetization injector (after ranking-opt)
select cron.schedule('seo-monetize', '30 6 * * *',
  $$select seo_invoke('monetization-injector', '{"max":20}'::jsonb);$$);

-- ───────────────────────────────────────────────────────────────────────────
-- FULL DAILY TIMELINE (UTC)
-- ───────────────────────────────────────────────────────────────────────────
-- 02:00  trend-scan          7 langs queue refill
-- 02:30  content-gen         35 drafts/day
-- 03:15  quality-gate        score → reject/keep
-- 03:45  publisher           commit passing
-- 04:00  translator-tr       TR → 5 langs × 5 posts
-- 04:15  translator-en       EN → 5 langs × 5 posts
-- 04:30  link-enhancer       wire siblings
-- 04:45  og-image-gen        replicate flux
-- 05:00  backlink-gen        outreach drafts
-- 05:30  viral-gen           tiktok/ig/x
-- 06:00  ranking-opt         A/B variants
-- 06:30  monetize            inject affiliate links
-- ───────────────────────────────────────────────────────────────────────────
-- WEEKLY
-- Mon 07:00  gsc-sync         analytics ingest
-- Mon 07:30  content-refresh  5 stale posts
-- Tue 08:00  topic-cluster    pillar rebuild
-- ───────────────────────────────────────────────────────────────────────────
