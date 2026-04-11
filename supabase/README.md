# Astrobobo SEO Machine — Operational Manual

Autonomous SEO content empire. Plug-in to existing astrobobo Flutter web app.

## TL;DR

```bash
# 1. Create Supabase project (free tier OK for Phase 1-2)
# 2. Bootstrap
cd ~/Documents/astrobobo
./scripts/gen_indexnow_key.sh        # → IndexNow key file in web/
./scripts/seo_init.sh                # → fills .env.seo template
# Fill .env.seo
./scripts/seo_init.sh                # → migrate + deploy 16 functions

# 3. Vault secrets (Supabase SQL editor, ONCE)
select vault.create_secret('https://<ref>.functions.supabase.co', 'functions_url');
select vault.create_secret('<service-role-key>', 'service_role_key');

# 4. Verify
./scripts/seo_status.sh

# 5. Open admin dashboard
open https://astrobobo.com/admin/seo.html
```

## Architecture

```
SUPABASE (brain)
├─ pg_cron        — schedules edge functions
├─ tables         — keyword_queue, posts, analytics_daily, ab_variants,
│                   backlink_tasks, viral_drafts, citation_events, og_images,
│                   translations, monetization_links, alerts, content_refresh_log
└─ 16 edge functions

      │
      ▼
GitHub repo (astrobobo)
├─ content/{lang}/*.md   — committed by edge functions
├─ scripts/generate_seo_pages.dart   — md → static HTML
└─ .github/workflows/seo-build.yml   — fires on content/** push

      │
      ▼
Vercel (astrobobo.com)
├─ /                   — Flutter SPA (untouched)
├─ /r/{lang}/{slug}    — static SEO HTML (135+ pages)
├─ /sitemap.xml        — auto-generated
├─ /admin/seo.html     — dashboard (noindex)
└─ /<KEY>.txt          — IndexNow verification
```

## Edge Functions (16 total)

| Function | Schedule | Purpose |
|---|---|---|
| `trend-scanner` | 02:00 daily | refill keyword_queue from 7 lang seeds |
| `content-generator` | 02:30 daily | claim queue → Claude Opus 4.6 → draft posts |
| `quality-gate` | 03:15 daily | heuristic score, reject < 70 |
| `publisher` | 03:45 daily | commit drafts to git → status='published' |
| `translator` | 04:00 + 04:15 daily | TR/EN → 5 other langs |
| `internal-link-enhancer` | 04:30 daily | wire new posts into siblings |
| `og-image-gen` | 04:45 daily | Replicate flux-schnell cover images |
| `backlink-autogen` | 05:00 daily | Medium/Reddit/Quora drafts (manual post) |
| `viral-gen` | 05:30 daily | TikTok/IG/X/YT/Threads scripts |
| `ranking-optimizer` | 06:00 daily | low-CTR detect → A/B variant |
| `monetization-injector` | 06:30 daily | inject affiliate blocks per cluster |
| `indexer` | on publish chain | IndexNow + Bing submission |
| `gsc-sync` | Mon 07:00 | last 7 days analytics |
| `content-refresh` | Mon 07:30 | rewrite 5 stale posts/week |
| `topic-cluster-builder` | Tue 08:00 | regenerate pillar pages |
| `citation-tracker` | on demand | log citation events from AI sources |

## Daily Capacity

- **35 new posts/day** across 7 langs
- **25 translations/day** (TR×5 + EN×5 → 5 langs)
- **20 affiliate injections/day**
- **15 OG images/day** (~$0.045/day)
- **5 stale refreshes/week** (260/year)
- **20 backlink drafts/day** (manual approval)
- **100 viral drafts/day** (5 channels × 20 posts)

## Quality Gate Heuristics

| Check | Penalty |
|---|---|
| Word count < 600 | -30 |
| Word count < 900 | -10 |
| Internal links < 3 | -15 |
| FAQ < 3 | -10 |
| H2 < 3 | -10 |
| Title len 30-65 fail | -5 |
| Meta len 100-165 fail | -5 |
| Banned phrase | -5 each |
| Bigram repetition > 4% | -10 |
| **Threshold** | **70/100** |

## Database Tables

```
keyword_queue       — input queue, 100+ seeds × 7 langs
posts               — generated content, statuses: draft|published|archived|failed
analytics_daily     — GSC/Bing per-page metrics
ab_variants         — title/meta A/B tests
backlink_tasks      — outreach drafts, manual approval
viral_drafts        — short-form social drafts
citation_events     — when AI cites our content
og_images           — generated cover images
translations        — TR/EN → other lang lineage
monetization_links  — affiliate inventory per cluster+lang
alerts              — cron failures, anomalies
content_refresh_log — refresh history per post
trend_scan          — raw scanner audit trail
gsc_state           — incremental sync cursor
```

## Required Env Vars

| Variable | Purpose | Where |
|---|---|---|
| `SUPABASE_URL` | auto-set by Supabase | edge runtime |
| `SUPABASE_SERVICE_ROLE_KEY` | auto-set | edge runtime |
| `ANTHROPIC_API_KEY` | Claude Opus 4.6 | required |
| `GITHUB_TOKEN` | Contents API write | required |
| `GITHUB_REPO` | e.g. `umutnull/astrobobo` | required |
| `GITHUB_BRANCH` | default `main` | optional |
| `SITE_ORIGIN` | `https://astrobobo.com` | required |
| `INDEXNOW_KEY` | from gen_indexnow_key.sh | required |
| `BING_WEBMASTER_KEY` | optional belt-and-braces | optional |
| `GOOGLE_SA_JSON` | service account JSON inline | for gsc-sync |
| `GSC_SITE_URL` | `https://astrobobo.com/` | for gsc-sync |
| `REPLICATE_API_TOKEN` | for og-image-gen | for images |
| `REPLICATE_MODEL_VERSION` | default `black-forest-labs/flux-schnell` | optional |

