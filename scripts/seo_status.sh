#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# seo_status.sh — quick health check for the SEO machine
# ═══════════════════════════════════════════════════════════════════════════
# Reads .env.seo, calls Supabase REST to fetch seo_pulse view + cron health.
# ═══════════════════════════════════════════════════════════════════════════

set -e
cd "$(dirname "$0")/.."

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'

[ -f .env.seo ] || { echo -e "${RED}✗${NC} .env.seo bulunamadı"; exit 1; }
set -a
. .env.seo
set +a

[ -n "$SUPABASE_PROJECT_REF" ] || { echo -e "${RED}✗${NC} SUPABASE_PROJECT_REF gerekli"; exit 1; }

API="https://${SUPABASE_PROJECT_REF}.supabase.co/rest/v1"

# Need service role key — try supabase CLI
if command -v supabase >/dev/null; then
  SVC_KEY=$(supabase status --output json 2>/dev/null | jq -r '.SERVICE_ROLE_KEY' 2>/dev/null || echo "")
fi

if [ -z "$SVC_KEY" ] || [ "$SVC_KEY" = "null" ]; then
  echo -e "${YELLOW}⚠${NC} SERVICE_ROLE_KEY otomatik alınamadı."
  echo -n "Yapıştır: "
  read -r SVC_KEY
fi

echo
echo "═══════════════════════════════════════════════════════"
echo -e "  ${BLUE}ASTROBOBO SEO PULSE${NC}  ($(date '+%Y-%m-%d %H:%M'))"
echo "═══════════════════════════════════════════════════════"
echo

# Single row from seo_pulse view
RESP=$(curl -sS "$API/seo_pulse?select=*" \
  -H "apikey: $SVC_KEY" \
  -H "Authorization: Bearer $SVC_KEY")

if command -v jq >/dev/null; then
  echo "$RESP" | jq -r '.[0] | to_entries | .[] | "  \(.key | gsub("_"; " ") | ascii_upcase): \(.value)"'
else
  echo "$RESP"
fi
echo

# Cron health
echo "═══════════════════════════════════════════════════════"
echo -e "  ${BLUE}CRON HEALTH${NC}"
echo "═══════════════════════════════════════════════════════"
echo

CRON=$(curl -sS "$API/seo_cron_health?select=*" \
  -H "apikey: $SVC_KEY" \
  -H "Authorization: Bearer $SVC_KEY")

if command -v jq >/dev/null; then
  echo "$CRON" | jq -r '.[] | "  \(.jobname) [\(.schedule)] → \(.status // "never run") — \(.start_time // "—")"'
else
  echo "$CRON"
fi
echo

# Recent post sample
echo "═══════════════════════════════════════════════════════"
echo -e "  ${BLUE}LAST 5 PUBLISHED${NC}"
echo "═══════════════════════════════════════════════════════"
echo

POSTS=$(curl -sS "$API/posts?select=lang,slug,title,quality_score,published_at&status=eq.published&order=published_at.desc&limit=5" \
  -H "apikey: $SVC_KEY" \
  -H "Authorization: Bearer $SVC_KEY")

if command -v jq >/dev/null; then
  echo "$POSTS" | jq -r '.[] | "  [\(.lang)] \(.slug) — q=\(.quality_score // "—") @ \(.published_at)"'
else
  echo "$POSTS"
fi
echo
