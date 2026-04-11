import { describe, expect, it } from "vitest";
import {
  parseArticleMarkdown,
  parseInline,
} from "@/lib/pro/markdown-lite";

describe("parseArticleMarkdown", () => {
  it("parses all block types from a canonical document", () => {
    const input = [
      "# Title",
      "",
      "## Section",
      "",
      "### Sub",
      "",
      "A paragraph.",
      "",
      "> first quote line",
      "> second quote line",
      "",
      "- alpha",
      "- beta",
      "- gamma",
      "",
      "Final paragraph.",
    ].join("\n");

    const blocks = parseArticleMarkdown(input);
    const types = blocks.map((b) => b.type);

    expect(types).toEqual([
      "h1",
      "h2",
      "h3",
      "paragraph",
      "quote",
      "list",
      "paragraph",
    ]);

    const h1 = blocks[0];
    if (h1.type === "h1") expect(h1.text).toBe("Title");

    const list = blocks[5];
    if (list.type === "list") {
      expect(list.items).toEqual(["alpha", "beta", "gamma"]);
    }

    const quote = blocks[4];
    if (quote.type === "quote") {
      expect(quote.text).toBe("first quote line second quote line");
    }
  });

  it("handles \\r\\n line endings", () => {
    const input = "# Title\r\n\r\nParagraph.\r\n";
    const blocks = parseArticleMarkdown(input);
    expect(blocks).toHaveLength(2);
    expect(blocks[0].type).toBe("h1");
    expect(blocks[1].type).toBe("paragraph");
  });

  it("collapses multi-line paragraphs into one", () => {
    const input = "line one\nline two\nline three";
    const blocks = parseArticleMarkdown(input);
    expect(blocks).toHaveLength(1);
    if (blocks[0].type === "paragraph") {
      expect(blocks[0].text).toBe("line one line two line three");
    }
  });

  it("treats bare `*` bullets as list items", () => {
    const input = "* one\n* two";
    const blocks = parseArticleMarkdown(input);
    expect(blocks).toHaveLength(1);
    if (blocks[0].type === "list") {
      expect(blocks[0].items).toEqual(["one", "two"]);
    }
  });

  it("never drops unknown content", () => {
    const input = "random line\nanother line";
    const blocks = parseArticleMarkdown(input);
    expect(blocks).toHaveLength(1);
    expect(blocks[0].type).toBe("paragraph");
  });
});

describe("parseInline", () => {
  it("splits text around **bold** spans", () => {
    const spans = parseInline("a **b** c");
    expect(spans).toEqual([
      { type: "text", value: "a " },
      { type: "bold", value: "b" },
      { type: "text", value: " c" },
    ]);
  });

  it("returns a single text span when no bold is present", () => {
    const spans = parseInline("plain text");
    expect(spans).toEqual([{ type: "text", value: "plain text" }]);
  });

  it("handles multiple bold spans", () => {
    const spans = parseInline("**a** and **b**");
    const bolds = spans.filter((s) => s.type === "bold").map((s) => s.value);
    expect(bolds).toEqual(["a", "b"]);
  });
});
