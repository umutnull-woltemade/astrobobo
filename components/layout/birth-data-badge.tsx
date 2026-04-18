"use client";
import { useState } from "react";
import { useBirthData } from "@/lib/birth-data/store";

export default function BirthDataBadge({ isEn, localePath }: { isEn: boolean; localePath: string }) {
  const { data, clear } = useBirthData();
  const [open, setOpen] = useState(false);
  if (!data) return null;

  return (
    <div className="relative">
      <button
        onClick={() => setOpen((o) => !o)}
        className="hidden md:inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-purple-500/10 border border-purple-500/30 text-[11px] text-purple-200 hover:bg-purple-500/20 transition-colors"
        title={isEn ? "Your saved birth data" : "Kayıtlı doğum verin"}
      >
        <span>✨</span>
        <span className="truncate max-w-[140px]">{data.placeName}</span>
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-40" onClick={() => setOpen(false)} />
          <div className="absolute right-0 top-full mt-2 w-64 rounded-xl border border-white/[0.12] bg-[#0f0d1a] shadow-xl z-50 p-3">
            <div className="text-[10px] uppercase tracking-wider text-cosmic-muted mb-1">{isEn ? "Saved Birth Data" : "Kayıtlı Doğum Verisi"}</div>
            <div className="text-xs text-white">{data.placeName}</div>
            <div className="text-xs text-cosmic-muted">{data.date} · {data.time}</div>
            <div className="text-[10px] text-cosmic-muted mt-0.5">{data.tz}</div>
            <div className="flex gap-2 mt-3">
              <a href={`${localePath}/tools/birth-chart`} className="flex-1 text-center px-2 py-1.5 rounded-lg bg-purple-500/20 text-purple-100 text-xs font-medium hover:bg-purple-500/30">
                {isEn ? "Change" : "Değiştir"}
              </a>
              <button
                onClick={() => { clear(); setOpen(false); }}
                className="flex-1 px-2 py-1.5 rounded-lg bg-white/[0.05] text-cosmic-muted text-xs hover:text-white hover:bg-white/[0.08]"
              >
                {isEn ? "Clear" : "Sil"}
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
