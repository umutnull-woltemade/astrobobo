#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# astrobobo SEO machine — one-tıkla bootstrap
# ═══════════════════════════════════════════════════════════════════════════
# Bu script:
#   1. supabase CLI varlığını kontrol eder
#   2. .env.seo dosyasından env okur (yoksa template oluşturur)
#   3. supabase link, db push (migrations)
#   4. edge function secrets set
#   5. edge functions deploy
#   6. ilk content-generator dry-run
# ═══════════════════════════════════════════════════════════════════════════

set -e
cd "$(dirname "$0")/.."

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'
step() { echo -e "${BLUE}▶${NC} $1"; }
ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }

echo "═══════════════════════════════════════════════════════"
echo "  astrobobo SEO machine — bootstrap"
echo "═══════════════════════════════════════════════════════"
echo

# ─── 0. tools ──────────────────────────────────────────────────────────────
step "Pre-flight"
command -v supabase >/dev/null || fail "supabase CLI yok. Install: brew install supabase/tap/supabase"
command -v dart     >/dev/null || fail "dart yok. Flutter SDK gerekli."
command -v jq       >/dev/null || warn "jq yok (curl çıktısı parse edemeyiz)"
ok "tools present"
echo

# ─── 1. .env.seo ───────────────────────────────────────────────────────────
ENV_FILE=".env.seo"
if [ ! -f "$ENV_FILE" ]; then
  warn "$ENV_FILE bulunamadı, template oluşturuluyor"
  cat > "$ENV_FILE" <<EOF
# ────────────────────────────────────────────────────────────────────
# astrobobo SEO machine — secrets
# Bu dosyayı .gitignore'a ekle: echo .env.seo >> .gitignore
# ────────────────────────────────────────────────────────────────────

# Supabase project (Settings → General → Reference ID)
SUPABASE_PROJECT_REF=

# Anthropic Claude API
ANTHROPIC_API_KEY=

# GitHub (PAT with contents:write on the repo)
GITHUB_TOKEN=
GITHUB_REPO=umutnull/astrobobo
GITHUB_BRANCH=main

# Site
SITE_ORIGIN=https://astrobobo.com

# IndexNow (rastgele 32 hex karakterli string oluştur, sonra
# /web/<KEY>.txt dosyasına aynı stringi koy)
INDEXNOW_KEY=

# Optional: Bing Webmaster Tools API key
BING_WEBMASTER_KEY=

# Optional: Vercel deploy hook URL
VERCEL_DEPLOY_HOOK_URL=

# ─── Phase 2: GSC sync ──────────────────────────────────────────────────
# Service account JSON (paste entire JSON contents on ONE line, escape quotes)
# Setup: GCP Console → IAM → Service Accounts → New → Download JSON key
#        Then in Search Console → Settings → Users → add SA email as Restricted
GOOGLE_SA_JSON=
GSC_SITE_URL=https://astrobobo.com/

# ─── Phase 3: og image generator ────────────────────────────────────────
# Replicate (cheap + fast). Sign up: https://replicate.com/account/api-tokens
REPLICATE_API_TOKEN=
REPLICATE_MODEL_VERSION=black-forest-labs/flux-schnell
EOF
  ok "$ENV_FILE oluşturuldu — değerleri doldur ve scripti tekrar çalıştır"
  exit 0
fi

# load env
set -a
# shellcheck disable=SC1090
. "$ENV_FILE"
set +a

[ -n "$SUPABASE_PROJECT_REF" ] || fail "SUPABASE_PROJECT_REF gerekli ($ENV_FILE)"
[ -n "$ANTHROPIC_API_KEY" ]    || fail "ANTHROPIC_API_KEY gerekli"
[ -n "$GITHUB_TOKEN" ]         || fail "GITHUB_TOKEN gerekli"
[ -n "$GITHUB_REPO" ]          || fail "GITHUB_REPO gerekli"
ok "env loaded"
echo

# ─── 2. supabase link ──────────────────────────────────────────────────────
step "supabase link → $SUPABASE_PROJECT_REF"
supabase link --project-ref "$SUPABASE_PROJECT_REF" || warn "zaten linked olabilir"
echo

# ─── 3. db push (migrations) ───────────────────────────────────────────────
step "db push (0001_seo_schema, 0002_pg_cron)"
supabase db push
ok "schema applied"
echo

