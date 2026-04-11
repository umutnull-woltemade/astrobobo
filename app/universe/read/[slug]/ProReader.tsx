/**
 * ProReader — renders a parsed article in the Pro cinematic language.
 *
 * Each block gets staggered entrance via framer-motion's whileInView so the
 * article feels like it's being unveiled as you descend into it. Headings
 * become tone-aware eyebrows, blockquotes float as glass slabs, and lists
 * render as small QuantumCards.
 *
 * This is a client component because of framer-motion; it receives an
 * already-parsed block list from the server page so the heavy string
 * work never ships to the browser.
 */

"use client";

import { motion } from "framer-motion";
import { type ProBlock, type InlineSpan, parseInline } from "@/lib/pro/markdown-lite";
import { QuantumCard } from "@/components/pro/QuantumCard";
import { GravityScroll } from "@/components/pro/GravityScroll";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

type ProReaderProps = {
  title: string;
  description: string;
  readingTime: number;
  category: string;
  tags: string[];
  blocks: ProBlock[];
};

function Inline({ spans }: { spans: InlineSpan[] }) {
  return (
    <>
      {spans.map((span, i) =>
        span.type === "bold" ? (
          <strong key={i} className="text-pro-cyan">
            {span.value}
          </strong>
        ) : (
          <span key={i}>{span.value}</span>
        )
      )}
    </>
  );
}

function BlockRenderer({ block, index }: { block: ProBlock; index: number }) {
  const common = {
    initial: { opacity: 0, y: 32, filter: "blur(8px)" },
    whileInView: { opacity: 1, y: 0, filter: "blur(0px)" },
    viewport: { once: true, margin: "-80px" },
    transition: {
      duration: 0.9,
      ease: [0.22, 1, 0.36, 1] as const,
      delay: Math.min(index * 0.02, 0.2),
    },
  };

  switch (block.type) {
    case "h1":
      return (
        <motion.h1 {...common} className="pro-heading mb-6 mt-16 text-4xl md:text-5xl">
          {block.text}
        </motion.h1>
      );
    case "h2":
      return (
        <motion.h2
          {...common}
          className="pro-heading mb-5 mt-14 text-2xl md:text-3xl"
        >
          {block.text}
        </motion.h2>
      );
    case "h3":
      return (
        <motion.h3
          {...common}
          className="mb-3 mt-10 font-pro text-xl text-pro-cyan-soft"
        >
          {block.text}
        </motion.h3>
      );
    case "paragraph":
      return (
        <motion.p
          {...common}
          className="mb-5 text-base leading-[1.85] text-pro-text/85"
        >
          <Inline spans={parseInline(block.text)} />
        </motion.p>
      );
    case "quote":
      return (
        <motion.div {...common} className="my-8" data-pro-node={`quote-${index}`}>
          <QuantumCard glow="cyan" className="text-center">
            <p className="font-pro text-lg italic leading-relaxed text-pro-text/95">
              “<Inline spans={parseInline(block.text)} />”
            </p>
          </QuantumCard>
        </motion.div>
      );
    case "list":
      return (
        <motion.ul {...common} className="mb-6 space-y-2.5">
          {block.items.map((item, i) => (
            <li key={i} className="flex gap-3 text-pro-text/85">
              <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-pro-violet-soft" />
              <span className="leading-relaxed">
                <Inline spans={parseInline(item)} />
              </span>
            </li>
          ))}
        </motion.ul>
      );
  }
}

export function ProReader({
  title,
  description,
  readingTime,
  category,
  tags,
  blocks,
}: ProReaderProps) {
  const { spring } = useMotionPhysics();

  return (
    <article className="relative mx-auto max-w-3xl px-6 pt-24 pb-32">
      <motion.header
        initial={{ opacity: 0, y: 24 }}
        animate={{ opacity: 1, y: 0 }}
        transition={spring}
        className="mb-16 text-center"
      >
        <p className="mb-3 text-xs uppercase tracking-[0.4em] text-pro-cyan">
          {category} · {readingTime} min
        </p>
        <h1 className="pro-heading text-4xl leading-[1.1] md:text-6xl">{title}</h1>
        <p className="mx-auto mt-6 max-w-xl text-pro-text/70">{description}</p>
        <div className="mt-8 flex flex-wrap justify-center gap-2">
          {tags.slice(0, 6).map((tag) => (
            <span
              key={tag}
              className="pro-glass rounded-full px-3 py-1 text-[0.7rem] uppercase tracking-wider text-pro-text/75"
              data-pro-node={`tag-${tag}`}
            >
              {tag}
            </span>
          ))}
        </div>
      </motion.header>

      <GravityScroll depth={60}>
        <div className="relative">
          {blocks.map((block, i) => (
            <BlockRenderer key={i} block={block} index={i} />
          ))}
        </div>
      </GravityScroll>
    </article>
  );
}
