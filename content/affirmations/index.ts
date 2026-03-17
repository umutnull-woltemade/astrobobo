export interface Affirmation {
  id: string;
  text: string;
  theme: "self-worth" | "growth" | "relationships" | "courage" | "peace" | "wisdom" | "abundance" | "healing";
  relatedSign?: string;
}

export const affirmations: Affirmation[] = [
  // ── Self-Worth ───────────────────────────────────────────
  { id: "sw01", text: "I am enough, exactly as I am in this moment.", theme: "self-worth" },
  { id: "sw02", text: "My worth is not measured by my productivity or output.", theme: "self-worth", relatedSign: "virgo" },
  { id: "sw03", text: "I honor the unique qualities that make me who I am.", theme: "self-worth", relatedSign: "aquarius" },
  { id: "sw04", text: "I deserve the same compassion I freely give to others.", theme: "self-worth", relatedSign: "pisces" },
  { id: "sw05", text: "My voice matters, and I trust myself to use it.", theme: "self-worth", relatedSign: "leo" },
  { id: "sw06", text: "I release the need for external validation to know my own value.", theme: "self-worth", relatedSign: "taurus" },
  { id: "sw07", text: "I am worthy of love that does not require me to shrink.", theme: "self-worth", relatedSign: "leo" },
  { id: "sw08", text: "My imperfections are part of my depth, not a diminishment of my value.", theme: "self-worth", relatedSign: "virgo" },
  { id: "sw09", text: "I trust that I am exactly where I need to be on my journey.", theme: "self-worth" },
  { id: "sw10", text: "I am allowed to take up space, to be seen, and to be heard.", theme: "self-worth", relatedSign: "aries" },
  { id: "sw11", text: "I choose to believe in my own capacity, even when doubt visits.", theme: "self-worth", relatedSign: "capricorn" },
  { id: "sw12", text: "I hold inherent value that no circumstance can diminish.", theme: "self-worth" },
  { id: "sw13", text: "My sensitivity is a strength, not a flaw to be corrected.", theme: "self-worth", relatedSign: "cancer" },

  // ── Growth ───────────────────────────────────────────────
  { id: "gr01", text: "Every challenge I face is shaping me into someone more resilient.", theme: "growth", relatedSign: "capricorn" },
  { id: "gr02", text: "I welcome transformation, even when its form surprises me.", theme: "growth", relatedSign: "scorpio" },
  { id: "gr03", text: "I am not behind. I am on my own timeline.", theme: "growth", relatedSign: "taurus" },
  { id: "gr04", text: "I am learning to hold space for both who I am and who I am becoming.", theme: "growth" },
  { id: "gr05", text: "Mistakes are not failures — they are invitations to understand more deeply.", theme: "growth", relatedSign: "sagittarius" },
  { id: "gr06", text: "I have the capacity to evolve without abandoning my core self.", theme: "growth", relatedSign: "scorpio" },
  { id: "gr07", text: "I trust the process of becoming, even when the path is unclear.", theme: "growth", relatedSign: "pisces" },
  { id: "gr08", text: "I give myself permission to outgrow spaces that no longer serve me.", theme: "growth", relatedSign: "sagittarius" },
  { id: "gr09", text: "My growth does not require suffering — it can come through joy.", theme: "growth", relatedSign: "jupiter" },
  { id: "gr10", text: "I am patient with myself as I learn, unlearn, and learn again.", theme: "growth", relatedSign: "virgo" },
  { id: "gr11", text: "Each season of my life carries its own wisdom. I am listening.", theme: "growth" },
  { id: "gr12", text: "I embrace the unknown as fertile ground for my expansion.", theme: "growth", relatedSign: "aquarius" },
  { id: "gr13", text: "The person I was yesterday brought me here. I honor that journey.", theme: "growth" },

  // ── Relationships ────────────────────────────────────────
  { id: "re01", text: "I attract relationships that honor my authenticity.", theme: "relationships", relatedSign: "libra" },
  { id: "re02", text: "I communicate my needs with clarity and compassion.", theme: "relationships", relatedSign: "gemini" },
  { id: "re03", text: "I am worthy of love that is steady, present, and kind.", theme: "relationships", relatedSign: "taurus" },
  { id: "re04", text: "I release relationships that ask me to betray myself.", theme: "relationships", relatedSign: "scorpio" },
  { id: "re05", text: "I bring my full self into connection, trusting that it is enough.", theme: "relationships", relatedSign: "leo" },
  { id: "re06", text: "Healthy boundaries are an expression of love — for myself and for others.", theme: "relationships", relatedSign: "capricorn" },
  { id: "re07", text: "I listen deeply, and in doing so, I create space for true intimacy.", theme: "relationships", relatedSign: "cancer" },
  { id: "re08", text: "I choose to see the humanity in others, even in moments of friction.", theme: "relationships", relatedSign: "pisces" },
  { id: "re09", text: "The love I give returns to me in forms I may not expect.", theme: "relationships", relatedSign: "libra" },
  { id: "re10", text: "I am building connections rooted in mutual respect and genuine care.", theme: "relationships" },
  { id: "re11", text: "I deserve partnerships where vulnerability is met with safety.", theme: "relationships", relatedSign: "cancer" },
  { id: "re12", text: "I honor the seasons of my relationships — closeness and distance both have purpose.", theme: "relationships" },

  // ── Courage ──────────────────────────────────────────────
  { id: "co01", text: "I have the strength to face what is difficult, and the wisdom to ask for help.", theme: "courage", relatedSign: "aries" },
  { id: "co02", text: "Fear is not a stop sign — it is information. I choose to move through it.", theme: "courage", relatedSign: "scorpio" },
  { id: "co03", text: "I trust my instincts, even when the world is loud.", theme: "courage", relatedSign: "aries" },
  { id: "co04", text: "Speaking my truth is an act of courage I practice every day.", theme: "courage", relatedSign: "leo" },
  { id: "co05", text: "I am brave enough to begin again, no matter how many times it takes.", theme: "courage", relatedSign: "aries" },
  { id: "co06", text: "I face the unknown not with recklessness but with grounded determination.", theme: "courage", relatedSign: "capricorn" },
  { id: "co07", text: "I stand firmly in who I am, even when it is easier to conform.", theme: "courage", relatedSign: "aquarius" },
  { id: "co08", text: "My courage grows each time I choose authenticity over approval.", theme: "courage", relatedSign: "leo" },
  { id: "co09", text: "I am not defined by what frightens me — I am defined by how I respond.", theme: "courage" },
  { id: "co10", text: "I give myself permission to take the first step before I feel ready.", theme: "courage", relatedSign: "aries" },
  { id: "co11", text: "The fire inside me is brighter than any shadow outside me.", theme: "courage", relatedSign: "sagittarius" },
  { id: "co12", text: "I carry within me an unshakable resilience that has carried me this far.", theme: "courage", relatedSign: "scorpio" },
  { id: "co13", text: "I choose action over avoidance, clarity over confusion.", theme: "courage", relatedSign: "aries" },

  // ── Peace ────────────────────────────────────────────────
  { id: "pe01", text: "I release what I cannot control and find peace in this present moment.", theme: "peace", relatedSign: "pisces" },
  { id: "pe02", text: "Stillness is not emptiness — it is fullness waiting to be recognized.", theme: "peace", relatedSign: "taurus" },
  { id: "pe03", text: "I allow myself to rest without guilt and to pause without apology.", theme: "peace", relatedSign: "cancer" },
  { id: "pe04", text: "My inner calm is a refuge I can return to at any time.", theme: "peace" },
  { id: "pe05", text: "I choose to meet this day with equanimity, whatever it may hold.", theme: "peace", relatedSign: "libra" },
  { id: "pe06", text: "I am at peace with the pace of my own becoming.", theme: "peace", relatedSign: "taurus" },
  { id: "pe07", text: "I exhale tension and inhale acceptance.", theme: "peace" },
  { id: "pe08", text: "I do not need to resolve everything today. Some things unfold in their own time.", theme: "peace", relatedSign: "pisces" },
  { id: "pe09", text: "Harmony begins within me, and I nurture it with gentleness.", theme: "peace", relatedSign: "libra" },
  { id: "pe10", text: "I make space for silence, knowing it holds its own kind of wisdom.", theme: "peace" },
  { id: "pe11", text: "I soften the edges of my expectations and find serenity in what is.", theme: "peace", relatedSign: "pisces" },
  { id: "pe12", text: "My peace is not dependent on circumstances — it is a choice I make.", theme: "peace", relatedSign: "libra" },
  { id: "pe13", text: "I trust the rhythm of my life, even when it slows to a whisper.", theme: "peace", relatedSign: "cancer" },

  // ── Wisdom ───────────────────────────────────────────────
  { id: "wi01", text: "I trust the deep knowing that lives beneath my thoughts.", theme: "wisdom", relatedSign: "scorpio" },
  { id: "wi02", text: "Every experience has been a teacher, and I honor the lessons received.", theme: "wisdom", relatedSign: "sagittarius" },
  { id: "wi03", text: "I hold complexity without rushing to simplify it.", theme: "wisdom", relatedSign: "gemini" },
  { id: "wi04", text: "True wisdom includes knowing when to speak and when to listen.", theme: "wisdom", relatedSign: "virgo" },
  { id: "wi05", text: "I seek understanding, not certainty. The questions matter as much as the answers.", theme: "wisdom", relatedSign: "sagittarius" },
  { id: "wi06", text: "I approach my life with the perspective that everything carries meaning.", theme: "wisdom" },
  { id: "wi07", text: "I learn from the past without being imprisoned by it.", theme: "wisdom", relatedSign: "capricorn" },
  { id: "wi08", text: "My intuition is a wellspring of insight that I choose to honor.", theme: "wisdom", relatedSign: "cancer" },
  { id: "wi09", text: "I do not need to know everything to move forward with clarity.", theme: "wisdom", relatedSign: "sagittarius" },
  { id: "wi10", text: "I value depth over speed, and presence over distraction.", theme: "wisdom", relatedSign: "scorpio" },
  { id: "wi11", text: "Each chapter of my life has built a foundation of understanding I now stand upon.", theme: "wisdom" },
  { id: "wi12", text: "I remain curious about what I do not yet understand. Wonder is a form of wisdom.", theme: "wisdom", relatedSign: "gemini" },

  // ── Abundance ────────────────────────────────────────────
  { id: "ab01", text: "I am open to receiving the fullness that life offers.", theme: "abundance", relatedSign: "taurus" },
  { id: "ab02", text: "There is enough — enough time, enough love, enough opportunity.", theme: "abundance", relatedSign: "sagittarius" },
  { id: "ab03", text: "I release scarcity thinking and welcome the flow of nourishment.", theme: "abundance", relatedSign: "taurus" },
  { id: "ab04", text: "My life is rich in ways that transcend material measure.", theme: "abundance" },
  { id: "ab05", text: "I notice and celebrate the abundance already present in my daily life.", theme: "abundance", relatedSign: "taurus" },
  { id: "ab06", text: "Generosity and receiving are two sides of the same cycle. I honor both.", theme: "abundance", relatedSign: "leo" },
  { id: "ab07", text: "I attract opportunities by showing up as my most authentic self.", theme: "abundance", relatedSign: "leo" },
  { id: "ab08", text: "I trust that what is meant for me is already making its way.", theme: "abundance", relatedSign: "pisces" },
  { id: "ab09", text: "My sense of prosperity grows when I appreciate what I already hold.", theme: "abundance", relatedSign: "taurus" },
  { id: "ab10", text: "I nourish abundance by sharing what I have with an open heart.", theme: "abundance", relatedSign: "sagittarius" },
  { id: "ab11", text: "I am worthy of ease, joy, and the fulfillment of my genuine desires.", theme: "abundance" },
  { id: "ab12", text: "Each day offers more than I realize. I choose to see it clearly.", theme: "abundance" },

  // ── Healing ──────────────────────────────────────────────
  { id: "he01", text: "I give myself permission to heal at my own pace, without comparison.", theme: "healing", relatedSign: "cancer" },
  { id: "he02", text: "My wounds are not my identity — they are part of my story, not its entirety.", theme: "healing", relatedSign: "scorpio" },
  { id: "he03", text: "I choose to nurture myself with the same tenderness I would offer a loved one.", theme: "healing", relatedSign: "cancer" },
  { id: "he04", text: "Healing is not a destination. It is a practice I honor daily.", theme: "healing" },
  { id: "he05", text: "I release the belief that I must carry this pain alone.", theme: "healing", relatedSign: "pisces" },
  { id: "he06", text: "My body holds wisdom. I listen to it with patience and respect.", theme: "healing", relatedSign: "virgo" },
  { id: "he07", text: "I am gently untangling old patterns that no longer serve my highest good.", theme: "healing", relatedSign: "scorpio" },
  { id: "he08", text: "I forgive not to forget, but to free myself from the weight of resentment.", theme: "healing", relatedSign: "libra" },
  { id: "he09", text: "There is strength in softness. I allow myself to be tender.", theme: "healing", relatedSign: "cancer" },
  { id: "he10", text: "I trust the intelligence of my healing process, even when it feels slow.", theme: "healing", relatedSign: "pisces" },
  { id: "he11", text: "I am worthy of the peace that comes from releasing what no longer belongs to me.", theme: "healing" },
  { id: "he12", text: "Each breath I take is an act of renewal. I am already healing.", theme: "healing" },
];

export function getAffirmationsByTheme(theme: Affirmation["theme"]): Affirmation[] {
  return affirmations.filter((a) => a.theme === theme);
}

export function getAffirmationsBySign(sign: string): Affirmation[] {
  return affirmations.filter((a) => a.relatedSign === sign);
}

export function getRandomAffirmation(theme?: Affirmation["theme"]): Affirmation {
  const pool = theme ? getAffirmationsByTheme(theme) : affirmations;
  return pool[Math.floor(Math.random() * pool.length)];
}

export function getDailyAffirmation(dateStr?: string): Affirmation {
  const date = dateStr ? new Date(dateStr) : new Date();
  const dayOfYear = Math.floor(
    (date.getTime() - new Date(date.getFullYear(), 0, 0).getTime()) / 86400000
  );
  return affirmations[dayOfYear % affirmations.length];
}

export function getAffirmationsByThemes(themes: Affirmation["theme"][]): Affirmation[] {
  return affirmations.filter((a) => themes.includes(a.theme));
}
