import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./content/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        cosmic: {
          bg: "#0D0D1A",
          surface: "#1A1A2E",
          card: "#16213E",
          accent: "#FFD700",
          "accent-soft": "#FFE066",
          purple: "#7B2FBE",
          blue: "#0F3460",
          text: "#F5F5F5",
          muted: "#A0A0B0",
          border: "#2A2A4E",
        },
        zodiac: {
          fire: "#FF6B35",
          earth: "#4A7C59",
          air: "#87CEEB",
          water: "#4169E1",
        },
        // Astrobobo Web Pro — cinematic universe tokens.
        // Namespaced under `pro-*` so existing `cosmic-*` classes are untouched.
        pro: {
          void: "#05010A",
          deep: "#070A12",
          violet: "#7C3AED",
          "violet-soft": "#A78BFA",
          cyan: "#22D3EE",
          "cyan-soft": "#67E8F9",
          amber: "#F59E0B",
          glass: "rgba(255,255,255,0.06)",
          "glass-strong": "rgba(255,255,255,0.10)",
          stroke: "rgba(255,255,255,0.14)",
          text: "#F5F3FF",
          muted: "#94A3B8",
        },
      },
      fontFamily: {
        display: ["var(--font-display)", "serif"],
        body: ["var(--font-body)", "sans-serif"],
        pro: ["var(--font-pro-display)", "Space Grotesk", "Satoshi", "Inter", "sans-serif"],
      },
      backgroundImage: {
        "cosmic-gradient": "linear-gradient(135deg, #0D0D1A 0%, #1A1A2E 50%, #16213E 100%)",
        "card-gradient": "linear-gradient(180deg, rgba(123, 47, 190, 0.1) 0%, rgba(15, 52, 96, 0.1) 100%)",
        "accent-gradient": "linear-gradient(135deg, #FFD700 0%, #FFE066 100%)",
        "pro-void": "radial-gradient(ellipse at top, #0B0618 0%, #05010A 60%, #000 100%)",
        "pro-nebula":
          "radial-gradient(600px circle at var(--mx,50%) var(--my,50%), rgba(124,58,237,0.22), transparent 60%)",
        "pro-stroke":
          "linear-gradient(135deg, rgba(124,58,237,0.6) 0%, rgba(34,211,238,0.6) 100%)",
      },
      boxShadow: {
        "pro-glow-violet": "0 0 40px rgba(124,58,237,0.35), 0 0 80px rgba(124,58,237,0.15)",
        "pro-glow-cyan": "0 0 40px rgba(34,211,238,0.35), 0 0 80px rgba(34,211,238,0.15)",
        "pro-glow-amber": "0 0 40px rgba(245,158,11,0.35), 0 0 80px rgba(245,158,11,0.12)",
        "pro-depth":
          "0 30px 60px -20px rgba(0,0,0,0.7), 0 8px 24px -12px rgba(124,58,237,0.35)",
      },
      backdropBlur: {
        "pro-sm": "18px",
        "pro-md": "28px",
        "pro-lg": "48px",
      },
      transitionTimingFunction: {
        "pro-out": "cubic-bezier(0.22, 1, 0.36, 1)",
        "pro-in-out": "cubic-bezier(0.76, 0, 0.24, 1)",
      },
      animation: {
        "float": "float 6s ease-in-out infinite",
        "pulse-slow": "pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite",
        "shimmer": "shimmer 2s linear infinite",
        "pro-breathe": "pro-breathe 5.5s cubic-bezier(0.22, 1, 0.36, 1) infinite",
        "pro-orbit": "pro-orbit 22s linear infinite",
        "pro-charge": "pro-charge 0.9s cubic-bezier(0.22, 1, 0.36, 1) forwards",
        "pro-drift": "pro-drift 14s ease-in-out infinite",
      },
      keyframes: {
        float: {
          "0%, 100%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(-10px)" },
        },
        shimmer: {
          "0%": { backgroundPosition: "-200% 0" },
          "100%": { backgroundPosition: "200% 0" },
        },
        "pro-breathe": {
          "0%, 100%": { transform: "scale(1)", opacity: "0.85" },
          "50%": { transform: "scale(1.015)", opacity: "1" },
        },
        "pro-orbit": {
          "0%": { transform: "rotate(0deg)" },
          "100%": { transform: "rotate(360deg)" },
        },
        "pro-charge": {
          "0%": { boxShadow: "0 0 0 rgba(124,58,237,0)" },
          "100%": { boxShadow: "0 0 60px rgba(124,58,237,0.55)" },
        },
        "pro-drift": {
          "0%, 100%": { transform: "translate3d(0,0,0)" },
          "50%": { transform: "translate3d(8px,-12px,0)" },
        },
      },
    },
  },
  plugins: [],
};

export default config;
