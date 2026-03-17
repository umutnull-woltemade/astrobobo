-- ============================================================
-- ASTROBOBO ISOLATED DATABASE SCHEMA
-- Version: 1.0.0
-- Created: 2026-02-11
-- Description: Independent schema for Astrobobo astrology platform
-- No foreign keys to external systems
-- ============================================================

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ============================================================
-- CORE CONTENT TABLES
-- ============================================================

CREATE TABLE zodiac_signs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    element VARCHAR(10) NOT NULL CHECK (element IN ('Fire', 'Earth', 'Air', 'Water')),
    modality VARCHAR(10) NOT NULL CHECK (modality IN ('Cardinal', 'Fixed', 'Mutable')),
    ruling_planet VARCHAR(30) NOT NULL,
    date_range VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE archetypes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(20) NOT NULL CHECK (category IN ('planetary', 'elemental', 'modal')),
    symbol VARCHAR(10),
    description TEXT NOT NULL,
    themes TEXT[] NOT NULL DEFAULT '{}',
    strengths TEXT[] NOT NULL DEFAULT '{}',
    growth_areas TEXT[] NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE articles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug VARCHAR(200) UNIQUE NOT NULL,
    title VARCHAR(300) NOT NULL,
    description VARCHAR(500) NOT NULL,
    category VARCHAR(30) NOT NULL,
    tags TEXT[] NOT NULL DEFAULT '{}',
    content TEXT NOT NULL,
    reading_time INTEGER NOT NULL DEFAULT 5,
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'review', 'published', 'archived')),
    compliance_score DECIMAL(3,1) DEFAULT 0,
    duplication_score DECIMAL(3,1) DEFAULT 0,
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE reflections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    text TEXT NOT NULL,
    category VARCHAR(30) NOT NULL,
    related_sign VARCHAR(20) REFERENCES zodiac_signs(slug),
    related_planet VARCHAR(30),
    related_element VARCHAR(10),
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    status VARCHAR(20) NOT NULL DEFAULT 'published',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE affirmations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    text TEXT NOT NULL,
    theme VARCHAR(30) NOT NULL,
    related_sign VARCHAR(20) REFERENCES zodiac_signs(slug),
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    status VARCHAR(20) NOT NULL DEFAULT 'published',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- ZODIAC CONTENT TABLES
-- ============================================================

CREATE TABLE zodiac_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sign_slug VARCHAR(20) NOT NULL REFERENCES zodiac_signs(slug),
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    overview TEXT NOT NULL,
    personality TEXT NOT NULL,
    strengths TEXT[] NOT NULL DEFAULT '{}',
    growth_themes TEXT[] NOT NULL DEFAULT '{}',
    reflection_prompts TEXT[] NOT NULL DEFAULT '{}',
    compatibility_notes TEXT,
    daily_inspirations TEXT[] NOT NULL DEFAULT '{}',
    cosmic_explanation TEXT,
    compliance_score DECIMAL(3,1) DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(sign_slug, language)
);

CREATE TABLE zodiac_compatibility (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sign_a VARCHAR(20) NOT NULL REFERENCES zodiac_signs(slug),
    sign_b VARCHAR(20) NOT NULL REFERENCES zodiac_signs(slug),
    dynamic_description TEXT NOT NULL,
    strengths TEXT[] NOT NULL DEFAULT '{}',
    growth_areas TEXT[] NOT NULL DEFAULT '{}',
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(sign_a, sign_b, language),
    CHECK (sign_a < sign_b)
);

-- ============================================================
-- SEO & ANALYTICS TABLES
-- ============================================================