# ─── 4. edge function secrets ──────────────────────────────────────────────
step "set edge function secrets"
SECRETS_ARGS=(
  ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"
  GITHUB_TOKEN="$GITHUB_TOKEN"
  GITHUB_REPO="$GITHUB_REPO"
  GITHUB_BRANCH="${GITHUB_BRANCH:-main}"
  SITE_ORIGIN="${SITE_ORIGIN:-https://astrobobo.com}"
  INDEXNOW_KEY="${INDEXNOW_KEY:-}"
  BING_WEBMASTER_KEY="${BING_WEBMASTER_KEY:-}"
  GSC_SITE_URL="${GSC_SITE_URL:-https://astrobobo.com/}"
)
if [ -n "$GOOGLE_SA_JSON" ]; then
  SECRETS_ARGS+=(GOOGLE_SA_JSON="$GOOGLE_SA_JSON")
fi
if [ -n "$REPLICATE_API_TOKEN" ]; then
  SECRETS_ARGS+=(REPLICATE_API_TOKEN="$REPLICATE_API_TOKEN")
  SECRETS_ARGS+=(REPLICATE_MODEL_VERSION="${REPLICATE_MODEL_VERSION:-black-forest-labs/flux-schnell}")
fi
supabase secrets set "${SECRETS_ARGS[@]}"
ok "secrets set"
echo

# ─── 5. deploy edge functions ──────────────────────────────────────────────
step "deploy edge functions"
FUNCTIONS=(
  trend-scanner
  content-generator
  quality-gate
  publisher
  indexer
  internal-link-enhancer
  backlink-autogen
  viral-gen
  ranking-optimizer
  content-refresh
  topic-cluster-builder
  gsc-sync
  translator
  citation-tracker
  og-image-gen
  monetization-injector
)
for fn in "${FUNCTIONS[@]}"; do
  echo "  → $fn"
  supabase functions deploy "$fn" --no-verify-jwt
done
ok "all ${#FUNCTIONS[@]} functions deployed"
echo

# ─── 6. seed keyword queue ─────────────────────────────────────────────────
step "trend-scanner → seed keyword_queue"
FUNCTIONS_URL="https://${SUPABASE_PROJECT_REF}.functions.supabase.co"
SVC_KEY=$(supabase status --output json 2>/dev/null | jq -r '.SERVICE_ROLE_KEY' || echo "")
if [ -z "$SVC_KEY" ] || [ "$SVC_KEY" = "null" ]; then
  warn "service_role_key auto-fetch fail; supabase secrets set sonrası elle çalıştır:"
  echo "    curl -X POST $FUNCTIONS_URL/trend-scanner -H \"Authorization: Bearer <SERVICE_ROLE>\" -d '{\"langs\":[\"tr\",\"en\"]}'"
else
  curl -sS -X POST "$FUNCTIONS_URL/trend-scanner" \
    -H "Authorization: Bearer $SVC_KEY" \
    -H "Content-Type: application/json" \
    -d '{"langs":["tr","en"]}' | (jq . 2>/dev/null || cat)
  ok "queue seeded"
fi
echo

# ─── 7. dry-run content-generator (5 makale) ──────────────────────────────
step "content-generator → ilk 5 makale (dry test)"
if [ -n "$SVC_KEY" ] && [ "$SVC_KEY" != "null" ]; then
  curl -sS -X POST "$FUNCTIONS_URL/content-generator" \
    -H "Authorization: Bearer $SVC_KEY" \
    -H "Content-Type: application/json" \
    -d '{"batch":5,"lang":"tr"}' | (jq . 2>/dev/null || cat)
  ok "dry run done — Supabase posts table'a bak"
fi
echo

echo "═══════════════════════════════════════════════════════"
ok "BOOTSTRAP TAMAMLANDI"
echo "═══════════════════════════════════════════════════════"
echo
echo "Sıradakiler:"
echo "  1. Supabase Vault (SQL editor):"
echo "     select vault.create_secret('$FUNCTIONS_URL', 'functions_url');"
echo "     select vault.create_secret('<service_role>',  'service_role_key');"
echo "  2. pg_cron jobs aktif olur (0002_pg_cron migration ile)"
echo "  3. supabase studio → posts → draft kaliteyi gözden geçir"
echo "  4. publisher elle test:"
echo "     curl -X POST $FUNCTIONS_URL/publisher -H 'Authorization: Bearer <svc>' -d '{\"max\":3}'"
echo "  5. GitHub repo Settings → Secrets:"
echo "     INDEXNOW_KEY, VERCEL_DEPLOY_HOOK_URL, SEO_PUSH_TOKEN (PAT)"
echo "  6. /web/\$INDEXNOW_KEY.txt dosyasını oluştur (içerik = key)"
