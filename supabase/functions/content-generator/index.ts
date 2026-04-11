// ═════════════════════════════════════════════════════════════════════════
// content-generator — claim N keywords from queue, generate posts (draft)
//
// Pipeline:
//   1. SELECT ... WHERE status='new' ORDER BY priority DESC LIMIT batch
//   2. UPDATE status='claimed' (optimistic lock via claimed_at)
//   3. For each: Claude Opus 4.6 → strict JSON → serialize → INSERT posts
//   4. UPDATE status='generated' on success, 'rejected' on fail
//
// POST body: { "batch": 10, "lang": "tr" | null, "cluster": "ruya" | null }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody, now } from '../_shared/supabase.ts';
import { claudeJSON, slugify } from '../_shared/claude.ts';

interface Body {
  batch?: number;
  lang?: string;
  cluster?: string;
}

interface GeneratedPost {
  slug: string;
  title: string;
  meta_desc: string;
  h1: string;
  intro: string;
  sections: Array<
    | { h2: string; body: string }
    | { h2: string; bullets: string[] }
    | { h2: string; faq: Array<{ q: string; a: string }> }
  >;
  summary: string;
  internal_links: string[];
  word_count: number;
}

const MODEL = 'claude-opus-4-6';

// ─── Prompts per language ────────────────────────────────────────────────
const SYSTEMS: Record<string, string> = {
  tr: `Sen Astrobobo için kıdemli SEO yazarsın. Tanım-öncelikli, AI-extraction-friendly,
kısa cümleli, spam ve clickbait'siz yazarsın. Her içerik definition-first format'ta olur.
Uydurmazsın: kesin tarih, istatistik veya olay verme. Disclaimer her zaman sonda.
Dil: profesyonel ama sıcak Türkçe.`,

  en: `You are a senior SEO writer for Astrobobo. You write definition-first,
AI-extraction-friendly content with short sentences, no spam, no clickbait.
You never fabricate: no hard dates, statistics or events. Disclaimer always at the end.
Tone: professional yet warm English.`,

  es: `Eres un redactor SEO senior para Astrobobo. Escribes contenido definition-first,
amigable para extracción por IA, con frases cortas, sin spam ni clickbait.
Nunca inventas: ni fechas exactas, ni estadísticas, ni eventos. Descargo de responsabilidad siempre al final.
Tono: español profesional pero cálido.`,

  de: `Du bist ein Senior-SEO-Texter für Astrobobo. Du schreibst definition-first,
KI-extraktionsfreundlich, mit kurzen Sätzen, ohne Spam und ohne Clickbait.
Du erfindest nichts: keine exakten Daten, Statistiken oder Ereignisse. Disclaimer immer am Ende.
Ton: professionelles, aber warmes Deutsch.`,

  fr: `Tu es un rédacteur SEO senior pour Astrobobo. Tu écris en mode definition-first,
adapté à l'extraction par IA, avec des phrases courtes, sans spam ni clickbait.
Tu n'inventes jamais: ni dates précises, ni statistiques, ni événements. Disclaimer toujours à la fin.
Ton: français professionnel mais chaleureux.`,

  it: `Sei un redattore SEO senior per Astrobobo. Scrivi contenuti definition-first,
ottimizzati per l'estrazione da parte dell'IA, con frasi brevi, senza spam o clickbait.
Non inventi mai: né date precise, né statistiche, né eventi. Disclaimer sempre alla fine.
Tono: italiano professionale ma caloroso.`,

  'pt-br': `Você é um redator SEO sênior para Astrobobo. Escreve conteúdo definition-first,
amigável para extração por IA, com frases curtas, sem spam nem clickbait.
Nunca inventa: nem datas exatas, nem estatísticas, nem eventos. Disclaimer sempre ao final.
Tom: português brasileiro profissional mas caloroso.`,
};

