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

  const title = isEn ? "Privacy Policy" : "Gizlilik Politikasi";
  const description = isEn
    ? "Learn how Astrobobo handles your data and protects your privacy."
    : "Astrobobo'nun verilerinizi nasil yonettigini ve gizliliginizi nasil korudugunu ogrenin.";

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
          {isEn ? "Privacy Policy" : "Gizlilik Politikasi"}
        </h1>
        <p className="text-cosmic-muted max-w-2xl mx-auto text-lg">
          {isEn
            ? "Last updated: March 2026"
            : "Son guncelleme: Mart 2026"}
        </p>
      </div>

      <div className="cosmic-card article-prose">
        {/* Introduction */}
        <section className="mb-10">
          <p>
            {isEn
              ? "Welcome to Astrobobo. Your privacy matters to us. This Privacy Policy explains what information we collect, how we use it, and your rights regarding your data."
              : "Astrobobo'ya hos geldiniz. Gizliliginiz bizim icin onemlidir. Bu Gizlilik Politikasi, hangi bilgileri topladigimizi, bunlari nasil kullandigimizi ve verilerinizle ilgili haklarinizi aciklar."}
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
              : "Astrobobo, minimum veri toplama ilkesiyle tasarlanmistir. Topladigimiz veriler:"}
          </p>
          <ul className="list-disc list-inside mt-4 space-y-2 text-cosmic-muted">
            <li>
              {isEn
                ? "Zodiac sign preference: Stored locally in your browser via localStorage. This data never leaves your device."
                : "Burc tercihi: Tarayicinizda localStorage araciligiyla yerel olarak saklanir. Bu veri cihazinizdan hicbir zaman cikmaz."}
            </li>
            <li>
              {isEn
                ? "Standard analytics: We use privacy-friendly analytics to understand general usage patterns such as page views and session duration. No personally identifiable information is collected through analytics."
                : "Standart analitik: Sayfa goruntulemesi ve oturum suresi gibi genel kullanim kaliplarini anlamak icin gizlilik dostu analitik kullaniyoruz. Analitik araciligiyla kisisel olarak tanimlanabilir hicbir bilgi toplanmaz."}
            </li>
            <li>
              {isEn
                ? "No account required: You do not need to create an account or provide any personal information to use Astrobobo."
                : "Hesap gerektirmez: Astrobobo'yu kullanmak icin hesap olusturmaniz veya herhangi bir kisisel bilgi vermeniz gerekmez."}
            </li>
          </ul>
        </section>

        {/* No Data Sold */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "We Do Not Sell Your Data" : "Verilerinizi Satmiyoruz"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo does not sell, rent, or trade any personal data to third parties. We do not engage in data brokering of any kind. Your browsing habits and preferences stay with you."
              : "Astrobobo, hicbir kisisel veriyi ucuncu taraflara satmaz, kiralamaz veya takas etmez. Hicbir turde veri araciligina katilmayiz. Gezinme aliskanliklariniz ve tercihleriniz sizde kalir."}
          </p>
        </section>

        {/* Cookies */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Cookies" : "Cerezler"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo uses essential cookies to ensure the website functions correctly, such as remembering your language preference. We may also use analytics cookies to gather anonymous usage statistics. You can control cookie settings through your browser preferences."
              : "Astrobobo, web sitesinin dogru calismasi icin dil tercihinizi hatirlamak gibi temel cerezler kullanir. Ayrica anonim kullanim istatistikleri toplamak icin analitik cerezler kullanabiliriz. Cerez ayarlarini tarayici tercihleriniz araciligiyla kontrol edebilirsiniz."}
          </p>
        </section>

        {/* Third-Party Services */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Third-Party Services" : "Ucuncu Taraf Hizmetleri"}
          </h2>
          <p>
            {isEn
              ? "We may use third-party services for analytics and hosting. These services have their own privacy policies, and we encourage you to review them. We only partner with services that respect user privacy."
              : "Analitik ve barindirma icin ucuncu taraf hizmetleri kullanabiliriz. Bu hizmetlerin kendi gizlilik politikalari vardir ve bunlari incelemenizi oneririz. Yalnizca kullanici gizliligine saygi gosteren hizmetlerle calisiyoruz."}
          </p>
        </section>

        {/* Your Rights */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Your Rights" : "Haklariniz"}
          </h2>
          <p>
            {isEn
              ? "Since we store your zodiac sign preference only in your browser's localStorage, you have full control over this data. You can clear it at any time by clearing your browser data. If you have any questions about your data, feel free to reach out to us."
              : "Burc tercihinizi yalnizca tarayicinizin localStorage'inda sakladigimiz icin, bu veriler uzerinde tam kontrole sahipsiniz. Tarayici verilerinizi temizleyerek istediginiz zaman silebilirsiniz. Verileriniz hakkinda sorulariniz varsa bizimle iletisime gecmekten cekinmeyin."}
          </p>
        </section>

        {/* Contact */}
        <section className="mb-4">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Contact Us" : "Bize Ulasin"}
          </h2>
          <p>
            {isEn
              ? "If you have any questions or concerns about this Privacy Policy, please contact us at:"
              : "Bu Gizlilik Politikasi hakkinda sorulariniz veya endiseleriniz varsa, lutfen bizimle iletisime gecin:"}
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
