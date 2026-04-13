"use client";

import { useState, useCallback } from "react";

const MAJOR_ARCANA = [
  { num: 0, en: "The Fool", tr: "Deli", symbol: "🌟", meaning_en: "New beginnings, innocence, spontaneity. Trust the journey ahead — even without seeing the full path.", meaning_tr: "Yeni başlangıçlar, masumiyet, kendiliğindenlik. Yolun tamamını görmeden de yolculuğa güven." },
  { num: 1, en: "The Magician", tr: "Büyücü", symbol: "✨", meaning_en: "Manifestation, resourcefulness, power. You have everything you need — use it wisely.", meaning_tr: "Tezahür, beceriklilik, güç. İhtiyacın olan her şeye sahipsin — bilgece kullan." },
  { num: 2, en: "The High Priestess", tr: "Yüksek Rahibe", symbol: "🌙", meaning_en: "Intuition, mystery, inner knowledge. Listen to the whispers beneath the noise.", meaning_tr: "Sezgi, gizem, içsel bilgi. Gürültünün altındaki fısıltıları dinle." },
  { num: 3, en: "The Empress", tr: "İmparatoriçe", symbol: "🌿", meaning_en: "Abundance, nurturing, fertility. Create from a place of love and fullness.", meaning_tr: "Bolluk, besleyicilik, bereket. Sevgi ve doluluktan yarat." },
  { num: 4, en: "The Emperor", tr: "İmparator", symbol: "👑", meaning_en: "Authority, structure, stability. Build the framework your vision needs.", meaning_tr: "Otorite, yapı, istikrar. Vizyonunun ihtiyaç duyduğu çerçeveyi kur." },
  { num: 5, en: "The Hierophant", tr: "Hierofant", symbol: "🔑", meaning_en: "Tradition, conformity, spiritual guidance. Seek wisdom from those who walked before you.", meaning_tr: "Gelenek, uyum, manevi rehberlik. Senden önce yürüyenlerden bilgelik ara." },
  { num: 6, en: "The Lovers", tr: "Aşıklar", symbol: "💕", meaning_en: "Love, harmony, choices. Align your heart and mind before deciding.", meaning_tr: "Aşk, uyum, tercihler. Karar vermeden önce kalbini ve aklını hizala." },
  { num: 7, en: "The Chariot", tr: "Savaş Arabası", symbol: "⚡", meaning_en: "Determination, willpower, triumph. Channel opposing forces toward your goal.", meaning_tr: "Kararlılık, irade gücü, zafer. Karşıt güçleri hedefe yönlendir." },
  { num: 8, en: "Strength", tr: "Güç", symbol: "🦁", meaning_en: "Courage, patience, inner strength. True power is gentle and persistent.", meaning_tr: "Cesaret, sabır, iç güç. Gerçek güç nazik ve ısrarcıdır." },
  { num: 9, en: "The Hermit", tr: "Ermiş", symbol: "🏔️", meaning_en: "Solitude, introspection, inner guidance. The answers you seek are within.", meaning_tr: "Yalnızlık, iç gözlem, içsel rehberlik. Aradığın cevaplar içinde." },
  { num: 10, en: "Wheel of Fortune", tr: "Kader Çarkı", symbol: "🎡", meaning_en: "Cycles, destiny, turning points. What goes around comes around — embrace the change.", meaning_tr: "Döngüler, kader, dönüm noktaları. Değişimi kucakla." },
  { num: 11, en: "Justice", tr: "Adalet", symbol: "⚖️", meaning_en: "Fairness, truth, accountability. Act with integrity and the scales will balance.", meaning_tr: "Adalet, hakikat, sorumluluk. Dürüstlükle davran, terazi dengelenecek." },
  { num: 12, en: "The Hanged Man", tr: "Asılan Adam", symbol: "🙃", meaning_en: "Surrender, letting go, new perspective. Sometimes pausing IS the action.", meaning_tr: "Teslim olma, bırakma, yeni bakış açısı. Bazen durmak eylemin kendisidir." },
  { num: 13, en: "Death", tr: "Ölüm", symbol: "🦋", meaning_en: "Transformation, endings, renewal. Something must end for the new to begin.", meaning_tr: "Dönüşüm, sonlar, yenilenme. Yeni başlasın diye bir şeyin bitmesi gerek." },
  { num: 14, en: "Temperance", tr: "Denge", symbol: "🌈", meaning_en: "Balance, moderation, patience. Blend opposing energies into harmony.", meaning_tr: "Denge, ılımlılık, sabır. Karşıt enerjileri uyuma dönüştür." },
  { num: 15, en: "The Devil", tr: "Şeytan", symbol: "⛓️", meaning_en: "Shadow, attachment, liberation. Name what binds you — that's the first step to freedom.", meaning_tr: "Gölge, bağımlılık, özgürleşme. Seni bağlayanı adlandır — özgürlüğün ilk adımı budur." },
  { num: 16, en: "The Tower", tr: "Kule", symbol: "🗼", meaning_en: "Upheaval, revelation, breakthrough. What crumbles was never solid. Build on truth.", meaning_tr: "Altüst oluş, aydınlanma, çığır açma. Yıkılan hiçbir zaman sağlam değildi. Hakikat üzerine inşa et." },
  { num: 17, en: "The Star", tr: "Yıldız", symbol: "⭐", meaning_en: "Hope, inspiration, serenity. After the storm, the sky clears. Trust.", meaning_tr: "Umut, ilham, huzur. Fırtınadan sonra gökyüzü açılır. Güven." },
  { num: 18, en: "The Moon", tr: "Ay", symbol: "🌕", meaning_en: "Illusion, intuition, the unconscious. Not everything is as it seems — look deeper.", meaning_tr: "Yanılsama, sezgi, bilinçaltı. Her şey göründüğü gibi değil — daha derine bak." },
  { num: 19, en: "The Sun", tr: "Güneş", symbol: "☀️", meaning_en: "Joy, success, vitality. Let yourself shine without apology.", meaning_tr: "Neşe, başarı, canlılık. Özür dilemeden parla." },
  { num: 20, en: "Judgement", tr: "Yargı", symbol: "🔔", meaning_en: "Rebirth, calling, absolution. Answer the call — your higher self is waiting.", meaning_tr: "Yeniden doğuş, çağrı, bağışlanma. Çağrıya cevap ver — yüksek benliğin seni bekliyor." },
  { num: 21, en: "The World", tr: "Dünya", symbol: "🌍", meaning_en: "Completion, integration, accomplishment. A cycle ends. Celebrate before the next one begins.", meaning_tr: "Tamamlanma, bütünleşme, başarı. Bir döngü sona eriyor. Yenisi başlamadan kutla." },
];

