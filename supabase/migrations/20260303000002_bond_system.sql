-- ═══════════════════════════════════════════════════════════════════════════
-- BOND SYSTEM — Partner/close relationship bonds with mood sharing & touches
-- ═══════════════════════════════════════════════════════════════════════════
-- Tables: bond_invites, bonds, touches, bond_privacy
-- RLS: auth.uid() = user_a / user_b / creator_id (user isolation)
-- Realtime enabled on touches + bonds for live updates
-- ═══════════════════════════════════════════════════════════════════════════

-- 1. Bond Invites
CREATE TABLE IF NOT EXISTS bond_invites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE,
  bond_type TEXT NOT NULL CHECK (bond_type IN ('partner', 'bestFriend', 'sibling')),
  expires_at TIMESTAMPTZ NOT NULL,
  accepted_by UUID REFERENCES auth.users(id),
  accepted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE bond_invites ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own invites" ON bond_invites
  FOR ALL USING (auth.uid() = creator_id OR auth.uid() = accepted_by);

CREATE INDEX idx_bond_invites_code ON bond_invites (code) WHERE accepted_by IS NULL;
CREATE INDEX idx_bond_invites_creator ON bond_invites (creator_id);

-- 2. Bonds
CREATE TABLE IF NOT EXISTS bonds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_a UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  user_b UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  bond_type TEXT NOT NULL CHECK (bond_type IN ('partner', 'bestFriend', 'sibling')),
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('pending', 'active', 'paused', 'dissolving', 'dissolved')),
  display_name_a TEXT, -- user_a's custom display name for user_b
  display_name_b TEXT, -- user_b's custom display name for user_a
  dissolve_requested_at TIMESTAMPTZ, -- 7-day cooling period start
  dissolve_requested_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT bonds_no_self CHECK (user_a <> user_b)
);

CREATE UNIQUE INDEX idx_bonds_unique_pair ON bonds (LEAST(user_a, user_b), GREATEST(user_a, user_b));

ALTER TABLE bonds ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can see own bonds" ON bonds
  FOR ALL USING (auth.uid() = user_a OR auth.uid() = user_b);

CREATE INDEX idx_bonds_user_a ON bonds (user_a) WHERE status = 'active';
CREATE INDEX idx_bonds_user_b ON bonds (user_b) WHERE status = 'active';

-- Enable Realtime on bonds
ALTER PUBLICATION supabase_realtime ADD TABLE bonds;

-- 3. Touches
CREATE TABLE IF NOT EXISTS touches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bond_id UUID NOT NULL REFERENCES bonds(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES auth.users(id),
  receiver_id UUID NOT NULL REFERENCES auth.users(id),
  touch_type TEXT NOT NULL DEFAULT 'warm' CHECK (touch_type IN ('warm', 'heartbeat', 'light')),
  seen_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE touches ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can see own touches" ON touches
  FOR ALL USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE INDEX idx_touches_receiver ON touches (receiver_id, created_at DESC);
CREATE INDEX idx_touches_bond ON touches (bond_id, created_at DESC);

-- Enable Realtime on touches
ALTER PUBLICATION supabase_realtime ADD TABLE touches;

-- 4. Bond Privacy
CREATE TABLE IF NOT EXISTS bond_privacy (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bond_id UUID NOT NULL REFERENCES bonds(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  share_mood BOOLEAN DEFAULT true,
  share_signal BOOLEAN DEFAULT true,
  share_streak BOOLEAN DEFAULT false,
  allow_touches BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (bond_id, user_id)
);

ALTER TABLE bond_privacy ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own privacy" ON bond_privacy
  FOR ALL USING (auth.uid() = user_id);

-- 5. Weather Status (Phase 2 stub — for future partner weather/mood status sharing)
CREATE TABLE IF NOT EXISTS weather_status (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  status_emoji TEXT,
  status_text TEXT,
  signal_id TEXT,
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE weather_status ENABLE ROW LEVEL SECURITY;

-- Users can read their bond partner's weather status
CREATE POLICY "Users can manage own weather" ON weather_status
  FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Bond partners can read weather" ON weather_status
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM bonds
      WHERE status = 'active'
      AND (
        (user_a = auth.uid() AND user_b = weather_status.user_id) OR
        (user_b = auth.uid() AND user_a = weather_status.user_id)
      )
    )
  );
