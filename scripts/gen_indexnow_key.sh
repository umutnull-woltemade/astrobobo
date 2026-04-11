#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# gen_indexnow_key.sh — generate IndexNow key + verification file
# ═══════════════════════════════════════════════════════════════════════════
# IndexNow requires a unique 8-128 char hex/alphanumeric key. The key must be
# served as a text file at https://your-site.com/<KEY>.txt with the key as body.
# ═══════════════════════════════════════════════════════════════════════════

set -e
cd "$(dirname "$0")/.."

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

# Generate 32-char hex key
if command -v openssl >/dev/null; then
  KEY=$(openssl rand -hex 16)
else
  KEY=$(head -c 16 /dev/urandom | xxd -p)
fi

KEY_FILE="web/${KEY}.txt"
echo "$KEY" > "$KEY_FILE"

echo -e "${GREEN}✓${NC} IndexNow key generated"
echo
echo -e "  ${BLUE}KEY:${NC}      $KEY"
echo -e "  ${BLUE}FILE:${NC}     $KEY_FILE"
echo -e "  ${BLUE}URL:${NC}      https://astrobobo.com/${KEY}.txt"
echo
echo -e "${YELLOW}Sıradaki adımlar:${NC}"
echo "  1. .env.seo dosyana ekle:"
echo "     INDEXNOW_KEY=$KEY"
echo
echo "  2. Supabase secrets:"
echo "     supabase secrets set INDEXNOW_KEY=$KEY"
echo
echo "  3. GitHub Repo Secrets:"
echo "     INDEXNOW_KEY=$KEY"
echo
echo "  4. Commit ve deploy:"
echo "     git add $KEY_FILE && git commit -m 'feat: indexnow verification key'"
echo "     git push origin main"
echo
echo "  5. Doğrula:"
echo "     curl https://astrobobo.com/${KEY}.txt   # → $KEY"
