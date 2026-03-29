import { NextResponse } from "next/server";
import { zodiacSigns } from "@/content/zodiac/signs";
import { articles } from "@/content/articles";
import { locales } from "@/lib/i18n/config";

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || "https://astrobobo.com";

export async function GET() {
  const now = new Date().toISOString().split("T")[0];

  const staticPages = [
    { path: "/", changefreq: "weekly", priority: "1.0" },
    { path: "/zodiac", changefreq: "weekly", priority: "0.9" },
    { path: "/articles", changefreq: "daily", priority: "0.9" },
    { path: "/privacy", changefreq: "yearly", priority: "0.3" },
    { path: "/terms", changefreq: "yearly", priority: "0.3" },
  ];

  const zodiacPages = zodiacSigns.map((s) => ({
    path: `/zodiac/${s.slug}`,
    changefreq: "weekly",
    priority: "0.8",
  }));

  const articlePages = articles.map((a) => ({
    path: `/articles/${a.slug}`,
    changefreq: "monthly",
    priority: "0.7",
    lastmod: a.publishedAt.split("T")[0],
  }));

  const allPages = [...staticPages, ...zodiacPages, ...articlePages];

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
${allPages
  .flatMap((p) =>
    locales.map((locale) => {
      const prefix = locale === "en" ? "" : `/${locale}`;
      const url = `${SITE_URL}${prefix}${p.path}`;
      const alternates = locales
        .map((l) => {
          const lPrefix = l === "en" ? "" : `/${l}`;
          return `    <xhtml:link rel="alternate" hreflang="${l}" href="${SITE_URL}${lPrefix}${p.path}"/>`;
        })
        .join("\n");
      return `  <url>
    <loc>${url}</loc>
    <lastmod>${("lastmod" in p && p.lastmod) || now}</lastmod>
    <changefreq>${p.changefreq}</changefreq>
    <priority>${p.priority}</priority>
${alternates}
  </url>`;
    })
  )
  .join("\n")}
</urlset>`;

  return new NextResponse(xml, {
    headers: {
      "Content-Type": "application/xml",
      "Cache-Control": "public, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}
