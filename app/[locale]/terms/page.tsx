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

  const title = isEn ? "Terms of Service" : "Kullanim Kosullari";
  const description = isEn
    ? "Read the Terms of Service for using the Astrobobo website."
    : "Astrobobo web sitesini kullanmaya iliskin Kullanim Kosullarini okuyun.";

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
          {isEn ? "Terms of Service" : "Kullanim Kosullari"}
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
              ? "Welcome to Astrobobo. By accessing or using our website, you agree to be bound by these Terms of Service. If you do not agree with any part of these terms, please do not use our website."
              : "Astrobobo'ya hos geldiniz. Web sitemize eriserek veya kullanarak bu Kullanim Kosullarina bagli olmayi kabul edersiniz. Bu kosullarin herhangi bir bolumunu kabul etmiyorsaniz, lutfen web sitemizi kullanmayin."}
          </p>
        </section>

        {/* Nature of Content */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Educational & Reflective Content" : "Egitim ve Dusunce Icerigi"}
          </h2>
          <p>
            {isEn
              ? "All content on Astrobobo is provided for educational and reflective purposes only. Our astrology content is designed to inspire self-reflection and personal exploration. It is not intended as predictive, prescriptive, or factual guidance about future events."
              : "Astrobobo'daki tum icerik yalnizca egitim ve dusunce amaciyla sunulmaktadir. Astroloji icerigimiz, oz-dusunce ve kisisel kesfi tesvik etmek icin tasarlanmistir. Gelecekteki olaylar hakkinda tahmine dayali, reçete nitelginde veya olgusal bir rehberlik olarak tasarlanmamistir."}
          </p>
          <p className="mt-4">
            {isEn
              ? "Astrobobo does not claim that astrological interpretations are scientifically proven or that they can predict specific outcomes in your life. Content should be enjoyed as a tool for contemplation and self-awareness."
              : "Astrobobo, astrolojik yorumlarin bilimsel olarak kanitlandigini veya hayatinizdaki belirli sonuclari tahmin edebilecegini iddia etmez. Icerik, tefekkur ve oz-farkindalik icin bir arac olarak degerlendirilmelidir."}
          </p>
        </section>

        {/* No Professional Advice */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "No Professional Advice" : "Profesyonel Tavsiye Degildir"}
          </h2>
          <p>
            {isEn
              ? "The content on Astrobobo does not constitute medical, psychological, financial, legal, or any other form of professional advice. You should not rely on our content as a substitute for professional consultation. Always seek the advice of qualified professionals for matters concerning your health, finances, or legal affairs."
              : "Astrobobo'daki icerik tibbi, psikolojik, finansal, hukuki veya herhangi bir profesyonel tavsiye niteliginde degildir. Icerigimize profesyonel danismanligin yerine gecmesi icin guvenilmemelidir. Sagliginiz, mali durumunuz veya hukuki islerinizle ilgili konularda her zaman uzman profesyonellerin tavsiyesini alin."}
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
              : "Astrobobo, icerigini \"oldugu gibi\" ve \"mevcut oldugu sekliyle\" sunar. Icerigin eksiksizligi, dogrulugu, guvenilirligi veya uygunlugu hakkinda acik veya zimni hicbir garanti veya beyan vermiyoruz. Bu web sitesindeki herhangi bir bilgiyi kullaniminiz tamamen kendi riskiniz dahilindedir."}
          </p>
        </section>

        {/* Intellectual Property */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Intellectual Property" : "Fikri Mulkiyet"}
          </h2>
          <p>
            {isEn
              ? "All content on Astrobobo, including but not limited to text, graphics, logos, images, illustrations, and software, is the property of Astrobobo or its content creators and is protected by international copyright and intellectual property laws."
              : "Astrobobo'daki metin, grafik, logo, gorsel, illustrasyon ve yazilim dahil ancak bunlarla sinirli olmamak uzere tum icerik, Astrobobo'nun veya icerik olusturucularinin mulkiyetindedir ve uluslararasi telif hakki ve fikri mulkiyet yasalariyla korunmaktadir."}
          </p>
          <p className="mt-4">
            {isEn
              ? "You may not reproduce, distribute, modify, or create derivative works from any content on this website without prior written permission from Astrobobo."
              : "Astrobobo'dan onceden yazili izin almadan bu web sitesindeki herhangi bir icerigi cogaltamaz, dagitamaz, degistiremez veya turev eserler olusuturamazsiniz."}
          </p>
        </section>

        {/* Limitation of Liability */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Limitation of Liability" : "Sorumluluk Sinirlamasi"}
          </h2>
          <p>
            {isEn
              ? "To the fullest extent permitted by applicable law, Astrobobo and its operators shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from:"
              : "Yururlukteki yasalarin izin verdigi azami olcude, Astrobobo ve isletmecileri, asagidakilerden kaynaklanan dogrudan veya dolayli olarak maruz kalinan herhangi bir dolayli, arizi, ozel, sonuc olarak ortaya cikan veya cezai zarar ile kar veya gelir kaybi ya da veri, kullanim, itibar veya diger maddi olmayan kayiplardan sorumlu tutulamaz:"}
          </p>
          <ul className="list-disc list-inside mt-4 space-y-2 text-cosmic-muted">
            <li>
              {isEn
                ? "Your access to or use of, or inability to access or use, the website"
                : "Web sitesine erismeniz veya kullaniminiz ya da erisenememeniz veya kullanamamaniz"}
            </li>
            <li>
              {isEn
                ? "Any content or conduct of any third party on the website"
                : "Web sitesindeki herhangi bir ucuncu tarafin icerigi veya davranisi"}
            </li>
            <li>
              {isEn
                ? "Any decisions made or actions taken based on content from this website"
                : "Bu web sitesindeki iceriklere dayanilarak alinan kararlar veya gerceklestirilen eylemler"}
            </li>
          </ul>
        </section>

        {/* Changes to Terms */}
        <section className="mb-10">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Changes to These Terms" : "Bu Kosullardaki Degisiklikler"}
          </h2>
          <p>
            {isEn
              ? "We reserve the right to modify these Terms of Service at any time. Changes will be effective immediately upon posting to this page. Your continued use of the website after any modifications constitutes your acceptance of the updated terms."
              : "Bu Kullanim Kosullarini istedigimiz zaman degistirme hakkini sakli tutariz. Degisiklikler bu sayfada yayinlandigi anda yururluge girer. Herhangi bir degisiklikten sonra web sitesini kullanmaya devam etmeniz, guncellenmis kosullari kabul ettiginiz anlamina gelir."}
          </p>
        </section>

        {/* Contact */}
        <section className="mb-4">
          <h2 className="cosmic-heading text-2xl mb-4">
            {isEn ? "Contact Us" : "Bize Ulasin"}
          </h2>
          <p>
            {isEn
              ? "If you have any questions about these Terms of Service, please contact us at:"
              : "Bu Kullanim Kosullari hakkinda sorulariniz varsa, lutfen bizimle iletisime gecin:"}
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
