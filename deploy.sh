#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════
# astrobobo.com — Next.js Deploy Script
# Builds, deploys to Vercel, sets astrobobo.com alias, runs smoke test.
# ═══════════════════════════════════════════════════════════════════════════

set -e
cd "$(dirname "$0")"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "═══════════════════════════════════════════"
echo "  astrobobo.com — Next.js Deploy"
echo "═══════════════════════════════════════════"

# Build
echo "▶ Building..."
npx next build

# Deploy
echo "▶ Deploying to Vercel..."
DEPLOY_URL=$(vercel --prod --yes 2>&1 | grep -oE 'https://astrobobo-[a-z0-9]+-umutnull[^ ]*' | head -1)
echo "  Deploy: $DEPLOY_URL"

# Alias
echo "▶ Setting astrobobo.com alias..."
vercel alias set "$DEPLOY_URL" astrobobo.com 2>&1 | tail -1

# Smoke test
echo "▶ Smoke testing..."
PASS=0
FAIL=0
for path in "/" "/api/health" "/api/og?title=Test" "/r/tr/ruyada-araba" "/r/tr" "/sitemap.xml" "/robots.txt" "/llms.txt"; do
  CODE=$(curl -sL -o /dev/null -w "%{http_code}" "https://astrobobo.com$path")
  if [ "$CODE" = "200" ]; then
    PASS=$((PASS + 1))
    printf "  ${GREEN}200${NC} %s\n" "$path"
  else
    FAIL=$((FAIL + 1))
    printf "  ${RED}%s${NC} %s\n" "$CODE" "$path"
  fi
done

echo ""
if [ $FAIL -eq 0 ]; then
  echo "═══════════════════════════════════════════"
  printf "  ${GREEN}✨ DEPLOY OK${NC} — $PASS/$((PASS+FAIL)) routes live\n"
  echo "  Production: https://astrobobo.com"
  echo "═══════════════════════════════════════════"
else
  echo "⚠ $FAIL routes failed"
fi
