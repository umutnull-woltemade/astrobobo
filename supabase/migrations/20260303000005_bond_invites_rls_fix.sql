-- ═══════════════════════════════════════════════════════════════════════════
-- FIX: Bond invite RLS policy blocks acceptance flow
-- ═══════════════════════════════════════════════════════════════════════════
-- The original policy (auth.uid() = creator_id OR auth.uid() = accepted_by)
-- prevents User B from reading/updating an invite where accepted_by is NULL.
-- This makes the entire bond acceptance flow fail silently.
-- ═══════════════════════════════════════════════════════════════════════════

-- Drop the broken policy
DROP POLICY IF EXISTS "Users can manage own invites" ON bond_invites;

-- Allow any authenticated user to read pending (unclaimed) invites by code
CREATE POLICY "Anyone can read pending invites" ON bond_invites
  FOR SELECT USING (
    accepted_by IS NULL
    OR auth.uid() = creator_id
    OR auth.uid() = accepted_by
  );

-- Allow any authenticated user to claim an unclaimed invite
CREATE POLICY "Anyone can accept pending invites" ON bond_invites
  FOR UPDATE USING (
    accepted_by IS NULL
    OR auth.uid() = creator_id
    OR auth.uid() = accepted_by
  );

-- Only creator can create invites
CREATE POLICY "Creator can insert invites" ON bond_invites
  FOR INSERT WITH CHECK (auth.uid() = creator_id);

-- Only creator can delete their invites
CREATE POLICY "Creator can delete invites" ON bond_invites
  FOR DELETE USING (auth.uid() = creator_id);
