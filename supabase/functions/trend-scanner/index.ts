// ═════════════════════════════════════════════════════════════════════════
// trend-scanner — refill keyword_queue
//
// Sources (Phase 1):
//   1. seeds/<lang>_seeds.json         (bundled via import, always on)
//   2. Google Trends daily (optional)  — if GOOGLE_TRENDS_ENABLED=true
//   3. GSC opportunity rows            — if GSC_SYNC_ENABLED=true
//      (post position 5-15, impressions>100, ctr<2%) → related queries
//
// POST body: { "langs": ["tr","en"], "limit": 200 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';
import trSeeds   from '../../seeds/tr_seeds.json'   with { type: 'json' };
import enSeeds   from '../../seeds/en_seeds.json'   with { type: 'json' };
import esSeeds   from '../../seeds/es_seeds.json'   with { type: 'json' };
import deSeeds   from '../../seeds/de_seeds.json'   with { type: 'json' };
import frSeeds   from '../../seeds/fr_seeds.json'   with { type: 'json' };
import itSeeds   from '../../seeds/it_seeds.json'   with { type: 'json' };
import ptbrSeeds from '../../seeds/pt-br_seeds.json' with { type: 'json' };

interface Seed {
  keyword: string;
  cluster: string;
  intent?: string;
  priority?: number;
}

const SEEDS: Record<string, Seed[]> = {
  tr: trSeeds as Seed[],
  en: enSeeds as Seed[],
  es: esSeeds as Seed[],
  de: deSeeds as Seed[],
  fr: frSeeds as Seed[],
  it: itSeeds as Seed[],
  'pt-br': ptbrSeeds as Seed[],
};

interface Body {
  langs?: string[];
  limit?: number;
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const langs = body.langs ?? ['tr', 'en'];
  const limit = body.limit ?? 200;
  const sb = admin();
  const started = Date.now();

  let total_inserted = 0;
  const per_lang: Record<string, number> = {};

  for (const lang of langs) {
    const seeds = SEEDS[lang];
    if (!seeds?.length) {
      per_lang[lang] = 0;
      continue;
    }

    // Insert seeds; unique(keyword,lang) → on_conflict ignore
    const rows = seeds.slice(0, limit).map((s) => ({
      keyword: s.keyword,
      lang,
      cluster: s.cluster,
      intent: s.intent ?? 'definition',
      priority: s.priority ?? 50,
      source: 'seed' as const,
    }));

    const { error, count } = await sb
      .from('keyword_queue')
      .upsert(rows, { onConflict: 'keyword,lang', ignoreDuplicates: true, count: 'exact' });

    if (error) {
      console.error('[trend-scanner] upsert fail', lang, error);
      per_lang[lang] = 0;
      continue;
    }

    per_lang[lang] = count ?? 0;
    total_inserted += count ?? 0;
  }

  // Optional: Google Trends daily trending (Phase 2) — stub
  if (Deno.env.get('GOOGLE_TRENDS_ENABLED') === 'true') {
    // TODO: fetch https://trends.google.com/trends/api/dailytrends?geo=TR
    // parse + filter by astro/dream keywords, insert with source='google_trends'
  }

  await sb.from('trend_scan').insert({
    lang: langs.join(','),
    source: 'seed',
    raw: per_lang,
    new_keywords: total_inserted,
    duration_ms: Date.now() - started,
  });

  return ok({ inserted: total_inserted, per_lang, duration_ms: Date.now() - started });
});
