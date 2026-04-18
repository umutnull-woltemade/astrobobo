"use client";

const SIGN_SYMBOLS = ['♈','♉','♊','♋','♌','♍','♎','♏','♐','♑','♒','♓'];
const SIGN_COLORS = ['#FF6B6B','#A8C66C','#FFD93D','#80DEEA','#FFA726','#9CCC65','#F06292','#7E57C2','#FF7043','#8D6E63','#42A5F5','#26C6DA'];

interface Planet { symbol: string; longitude: number; name: string }
interface House { house: number; cusp: number }

function polarToXY(cx: number, cy: number, r: number, deg: number) {
  const rad = ((deg - 90) * Math.PI) / 180;
  return { x: cx + r * Math.cos(rad), y: cy + r * Math.sin(rad) };
}

function zodiacDeg(longitude: number): number {
  // Zodiac wheel: Aries starts at 0° (=top rotated). We display ASC at left (9 o'clock).
  return longitude;
}

export default function ChartWheel({
  planets,
  houses,
  ascendant,
}: {
  planets: Planet[];
  houses: House[];
  ascendant: number;
}) {
  const size = 400;
  const cx = size / 2;
  const cy = size / 2;
  const outerR = 185;
  const signR = 165;
  const innerR = 140;
  const planetR = 115;
  const houseNumR = 128;

  // Rotate so ASC is at 9 o'clock (180°)
  const rotation = 180 - ascendant;

  function toDeg(lon: number) {
    return (lon + rotation) % 360;
  }

  // Sign wedges
  const signWedges = Array.from({ length: 12 }, (_, i) => {
    const startDeg = toDeg(i * 30);
    const endDeg = toDeg((i + 1) * 30);
    const midDeg = toDeg(i * 30 + 15);
    const p1 = polarToXY(cx, cy, outerR, startDeg);
    const p2 = polarToXY(cx, cy, outerR, endDeg);
    const p3 = polarToXY(cx, cy, signR, endDeg);
    const p4 = polarToXY(cx, cy, signR, startDeg);
    const labelPos = polarToXY(cx, cy, (outerR + signR) / 2, midDeg);
    const largeArc = 0;
    const path = `M ${p1.x} ${p1.y} A ${outerR} ${outerR} 0 ${largeArc} 1 ${p2.x} ${p2.y} L ${p3.x} ${p3.y} A ${signR} ${signR} 0 ${largeArc} 0 ${p4.x} ${p4.y} Z`;
    return { path, label: SIGN_SYMBOLS[i], labelPos, color: SIGN_COLORS[i] };
  });

  // House lines
  const houseLines = houses.map((h) => {
    const deg = toDeg(h.cusp);
    const p1 = polarToXY(cx, cy, signR, deg);
    const p2 = polarToXY(cx, cy, 40, deg);
    const numPos = polarToXY(cx, cy, houseNumR, toDeg(h.cusp + 15));
    return { p1, p2, num: h.house, numPos };
  });

  // Planet positions (spread if overlapping)
  const planetPositions = planets.map((p) => {
    const deg = toDeg(p.longitude);
    const pos = polarToXY(cx, cy, planetR, deg);
    const tickInner = polarToXY(cx, cy, signR - 2, deg);
    const tickOuter = polarToXY(cx, cy, innerR + 2, deg);
    return { ...p, deg, pos, tickInner, tickOuter };
  });

  return (
    <div className="flex justify-center">
      <svg viewBox={`0 0 ${size} ${size}`} className="w-full max-w-[400px]" style={{ filter: 'drop-shadow(0 0 20px rgba(124,58,237,0.15))' }}>
        {/* Outer circle */}
        <circle cx={cx} cy={cy} r={outerR} fill="none" stroke="rgba(255,255,255,0.15)" strokeWidth="1" />
        <circle cx={cx} cy={cy} r={signR} fill="none" stroke="rgba(255,255,255,0.1)" strokeWidth="1" />
        <circle cx={cx} cy={cy} r={innerR} fill="none" stroke="rgba(255,255,255,0.08)" strokeWidth="0.5" />

        {/* Sign wedges */}
        {signWedges.map((w, i) => (
          <g key={i}>
            <path d={w.path} fill={`${w.color}08`} stroke={`${w.color}30`} strokeWidth="0.5" />
            <text x={w.labelPos.x} y={w.labelPos.y} textAnchor="middle" dominantBaseline="central" fill={w.color} fontSize="12" opacity="0.7">
              {w.label}
            </text>
          </g>
        ))}

        {/* House lines */}
        {houseLines.map((h) => (
          <g key={h.num}>
            <line x1={h.p1.x} y1={h.p1.y} x2={h.p2.x} y2={h.p2.y}
              stroke={h.num === 1 || h.num === 10 ? 'rgba(167,139,250,0.5)' : 'rgba(255,255,255,0.08)'} strokeWidth={h.num === 1 || h.num === 10 ? 1.5 : 0.5} />
            <text x={h.numPos.x} y={h.numPos.y} textAnchor="middle" dominantBaseline="central" fill="rgba(255,255,255,0.2)" fontSize="9">
              {h.num}
            </text>
          </g>
        ))}

        {/* ASC / MC labels */}
        {ascendant > 0 && (
          <text x={polarToXY(cx, cy, outerR + 12, toDeg(ascendant)).x} y={polarToXY(cx, cy, outerR + 12, toDeg(ascendant)).y}
            textAnchor="middle" dominantBaseline="central" fill="#a78bfa" fontSize="8" fontWeight="bold">ASC</text>
        )}

        {/* Planet ticks and symbols */}
        {planetPositions.map((p, i) => (
          <g key={i}>
            <line x1={p.tickInner.x} y1={p.tickInner.y} x2={p.tickOuter.x} y2={p.tickOuter.y} stroke="rgba(255,255,255,0.3)" strokeWidth="0.5" />
            <text x={p.pos.x} y={p.pos.y} textAnchor="middle" dominantBaseline="central" fill="white" fontSize="11" style={{ textShadow: '0 0 6px rgba(0,0,0,0.8)' }}>
              {p.symbol}
            </text>
          </g>
        ))}

        {/* Center dot */}
        <circle cx={cx} cy={cy} r="2" fill="rgba(167,139,250,0.5)" />
      </svg>
    </div>
  );
}
