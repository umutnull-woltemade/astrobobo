-- ML-Assisted Experimentation System
-- Migration: 20260204_ml_experimentation
-- Purpose: Tables for Learning A/B Agent and ML Rollout Policy

-- =============================================================================
-- PART 1: Learning Agent Tables
-- =============================================================================

-- Time-series metrics for learning agent
CREATE TABLE IF NOT EXISTS experiment_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  experiment_id TEXT NOT NULL,
  variant_code TEXT NOT NULL,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  stage_number INTEGER NOT NULL CHECK (stage_number BETWEEN 1 AND 4),
  rollout_percentage DECIMAL(5,2) CHECK (rollout_percentage BETWEEN 0 AND 100),
  sample_size INTEGER NOT NULL DEFAULT 0,
  success_rate DECIMAL(6,4) CHECK (success_rate BETWEEN 0 AND 1),
  error_rate DECIMAL(6,4) CHECK (error_rate BETWEEN 0 AND 1),
  crash_rate DECIMAL(6,4) CHECK (crash_rate BETWEEN 0 AND 1),
  confidence_score DECIMAL(4,3) CHECK (confidence_score BETWEEN 0 AND 1),
  hours_in_stage INTEGER DEFAULT 0,
  hours_total INTEGER DEFAULT 0,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for experiment_metrics
CREATE INDEX IF NOT EXISTS idx_experiment_metrics_experiment_id
  ON experiment_metrics(experiment_id);
