"use client";
import { useEffect, useState } from "react";

interface VocData {
  now: string;
  moonSign: { name: string; symbol: string };
  nextSign: { name: string; symbol: string; changeAt: string };
  isVoidNow: boolean;
  voidStart: string;
  voidEnd: string;
}

function fmt(iso: string, locale: string) {
  return new Date(iso).toLocaleString(locale === "en" ? "en-US" : "tr-TR", { dateStyle: "medium", timeStyle: "short" });
}

export default function VoidOfCourseClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const [data, setData] = useState<VocData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/voc-moon?lang=${locale}`)
      .then((r) => r.json())
      .then(setData)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [locale]);

  if (loading) return <div className="text-center text-cosmic-muted py-8">{isEn ? "Scanning the Moon..." : "Ay taranıyor..."}</div>;
  if (!data) return <div className="text-center text-red-300">{isEn ? "Could not load." : "Yüklenemedi."}</div>;

  return (
    <div className="max-w-md mx-auto space-y-4">
      <div className={`cosmic-card text-center ${data.isVoidNow ? "bg-gradient-to-r from-slate-900/40 to-indigo-900/40 border-indigo-500/30" : ""}`}>
        <div className="text-4xl mb-2">{data.isVoidNow ? "🌑" : "🌙"}</div>
        <div className="text-lg font-display text-cosmic-accent">
          {data.isVoidNow ? (isEn ? "Moon is Void of Course" : "Ay Yörüngesiz") : (isEn ? "Moon is Active" : "Ay Aktif")}
        </div>
        <div className="text-sm text-cosmic-muted mt-2">
          {data.moonSign.symbol} {data.moonSign.name} → {data.nextSign.symbol} {data.nextSign.name}
        </div>
      </div>
      <div className="cosmic-card">
        <div className="text-xs uppercase tracking-wider text-cosmic-muted mb-2">{isEn ? "Void Window" : "Yörüngesiz Pencere"}</div>
        <div className="text-sm">
          <div><span className="text-cosmic-muted">{isEn ? "Start:" : "Başlangıç:"}</span> {fmt(data.voidStart, locale)}</div>
          <div><span className="text-cosmic-muted">{isEn ? "End:" : "Bitiş:"}</span> {fmt(data.voidEnd, locale)}</div>
        </div>
      </div>
      <p className="text-xs text-cosmic-muted text-center">
        {isEn
          ? "During void-of-course, traditional astrology suggests rest, reflection, minor tasks — not launches."
          : "Yörüngesiz dönemde gelenek: dinlenme, düşünme, küçük işler — büyük başlangıçlar değil."}
      </p>
    </div>
  );
}
