"use client";
import { useEffect, useRef, useState } from "react";
import { useBirthData, type BirthData } from "@/lib/birth-data/store";
import { searchPlaces, type PlaceResult } from "@/lib/birth-data/geocode";

interface Props {
  locale: "en" | "tr";
  /** Called with valid data whenever user submits or reuses saved. */
  onReady: (d: BirthData) => void;
  /** Visual accent color class suffix, e.g. "purple" (default), "amber", "orange". */
  accent?: string;
  /** Compact pill mode when we already have saved data. Default true. */
  allowCollapsed?: boolean;
  /** Optional override button label. */
  submitLabel?: string;
  /** If false, don't read or write the global saved birth data (e.g. Person 2). Default true. */
  useSavedStore?: boolean;
}

export default function BirthDataForm({ locale, onReady, accent = "purple", allowCollapsed = true, submitLabel, useSavedStore = true }: Props) {
  const store = useBirthData();
  const saved = useSavedStore ? store.data : null;
  const save = useSavedStore ? store.set : (_d: BirthData) => {};
  const clear = useSavedStore ? store.clear : () => {};
  const isEn = locale === "en";
  const [expanded, setExpanded] = useState(!saved || !allowCollapsed);
  const [date, setDate] = useState(saved?.date || "");
  const [time, setTime] = useState(saved?.time || "12:00");
  const [placeQuery, setPlaceQuery] = useState(saved?.placeName || "");
  const [place, setPlace] = useState<PlaceResult | null>(
    saved ? { lat: saved.lat, lng: saved.lng, tz: saved.tz, placeName: saved.placeName } : null
  );
  const [results, setResults] = useState<PlaceResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [remember, setRemember] = useState(useSavedStore);
  const abortRef = useRef<AbortController | null>(null);

  // Debounced place search
  useEffect(() => {
    if (!placeQuery || place?.placeName === placeQuery) {
      setResults([]);
      return;
    }
    const t = setTimeout(async () => {
      abortRef.current?.abort();
      const ctl = new AbortController();
      abortRef.current = ctl;
      setSearching(true);
      try {
        const r = await searchPlaces(placeQuery, ctl.signal);
        setResults(r);
      } catch {
        /* ignore */
      } finally {
        setSearching(false);
      }
    }, 400);
    return () => clearTimeout(t);
  }, [placeQuery, place?.placeName]);

  function submit() {
    if (!date || !time || !place) return;
    const payload: BirthData = {
      date,
      time,
      lat: place.lat,
      lng: place.lng,
      tz: place.tz,
      placeName: place.placeName,
    };
    if (remember) save(payload);
    onReady(payload);
    setExpanded(false);
  }

  // Collapsed reuse banner
  if (allowCollapsed && saved && !expanded) {
    return (
      <div className="cosmic-card max-w-sm mx-auto flex items-center justify-between gap-3">
        <div className="text-left text-xs">
          <div className="text-cosmic-muted uppercase tracking-wider mb-0.5">{isEn ? "Using" : "Kullanılan"}</div>
          <div className="text-white">
            {saved.placeName} · {saved.date} {saved.time}
          </div>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => onReady(saved)}
            className="px-3 py-2 rounded-lg bg-gradient-to-r from-purple-600 to-purple-800 text-white text-xs font-semibold"
          >
            {isEn ? "Use" : "Kullan"}
          </button>
          <button
            onClick={() => setExpanded(true)}
            className="px-3 py-2 rounded-lg bg-white/[0.06] text-cosmic-muted text-xs hover:text-white"
          >
            {isEn ? "Change" : "Değiştir"}
          </button>
        </div>
      </div>
    );
  }

  const ACCENTS: Record<string, { btn: string; focus: string }> = {
    purple: { btn: "from-purple-600 to-purple-800", focus: "focus:border-purple-500" },
    amber: { btn: "from-amber-700 to-amber-900", focus: "focus:border-amber-500" },
    orange: { btn: "from-orange-600 to-amber-700", focus: "focus:border-orange-500" },
    rose: { btn: "from-rose-600 to-rose-800", focus: "focus:border-rose-500" },
    teal: { btn: "from-teal-600 to-teal-800", focus: "focus:border-teal-500" },
  };
  const A = ACCENTS[accent] || ACCENTS.purple;
  const btnClass = `w-full mt-4 px-6 py-3 rounded-xl bg-gradient-to-r ${A.btn} text-white font-semibold disabled:opacity-40 transition-all`;
  const inputClass = `w-full px-3 py-2.5 rounded-xl bg-white/[0.05] border border-white/[0.12] text-white ${A.focus} focus:outline-none text-sm`;

  return (
    <div className="cosmic-card max-w-lg mx-auto">
      <div className="grid grid-cols-2 gap-3">
        <div>
          <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
            {isEn ? "Birth Date" : "Doğum Tarihi"}
          </label>
          <input type="date" value={date} onChange={(e) => setDate(e.target.value)} className={inputClass} max={new Date().toISOString().split("T")[0]} />
        </div>
        <div>
          <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
            {isEn ? "Birth Time" : "Doğum Saati"}
          </label>
          <input type="time" value={time} onChange={(e) => setTime(e.target.value)} className={inputClass} />
        </div>
        <div className="col-span-2 relative">
          <label className="block text-xs text-cosmic-muted mb-1 uppercase tracking-wider">
            {isEn ? "Birth Place" : "Doğum Yeri"}
          </label>
          <input
            type="text"
            value={placeQuery}
            onChange={(e) => {
              setPlaceQuery(e.target.value);
              setPlace(null);
            }}
            placeholder={isEn ? "e.g. Istanbul, Türkiye" : "örn. İstanbul, Türkiye"}
            className={inputClass}
            autoComplete="off"
          />
          {searching && <div className="absolute right-3 top-9 text-xs text-cosmic-muted">…</div>}
          {results.length > 0 && !place && (
            <div className="absolute z-20 left-0 right-0 mt-1 max-h-56 overflow-y-auto rounded-xl border border-white/[0.12] bg-[#0f0d1a] shadow-xl">
              {results.map((r, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setPlace(r);
                    setPlaceQuery(r.placeName);
                    setResults([]);
                  }}
                  className="block w-full text-left px-3 py-2 text-sm text-white hover:bg-white/[0.06] border-b border-white/[0.04] last:border-0"
                >
                  <div>{r.placeName}</div>
                  <div className="text-[10px] text-cosmic-muted">
                    {r.lat.toFixed(2)}°, {r.lng.toFixed(2)}° · {r.tz}
                  </div>
                </button>
              ))}
            </div>
          )}
        </div>
      </div>
      {useSavedStore && (
        <label className="flex items-center gap-2 mt-3 text-xs text-cosmic-muted select-none cursor-pointer">
          <input type="checkbox" checked={remember} onChange={(e) => setRemember(e.target.checked)} className="accent-purple-500" />
          {isEn ? "Remember for all tools" : "Tüm araçlar için hatırla"}
        </label>
      )}
      <button onClick={submit} disabled={!date || !time || !place} className={btnClass}>
        {submitLabel || (isEn ? "Calculate" : "Hesapla")}
      </button>
      {saved && (
        <button
          onClick={() => {
            clear();
            setDate("");
            setTime("12:00");
            setPlace(null);
            setPlaceQuery("");
          }}
          className="w-full mt-2 text-[11px] text-cosmic-muted hover:text-white"
        >
          {isEn ? "Clear saved data" : "Kayıtlı veriyi sil"}
        </button>
      )}
      <p className="text-[10px] text-cosmic-muted mt-3 text-center">
        {isEn ? "Swiss Ephemeris precision. Place search via OpenStreetMap." : "Swiss Ephemeris hassasiyeti. Yer arama: OpenStreetMap."}
      </p>
    </div>
  );
}
