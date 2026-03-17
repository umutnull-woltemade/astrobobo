import { NextResponse } from "next/server";

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || "https://astrobobo.com";

export async function GET() {
  const robots = `User-agent: *
Allow: /
Disallow: /api/
Disallow: /_next/

Sitemap: ${SITE_URL}/sitemap.xml
`;

  return new NextResponse(robots, {
    headers: { "Content-Type": "text/plain" },
  });
}
