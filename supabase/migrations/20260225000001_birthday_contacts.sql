-- ════════════════════════════════════════════════════════════════════════════
-- BIRTHDAY CONTACTS TABLE - Birthday Agenda Feature
-- ════════════════════════════════════════════════════════════════════════════
-- Stores birthday contacts for the Birthday Agenda.
-- Follows the same pattern as life_events table.
-- ════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS birthday_contacts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  birthday_month INTEGER NOT NULL CHECK (birthday_month BETWEEN 1 AND 12),
  birthday_day INTEGER NOT NULL CHECK (birthday_day BETWEEN 1 AND 31),
  birth_year INTEGER,
  photo_path TEXT,
  avatar_emoji TEXT,
  relationship TEXT DEFAULT 'friend',
  note TEXT,
  source TEXT DEFAULT 'manual',
  notifications_enabled BOOLEAN DEFAULT true,
  day_before_reminder BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  is_deleted BOOLEAN DEFAULT false
);

ALTER TABLE birthday_contacts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own birthday contacts" ON birthday_contacts
  FOR ALL USING (auth.uid() = user_id);

CREATE TRIGGER update_birthday_contacts_updated_at
  BEFORE UPDATE ON birthday_contacts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE INDEX idx_birthday_contacts_user_id ON birthday_contacts(user_id);
CREATE INDEX idx_birthday_contacts_birthday ON birthday_contacts(birthday_month, birthday_day);
