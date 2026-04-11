// ═════════════════════════════════════════════════════════════════════════
// topic-cluster-builder — generate / refresh pillar pages per cluster+lang
//
// Pillar = a single hub page that:
//   - Defines the cluster topic broadly
//   - Links to every published child post in that cluster
//   - Updates whenever child count changes by 5+
//
// Output slug pattern: cluster-{cluster}  (e.g. cluster-ruya, cluster-burclar)
// Output path: content/{lang}/cluster-{cluster}.md
// URL:         /r/{lang}/cluster-{cluster}
//
// POST body: { "lang": "tr"|null, "cluster": "ruya"|null, "force": false }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody, now } from '../_shared/supabase.ts';
import { claudeJSON } from '../_shared/claude.ts';
import { commitFile } from '../_shared/github.ts';

interface Body {
  lang?: string;
  cluster?: string;
  force?: boolean;
}

interface ChildPost {
  slug: string;
  title: string;
  meta_desc: string;
}

interface PillarOutput {
  title: string;
  meta_desc: string;
  h1: string;
  intro: string;
  sections: Array<{ h2: string; body: string }>;
  conclusion: string;
}

const CLUSTER_LABELS: Record<string, Record<string, string>> = {
  tr: {
    ruya: 'Rüya Tabirleri Rehberi',
    burclar: 'Burçlar ve Astroloji',
    askUyumu: 'Aşk Uyumu Rehberi',
    dogumHaritasi: 'Doğum Haritası Rehberi',
    gunlukYorum: 'Günlük Yorumlar',
    tarot: 'Tarot Rehberi',
    numeroloji: 'Numeroloji',
  },
  en: {
    ruya: 'Dream Interpretation Guide',
    burclar: 'Zodiac Signs & Astrology',
    askUyumu: 'Love Compatibility Guide',
    dogumHaritasi: 'Birth Chart Guide',
    gunlukYorum: 'Daily Horoscopes',
    tarot: 'Tarot Guide',
    numeroloji: 'Numerology',
  },
};

const FUNCTIONS_URL = Deno.env.get('SUPABASE_URL')?.replace('.supabase.co', '.functions.supabase.co') ?? '';
const SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

function serializePillar(pillar: PillarOutput, children: ChildPost[], lang: string, cluster: string): string {
  const today = new Date().toISOString().slice(0, 10);
  const slug = `cluster-${cluster}`;

  let body = `---
lang: ${lang}
route: "${slug}"
title: "${pillar.title.replace(/"/g, '\\"')}"
updated_at: "${today}"
---

# ${pillar.h1}

${pillar.intro}

`;

  for (const s of pillar.sections) {
    body += `## ${s.h2}\n\n${s.body}\n\n`;
  }

  body += `## ${lang === 'tr' ? 'Tüm Yazılar' : 'All Articles'}\n\n`;
  for (const c of children) {
    body += `- [${c.title}](/r/${lang}/${c.slug}) — ${c.meta_desc}\n`;
  }
  body += '\n';

  body += `## ${lang === 'tr' ? 'Sonuç' : 'Conclusion'}\n\n${pillar.conclusion}\n\n`;

  body += lang === 'tr'
    ? `*Bu içerik eğlence ve kişisel keşif amaçlıdır; profesyonel psikolojik, tıbbi veya dini danışmanlık yerine geçmez.*\n`
    : `*This content is for entertainment and personal exploration; it is not a substitute for professional psychological, medical, or religious advice.*\n`;

  return body;
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const sb = admin();

  // Determine target (cluster, lang) pairs
  const langs = body.lang ? [body.lang] : ['tr', 'en'];
  const clusters = body.cluster ? [body.cluster] : Object.keys(CLUSTER_LABELS.tr);

  let built = 0;
  const errors: Array<{ key: string; error: string }> = [];
  const updated_slugs: string[] = [];

  for (const lang of langs) {
    for (const cluster of clusters) {
      try {
        const slug = `cluster-${cluster}`;

        // children = all published posts in this cluster+lang
        const { data: children } = await sb
          .from('posts')
          .select('slug, title, meta_desc')
          .eq('status', 'published')
          .eq('lang', lang)
          .eq('cluster', cluster)
          .neq('slug', slug)
          .order('published_at', { ascending: false });

        if (!children?.length) continue;

        // Skip if pillar exists and child count hasn't changed by 5+
        const { data: existing } = await sb
          .from('posts')
          .select('id, internal_links, updated_at')
          .eq('slug', slug)
          .eq('lang', lang)
          .maybeSingle();

        if (existing && !body.force) {
          const prev = existing.internal_links?.length || 0;
          const diff = Math.abs((children.length) - prev);
          if (diff < 5) continue;
        }

        const label = CLUSTER_LABELS[lang]?.[cluster] || cluster;
        const childTitles = children.slice(0, 30).map((c) => `- ${c.title}`).join('\n');

        const pillar = await claudeJSON<PillarOutput>({
          system: lang === 'tr'
            ? 'Sen Astrobobo için pillar/rehber içerik yazarsın. Geniş kapsamlı, AI-friendly, definition-first.'
            : 'You write pillar/hub guides for Astrobobo. Broad, AI-friendly, definition-first.',
          user: `Create a pillar guide for cluster "${label}" in ${lang}.

CHILD POSTS (${children.length} total, sample):
${childTitles}

OUTPUT strict JSON:
{
  "title": "max 60 char SEO title for the pillar",
  "meta_desc": "max 155 char meta",
  "h1": "compelling H1",
  "intro": "2-3 sentence definition of this topic area",
  "sections": [
    {"h2":"...","body":"2-3 paragraphs"},
    {"h2":"...","body":"2-3 paragraphs"},
    {"h2":"...","body":"2-3 paragraphs"}
  ],
  "conclusion": "1 paragraph that ties everything together"
}`,
          maxTokens: 4500,
        });

        const content = serializePillar(pillar, children as ChildPost[], lang, cluster);

        const path = `content/${lang}/${slug}.md`;
        const commit = await commitFile({
          path,
          content,
          message: existing ? `content: refresh pillar ${slug} [${lang}]` : `content: create pillar ${slug} [${lang}]`,
        });

        // upsert into posts
        await sb.from('posts').upsert(
          {
            slug,
            lang,
            cluster,
            title: pillar.title,
            meta_desc: pillar.meta_desc,
            h1: pillar.h1,
            body_md: content,
            internal_links: children.map((c) => c.slug),
            word_count: content.split(/\s+/).length,
            status: 'published',
            published_at: existing?.updated_at || now(),
            git_sha: commit.sha,
            commit_url: commit.html_url,
            model_used: 'claude-opus-4-6',
            last_refreshed_at: now(),
          },
          { onConflict: 'slug,lang' },
        );

        updated_slugs.push(`${lang}/${slug}`);
        built++;
      } catch (e) {
        errors.push({ key: `${lang}/${cluster}`, error: (e as Error).message });
      }
    }
  }

  if (built > 0 && FUNCTIONS_URL && SERVICE_KEY) {
    try {
      await fetch(`${FUNCTIONS_URL}/indexer`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${SERVICE_KEY}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ slugs: updated_slugs }),
      });
    } catch (_) { /* non-fatal */ }
  }

  return ok({ built, errors: errors.slice(0, 5) });
});
