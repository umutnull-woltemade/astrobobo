// Essential dignities: ruler, detriment, exaltation, fall for each sign
const DIGNITIES: Record<string, { ruler: string; detriment: string; exalted: string; fall: string }> = {
  Aries:       { ruler: '♂', detriment: '♀', exalted: '☉', fall: '♄' },
  Taurus:      { ruler: '♀', detriment: '♂', exalted: '☽', fall: '♅' },
  Gemini:      { ruler: '☿', detriment: '♃', exalted: '☊', fall: '☋' },
  Cancer:      { ruler: '☽', detriment: '♄', exalted: '♃', fall: '♂' },
  Leo:         { ruler: '☉', detriment: '♄', exalted: '♆', fall: '♅' },
  Virgo:       { ruler: '☿', detriment: '♃', exalted: '☿', fall: '♀' },
  Libra:       { ruler: '♀', detriment: '♂', exalted: '♄', fall: '☉' },
  Scorpio:     { ruler: '♂', detriment: '♀', exalted: '♅', fall: '☽' },
  Sagittarius: { ruler: '♃', detriment: '☿', exalted: '☊', fall: '☋' },
  Capricorn:   { ruler: '♄', detriment: '☽', exalted: '♂', fall: '♃' },
  Aquarius:    { ruler: '♄', detriment: '☉', exalted: '☿', fall: '♆' },
  Pisces:      { ruler: '♃', detriment: '☿', exalted: '♀', fall: '☿' },
};

export type Dignity = 'domicile' | 'detriment' | 'exalted' | 'fall' | 'peregrine';

export function getDignity(planetSymbol: string, signEn: string): Dignity {
  const d = DIGNITIES[signEn];
  if (!d) return 'peregrine';
  if (d.ruler === planetSymbol) return 'domicile';
  if (d.exalted === planetSymbol) return 'exalted';
  if (d.detriment === planetSymbol) return 'detriment';
  if (d.fall === planetSymbol) return 'fall';
  return 'peregrine';
}

export const DIGNITY_LABELS: Record<Dignity, { en: string; tr: string; color: string }> = {
  domicile:  { en: 'Domicile',  tr: 'Hane',      color: '#22c55e' },
  exalted:   { en: 'Exalted',   tr: 'Yücelme',   color: '#a78bfa' },
  detriment: { en: 'Detriment', tr: 'Zararında',  color: '#f87171' },
  fall:      { en: 'Fall',      tr: 'Düşüşünde',  color: '#fb923c' },
  peregrine: { en: '',          tr: '',            color: '' },
};

// Sign name mapping for Turkish→English lookup
export const SIGN_EN: Record<string, string> = {
  Koç: 'Aries', Boğa: 'Taurus', İkizler: 'Gemini', Yengeç: 'Cancer',
  Aslan: 'Leo', Başak: 'Virgo', Terazi: 'Libra', Akrep: 'Scorpio',
  Yay: 'Sagittarius', Oğlak: 'Capricorn', Kova: 'Aquarius', Balık: 'Pisces',
  Aries: 'Aries', Taurus: 'Taurus', Gemini: 'Gemini', Cancer: 'Cancer',
  Leo: 'Leo', Virgo: 'Virgo', Libra: 'Libra', Scorpio: 'Scorpio',
  Sagittarius: 'Sagittarius', Capricorn: 'Capricorn', Aquarius: 'Aquarius', Pisces: 'Pisces',
};
