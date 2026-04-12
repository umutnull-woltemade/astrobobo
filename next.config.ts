import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "standalone",

  // Pin the workspace root to this project so Next doesn't pick up the
  // stray ~/package-lock.json (unrelated Anthropic SDK experiment in the
  // home directory).
  outputFileTracingRoot: process.cwd(),

  images: {
    formats: ["image/avif", "image/webp"],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920],
    imageSizes: [16, 32, 48, 64, 96, 128, 256],
    minimumCacheTTL: 31536000,
    remotePatterns: [
      {
        protocol: "https",
        hostname: "astrobobo.com",
      },
    ],
  },

  headers: async () => [
    {
      source: "/(.*)",
      headers: [
        { key: "X-Content-Type-Options", value: "nosniff" },
        { key: "X-Frame-Options", value: "DENY" },
        { key: "X-XSS-Protection", value: "1; mode=block" },
        { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
      ],
    },
    {
      source: "/images/(.*)",
      headers: [
        {
          key: "Cache-Control",
          value: "public, max-age=31536000, immutable",
        },
      ],
    },
    {
      source: "/fonts/(.*)",
      headers: [
        {
          key: "Cache-Control",
          value: "public, max-age=31536000, immutable",
        },
      ],
    },
  ],

  redirects: async () => [
    {
      source: "/horoscope/:sign",
      destination: "/zodiac/:sign",
      permanent: true,
    },
    {
      source: "/burc/:sign",
      destination: "/tr/zodiac/:sign",
      permanent: true,
    },
    {
      source: "/en/:path*",
      destination: "/:path*",
      permanent: true,
    },
  ],

  // SEO article page rewrites are in vercel.json (platform-level),
  // NOT here — Next.js rewrites don't resolve public/ static files.

  experimental: {
    optimizePackageImports: ["fuse.js"],
  },
};

export default nextConfig;
