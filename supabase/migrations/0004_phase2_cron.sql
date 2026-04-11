-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — Phase 2 cron schedules
-- ═══════════════════════════════════════════════════════════════════════════
-- Adds: gsc-sync, quality-gate, content-refresh, internal-link-enhancer,
--       viral-gen, topic-cluster-builder
-- All times UTC. Pipeline order matters: scan → gen → quality → publish →
--                                         link → backlink → viral → index.
-- ═══════════════════════════════════════════════════════════════════════════

-- Reschedule existing jobs to leave room for new ones (idempotent)
select cron.unschedule('seo-trend-scan')   where exists(select 1 from cron.job where jobname='seo-trend-scan');
select cron.unschedule('seo-content-gen')  where exists(select 1 from cron.job where jobname='seo-content-gen');
select cron.unschedule('seo-publisher')    where exists(select 1 from cron.job where jobname='seo-publisher');
select cron.unschedule('seo-backlink-gen') where exists(select 1 from cron.job where jobname='seo-backlink-gen');
select cron.unschedule('seo-ranking-opt')  where exists(select 1 from cron.job where jobname='seo-ranking-opt');
select cron.unschedule('seo-gsc-sync')     where exists(select 1 from cron.job where jobname='seo-gsc-sync');

-- ───────────────────────────────────────────────────────────────────────────
-- DAILY PIPELINE (Europe-friendly times — finishes before EU morning)
-- ───────────────────────────────────────────────────────────────────────────

-- 02:00 — refill keyword queue
select cron.schedule('seo-trend-scan', '0 2 * * *',
  $$select seo_invoke('trend-scanner', '{"langs":["tr","en"]}'::jsonb);$$);

-- 02:30 — generate batch (TR + EN, 20 total)
select cron.schedule('seo-content-gen', '30 2 * * *',
  $$select seo_invoke('content-generator', '{"batch":20}'::jsonb);$$);

-- 03:15 — quality gate (score everything generated)
select cron.schedule('seo-quality-gate', '15 3 * * *',
  $$select seo_invoke('quality-gate', '{"max":50,"min_score":70}'::jsonb);$$);

-- 03:45 — publish drafts that passed quality
select cron.schedule('seo-publisher', '45 3 * * *',
  $$select seo_invoke('publisher', '{"max":30}'::jsonb);$$);

-- 04:30 — internal link enhancer (wires new posts into older siblings)
select cron.schedule('seo-link-enhancer', '30 4 * * *',
  $$select seo_invoke('internal-link-enhancer', '{"max_anchors":15}'::jsonb);$$);

-- 05:00 — backlink drafts
select cron.schedule('seo-backlink-gen', '0 5 * * *',
  $$select seo_invoke('backlink-autogen', '{"lookback_hours":24}'::jsonb);$$);

-- 05:30 — viral drafts (TikTok/IG/X scripts)
select cron.schedule('seo-viral-gen', '30 5 * * *',
  $$select seo_invoke('viral-gen', '{"lookback_hours":24}'::jsonb);$$);

-- 06:00 — ranking optimizer (low CTR rewrite)
select cron.schedule('seo-ranking-opt', '0 6 * * *',
  $$select seo_invoke('ranking-optimizer', '{}'::jsonb);$$);

-- ───────────────────────────────────────────────────────────────────────────
-- WEEKLY MAINTENANCE
-- ───────────────────────────────────────────────────────────────────────────

-- Mon 07:00 — GSC analytics sync (last 7 days)
select cron.schedule('seo-gsc-sync', '0 7 * * 1',
  $$select seo_invoke('gsc-sync', '{"days":7}'::jsonb);$$);

-- Mon 07:30 — refresh stale posts (5/week ≈ 260/year)
select cron.schedule('seo-content-refresh', '30 7 * * 1',
  $$select seo_invoke('content-refresh', '{"max":5}'::jsonb);$$);

-- Tue 08:00 — rebuild topic cluster pillars
select cron.schedule('seo-topic-cluster', '0 8 * * 2',
  $$select seo_invoke('topic-cluster-builder', '{}'::jsonb);$$);

-- ───────────────────────────────────────────────────────────────────────────
-- HEALTH CHECK VIEW (extended)
-- ───────────────────────────────────────────────────────────────────────────
create or replace view seo_cron_health as
select
  j.jobname,
  j.schedule,
  r.status,
  r.return_message,
  r.start_time,
  r.end_time,
  extract(epoch from (r.end_time - r.start_time))::int as duration_s
from cron.job j
left join lateral (
  select * from cron.job_run_details
  where jobid = j.jobid
  order by start_time desc limit 1
) r on true
where j.jobname like 'seo-%'
order by j.jobname;
