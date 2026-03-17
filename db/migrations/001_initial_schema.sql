-- Migration: 001_initial_schema
-- Created: 2026-02-11
-- Description: Initial Astrobobo database schema
-- Rollback: 001_initial_schema_rollback.sql

BEGIN;

-- Track migration state
CREATE TABLE IF NOT EXISTS _migrations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) UNIQUE NOT NULL,
    applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Check if already applied
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM _migrations WHERE name = '001_initial_schema') THEN
        RAISE EXCEPTION 'Migration 001_initial_schema already applied';
    END IF;
END $$;

-- Execute full schema
\i ../schema_astrobobo.sql

-- Record migration
INSERT INTO _migrations (name) VALUES ('001_initial_schema');

COMMIT;
