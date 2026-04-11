-- ═══════════════════════════════════════════════════════════════════════════
-- ASTROBOBO SEO MACHINE — Phase 2 schema additions
-- ═══════════════════════════════════════════════════════════════════════════
-- New: viral_drafts, content_refresh_log, citation_events, gsc_state
-- Alter: posts.quality_score (was nullable; now indexed)
-- ═══════════════════════════════════════════════════════════════════════════

-- ───────────────────────────────────────────────────────────────────────────
-- 1. viral_drafts — TikTok/IG/X content for each post
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists viral_drafts (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  channel       text not null check (channel in ('tiktok','instagram','x','youtube_shorts','linkedin','threads')),
  hook          text,
  script_md     text not null,
  hashtags      text[],
  cta_url       text,
  duration_s    int,
  status        text default 'pending' check (status in ('pending','approved','scheduled','posted','dead','rejected')),
  posted_url    text,
  posted_at     timestamptz,
  views         int,
  likes         int,
  shares        int,
  clicks        int,
  created_at    timestamptz default now()
);
create index if not exists idx_viral_status on viral_drafts(status, created_at desc);
create index if not exists idx_viral_post on viral_drafts(post_id);

-- ───────────────────────────────────────────────────────────────────────────
-- 2. content_refresh_log — track which posts were refreshed when, why
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists content_refresh_log (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete cascade,
  refreshed_at  timestamptz default now(),
  trigger       text,            -- 'age'|'low_position'|'manual'|'topic_update'
  prev_word_count int,
  new_word_count  int,
  prev_position   numeric(5,2),
  diff_summary    text,
  git_sha         text
);
create index if not exists idx_refresh_post on content_refresh_log(post_id, refreshed_at desc);

-- ───────────────────────────────────────────────────────────────────────────
-- 3. citation_events — log when our content gets cited (manual or webhook)
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists citation_events (
  id            bigserial primary key,
  post_id       bigint references posts(id) on delete set null,
  source        text not null,   -- 'chatgpt'|'perplexity'|'google_ai_overview'|'bing_chat'|'bard'
  query         text,
  cited_url     text,
  snippet       text,
  raw           jsonb,
  detected_at   timestamptz default now()
);
create index if not exists idx_citation_source on citation_events(source, detected_at desc);
create index if not exists idx_citation_post on citation_events(post_id);

-- ───────────────────────────────────────────────────────────────────────────
-- 4. gsc_state — incremental sync cursor for Google Search Console
-- ───────────────────────────────────────────────────────────────────────────
create table if not exists gsc_state (
  site_url      text primary key,
  last_synced_date date,
  last_sync_at  timestamptz,
  rows_synced   bigint default 0
);

-- ───────────────────────────────────────────────────────────────────────────
-- 5. posts: quality_score index, refresh tracking, citation count cache
-- ───────────────────────────────────────────────────────────────────────────
alter table posts
  add column if not exists last_refreshed_at timestamptz,
  add column if not exists citation_count int default 0,
  add column if not exists internal_link_count int generated always as (coalesce(array_length(internal_links,1),0)) stored;

create index if not exists idx_posts_quality on posts(quality_score desc nulls last) where status='draft';
create index if not exists idx_posts_refresh on posts(last_refreshed_at nulls first, published_at) where status='published';

-- ───────────────────────────────────────────────────────────────────────────
-- 6. RPC: find CTR opportunities (used by ranking-optimizer fallback)
-- ───────────────────────────────────────────────────────────────────────────
create or replace function find_ctr_opportunities()
returns table (
  post_id bigint,
  slug text,
  lang text,
  title text,
  meta_desc text,
  h1 text,
  impressions int,
  ctr numeric,
  avg_position numeric
)
language sql
stable
as $$
  select
    p.id,
    p.slug,
    p.lang,
    p.title,
    p.meta_desc,
    p.h1,
    sum(a.impressions)::int as impressions,
    (sum(a.clicks)::numeric / nullif(sum(a.impressions),0))::numeric(5,4) as ctr,
    avg(a.avg_position)::numeric(5,2) as avg_position
  from posts p
  join analytics_daily a on a.post_id = p.id
  where a.date >= current_date - interval '14 days'
    and p.status = 'published'
  group by p.id
  having sum(a.impressions) > 100
     and (sum(a.clicks)::numeric / nullif(sum(a.impressions),0)) < 0.01
  order by sum(a.impressions) desc
  limit 50;
$$;

-- ───────────────────────────────────────────────────────────────────────────
-- 7. seo_pulse v2 — extended dashboard
-- ───────────────────────────────────────────────────────────────────────────
create or replace view seo_pulse as
select
  (select count(*) from posts where status='published') as total_pages,
  (select count(*) from posts where status='draft') as draft_pages,
  (select count(*) from posts where status='published' and published_at > now() - interval '7 days') as weekly_new,
  (select count(*) from posts where status='published' and published_at > now() - interval '24 hours') as daily_new,
  (select count(*) from posts where status='published' and last_refreshed_at > now() - interval '30 days') as monthly_refreshed,
  (select count(*) from keyword_queue where status='new') as queue_depth,
  (select coalesce(sum(impressions),0) from analytics_daily where date > now()::date - 7) as weekly_impressions,
  (select coalesce(sum(clicks),0) from analytics_daily where date > now()::date - 7) as weekly_clicks,
  (select round(avg(avg_position)::numeric,2) from analytics_daily where date > now()::date - 7) as avg_position,
  (select count(*) from backlink_tasks where status='posted') as live_backlinks,
  (select count(*) from backlink_tasks where status='pending') as pending_backlinks,
  (select count(*) from viral_drafts where status='posted') as live_viral,
  (select count(*) from viral_drafts where status='pending') as pending_viral,
  (select count(*) from ab_variants where winner is null and active_from > now() - interval '14 days') as running_ab_tests,
  (select count(*) from citation_events where detected_at > now() - interval '7 days') as weekly_citations
;

-- RLS for new tables
alter table viral_drafts        enable row level security;
alter table content_refresh_log enable row level security;
alter table citation_events     enable row level security;
alter table gsc_state           enable row level security;
