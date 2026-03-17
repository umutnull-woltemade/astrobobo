#!/usr/bin/env bash
# Stop Astrobobo Agent System
set -euo pipefail

SESSION="astrobobo-agents"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "Stopping agent session: $SESSION"
  tmux kill-session -t "$SESSION"
  echo "All agents stopped."
else
  echo "No active agent session found."
fi