CREATE INDEX IF NOT EXISTS idx_experiment_metrics_timestamp
  ON experiment_metrics(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_experiment_metrics_user_id
  ON experiment_metrics(user_id) WHERE user_id IS NOT NULL;

-- Experiment outcomes for learning loop
CREATE TABLE IF NOT EXISTS experiment_outcomes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  experiment_id TEXT NOT NULL,
  was_successful BOOLEAN NOT NULL,
  variant_code TEXT NOT NULL,
  recommendations JSONB,
  metric_summary JSONB,
  final_stage INTEGER,
  total_hours INTEGER,
  recorded_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for outcomes
CREATE INDEX IF NOT EXISTS idx_experiment_outcomes_experiment_id
  ON experiment_outcomes(experiment_id);
CREATE INDEX IF NOT EXISTS idx_experiment_outcomes_recorded_at
  ON experiment_outcomes(recorded_at DESC);

-- Global learning model (synced from devices)
CREATE TABLE IF NOT EXISTS learning_models (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  version TEXT UNIQUE NOT NULL,
  is_active BOOLEAN DEFAULT FALSE,
  feature_weights JSONB NOT NULL DEFAULT '{}',
  patterns JSONB DEFAULT '[]',
  thresholds JSONB DEFAULT '{"crashWarning": 0.003, "errorWarning": 0.05}',
  training_epochs INTEGER DEFAULT 0,
  accuracy_score DECIMAL(4,3),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  activated_at TIMESTAMPTZ
);

-- Ensure only one active model
CREATE UNIQUE INDEX IF NOT EXISTS idx_learning_models_active
  ON learning_models(is_active) WHERE is_active = TRUE;

-- =============================================================================
-- PART 2: ML Rollout Policy Tables
-- =============================================================================

-- ML rollout training data
CREATE TABLE IF NOT EXISTS rollout_training_data (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  flag_name TEXT NOT NULL,
  snapshot_timestamp TIMESTAMPTZ DEFAULT NOW(),

  -- Rollout context features
  current_rollout_percentage INTEGER CHECK (current_rollout_percentage BETWEEN 0 AND 100),
  time_since_last_step_hours INTEGER,
  total_exposed_users INTEGER,

  -- Health metrics
  crash_rate_delta_24h DECIMAL(5,4),
  error_rate_delta_24h DECIMAL(5,4),
  churn_rate_exposed_vs_control DECIMAL(5,2),

  -- Success signals
  conversion_rate_exposed DECIMAL(5,4),
  engagement_delta_exposed DECIMAL(5,4),
  retention_d1_exposed DECIMAL(5,4),

  -- Platform distribution
  platform_ios_ratio DECIMAL(4,3),
  platform_android_ratio DECIMAL(4,3),

  -- Outcome (for training)
  had_incident_within_24h BOOLEAN DEFAULT FALSE,
  incident_type TEXT,
  incident_severity TEXT CHECK (incident_severity IN ('low', 'medium', 'high', 'critical'))
);

-- Indexes for training data
CREATE INDEX IF NOT EXISTS idx_rollout_training_flag
  ON rollout_training_data(flag_name);
CREATE INDEX IF NOT EXISTS idx_rollout_training_timestamp
  ON rollout_training_data(snapshot_timestamp DESC);

-- Trained ML rollout models
CREATE TABLE IF NOT EXISTS ml_rollout_models (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  version TEXT UNIQUE NOT NULL,
  model_type TEXT NOT NULL DEFAULT 'logistic_regression',
  weights JSONB NOT NULL,
  feature_names TEXT[] NOT NULL,
  feature_importance JSONB NOT NULL DEFAULT '{}',
  training_samples INTEGER,

  -- Model metrics
  metrics JSONB DEFAULT '{}',
  f1_score DECIMAL(4,3),
  precision_score DECIMAL(4,3),
  recall_score DECIMAL(4,3),
  auc_roc DECIMAL(4,3),

  -- Status tracking
  status TEXT DEFAULT 'trained' CHECK (status IN ('trained', 'validated', 'approved', 'active', 'deprecated')),
  is_active BOOLEAN DEFAULT FALSE,
  approved_by TEXT,
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Ensure only one active rollout model
CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_rollout_models_active
  ON ml_rollout_models(is_active) WHERE is_active = TRUE;

-- =============================================================================
-- PART 3: Audit & Decision Logging
-- =============================================================================

-- Audit trail for all ML model actions
CREATE TABLE IF NOT EXISTS ml_model_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  model_version TEXT NOT NULL,
  model_type TEXT NOT NULL DEFAULT 'learning_agent',
  action TEXT NOT NULL CHECK (action IN (
    'created', 'trained', 'validated', 'approved', 'activated',
    'deprecated', 'rolled_back', 'weights_updated', 'threshold_adjusted'
  )),
  actor_type TEXT DEFAULT 'system' CHECK (actor_type IN ('system', 'user', 'admin', 'cron')),
  actor_id TEXT,
  previous_state JSONB,
  new_state JSONB,
  metrics JSONB,
  feature_importance JSONB,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for audit lookups
CREATE INDEX IF NOT EXISTS idx_ml_model_audit_version
  ON ml_model_audit(model_version);
CREATE INDEX IF NOT EXISTS idx_ml_model_audit_created_at
  ON ml_model_audit(created_at DESC);

-- Rollout decisions log (every decision, rule or ML)
CREATE TABLE IF NOT EXISTS rollout_decisions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  flag_name TEXT NOT NULL,
  action TEXT NOT NULL CHECK (action IN ('hold', 'advance', 'rollback', 'freeze', 'unfreeze')),
  previous_percentage INTEGER,
  new_percentage INTEGER,

  -- Decision source and reasoning
  decision_source TEXT NOT NULL CHECK (decision_source IN (
    'rule_hard_guard', 'rule_churn_defense', 'ml_risk_gate',
    'ml_acceleration', 'manual_override', 'safety_rollback'
  )),
  decision_level INTEGER CHECK (decision_level BETWEEN 1 AND 3),

  -- ML details (if applicable)
  ml_risk_probability DECIMAL(5,4),
  ml_suggested_delta INTEGER,
  ml_confidence_next DECIMAL(4,3),
  ml_overridden BOOLEAN DEFAULT FALSE,
  override_reason TEXT,

  -- Explainability
  explanation TEXT,
  top_contributors JSONB,

  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for decision queries
CREATE INDEX IF NOT EXISTS idx_rollout_decisions_flag
  ON rollout_decisions(flag_name);
CREATE INDEX IF NOT EXISTS idx_rollout_decisions_created_at
  ON rollout_decisions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_rollout_decisions_action
  ON rollout_decisions(action);

-- =============================================================================
-- PART 4: Row Level Security Policies
-- =============================================================================

-- Enable RLS on all tables
ALTER TABLE experiment_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE experiment_outcomes ENABLE ROW LEVEL SECURITY;
ALTER TABLE learning_models ENABLE ROW LEVEL SECURITY;
ALTER TABLE rollout_training_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE ml_rollout_models ENABLE ROW LEVEL SECURITY;
ALTER TABLE ml_model_audit ENABLE ROW LEVEL SECURITY;
ALTER TABLE rollout_decisions ENABLE ROW LEVEL SECURITY;

-- experiment_metrics: Users can view own metrics, insert own metrics
CREATE POLICY "Users view own experiment metrics"
  ON experiment_metrics FOR SELECT
  USING (auth.uid() = user_id OR user_id IS NULL);

CREATE POLICY "Users insert own experiment metrics"
  ON experiment_metrics FOR INSERT
  WITH CHECK (auth.uid() = user_id OR user_id IS NULL);

-- experiment_outcomes: Insert only (for collecting outcomes)
CREATE POLICY "Insert experiment outcomes"
  ON experiment_outcomes FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Select experiment outcomes"
  ON experiment_outcomes FOR SELECT
  USING (true);

-- learning_models: Public read (models are shared)
CREATE POLICY "Public read learning models"
  ON learning_models FOR SELECT
  USING (true);

-- rollout_training_data: Insert only for data collection
CREATE POLICY "Insert rollout training data"
  ON rollout_training_data FOR INSERT
  WITH CHECK (true);

-- ml_rollout_models: Public read
CREATE POLICY "Public read ml rollout models"
  ON ml_rollout_models FOR SELECT
  USING (true);

-- ml_model_audit: Public read for transparency
CREATE POLICY "Public read ml model audit"
  ON ml_model_audit FOR SELECT
  USING (true);

CREATE POLICY "System insert ml model audit"
  ON ml_model_audit FOR INSERT
  WITH CHECK (true);

-- rollout_decisions: Public read for transparency
CREATE POLICY "Public read rollout decisions"
  ON rollout_decisions FOR SELECT
  USING (true);

CREATE POLICY "System insert rollout decisions"
  ON rollout_decisions FOR INSERT
  WITH CHECK (true);

-- =============================================================================
-- PART 5: Helper Functions
-- =============================================================================

-- Function to get the active learning model
CREATE OR REPLACE FUNCTION get_active_learning_model()
RETURNS learning_models AS $$
  SELECT * FROM learning_models WHERE is_active = TRUE LIMIT 1;
$$ LANGUAGE SQL STABLE;

-- Function to get the active ML rollout model
CREATE OR REPLACE FUNCTION get_active_rollout_model()
RETURNS ml_rollout_models AS $$
  SELECT * FROM ml_rollout_models WHERE is_active = TRUE LIMIT 1;
$$ LANGUAGE SQL STABLE;

-- Function to log a model action
CREATE OR REPLACE FUNCTION log_model_action(
  p_model_version TEXT,
  p_model_type TEXT,
  p_action TEXT,
  p_actor_type TEXT DEFAULT 'system',
  p_actor_id TEXT DEFAULT NULL,
  p_metrics JSONB DEFAULT NULL,
  p_notes TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  v_id UUID;
BEGIN
  INSERT INTO ml_model_audit (
    model_version, model_type, action, actor_type, actor_id, metrics, notes
  ) VALUES (
    p_model_version, p_model_type, p_action, p_actor_type, p_actor_id, p_metrics, p_notes
  ) RETURNING id INTO v_id;

  RETURN v_id;
END;
$$ LANGUAGE plpgsql;

-- Function to get recent metrics for an experiment
CREATE OR REPLACE FUNCTION get_experiment_metrics_history(
  p_experiment_id TEXT,
  p_hours_back INTEGER DEFAULT 168  -- 7 days default
)
RETURNS SETOF experiment_metrics AS $$
  SELECT * FROM experiment_metrics
  WHERE experiment_id = p_experiment_id
    AND timestamp >= NOW() - (p_hours_back || ' hours')::INTERVAL
  ORDER BY timestamp DESC;
$$ LANGUAGE SQL STABLE;

-- =============================================================================
-- COMMENT: Migration complete
-- =============================================================================
