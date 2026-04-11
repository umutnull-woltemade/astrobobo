// ═════════════════════════════════════════════════════════════════════════
// og-image-gen — generate OG cover images via Replicate (cheap + fast)
//
// Default model: black-forest-labs/flux-schnell  (~$0.003/image, 4 sec)
// Override via env: REPLICATE_MODEL
//
// Stores result in og_images table + updates posts.og_image_url + schema_json
//
// POST body: { "max": 10 }
// ═════════════════════════════════════════════════════════════════════════

import { admin, ok, err, readBody } from '../_shared/supabase.ts';

interface Body {
  max?: number;
}

interface Post {
  id: number;
  slug: string;
  lang: string;
  cluster: string;
  title: string;
  h1: string;
  meta_desc: string;
  schema_json: Record<string, unknown> | null;
}

const REPLICATE_TOKEN = Deno.env.get('REPLICATE_API_TOKEN') || '';
const MODEL_VERSION   = Deno.env.get('REPLICATE_MODEL_VERSION') || 'black-forest-labs/flux-schnell';
const SITE_ORIGIN     = Deno.env.get('SITE_ORIGIN') || 'https://astrobobo.com';

const CLUSTER_STYLES: Record<string, string> = {
  ruya: 'mystical dreamlike scene, deep blues and purples, soft glow, surreal symbolism, painterly',
  burclar: 'cosmic zodiac symbols, stars, deep navy with gold constellations, ethereal',
  askUyumu: 'two intertwined cosmic flames, warm gold and rose, soft gradient, romantic atmosphere',
  dogumHaritasi: 'astrological wheel, planets, golden geometric lines, dark purple background',
  gunlukYorum: 'sunrise over horizon, soft pastels, hopeful, calm sky, minimal',
  tarot: 'tarot card aesthetic, gold leaf, deep burgundy, ornate borders, mystical',
  numeroloji: 'sacred geometry, glowing numbers, deep cosmic background, golden ratio',
};

Deno.serve(async (req) => {
  if (req.method !== 'POST') return err('POST only', 405);
  if (!REPLICATE_TOKEN) return err('REPLICATE_API_TOKEN missing', 500);

  const body = await readBody<Body>(req);
  const max = Math.min(body.max ?? 10, 30);
  const sb = admin();

  // Posts that have no OG image yet
  const { data: posts, error } = await sb
    .from('posts')
    .select('id, slug, lang, cluster, title, h1, meta_desc, schema_json')
    .eq('status', 'published')
    .is('og_image_url', null)
    .order('published_at', { ascending: false })
    .limit(max);

  if (error) return err('select failed', 500, { detail: error });
  if (!posts?.length) return ok({ generated: 0, reason: 'no posts without OG image' });

  let generated = 0;
  let totalCost = 0;
  const errors: Array<{ post_id: number; error: string }> = [];

  for (const post of posts as Post[]) {
    try {
      const style = CLUSTER_STYLES[post.cluster] || 'mystical cosmic illustration, deep purple, gold accents';
      const prompt = `${post.h1}. ${style}. No text, no words, no letters. 1200x630 horizontal banner. High detail, professional editorial illustration.`;

      // 1. create prediction
      const create = await fetch('https://api.replicate.com/v1/predictions', {
        method: 'POST',
        headers: {
          Authorization: `Token ${REPLICATE_TOKEN}`,
          'Content-Type': 'application/json',
          Prefer: 'wait',
        },
        body: JSON.stringify({
          version: MODEL_VERSION,
          input: {
            prompt,
            aspect_ratio: '16:9',
            output_format: 'webp',
            output_quality: 85,
            num_inference_steps: 4,
          },
        }),
      });

      if (!create.ok) {
        throw new Error(`replicate ${create.status}: ${await create.text()}`);
      }

      const data = await create.json();
      let imgUrl: string | null = null;

      // Replicate returns { output: [url] } or { output: url } depending on model
      if (Array.isArray(data.output) && data.output[0]) imgUrl = data.output[0];
      else if (typeof data.output === 'string') imgUrl = data.output;
      else if (data.status === 'starting' || data.status === 'processing') {
        // Poll
        const id = data.id;
        for (let i = 0; i < 30; i++) {
          await new Promise((r) => setTimeout(r, 1000));
          const poll = await fetch(`https://api.replicate.com/v1/predictions/${id}`, {
            headers: { Authorization: `Token ${REPLICATE_TOKEN}` },
          });
          const pollData = await poll.json();
          if (pollData.status === 'succeeded') {
            imgUrl = Array.isArray(pollData.output) ? pollData.output[0] : pollData.output;
            break;
          }
          if (pollData.status === 'failed' || pollData.status === 'canceled') {
            throw new Error(`prediction ${pollData.status}: ${pollData.error}`);
          }
        }
      }

      if (!imgUrl) throw new Error('no output url');

      // Insert og_images row
      await sb.from('og_images').upsert(
        {
          post_id: post.id,
          prompt,
          provider: 'replicate',
          model: MODEL_VERSION,
          url: imgUrl,
          width: 1200,
          height: 630,
          cost_usd: 0.003,
        },
        { onConflict: 'post_id,provider' },
      );

      // Update post with og_image_url + schema
      const newSchema = { ...(post.schema_json || {}), image: imgUrl };
      await sb
        .from('posts')
        .update({ og_image_url: imgUrl, schema_json: newSchema })
        .eq('id', post.id);

      generated++;
      totalCost += 0.003;
    } catch (e) {
      errors.push({ post_id: post.id, error: (e as Error).message });
    }
  }

  return ok({
    generated,
    total_cost_usd: totalCost.toFixed(4),
    errors: errors.slice(0, 5),
  });
});
