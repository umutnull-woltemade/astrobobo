"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

export default function MoonSignClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<any>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/moon-sign?${birthDataQuery(d, locale)}`);
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setResult(data);
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (saved && !result) calc(saved); /* eslint-disable-next-line */ }, []);

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calc} submitLabel={isEn ? "Find My Moon Sign" : "Ay Burcumu Bul"} />
      {loading && <div className="text-center text-cosmic-muted text-sm">{isEn ? "Calculating..." : "Hesaplanıyor..."}</div>}
      {result?.moon && (
        <div className="max-w-md mx-auto animate-in fade-in text-center space-y-4">
          <div className="text-7xl">🌙</div>
          <div>
            <div className="text-xs uppercase tracking-wider text-cosmic-muted">{isEn ? "Your Moon Sign" : "Ay Burcun"}</div>
            <div className="text-4xl font-display mt-1">{result.moon.symbol}</div>
            <div className="text-2xl font-display text-cosmic-accent">{result.moon.sign}</div>
            <div className="text-sm text-cosmic-muted">{result.moon.degree}°</div>
          </div>
          {result.meaning && (
            <div className="cosmic-card bg-gradient-to-r from-indigo-900/20 to-purple-900/20 border-indigo-500/20">
              <p className="text-sm text-cosmic-text/80 leading-relaxed">{result.meaning}</p>
            </div>
          )}
          <div className="text-xs text-cosmic-muted">
            {isEn
              ? "Note: The Moon changes signs every ~2.5 days. If born near a sign boundary, exact birth time matters."
              : "Not: Ay her ~2.5 günde burç değiştirir. Sınır yakınında doğduysanız kesin saat önemlidir."}
          </div>
        </div>
      )}
      <p className="text-xs text-cosmic-muted text-center">{isEn ? "Swiss Ephemeris precision." : "Swiss Ephemeris hassasiyeti."}</p>
    </div>
  );
}
