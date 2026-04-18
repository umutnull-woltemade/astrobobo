"use client";
import { useCallback, useEffect, useState } from "react";
import BirthDataForm from "@/components/tools/birth-data-form";
import { useBirthData, birthDataQuery, type BirthData } from "@/lib/birth-data/store";

const COLORS: Record<string, string> = { fire: "#FF6B6B", earth: "#A8C66C", air: "#FFD93D", water: "#80DEEA" };
const NAMES: Record<string, Record<string, string>> = {
  fire: { en: "Fire", tr: "Ateş" }, earth: { en: "Earth", tr: "Toprak" },
  air: { en: "Air", tr: "Hava" }, water: { en: "Water", tr: "Su" },
};
const DESC_EN: Record<string, string> = {
  fire: "Action, courage, spark. Initiative and expression.",
  earth: "Body, stability, follow-through. Practical grounding.",
  air: "Mind, connection, ideas. Communication and perspective.",
  water: "Feeling, intuition, depth. Empathy and imagination.",
};
const DESC_TR: Record<string, string> = {
  fire: "Aksiyon, cesaret, kıvılcım. İnisiyatif ve ifade.",
  earth: "Beden, istikrar, takip. Pratik topraklanma.",
  air: "Zihin, bağlantı, fikirler. İletişim ve perspektif.",
  water: "Duygu, sezgi, derinlik. Empati ve hayal gücü.",
};

export default function ElementBalanceClient({ locale }: { locale: "en" | "tr" }) {
  const isEn = locale === "en";
  const { data: saved } = useBirthData();
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<{ counts: Record<string, number>; dominant: string } | null>(null);

  const calc = useCallback(async (d: BirthData) => {
    setLoading(true);
    try {
      const r = await fetch(`/api/chart?${birthDataQuery(d, locale)}`).then(r => r.json());
      setData({ counts: r.summary.elementBalance, dominant: r.summary.dominantElement });
    } catch {} finally { setLoading(false); }
  }, [locale]);

  useEffect(() => { if (saved && !data) calc(saved); /* eslint-disable-next-line */ }, []);

  const total = data ? Object.values(data.counts).reduce((a, b) => a + b, 0) : 0;

  return (
    <div className="space-y-8">
      <BirthDataForm locale={locale} onReady={calc} accent="rose" submitLabel={isEn ? "Calculate Balance" : "Dengeyi Hesapla"} />
      {loading && <div className="text-center text-cosmic-muted text-sm">...</div>}
      {data && (
        <div className="max-w-lg mx-auto space-y-4 animate-in fade-in">
          <div className="cosmic-card text-center">
            <div className="text-xs uppercase tracking-wider text-cosmic-muted">{isEn ? "Dominant Element" : "Baskın Element"}</div>
            <div className="text-3xl font-display mt-1" style={{ color: COLORS[data.dominant] }}>{NAMES[data.dominant]?.[locale]}</div>
          </div>
          <div className="space-y-2">
            {Object.entries(data.counts).map(([el, c]) => {
              const pct = total ? Math.round((c / total) * 100) : 0;
              return (
                <div key={el} className="cosmic-card">
                  <div className="flex justify-between items-center mb-2">
                    <div style={{ color: COLORS[el] }} className="font-semibold">{NAMES[el]?.[locale]}</div>
                    <div className="text-xs text-cosmic-muted">{c} · {pct}%</div>
                  </div>
                  <div className="h-2 rounded-full bg-white/[0.05] overflow-hidden">
                    <div className="h-full rounded-full transition-all" style={{ width: `${pct}%`, background: COLORS[el] }} />
                  </div>
                  <p className="text-xs text-cosmic-muted mt-2">{isEn ? DESC_EN[el] : DESC_TR[el]}</p>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
