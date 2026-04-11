/// Dream Interpretation Result Widget - 7 Boyutlu Yorum Sonuç Görünümü
/// Kadim bilgelik + Jungian arketipler + Astrolojik zamanlama
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/dream_interpretation_models.dart';

/// Ana yorum sonucu widget'ı
class DreamInterpretationResultWidget extends StatelessWidget {
  final FullDreamInterpretation interpretation;
  final VoidCallback? onExploreLink;

  const DreamInterpretationResultWidget({
    super.key,
    required this.interpretation,
    this.onExploreLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mystic.withValues(alpha: 0.15),
            const Color(0xFF1A1A2E).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mystic.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.mystic.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),

              // 1. Kadim Giriş
              _buildSection(
                context,
                emoji: '📜',
                title: 'Kadim Bilgelik',
                content: interpretation.ancientIntro,
                delay: 100,
              ),

              // 2. Ana Mesaj
              _buildCoreMessage(context),

              // 3. Sembol Analizi
              if (interpretation.symbols.isNotEmpty)
                _buildSymbolsSection(context),

              // 4. Arketip Bağlantısı
              _buildArchetypeSection(context),

              // 5. Duygusal Okuma
              _buildEmotionalSection(context),

              // 6. Astrolojik Zamanlama
              _buildAstroSection(context),

              // 7. Işık/Gölge
              _buildLightShadowSection(context),

              // 8. Pratik Rehberlik
              _buildGuidanceSection(context),

              // 9. Fısıldayan Cümle
              _buildWhisperQuote(context),

              // 10. Paylaşılabilir Kart
              _buildShareCard(context),

              // 11. Keşfet Linkleri
              if (interpretation.explorationLinks.isNotEmpty)
                _buildExplorationLinks(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cosmicPurple.withValues(alpha: 0.4),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.mystic.withValues(alpha: 0.6),
                  AppColors.nebulaPurple.withValues(alpha: 0.3),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mystic.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Text('🔮', style: TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7 BOYUTLU RÜYA YORUMU',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bilinçaltının Mesajı',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Ay fazı göstergesi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.mystic.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.mystic.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interpretation.astroTiming.moonPhase.emoji,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                Text(
                  interpretation.astroTiming.moonPhase.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildSection(
    BuildContext context, {
    required String emoji,
    required String title,
    required String content,
    int delay = 0,
  }) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.starGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms, delay: delay.ms)
        .slideX(begin: -0.05, end: 0);
  }

  Widget _buildCoreMessage(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.starGold.withValues(alpha: 0.15),
                AppColors.cosmicPurple.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.starGold.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('✨', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    'ANA MESAJ',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.starGold,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                interpretation.coreMessage,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildSymbolsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔍', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'SEMBOL ANALİZİ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...interpretation.symbols.asMap().entries.map((entry) {
            final index = entry.key;
            final symbol = entry.value;
            return _buildSymbolCard(context, symbol, index);
          }),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 300.ms);
  }

  Widget _buildSymbolCard(
    BuildContext context,
    SymbolInterpretation symbol,
    int index,
  ) {
    return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.mystic.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.mystic.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    symbol.symbolEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      symbol.symbol.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildSymbolDetail(
                context,
                '🌍',
                'Evrensel',
                symbol.universalMeaning,
              ),
              _buildSymbolDetail(
                context,
                '👤',
                'Kişisel',
                symbol.personalContext,
              ),
              _buildSymbolDetail(context, '🌑', 'Gölge', symbol.shadowAspect),
              _buildSymbolDetail(context, '☀️', 'Işık', symbol.lightAspect),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 200.ms, delay: (400 + index * 100).ms)
        .slideX(begin: 0.05, end: 0);
  }

  Widget _buildSymbolDetail(
    BuildContext context,
    String emoji,
    String label,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchetypeSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.nebulaPurple.withValues(alpha: 0.3),
            AppColors.cosmicPurple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.nebulaPurple.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎭', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'ARKETİP: ${interpretation.archetypeName.toUpperCase()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            interpretation.archetypeConnection,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 500.ms);
  }

  Widget _buildEmotionalSection(BuildContext context) {
    final emotional = interpretation.emotionalReading;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                emotional.dominantEmotion.emoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'DUYGUSAL OKUMA: ${emotional.dominantEmotion.label.toUpperCase()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildEmotionalRow(context, '📍', 'Yüzey', emotional.surfaceMessage),
          _buildEmotionalRow(
            context,
            '🔮',
            'Derinlik',
            emotional.deeperMeaning,
          ),
          _buildEmotionalRow(
            context,
            '❓',
            'Gölge Sorusu',
            emotional.shadowQuestion,
          ),
          _buildEmotionalRow(
            context,
            '🛤️',
            'Entegrasyon',
            emotional.integrationPath,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 600.ms);
  }

  Widget _buildEmotionalRow(
    BuildContext context,
    String emoji,
    String label,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAstroSection(BuildContext context) {
    final astro = interpretation.astroTiming;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1A4E).withValues(alpha: 0.5),
            AppColors.cosmicPurple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cosmicPurple.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(astro.moonPhase.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Text(
                'ASTROLOJİK ZAMANLAMA',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (astro.isRetrograde)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '℞ Retro',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: Colors.orange),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            astro.timingMessage,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.mystic.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('🤔', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Neden şimdi? ${astro.whyNow}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 700.ms);
  }

  Widget _buildLightShadowSection(BuildContext context) {
    final ls = interpretation.lightShadow;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.amber.withValues(alpha: 0.15),
                    Colors.orange.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('☀️', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        'IŞIK',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ls.lightMessage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigo.withValues(alpha: 0.2),
                    Colors.deepPurple.withValues(alpha: 0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🌑', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        'GÖLGE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.indigo[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ls.shadowMessage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 800.ms);
  }

  Widget _buildGuidanceSection(BuildContext context) {
    final guidance = interpretation.guidance;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mystic.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mystic.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧭', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                'PRATİK REHBERLİK',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildGuidanceItem(context, '📅', 'Bugün', guidance.todayAction),
          _buildGuidanceItem(context, '📆', 'Bu Hafta', guidance.weeklyFocus),
          _buildGuidanceItem(context, '🚫', 'Kaçın', guidance.avoidance),
          const Divider(color: AppColors.mystic, height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cosmicPurple.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💭', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yansıtma Sorusu',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        guidance.reflectionQuestion,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 900.ms);
  }

  Widget _buildGuidanceItem(
    BuildContext context,
    String emoji,
    String label,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhisperQuote(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.mystic.withValues(alpha: 0.25),
                AppColors.nebulaPurple.withValues(alpha: 0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.mystic.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('🌙', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 12),
              Text(
                '"${interpretation.whisperQuote}"',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '— Fısıldayan Bilgelik',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms, delay: 1000.ms)
        .shimmer(
          duration: 2000.ms,
          delay: 1200.ms,
          color: AppColors.starGold.withValues(alpha: 0.3),
        );
  }

  Widget _buildShareCard(BuildContext context) {
    final card = interpretation.shareCard;
    return GestureDetector(
          onTap: () => _shareCard(context, card),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cosmicPurple, AppColors.nebulaPurple],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cosmicPurple.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(card.emoji, style: const TextStyle(fontSize: 32)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Paylaş',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '"${card.quote}"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '— Rüya Yorumu | venusone.com',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 1100.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildExplorationLinks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔗', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'KEŞFET',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.starGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interpretation.explorationLinks.map((link) {
              return InkWell(
                onTap: onExploreLink,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cosmicPurple.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.cosmicPurple.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(link.emoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        link.title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 1200.ms);
  }

  void _shareCard(BuildContext context, ShareableCard card) {
    final shareText = card.fullShareText;
    HapticFeedback.mediumImpact();
    Share.share(shareText);
  }
}
