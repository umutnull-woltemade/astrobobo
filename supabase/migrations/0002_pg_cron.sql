-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — pg_cron schedules
-- ═══════════════════════════════════════════════════════════════════════════
-- Requires extensions: pg_cron, pg_net (Supabase: Database → Extensions)
-- Expects vault secrets: service_role_key, functions_url
-- ═══════════════════════════════════════════════════════════════════════════

create extension if not exists pg_cron;
create extension if not exists pg_net;

-- ───────────────────────────────────────────────────────────────────────────
-- Vault: run ONCE in Supabase SQL editor with real values
-- ───────────────────────────────────────────────────────────────────────────
-- select vault.create_secret('https://<project-ref>.functions.supabase.co', 'functions_url');
-- select vault.create_secret('<service-role-key>',                          'service_role_key');

-- helper to fire any edge function
create or replace function seo_invoke(fn text, payload jsonb default '{}'::jsonb)
returns bigint
language plpgsql
security definer
as $$
declare
  v_url  text;
  v_key  text;
  v_req  bigint;
begin
  select decrypted_secret into v_url from vault.decrypted_secrets where name='functions_url';
  select decrypted_secret into v_key from vault.decrypted_secrets where name='service_role_key';
  select net.http_post(
    url     := v_url || '/' || fn,
    body    := payload,
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || v_key,
      'Content-Type',  'application/json'
    ),
    timeout_milliseconds := 60000
  ) into v_req;
  return v_req;
end;
$$;

-- ───────────────────────────────────────────────────────────────────────────
-- SCHEDULES (UTC)
-- ───────────────────────────────────────────────────────────────────────────

-- 02:00 — Scan trends, refill keyword_queue
select cron.schedule(
  'seo-trend-scan',
  '0 2 * * *',
  $$select seo_invoke('trend-scanner', '{"langs":["tr","en"]}'::jsonb);$$
);

-- 03:00 — Generate 20 posts (10 TR + 10 EN)
select cron.schedule(
  'seo-content-gen',
  '0 3 * * *',
  $$select seo_invoke('content-generator', '{"batch":20}'::jsonb);$$
);

-- 04:00 — Publish drafts (commit to git, chain indexer)
select cron.schedule(
  'seo-publisher',
  '0 4 * * *',
  $$select seo_invoke('publisher', '{"max":30}'::jsonb);$$
);

-- 05:00 — Backlink drafts for yesterday's publishes
select cron.schedule(
  'seo-backlink-gen',
  '0 5 * * *',
  $$select seo_invoke('backlink-autogen', '{"lookback_hours":24}'::jsonb);$$
);

-- 06:00 — Ranking optimizer (low CTR rewrite)
select cron.schedule(
  'seo-ranking-opt',
  '0 6 * * *',
  $$select seo_invoke('ranking-optimizer', '{}'::jsonb);$$
);

-- Mon 07:00 — GSC sync (fetch last week analytics)
select cron.schedule(
  'seo-gsc-sync',
  '0 7 * * 1',
  $$select seo_invoke('gsc-sync', '{"days":7}'::jsonb);$$
);

-- ───────────────────────────────────────────────────────────────────────────
-- Monitoring: simple view on cron job history
-- ───────────────────────────────────────────────────────────────────────────
create or replace view seo_cron_health as
select
  j.jobname,
  j.schedule,
  r.status,
  r.return_message,
  r.start_time,
  r.end_time,
  extract(epoch from (r.end_time - r.start_time)) as duration_s
from cron.job j
left join lateral (
  select * from cron.job_run_details
  where jobid = j.jobid
  order by start_time desc limit 1
) r on true
where j.jobname like 'seo-%'
order by j.jobname;
