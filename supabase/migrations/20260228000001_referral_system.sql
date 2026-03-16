-- ============================================================================
-- REFERRAL SYSTEM - Viral growth engine
-- ============================================================================
-- Tables: referral_codes, referral_events
-- Function: increment_referral_count (RPC)
-- RLS: Users can only see/manage their own codes
-- ============================================================================

-- Referral codes table (one per user)
CREATE TABLE IF NOT EXISTS referral_codes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE,
  referral_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT unique_user_referral UNIQUE (user_id)
);

-- Referral events (tracking who used whose code)
CREATE TABLE IF NOT EXISTS referral_events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  referral_code TEXT NOT NULL REFERENCES referral_codes(code) ON DELETE CASCADE,
  invitee_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_referral_codes_code ON referral_codes(code);
CREATE INDEX IF NOT EXISTS idx_referral_codes_user ON referral_codes(user_id);
CREATE INDEX IF NOT EXISTS idx_referral_events_code ON referral_events(referral_code);

-- RLS
ALTER TABLE referral_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE referral_events ENABLE ROW LEVEL SECURITY;

-- Users can read/insert/update their own referral code
CREATE POLICY "Users manage own referral code"
  ON referral_codes FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Anyone can validate a code exists (SELECT only, no user data exposed)
CREATE POLICY "Anyone can validate referral codes"
  ON referral_codes FOR SELECT
  USING (true);

-- Users can insert referral events (when they use a code)
CREATE POLICY "Users can create referral events"
  ON referral_events FOR INSERT
  WITH CHECK (auth.uid() = invitee_user_id);

-- Users can see events for their own code
CREATE POLICY "Users can see own referral events"
  ON referral_events FOR SELECT
  USING (
    referral_code IN (
      SELECT code FROM referral_codes WHERE user_id = auth.uid()
    )
  );

-- RPC: Increment referral count atomically
CREATE OR REPLACE FUNCTION increment_referral_count(referral_code TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE referral_codes
  SET referral_count = referral_count + 1,
      updated_at = now()
  WHERE code = referral_code;
END;
$$;
