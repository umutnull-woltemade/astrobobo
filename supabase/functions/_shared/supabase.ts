// Shared Supabase admin client for edge functions
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.45.0';

export function admin() {
  const url = Deno.env.get('SUPABASE_URL')!;
  const key = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
  return createClient(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

export function json(body: unknown, init: ResponseInit = {}) {
  return new Response(JSON.stringify(body), {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...init.headers,
    },
  });
}

export function err(message: string, status = 500, extra: Record<string, unknown> = {}) {
  console.error('[edge-error]', message, extra);
  return json({ ok: false, error: message, ...extra }, { status });
}

export function ok(data: Record<string, unknown> = {}) {
  return json({ ok: true, ...data });
}

export async function readBody<T = Record<string, unknown>>(req: Request): Promise<T> {
  try {
    if (req.method === 'GET') return {} as T;
    const text = await req.text();
    if (!text) return {} as T;
    return JSON.parse(text) as T;
  } catch {
    return {} as T;
  }
}

export function now() {
  return new Date().toISOString();
}
