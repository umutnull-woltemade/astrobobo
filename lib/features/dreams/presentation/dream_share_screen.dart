import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../data/services/io_stub.dart'
    if (dart.library.io) '../../../data/services/io_real.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/dream_interpretation_models.dart';
import '../../../data/services/moon_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/dream_share_card.dart';
import '../../../shared/widgets/gradient_button.dart';

/// Dream Sharing Screen with Social Features
/// Allows users to create shareable cards from dream interpretations
class DreamShareScreen extends ConsumerStatefulWidget {
  final FullDreamInterpretation? interpretation;
  final String? quickShareText;
  final String? quickShareSymbol;

  const DreamShareScreen({
    super.key,
    this.interpretation,
    this.quickShareText,
    this.quickShareSymbol,
  });

  @override
  ConsumerState<DreamShareScreen> createState() => _DreamShareScreenState();
}

class _DreamShareScreenState extends ConsumerState<DreamShareScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey _cardKey = GlobalKey();

  // Card configuration state
  DreamShareCardConfig _config = const DreamShareCardConfig();
  DreamCardTemplate _selectedTemplate = DreamCardTemplate.dreamQuote;

  // Content state
  String _mainText = '';
  String _subtitle = '';
  String _headerEmoji = '\u{1F319}';

  // Privacy settings
  bool _shareAnonymously = false;
  bool _shareInterpretationOnly = false;
  bool _shareSymbolOnly = false;

  // Generated content
  String? _generatedPoetry;
  String? _generatedAffirmation;
  List<String> _symbolArtSuggestions = [];

  // Share state
  bool _isSharing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeContent();
    _generateContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeContent() {
    if (widget.interpretation != null) {
      final interp = widget.interpretation!;
      _mainText = interp.whisperQuote;
      _subtitle = interp.archetypeName;
      _headerEmoji = interp.shareCard.emoji;
    } else if (widget.quickShareText != null) {
      _mainText = widget.quickShareText!;
      _headerEmoji = widget.quickShareSymbol ?? '\u{1F319}';
    } else {
      // Default content
      _mainText = 'Ruyalarimin icinde kayboldum, kendimi buldum.';
      _headerEmoji = '\u{1F319}';
    }
  }

  void _generateContent() {
    // Generate poetry based on dream
    _generatedPoetry = _generateDreamPoetry();
    _generatedAffirmation = _generateDreamAffirmation();
    _symbolArtSuggestions = _generateSymbolArtSuggestions();
  }

  String _generateDreamPoetry() {
    if (widget.interpretation == null) {
      return 'Gece kainatin sessiz fisildamasi,\n'
          'Ruyalar ruhumun aynadaki yansimasi.\n'
          'Her sembol bir mesaj, her an bir keşif,\n'
          'Bilinçaltindan gelen kudretli bir hediye.';
    }

    final symbols = widget.interpretation!.symbols;
    final mainSymbol = symbols.isNotEmpty ? symbols.first.symbol : 'gizem';
    final archetype = widget.interpretation!.archetypeName;

    final poetryTemplates = [
      'Gecenin derinliklerinde $mainSymbol belirdi,\n'
          '$archetype arketipi ruhuma seslendi.\n'
          'Bilincaltinin sifreli mesajlari,\n'
          'Simdi anlamin isiginda parlıyor.',
      'Ruya aleminin kapilari aralandi,\n'
          '$mainSymbol sembolü yolumu aydinlatti.\n'
          'Kadim bilgelik fisildadi kulağima,\n'
          '$archetype enerjisi sardi tum benligimi.',
      'Ay isiginda dans eden golgeler,\n'
          '$mainSymbol bana hikayeler anlatti.\n'
          '$archetype\'in izinde yuruyorum,\n'
          'Ruyamin bilgeligini kalbime nakşettim.',
    ];

    return poetryTemplates[DateTime.now().microsecond % poetryTemplates.length];
  }

  String _generateDreamAffirmation() {
    if (widget.interpretation == null) {
      return 'Ruyalarim bana yol gosteriyor, onlara guveniyorum.';
    }

    final guidance = widget.interpretation!.guidance;
    final moonPhase = MoonService.getCurrentPhase();

    final affirmations = [
      '${moonPhase.emoji} ${guidance.todayAction}',
      'Bilinçaltimin bilgeligine guveniyorum ve mesajlarini anliyorum.',
      'Her ruya beni kendime daha da yaklastiriyor.',
      'Golgelerimi kabul ediyor, isigimi parlak tutuyorum.',
      'Kozmik rehberlige acigim ve yolculugumda destekleniyorum.',
    ];

    return affirmations[DateTime.now().second % affirmations.length];
  }

  List<String> _generateSymbolArtSuggestions() {
    if (widget.interpretation == null) {
      return [
        '\u{1F319} Ay ve yildizlar kompozisyonu',
        '\u{1F30A} Suyun akisini gosteren soyut cizim',
        '\u{1F3A8} Mor ve mavi tonlarinda mandala',
      ];
    }

    final suggestions = <String>[];
    for (final symbol in widget.interpretation!.symbols.take(3)) {
      suggestions.add(
        '${symbol.symbolEmoji} "${symbol.symbol}" temasinda minimalist cizim',
      );
    }

    suggestions.add(
      '\u{1F52E} ${widget.interpretation!.archetypeName} arketip sembolü',
    );

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCardsTab(),
                    _buildCustomizeTab(),
                    _buildTemplatesTab(),
                    _buildGeneratedTab(),
                  ],
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.mystic.withOpacity(0.3), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.mystic.withOpacity(0.5),
                  AppColors.nebulaPurple.withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Text('\u{1F4E4}', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ruya Paylasimi',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Kozmik mesajini paylas',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Privacy toggle
          IconButton(
            onPressed: () => _showPrivacySheet(),
            icon: Icon(
              _shareAnonymously ? Icons.visibility_off : Icons.visibility,
              color: AppColors.mystic,
            ),
            tooltip: 'Gizlilik Ayarlari',
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.mystic, AppColors.cosmicPurple],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Kartlar'),
          Tab(text: 'Özelleştir'),
          Tab(text: 'Şablonlar'),
          Tab(text: 'Üretilen'),
        ],
      ),
    );
  }

  // ========================================
  // TAB 1: Cards Preview
  // ========================================
  Widget _buildCardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Main card preview
          Center(child: _buildCurrentCard()),
          const SizedBox(height: 24),

          // Quick template buttons
          Text(
            'Hizli Sablonlar',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          _buildQuickTemplates(),

          const SizedBox(height: 24),

          // Theme preview strip
          Text(
            'Tema Sec',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          _buildThemeStrip(),
        ],
      ),
    );
  }

  Widget _buildCurrentCard() {
    return DreamShareCard(
      repaintKey: _cardKey,
      mainText: _getDisplayText(),
      subtitle: _subtitle.isNotEmpty ? _subtitle : null,
      headerEmoji: _headerEmoji,
      footerText: _selectedTemplate.label,
      config: _config,
    ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.95, 0.95));
  }

  String _getDisplayText() {
    if (_shareSymbolOnly && widget.interpretation != null) {
      final symbols = widget.interpretation!.symbols;
      if (symbols.isNotEmpty) {
        return symbols.first.universalMeaning;
      }
    }

    if (_shareInterpretationOnly && widget.interpretation != null) {
      return widget.interpretation!.coreMessage;
    }

    return _mainText;
  }

  Widget _buildQuickTemplates() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: DreamCardTemplate.values.map((template) {
        final isSelected = _selectedTemplate == template;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTemplate = template;
              _updateContentForTemplate(template);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [AppColors.mystic, AppColors.cosmicPurple],
                    )
                  : null,
              color: isSelected ? null : AppColors.surfaceDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColors.mystic.withOpacity(0.3),
              ),
            ),
            child: Text(
              template.label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _updateContentForTemplate(DreamCardTemplate template) {
    final interp = widget.interpretation;

    switch (template) {
      case DreamCardTemplate.dreamQuote:
        _mainText =
            interp?.whisperQuote ?? 'Ruyalarimin icinde kendimi buldum.';
        _subtitle = '';
        _headerEmoji = '\u{1F319}';
        break;
      case DreamCardTemplate.symbolInsight:
        if (interp != null && interp.symbols.isNotEmpty) {
          final symbol = interp.symbols.first;
          _mainText = symbol.symbol;
          _subtitle = symbol.universalMeaning;
          _headerEmoji = symbol.symbolEmoji;
        } else {
          _mainText = 'Sembol Icgorusu';
          _subtitle = 'Bilinçaltinin mesajları';
          _headerEmoji = '\u{1F52E}';
        }
        break;
      case DreamCardTemplate.dailyMessage:
        _mainText =
            _generatedAffirmation ?? 'Bugün ruyalarimin isiginda yuruyorum.';
        _subtitle = '';
        _headerEmoji = '\u{1F31F}';
        break;
      case DreamCardTemplate.moonPhase:
        final moonPhase = MoonService.getCurrentPhase();
        _mainText = moonPhase.meaning;
        _subtitle = '${moonPhase.nameTr} Enerjisi';
        _headerEmoji = moonPhase.emoji;
        break;
      case DreamCardTemplate.personalInsight:
        _mainText = interp?.coreMessage ?? 'Kisisel icgorum';
        _subtitle = '';
        _headerEmoji = '\u{2728}';
        break;
      case DreamCardTemplate.archetypeDiscovery:
        _mainText = interp?.archetypeName ?? 'Arketip';
        _subtitle = interp?.archetypeConnection ?? '';
        _headerEmoji = '\u{1F3AD}';
        break;
      case DreamCardTemplate.weeklySummary:
        _mainText = 'Bu hafta bilinçaltim bana yol gosterdi.';
        _subtitle = 'Haftalik ruya ozeti';
        _headerEmoji = '\u{1F4D6}';
        break;
    }
  }

  Widget _buildThemeStrip() {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: DreamCardTheme.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final theme = DreamCardTheme.values[index];
          final isSelected = _config.theme == theme;

          return GestureDetector(
            onTap: () {
              setState(() {
                _config = _config.copyWith(theme: theme);
              });
            },
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.starGold
                          : Colors.transparent,
                      width: 2,
                    ),
                    gradient: _getThemePreviewGradient(theme),
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 4),
                Text(
                  theme.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected
                        ? AppColors.starGold
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  LinearGradient _getThemePreviewGradient(DreamCardTheme theme) {
    switch (theme) {
      case DreamCardTheme.mystical:
        return const LinearGradient(
          colors: [Color(0xFF1A0A2E), Color(0xFF0D0517)],
        );
      case DreamCardTheme.minimal:
        return const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        );
      case DreamCardTheme.cosmic:
        return const LinearGradient(
          colors: [Color(0xFF2D1B4E), Color(0xFF0D0517)],
        );
      case DreamCardTheme.aurora:
        return const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
        );
      case DreamCardTheme.moonlit:
        return const LinearGradient(
          colors: [Color(0xFF1A1A3E), Color(0xFF0D0D1F)],
        );
      case DreamCardTheme.golden:
        return LinearGradient(
          colors: [
            const Color(0xFF2D2410),
            AppColors.starGold.withOpacity(0.3),
          ],
        );
    }
  }

  // ========================================
  // TAB 2: Customize
  // ========================================
  Widget _buildCustomizeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Edit main text
          _buildSectionTitle('Ana Metin'),
          const SizedBox(height: 8),
          _buildTextEditor(),

          const SizedBox(height: 24),

          // Font style
          _buildSectionTitle('Yazi Stili'),
          const SizedBox(height: 8),
          _buildFontSelector(),

          const SizedBox(height: 24),

          // Emoji decorations
          _buildSectionTitle('Emoji Susleme'),
          const SizedBox(height: 8),
          _buildEmojiSelector(),

          const SizedBox(height: 24),

          // Toggle options
          _buildSectionTitle('Gorsel Ogeler'),
          const SizedBox(height: 8),
          _buildToggleOptions(),

          const SizedBox(height: 24),

          // Color accent
          _buildSectionTitle('Vurgu Rengi'),
          const SizedBox(height: 8),
          _buildColorPicker(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextEditor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mystic.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: TextEditingController(text: _mainText),
            onChanged: (value) {
              setState(() {
                _mainText = value;
              });
            },
            maxLines: 4,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Paylasmak istedigin metni yaz...',
              hintStyle: TextStyle(color: AppColors.textMuted),
              border: InputBorder.none,
            ),
          ),
          const Divider(color: AppColors.textMuted),
          TextField(
            controller: TextEditingController(text: _subtitle),
            onChanged: (value) {
              setState(() {
                _subtitle = value;
              });
            },
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            decoration: const InputDecoration(
              hintText: 'Alt baslik (opsiyonel)',
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: DreamCardFont.values.map((font) {
        final isSelected = _config.font == font;
        return GestureDetector(
          onTap: () {
            setState(() {
              _config = _config.copyWith(font: font);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [AppColors.mystic, AppColors.cosmicPurple],
                    )
                  : null,
              color: isSelected ? null : AppColors.surfaceDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColors.mystic.withOpacity(0.3),
              ),
            ),
            child: Text(
              font.label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontStyle: font == DreamCardFont.mystical
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmojiSelector() {
    final dreamEmojis = [
      '\u{1F319}',
      '\u{1F31F}',
      '\u{2728}',
      '\u{1F52E}',
      '\u{1F3AD}',
      '\u{1F30C}',
      '\u{1F320}',
      '\u{2604}',
      '\u{1F300}',
      '\u{1F311}',
      '\u{1F315}',
      '\u{1FA90}',
      '\u{1F9FF}',
      '\u{1F4AB}',
      '\u{1F302}',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Selected emoji display
        GestureDetector(
          onTap: () => _showEmojiPicker(),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mystic, AppColors.cosmicPurple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(_headerEmoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
        ),
        // Quick emoji picks
        ...dreamEmojis.map((emoji) {
          final isSelected = _headerEmoji == emoji;
          return GestureDetector(
            onTap: () {
              setState(() {
                _headerEmoji = emoji;
              });
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.mystic.withOpacity(0.3)
                    : AppColors.surfaceDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? AppColors.mystic : Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 20)),
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emoji Sec',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children:
                    [
                      '\u{1F319}',
                      '\u{1F31F}',
                      '\u{2728}',
                      '\u{1F52E}',
                      '\u{1F3AD}',
                      '\u{1F30C}',
                      '\u{1F320}',
                      '\u{2604}',
                      '\u{1F300}',
                      '\u{1F311}',
                      '\u{1F312}',
                      '\u{1F313}',
                      '\u{1F314}',
                      '\u{1F315}',
                      '\u{1F316}',
                      '\u{1F317}',
                      '\u{1F318}',
                      '\u{1FA90}',
                      '\u{1F9FF}',
                      '\u{1F4AB}',
                      '\u{1F302}',
                      '\u{1F40D}',
                      '\u{1F99B}',
                      '\u{1F418}',
                      '\u{1F987}',
                      '\u{1F989}',
                      '\u{1F426}',
                      '\u{1F43A}',
                      '\u{1F981}',
                      '\u{1F98B}',
                      '\u{1F31E}',
                      '\u{1F525}',
                      '\u{1F30A}',
                      '\u{1F343}',
                      '\u{1F338}',
                      '\u{1F48E}',
                      '\u{1F5DD}',
                      '\u{1F573}',
                      '\u{1F30D}',
                      '\u{1F308}',
                    ].map((emoji) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _headerEmoji = emoji;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOptions() {
    return Column(
      children: [
        _buildToggleTile('Ay Fazini Goster', _config.showMoonPhase, (value) {
          setState(() {
            _config = _config.copyWith(showMoonPhase: value);
          });
        }),
        _buildToggleTile('Filigran Goster', _config.showWatermark, (value) {
          setState(() {
            _config = _config.copyWith(showWatermark: value);
          });
        }),
        _buildToggleTile('Emoji Suslemeler', _config.showEmoji, (value) {
          setState(() {
            _config = _config.copyWith(showEmoji: value);
          });
        }),
      ],
    );
  }

  Widget _buildToggleTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.mystic,
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      AppColors.mystic,
      AppColors.cosmicPurple,
      AppColors.starGold,
      Colors.pink,
      Colors.cyan,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];

    return Wrap(
      spacing: 12,
      children: colors.map((color) {
        final isSelected = _config.accentColor == color;
        return GestureDetector(
          onTap: () {
            setState(() {
              _config = _config.copyWith(accentColor: color);
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 3,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ========================================
  // TAB 3: Templates
  // ========================================
  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Hazir Sablonlar'),
          const SizedBox(height: 16),

          // "Bu gece ruyamda..." template
          _buildTemplateCard(
            emoji: '\u{1F319}',
            title: '"Bu gece ruyamda..."',
            description: 'Klasik ruya paylasimi formati',
            onTap: () => _useTemplate('dream_tonight'),
          ),

          // Symbol meaning card
          _buildTemplateCard(
            emoji: '\u{1F52E}',
            title: 'Sembol Anlami',
            description: 'Bir sembolun derin anlamini paylas',
            onTap: () => _useTemplate('symbol_meaning'),
          ),

          // Archetype discovery
          _buildTemplateCard(
            emoji: '\u{1F3AD}',
            title: 'Arketip Kesfi',
            description: 'Hangi arketiple karsilastin?',
            onTap: () => _useTemplate('archetype'),
          ),

          // Moon phase wisdom
          _buildTemplateCard(
            emoji: MoonService.getCurrentPhase().emoji,
            title: 'Ay Fazi Bilgeligi',
            description: 'Ayin mesajini paylas',
            onTap: () => _useTemplate('moon_phase'),
          ),

          // Weekly dream summary
          _buildTemplateCard(
            emoji: '\u{1F4D6}',
            title: 'Haftalik Ozet',
            description: 'Bu haftaki ruyalarinin ozeti',
            onTap: () => _useTemplate('weekly'),
          ),

          const SizedBox(height: 24),
          _buildSectionTitle('Instagram Story Boyutu'),
          const SizedBox(height: 16),

          // Story format preview
          _buildStoryFormatPreview(),
        ],
      ),
    );
  }

  Widget _buildTemplateCard({
    required String emoji,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.surfaceDark.withOpacity(0.8),
              AppColors.surfaceDark.withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.mystic.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.mystic.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  void _useTemplate(String templateId) {
    setState(() {
      switch (templateId) {
        case 'dream_tonight':
          _selectedTemplate = DreamCardTemplate.dreamQuote;
          _mainText = 'Bu gece ruyamda $_mainText';
          _headerEmoji = '\u{1F319}';
          break;
        case 'symbol_meaning':
          _selectedTemplate = DreamCardTemplate.symbolInsight;
          _updateContentForTemplate(DreamCardTemplate.symbolInsight);
          break;
        case 'archetype':
          _selectedTemplate = DreamCardTemplate.archetypeDiscovery;
          _updateContentForTemplate(DreamCardTemplate.archetypeDiscovery);
          break;
        case 'moon_phase':
          _selectedTemplate = DreamCardTemplate.moonPhase;
          _updateContentForTemplate(DreamCardTemplate.moonPhase);
          break;
        case 'weekly':
          _selectedTemplate = DreamCardTemplate.weeklySummary;
          _updateContentForTemplate(DreamCardTemplate.weeklySummary);
          break;
      }
    });

    _tabController.animateTo(0);
  }

  Widget _buildStoryFormatPreview() {
    return Center(
      child: Container(
        width: 180,
        height: 320,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.mystic.withOpacity(0.3),
              AppColors.nebulaPurple.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.mystic.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_headerEmoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _mainText.length > 80
                    ? '${_mainText.substring(0, 80)}...'
                    : _mainText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '9:16 Story Format',
                style: TextStyle(color: Colors.white54, fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================
  // TAB 4: Generated Content
  // ========================================
  Widget _buildGeneratedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Generated Poetry
          _buildSectionTitle('Ruya Siiri'),
          const SizedBox(height: 12),
          _buildGeneratedContent(
            content: _generatedPoetry ?? '',
            icon: Icons.auto_awesome,
            onUse: () {
              setState(() {
                _mainText = _generatedPoetry ?? '';
                _headerEmoji = '\u{1F4DC}';
              });
              _tabController.animateTo(0);
            },
          ),

          const SizedBox(height: 24),

          // Daily Affirmation
          _buildSectionTitle('Günlük Olumlamalar'),
          const SizedBox(height: 12),
          _buildGeneratedContent(
            content: _generatedAffirmation ?? '',
            icon: Icons.wb_sunny,
            onUse: () {
              setState(() {
                _mainText = _generatedAffirmation ?? '';
                _headerEmoji = '\u{1F31F}';
              });
              _tabController.animateTo(0);
            },
          ),

          const SizedBox(height: 24),

          // Mystical Quotes
          _buildSectionTitle('Mistik Alıntilar'),
          const SizedBox(height: 12),
          ..._buildMysticalQuotes(),

          const SizedBox(height: 24),

          // Symbol Art Suggestions
          _buildSectionTitle('Sembol Sanati Onerileri'),
          const SizedBox(height: 12),
          ..._symbolArtSuggestions.map((suggestion) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.palette, color: AppColors.mystic, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      suggestion,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGeneratedContent({
    required String content,
    required IconData icon,
    required VoidCallback onUse,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mystic.withOpacity(0.1),
            AppColors.nebulaPurple.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mystic.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.starGold, size: 18),
              const SizedBox(width: 8),
              const Text(
                'AI Uretimi',
                style: TextStyle(
                  color: AppColors.starGold,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.textPrimary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: content));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Kopyalandı!')));
                },
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Kopyala'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: onUse,
                icon: const Icon(Icons.check, size: 16),
                label: const Text('Kullan'),
                style: TextButton.styleFrom(foregroundColor: AppColors.mystic),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMysticalQuotes() {
    final quotes = [
      '"Ruyalar, ruhumuzun gece yazilan mektuplaridir."',
      '"Her ruya bir ayna, her sembol bir anahtar."',
      '"Gece, bilincaltinin en yuksek sesle konuştugu andir."',
      '"Ruyalarini dinleyen, kaderini yazar."',
    ];

    return quotes.map((quote) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _mainText = quote;
            _headerEmoji = '\u{2728}';
          });
          _tabController.animateTo(0);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.mystic.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Text('\u{2728}', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  quote,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
              ),
              const Icon(Icons.add, color: AppColors.mystic, size: 18),
            ],
          ),
        ),
      );
    }).toList();
  }

  // ========================================
  // Bottom Actions
  // ========================================
  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [AppColors.nebulaPurple.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          // Save to gallery
          Expanded(
            child: OutlineButton(
              label: _isSaving ? 'Kaydediliyor...' : 'Kaydet',
              icon: Icons.save_alt,
              onPressed: _isSaving ? null : _saveToGallery,
            ),
          ),
          const SizedBox(width: 12),
          // Share
          Expanded(
            flex: 2,
            child: GradientButton(
              label: _isSharing ? 'Paylasiliyor...' : 'Paylas',
              icon: Icons.share,
              isLoading: _isSharing,
              onPressed: _isSharing ? null : _shareCard,
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gizlilik Kontrolleri',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 20),
            _buildPrivacyToggle(
              'Anonim Paylas',
              'Isim ve profil bilgisi gosterilmez',
              _shareAnonymously,
              (value) {
                setState(() {
                  _shareAnonymously = value;
                });
                Navigator.pop(context);
              },
            ),
            _buildPrivacyToggle(
              'Sadece Yorum Paylas',
              'Ruya metni gizlenir, sadece yorum gosterilir',
              _shareInterpretationOnly,
              (value) {
                setState(() {
                  _shareInterpretationOnly = value;
                });
                Navigator.pop(context);
              },
            ),
            _buildPrivacyToggle(
              'Sadece Sembol Paylas',
              'Kisisel detaylar olmadan sembol anlami',
              _shareSymbolOnly,
              (value) {
                setState(() {
                  _shareSymbolOnly = value;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.mystic,
          ),
        ],
      ),
    );
  }

  Future<void> _saveToGallery() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final imageBytes = await DreamCardCapture.captureCard(_cardKey);
      if (imageBytes == null) {
        _showError('Gorsel olusturulamadi');
        return;
      }

      if (kIsWeb) {
        // Web: Download file
        _showSuccess('Gorsel indirildi!');
      } else {
        // Mobile: Save to temp and share to photos
        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/dream_card_${DateTime.now().millisecondsSinceEpoch}.png',
        );
        await file.writeAsBytes(imageBytes);

        _showSuccess('Gorsel kaydedildi!');
      }
    } catch (e) {
      _showError('Kaydetme hatasi: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _shareCard() async {
    setState(() {
      _isSharing = true;
    });

    try {
      final imageBytes = await DreamCardCapture.captureCard(_cardKey);
      if (imageBytes == null) {
        _showError('Gorsel olusturulamadi');
        return;
      }

      // Prepare share text
      String shareText = _mainText;
      if (_subtitle.isNotEmpty) {
        shareText += '\n\n$_subtitle';
      }
      shareText += '\n\n#ruyayorumu #venusone #kozmikenerji';

      if (kIsWeb) {
        // Web: Copy text and show instructions
        await Clipboard.setData(ClipboardData(text: shareText));
        _showSuccess('Metin kopyalandı! Sosyal medyada paylasabilirsin.');
      } else {
        // Mobile: Use share sheet
        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/dream_share_${DateTime.now().millisecondsSinceEpoch}.png',
        );
        await file.writeAsBytes(imageBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: shareText,
          subject: 'Ruya Yorumu',
        );
      }
    } catch (e) {
      _showError('Paylasim hatasi: $e');
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

/// Quick share button to add to dream interpretation results
class DreamQuickShareButton extends StatelessWidget {
  final String text;
  final String? symbol;
  final VoidCallback? onShare;

  const DreamQuickShareButton({
    super.key,
    required this.text,
    this.symbol,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onShare ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DreamShareScreen(
                  quickShareText: text,
                  quickShareSymbol: symbol,
                ),
              ),
            );
          },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mystic.withOpacity(0.3),
              AppColors.cosmicPurple.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.mystic.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.share, size: 18, color: AppColors.mystic),
            const SizedBox(width: 8),
            Text(
              'Paylas',
              style: TextStyle(
                color: AppColors.mystic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
