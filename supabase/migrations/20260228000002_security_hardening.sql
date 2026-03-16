-- ============================================================================
-- SECURITY HARDENING - Fix RLS policies and RPC validation
-- ============================================================================
-- Fixes:
-- 1. analytics_events: Require auth for INSERT
-- 2. referral_codes: Replace broad SELECT with validation function
-- 3. increment_referral_count: Add caller validation
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. ANALYTICS EVENTS: Require authenticated user for INSERT
-- ══════════════════════════════════════════════════════════════════════════════

DROP POLICY IF EXISTS "Anyone can insert analytics events" ON analytics_events;

CREATE POLICY "Authenticated users can insert analytics events"
  ON analytics_events FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. REFERRAL CODES: Replace broad SELECT with a validation function
-- ══════════════════════════════════════════════════════════════════════════════

-- Remove the policy that exposes all user_ids
DROP POLICY IF EXISTS "Anyone can validate referral codes" ON referral_codes;

-- Add a narrow SELECT policy: users can only see their own code
-- (The "Users manage own referral code" policy already covers FOR ALL,
--  but we explicitly drop the broad one above)

-- Secure code validation function (returns boolean, no row exposure)
CREATE OR REPLACE FUNCTION validate_referral_code(code_to_check TEXT)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM referral_codes WHERE code = code_to_check
  );
END;
$$;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. INCREMENT REFERRAL COUNT: Add caller validation
-- ══════════════════════════════════════════════════════════════════════════════

-- Replace the unguarded increment function with one that:
-- a) Prevents self-referral
-- b) Prevents duplicate redemptions
CREATE OR REPLACE FUNCTION increment_referral_count(referral_code TEXT)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  code_owner_id UUID;
BEGIN
  -- Get the owner of this referral code
  SELECT user_id INTO code_owner_id
  FROM referral_codes
  WHERE code = referral_code;

  -- Code doesn't exist
  IF code_owner_id IS NULL THEN
    RAISE EXCEPTION 'Invalid referral code';
  END IF;

  -- Prevent self-referral
  IF code_owner_id = auth.uid() THEN
    RAISE EXCEPTION 'Cannot use your own referral code';
  END IF;

  -- Prevent duplicate redemption by this user
  IF EXISTS (
    SELECT 1 FROM referral_events
    WHERE referral_events.referral_code = increment_referral_count.referral_code
      AND invitee_user_id = auth.uid()
  ) THEN
    RAISE EXCEPTION 'Referral code already redeemed';
  END IF;

  -- All checks passed — increment
  UPDATE referral_codes
  SET referral_count = referral_count + 1,
      updated_at = now()
  WHERE code = referral_code;
END;
$$;
