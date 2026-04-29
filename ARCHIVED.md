# ARCHIVED — astrobobo-web (legacy Next.js)

This repository is **archived** as of 2026-04-29.

## What this used to be

`astrobobo-web` was the original Next.js implementation of astrobobo.com. It hosted the public marketing/content surface and four ephemeris API endpoints:

- `/api/chart`
- `/api/transits`
- `/api/moon-sign`
- `/api/voc-moon`

## Where it went

The product is now a SvelteKit app at `~/astrobobo-platform`, deployed to `astrobobo.com` via Vercel project `web`.

All four ephemeris endpoints were ported to the platform on 2026-04-28 (`feat(api): port /voc-moon — last astrobobo-web dependency` and prior commits on the platform repo). After porting, no internal or external consumer depends on `astrobobo-web.vercel.app`.

## What you should do instead

| Old path | New home |
|---|---|
| `https://astrobobo-web.vercel.app/api/chart` | `https://astrobobo.com/api/chart` |
| `https://astrobobo-web.vercel.app/api/transits` | `https://astrobobo.com/api/transits` |
| `https://astrobobo-web.vercel.app/api/moon-sign` | `https://astrobobo.com/api/moon-sign` |
| `https://astrobobo-web.vercel.app/api/voc-moon` | `https://astrobobo.com/api/voc-moon` |
| Marketing / tools surface | `https://astrobobo.com/...` (see redirects in `astrobobo-platform/vercel.json`) |

## What was kept

The git history, source tree, and `.vercel` link are intentionally preserved for forensic reference. The Vercel project itself (if still attached) remains free on Hobby; remove it manually if/when desired.

## Do not commit here

New work belongs in `astrobobo-platform` (SvelteKit) or `astrobobo-content-engine` (insights pipeline). If you find yourself editing this repo, you are almost certainly in the wrong directory.
