// Shared Anthropic client — Claude Opus 4.6 with JSON-only output
// env: ANTHROPIC_API_KEY

const ANTHROPIC_URL = 'https://api.anthropic.com/v1/messages';

interface GenerateArgs {
  system: string;
  user: string;
  model?: string;
  maxTokens?: number;
  temperature?: number;
}

interface AnthropicMessage {
  role: 'user' | 'assistant';
  content: string | Array<{ type: string; text?: string }>;
}

export async function claudeJSON<T = unknown>(args: GenerateArgs): Promise<T> {
  const key = Deno.env.get('ANTHROPIC_API_KEY');
  if (!key) throw new Error('ANTHROPIC_API_KEY required');

  const body = {
    model: args.model || 'claude-opus-4-6',
    max_tokens: args.maxTokens || 4096,
    temperature: args.temperature ?? 0.6,
    system: args.system + '\n\nCRITICAL: Respond with a single valid JSON object. No prose before or after. No markdown fences.',
    messages: [{ role: 'user', content: args.user }] as AnthropicMessage[],
  };

  const res = await fetch(ANTHROPIC_URL, {
    method: 'POST',
    headers: {
      'x-api-key': key,
      'anthropic-version': '2023-06-01',
      'content-type': 'application/json',
    },
    body: JSON.stringify(body),
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`Anthropic ${res.status}: ${text}`);
  }

  const data = await res.json();
  const content = data.content?.[0]?.text ?? '';
  return parseJSON<T>(content);
}

function parseJSON<T>(text: string): T {
  // strip any accidental fences / whitespace
  let s = text.trim();
  if (s.startsWith('```')) {
    s = s.replace(/^```(?:json)?\s*/i, '').replace(/```\s*$/, '');
  }
  // first { ... last }
  const first = s.indexOf('{');
  const last = s.lastIndexOf('}');
  if (first !== -1 && last !== -1) s = s.slice(first, last + 1);
  try {
    return JSON.parse(s) as T;
  } catch (e) {
    throw new Error(`Claude JSON parse fail: ${(e as Error).message}\nraw: ${text.slice(0, 500)}`);
  }
}

export function slugify(input: string, lang: string): string {
  // Latin-compatible slug for all langs. TR special chars → ascii.
  const map: Record<string, string> = {
    ç: 'c', ğ: 'g', ı: 'i', ö: 'o', ş: 's', ü: 'u',
    Ç: 'c', Ğ: 'g', İ: 'i', Ö: 'o', Ş: 's', Ü: 'u',
    á: 'a', é: 'e', í: 'i', ó: 'o', ú: 'u', ñ: 'n',
    ä: 'a', ë: 'e', ï: 'i', ö2: 'o', ü2: 'u',
  };
  let s = input.toLowerCase();
  for (const [k, v] of Object.entries(map)) s = s.replaceAll(k, v);
  s = s.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
  s = s.replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
  // lang prefix for ruya cluster TR
  return s || `post-${Date.now()}`;
}
