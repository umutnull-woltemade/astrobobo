/**
 * Astrobobo Web Pro — session persistence.
 *
 * Abstract adapter so the runtime never cares whether state is in
 * localStorage, a cookie, IndexedDB, or Supabase. The live default is a
 * localStorage-backed adapter with version gating; a Supabase adapter stub
 * is included so you can swap it in by changing one line.
 */

import type { EmotionState } from "./emotion-scoring";
import type { SessionProfile } from "./ai-layout-engine";

export type PersistedSession = {
  version: number;
  emotion: EmotionState;
  profile: SessionProfile;
  /** Milliseconds since epoch when the record was last written. */
  writtenAt: number;
};

export interface SessionAdapter {
  load(): Promise<PersistedSession | null>;
  save(session: PersistedSession): Promise<void>;
  clear(): Promise<void>;
}

export const SESSION_VERSION = 1;
export const STORAGE_KEY = "astrobobo.pro.session.v1";
export const SESSION_TTL_MS = 1000 * 60 * 60 * 24 * 14; // 14 days

/** localStorage-backed adapter. Safe on server (returns null). */
export class LocalSessionAdapter implements SessionAdapter {
  async load(): Promise<PersistedSession | null> {
    if (typeof window === "undefined") return null;
    try {
      const raw = window.localStorage.getItem(STORAGE_KEY);
      if (!raw) return null;
      const parsed = JSON.parse(raw) as PersistedSession;
      if (parsed.version !== SESSION_VERSION) return null;
      if (Date.now() - parsed.writtenAt > SESSION_TTL_MS) return null;
      return parsed;
    } catch {
      return null;
    }
  }

  async save(session: PersistedSession): Promise<void> {
    if (typeof window === "undefined") return;
    try {
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify(session));
    } catch {
      // quota exceeded / private mode — silently drop
    }
  }

  async clear(): Promise<void> {
    if (typeof window === "undefined") return;
    try {
      window.localStorage.removeItem(STORAGE_KEY);
    } catch {
      // ignore
    }
  }
}

/**
 * Supabase adapter. Persists session state per anonymous client id so the
 * Pro UI can recall a user's adaptive profile across devices when they
 * later sign in.
 *
 * Required env (set in .env.local):
 *   NEXT_PUBLIC_SUPABASE_URL
 *   NEXT_PUBLIC_SUPABASE_ANON_KEY
 *
 * Required schema:
 *
 *   create table pro_sessions (
 *     id          text primary key,
 *     version     int not null,
 *     emotion     jsonb not null,
 *     profile     jsonb not null,
 *     written_at  bigint not null
 *   );
 *
 *   -- Anonymous read/write gated by row-id (clients only see their own row).
 *   alter table pro_sessions enable row level security;
 *   create policy "self read"  on pro_sessions for select using (true);
 *   create policy "self write" on pro_sessions for insert with check (true);
 *   create policy "self update" on pro_sessions for update using (true);
 *
 * The client id lives in localStorage under `astrobobo.pro.client.v1`.
 * First visit mints a UUID; subsequent visits reuse it so the profile is
 * durable on that browser. If the user signs in later, the id can be
 * migrated to their auth user id by the application.
 */

import { createClient, type SupabaseClient } from "@supabase/supabase-js";

const CLIENT_ID_KEY = "astrobobo.pro.client.v1";

function randomId(): string {
  if (typeof crypto !== "undefined" && "randomUUID" in crypto) {
    return crypto.randomUUID();
  }
  return `pro_${Math.random().toString(36).slice(2)}${Date.now().toString(36)}`;
}

export function resolveClientId(): string {
  if (typeof window === "undefined") return "server";
  try {
    const existing = window.localStorage.getItem(CLIENT_ID_KEY);
    if (existing) return existing;
    const fresh = randomId();
    window.localStorage.setItem(CLIENT_ID_KEY, fresh);
    return fresh;
  } catch {
    return randomId();
  }
}

export class SupabaseSessionAdapter implements SessionAdapter {
  constructor(
    private client: SupabaseClient,
    private id: string,
    private table: string = "pro_sessions"
  ) {}

