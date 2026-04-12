import { ImageResponse } from 'next/og';
import { NextRequest } from 'next/server';

export const runtime = 'edge';

const SIGN_GLYPHS: Record<string, { glyph: string; name: string; color: string }> = {
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

export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const title = (searchParams.get('title') || 'Astrobobo').slice(0, 80);
  const subtitle = (searchParams.get('subtitle') || 'Kişisel Kozmik Rehberiniz').slice(0, 120);
  const signKey = (searchParams.get('sign') || '').toLowerCase();
  const sign = SIGN_GLYPHS[signKey] || null;
  const accent = sign?.color || '#A78BFA';
  const glyph = sign?.glyph || '✨';

  return new ImageResponse(
    (
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          width: '100%',
          height: '100%',
          background: 'radial-gradient(ellipse at top, #1F1B3A 0%, #0D0D1A 60%, #000000 100%)',
          color: '#FFFFFF',
          fontFamily: 'sans-serif',
          padding: '80px',
          position: 'relative',
        }}
      >
        {/* Glow blob */}
        <div
          style={{
            position: 'absolute',
            top: -200,
            right: -200,
            width: 600,
            height: 600,
            borderRadius: 600,
            background: `radial-gradient(circle, ${accent}40 0%, ${accent}00 70%)`,
          }}
        />

        {/* Brand */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 20, marginBottom: 60 }}>
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              width: 72,
              height: 72,
              borderRadius: 72,
              background: 'linear-gradient(135deg, #A78BFA 0%, #7C3AED 100%)',
              fontSize: 40,
            }}
          >
            ✨
          </div>
          <div style={{ fontSize: 36, fontWeight: 300, letterSpacing: 6 }}>ASTROBOBO</div>
        </div>

        {/* Sign glyph */}
        {sign && (
          <div
            style={{
              fontSize: 240,
              color: accent,
              lineHeight: 1,
              marginBottom: 20,
              textShadow: `0 0 80px ${accent}99`,
            }}
          >
            {glyph}
          </div>
        )}

        {/* Title */}
        <div
          style={{
            fontSize: 80,
            fontWeight: 700,
            lineHeight: 1.1,
            marginBottom: 24,
            color: '#FFFFFF',
            maxWidth: 1040,
          }}
        >
          {title}
        </div>

        {/* Subtitle */}
        <div
          style={{
            fontSize: 36,
            fontWeight: 300,
            color: '#A0A0B8',
            maxWidth: 1040,
          }}
        >
          {subtitle}
        </div>

        {/* Footer */}
        <div
          style={{
            position: 'absolute',
            bottom: 60,
            left: 80,
            fontSize: 28,
            color: accent,
            fontWeight: 600,
            letterSpacing: 2,
          }}
        >
          astrobobo.com
        </div>
      </div>
    ),
    {
      width: 1200,
      height: 630,
      headers: {
        'Cache-Control': 'public, max-age=86400, s-maxage=604800',
      },
    }
  );
}
