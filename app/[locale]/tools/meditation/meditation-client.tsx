"use client";
import { useState, useEffect, useRef, useCallback } from "react";

const DURATIONS = [3, 5, 10, 15, 20];

export default function MeditationClient({ locale }: { locale: "en" | "tr" }) {
  const [duration, setDuration] = useState(5);
  const [remaining, setRemaining] = useState(0);
  const [active, setActive] = useState(false);
  const [done, setDone] = useState(false);
  const intervalRef = useRef<NodeJS.Timeout | null>(null);
  const isEn = locale === "en";

  const start = useCallback(() => {
    setRemaining(duration * 60);
    setActive(true);
    setDone(false);
  }, [duration]);

  const stop = useCallback(() => {
    setActive(false);
    if (intervalRef.current) clearInterval(intervalRef.current);
  }, []);

  useEffect(() => {
    if (!active) return;
    intervalRef.current = setInterval(() => {
      setRemaining(prev => {
        if (prev <= 1) {
          setActive(false);
          setDone(true);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => { if (intervalRef.current) clearInterval(intervalRef.current); };
  }, [active]);

  const mins = Math.floor(remaining / 60);
  const secs = remaining % 60;
  const progress = active || done ? 1 - remaining / (duration * 60) : 0;

  return (
    <div className="flex flex-col items-center gap-8">
      {!active && !done && (
        <div className="space-y-6 text-center">
          <div className="flex gap-3 justify-center">
            {DURATIONS.map(d => (
              <button key={d} onClick={() => setDuration(d)}
                className={`w-16 h-16 rounded-full text-lg font-display transition-all ${
                  duration === d
                    ? 'bg-purple-500/30 border-2 border-purple-500 text-white scale-110'
                    : 'bg-white/[0.04] border border-white/[0.1] text-cosmic-muted hover:border-purple-500/30'
                }`}>
                {d}
              </button>
            ))}
          </div>
          <div className="text-sm text-cosmic-muted">{isEn ? "minutes" : "dakika"}</div>
          <button onClick={start}
            className="px-12 py-4 rounded-full bg-gradient-to-r from-purple-600 to-indigo-700 text-white font-semibold text-lg transition-all hover:scale-105">
            {isEn ? "Begin" : "Başla"}
          </button>
        </div>
      )}

      {(active || done) && (
        <div className="text-center">
          {/* Breathing circle */}
          <div className="relative w-64 h-64 mx-auto mb-8">
            <svg viewBox="0 0 100 100" className="w-full h-full -rotate-90">
              <circle cx="50" cy="50" r="45" fill="none" stroke="rgba(255,255,255,0.06)" strokeWidth="2" />
              <circle cx="50" cy="50" r="45" fill="none" stroke="#a78bfa" strokeWidth="2"
                strokeDasharray={`${progress * 283} 283`}
                className="transition-all duration-1000" />
            </svg>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              {done ? (
                <>
                  <div className="text-4xl mb-2">🕊️</div>
                  <div className="text-lg font-display text-white">{isEn ? "Namaste" : "Namaste"}</div>
                </>
              ) : (
                <>
                  <div className="text-5xl font-display text-white tabular-nums">
                    {mins}:{secs.toString().padStart(2, '0')}
                  </div>
                  <div className="text-sm text-cosmic-muted mt-2 animate-pulse">
                    {isEn ? "breathe..." : "nefes al..."}
                  </div>
                </>
              )}
            </div>
          </div>

          {active && (
            <button onClick={stop}
              className="px-8 py-3 rounded-full bg-white/[0.06] border border-white/[0.12] text-cosmic-muted hover:text-white transition-all">
              {isEn ? "End Early" : "Erken Bitir"}
            </button>
          )}
          {done && (
            <button onClick={() => { setDone(false); setRemaining(0); }}
              className="px-8 py-3 rounded-full bg-purple-500/20 border border-purple-500/30 text-purple-300 transition-all">
              {isEn ? "Meditate Again" : "Tekrar Meditasyon"}
            </button>
          )}
        </div>
      )}
    </div>
  );
}
