# Wikidata Submission — Astrobobo

**Why this matters:** Wikidata is the canonical entity database used by ChatGPT, Perplexity, Google Knowledge Graph, Bing, and most LLMs as a ground-truth identity source. Having a Wikidata QID is the **strongest single signal** that "Astrobobo" is a real entity worth citing.

**Time required:** 20 minutes
**Cost:** $0
**Risk:** entry can be deleted if it's clearly self-promotional. Write neutrally.

---

## Step 1 — Verify Notability

Wikidata is more permissive than Wikipedia about notability, but the entry needs at least:
- ✓ A working website (we have astrobobo.com)
- ✓ Public content (137+ articles)
- ✓ Multi-language presence
- ⚠ At least 1-2 external mentions (forum, blog, social) — get these BEFORE submitting

**If you have zero external mentions yet:** wait 30 days, post on 2-3 astrology forums with brand links, then submit.

---

## Step 2 — Create a Wikidata Account

1. Go to https://www.wikidata.org
2. Click "Create account" (top right)
3. Use a real name or your handle (not "Astrobobo" — that's a conflict-of-interest signal)
4. Confirm email
5. **Make 5-10 small edits to existing entries first** (e.g. add a missing translation to a zodiac sign entry). This builds trust before you create a new entity. New accounts that immediately create entries are flagged.

---

## Step 3 — Submit the Entity

1. Go to https://www.wikidata.org/wiki/Special:NewItem
2. Fill in:

### Label (English)
```
Astrobobo
```

### Description (English)
```
multilingual web platform for astrology and dream interpretation
```

### Aliases (English)
```
astrobobo.com
```

### Repeat for other languages

| Lang | Label | Description |
|---|---|---|
| tr | Astrobobo | astroloji ve rüya tabiri için çok dilli web platformu |
| es | Astrobobo | plataforma web multilingüe de astrología e interpretación de sueños |
| de | Astrobobo | mehrsprachige Webplattform für Astrologie und Traumdeutung |
| fr | Astrobobo | plateforme web multilingue d'astrologie et d'interprétation des rêves |
| it | Astrobobo | piattaforma web multilingue di astrologia e interpretazione dei sogni |

---

## Step 4 — Add Statements (Properties)

After creating the item, add these statements one by one. Each "P" code is a Wikidata property.

### Required
| Property | Value | Source |
|---|---|---|
| **P31** (instance of) | Q35127 (website) | — |
| **P31** (instance of) | Q5891907 (online platform) | — |
| **P856** (official website) | https://astrobobo.com | — |
| **P407** (language of work) | Turkish, English, Spanish, German, French, Italian, Portuguese, Russian, Arabic | — |
| **P101** (field of work) | Q67098675 (astrology), Q170869 (dream interpretation) | — |

### Optional but high-impact
| Property | Value |
|---|---|
| **P571** (inception) | 2024 |
| **P127** (owned by) | Umut Null *(or your legal entity if any)* |
| **P17** (country) | Q43 (Turkey) |
| **P859** (sponsor) | — *(skip)* |
| **P2002** (Twitter username) | astrobobo |
| **P2003** (Instagram username) | astrobobo |
| **P3185** (TikTok username) | astrobobo |
| **P2013** (Facebook ID) | astrobobo |
| **P2397** (YouTube channel ID) | UC... *(after creating channel)* |

---

## Step 5 — Add a Reference

Every statement should have at least one reference, otherwise the entry will be flagged. The easiest:

1. Open one of your strongest articles (e.g. https://astrobobo.com/r/en/ruyada-yilan)
2. On a Wikidata statement, click "add reference"
3. Property: **P854** (reference URL) → paste the article URL
4. Property: **P1476** (title) → paste the article title
5. Property: **P813** (retrieved) → today's date

---

## Step 6 — Save the QID

After submitting, you'll get a QID like `Q123456789`. Save it in two places:

### 1. `scripts/brand_config.json`
```json
{
  ...
  "identifier": {
    "wikidata": "Q123456789"
  },
  ...
}
```

### 2. Your About page schema
We'll update `generate_seo_pages.dart` to inject the Wikidata QID into the Organization schema as `identifier`:

```json
{
  "@type": "Organization",
  "@id": "https://astrobobo.com/#organization",
  "name": "Astrobobo",
  "identifier": {
    "@type": "PropertyValue",
    "propertyID": "Wikidata",
    "value": "Q123456789"
  },
  ...
}
```

---

## Step 7 — Wait + Monitor

- **Days 1-7:** entry will be visible at `https://www.wikidata.org/wiki/Q...`
- **Days 7-30:** Google Knowledge Graph picks it up (sometimes faster)
- **Days 30-90:** ChatGPT and Perplexity start treating Astrobobo as a known entity in their training/retrieval

**If your entry gets deleted** (rare but possible), the deletion log will give a reason. Most common reasons:
- "Not notable" → add 2-3 more external mentions, resubmit in 60 days
- "Self-promotional" → rewrite description to be neutral and factual
- "Conflict of interest" → use a different account, get a friend to verify the entry

---

## Optional: Wikipedia stub

Wikipedia is much harder than Wikidata. **Don't try unless you have:**
- 5+ independent press mentions
- 10K+ monthly visitors
- 3+ years of operation

Premature Wikipedia submissions get speedy-deleted and lock you out of future attempts. Wait until Year 2.
