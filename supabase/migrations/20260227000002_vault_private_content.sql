-- ════════════════════════════════════════════════════════════════════════════
-- MIGRATION: Private Vault - Add is_private flag to journal_entries & notes_to_self
-- Date: 2026-02-27
-- ════════════════════════════════════════════════════════════════════════════

-- Add is_private column to journal_entries
ALTER TABLE journal_entries
  ADD COLUMN IF NOT EXISTS is_private boolean NOT NULL DEFAULT false;

-- Add is_private column to notes_to_self
ALTER TABLE notes_to_self
  ADD COLUMN IF NOT EXISTS is_private boolean NOT NULL DEFAULT false;

-- Index for fast private content queries
CREATE INDEX IF NOT EXISTS idx_journal_entries_private
  ON journal_entries (user_id, is_private)
  WHERE is_private = true;

CREATE INDEX IF NOT EXISTS idx_notes_to_self_private
  ON notes_to_self (user_id, is_private)
  WHERE is_private = true;
