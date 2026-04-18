/** Compute IANA zone offset (hours from UTC) for a local wall-clock moment. */
export function getTzOffsetHours(tz: string, y: number, mo: number, d: number, h: number, mi: number): number {
  if (!tz) return 0;
  try {
    const asUTC = Date.UTC(y, mo - 1, d, h, mi);
    const fmt = new Intl.DateTimeFormat('en-US', {
      timeZone: tz,
      year: 'numeric', month: '2-digit', day: '2-digit',
      hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
    });
    const parts = fmt.formatToParts(new Date(asUTC));
    const get = (t: string) => Number(parts.find(p => p.type === t)?.value || 0);
    const hr = get('hour') === 24 ? 0 : get('hour');
    const localAsUTC = Date.UTC(get('year'), get('month') - 1, get('day'), hr, get('minute'), get('second'));
    return (localAsUTC - asUTC) / 3_600_000;
  } catch {
    return 0;
  }
}

/** Parse YYYY-MM-DD + HH:MM + IANA tz into decimal UTC hours and YMD. */
export function localToUtcDecimalHours(date: string, time: string, tz: string) {
  const [y, mo, d] = date.split('-').map(Number);
  const [h, mi] = (time || '12:00').split(':').map(Number);
  const offset = getTzOffsetHours(tz, y, mo, d, h, mi);
  return { year: y, month: mo, day: d, decimalHours: h + mi / 60 - offset, tzOffsetHours: offset };
}
