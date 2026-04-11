# Astrobobo — AI/ChatGPT Visibility Playbook

Goal: get cited by ChatGPT, Perplexity, Google AI Overview, Bing Chat, Claude, Gemini.

## How AI engines pick what to cite

AI engines fall into two camps:

### Real-time browsing (ChatGPT, Perplexity, Bing Chat, Copilot)
1. User asks a question
2. Model issues 1-3 search queries
3. Searches against an index (Bing for ChatGPT/Copilot, custom for Perplexity)
4. Top results are fetched, parsed, and summarized
5. Sources are cited inline with footnotes

**Implication:** be in **Bing's index** + **rank top 5 for the query** + **be parseable**.

### Training data (base models, no browsing)
1. Web crawls during model training (CCBot, GPTBot, ClaudeBot, Google-Extended)
2. Models internalize content as latent knowledge
3. Cited as part of base knowledge, often without source links

**Implication:** be **crawled by training bots** + have **memorable brand entity** so the model can reference you by name.

## What we already have ✓

- ✓ `robots.txt` explicitly allows GPTBot, ClaudeBot, PerplexityBot, Google-Extended, Applebot-Extended, CCBot, Bytespider
- ✓ `/.well-known/ai-content.txt` declares citation policy
- ✓ `/llms.txt` and `/llms-full.txt` follow the LLMs.txt spec
- ✓ Schema.org `@graph` with Article, Organization, WebSite, BreadcrumbList, FAQPage
- ✓ Organization schema includes `sameAs` network
- ✓ Definition-first content structure (matches AI extraction patterns)
- ✓ `hreflang` alternates for multi-lang
- ✓ IndexNow → Bing instant submission
- ✓ Bing Webmaster API direct submission
- ✓ Multi-language coverage (9 langs)

## What still needs HUMAN action

### 1. Bing Webmaster Tools verification (15 min, **critical**)
Bing's index is what ChatGPT browses. Without verification, your content takes weeks to appear.

1. Go to https://www.bing.com/webmasters
2. Sign in with Microsoft account
3. Add site: `https://astrobobo.com/`
4. Verify via DNS TXT (preferred) or HTML file upload
5. Settings → API access → generate API key → save as `BING_WEBMASTER_KEY` in `.env.seo`
6. Submit sitemap: `https://astrobobo.com/sitemap.xml`
7. Settings → IndexNow → enable

### 2. Wikidata entry (20 min, **critical for entity recognition**)
ChatGPT, Perplexity, and Google use Wikidata as the canonical entity database. Having a Wikidata QID is the strongest single signal that "Astrobobo" is a real entity.

See `WIKIDATA_SUBMIT.md` in this folder for step-by-step.

### 3. Social profiles (1 hour)
Each social profile is a `sameAs` claim that strengthens entity authority. **Empty profiles are worse than no profile** — make at least 5 posts on each.

| Network | Username | Status | Priority |
|---|---|---|---|
| X / Twitter | @astrobobo | TBD | HIGH |
| Instagram | @astrobobo | TBD | HIGH |
| TikTok | @astrobobo | TBD | HIGH |
| Threads | @astrobobo | TBD | MEDIUM |
| YouTube | @astrobobo | TBD | MEDIUM |
| GitHub | astrobobo (org) | TBD | MEDIUM |
| LinkedIn | astrobobo | TBD | LOW |

After creating, update `scripts/brand_config.json` → `sameAs` array with the actual URLs.

### 4. Reddit / Quora seeding (ongoing, **critical for ChatGPT training data**)
ChatGPT (and Perplexity) heavily weight Reddit and Quora as authority sources. They're in EVERY training crawl.

Strategy:
- Find 5 active subreddits: r/dreams, r/astrology, r/Tarotpros, r/birthcharts, r/AskAstrologers
- Post **genuinely helpful answers** with occasional links to your articles
- Quora: answer 2-3 questions per week, link only when truly relevant
- **Goal:** 30-50 quality mentions per quarter

**Risk:** spamming Reddit/Quora gets you banned + AI engines ignore spammy patterns. Use the `backlink-autogen` drafts as INSPIRATION, not paste-and-submit.

### 5. GitHub presence (30 min)
Create a public GitHub org `astrobobo` with at least one real repo. Examples:
- `astrobobo/swiss-ephemeris-helpers` — Dart/JS bindings used internally
- `astrobobo/zodiac-data` — public JSON dataset of zodiac signs and their attributes
- `astrobobo/dream-symbol-corpus` — public CSV of common dream symbols

GitHub is in every AI training crawl. A real repo with real commits is a strong authority signal at near-zero cost.

### 6. Press / mention seeding (ongoing)
Every brand mention on the open web (forum, comment, blog post) trains AI to associate "Astrobobo" with the topic. Targets:

- Astrology forums (Lindaland, AstrologyWeekly forum)
- Spirituality blogs (comment on related posts with link)
- HARO / Help A Reporter Out (now Connectively) — answer journalist queries
- Podcast appearances (small astro podcasts)

Track in your `monetization_links` or a separate spreadsheet.

## Citation tracking

Set up a weekly habit:
1. Open ChatGPT, search 5 known query patterns ("rüyada yılan görmek nedir", "what does dreaming of snakes mean", etc.)
2. Note if Astrobobo appears as a source
3. Open `/admin/seo.html` → Manual Citation Logger → log it
4. Repeat for Perplexity, Bing Chat, Google AI Overview

This data feeds the `citation_events` table and shows you which content gets picked up.

## Realistic Timeline

| Phase | Weeks | What to expect |
|---|---|---|
| **Tech setup** | 0-2 | Bing verified, sitemap submitted, Wikidata pending review |
| **First Bing index** | 2-3 | All 137 pages indexed in Bing |
| **First ChatGPT cites** | 3-6 | Long-tail queries start citing Astrobobo |
| **Brand recognition** | 8-12 | Brand searches grow, sameAs network active |
| **AI Overview** | 16-26 | Google AI Overview starts including (slowest) |
| **Steady citation flow** | 26+ | 100-500 cites/month observable |

## What does NOT help (avoid wasting time)

- ❌ Paying for "AI SEO" tools that promise ChatGPT rankings (no such thing as ranking)
- ❌ Cloaking content for bots vs humans (AI engines detect this)
- ❌ Hidden text or keyword stuffing
- ❌ Duplicating content across pages
- ❌ Buying backlinks
- ❌ Comment spam

## What gives compounding returns

- ✅ One high-quality article per day, every day, for 6 months
- ✅ One real Reddit/Quora answer per week
- ✅ One brand mention earned per week (forum, podcast, guest post)
- ✅ Updating old content quarterly (we automate this with `content-refresh`)
- ✅ Publishing original data (e.g. "Top 10 most-searched dream symbols of 2026")
