-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — Phase 1 Schema
-- ═══════════════════════════════════════════════════════════════════════════
-- Tables: keyword_queue, posts, analytics_daily, ab_variants,
--         backlink_tasks, trend_scan
-- View:   seo_pulse
-- ═══════════════════════════════════════════════════════════════════════════

-- Extensions used downstream (pg_cron/pg_net enabled via 0002)
create extension if not exists "pgcrypto";

-- ───────────────────────────────────────────────────────────────────────────
-- 1. keyword_queue — trend-scanner output, content-generator input
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists keyword_queue (
  id            bigserial primary key,
  keyword       text not null,
  lang          text not null check (lang in ('tr','en','es','de','fr','it','pt-br','ru','ar')),
  cluster       text not null check (cluster in ('ruya','burclar','askUyumu','dogumHaritasi','gunlukYorum','tarot','numeroloji')),
  intent        text default 'definition' check (intent in ('definition','howto','daily','list')),
  volume_est    int,
  cpc_est       numeric(10,2),
  difficulty    int,
  source        text default 'seed' check (source in ('seed','google_trends','gsc_opportunity','manual','related')),
  priority      int default 50,
  status        text default 'new' check (status in ('new','claimed','generated','published','rejected')),
  claimed_at    timestamptz,
  rejected_reason text,
  created_at    timestamptz default now(),
  unique(keyword, lang)
);
create index if not exists idx_keyword_queue_status on keyword_queue(status, lang, priority desc);
create index if not exists idx_keyword_queue_cluster on keyword_queue(cluster, lang);

-- ───────────────────────────────────────────────────────────────────────────
-- 2. posts — generated content
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists posts (
  id            bigserial primary key,
  slug          text not null,
  lang          text not null,
  cluster       text not null,
  keyword_id    bigint references keyword_queue(id) on delete set null,
  title         text not null,
  meta_desc     text not null,
  h1            text not null,
  body_md       text not null,
  faq           jsonb default '[]'::jsonb,
  schema_json   jsonb,
  internal_links text[] default '{}',
  word_count    int,
  status        text default 'draft' check (status in ('draft','published','archived','failed')),
  quality_score numeric(4,2),
  model_used    text,
  generated_at  timestamptz default now(),
  published_at  timestamptz,
  updated_at    timestamptz default now(),
  git_sha       text,
  commit_url    text,
  unique(slug, lang)
);
create index if not exists idx_posts_status on posts(status, lang, published_at desc nulls last);
create index if not exists idx_posts_cluster on posts(cluster, lang);
create index if not exists idx_posts_updated on posts(updated_at desc);

-- auto-touch updated_at
create or replace function touch_updated_at() returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_posts_touch on posts;
create trigger trg_posts_touch before update on posts
  for each row execute function touch_updated_at();

-- ───────────────────────────────────────────────────────────────────────────
-- 3. analytics_daily — GSC + Bing + internal
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists analytics_daily (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  slug          text,
  lang          text,
  date          date not null,
  impressions   int default 0,
  clicks        int default 0,
  ctr           numeric(5,4),
  avg_position  numeric(5,2),
  source        text default 'gsc' check (source in ('gsc','bing','internal','ga4')),
  raw           jsonb,
  fetched_at    timestamptz default now(),
  unique(post_id, date, source)
);
create index if not exists idx_analytics_post_date on analytics_daily(post_id, date desc);
create index if not exists idx_analytics_opportunity on analytics_daily(date desc, impressions desc)
  where ctr < 0.02 and impressions > 50;

-- ───────────────────────────────────────────────────────────────────────────
-- 4. ab_variants — title/meta A/B testing (ranking-optimizer)
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists ab_variants (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  variant       text not null check (variant in ('A','B')),
  title         text not null,
  meta_desc     text not null,
  active_from   timestamptz default now(),
  active_to     timestamptz,
  impressions   int default 0,
  clicks        int default 0,
  ctr           numeric(5,4),
  winner        boolean,
  created_at    timestamptz default now()
);
create index if not exists idx_ab_post on ab_variants(post_id, variant);

-- ───────────────────────────────────────────────────────────────────────────
-- 5. backlink_tasks — outreach drafts (human-in-the-loop)
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists backlink_tasks (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  channel       text not null check (channel in ('medium','reddit','quora','forum','devto','hashnode','linkedin')),
  title         text,
  draft_md      text not null,
  target_url    text,
  status        text default 'pending' check (status in ('pending','approved','scheduled','posted','dead','rejected')),
  posted_url    text,
  posted_at     timestamptz,
  dofollow      boolean,
  created_at    timestamptz default now()
);
create index if not exists idx_backlink_status on backlink_tasks(status, created_at desc);

-- ───────────────────────────────────────────────────────────────────────────
-- 6. trend_scan — raw trend audit trail
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists trend_scan (
  id            bigserial primary key,
  scanned_at    timestamptz default now(),
  lang          text,
  source        text,
  raw           jsonb,
  new_keywords  int default 0,
  duration_ms   int
);

-- ───────────────────────────────────────────────────────────────────────────
-- 7. seo_pulse — single-query dashboard
-- ───────────────────────────────────────────────────────────────────────────
create or replace view seo_pulse as
select
  (select count(*) from posts where status='published') as total_pages,
  (select count(*) from posts where status='published' and published_at > now() - interval '7 days') as weekly_new,
  (select count(*) from posts where status='published' and published_at > now() - interval '24 hours') as daily_new,
  (select count(*) from keyword_queue where status='new') as queue_depth,
  (select coalesce(sum(impressions),0) from analytics_daily where date > now()::date - 7) as weekly_impressions,
  (select coalesce(sum(clicks),0) from analytics_daily where date > now()::date - 7) as weekly_clicks,
  (select round(avg(avg_position)::numeric,2) from analytics_daily where date > now()::date - 7) as avg_position,
  (select count(*) from backlink_tasks where status='posted') as live_backlinks,
  (select count(*) from backlink_tasks where status='pending') as pending_backlinks,
  (select count(*) from ab_variants where winner is null and active_from > now() - interval '14 days') as running_ab_tests
;

-- ───────────────────────────────────────────────────────────────────────────
-- RLS: service_role has full access, anon can read published posts
-- ───────────────────────────────────────────────────────────────────────────
alter table posts           enable row level security;
alter table keyword_queue   enable row level security;
alter table analytics_daily enable row level security;
alter table ab_variants     enable row level security;
alter table backlink_tasks  enable row level security;
alter table trend_scan      enable row level security;

drop policy if exists "posts_public_read" on posts;
create policy "posts_public_read" on posts
  for select using (status = 'published');

-- service_role bypasses RLS automatically
