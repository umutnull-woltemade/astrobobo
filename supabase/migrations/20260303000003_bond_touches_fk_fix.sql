-- Fix touches table FK constraints to add CASCADE on user deletion
-- This prevents account deletion from being blocked by orphaned touch records

ALTER TABLE touches DROP CONSTRAINT IF EXISTS touches_sender_id_fkey;
ALTER TABLE touches DROP CONSTRAINT IF EXISTS touches_receiver_id_fkey;

ALTER TABLE touches
  ADD CONSTRAINT touches_sender_id_fkey
  FOREIGN KEY (sender_id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE touches
  ADD CONSTRAINT touches_receiver_id_fkey
  FOREIGN KEY (receiver_id) REFERENCES auth.users(id) ON DELETE CASCADE;
