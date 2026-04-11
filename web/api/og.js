// ═══════════════════════════════════════════════════════════════════════════
// Dynamic Open Graph image generator
// Vercel Edge Function — runs on the edge, no cold start.
//
// Usage:  /api/og?title=Yengeç+Burcu&subtitle=Günlük+Yorum&sign=cancer
//
// Returns: 1200x630 PNG (the canonical OG image size).
// Cached: 24h public, immutable per query string.
// ═══════════════════════════════════════════════════════════════════════════

import { ImageResponse } from '@vercel/og';

export const config = { runtime: 'edge' };

const SIGN_GLYPHS = {
  aries:       { glyph: '♈', name: 'Koç',     color: '#FF6B6B' },
  taurus:      { glyph: '♉', name: 'Boğa',    color: '#A8C66C' },
  gemini:      { glyph: '♊', name: 'İkizler', color: '#FFD93D' },
  cancer:      { glyph: '♋', name: 'Yengeç',  color: '#80DEEA' },
  leo:         { glyph: '♌', name: 'Aslan',   color: '#FFA726' },
  virgo:       { glyph: '♍', name: 'Başak',   color: '#9CCC65' },
  libra:       { glyph: '♎', name: 'Terazi',  color: '#F06292' },
  scorpio:     { glyph: '♏', name: 'Akrep',   color: '#7E57C2' },
  sagittarius: { glyph: '♐', name: 'Yay',     color: '#FF7043' },
  capricorn:   { glyph: '♑', name: 'Oğlak',   color: '#8D6E63' },
  aquarius:    { glyph: '♒', name: 'Kova',    color: '#42A5F5' },
  pisces:      { glyph: '♓', name: 'Balık',   color: '#26C6DA' },
};

export default function handler(req) {
  const { searchParams } = new URL(req.url);
  const title = (searchParams.get('title') || 'Venus One').slice(0, 80);
  const subtitle = (searchParams.get('subtitle') || 'Kişisel Kozmik Rehberiniz').slice(0, 120);
  const signKey = (searchParams.get('sign') || '').toLowerCase();
  const sign = SIGN_GLYPHS[signKey] || null;
  const accent = sign?.color || '#FFD700';
  const glyph = sign?.glyph || '✨';

  return new ImageResponse(
    {
      type: 'div',
      props: {
        style: {
          display: 'flex',
          flexDirection: 'column',
          width: '100%',
          height: '100%',
          background: 'radial-gradient(ellipse at top, #1F1B3A 0%, #0D0D1A 60%, #000000 100%)',
          color: '#FFFFFF',
          fontFamily: 'sans-serif',
          padding: '80px',
          position: 'relative',
        },
        children: [
          // Decorative purple glow blob (top-right)
          {
            type: 'div',
            props: {
              style: {
                position: 'absolute',
                top: -200,
                right: -200,
                width: 600,
                height: 600,
                borderRadius: 600,
                background: `radial-gradient(circle, ${accent}40 0%, ${accent}00 70%)`,
              },
            },
          },
          // Brand row
          {
            type: 'div',
            props: {
              style: { display: 'flex', alignItems: 'center', gap: 20, marginBottom: 60 },
              children: [
                {
                  type: 'div',
                  props: {
                    style: {
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      width: 72,
                      height: 72,
                      borderRadius: 72,
                      background: 'linear-gradient(135deg, #667EEA 0%, #764BA2 100%)',
                      fontSize: 40,
                    },
                    children: '✨',
                  },
                },
                {
                  type: 'div',
                  props: {
                    style: { fontSize: 36, fontWeight: 300, letterSpacing: 6 },
                    children: 'VENUS ONE',
                  },
                },
              ],
            },
          },
          // Big sign glyph (if applicable)
          sign && {
            type: 'div',
            props: {
              style: {
                fontSize: 240,
                color: accent,
                lineHeight: 1,
                marginBottom: 20,
                textShadow: `0 0 80px ${accent}99`,
              },
              children: glyph,
            },
          },
          // Title
          {
            type: 'div',
            props: {
              style: {
                fontSize: 80,
                fontWeight: 700,
                lineHeight: 1.1,
                marginBottom: 24,
                color: '#FFFFFF',
                maxWidth: 1040,
              },
              children: title,
            },
          },
          // Subtitle
          {
            type: 'div',
            props: {
              style: {
                fontSize: 36,
                fontWeight: 300,
                color: '#A0A0B8',
                maxWidth: 1040,
              },
              children: subtitle,
            },
          },
          // Footer URL
          {
            type: 'div',
            props: {
              style: {
                position: 'absolute',
                bottom: 60,
                left: 80,
                fontSize: 28,
                color: accent,
                fontWeight: 600,
                letterSpacing: 2,
              },
              children: 'astrobobo.com',
            },
          },
        ].filter(Boolean),
      },
    },
    {
      width: 1200,
      height: 630,
      headers: {
        'Cache-Control': 'public, max-age=86400, s-maxage=86400, immutable',
      },
    }
  );
}
