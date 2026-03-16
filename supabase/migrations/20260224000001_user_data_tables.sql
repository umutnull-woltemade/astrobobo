-- ════════════════════════════════════════════════════════════════════════════
-- USER DATA TABLES - Supabase Full Data Sync
-- ════════════════════════════════════════════════════════════════════════════
-- All user data tables for offline-first sync: journal, dreams, mood,
-- notes, life events, cycle logs, profiles, and sync metadata.
-- ════════════════════════════════════════════════════════════════════════════

-- Auto-update trigger function (shared by all tables)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ═══════════════════════════════════════════════════════════════════════════
-- 1. USER PROFILES
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url TEXT,
  avatar_emoji TEXT,
  birth_date DATE,
  birth_time TEXT,
  birth_place TEXT,
  birth_latitude DOUBLE PRECISION,
  birth_longitude DOUBLE PRECISION,
  is_primary BOOLEAN DEFAULT false,
  relationship TEXT,
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own profiles" ON user_profiles
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_user_profiles_updated_at
  BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_user_profiles_user_id ON user_profiles(user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- 2. JOURNAL ENTRIES
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS journal_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  focus_area TEXT NOT NULL,
  overall_rating INTEGER NOT NULL CHECK (overall_rating BETWEEN 1 AND 5),
  sub_ratings JSONB DEFAULT '{}',
  note TEXT,
  image_path TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own journal entries" ON journal_entries
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_journal_entries_updated_at
  BEFORE UPDATE ON journal_entries
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_journal_entries_user_date ON journal_entries(user_id, date);

-- ═══════════════════════════════════════════════════════════════════════════
-- 3. DREAM ENTRIES
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS dream_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  dream_date DATE NOT NULL,
  recorded_at TIMESTAMPTZ DEFAULT now(),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  detected_symbols TEXT[] DEFAULT '{}',
  user_tags TEXT[] DEFAULT '{}',
  dominant_emotion TEXT,
  emotional_intensity INTEGER CHECK (emotional_intensity BETWEEN 1 AND 10),
  is_recurring BOOLEAN DEFAULT false,
  is_lucid BOOLEAN DEFAULT false,
  is_nightmare BOOLEAN DEFAULT false,
  moon_phase TEXT,
  interpretation JSONB,
  metadata JSONB,
  characters TEXT[] DEFAULT '{}',
  locations TEXT[] DEFAULT '{}',
  clarity INTEGER CHECK (clarity BETWEEN 1 AND 10),
  sleep_quality TEXT,
  dream_series_id TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE dream_entries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own dream entries" ON dream_entries
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_dream_entries_updated_at
  BEFORE UPDATE ON dream_entries
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_dream_entries_user_date ON dream_entries(user_id, dream_date);

-- ═══════════════════════════════════════════════════════════════════════════
-- 4. MOOD ENTRIES
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS mood_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  mood INTEGER NOT NULL CHECK (mood BETWEEN 1 AND 5),
  emoji TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false,
  UNIQUE(user_id, date)
);

ALTER TABLE mood_entries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own mood entries" ON mood_entries
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_mood_entries_updated_at
  BEFORE UPDATE ON mood_entries
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_mood_entries_user_date ON mood_entries(user_id, date);

-- ═══════════════════════════════════════════════════════════════════════════
-- 5. NOTES TO SELF
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS notes_to_self (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT NOT NULL DEFAULT '',
  is_pinned BOOLEAN DEFAULT false,
  tags TEXT[] DEFAULT '{}',
  linked_journal_entry_id UUID,
  mood_at_creation TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE notes_to_self ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own notes" ON notes_to_self
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_notes_to_self_updated_at
  BEFORE UPDATE ON notes_to_self
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_notes_to_self_user_id ON notes_to_self(user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- 6. NOTE REMINDERS
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS note_reminders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  note_id UUID NOT NULL REFERENCES notes_to_self(id) ON DELETE CASCADE,
  scheduled_at TIMESTAMPTZ NOT NULL,
  frequency TEXT NOT NULL DEFAULT 'once',
  is_active BOOLEAN DEFAULT true,
  custom_message TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE note_reminders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own reminders" ON note_reminders
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM notes_to_self
      WHERE notes_to_self.id = note_reminders.note_id
        AND notes_to_self.user_id = auth.uid()
    )
  );

CREATE TRIGGER update_note_reminders_updated_at
  BEFORE UPDATE ON note_reminders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_note_reminders_note_id ON note_reminders(note_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- 7. LIFE EVENTS
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS life_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  type TEXT NOT NULL,
  event_key TEXT,
  title TEXT NOT NULL,
  note TEXT,
  emotion_tags TEXT[] DEFAULT '{}',
  image_path TEXT,
  intensity INTEGER CHECK (intensity BETWEEN 1 AND 5),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE life_events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own life events" ON life_events
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_life_events_updated_at
  BEFORE UPDATE ON life_events
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_life_events_user_date ON life_events(user_id, date);

-- ═══════════════════════════════════════════════════════════════════════════
-- 8. CYCLE PERIOD LOGS
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS cycle_period_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  period_start_date DATE NOT NULL,
  period_end_date DATE,
  flow_intensity TEXT,
  symptoms TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE cycle_period_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own cycle logs" ON cycle_period_logs
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_cycle_period_logs_updated_at
  BEFORE UPDATE ON cycle_period_logs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_cycle_period_logs_user_date ON cycle_period_logs(user_id, period_start_date);

-- ═══════════════════════════════════════════════════════════════════════════
-- 9. SYNC METADATA
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS sync_metadata (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  last_full_sync TIMESTAMPTZ,
  last_incremental_sync TIMESTAMPTZ,
  schema_version INTEGER DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE sync_metadata ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own sync metadata" ON sync_metadata
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_sync_metadata_updated_at
  BEFORE UPDATE ON sync_metadata
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
