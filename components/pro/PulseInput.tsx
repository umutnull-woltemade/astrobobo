/**
 * PulseInput — alive input field. Idle pulse is subtle; focus elevates into
 * a breathing aura keyed off `motionIntensity`.
 */

"use client";

import { motion } from "framer-motion";
import { useState } from "react";
import { useMotionPhysics } from "@/lib/hooks/useMotionPhysics";

type PulseInputProps = {
  label?: string;
  placeholder?: string;
  value?: string;
  onChange?: (value: string) => void;
  id?: string;
  type?: "text" | "email" | "password";
};

export function PulseInput({
  label,
  placeholder,
  value,
  onChange,
  id,
  type = "text",
}: PulseInputProps) {
  const { spring, intensity } = useMotionPhysics();
  const [focused, setFocused] = useState(false);

  return (
    <motion.label
      className="relative block w-full"
      initial={false}
      animate={{
        y: focused ? -1 : 0,
      }}
      transition={spring}
    >
      {label ? (
        <span className="mb-2 block text-xs uppercase tracking-[0.18em] text-pro-muted">
          {label}
        </span>
      ) : null}
      <motion.div
        className="pro-glass pro-stroke-gradient relative rounded-2xl px-4 py-3"
        animate={{
          boxShadow: focused
            ? intensity === "charged"
              ? "0 0 40px rgba(34,211,238,0.45), 0 0 80px rgba(124,58,237,0.35)"
              : "0 0 24px rgba(34,211,238,0.30)"
            : "0 0 0 rgba(0,0,0,0)",
        }}
        transition={spring}
      >
        <input
          id={id}
          type={type}
          value={value}
          placeholder={placeholder}
          onChange={(e) => onChange?.(e.target.value)}
          onFocus={() => setFocused(true)}
          onBlur={() => setFocused(false)}
          className="w-full bg-transparent text-pro-text placeholder:text-pro-muted/60 outline-none"
        />
        <motion.span
          aria-hidden
          className="pointer-events-none absolute inset-0 rounded-2xl"
          animate={{
            opacity: focused ? [0.25, 0.65, 0.25] : 0,
          }}
          transition={{
            duration: 2.8,
            repeat: focused ? Infinity : 0,
            ease: "easeInOut",
          }}
          style={{
            background:
              "radial-gradient(circle at 50% 50%, rgba(34,211,238,0.18), transparent 70%)",
          }}
        />
      </motion.div>
    </motion.label>
  );
}
