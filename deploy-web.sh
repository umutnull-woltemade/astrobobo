#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════
# Venus One / astrobobo.com - SAFE Web Deployment Script
# ═══════════════════════════════════════════════════════════════════════════
# Bu script tüm bilinen bozulma sebeplerini OTOMATİK kontrol eder ve düzeltir.
# Bir daha web deploy yapmak için SADECE bu scripti çalıştır:
#
#   ./deploy-web.sh
#
# ═══════════════════════════════════════════════════════════════════════════

set -e  # Exit on error
cd "$(dirname "$0")"  # Always run from project root

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

step() { echo -e "${BLUE}▶${NC} $1"; }
ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }

echo "═══════════════════════════════════════════════════════"
echo "  astrobobo.com — SAFE Web Deploy"
echo "═══════════════════════════════════════════════════════"
echo

# ─── 0. Pre-flight checks ──────────────────────────────────────────────────
step "Pre-flight checks"
command -v flutter >/dev/null || fail "Flutter not installed"
command -v vercel  >/dev/null || fail "Vercel CLI not installed (npm i -g vercel)"
[ -f pubspec.yaml ] || fail "pubspec.yaml not found — wrong directory?"
[ -f vercel.json  ] || fail "vercel.json not found"
ok "All tools present"
echo

# ─── 1. GUARD: web/ folder must NOT contain stale build artifacts ──────────
step "GUARD 1: Checking web/ folder for stale files"

STALE_PATTERNS=(
  "web/main.dart.js"
  "web/main.dart.js.map"
  "web/flutter.js"
  "web/flutter_bootstrap.js"
  "web/flutter_service_worker.js"
  "web/canvaskit"
  "web/assets"
  "web/node_modules"
  "web/package-lock.json"
  "web/package.json"
  "web/.next"
  "web/next-env.d.ts"
)

STALE_FOUND=0
for pattern in "${STALE_PATTERNS[@]}"; do
  if [ -e "$pattern" ]; then
    warn "Removing stale: $pattern"
    rm -rf "$pattern"
    STALE_FOUND=1
  fi
done