CREATE TABLE content_metadata (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content_type VARCHAR(30) NOT NULL,
    content_id UUID NOT NULL,
    meta_title VARCHAR(70),
    meta_description VARCHAR(160),
    og_image_url VARCHAR(500),
    canonical_url VARCHAR(500),
    structured_data JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE page_views (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    path VARCHAR(500) NOT NULL,
    referrer VARCHAR(500),
    user_agent VARCHAR(500),
    country VARCHAR(5),
    viewed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- COMPLIANCE & VALIDATION TABLES
-- ============================================================

CREATE TABLE compliance_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content_type VARCHAR(30) NOT NULL,
    content_id UUID NOT NULL,
    check_type VARCHAR(50) NOT NULL,
    passed BOOLEAN NOT NULL,
    score DECIMAL(3,1),
    violations JSONB DEFAULT '[]',
    checked_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE content_generation_log (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    batch_id VARCHAR(50),
    agent_name VARCHAR(50) NOT NULL,
    content_type VARCHAR(30) NOT NULL,
    model_used VARCHAR(50) NOT NULL,
    input_tokens INTEGER DEFAULT 0,
    output_tokens INTEGER DEFAULT 0,
    cost_usd DECIMAL(8,4) DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'completed',
    error_message TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_articles_slug ON articles(slug);
CREATE INDEX idx_articles_category ON articles(category);
CREATE INDEX idx_articles_status ON articles(status);
CREATE INDEX idx_articles_language ON articles(language);
CREATE INDEX idx_articles_published_at ON articles(published_at DESC);
CREATE INDEX idx_articles_tags ON articles USING GIN(tags);
CREATE INDEX idx_articles_content_search ON articles USING GIN(to_tsvector('english', title || ' ' || content));

CREATE INDEX idx_reflections_category ON reflections(category);
CREATE INDEX idx_reflections_sign ON reflections(related_sign);
CREATE INDEX idx_reflections_language ON reflections(language);

CREATE INDEX idx_affirmations_theme ON affirmations(theme);
CREATE INDEX idx_affirmations_sign ON affirmations(related_sign);
CREATE INDEX idx_affirmations_language ON affirmations(language);

CREATE INDEX idx_zodiac_profiles_sign ON zodiac_profiles(sign_slug);
CREATE INDEX idx_zodiac_profiles_language ON zodiac_profiles(language);

CREATE INDEX idx_page_views_path ON page_views(path);
CREATE INDEX idx_page_views_date ON page_views(viewed_at DESC);

CREATE INDEX idx_compliance_logs_content ON compliance_logs(content_type, content_id);
CREATE INDEX idx_compliance_logs_check ON compliance_logs(check_type);

CREATE INDEX idx_content_gen_batch ON content_generation_log(batch_id);
CREATE INDEX idx_content_gen_agent ON content_generation_log(agent_name);

-- ============================================================
-- TRIGGERS
-- ============================================================

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_zodiac_signs_updated
    BEFORE UPDATE ON zodiac_signs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_archetypes_updated
    BEFORE UPDATE ON archetypes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_articles_updated
    BEFORE UPDATE ON articles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_zodiac_profiles_updated
    BEFORE UPDATE ON zodiac_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_content_metadata_updated
    BEFORE UPDATE ON content_metadata
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- SEED DATA: Zodiac Signs
-- ============================================================

INSERT INTO zodiac_signs (slug, name, symbol, element, modality, ruling_planet, date_range, sort_order) VALUES
('aries',       'Aries',       '♈', 'Fire',  'Cardinal', 'Mars',              'Mar 21 - Apr 19',  1),
('taurus',      'Taurus',      '♉', 'Earth', 'Fixed',    'Venus',             'Apr 20 - May 20',  2),
('gemini',      'Gemini',      '♊', 'Air',   'Mutable',  'Mercury',           'May 21 - Jun 20',  3),
('cancer',      'Cancer',      '♋', 'Water', 'Cardinal', 'Moon',              'Jun 21 - Jul 22',  4),
('leo',         'Leo',         '♌', 'Fire',  'Fixed',    'Sun',               'Jul 23 - Aug 22',  5),
('virgo',       'Virgo',       '♍', 'Earth', 'Mutable',  'Mercury',           'Aug 23 - Sep 22',  6),
('libra',       'Libra',       '♎', 'Air',   'Cardinal', 'Venus',             'Sep 23 - Oct 22',  7),
('scorpio',     'Scorpio',     '♏', 'Water', 'Fixed',    'Pluto / Mars',      'Oct 23 - Nov 21',  8),
('sagittarius', 'Sagittarius', '♐', 'Fire',  'Mutable',  'Jupiter',           'Nov 22 - Dec 21',  9),
('capricorn',   'Capricorn',   '♑', 'Earth', 'Cardinal', 'Saturn',            'Dec 22 - Jan 19', 10),
('aquarius',    'Aquarius',    '♒', 'Air',   'Fixed',    'Uranus / Saturn',   'Jan 20 - Feb 18', 11),
('pisces',      'Pisces',      '♓', 'Water', 'Mutable',  'Neptune / Jupiter', 'Feb 19 - Mar 20', 12);
