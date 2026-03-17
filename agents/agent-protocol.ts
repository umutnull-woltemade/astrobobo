/**
 * Astrobobo Inter-Agent Communication Protocol
 *
 * Standard JSON format for agent-to-agent data exchange.
 * Used across all TMUX windows for content pipeline.
 */

export interface AgentMessage {
  id: string;
  category:
    | "zodiac_profile"
    | "article"
    | "reflection"
    | "affirmation"
    | "micro_content"
    | "seo_page"
    | "compliance_result"
    | "cost_report";
  language: "en" | "tr";
  content: string;
  risk_score: number; // 0-10, 0 = safe
  duplication_score: number; // 0.0-1.0, < 0.7 required
  metadata?: Record<string, unknown>;
}

export interface AgentBatch {
  batch_id: string;
  agent_name: string;
  started_at: string;
  completed_at?: string;
  items: AgentMessage[];
  total_tokens: number;
  total_cost_usd: number;
  status: "running" | "completed" | "failed" | "retrying";
  retry_count: number;
  errors: string[];
}

export interface AgentConfig {
  name: string;
  window: number;
  batch_size: number;
  retry_limit: number;
  max_concurrent: number;
  model_preference: "local" | "cloud" | "hybrid";
  cost_limit_usd: number;
}

// Agent configuration registry
export const AGENT_CONFIGS: AgentConfig[] = [
  {
    name: "content_regenerator",
    window: 1,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 4,
    model_preference: "hybrid",
    cost_limit_usd: 2.0,
  },
  {
    name: "micro_content",
    window: 2,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 4,
    model_preference: "local",
    cost_limit_usd: 0.5,
  },
  {
    name: "compliance_validator",
    window: 3,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 2,
    model_preference: "cloud",
    cost_limit_usd: 1.0,
  },
  {
    name: "seo_optimizer",
    window: 4,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 4,
    model_preference: "local",
    cost_limit_usd: 0.5,
  },
  {
    name: "duplication_checker",
    window: 5,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 2,
    model_preference: "local",
    cost_limit_usd: 0.0,
  },
  {
    name: "db_migration_validator",
    window: 6,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 1,
    model_preference: "local",
    cost_limit_usd: 0.0,
  },
  {
    name: "cost_monitor",
    window: 7,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 1,
    model_preference: "local",
    cost_limit_usd: 0.0,
  },
  {
    name: "merge_manager",
    window: 8,
    batch_size: 25,
    retry_limit: 3,
    max_concurrent: 1,
    model_preference: "local",
    cost_limit_usd: 0.0,
  },
];

// Cost tracking
export interface CostEntry {
  agent_name: string;
  model: string;
  input_tokens: number;
  output_tokens: number;
  cost_usd: number;
  timestamp: string;
}

export const COST_LIMITS = {
  per_agent: 2.0,
  per_cycle: 10.0,
  per_week: 50.0,
  per_month: 200.0,
};
