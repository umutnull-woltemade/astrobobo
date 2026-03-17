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
      },
      fontFamily: {
        display: ["var(--font-display)", "serif"],
        body: ["var(--font-body)", "sans-serif"],
      },
      backgroundImage: {
        "cosmic-gradient": "linear-gradient(135deg, #0D0D1A 0%, #1A1A2E 50%, #16213E 100%)",
        "card-gradient": "linear-gradient(180deg, rgba(123, 47, 190, 0.1) 0%, rgba(15, 52, 96, 0.1) 100%)",
        "accent-gradient": "linear-gradient(135deg, #FFD700 0%, #FFE066 100%)",
      },
      animation: {
        "float": "float 6s ease-in-out infinite",
        "pulse-slow": "pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite",
        "shimmer": "shimmer 2s linear infinite",
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
      },
    },
  },
  plugins: [],
};

export default config;
