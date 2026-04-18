"use client";

import { useState, useCallback } from "react";

const MAJOR_ARCANA = [
  { num: 0, en: "The Fool", tr: "Deli", symbol: "🌟", up_en: "New beginnings, innocence, spontaneity. Trust the journey ahead.", up_tr: "Yeni başlangıçlar, masumiyet, kendiliğindenlik. Yolculuğa güven.", rev_en: "Recklessness, fear of the unknown. Pause and look before you leap.", rev_tr: "Düşüncesizlik, bilinmeyenden korku. Atlamadan önce dur ve bak." },
  { num: 1, en: "The Magician", tr: "Büyücü", symbol: "✨", up_en: "Manifestation, resourcefulness, power. You have everything you need.", up_tr: "Tezahür, beceriklilik, güç. İhtiyacın olan her şeye sahipsin.", rev_en: "Manipulation, untapped potential. Are you using your gifts authentically?", rev_tr: "Manipülasyon, kullanılmayan potansiyel. Yeteneklerini otantik mi kullanıyorsun?" },
  { num: 2, en: "The High Priestess", tr: "Yüksek Rahibe", symbol: "🌙", up_en: "Intuition, mystery, inner knowledge. Listen to the whispers beneath the noise.", up_tr: "Sezgi, gizem, içsel bilgi. Gürültünün altındaki fısıltıları dinle.", rev_en: "Secrets, withdrawal, disconnection from intuition. What are you avoiding?", rev_tr: "Sırlar, çekilme, sezgiden kopuş. Neden kaçınıyorsun?" },
  { num: 3, en: "The Empress", tr: "İmparatoriçe", symbol: "🌿", up_en: "Abundance, nurturing, fertility. Create from a place of love.", up_tr: "Bolluk, besleyicilik, bereket. Sevgi ve doluluktan yarat.", rev_en: "Creative block, dependence, neglecting self-care. Nurture yourself first.", rev_tr: "Yaratıcı blokaj, bağımlılık. Önce kendine bak." },
  { num: 4, en: "The Emperor", tr: "İmparator", symbol: "👑", up_en: "Authority, structure, stability. Build the framework your vision needs.", up_tr: "Otorite, yapı, istikrar. Vizyonunun ihtiyaç duyduğu çerçeveyi kur.", rev_en: "Rigidity, tyranny, loss of control. Loosen the grip.", rev_tr: "Katılık, tiranlık, kontrolü kaybetme. Tutuşunu gevşet." },
  { num: 5, en: "The Hierophant", tr: "Hierofant", symbol: "🔑", up_en: "Tradition, spiritual guidance. Seek wisdom from those who walked before you.", up_tr: "Gelenek, manevi rehberlik. Senden önce yürüyenlerden bilgelik ara.", rev_en: "Rebellion, personal beliefs over dogma. Question the rules.", rev_tr: "İsyan, dogma yerine kişisel inançlar. Kuralları sorgula." },
  { num: 6, en: "The Lovers", tr: "Aşıklar", symbol: "💕", up_en: "Love, harmony, choices. Align your heart and mind before deciding.", up_tr: "Aşk, uyum, tercihler. Karar vermeden önce kalbini ve aklını hizala.", rev_en: "Disharmony, imbalance, misalignment. Are your values aligned with your choices?", rev_tr: "Uyumsuzluk, dengesizlik. Değerlerin seçimlerinle uyumlu mu?" },
  { num: 7, en: "The Chariot", tr: "Savaş Arabası", symbol: "⚡", up_en: "Determination, willpower, triumph. Channel opposing forces toward your goal.", up_tr: "Kararlılık, irade gücü, zafer. Karşıt güçleri hedefe yönlendir.", rev_en: "Aggression, lack of direction. Where are you forcing instead of flowing?", rev_tr: "Saldırganlık, yön eksikliği. Nerede akmak yerine zorluyorsun?" },
  { num: 8, en: "Strength", tr: "Güç", symbol: "🦁", up_en: "Courage, patience, inner strength. True power is gentle and persistent.", up_tr: "Cesaret, sabır, iç güç. Gerçek güç nazik ve ısrarcıdır.", rev_en: "Self-doubt, insecurity. The lion within you hasn't gone anywhere.", rev_tr: "Kendinden şüphe, güvensizlik. İçindeki aslan hiçbir yere gitmedi." },
  { num: 9, en: "The Hermit", tr: "Ermiş", symbol: "🏔️", up_en: "Solitude, introspection, inner guidance. The answers you seek are within.", up_tr: "Yalnızlık, iç gözlem, içsel rehberlik. Aradığın cevaplar içinde.", rev_en: "Isolation, loneliness, withdrawal. Solitude heals; isolation hurts.", rev_tr: "İzolasyon, yalnızlık, çekilme. Yalnızlık iyileştirir; izolasyon acıtır." },
  { num: 10, en: "Wheel of Fortune", tr: "Kader Çarkı", symbol: "🎡", up_en: "Cycles, destiny, turning points. Embrace the change.", up_tr: "Döngüler, kader, dönüm noktaları. Değişimi kucakla.", rev_en: "Bad luck, resistance to change. This too shall pass.", rev_tr: "Kötü şans, değişime direnç. Bu da geçecek." },
  { num: 11, en: "Justice", tr: "Adalet", symbol: "⚖️", up_en: "Fairness, truth, accountability. Act with integrity.", up_tr: "Adalet, hakikat, sorumluluk. Dürüstlükle davran.", rev_en: "Injustice, dishonesty, avoidance. Face what needs to be faced.", rev_tr: "Adaletsizlik, sahtekarlık, kaçınma. Yüzleşilmesi gerekene yüzleş." },
  { num: 12, en: "The Hanged Man", tr: "Asılan Adam", symbol: "🙃", up_en: "Surrender, letting go, new perspective. Sometimes pausing IS the action.", up_tr: "Teslim olma, bırakma, yeni bakış açısı. Bazen durmak eylemin kendisidir.", rev_en: "Stalling, martyrdom, resistance. Stop sacrificing without purpose.", rev_tr: "Erteleme, kurban edicilik, direnç. Amaçsız fedakarlığı durdur." },
  { num: 13, en: "Death", tr: "Ölüm", symbol: "🦋", up_en: "Transformation, endings, renewal. Something must end for the new to begin.", up_tr: "Dönüşüm, sonlar, yenilenme. Yeni başlasın diye bir şeyin bitmesi gerek.", rev_en: "Resistance to change, stagnation. Let go of what's already gone.", rev_tr: "Değişime direnç, durgunluk. Gitmiş olanı bırak." },
  { num: 14, en: "Temperance", tr: "Denge", symbol: "🌈", up_en: "Balance, moderation, patience. Blend opposing energies into harmony.", up_tr: "Denge, ılımlılık, sabır. Karşıt enerjileri uyuma dönüştür.", rev_en: "Imbalance, excess, impatience. Where have you gone too far?", rev_tr: "Dengesizlik, aşırılık, sabırsızlık. Nerede çok ileri gittin?" },
  { num: 15, en: "The Devil", tr: "Şeytan", symbol: "⛓️", up_en: "Shadow, attachment, liberation. Name what binds you.", up_tr: "Gölge, bağımlılık, özgürleşme. Seni bağlayanı adlandır.", rev_en: "Breaking free, reclaiming power. The chains were never locked.", rev_tr: "Özgürleşme, gücü geri alma. Zincirler hiçbir zaman kilitli değildi." },
  { num: 16, en: "The Tower", tr: "Kule", symbol: "🗼", up_en: "Upheaval, revelation, breakthrough. What crumbles was never solid.", up_tr: "Altüst oluş, aydınlanma, çığır açma. Yıkılan hiçbir zaman sağlam değildi.", rev_en: "Averting disaster, fear of change. The tower wants to fall — let it.", rev_tr: "Felaketten kaçınma, değişim korkusu. Kule düşmek istiyor — bırak." },
  { num: 17, en: "The Star", tr: "Yıldız", symbol: "⭐", up_en: "Hope, inspiration, serenity. After the storm, the sky clears.", up_tr: "Umut, ilham, huzur. Fırtınadan sonra gökyüzü açılır.", rev_en: "Despair, disconnection, lost faith. The star is still there — clouds pass.", rev_tr: "Umutsuzluk, kopukluk, kayıp inanç. Yıldız hâlâ orada — bulutlar geçer." },
  { num: 18, en: "The Moon", tr: "Ay", symbol: "🌕", up_en: "Illusion, intuition, the unconscious. Not everything is as it seems.", up_tr: "Yanılsama, sezgi, bilinçaltı. Her şey göründüğü gibi değil.", rev_en: "Releasing fear, clarity emerging. The fog is lifting.", rev_tr: "Korkuyu bırakma, netlik beliriyor. Sis kalkıyor." },
  { num: 19, en: "The Sun", tr: "Güneş", symbol: "☀️", up_en: "Joy, success, vitality. Let yourself shine without apology.", up_tr: "Neşe, başarı, canlılık. Özür dilemeden parla.", rev_en: "Temporary sadness, lack of clarity. The sun hasn't disappeared — just a cloudy day.", rev_tr: "Geçici üzüntü, netlik eksikliği. Güneş kaybolmadı — sadece bulutlu bir gün." },
  { num: 20, en: "Judgement", tr: "Yargı", symbol: "🔔", up_en: "Rebirth, calling, absolution. Answer the call.", up_tr: "Yeniden doğuş, çağrı, bağışlanma. Çağrıya cevap ver.", rev_en: "Self-doubt, ignoring the call. What keeps you from answering?", rev_tr: "Kendinden şüphe, çağrıyı yok sayma. Seni cevap vermekten ne alıkoyuyor?" },
  { num: 21, en: "The World", tr: "Dünya", symbol: "🌍", up_en: "Completion, integration, accomplishment. A cycle ends — celebrate.", up_tr: "Tamamlanma, bütünleşme, başarı. Bir döngü sona eriyor — kutla.", rev_en: "Incompletion, shortcuts, unfinished business. What needs closure?", rev_tr: "Tamamlanmamışlık, kestirmeler, bitmemiş iş. Neyin kapanışa ihtiyacı var?" },
];

