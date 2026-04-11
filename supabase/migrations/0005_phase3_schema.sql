-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — Phase 3 schema
-- ═══════════════════════════════════════════════════════════════════════════
-- New: og_images, translations, monetization_links, alerts
-- Alter: posts.og_image_url, posts.has_monetization
-- ═══════════════════════════════════════════════════════════════════════════

-- ───────────────────────────────────────────────────────────────────────────
-- 1. og_images — generated cover images per post
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists og_images (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  prompt        text not null,
  provider      text not null check (provider in ('replicate','openai','stability','flux','manual')),
  model         text,
  url           text not null,
  width         int default 1200,
  height        int default 630,
  cost_usd      numeric(8,4),
  created_at    timestamptz default now(),
  unique(post_id, provider)
);
create index if not exists idx_og_images_post on og_images(post_id);

-- ───────────────────────────────────────────────────────────────────────────
-- 2. translations — track which posts have which lang siblings
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists translations (
  id            bigserial primary key,
  source_post_id bigint references posts(id) on delete cascade,
  target_post_id bigint references posts(id) on delete cascade,
  source_lang   text not null,
  target_lang   text not null,
  model         text,
  cost_usd      numeric(8,4),
  created_at    timestamptz default now(),
  unique(source_post_id, target_lang)
);
create index if not exists idx_translations_source on translations(source_post_id);
create index if not exists idx_translations_target on translations(target_post_id);

-- ───────────────────────────────────────────────────────────────────────────
-- 3. monetization_links — affiliate / sponsored link inventory
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists monetization_links (
  id            bigserial primary key,
  cluster       text not null,
  lang          text not null,
  anchor        text not null,
  url           text not null,
  partner       text,        -- 'amazon'|'gumroad'|'lemonsqueezy'|'sponsor'
  rel           text default 'sponsored noopener',
  active        boolean default true,
  clicks        int default 0,
  conversions   int default 0,
  revenue_usd   numeric(10,2) default 0,
  created_at    timestamptz default now()
);
create index if not exists idx_monetization_active on monetization_links(cluster, lang, active);

-- ───────────────────────────────────────────────────────────────────────────
-- 4. alerts — simple alerting log (cron failures, anomalies)
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists alerts (
  id            bigserial primary key,
  severity      text not null check (severity in ('info','warn','error','critical')),
  source        text not null,
  message       text not null,
  context       jsonb,
  acknowledged  boolean default false,
  created_at    timestamptz default now()
);
create index if not exists idx_alerts_unack on alerts(acknowledged, created_at desc) where not acknowledged;

-- ───────────────────────────────────────────────────────────────────────────
-- 5. posts: og + monetization columns
-- ───────────────────────────────────────────────────────────────────────────
alter table posts
  add column if not exists og_image_url text,
  add column if not exists has_monetization boolean default false,
  add column if not exists translated_from bigint references posts(id) on delete set null;

create index if not exists idx_posts_translated_from on posts(translated_from);

-- ───────────────────────────────────────────────────────────────────────────
-- 6. seo_pulse v3 — final dashboard view
-- ───────────────────────────────────────────────────────────────────────────
create or replace view seo_pulse as
select
  -- Content
  (select count(*) from posts where status='published') as total_pages,
  (select count(*) from posts where status='draft') as draft_pages,
  (select count(*) from posts where status='published' and published_at > now() - interval '7 days') as weekly_new,
  (select count(*) from posts where status='published' and published_at > now() - interval '24 hours') as daily_new,
  (select count(*) from posts where status='published' and last_refreshed_at > now() - interval '30 days') as monthly_refreshed,
  (select count(*) from posts where status='published' and og_image_url is not null) as with_og_image,
  (select count(distinct lang) from posts where status='published') as active_langs,
  -- Pipeline
  (select count(*) from keyword_queue where status='new') as queue_depth,
  (select count(*) from translations) as translations_count,
  -- Analytics
  (select coalesce(sum(impressions),0) from analytics_daily where date > now()::date - 7) as weekly_impressions,
  (select coalesce(sum(clicks),0)      from analytics_daily where date > now()::date - 7) as weekly_clicks,
  (select round(avg(avg_position)::numeric,2) from analytics_daily where date > now()::date - 7) as avg_position,
  -- Backlinks
  (select count(*) from backlink_tasks where status='posted') as live_backlinks,
  (select count(*) from backlink_tasks where status='pending') as pending_backlinks,
  -- Viral
  (select count(*) from viral_drafts where status='posted') as live_viral,
  (select count(*) from viral_drafts where status='pending') as pending_viral,
  -- Optimization
  (select count(*) from ab_variants where winner is null and active_from > now() - interval '14 days') as running_ab_tests,
  -- Citations & monetization
  (select count(*) from citation_events where detected_at > now() - interval '7 days') as weekly_citations,
  (select coalesce(sum(revenue_usd),0) from monetization_links where active) as total_revenue_usd,
  (select coalesce(sum(clicks),0) from monetization_links where active) as monetization_clicks,
  -- Health
  (select count(*) from alerts where not acknowledged and severity in ('error','critical')) as open_alerts
;

-- ───────────────────────────────────────────────────────────────────────────
-- 7. RLS for new tables
-- ───────────────────────────────────────────────────────────────────────────
alter table og_images          enable row level security;
alter table translations       enable row level security;
alter table monetization_links enable row level security;
alter table alerts             enable row level security;
