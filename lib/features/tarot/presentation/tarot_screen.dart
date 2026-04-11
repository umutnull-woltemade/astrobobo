import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/tarot_service.dart';
import '../../../data/content/tarot_content.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';
import '../../../shared/widgets/quiz_cta_card.dart';

class TarotScreen extends ConsumerStatefulWidget {
  const TarotScreen({super.key});

  @override
  ConsumerState<TarotScreen> createState() => _TarotScreenState();
}

class _TarotScreenState extends ConsumerState<TarotScreen> {
  TarotCard? _dailyCard;
  ThreeCardSpread? _threeCardSpread;
  LoveSpread? _loveSpread;
  YesNoReading? _yesNoReading;
  String _selectedSpread = 'daily';
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    _dailyCard = TarotService.getDailyCard(DateTime.now());
  }

  void _drawThreeCards() {
    setState(() {
      _threeCardSpread = TarotService.drawThreeCards();
      _selectedSpread = 'three';
      _isRevealed = false;
    });
  }

  void _drawLoveSpread() {
    setState(() {
      _loveSpread = TarotService.drawLoveSpread();
      _selectedSpread = 'love';
      _isRevealed = false;
    });
  }

  void _drawYesNo() {
    setState(() {
      _yesNoReading = TarotService.drawYesNoCard();
      _selectedSpread = 'yesno';
      _isRevealed = false;
    });
  }

  void _revealCards() {
    setState(() {
      _isRevealed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                snap: true,
                title: Text(
                  'Kartlar sana ne söylüyor?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.starGold,
                    fontSize: 20,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Ezoterik giriş
                    _buildEsotericIntro(context),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Açılım seçenekleri
                    _buildSpreadOptions(context),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Seçilen açılım
                    if (_selectedSpread == 'daily')
                      _buildDailyCard(context)
                    else if (_selectedSpread == 'three' &&
                        _threeCardSpread != null)
                      _buildThreeCardSpread(context)
                    else if (_selectedSpread == 'love' && _loveSpread != null)
                      _buildLoveSpread(context)
                    else if (_selectedSpread == 'yesno' &&
                        _yesNoReading != null)
                      _buildYesNoReading(context),

                    const SizedBox(height: AppConstants.spacingLg),

                    // Major Arcana Grid
                    _buildMajorArcanaSection(context),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Quiz CTA - Google Discover Funnel
                    QuizCTACard.general(compact: true),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Kadim Not - Tarot bilgeliği
                    const KadimNotCard(
                      title: 'Arketiplerin Dansı',
                      content:
                          'Her Tarot kartı, kolektif bilinçaltının bir arketipidir. Jung\'un dediği gibi, bu semboller insanlığın ortak rüyalarından doğmuştur. Bir kart çektiğinde, evrenle bir diyalog başlatıyorsun. Cevap kartın kendisinde değil, onunla kurduğun bağlantıda.',
                      category: KadimCategory.tarot,
                      source: 'Jungiyen Sembolizm',
                    ),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Next Blocks - Sonraki öneriler
                    const NextBlocks(currentPage: 'tarot'),
                    const SizedBox(height: AppConstants.spacingXl),
                    // Back-Button-Free Navigation
                    const PageBottomNavigation(currentRoute: '/tarot'),
                    const SizedBox(height: AppConstants.spacingLg),
                    // Disclaimer
                    const PageFooterWithDisclaimer(
                      brandText: 'Tarot — Venus One',
                      disclaimerText: DisclaimerTexts.tarot,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEsotericIntro(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.auroraEnd.withAlpha(25), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.auroraEnd.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.auroraEnd,
                size: 18,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Kadim Bilgeliğin Anahtarları',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.auroraEnd,
                    fontStyle: FontStyle.italic,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Tarot, bilinçaltının aynasıdır. Bu kartlar geleceği değil, olasılıkları gösterir. Her çekiş, şu anki enerji alanını ve potansiyel yolları ortaya koyar. Kartlara bir soru sor veya sadece rehberlik iste. Sezgine güven - cevaplar zaten içinde.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSpreadOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Açılım Seç',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Wrap(
          spacing: AppConstants.spacingMd,
          runSpacing: AppConstants.spacingMd,
          children: [
            _buildSpreadButton(
              context,
              'Günün Kartı',
              Icons.today,
              AppColors.starGold,
              () => setState(() => _selectedSpread = 'daily'),
              _selectedSpread == 'daily',
            ),
            _buildSpreadButton(
              context,
              '3 Kart',
              Icons.view_column,
              AppColors.auroraStart,
              _drawThreeCards,
              _selectedSpread == 'three',
            ),
            _buildSpreadButton(
              context,
              'Aşk Açılımı',
              Icons.favorite,
              AppColors.fireElement,
              _drawLoveSpread,
              _selectedSpread == 'love',
            ),
            _buildSpreadButton(
              context,
              'Evet/Hayır',
              Icons.help_outline,
              AppColors.waterElement,
              _drawYesNo,
              _selectedSpread == 'yesno',
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildSpreadButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [color.withAlpha(100), color.withAlpha(50)],
                )
              : null,
          color: isSelected ? null : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: isSelected ? color : color.withAlpha(76),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected ? AppColors.textPrimary : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyCard(BuildContext context) {
    if (_dailyCard == null) return const SizedBox.shrink();

    return Column(
      children: [
        Text(
          'Günün Kartı',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.starGold),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _buildSingleCard(context, _dailyCard!, true, AppColors.starGold),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildThreeCardSpread(BuildContext context) {
    return Column(
      children: [
        Text(
          'Geçmiş - Şimdi - Gelecek',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.auroraStart),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        if (!_isRevealed)
          ElevatedButton.icon(
            onPressed: _revealCards,
            icon: const Icon(Icons.visibility),
            label: const Text('Kartları Aç'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.auroraStart,
              foregroundColor: Colors.white,
            ),
          )
        else
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _threeCardSpread!.past,
                      'Geçmiş',
                      Colors.grey,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _threeCardSpread!.present,
                      'Şimdi',
                      AppColors.auroraStart,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _threeCardSpread!.future,
                      'Gelecek',
                      AppColors.starGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingLg),
              _buildInterpretationCard(
                context,
                _threeCardSpread!.interpretation,
              ),
            ],
          ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildLoveSpread(BuildContext context) {
    return Column(
      children: [
        Text(
          'Aşk Açılımı',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.fireElement),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        if (!_isRevealed)
          ElevatedButton.icon(
            onPressed: _revealCards,
            icon: const Icon(Icons.favorite),
            label: const Text('Kartları Aç'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.fireElement,
              foregroundColor: Colors.white,
            ),
          )
        else
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _loveSpread!.youCard,
                      'Sen',
                      AppColors.waterElement,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _loveSpread!.partnerCard,
                      'Partner',
                      AppColors.fireElement,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingSm),
              _buildMiniCard(
                context,
                _loveSpread!.relationshipCard,
                'İlişki',
                AppColors.auroraStart,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _loveSpread!.challengeCard,
                      'Zorluk',
                      Colors.red,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: _buildMiniCard(
                      context,
                      _loveSpread!.adviceCard,
                      'Tavsiye',
                      AppColors.starGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingLg),
              _buildInterpretationCard(context, _loveSpread!.interpretation),
            ],
          ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildYesNoReading(BuildContext context) {
    return Column(
      children: [
        Text(
          'Evet / Hayır',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.waterElement),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        if (!_isRevealed)
          ElevatedButton.icon(
            onPressed: _revealCards,
            icon: const Icon(Icons.help_outline),
            label: const Text('Cevabı Gör'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.waterElement,
              foregroundColor: Colors.white,
            ),
          )
        else
          Column(
            children: [
              _buildSingleCard(
                context,
                _yesNoReading!.card,
                true,
                AppColors.waterElement,
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getAnswerColor(_yesNoReading!.answer).withAlpha(50),
                      AppColors.surfaceDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  border: Border.all(
                    color: _getAnswerColor(
                      _yesNoReading!.answer,
                    ).withAlpha(128),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _yesNoReading!.answer,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: _getAnswerColor(_yesNoReading!.answer),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      _yesNoReading!.explanation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Color _getAnswerColor(String answer) {
    if (answer.contains('Evet')) return Colors.green;
    if (answer.contains('Hayır')) return Colors.red;
    return AppColors.warning;
  }

  Widget _buildSingleCard(
    BuildContext context,
    TarotCard card,
    bool showDetails,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withAlpha(50), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withAlpha(128)),
      ),
      child: Column(
        children: [
          // Kart görseli placeholder
          Container(
            width: 150,
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withAlpha(100), AppColors.surfaceDark],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 2),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(50),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  card.number.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (card.isReversed)
                  Transform.rotate(
                    angle: 3.14159,
                    child: Icon(Icons.arrow_upward, color: color, size: 24),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            '${card.nameTr}${card.isReversed ? ' (Ters)' : ''}',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: color),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            card.keywordsTr,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          if (showDetails) ...[
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              card.currentMeaning,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            // Ezoterik Bilgi Kartı
            _buildEsotericInfoCard(context, card, color),
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      card.advice,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEsotericInfoCard(
    BuildContext context,
    TarotCard card,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceDark, color.withAlpha(15)],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: AppColors.starGold, size: 16),
              const SizedBox(width: 8),
              Text(
                'Ezoterik Sırlar',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          if (card.esotericMeaning.isNotEmpty) ...[
            Text(
              card.esotericMeaning,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                height: 1.7,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
          ],
          // Ezoterik Özellikler Grid
          Wrap(
            spacing: AppConstants.spacingSm,
            runSpacing: AppConstants.spacingSm,
            children: [
              if (card.archetype.isNotEmpty)
                _buildEsotericTag(
                  context,
                  'Arketip',
                  card.archetype,
                  Colors.purple,
                ),
              if (card.element.isNotEmpty)
                _buildEsotericTag(
                  context,
                  'Element',
                  card.element,
                  Colors.blue,
                ),
              if (card.astrologicalSign.isNotEmpty)
                _buildEsotericTag(
                  context,
                  'Gezegen/Burç',
                  card.astrologicalSign,
                  Colors.orange,
                ),
              if (card.hebrewLetter.isNotEmpty)
                _buildEsotericTag(
                  context,
                  'İbrani Harf',
                  card.hebrewLetter,
                  Colors.teal,
                ),
              if (card.pathOnTree.isNotEmpty)
                _buildEsotericTag(
                  context,
                  'Hayat Ağacı',
                  card.pathOnTree,
                  AppColors.starGold,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEsotericTag(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color.withAlpha(180),
              fontSize: 9,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(
    BuildContext context,
    TarotCard card,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withAlpha(50), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withAlpha(80), AppColors.surfaceDark],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color),
            ),
            child: Center(
              child: Text(
                card.number.toString(),
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: color),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            card.nameTr,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (card.isReversed)
            Text(
              '(Ters)',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInterpretationCard(BuildContext context, String interpretation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.starGold,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Yorum',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMajorArcanaSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.style, color: AppColors.auroraEnd, size: 20),
            const SizedBox(width: 8),
            Text(
              '22 Major Arcana',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.auroraEnd,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              'Kartlara dokun',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 22,
            itemBuilder: (context, index) {
              final card = majorArcanaContents[index];
              if (card == null) return const SizedBox.shrink();

              final color = _getMajorArcanaColor(index);

              return GestureDetector(
                    onTap: () => context.push('/tarot/major/$index'),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color.withAlpha(80), AppColors.surfaceDark],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: color.withAlpha(150)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getRomanNumeral(index),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              card.nameTr,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 9,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate(delay: Duration(milliseconds: index * 30))
                  .fadeIn(duration: 300.ms)
                  .slideX(begin: 0.2, end: 0);
            },
          ),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  String _getRomanNumeral(int number) {
    final romanNumerals = [
      '0',
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
      'XIII',
      'XIV',
      'XV',
      'XVI',
      'XVII',
      'XVIII',
      'XIX',
      'XX',
      'XXI',
    ];
    return romanNumerals[number];
  }

  Color _getMajorArcanaColor(int number) {
    final colors = [
      const Color(0xFF00BCD4), // Fool
      const Color(0xFFFFD700), // Magician
      const Color(0xFF9C27B0), // High Priestess
      const Color(0xFF4CAF50), // Empress
      const Color(0xFFF44336), // Emperor
      const Color(0xFF795548), // Hierophant
      const Color(0xFFE91E63), // Lovers
      const Color(0xFF607D8B), // Chariot
      const Color(0xFFFF9800), // Strength
      const Color(0xFF3F51B5), // Hermit
      const Color(0xFF9E9E9E), // Wheel
      const Color(0xFFCDDC39), // Justice
      const Color(0xFF2196F3), // Hanged Man
      const Color(0xFF212121), // Death
      const Color(0xFF00BCD4), // Temperance
      const Color(0xFF8B0000), // Devil
      const Color(0xFFFFEB3B), // Tower
      const Color(0xFF7C4DFF), // Star
      const Color(0xFFC0C0C0), // Moon
      const Color(0xFFFFD700), // Sun
      const Color(0xFF9C27B0), // Judgement
      const Color(0xFF4CAF50), // World
    ];
    return colors[number % colors.length];
  }
}
