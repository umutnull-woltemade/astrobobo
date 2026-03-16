-- Fix analytics_events RLS: allow anonymous (unauthenticated) inserts
-- The original policy exists but anon role may not have been granted access

-- Re-grant table access to anon role
GRANT INSERT ON analytics_events TO anon;
GRANT INSERT ON analytics_events TO authenticated;

-- Recreate policy to ensure it's correctly applied
DROP POLICY IF EXISTS "Anyone can insert analytics events" ON analytics_events;
CREATE POLICY "Anyone can insert analytics events"
  ON analytics_events FOR INSERT
  WITH CHECK (true);
