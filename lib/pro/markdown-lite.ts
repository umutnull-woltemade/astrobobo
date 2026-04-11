/**
 * Astrobobo Web Pro — tiny markdown parser.
 *
 * Purpose: lift the existing article corpus (plain markdown stored as
 * string fields) into a structured block list the Pro reader can render
 * with cinematic motion. We don't need a full CommonMark engine — the
 * articles use a curated subset (h1–h3, paragraphs, unordered lists,
 * blockquotes, and bold spans). Anything outside that set falls through
 * as a paragraph so we never drop content.
 *
 * Input contract: markdown as a string.
 * Output contract: ProBlock[], preserving authoring order.
 */

export type ProBlock =
  | { type: "h1"; text: string }
  | { type: "h2"; text: string }
  | { type: "h3"; text: string }
  | { type: "paragraph"; text: string }
  | { type: "quote"; text: string }
  | { type: "list"; items: string[] };

export function parseArticleMarkdown(raw: string): ProBlock[] {
  const blocks: ProBlock[] = [];
  const lines = raw.replace(/\r\n/g, "\n").split("\n");

  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    const trimmed = line.trimEnd();

    if (trimmed === "") {
      i++;
      continue;
    }

    // Headings
    if (trimmed.startsWith("### ")) {
      blocks.push({ type: "h3", text: trimmed.slice(4).trim() });
      i++;
      continue;
    }
    if (trimmed.startsWith("## ")) {
      blocks.push({ type: "h2", text: trimmed.slice(3).trim() });
      i++;
      continue;
    }
    if (trimmed.startsWith("# ")) {
      blocks.push({ type: "h1", text: trimmed.slice(2).trim() });
      i++;
      continue;
    }

    // Blockquote — one or more consecutive `> ` lines collapse to one quote.
    if (trimmed.startsWith("> ")) {
      const quoteLines: string[] = [];
      while (i < lines.length && lines[i].trimStart().startsWith("> ")) {
        quoteLines.push(lines[i].trimStart().slice(2).trim());
        i++;
      }
      blocks.push({ type: "quote", text: quoteLines.join(" ") });
      continue;
    }

    // Unordered list — `- ` or `* ` bullets. Consecutive items collapse.
    if (/^\s*[-*]\s+/.test(line)) {
      const items: string[] = [];
      while (i < lines.length && /^\s*[-*]\s+/.test(lines[i])) {
        items.push(lines[i].replace(/^\s*[-*]\s+/, "").trim());
        i++;
      }
      blocks.push({ type: "list", items });
      continue;
    }

    // Paragraph — gather consecutive non-empty lines.
    const paragraph: string[] = [trimmed];
    i++;
    while (
      i < lines.length &&
      lines[i].trim() !== "" &&
      !lines[i].startsWith("#") &&
      !lines[i].trimStart().startsWith("> ") &&
      !/^\s*[-*]\s+/.test(lines[i])
    ) {
      paragraph.push(lines[i].trim());
      i++;
    }
    blocks.push({ type: "paragraph", text: paragraph.join(" ") });
  }

  return blocks;
}

/**
 * Turn a single inline string into an array of (text | bold) spans.
 * Keeps the renderer free of `dangerouslySetInnerHTML`.
 */
export type InlineSpan = { type: "text" | "bold"; value: string };

export function parseInline(text: string): InlineSpan[] {
  const spans: InlineSpan[] = [];
  const pattern = /\*\*(.+?)\*\*/g;
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  while ((match = pattern.exec(text)) !== null) {
    if (match.index > lastIndex) {
      spans.push({ type: "text", value: text.slice(lastIndex, match.index) });
    }
    spans.push({ type: "bold", value: match[1] });
    lastIndex = match.index + match[0].length;
  }
  if (lastIndex < text.length) {
    spans.push({ type: "text", value: text.slice(lastIndex) });
  }
  return spans;
}
