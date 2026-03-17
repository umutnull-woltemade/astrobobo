export interface Reflection {
  id: string;
  text: string;
  category: "morning" | "evening" | "growth" | "relationship" | "career" | "spiritual";
  relatedSign?: string;
  relatedPlanet?: string;
  relatedElement?: string;
}

export const reflections: Reflection[] = [
  // ── Morning ──────────────────────────────────────────────
  { id: "m01", text: "What intention can you carry through today that honors your deepest values?", category: "morning" },
  { id: "m02", text: "Notice the first emotion that arises this morning. What might it be asking of you?", category: "morning" },
  { id: "m03", text: "Consider one small act of kindness you can offer yourself before the day begins.", category: "morning" },
  { id: "m04", text: "What part of yourself are you ready to bring forward today?", category: "morning" },
  { id: "m05", text: "Before the world rushes in, take a breath and ask: what matters most right now?", category: "morning" },
  { id: "m06", text: "How might you approach today with the curiosity of someone experiencing it for the first time?", category: "morning" },
  { id: "m07", text: "What would it look like to move through this day at your own pace?", category: "morning" },
  { id: "m08", text: "Name one thing you are grateful for before your feet touch the ground.", category: "morning" },
  { id: "m09", text: "What quality do you want to embody today — patience, courage, gentleness, or something else entirely?", category: "morning" },
  { id: "m10", text: "Consider the energy you wish to carry into your first interaction today.", category: "morning" },
  { id: "m11", text: "What does your body need this morning? Listen before you plan.", category: "morning" },
  { id: "m12", text: "Imagine the best version of today. What one step can you take toward that vision?", category: "morning" },
  { id: "m13", text: "How might you create a moment of stillness before the momentum of the day takes hold?", category: "morning" },
  { id: "m14", text: "What are you choosing to release from yesterday so you can meet today with fresh eyes?", category: "morning" },
  { id: "m15", text: "Notice where your thoughts go first. That direction may hold a clue about what needs attention.", category: "morning" },
  { id: "m16", text: "What personal boundary can you honor today that supports your wellbeing?", category: "morning" },
  { id: "m17", text: "Consider starting today not with a to-do list, but with a to-be list.", category: "morning" },

  // ── Evening ──────────────────────────────────────────────
  { id: "e01", text: "What moment from today are you most proud of, even if it was small?", category: "evening" },
  { id: "e02", text: "Reflect on a conversation you had today. What did you learn about yourself through it?", category: "evening" },
  { id: "e03", text: "What can you forgive yourself for today? Let that weight dissolve before sleep.", category: "evening" },
  { id: "e04", text: "Notice the emotions that linger from the day. Acknowledge each one without judgment.", category: "evening" },
  { id: "e05", text: "What challenged you today, and how did you respond? There is no wrong answer.", category: "evening" },
  { id: "e06", text: "Recall one moment of unexpected beauty or connection from this day.", category: "evening" },
  { id: "e07", text: "What did today teach you about your needs that you may not have recognized before?", category: "evening" },
  { id: "e08", text: "As the day closes, consider: did you give from a place of fullness or depletion?", category: "evening" },
  { id: "e09", text: "What thought or worry can you set down tonight, trusting it can wait until morning?", category: "evening" },
  { id: "e10", text: "Reflect on the space between what you planned and what actually happened. What lives in that gap?", category: "evening" },
  { id: "e11", text: "Who or what brought you comfort today? Hold that image as you drift toward rest.", category: "evening" },
  { id: "e12", text: "What unfinished thought from today deserves a moment of your attention before you sleep?", category: "evening" },
  { id: "e13", text: "Consider the rhythm of your energy today. When did you feel most alive?", category: "evening" },
  { id: "e14", text: "What did you resist today? Sometimes resistance is a signpost worth examining.", category: "evening" },
  { id: "e15", text: "Let tonight be a threshold. What are you carrying across, and what stays behind?", category: "evening" },
  { id: "e16", text: "Name three things — large or small — that went right today.", category: "evening" },
  { id: "e17", text: "What would you tell a friend who had the exact same day you just had?", category: "evening" },

  // ── Growth ───────────────────────────────────────────────
  { id: "g01", text: "What pattern in your life are you beginning to notice more clearly?", category: "growth", relatedPlanet: "saturn" },
  { id: "g02", text: "Consider the difference between who you were a year ago and who you are now. What shifted?", category: "growth", relatedPlanet: "jupiter" },
  { id: "g03", text: "What fear have you been avoiding that might hold a key to your next chapter?", category: "growth", relatedPlanet: "pluto" },
  { id: "g04", text: "Growth often hides in discomfort. What uncomfortable truth are you ready to sit with?", category: "growth", relatedPlanet: "saturn" },
  { id: "g05", text: "What belief about yourself has quietly expired? Consider releasing it.", category: "growth", relatedPlanet: "pluto" },
  { id: "g06", text: "Notice where you feel stuck. That stagnation may be an invitation to look deeper.", category: "growth", relatedElement: "water" },
  { id: "g07", text: "What skill or quality are you developing right now, even if progress feels invisible?", category: "growth", relatedPlanet: "saturn" },
  { id: "g08", text: "Consider a mistake that later became a teacher. What did it offer you?", category: "growth", relatedPlanet: "jupiter" },
  { id: "g09", text: "What part of your identity are you outgrowing? Honor it, and then let it evolve.", category: "growth", relatedPlanet: "uranus" },
  { id: "g10", text: "Where in your life are you playing small? What would expansion look like?", category: "growth", relatedPlanet: "jupiter" },
  { id: "g11", text: "What would you attempt if you trusted yourself completely?", category: "growth", relatedElement: "fire" },
  { id: "g12", text: "Reflect on a boundary you recently set. How did it serve your growth?", category: "growth", relatedPlanet: "saturn" },
  { id: "g13", text: "Consider exploring the space between who you are and who you are becoming.", category: "growth", relatedPlanet: "neptune" },
  { id: "g14", text: "What lesson keeps returning to you? Perhaps it is ready to be fully received.", category: "growth", relatedPlanet: "saturn" },
  { id: "g15", text: "You may notice that growth is not always forward motion — sometimes it is deepening.", category: "growth", relatedElement: "earth" },
  { id: "g16", text: "What conversation with yourself have you been postponing?", category: "growth", relatedPlanet: "mercury" },
  { id: "g17", text: "Consider the ways you have surprised yourself recently. What do they reveal?", category: "growth", relatedPlanet: "uranus" },

  // ── Relationship ─────────────────────────────────────────
  { id: "r01", text: "What unspoken need in your closest relationship deserves gentle expression?", category: "relationship", relatedPlanet: "venus" },
  { id: "r02", text: "Consider how you show love. Is it the same way you wish to receive it?", category: "relationship", relatedPlanet: "venus" },
  { id: "r03", text: "Reflect on a relationship that has shifted recently. What are you learning from the change?", category: "relationship", relatedPlanet: "venus" },
  { id: "r04", text: "What does trust look like in your life right now? Where is it strong, and where does it need tending?", category: "relationship", relatedSign: "scorpio" },
  { id: "r05", text: "Notice the people who energize you. What qualities do they reflect back to you?", category: "relationship", relatedElement: "fire" },
  { id: "r06", text: "What role do you tend to play in your relationships? Is it one you have chosen, or one you fell into?", category: "relationship", relatedPlanet: "moon" },
  { id: "r07", text: "Consider extending the same compassion to someone else that you would want for yourself.", category: "relationship", relatedSign: "pisces" },
  { id: "r08", text: "What boundary in a relationship needs reinforcing — not as a wall, but as a form of care?", category: "relationship", relatedSign: "capricorn" },
  { id: "r09", text: "Reflect on a moment of genuine connection this week. What made it possible?", category: "relationship", relatedPlanet: "venus" },
  { id: "r10", text: "Who in your life do you owe a moment of honest appreciation?", category: "relationship", relatedSign: "taurus" },
  { id: "r11", text: "Notice when you are giving to avoid receiving. What might that pattern be protecting?", category: "relationship", relatedPlanet: "moon" },
  { id: "r12", text: "What does healthy conflict look like to you? Consider exploring that question without judgment.", category: "relationship", relatedSign: "libra" },
  { id: "r13", text: "Reflect on the relationship you have with yourself. It shapes every other connection.", category: "relationship", relatedPlanet: "moon" },
  { id: "r14", text: "What would it mean to fully listen — not to respond, but to understand?", category: "relationship", relatedPlanet: "mercury" },
  { id: "r15", text: "Consider the difference between needing someone and choosing someone. Both are valid.", category: "relationship", relatedPlanet: "venus" },
  { id: "r16", text: "Who has taught you the most about love, and what was the lesson?", category: "relationship", relatedPlanet: "venus" },

  // ── Career ───────────────────────────────────────────────
  { id: "c01", text: "What part of your work feels most aligned with who you truly are?", category: "career", relatedPlanet: "sun" },
  { id: "c02", text: "Consider the difference between ambition driven by fear and ambition driven by purpose.", category: "career", relatedPlanet: "mars" },
  { id: "c03", text: "What skill are you undervaluing in yourself that others consistently recognize?", category: "career", relatedPlanet: "mercury" },
  { id: "c04", text: "Reflect on what success means to you — not the world's definition, but yours.", category: "career", relatedSign: "capricorn" },
  { id: "c05", text: "Where in your career are you following a script someone else wrote? Consider revising it.", category: "career", relatedPlanet: "saturn" },
  { id: "c06", text: "What would your work look like if it were a full expression of your values?", category: "career", relatedPlanet: "sun" },
  { id: "c07", text: "Notice where perfectionism slows you down. Progress often matters more than polish.", category: "career", relatedSign: "virgo" },
  { id: "c08", text: "What professional risk have you been weighing? Consider what you might gain by taking it.", category: "career", relatedPlanet: "jupiter" },
  { id: "c09", text: "Reflect on the leaders and mentors who shaped you. What qualities of theirs are now your own?", category: "career", relatedPlanet: "saturn" },
  { id: "c10", text: "You may notice that rest is not the opposite of productivity — it is its foundation.", category: "career", relatedPlanet: "moon" },
  { id: "c11", text: "What would you build if no one were watching?", category: "career", relatedPlanet: "sun" },
  { id: "c12", text: "Consider the legacy you are quietly creating through your daily work.", category: "career", relatedSign: "capricorn" },
  { id: "c13", text: "What does balance between effort and ease look like in your professional life?", category: "career", relatedSign: "libra" },
  { id: "c14", text: "Reflect on a setback that redirected you toward something better.", category: "career", relatedPlanet: "saturn" },
  { id: "c15", text: "What collaborative energy are you seeking in your work, and how might you invite it in?", category: "career", relatedElement: "air" },
  { id: "c16", text: "Consider whether your current pace is sustainable. Adjust before the body insists.", category: "career", relatedSign: "taurus" },

  // ── Spiritual ────────────────────────────────────────────
  { id: "s01", text: "What does your inner stillness sound like when you finally pause long enough to hear it?", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s02", text: "Consider the cycles in nature around you. Which one mirrors your own inner season?", category: "spiritual", relatedPlanet: "moon" },
  { id: "s03", text: "What sacred practice — however small — anchors you when life feels unsteady?", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s04", text: "Notice the moments when time seems to dissolve. What are you doing in those moments?", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s05", text: "Reflect on the interconnectedness between your inner world and the world around you.", category: "spiritual", relatedElement: "water" },
  { id: "s06", text: "What question is your soul asking that your mind keeps trying to answer?", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s07", text: "Consider the idea that you are both the wave and the ocean. What does that feel like?", category: "spiritual", relatedSign: "pisces" },
  { id: "s08", text: "What does surrender mean to you? Not giving up, but releasing the need to control.", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s09", text: "Notice the thin line between intuition and overthinking. Where are you today?", category: "spiritual", relatedPlanet: "moon" },
  { id: "s10", text: "What ancestor, teacher, or guide — real or imagined — do you feel walking beside you?", category: "spiritual", relatedPlanet: "pluto" },
  { id: "s11", text: "Reflect on a synchronicity you experienced recently. What meaning do you assign to it?", category: "spiritual", relatedPlanet: "uranus" },
  { id: "s12", text: "Consider exploring the silence between your breaths. Something lives there.", category: "spiritual", relatedPlanet: "neptune" },
  { id: "s13", text: "What part of the natural world reminds you of your own essence?", category: "spiritual", relatedElement: "earth" },
  { id: "s14", text: "This archetype invites you to trust the unseen forces shaping your path.", category: "spiritual", relatedPlanet: "pluto" },
  { id: "s15", text: "What ritual — morning tea, a walk, journaling — connects you to something greater?", category: "spiritual", relatedPlanet: "moon" },
  { id: "s16", text: "Notice where faith and doubt coexist in you. Both are valid companions on the journey.", category: "spiritual", relatedSign: "sagittarius" },
  { id: "s17", text: "Consider that the universe is not something you observe — it is something you participate in.", category: "spiritual", relatedPlanet: "neptune" },
];

export function getReflectionsByCategory(category: Reflection["category"]): Reflection[] {
  return reflections.filter((r) => r.category === category);
}

export function getReflectionsBySign(sign: string): Reflection[] {
  return reflections.filter((r) => r.relatedSign === sign);
}

export function getReflectionsByPlanet(planet: string): Reflection[] {
  return reflections.filter((r) => r.relatedPlanet === planet);
}

export function getReflectionsByElement(element: string): Reflection[] {
  return reflections.filter((r) => r.relatedElement === element);
}

export function getRandomReflection(category?: Reflection["category"]): Reflection {
  const pool = category ? getReflectionsByCategory(category) : reflections;
  return pool[Math.floor(Math.random() * pool.length)];
}

export function getDailyReflection(dateStr?: string): Reflection {
  const date = dateStr ? new Date(dateStr) : new Date();
  const dayOfYear = Math.floor(
    (date.getTime() - new Date(date.getFullYear(), 0, 0).getTime()) / 86400000
  );
  return reflections[dayOfYear % reflections.length];
}
