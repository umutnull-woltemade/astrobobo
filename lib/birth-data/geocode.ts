// @ts-expect-error - no types for tz-lookup
import tzlookup from "tz-lookup";

export interface PlaceResult {
  lat: number;
  lng: number;
  placeName: string;
  tz: string;
}

/** Search a place via OpenStreetMap Nominatim. Rate limit: 1 req/sec. */
export async function searchPlaces(query: string, signal?: AbortSignal): Promise<PlaceResult[]> {
  if (!query || query.length < 2) return [];
  const url = `https://nominatim.openstreetmap.org/search?q=${encodeURIComponent(query)}&format=json&limit=5&addressdetails=1`;
  const res = await fetch(url, {
    signal,
    headers: { "Accept-Language": "en,tr" },
  });
  if (!res.ok) return [];
  const raw = (await res.json()) as Array<{
    lat: string;
    lon: string;
    display_name: string;
    address?: { city?: string; town?: string; village?: string; state?: string; country?: string };
  }>;
  return raw.map((r) => {
    const lat = parseFloat(r.lat);
    const lng = parseFloat(r.lon);
    let tz = "UTC";
    try {
      tz = tzlookup(lat, lng);
    } catch {
      /* keep UTC */
    }
    const city = r.address?.city || r.address?.town || r.address?.village || r.address?.state || "";
    const country = r.address?.country || "";
    const short = [city, country].filter(Boolean).join(", ") || r.display_name;
    return { lat, lng, placeName: short, tz };
  });
}
