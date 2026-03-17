const en = {
  meta: {
    siteTitle: "Astrobobo - Reflective Astrology & Cosmic Self-Discovery",
    siteDescription:
      "Explore zodiac archetypes, birth chart insights, cosmic reflections, and educational astrology content. Understand yourself through the language of the stars.",
    ogDescription:
      "Explore zodiac archetypes, birth chart insights, and educational astrology content.",
  },
  nav: {
    zodiacSigns: "Zodiac Signs",
    articles: "Articles",
    archetypes: "Archetypes",
  },
  footer: {
    tagline:
      "Educational astrology content for self-reflection and cosmic exploration. All content is reflective and non-predictive.",
    explore: "Explore",
    legal: "Legal",
    privacy: "Privacy Policy",
    terms: "Terms of Service",
    editorial: "Editorial Policy",
    disclaimer:
      "Content is educational and reflective. Astrobobo does not make predictions or guarantees.",
    copyright: "Astrobobo. All rights reserved.",
  },
  home: {
    heroSubtitle:
      "Explore zodiac archetypes and cosmic patterns through reflective, educational content.",
    heroDescription:
      "Discover insights about personality, relationships, and growth themes. No predictions. No fortune telling. Just self-understanding.",
    zodiacHeading: "The Twelve Zodiac Archetypes",
    exploreHeading: "Explore Cosmic Wisdom",
    zodiacProfiles: "Zodiac Profiles",
    zodiacProfilesDesc:
      "Deep personality insights, strengths, growth themes, and reflection prompts for each zodiac archetype.",
    exploreAllSigns: "Explore all signs",
    educationalArticles: "Educational Articles",
    educationalArticlesDesc:
      "In-depth explorations of astrological concepts, planetary archetypes, elemental wisdom, and cosmic patterns.",
    readArticles: "Read articles",
    dailyReflections: "Daily Reflections",
    dailyReflectionsDesc:
      "Thoughtful prompts and affirmations inspired by cosmic archetypes to support your self-awareness journey.",
    startReflecting: "Start reflecting",
    whatIsReflective: "What is Reflective Astrology?",
    whatIsReflectiveP1:
      "Reflective astrology approaches zodiac archetypes as psychological frameworks for self-understanding rather than predictive tools. Each zodiac sign represents a constellation of personality traits, growth themes, and relational patterns that many people find insightful for self-reflection.",
    whatIsReflectiveP2:
      "At Astrobobo, all content is educational and reflective. We explore how archetypal patterns from astrology, mythology, and depth psychology can serve as mirrors for personal growth. Our approach emphasizes self-awareness, curiosity, and empowerment rather than dependency or deterministic claims.",
    howToUse: "How to Use This Resource",
    howToUseP:
      "Browse zodiac profiles to explore personality archetypes. Read educational articles about planetary symbolism, elemental wisdom, and cosmic cycles. Use reflection prompts as journaling inspiration. Consider what resonates with your experience and what invites further exploration.",
  },
  zodiac: {
    pageTitle: "All 12 Zodiac Signs - Personality, Traits & Cosmic Insights",
    pageDescription:
      "Explore all 12 zodiac archetypes with deep personality insights, strengths, growth themes, and reflection prompts. Educational astrology for self-understanding.",
    heading: "The Twelve Zodiac Archetypes",
    subtitle:
      "Each zodiac sign represents a unique constellation of personality traits, growth themes, and relational patterns. Explore what resonates with you.",
    all: "All",
    seoHeading: "Understanding Zodiac Archetypes",
    seoP1:
      "The twelve zodiac signs form a complete cycle of archetypal energies, each representing a distinct approach to life, relationships, and personal growth. In reflective astrology, these signs serve as psychological frameworks rather than deterministic labels.",
    seoP2:
      "The signs are organized by element (Fire, Earth, Air, Water) and modality (Cardinal, Fixed, Mutable), creating a rich tapestry of complementary energies. Understanding your zodiac archetype can offer valuable insight into your natural tendencies, communication style, and areas for growth.",
    overview: "Overview",
    personality: "Personality Insights",
    strengths: "Key Strengths",
    growthThemes: "Growth Themes",
    reflectionPrompts: "Reflection Prompts",
    compatibility: "Relational Dynamics",
    dailyInspiration: "Daily Inspirations",
    cosmicContext: "Cosmic Context",
    relatedSigns: "Related Zodiac Signs",
  },
  articles: {
    pageTitle: "Astrology Articles - Educational Insights & Cosmic Wisdom",
    pageDescription:
      "In-depth educational articles about zodiac signs, planetary archetypes, birth charts, elements, and cosmic psychology. Reflective astrology for self-understanding.",
    heading: "Astrology Articles",
    subtitle:
      "Educational explorations of astrological concepts, planetary symbolism, and archetypal psychology for self-reflection and growth.",
    minRead: "min read",
  },
  elements: {
    Fire: "Fire",
    Earth: "Earth",
    Air: "Air",
    Water: "Water",
  },
  modalities: {
    Cardinal: "Cardinal",
    Fixed: "Fixed",
    Mutable: "Mutable",
  },
};

// Recursive type that converts all literal string values to `string`
type DeepStringify<T> = {
  [K in keyof T]: T[K] extends string ? string : DeepStringify<T[K]>;
};

export type Dictionary = DeepStringify<typeof en>;
export default en;