## Manual Operations

### Trigger function manually
```bash
FN=content-generator   # any function name
curl -X POST "https://<ref>.functions.supabase.co/$FN" \
  -H "Authorization: Bearer <service-role>" \
  -H "Content-Type: application/json" \
  -d '{"batch":5,"lang":"tr"}'
```

### Add monetization link
```sql
insert into monetization_links (cluster, lang, anchor, url, partner, rel)
values ('ruya', 'tr', 'Profesyonel rüya günlüğü', 'https://amzn.to/xxx', 'amazon', 'sponsored noopener nofollow');
```

### Force regenerate a single post
```sql
-- 1. Mark draft
update posts set status='draft', body_md='' where id=123;
-- 2. Reset its keyword
update keyword_queue set status='new' where id = (select keyword_id from posts where id=123);
-- 3. Trigger content-generator
```

### Approve a backlink draft
```sql
-- After you've posted manually
update backlink_tasks
  set status='posted', posted_url='https://medium.com/...', posted_at=now()
  where id=42;
```

### Log a citation manually
Use admin dashboard `/admin/seo.html` or:
```bash
curl -X POST "https://<ref>.functions.supabase.co/citation-tracker" \
  -H "Authorization: Bearer <service-role>" \
  -H "Content-Type: application/json" \
  -d '{
    "action":"log",
    "source":"chatgpt",
    "query":"rüyada yılan görmek",
    "cited_url":"https://astrobobo.com/r/tr/ruyada-yilan",
    "snippet":"Astrobobo'\''ya göre yılan rüyası..."
  }'
```

## Troubleshooting

### Cron not firing
```sql
select * from seo_cron_health;
-- Check vault.decrypted_secrets has functions_url and service_role_key
select count(*) from vault.decrypted_secrets where name in ('functions_url','service_role_key');
```

### Edge function errors
```sql
-- Recent failed runs
select * from cron.job_run_details where status='failed' order by start_time desc limit 10;
```

### Quality gate rejecting too much
```sql
-- See rejected reasons
select rejected_reason, count(*)
from keyword_queue where rejected_reason is not null
group by rejected_reason order by count desc;

-- Lower threshold temporarily
-- supabase secrets set QUALITY_MIN_SCORE=60
```

### GitHub commit failures
- Check `GITHUB_TOKEN` has `contents:write` scope on the repo
- For protected `main`, use a `SEO_PUSH_TOKEN` PAT with bypass permission

### IndexNow not working
- Verify `https://astrobobo.com/<KEY>.txt` returns the key (not 404)
- Check Bing Webmaster Tools → Site → IndexNow status

## Cost Estimates (autopilot, monthly)

| Service | Use | Cost |
|---|---|---|
| Supabase | DB + functions + cron | $25/mo (Pro tier recommended) |
| Anthropic Claude Opus 4.6 | content + translate + refresh | ~$60-100/mo @ 35 posts/day |
| Replicate flux-schnell | OG images @ 15/day | ~$1.50/mo |
| Vercel | hosting | existing tier |
| GitHub | repo + actions | free |
| **Total** | | **~$90-130/mo** |

ROI breakeven: ~10 organic clicks/day at $0.40 RPM = $1.20/day. Hit ~3000 indexed pages and you're profitable.

## File Layout

```
astrobobo/
├─ supabase/
│  ├─ migrations/
│  │  ├─ 0001_seo_schema.sql
│  │  ├─ 0002_pg_cron.sql
│  │  ├─ 0003_phase2_schema.sql
│  │  ├─ 0004_phase2_cron.sql
│  │  ├─ 0005_phase3_schema.sql
│  │  └─ 0006_phase3_cron.sql
│  ├─ functions/
│  │  ├─ _shared/
│  │  │  ├─ supabase.ts
│  │  │  ├─ github.ts
│  │  │  ├─ claude.ts
│  │  │  └─ google_jwt.ts
│  │  ├─ trend-scanner/
│  │  ├─ content-generator/
│  │  ├─ quality-gate/
│  │  ├─ publisher/
│  │  ├─ indexer/
│  │  ├─ internal-link-enhancer/
│  │  ├─ backlink-autogen/
│  │  ├─ viral-gen/
│  │  ├─ ranking-optimizer/
│  │  ├─ content-refresh/
│  │  ├─ topic-cluster-builder/
│  │  ├─ gsc-sync/
│  │  ├─ translator/
│  │  ├─ citation-tracker/
│  │  ├─ og-image-gen/
│  │  └─ monetization-injector/
│  ├─ seeds/
│  │  ├─ tr_seeds.json    (100)
│  │  ├─ en_seeds.json    (100)
│  │  ├─ es_seeds.json    (50)
│  │  ├─ de_seeds.json    (50)
│  │  ├─ fr_seeds.json    (50)
│  │  ├─ it_seeds.json    (50)
│  │  └─ pt-br_seeds.json (50)
│  └─ README.md  (this file)
├─ scripts/
│  ├─ generate_seo_pages.dart    — md → static HTML
│  ├─ generate_sitemap.dart      — sitemap.xml
│  ├─ seo_init.sh                — bootstrap
│  ├─ seo_status.sh              — live dashboard CLI
│  └─ gen_indexnow_key.sh        — IndexNow key
├─ .github/workflows/
│  └─ seo-build.yml
├─ web/
│  ├─ admin/seo.html             — dashboard UI
│  ├─ .well-known/ai-content.txt — AI citation policy
│  ├─ robots.txt                 — explicit AI bot allow
│  └─ r/{lang}/{slug}.html       — generated SEO pages
└─ content/{lang}/*.md           — source markdown
```