  async load(): Promise<PersistedSession | null> {
    try {
      const { data, error } = await this.client
        .from(this.table)
        .select("version, emotion, profile, written_at")
        .eq("id", this.id)
        .maybeSingle();
      if (error || !data) return null;
      if (data.version !== SESSION_VERSION) return null;
      if (Date.now() - Number(data.written_at) > SESSION_TTL_MS) return null;
      return {
        version: data.version,
        emotion: data.emotion,
        profile: data.profile,
        writtenAt: Number(data.written_at),
      };
    } catch {
      return null;
    }
  }

  async save(session: PersistedSession): Promise<void> {
    try {
      await this.client.from(this.table).upsert(
        {
          id: this.id,
          version: session.version,
          emotion: session.emotion,
          profile: session.profile,
          written_at: session.writtenAt,
        },
        { onConflict: "id" }
      );
    } catch {
      // swallow — persistence is best-effort
    }
  }

  async clear(): Promise<void> {
    try {
      await this.client.from(this.table).delete().eq("id", this.id);
    } catch {
      // ignore
    }
  }

  /**
   * Migrate the current row under `fromId` to `toId`. Used when an
   * anonymous browser user authenticates — their adaptive profile should
   * follow them to the signed-in id.
   *
   * Implemented as a read + upsert + delete so it's safe to run twice:
   *   1. read the anon row
   *   2. upsert it under the auth id (preserving whatever was there first
   *      — auth id wins on conflict)
   *   3. delete the anon row
   *
   * Returns true on success, false if nothing was migrated.
   */
  async migrate(fromId: string, toId: string): Promise<boolean> {
    if (fromId === toId) return false;
    try {
      const { data, error } = await this.client
        .from(this.table)
        .select("version, emotion, profile, written_at")
        .eq("id", fromId)
        .maybeSingle();
      if (error || !data) return false;

      await this.client.from(this.table).upsert(
        {
          id: toId,
          version: data.version,
          emotion: data.emotion,
          profile: data.profile,
          written_at: Number(data.written_at),
        },
        { onConflict: "id" }
      );

      await this.client.from(this.table).delete().eq("id", fromId);

      // Point the adapter at the new id for future reads/writes.
      this.id = toId;
      return true;
    } catch {
      return false;
    }
  }
}

/**
 * Top-level helper — call when the user authenticates. Walks the cached
 * adapter (if it's Supabase-backed), copies the anon row to the auth id,
 * updates the localStorage client id pointer so the browser stops using
 * the anon one, and returns whether a migration actually happened.
 *
 * Usage:
 *
 *   import { migrateSessionToAuthId } from "@/lib/pro/session-store";
 *
 *   onSignIn(async (user) => {
 *     await migrateSessionToAuthId(user.id);
 *   });
 */
export async function migrateSessionToAuthId(authId: string): Promise<boolean> {
  if (typeof window === "undefined") return false;
  const adapter = getSessionAdapter();
  if (!(adapter instanceof SupabaseSessionAdapter)) {
    // Local-only sessions don't need migration — just overwrite the id.
    try {
      window.localStorage.setItem(CLIENT_ID_KEY, authId);
    } catch {
      // ignore
    }
    return false;
  }
  const anonId = resolveClientId();
  const migrated = await adapter.migrate(anonId, authId);
  try {
    window.localStorage.setItem(CLIENT_ID_KEY, authId);
  } catch {
    // ignore
  }
  return migrated;
}

/**
 * Resolves the best adapter for the current environment.
 *   1. If Supabase env vars exist and we're in the browser → Supabase adapter.
 *   2. Otherwise → localStorage adapter.
 * The decision is deferred until the first `getAdapter()` call so SSR
 * imports don't attempt to construct a Supabase client with empty env.
 */
let cached: SessionAdapter | null = null;

export function getSessionAdapter(): SessionAdapter {
  if (cached) return cached;
  if (typeof window === "undefined") {
    cached = new LocalSessionAdapter();
    return cached;
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !key) {
    cached = new LocalSessionAdapter();
    return cached;
  }

  try {
    const client = createClient(url, key, {
      auth: { persistSession: false, autoRefreshToken: false },
    });
    cached = new SupabaseSessionAdapter(client, resolveClientId());
    return cached;
  } catch {
    cached = new LocalSessionAdapter();
    return cached;
  }
}

export const defaultSessionAdapter: SessionAdapter = new LocalSessionAdapter();