type CardDraw = { card: typeof MAJOR_ARCANA[0]; reversed: boolean };
type SpreadType = "single" | "three";

export default function TarotClient({ locale }: { locale: "en" | "tr" }) {
  const [spread, setSpread] = useState<SpreadType>("single");
  const [draws, setDraws] = useState<CardDraw[]>([]);
  const [isFlipping, setIsFlipping] = useState(false);
  const [isRevealed, setIsRevealed] = useState(false);
  const isEn = locale === "en";

  const pull = useCallback(() => {
    setIsFlipping(true);
    setIsRevealed(false);
    setDraws([]);

    const count = spread === "three" ? 3 : 1;
    const shuffled = [...MAJOR_ARCANA].sort(() => Math.random() - 0.5);
    const picked: CardDraw[] = shuffled.slice(0, count).map(c => ({
      card: c,
      reversed: Math.random() < 0.3,
    }));

    setTimeout(() => {
      setDraws(picked);
      setTimeout(() => {
        setIsRevealed(true);
        setIsFlipping(false);
      }, 600);
    }, 800);
  }, [spread]);

  const LABELS_3 = isEn
    ? ["Past", "Present", "Future"]
    : ["Geçmiş", "Şu An", "Gelecek"];

  return (
    <div className="flex flex-col items-center gap-8">
      <div className="flex gap-2">
        <button onClick={() => { setSpread("single"); setDraws([]); setIsRevealed(false); }}
          className={`px-4 py-2 rounded-xl text-sm ${spread === "single" ? 'bg-purple-500/20 border border-purple-500/40 text-white' : 'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>
          {isEn ? "Single Card" : "Tek Kart"}
        </button>
        <button onClick={() => { setSpread("three"); setDraws([]); setIsRevealed(false); }}
          className={`px-4 py-2 rounded-xl text-sm ${spread === "three" ? 'bg-purple-500/20 border border-purple-500/40 text-white' : 'bg-white/[0.04] border border-white/[0.08] text-cosmic-muted'}`}>
          {isEn ? "3-Card Spread" : "3 Kart Açılımı"}
        </button>
      </div>

      {draws.length === 0 && !isFlipping && (
        <div
          className="w-52 h-72 rounded-2xl cursor-pointer flex flex-col items-center justify-center"
          onClick={pull}
          style={{
            background: "linear-gradient(135deg, #1a1040 0%, #2d1b69 50%, #1a1040 100%)",
            border: "2px solid rgba(167, 139, 250, 0.3)",
            boxShadow: "0 20px 60px rgba(124, 58, 237, 0.3)",
          }}
        >
          <div className="text-5xl mb-3">🔮</div>
          <div className="text-sm font-display text-purple-300 tracking-widest">{isEn ? "TAP TO PULL" : "ÇEK"}</div>
          <div className="text-[10px] text-purple-400/60 mt-1">Major Arcana · {spread === "three" ? "3 cards" : "1 card"}</div>
        </div>
      )}

      {isFlipping && !isRevealed && (
        <div className="text-center text-cosmic-muted text-sm animate-pulse py-12">
          {isEn ? "Shuffling..." : "Karıştırılıyor..."}
        </div>
      )}

      {isRevealed && draws.length > 0 && (
        <div className={`${spread === "three" ? "grid grid-cols-3 gap-3 max-w-3xl" : "max-w-xs"} w-full`}>
          {draws.map((d, i) => (
            <div key={i} className="animate-in fade-in" style={{ animationDelay: `${i * 200}ms` }}>
              {spread === "three" && (
                <div className="text-center text-xs text-cosmic-muted uppercase tracking-wider mb-2">{LABELS_3[i]}</div>
              )}
              <div
                className="rounded-2xl p-5 text-center"
                style={{
                  background: "linear-gradient(180deg, #0d0820 0%, #1a1040 50%, #0d0820 100%)",
                  border: `2px solid ${d.reversed ? 'rgba(248,113,113,0.4)' : 'rgba(167,139,250,0.5)'}`,
                  boxShadow: `0 10px 30px ${d.reversed ? 'rgba(248,113,113,0.2)' : 'rgba(124,58,237,0.3)'}`,
                }}
              >
                <div className="text-[10px] text-purple-400/70 tracking-widest mb-1">{d.card.num}</div>
                <div className={`text-4xl mb-2 ${d.reversed ? 'rotate-180' : ''}`}>{d.card.symbol}</div>
                <h3 className="text-base font-display text-white mb-0.5">{isEn ? d.card.en : d.card.tr}</h3>
                {d.reversed && <div className="text-[10px] text-red-400 mb-1">{isEn ? "REVERSED" : "TERS"}</div>}
                <div className="w-8 h-px bg-purple-500/40 mx-auto my-2" />
                <p className="text-xs text-purple-200/80 leading-relaxed">
                  {d.reversed
                    ? (isEn ? d.card.rev_en : d.card.rev_tr)
                    : (isEn ? d.card.up_en : d.card.up_tr)}
                </p>
              </div>
            </div>
          ))}
        </div>
      )}

      {isRevealed && (
        <button onClick={pull}
          className="px-8 py-3 rounded-xl bg-purple-500/20 border border-purple-500/30 text-purple-300 hover:bg-purple-500/30 transition-all font-medium">
          {isEn ? "Pull Again" : "Tekrar Çek"}
        </button>
      )}

      <p className="text-xs text-cosmic-muted text-center max-w-md mt-4">
        {isEn ? "22 Major Arcana with upright & reversed meanings. For reflection, not prediction."
              : "22 Major Arcana düz ve ters anlamlarıyla. Tahmin değil, kişisel keşif amaçlıdır."}
      </p>
    </div>
  );
}
