/** JSON-LD BreadcrumbList for tool pages — invisible, SEO-only. */
export default function ToolBreadcrumbs({ toolName, toolSlug, locale }: { toolName: string; toolSlug: string; locale: string }) {
  const isEn = locale === "en";
  const prefix = isEn ? "" : `/${locale}`;
  const data = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Astrobobo", item: "https://astrobobo.com" + (isEn ? "/" : `/${locale}`) },
      { "@type": "ListItem", position: 2, name: isEn ? "Tools" : "Araçlar", item: `https://astrobobo.com${prefix}/tools` },
      { "@type": "ListItem", position: 3, name: toolName, item: `https://astrobobo.com${prefix}/tools/${toolSlug}` },
    ],
  };
  return <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }} />;
}
