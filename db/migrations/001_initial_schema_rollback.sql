-- Rollback: 001_initial_schema
-- WARNING: This will destroy all data

BEGIN;

DROP TABLE IF EXISTS content_generation_log CASCADE;
DROP TABLE IF EXISTS compliance_logs CASCADE;
DROP TABLE IF EXISTS page_views CASCADE;
DROP TABLE IF EXISTS content_metadata CASCADE;
DROP TABLE IF EXISTS zodiac_compatibility CASCADE;
DROP TABLE IF EXISTS zodiac_profiles CASCADE;
DROP TABLE IF EXISTS affirmations CASCADE;
DROP TABLE IF EXISTS reflections CASCADE;
DROP TABLE IF EXISTS articles CASCADE;
DROP TABLE IF EXISTS archetypes CASCADE;
DROP TABLE IF EXISTS zodiac_signs CASCADE;

DROP FUNCTION IF EXISTS update_updated_at() CASCADE;

DELETE FROM _migrations WHERE name = '001_initial_schema';

COMMIT;
