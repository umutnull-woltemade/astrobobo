-- ═══════════════════════════════════════════════════════════════════════════
-- ADD selected_emotions TO mood_entries
-- ═══════════════════════════════════════════════════════════════════════════
-- Stores granular emotion IDs selected during mood check-in.
-- Powers pattern engine cross-correlation with specific emotions.
-- ═══════════════════════════════════════════════════════════════════════════

ALTER TABLE mood_entries
  ADD COLUMN IF NOT EXISTS selected_emotions TEXT[] DEFAULT '{}';

-- Index for querying entries that have granular emotions
CREATE INDEX IF NOT EXISTS idx_mood_entries_has_emotions
  ON mood_entries(user_id)
  WHERE array_length(selected_emotions, 1) > 0;