export default function TarotClient({ locale }: { locale: "en" | "tr" }) {
  const [card, setCard] = useState<typeof MAJOR_ARCANA[0] | null>(null);
  const [isFlipping, setIsFlipping] = useState(false);
  const [isRevealed, setIsRevealed] = useState(false);
  const isEn = locale === "en";

  const pullCard = useCallback(() => {
    setIsFlipping(true);
    setIsRevealed(false);
    setCard(null);

    setTimeout(() => {
      const randomCard = MAJOR_ARCANA[Math.floor(Math.random() * MAJOR_ARCANA.length)];
      setCard(randomCard);
      setTimeout(() => {
        setIsRevealed(true);
        setIsFlipping(false);
      }, 600);
    }, 800);
  }, []);

  return (
    <div className="flex flex-col items-center gap-8">
      {/* Card Area */}
      <div
        className="relative w-64 h-96 cursor-pointer"
        onClick={!isFlipping ? pullCard : undefined}
        style={{ perspective: "1000px" }}
      >
        <div
          className="w-full h-full transition-transform duration-700 relative"
          style={{
            transformStyle: "preserve-3d",
            transform: isRevealed ? "rotateY(180deg)" : "rotateY(0deg)",
          }}
        >
          {/* Card Back */}
          <div
            className="absolute inset-0 rounded-2xl flex flex-col items-center justify-center"
            style={{
              backfaceVisibility: "hidden",
              background: "linear-gradient(135deg, #1a1040 0%, #2d1b69 50%, #1a1040 100%)",
              border: "2px solid rgba(167, 139, 250, 0.3)",
              boxShadow: "0 20px 60px rgba(124, 58, 237, 0.3)",
            }}
          >
            <div className="text-6xl mb-4">🔮</div>
            <div className="text-lg font-display text-purple-300 tracking-widest">
              {isEn ? "TAP TO PULL" : "ÇEK"}
            </div>
            <div className="text-xs text-purple-400/60 mt-2">Major Arcana</div>
          </div>

          {/* Card Front */}
          {card && (
            <div
              className="absolute inset-0 rounded-2xl flex flex-col items-center justify-center p-6"
              style={{
                backfaceVisibility: "hidden",
                transform: "rotateY(180deg)",
                background: "linear-gradient(180deg, #0d0820 0%, #1a1040 50%, #0d0820 100%)",
                border: "2px solid rgba(167, 139, 250, 0.5)",
                boxShadow: "0 20px 60px rgba(124, 58, 237, 0.4), inset 0 0 60px rgba(167, 139, 250, 0.05)",
              }}
            >
              <div className="text-xs text-purple-400/70 tracking-widest mb-2">
                {card.num}
              </div>
              <div className="text-5xl mb-3">{card.symbol}</div>
              <h2 className="text-xl font-display text-white text-center mb-1">
                {isEn ? card.en : card.tr}
              </h2>
              <div className="w-12 h-px bg-purple-500/40 my-3" />
              <p className="text-sm text-purple-200/80 text-center leading-relaxed">
                {isEn ? card.meaning_en : card.meaning_tr}
              </p>
            </div>
          )}
        </div>
      </div>

      {/* Pull Again Button */}
      {isRevealed && (
        <button
          onClick={pullCard}
          className="px-8 py-3 rounded-xl bg-purple-500/20 border border-purple-500/30 text-purple-300 hover:bg-purple-500/30 transition-all font-medium"
        >
          {isEn ? "Pull Another Card" : "Başka Bir Kart Çek"}
        </button>
      )}

      {/* Disclaimer */}
      <p className="text-xs text-cosmic-muted text-center max-w-md mt-4">
        {isEn
          ? "This is for entertainment and personal reflection only. Not a substitute for professional advice."
          : "Bu yalnızca eğlence ve kişisel keşif amaçlıdır. Profesyonel danışmanlık yerine geçmez."}
      </p>
    </div>
  );
}
