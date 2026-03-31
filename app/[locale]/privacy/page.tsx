import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/get-dictionary";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) return {};
  const dict = await getDictionary(locale as Locale);
  const isEn = locale === "en";

  const title = isEn ? "Privacy Policy" : "Gizlilik Politikası";
  const description = isEn
    ? "Learn how Astrobobo handles your data and protects your privacy."
    : "Astrobobo'nun verilerinizi nasıl yönettiğini ve gizliliğinizi nasıl koruduğunu öğrenin.";

  return {
    title,
    description,
    openGraph: {
      title: `${title} | Astrobobo`,
      description,
      url: isEn ? "/privacy" : `/${locale}/privacy`,
    },
  };
}

export default async function PrivacyPolicyPage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const isEn = locale === "en";

  return (
    <div className="max-w-3xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? "Privacy Policy" : "Gizlilik Politikası"}
        </h1>
        <p className="text-cosmic-muted max-w-2xl mx-auto text-lg">
          {isEn
            ? "Last updated: March 2026"
            : "Son güncelleme: Mart 2026"}
        </p>
      </div>

      <div className="cosmic-card article-prose">
        {/* Introduction */}
        <section className="mb-10">
          <p>
            {isEn
              ? "Welcome to Astrobobo. Your privacy matters to us. This Privacy Policy explains what information we collect, how we use it, and your rights regarding your data."
              : "Astrobobo'ya hoş geldiniz. Gizliliğiniz bizim için önemlidir. Bu Gizlilik Politikası, hangi bilgileri topladığımızı, bunları nasıl kullandığımızı ve verilerinizle ilgili haklarınızı açıklar."}
          </p>
        </section>

        {/* Data Collection */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "What Data We Collect" : "Hangi Verileri Topluyoruz"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo is designed with minimal data collection in mind. Here is what we collect:"
              : "Astrobobo, minimum veri toplama ilkesiyle tasarlanmıştır. Topladığımız veriler:"}
          </p>
          <ul className="list-disc list-inside mt-4 space-y-2 text-cosmic-muted">
            <li>
              {isEn
                ? "Zodiac sign preference: Stored locally in your browser via localStorage. This data never leaves your device."
                : "Burç tercihi: Tarayıcınızda localStorage aracılığıyla yerel olarak saklanır. Bu veri cihazınızdan hiçbir zaman çıkmaz."}
            </li>
            <li>
              {isEn
                ? "Standard analytics: We use privacy-friendly analytics to understand general usage patterns such as page views and session duration. No personally identifiable information is collected through analytics."
                : "Standart analitik: Sayfa görüntülemesi ve oturum süresi gibi genel kullanım kalıplarını anlamak için gizlilik dostu analitik kullanıyoruz. Analitik aracılığıyla kişisel olarak tanımlanabilir hiçbir bilgi toplanmaz."}
            </li>
            <li>
              {isEn
                ? "No account required: You do not need to create an account or provide any personal information to use Astrobobo."
                : "Hesap gerektirmez: Astrobobo'yu kullanmak için hesap oluşturmanız veya herhangi bir kişisel bilgi vermeniz gerekmez."}
            </li>
          </ul>
        </section>

        {/* No Data Sold */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "We Do Not Sell Your Data" : "Verilerinizi Satmıyoruz"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo does not sell, rent, or trade any personal data to third parties. We do not engage in data brokering of any kind. Your browsing habits and preferences stay with you."
              : "Astrobobo, hiçbir kişisel veriyi üçüncü taraflara satmaz, kiralamaz veya takas etmez. Hiçbir türde veri aracılığına katılmayız. Gezinme alışkanlıklarınız ve tercihleriniz sizde kalır."}
          </p>
        </section>

        {/* Cookies */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Cookies" : "Çerezler"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo uses essential cookies to ensure the website functions correctly, such as remembering your language preference. We may also use analytics cookies to gather anonymous usage statistics. You can control cookie settings through your browser preferences."
              : "Astrobobo, web sitesinin doğru çalışması için dil tercihinizi hatırlamak gibi temel çerezler kullanır. Ayrıca anonim kullanım istatistikleri toplamak için analitik çerezler kullanabiliriz. Çerez ayarlarını tarayıcı tercihleriniz aracılığıyla kontrol edebilirsiniz."}
          </p>
        </section>

        {/* Third-Party Services */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Third-Party Services" : "Üçüncü Taraf Hizmetleri"}
          </h2>
          <p>
            {isEn
              ? "We may use third-party services for analytics and hosting. These services have their own privacy policies, and we encourage you to review them. We only partner with services that respect user privacy."
              : "Analitik ve barındırma için üçüncü taraf hizmetleri kullanabiliriz. Bu hizmetlerin kendi gizlilik politikaları vardır ve bunları incelemenizi öneririz. Yalnızca kullanıcı gizliliğine saygı gösteren hizmetlerle çalışıyoruz."}
          </p>
        </section>

        {/* Your Rights */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Your Rights" : "Haklarınız"}
          </h2>
          <p>
            {isEn
              ? "Since we store your zodiac sign preference only in your browser's localStorage, you have full control over this data. You can clear it at any time by clearing your browser data. If you have any questions about your data, feel free to reach out to us."
              : "Burç tercihinizi yalnızca tarayıcınızın localStorage'ında sakladığımız için, bu veriler üzerinde tam kontrole sahipsiniz. Tarayıcı verilerinizi temizleyerek istediğiniz zaman silebilirsiniz. Verileriniz hakkında sorularınız varsa bizimle iletişime geçmekten çekinmeyin."}
          </p>
        </section>

        {/* Contact */}
        <section className="mb-4">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Contact Us" : "Bize Ulaşın"}
          </h2>
          <p>
            {isEn
              ? "If you have any questions or concerns about this Privacy Policy, please contact us at:"
              : "Bu Gizlilik Politikası hakkında sorularınız veya endişeleriniz varsa, lütfen bizimle iletişime geçin:"}
          </p>
          <p className="mt-4">
            <a
              href="mailto:info@astrobobo.com"
              className="text-cosmic-accent hover:underline"
            >
              info@astrobobo.com
            </a>
          </p>
        </section>
      </div>
    </div>
  );
}
