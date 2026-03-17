export interface Article {
  slug: string;
  title: string;
  description: string;
  category: "zodiac" | "planets" | "elements" | "houses" | "aspects" | "education" | "reflection";
  tags: string[];
  readingTime: number;
  content: string;
  relatedSigns?: string[];
  publishedAt: string;
}
