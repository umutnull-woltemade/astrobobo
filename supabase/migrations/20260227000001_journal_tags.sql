-- ════════════════════════════════════════════════════════════════════════════
-- ADD TAGS TO JOURNAL ENTRIES
-- ════════════════════════════════════════════════════════════════════════════
-- Adds a tags TEXT[] column to journal_entries for user-defined tagging.
-- Mirrors the existing tags field on notes_to_self.
-- ════════════════════════════════════════════════════════════════════════════

ALTER TABLE journal_entries
  ADD COLUMN IF NOT EXISTS tags TEXT[] DEFAULT '{}';

-- Index for tag-based queries (GIN index for array contains)
CREATE INDEX IF NOT EXISTS idx_journal_entries_tags
  ON journal_entries USING GIN (tags);
