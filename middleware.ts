import { NextRequest, NextResponse } from "next/server";
import { defaultLocale, locales } from "@/lib/i18n/config";

const PUBLIC_FILE = /\.(.*)$/;

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Skip public files, api routes, Next.js internals, the Pro universe
  // route, and SEO pre-rendered pages under /r/ (served as static HTML
  // from public/r/ via vercel.json rewrites).
  if (
    PUBLIC_FILE.test(pathname) ||
    pathname.startsWith("/api/") ||
    pathname.startsWith("/_next/") ||
    pathname === "/universe" ||
    pathname.startsWith("/universe/") ||
    pathname.startsWith("/r/") ||
    pathname.startsWith("/admin/")
  ) {
    return NextResponse.next();
  }

  // Check if pathname already has a locale prefix
  const pathnameHasLocale = locales.some(
    (locale) => pathname.startsWith(`/${locale}/`) || pathname === `/${locale}`
  );

  if (pathnameHasLocale) {
    return NextResponse.next();
  }

  // No locale prefix → rewrite to default locale (en) internally
  // This keeps URLs clean: astrobobo.com/zodiac/aries → internally /en/zodiac/aries
  return NextResponse.rewrite(
    new URL(`/${defaultLocale}${pathname}`, request.url)
  );
}

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|images|fonts|favicon.ico|manifest.json|.*\\..*).*)"],
};
