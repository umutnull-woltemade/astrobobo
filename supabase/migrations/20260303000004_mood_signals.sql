-- ═══════════════════════════════════════════════════════════════════════════
-- MOOD SIGNALS — Circumplex model extension for mood_entries
-- ═══════════════════════════════════════════════════════════════════════════
-- Adds quadrant (fire/water/storm/shadow), signal_id, energy (1-10),
-- and pleasantness (1-10) to existing mood_entries table.
-- All columns nullable for backward compatibility with legacy 5-emoji entries.
-- ═══════════════════════════════════════════════════════════════════════════

-- Add signal columns
ALTER TABLE mood_entries ADD COLUMN IF NOT EXISTS quadrant TEXT;
ALTER TABLE mood_entries ADD COLUMN IF NOT EXISTS signal_id TEXT;
ALTER TABLE mood_entries ADD COLUMN IF NOT EXISTS energy INTEGER;
ALTER TABLE mood_entries ADD COLUMN IF NOT EXISTS pleasantness INTEGER;
ALTER TABLE mood_entries ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ;

-- Constraints (only validate when values present)
ALTER TABLE mood_entries ADD CONSTRAINT mood_entries_energy_range
  CHECK (energy IS NULL OR (energy >= 1 AND energy <= 10));

ALTER TABLE mood_entries ADD CONSTRAINT mood_entries_pleasantness_range
  CHECK (pleasantness IS NULL OR (pleasantness >= 1 AND pleasantness <= 10));

ALTER TABLE mood_entries ADD CONSTRAINT mood_entries_quadrant_valid
  CHECK (quadrant IS NULL OR quadrant IN ('fire', 'water', 'storm', 'shadow'));

-- Indexes for analytics queries (partial — only signal entries)
CREATE INDEX IF NOT EXISTS idx_mood_entries_user_quadrant
  ON mood_entries (user_id, quadrant)
  WHERE quadrant IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_mood_entries_user_signal
  ON mood_entries (user_id, signal_id)
  WHERE signal_id IS NOT NULL;
