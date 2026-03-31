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

  const title = isEn ? "Terms of Service" : "Kullanım Koşulları";
  const description = isEn
    ? "Read the Terms of Service for using the Astrobobo website."
    : "Astrobobo web sitesini kullanmaya ilişkin Kullanım Koşullarını okuyun.";

  return {
    title,
    description,
    openGraph: {
      title: `${title} | Astrobobo`,
      description,
      url: isEn ? "/terms" : `/${locale}/terms`,
    },
  };
}

export default async function TermsOfServicePage({ params }: PageProps) {
  const { locale } = await params;
  if (!locales.includes(locale as Locale)) notFound();

  const isEn = locale === "en";

  return (
    <div className="max-w-3xl mx-auto px-4 py-12">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-display text-cosmic-accent mb-4">
          {isEn ? "Terms of Service" : "Kullanım Koşulları"}
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
              ? "Welcome to Astrobobo. By accessing or using our website, you agree to be bound by these Terms of Service. If you do not agree with any part of these terms, please do not use our website."
              : "Astrobobo'ya hoş geldiniz. Web sitemize erişerek veya kullanarak bu Kullanım Koşullarına bağlı olmayı kabul edersiniz. Bu koşulların herhangi bir bölümünü kabul etmiyorsanız, lütfen web sitemizi kullanmayın."}
          </p>
        </section>

        {/* Nature of Content */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Educational & Reflective Content" : "Eğitim ve Düşünce İçeriği"}
          </h2>
          <p>
            {isEn
              ? "All content on Astrobobo is provided for educational and reflective purposes only. Our astrology content is designed to inspire self-reflection and personal exploration. It is not intended as predictive, prescriptive, or factual guidance about future events."
              : "Astrobobo'daki tüm içerik yalnızca eğitim ve düşünce amacıyla sunulmaktadır. Astroloji içeriğimiz, öz-düşünce ve kişisel keşfi teşvik etmek için tasarlanmıştır. Gelecekteki olaylar hakkında tahmine dayalı, reçete niteliğinde veya olgusal bir rehberlik olarak tasarlanmamıştır."}
          </p>
          <p className="mt-4">
            {isEn
              ? "Astrobobo does not claim that astrological interpretations are scientifically proven or that they can predict specific outcomes in your life. Content should be enjoyed as a tool for contemplation and self-awareness."
              : "Astrobobo, astrolojik yorumların bilimsel olarak kanıtlandığını veya hayatınızdaki belirli sonuçları tahmin edebileceğini iddia etmez. İçerik, tefekkür ve öz-farkındalık için bir araç olarak değerlendirilmelidir."}
          </p>
        </section>

        {/* No Professional Advice */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "No Professional Advice" : "Profesyonel Tavsiye Değildir"}
          </h2>
          <p>
            {isEn
              ? "The content on Astrobobo does not constitute medical, psychological, financial, legal, or any other form of professional advice. You should not rely on our content as a substitute for professional consultation. Always seek the advice of qualified professionals for matters concerning your health, finances, or legal affairs."
              : "Astrobobo'daki içerik tıbbi, psikolojik, finansal, hukuki veya herhangi bir profesyonel tavsiye niteliğinde değildir. İçeriğimize profesyonel danışmanlığın yerine geçmesi için güvenilmemelidir. Sağlığınız, mali durumunuz veya hukuki işlerinizle ilgili konularda her zaman uzman profesyonellerin tavsiyesini alın."}
          </p>
        </section>

        {/* No Guarantees */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "No Guarantees" : "Garanti Yoktur"}
          </h2>
          <p>
            {isEn
              ? "Astrobobo provides its content on an \"as is\" and \"as available\" basis. We make no warranties or representations, express or implied, about the completeness, accuracy, reliability, or suitability of the content. Your use of any information on this website is entirely at your own risk."
              : "Astrobobo, içeriğini \"olduğu gibi\" ve \"mevcut olduğu şekliyle\" sunar. İçeriğin eksiksizliği, doğruluğu, güvenilirliği veya uygunluğu hakkında açık veya zımni hiçbir garanti veya beyan vermiyoruz. Bu web sitesindeki herhangi bir bilgiyi kullanımınız tamamen kendi riskiniz dahilindedir."}
          </p>
        </section>

        {/* Intellectual Property */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Intellectual Property" : "Fikri Mülkiyet"}
          </h2>
          <p>
            {isEn
              ? "All content on Astrobobo, including but not limited to text, graphics, logos, images, illustrations, and software, is the property of Astrobobo or its content creators and is protected by international copyright and intellectual property laws."
              : "Astrobobo'daki metin, grafik, logo, görsel, illüstrasyon ve yazılım dahil ancak bunlarla sınırlı olmamak üzere tüm içerik, Astrobobo'nun veya içerik oluşturucularının mülkiyetindedir ve uluslararası telif hakkı ve fikri mülkiyet yasalarıyla korunmaktadır."}
          </p>
          <p className="mt-4">
            {isEn
              ? "You may not reproduce, distribute, modify, or create derivative works from any content on this website without prior written permission from Astrobobo."
              : "Astrobobo'dan önceden yazılı izin almadan bu web sitesindeki herhangi bir içeriği çoğaltamaz, dağıtamaz, değiştiremez veya türev eserler oluşturamazsınız."}
          </p>
        </section>

        {/* Limitation of Liability */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Limitation of Liability" : "Sorumluluk Sınırlaması"}
          </h2>
          <p>
            {isEn
              ? "To the fullest extent permitted by applicable law, Astrobobo and its operators shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from:"
              : "Yürürlükteki yasaların izin verdiği azami ölçüde, Astrobobo ve işletmecileri, aşağıdakilerden kaynaklanan doğrudan veya dolaylı olarak maruz kalınan herhangi bir dolaylı, arızi, özel, sonuç olarak ortaya çıkan veya cezai zarar ile kâr veya gelir kaybı ya da veri, kullanım, itibar veya diğer maddi olmayan kayıplardan sorumlu tutulamaz:"}
          </p>
          <ul className="list-disc list-inside mt-4 space-y-2 text-cosmic-muted">
            <li>
              {isEn
                ? "Your access to or use of, or inability to access or use, the website"
                : "Web sitesine erişmeniz veya kullanımınız ya da erişememeniz veya kullanamamanız"}
            </li>
            <li>
              {isEn
                ? "Any content or conduct of any third party on the website"
                : "Web sitesindeki herhangi bir üçüncü tarafın içeriği veya davranışı"}
            </li>
            <li>
              {isEn
                ? "Any decisions made or actions taken based on content from this website"
                : "Bu web sitesindeki içeriklere dayanılarak alınan kararlar veya gerçekleştirilen eylemler"}
            </li>
          </ul>
        </section>

        {/* Changes to Terms */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Changes to These Terms" : "Bu Koşullardaki Değişiklikler"}
          </h2>
          <p>
            {isEn
              ? "We reserve the right to modify these Terms of Service at any time. Changes will be effective immediately upon posting to this page. Your continued use of the website after any modifications constitutes your acceptance of the updated terms."
              : "Bu Kullanım Koşullarını istediğimiz zaman değiştirme hakkını saklı tutarız. Değişiklikler bu sayfada yayınlandığı anda yürürlüğe girer. Herhangi bir değişiklikten sonra web sitesini kullanmaya devam etmeniz, güncellenmiş koşulları kabul ettiğiniz anlamına gelir."}
          </p>
        </section>

        {/* Contact */}
        <section className="mb-4">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Contact Us" : "Bize Ulaşın"}
          </h2>
          <p>
            {isEn
              ? "If you have any questions about these Terms of Service, please contact us at:"
              : "Bu Kullanım Koşulları hakkında sorularınız varsa, lütfen bizimle iletişime geçin:"}
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