const DISCLAIMERS: Record<string, string> = {
  tr: 'Bu içerik eğlence ve kişisel keşif amaçlıdır; profesyonel psikolojik, tıbbi veya dini danışmanlık yerine geçmez.',
  en: 'This content is for entertainment and personal exploration; it is not a substitute for professional psychological, medical, or religious advice.',
  es: 'Este contenido es para entretenimiento y exploración personal; no sustituye el asesoramiento psicológico, médico o religioso profesional.',
  de: 'Dieser Inhalt dient der Unterhaltung und persönlichen Erkundung; er ersetzt keine professionelle psychologische, medizinische oder religiöse Beratung.',
  fr: "Ce contenu est destiné au divertissement et à l'exploration personnelle ; il ne remplace pas un avis psychologique, médical ou religieux professionnel.",
  it: 'Questo contenuto è a scopo di intrattenimento ed esplorazione personale; non sostituisce un parere psicologico, medico o religioso professionale.',
  'pt-br': 'Este conteúdo é para entretenimento e exploração pessoal; não substitui aconselhamento psicológico, médico ou religioso profissional.',
};

const SUMMARY_LABELS: Record<string, string> = {
  tr: 'Özet', en: 'Summary', es: 'Resumen', de: 'Zusammenfassung',
  fr: 'Résumé', it: 'Riepilogo', 'pt-br': 'Resumo',
};

function buildUserPrompt(keyword: string, lang: string, cluster: string, intent: string, related: Array<{ slug: string; title: string }>) {
  const relatedList = related.map((r) => `- ${r.slug}: ${r.title}`).join('\n') || '(none yet)';
  return `TASK: Write a 1200-1800 word SEO article.

keyword: "${keyword}"
lang: ${lang}
cluster: ${cluster}
intent: ${intent}

RELATED POSTS (pick 3+ for internal_links, use slug only):
${relatedList}

OUTPUT — strict JSON, no prose, no fences:
{
  "slug": "kebab-case-slug-of-keyword",
  "title": "max 60 chars, includes keyword",
  "meta_desc": "max 155 chars, includes keyword",
  "h1": "compelling H1 with keyword",
  "intro": "2-3 sentence definition-first opening",
  "sections": [
    {"h2": "...", "body": "2-4 paragraphs"},
    {"h2": "...", "bullets": ["...", "...", "...", "...", "..."]},
    {"h2": "...", "body": "2-3 paragraphs"},
    {"h2": "Sık Sorulan Sorular | FAQ", "faq": [{"q":"...","a":"..."},{"q":"...","a":"..."},{"q":"...","a":"..."},{"q":"...","a":"..."}]}
  ],
  "summary": "1 paragraph summary",
  "internal_links": ["slug1","slug2","slug3"],
  "word_count": 1500
}

RULES:
- Short sentences. Clear definitions. No hype.
- Disclaimer: "${DISCLAIMERS[lang] || DISCLAIMERS.en}"
- Minimum 3 internal_links from the RELATED POSTS list above.
- No fabricated dates, no specific statistics.
- H1 must contain the keyword.
- Last FAQ section H2 in the same language as the article.`;
}

// ─── Markdown serialization to match existing frontmatter format ─────────
function serialize(post: GeneratedPost, lang: string): string {
  const date = new Date().toISOString().slice(0, 10);
  const fm = `---
lang: ${lang}
route: "${post.slug}"
title: "${post.title.replace(/"/g, '\\"')}"
updated_at: "${date}"
---

`;
  let body = `# ${post.h1}\n\n${post.intro}\n\n`;

  for (const s of post.sections) {
    if ('body' in s) {
      body += `## ${s.h2}\n\n${s.body}\n\n`;
    } else if ('bullets' in s) {
      body += `## ${s.h2}\n\n${s.bullets.map((b) => `- ${b}`).join('\n')}\n\n`;
    } else if ('faq' in s) {
      body += `## ${s.h2}\n\n`;
      for (const q of s.faq) {
        body += `**${q.q}**\n\n${q.a}\n\n`;
      }
    }
  }

  body += `## ${SUMMARY_LABELS[lang] || 'Summary'}\n\n${post.summary}\n\n`;
  body += `*${DISCLAIMERS[lang] || DISCLAIMERS.en}*\n`;

  return fm + body;
}

