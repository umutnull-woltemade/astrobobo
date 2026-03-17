#!/usr/bin/env bash
# =============================================================
# ASTROBOBO TMUX MULTI-AGENT ORCHESTRATION SYSTEM
# =============================================================
# Usage: bash scripts/tmux/start-agents.sh
# Stop:  bash scripts/tmux/stop-agents.sh
# =============================================================

set -euo pipefail

SESSION="astrobobo-agents"
PROJECT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
LOG_DIR="$PROJECT_DIR/logs/agents"

mkdir -p "$LOG_DIR"

# Kill existing session if running
tmux kill-session -t "$SESSION" 2>/dev/null || true

echo "=== Starting Astrobobo Agent System ==="
echo "Project: $PROJECT_DIR"
echo "Logs: $LOG_DIR"
echo ""

# Create session with first window
tmux new-session -d -s "$SESSION" -n "orchestrator" -c "$PROJECT_DIR"

# Window 1: Content Regenerator
tmux send-keys -t "$SESSION:orchestrator" \
  "echo '[ORCHESTRATOR] Astrobobo Agent System Online' && echo 'Batch size: 25 | Retry limit: 3 | No infinite loops'" C-m

# Window 2: Content Regenerator
tmux new-window -t "$SESSION" -n "content_regenerator" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:content_regenerator" \
  "echo '[CONTENT_REGEN] Ready. Run: node scripts/content-gen/batch-generate.mjs' | tee $LOG_DIR/content_regen.log" C-m

# Window 3: Micro Content Generator
tmux new-window -t "$SESSION" -n "micro_content" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:micro_content" \
  "echo '[MICRO_CONTENT] Ready. Generates reflections + affirmations' | tee $LOG_DIR/micro_content.log" C-m

# Window 4: Compliance Validator
tmux new-window -t "$SESSION" -n "compliance_validator" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:compliance_validator" \
  "echo '[COMPLIANCE] Ready. Run: npm run lint:compliance' | tee $LOG_DIR/compliance.log" C-m

# Window 5: SEO Optimizer
tmux new-window -t "$SESSION" -n "seo_optimizer" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:seo_optimizer" \
  "echo '[SEO] Ready. Run: npm run generate:sitemap' | tee $LOG_DIR/seo.log" C-m

# Window 6: Duplication Checker
tmux new-window -t "$SESSION" -n "duplication_checker" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:duplication_checker" \
  "echo '[DEDUP] Ready. Run: npm run lint:duplicates' | tee $LOG_DIR/dedup.log" C-m

# Window 7: DB Migration Validator
tmux new-window -t "$SESSION" -n "db_migration_validator" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:db_migration_validator" \
  "echo '[DB_MIGRATE] Ready. Run: npm run db:migrate -- --dry-run' | tee $LOG_DIR/db_migrate.log" C-m

# Window 8: Cost Monitor
tmux new-window -t "$SESSION" -n "cost_monitor" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:cost_monitor" \
  "echo '[COST] Budget: \$2/agent, \$10/cycle, \$50/week, \$200/month' | tee $LOG_DIR/cost.log" C-m

# Window 9: Merge Manager
tmux new-window -t "$SESSION" -n "merge_manager" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION:merge_manager" \
  "echo '[MERGE] Ready. Validates inter-agent outputs before merge.' | tee $LOG_DIR/merge.log" C-m

echo ""
echo "=== Agent System Started ==="
echo "Session: $SESSION"
echo "Windows:"
tmux list-windows -t "$SESSION" -F "  #{window_index}: #{window_name}"
echo ""
echo "Attach: tmux attach -t $SESSION"
echo "Stop:   bash scripts/tmux/stop-agents.sh"
