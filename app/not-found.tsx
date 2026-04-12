import Link from 'next/link';

export default function NotFound() {
  return (
    <html lang="en" className="dark">
      <body style={{
        margin: 0,
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: 'radial-gradient(ellipse at top, #1F1B3A 0%, #0D0D1A 60%, #000 100%)',
        fontFamily: '-apple-system, BlinkMacSystemFont, sans-serif',
        color: '#f5f0e6',
      }}>
        <div style={{ textAlign: 'center', padding: '48px 24px', maxWidth: 480 }}>
          <div style={{ fontSize: 80, marginBottom: 16, opacity: 0.7 }}>🔮</div>
          <h1 style={{
            fontSize: 64,
            fontWeight: 800,
            margin: '0 0 8px',
            background: 'linear-gradient(135deg, #a78bfa, #7c3aed)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
          }}>
            404
          </h1>
          <p style={{ fontSize: 18, color: '#c8c2d6', margin: '0 0 8px' }}>
            Page not found
          </p>
          <p style={{ fontSize: 14, color: '#9b94aa', margin: '0 0 32px' }}>
            The stars couldn&apos;t find what you&apos;re looking for.
          </p>
          <div style={{ display: 'flex', gap: 12, justifyContent: 'center', flexWrap: 'wrap' }}>
            <Link
              href="/"
              style={{
                display: 'inline-block',
                padding: '14px 32px',
                background: 'linear-gradient(135deg, #a78bfa, #7c3aed)',
                color: 'white',
                borderRadius: 12,
                textDecoration: 'none',
                fontWeight: 600,
                fontSize: 15,
              }}
            >
              Go Home
            </Link>
            <Link
              href="/r/en"
              style={{
                display: 'inline-block',
                padding: '14px 32px',
                background: 'rgba(255,255,255,0.06)',
                border: '1px solid rgba(255,255,255,0.12)',
                color: '#c8c2d6',
                borderRadius: 12,
                textDecoration: 'none',
                fontWeight: 500,
                fontSize: 15,
              }}
            >
              Dream Dictionary
            </Link>
          </div>
        </div>
      </body>
    </html>
  );
}