function schemaJson(post: GeneratedPost, lang: string): Record<string, unknown> {
  const now = new Date().toISOString();
  return {
    '@context': 'https://schema.org',
    '@type': 'Article',
    headline: post.title,
    description: post.meta_desc,
    datePublished: now,
    dateModified: now,
    inLanguage: lang,
    author: { '@type': 'Organization', name: 'Astrobobo', url: 'https://astrobobo.com' },
    publisher: {
      '@type': 'Organization',
      name: 'Astrobobo',
      logo: { '@type': 'ImageObject', url: 'https://astrobobo.com/icons/Icon-512.png' },
    },
    mainEntityOfPage: `https://astrobobo.com/r/${lang}/${post.slug}`,
  };
}

// ─── Handler ─────────────────────────────────────────────────────────────
Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  const body = await readBody<Body>(req);
  const batch = Math.min(body.batch ?? 10, 30);
  const sb = admin();

  // 1. claim batch (atomic via RPC would be cleaner; for Phase 1: select then update)
  let q = sb
    .from('keyword_queue')
    .select('id, keyword, lang, cluster, intent')
    .eq('status', 'new')
    .order('priority', { ascending: false })
    .limit(batch);

  if (body.lang) q = q.eq('lang', body.lang);
  if (body.cluster) q = q.eq('cluster', body.cluster);

  const { data: claims, error: claimErr } = await q;
  if (claimErr) return err('claim select failed', 500, { detail: claimErr });
  if (!claims?.length) return ok({ generated: 0, reason: 'queue empty' });

  const ids = claims.map((c) => c.id);
  await sb.from('keyword_queue').update({ status: 'claimed', claimed_at: now() }).in('id', ids);

  let generated = 0;
  let failed = 0;
  const errors: Array<{ id: number; error: string }> = [];

  for (const kw of claims) {
    try {
      // Fetch related posts for internal linking
      const { data: related } = await sb
        .from('posts')
        .select('slug, title')
        .eq('lang', kw.lang)
        .eq('cluster', kw.cluster)
        .eq('status', 'published')
        .limit(8);

      const post = await claudeJSON<GeneratedPost>({
        system: SYSTEMS[kw.lang] || SYSTEMS.en,
        user: buildUserPrompt(kw.keyword, kw.lang, kw.cluster, kw.intent || 'definition', related || []),
        model: MODEL,
        maxTokens: 6000,
      });

      // Sanity
      if (!post.slug || !post.title || !post.sections?.length) {
        throw new Error('missing required fields');
      }

      const slug = slugify(post.slug, kw.lang);
      const body_md = serialize(post, kw.lang);
      const schema = schemaJson(post, kw.lang);

      // FAQ extraction for dedicated column
      const faqSection = post.sections.find((s) => 'faq' in s) as { faq: Array<{ q: string; a: string }> } | undefined;

      const { error: insErr } = await sb.from('posts').upsert(
        {
          slug,
          lang: kw.lang,
          cluster: kw.cluster,
          keyword_id: kw.id,
          title: post.title,
          meta_desc: post.meta_desc,
          h1: post.h1,
          body_md,
          faq: faqSection?.faq || [],
          schema_json: schema,
          internal_links: post.internal_links || [],
          word_count: post.word_count || body_md.split(/\s+/).length,
          status: 'draft',
          model_used: MODEL,
          generated_at: now(),
        },
        { onConflict: 'slug,lang' },
      );

      if (insErr) throw new Error(`insert: ${insErr.message}`);

      await sb.from('keyword_queue').update({ status: 'generated' }).eq('id', kw.id);
      generated++;
    } catch (e) {
      failed++;
      const msg = (e as Error).message;
      errors.push({ id: kw.id, error: msg });
      await sb
        .from('keyword_queue')
        .update({ status: 'new', claimed_at: null, rejected_reason: msg })
        .eq('id', kw.id);
    }
  }

  return ok({ generated, failed, errors: errors.slice(0, 5) });
});