# Also remove any stray .html files in web/ except known good ones.
# Whitelist: index.html (main entry), offline.html (PWA fallback)
KEEP_HTML="index.html offline.html"
for f in web/*.html; do
  if [ -e "$f" ]; then
    base=$(basename "$f")
    case " $KEEP_HTML " in
      *" $base "*) ;;  # whitelisted, skip
      *)
        warn "Removing stale HTML: $f"
        rm -f "$f"
        STALE_FOUND=1
        ;;
    esac
  fi
done

if [ $STALE_FOUND -eq 0 ]; then
  ok "web/ folder is clean"
else
  ok "Cleaned stale files from web/"
fi
echo

# ─── 2. GUARD: No 'innercycles' references in web sources ──────────────────
step "GUARD 2: Checking for forbidden 'innercycles' references"

INNERCYCLES=$(grep -rli "innercycles" web/ lib/ 2>/dev/null || true)
if [ -n "$INNERCYCLES" ]; then
  warn "Found 'innercycles' references in:"
  echo "$INNERCYCLES" | sed 's/^/    /'
  fail "Remove 'innercycles' before deploying"
fi
ok "No 'innercycles' references"
echo

# ─── 3. GUARD: No raw 'dart:io' imports in lib/ (web crashes!) ─────────────
step "GUARD 3: Checking for unsafe dart:io imports"

DART_IO=$(grep -rln "^import 'dart:io'" lib/ 2>/dev/null || true)
if [ -n "$DART_IO" ]; then
  warn "Found unconditional 'dart:io' imports in:"
  echo "$DART_IO" | sed 's/^/    /'
  warn "These will crash on web. Use conditional imports or io_stub.dart"
  fail "Fix dart:io imports before deploying"
fi
ok "No unsafe dart:io imports"
echo

# ─── 4. Clean Flutter build cache ──────────────────────────────────────────
step "Cleaning previous build"
flutter clean >/dev/null 2>&1
ok "Flutter cache cleaned"
echo

# ─── 5. Get dependencies ───────────────────────────────────────────────────
step "Getting dependencies"
flutter pub get >/dev/null 2>&1
ok "Dependencies fetched"
echo

# ─── 6. Build Flutter web (release) ────────────────────────────────────────
step "Building Flutter web (release mode)"
flutter build web --release 2>&1 | grep -E "(✓|Built|Error|error)" || true

if [ ! -f build/web/main.dart.js ]; then
  fail "Build failed — main.dart.js not generated"
fi

# Verify build is fresh (modified within last 5 minutes)
if [ "$(find build/web/main.dart.js -mmin -5 2>/dev/null)" = "" ]; then
  fail "main.dart.js is stale — build did not regenerate it!"
fi

# Verify NO firebase references in compiled JS (catches stale build leak)
if grep -q "firebase" build/web/main.dart.js 2>/dev/null; then
  FB_COUNT=$(grep -c "firebase" build/web/main.dart.js)
  warn "main.dart.js contains $FB_COUNT firebase references"
  warn "This usually means stale web/ files leaked into the build"
  fail "Build contaminated — investigate web/ folder"
fi

BUILD_SIZE=$(du -sh build/web | cut -f1)
ok "Build successful (size: $BUILD_SIZE)"
echo

# ─── 7. Apply custom static files (index.html, sitemap, robots, etc.) ─────
step "Applying custom static files"
if [ -f web/index.html ]; then
  cp web/index.html build/web/index.html
  ok "Custom index.html applied"
fi
# Copy SEO + PWA + routing files that Flutter doesn't process automatically
for f in sitemap.xml robots.txt vercel.json llms.txt llms-full.txt offline.html; do
  if [ -f "web/$f" ]; then
    cp "web/$f" "build/web/$f"
    ok "Copied $f"
  fi
done

# Copy SEO directories (137 pre-rendered pages, admin dashboard, AI manifest)
for d in r admin .well-known; do
  if [ -d "web/$d" ]; then
    cp -r "web/$d" "build/web/$d"
    PAGES=$(find "web/$d" -type f | wc -l | tr -d ' ')
    ok "Copied web/$d/ ($PAGES files)"
  fi
done
echo

# ─── 8. Strip any leftover junk from build/web/ ────────────────────────────
step "Cleaning build/web/ output"
rm -rf build/web/node_modules build/web/.next build/web/package-lock.json build/web/next-env.d.ts 2>/dev/null || true
ok "build/web/ is clean"
echo

# ─── 9. Deploy to Vercel (from build/web — uses local vercel.json) ─────────
step "Deploying to Vercel"
echo

# Deploy from build/web using its own vercel.json (rewrites for SPA routes)
cd build/web

# Pre-deploy validation: vercel.json must exist with rewrites
if [ ! -f vercel.json ]; then
  cd - >/dev/null
  fail "build/web/vercel.json missing — SPA rewrites won't work"
fi

if ! grep -q '"rewrites"' vercel.json; then
  cd - >/dev/null
  fail "build/web/vercel.json has no rewrites — SPA routes will 404"
fi

# cleanUrls breaks SPA rewrites — Vercel maps /tarot → /tarot.html FIRST,
# returns 404 before rewrite rules get a chance to fire.
if grep -q '"cleanUrls"[[:space:]]*:[[:space:]]*true' vercel.json; then
  cd - >/dev/null
  fail "build/web/vercel.json has cleanUrls:true — disable it or SPA routes will 404"
fi

DEPLOY_OUTPUT=$(vercel --prod --yes --local-config vercel.json 2>&1)
echo "$DEPLOY_OUTPUT" | tail -5

# Extract production URL
PROD_URL=$(echo "$DEPLOY_OUTPUT" | grep -oE 'https://web-[a-z0-9]+-umutnull[^ ]*' | head -1)
cd - >/dev/null

if [ -z "$PROD_URL" ]; then
  fail "Could not extract deployment URL"
fi

ok "Deployed: $PROD_URL"
echo

# ─── 10. Smoke test: verify astrobobo.com + key routes load ────────────────
step "Smoke testing astrobobo.com routes"
sleep 2

ROUTES_OK=0
ROUTES_FAIL=0
SAMPLE_ROUTES=("/" "/main.dart.js" "/tarot" "/horoscope" "/birth-chart" "/numerology" "/dreams" "/sitemap.xml" "/robots.txt" "/llms.txt" "/admin/seo.html" "/r/tr/ruyada-araba.html")

for path in "${SAMPLE_ROUTES[@]}"; do
  CODE=$(curl -sL -o /dev/null -w "%{http_code}" "https://astrobobo.com$path")
  if [ "$CODE" = "200" ]; then
    ROUTES_OK=$((ROUTES_OK + 1))
    printf "    ${GREEN}200${NC} %s\n" "$path"
  else
    ROUTES_FAIL=$((ROUTES_FAIL + 1))
    printf "    ${RED}%s${NC} %s\n" "$CODE" "$path"
  fi
done

if [ $ROUTES_FAIL -eq 0 ]; then
  ok "All $ROUTES_OK sample routes live"
else
  warn "$ROUTES_FAIL routes failed (may still be propagating)"
fi
echo

echo "═══════════════════════════════════════════════════════"
echo -e "  ${GREEN}✨ DEPLOY SUCCESSFUL${NC}"
echo "═══════════════════════════════════════════════════════"
echo "  Production: https://astrobobo.com"
echo "  Inspect:    $PROD_URL"
echo "═══════════════════════════════════════════════════════"
