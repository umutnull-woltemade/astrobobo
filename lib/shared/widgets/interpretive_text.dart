import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/routes.dart';
import '../../data/content/glossary_content.dart';
import '../../data/models/reference_content.dart';

/// Global glossary term cache for fast lookup
class GlossaryCache {
  static final GlossaryCache _instance = GlossaryCache._internal();
  factory GlossaryCache() => _instance;
  GlossaryCache._internal();

  Map<String, GlossaryEntry>? _termMap;
  List<String>? _sortedTerms;
  RegExp? _termPattern;

  /// Initialize cache - call this early in app lifecycle
  void initialize() {
    if (_termMap != null) return;

    // Web'de glossary cache'i skip et - 300+ terimlik regex çok yavaş
    if (kIsWeb) {
      _termMap = {};
      _sortedTerms = [];
      return;
    }

    final entries = GlossaryContent.getAllEntries();
    _termMap = <String, GlossaryEntry>{};

    for (final entry in entries) {
      _termMap![entry.termTr.toLowerCase()] = entry;
      _termMap![entry.term.toLowerCase()] = entry;
    }

    // Sort terms by length (longest first) to match longer terms first
    _sortedTerms = _termMap!.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    // Only match terms that are at least 3 characters
    final filteredTerms = _sortedTerms!.where((t) => t.length >= 3).toList();
    if (filteredTerms.isNotEmpty) {
      final escapedTerms = filteredTerms.map((t) => RegExp.escape(t)).join('|');
      _termPattern = RegExp('\\b($escapedTerms)\\b', caseSensitive: false);
    }
  }

  /// Get entry by term (case-insensitive)
  GlossaryEntry? getEntry(String term) {
    initialize();
    return _termMap?[term.toLowerCase()];
  }

  /// Get all entries
  Map<String, GlossaryEntry> get termMap {
    initialize();
    return _termMap ?? {};
  }

  /// Get the pattern for auto-detection
  RegExp? get termPattern {
    initialize();
    return _termPattern;
  }

  /// Check if a term exists
  bool hasTerm(String term) {
    initialize();
    return _termMap?.containsKey(term.toLowerCase()) ?? false;
  }
}

/// A widget that displays interpretive text with clickable glossary references.
///
/// Glossary terms are marked with [[term]] syntax and become clickable links
/// that show tooltip on hover and navigate to glossary on tap.
class InterpretiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const InterpretiveText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultStyle =
        style ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.textSecondary : AppColors.textLight,
          height: 1.6,
        );

    final spans = _parseText(context, text, defaultStyle, isDark);

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  List<InlineSpan> _parseText(
    BuildContext context,
    String text,
    TextStyle? baseStyle,
    bool isDark,
  ) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\[\[([^\]]+)\]\]');
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before the match
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      // Add the glossary link with tooltip
      final term = match.group(1)!;
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: _GlossaryTermWidget(term: term, style: baseStyle),
        ),
      );

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: baseStyle));
    }

    return spans;
  }
}

/// Widget for a single glossary term with enhanced rich tooltip
class _GlossaryTermWidget extends StatefulWidget {
  final String term;
  final TextStyle? style;

  const _GlossaryTermWidget({required this.term, this.style});

  @override
  State<_GlossaryTermWidget> createState() => _GlossaryTermWidgetState();
}

class _GlossaryTermWidgetState extends State<_GlossaryTermWidget> {
  bool _isHovered = false;
  GlossaryEntry? _entry;
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _entry = GlossaryCache().getEntry(widget.term);
  }

  void _showRichTooltip() {
    if (_entry != null) {
      HapticFeedback.selectionClick();
      _overlayController.show();
    }
  }

  void _hideRichTooltip() {
    _overlayController.hide();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => _buildRichTooltipOverlay(context),
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            _showRichTooltip();
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            Future.delayed(const Duration(milliseconds: 200), () {
              if (!_isHovered && mounted) {
                _hideRichTooltip();
              }
            });
          },
          child: GestureDetector(
            onTap: () => _navigateToGlossary(context),
            onLongPress: _showRichTooltip,
            child: Text(
              widget.term,
              style: widget.style?.copyWith(
                color: _isHovered
                    ? AppColors.celestialGold
                    : AppColors.starGold,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor:
                    (_isHovered ? AppColors.celestialGold : AppColors.starGold)
                        .withValues(alpha: 0.7),
                decorationStyle: TextDecorationStyle.dotted,
                decorationThickness: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTooltipOverlay(BuildContext context) {
    if (_entry == null) return const SizedBox.shrink();

    return _ConstrainedTooltipOverlay(
      link: _link,
      child: GlossaryRichTooltip(
        entry: _entry!,
        onClose: _hideRichTooltip,
        onNavigate: () => _navigateToGlossary(context),
      ),
    );
  }

  void _navigateToGlossary(BuildContext context) {
    _hideRichTooltip();
    final searchTerm = _entry?.termTr ?? widget.term;
    context.push('${Routes.glossary}?search=$searchTerm');
  }
}

/// Constrained tooltip overlay that stays within screen bounds
/// CRITICAL: Prevents viewport overflow, horizontal scroll, and layout shift (CLS = 0)
class _ConstrainedTooltipOverlay extends StatelessWidget {
  final LayerLink link;
  final Widget child;

  const _ConstrainedTooltipOverlay({required this.link, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;
    final viewInsets = MediaQuery.of(context).viewInsets; // Keyboard awareness
    final isMobile = screenSize.width < 600;

    // Safe area calculations - prevent overflow in all directions
    final safeHorizontalPadding = 16.0;
    final safeBottom = screenPadding.bottom + viewInsets.bottom + 16;
    final availableWidth = screenSize.width - (safeHorizontalPadding * 2);
    final availableHeight =
        screenSize.height - screenPadding.top - safeBottom - 100;

    // On mobile, center the tooltip horizontally and position below the target
    if (isMobile) {
      return Positioned(
        left: safeHorizontalPadding,
        right: safeHorizontalPadding,
        child: CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          offset: const Offset(0, 8),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: availableWidth,
              maxHeight: availableHeight.clamp(200.0, screenSize.height * 0.4),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Material(color: Colors.transparent, child: child),
            ),
          ),
        ),
      );
    }

    // On desktop/tablet, use the default positioning with boundary checks
    return Positioned(
      child: CompositedTransformFollower(
        link: link,
        showWhenUnlinked: false,
        targetAnchor: Alignment.bottomCenter,
        followerAnchor: Alignment.topCenter,
        offset: const Offset(0, 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 320.0.clamp(0.0, availableWidth),
            maxHeight: availableHeight.clamp(200.0, 500.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Rich tooltip widget with detailed glossary information
class GlossaryRichTooltip extends StatelessWidget {
  final GlossaryEntry entry;
  final VoidCallback onClose;
  final VoidCallback onNavigate;

  const GlossaryRichTooltip({
    super.key,
    required this.entry,
    required this.onClose,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onExit: (_) => onClose(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320, maxHeight: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF1A1A2E) : Colors.white,
              isDark ? const Color(0xFF16213E) : const Color(0xFFF5F0FF),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.starGold.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cosmic.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with category icon and term
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.cosmic.withValues(alpha: 0.3),
                            AppColors.mystic.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        entry.category.icon,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.termTr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : AppColors.textDark,
                            ),
                          ),
                          Text(
                            entry.term,
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: isDark
                                  ? Colors.white60
                                  : AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onClose,
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: isDark ? Colors.white38 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),

                // Hint (if available)
                if (entry.hint.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.starGold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('✨', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            entry.hint,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.celestialGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Definition
                const SizedBox(height: 12),
                Text(
                  entry.definition,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: isDark ? Colors.white70 : AppColors.textLight,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),

                // Deep explanation preview (if available)
                if (entry.deepExplanation != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.mystic.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.mystic.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('🔮', style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 6),
                            Text(
                              'Derin Yorum',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mystic,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entry.deepExplanation!,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.4,
                            color: isDark
                                ? Colors.white60
                                : AppColors.textLight,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],

                // Example (if available)
                if (entry.example != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          entry.example!,
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? Colors.white54
                                : AppColors.textLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],

                // Related terms
                if (entry.relatedTerms.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: entry.relatedTerms.take(4).map((term) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : AppColors.cosmic.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          term,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.cosmic,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                // Navigate button
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onNavigate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.cosmic.withValues(alpha: 0.2),
                          AppColors.mystic.withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 14,
                          color: AppColors.cosmic,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Sözlükte Görüntüle',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cosmic,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.cosmic,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Auto-detect and highlight glossary terms in plain text
/// This widget scans text for known glossary terms and highlights them
/// Uses cached term patterns for optimal performance
class AutoGlossaryText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool enableHighlighting;
  final int maxHighlights; // Limit highlights for performance

  const AutoGlossaryText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.enableHighlighting = true,
    this.maxHighlights = 10,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultStyle =
        style ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.textSecondary : AppColors.textLight,
          height: 1.6,
        );

    if (!enableHighlighting) {
      return Text(
        text,
        style: defaultStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final spans = _autoDetectTerms(context, text, defaultStyle);

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  List<InlineSpan> _autoDetectTerms(
    BuildContext context,
    String text,
    TextStyle? baseStyle,
  ) {
    final spans = <InlineSpan>[];
    final cache = GlossaryCache();
    final pattern = cache.termPattern;

    if (pattern == null) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    int lastEnd = 0;
    int highlightCount = 0;

    for (final match in pattern.allMatches(text)) {
      // Limit highlights for performance
      if (highlightCount >= maxHighlights) {
        break;
      }

      // Add text before the match
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: baseStyle,
          ),
        );
      }

      // Add the matched term with tooltip
      final matchedText = match.group(0)!;
      final entry = cache.getEntry(matchedText);

      if (entry != null) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _AutoGlossaryTermWidget(
              displayText: matchedText,
              entry: entry,
              style: baseStyle,
            ),
          ),
        );
        highlightCount++;
      } else {
        spans.add(TextSpan(text: matchedText, style: baseStyle));
      }

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: baseStyle));
    }

    return spans;
  }
}

/// Widget for auto-detected glossary term with enhanced tooltip
class _AutoGlossaryTermWidget extends StatefulWidget {
  final String displayText;
  final GlossaryEntry entry;
  final TextStyle? style;

  const _AutoGlossaryTermWidget({
    required this.displayText,
    required this.entry,
    this.style,
  });

  @override
  State<_AutoGlossaryTermWidget> createState() =>
      _AutoGlossaryTermWidgetState();
}

class _AutoGlossaryTermWidgetState extends State<_AutoGlossaryTermWidget> {
  bool _isHovered = false;
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  void _showRichTooltip() {
    HapticFeedback.selectionClick();
    _overlayController.show();
  }

  void _hideRichTooltip() {
    _overlayController.hide();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => _buildRichTooltipOverlay(context),
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            _showRichTooltip();
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            Future.delayed(const Duration(milliseconds: 200), () {
              if (!_isHovered && mounted) {
                _hideRichTooltip();
              }
            });
          },
          child: GestureDetector(
            onTap: () => _navigateToGlossary(context),
            onLongPress: _showRichTooltip,
            child: Text(
              widget.displayText,
              style: widget.style?.copyWith(
                color: _isHovered
                    ? AppColors.celestialGold
                    : AppColors.starGold,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor:
                    (_isHovered ? AppColors.celestialGold : AppColors.starGold)
                        .withValues(alpha: 0.5),
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTooltipOverlay(BuildContext context) {
    return _ConstrainedTooltipOverlay(
      link: _link,
      child: GlossaryRichTooltip(
        entry: widget.entry,
        onClose: _hideRichTooltip,
        onNavigate: () => _navigateToGlossary(context),
      ),
    );
  }

  void _navigateToGlossary(BuildContext context) {
    _hideRichTooltip();
    context.push('${Routes.glossary}?search=${widget.entry.termTr}');
  }
}

/// A card widget with expandable deep interpretation section
class DeepInterpretationCard extends StatefulWidget {
  final String title;
  final String summary;
  final String deepInterpretation;
  final IconData? icon;
  final Color? accentColor;
  final List<String>? relatedTerms;

  const DeepInterpretationCard({
    super.key,
    required this.title,
    required this.summary,
    required this.deepInterpretation,
    this.icon,
    this.accentColor,
    this.relatedTerms,
  });

  @override
  State<DeepInterpretationCard> createState() => _DeepInterpretationCardState();
}

class _DeepInterpretationCardState extends State<DeepInterpretationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = widget.accentColor ?? AppColors.auroraStart;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.15),
            isDark ? AppColors.surfaceDark : Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: accentColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Summary with glossary links
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InterpretiveText(
              text: widget.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.white70 : AppColors.textLight,
                height: 1.5,
              ),
            ),
          ),

          // Expand button
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Row(
                children: [
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: accentColor,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isExpanded ? 'Kisalt' : 'Derin Yorumu Oku',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Deep interpretation (expandable)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_stories, size: 16, color: accentColor),
                      const SizedBox(width: 8),
                      Text(
                        'Derin Yorum',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  InterpretiveText(
                    text: widget.deepInterpretation,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white60 : AppColors.textLight,
                      height: 1.7,
                    ),
                  ),
                  if (widget.relatedTerms != null &&
                      widget.relatedTerms!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.relatedTerms!.map((term) {
                        return GestureDetector(
                          onTap: () =>
                              context.push('${Routes.glossary}?search=$term'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.starGold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.starGold.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 12,
                                  color: AppColors.starGold,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  term,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppColors.starGold,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

/// A simple inline glossary tooltip wrapper with rich tooltip support
class GlossaryTooltip extends StatefulWidget {
  final String term;
  final Widget child;
  final bool useRichTooltip;

  const GlossaryTooltip({
    super.key,
    required this.term,
    required this.child,
    this.useRichTooltip = true,
  });

  @override
  State<GlossaryTooltip> createState() => _GlossaryTooltipState();
}

class _GlossaryTooltipState extends State<GlossaryTooltip> {
  GlossaryEntry? _entry;
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _entry = GlossaryCache().getEntry(widget.term);
  }

  void _showRichTooltip() {
    if (_entry != null && widget.useRichTooltip) {
      HapticFeedback.selectionClick();
      _overlayController.show();
    }
  }

  void _hideRichTooltip() {
    _overlayController.hide();
  }

  String _getTooltipMessage() {
    if (_entry == null) {
      return '${widget.term} - Sözlükte ara';
    }

    if (_entry!.hint.isNotEmpty) {
      return '✨ ${_entry!.termTr}: ${_entry!.hint}';
    }

    final shortDef = _entry!.definition.length > 150
        ? '${_entry!.definition.substring(0, 150)}...'
        : _entry!.definition;
    return '📖 ${_entry!.termTr}: $shortDef';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.useRichTooltip || _entry == null) {
      // Fall back to simple tooltip
      return Tooltip(
        message: _getTooltipMessage(),
        preferBelow: true,
        waitDuration: const Duration(milliseconds: 300),
        showDuration: const Duration(seconds: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.starGold.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          height: 1.4,
        ),
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
          onTap: () => context.push(
            '${Routes.glossary}?search=${_entry?.termTr ?? widget.term}',
          ),
          child: widget.child,
        ),
      );
    }

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => _ConstrainedTooltipOverlay(
          link: _link,
          child: GlossaryRichTooltip(
            entry: _entry!,
            onClose: _hideRichTooltip,
            onNavigate: () {
              _hideRichTooltip();
              context.push('${Routes.glossary}?search=${_entry!.termTr}');
            },
          ),
        ),
        child: MouseRegion(
          onEnter: (_) => _showRichTooltip(),
          onExit: (_) => Future.delayed(
            const Duration(milliseconds: 200),
            _hideRichTooltip,
          ),
          child: GestureDetector(
            onTap: () =>
                context.push('${Routes.glossary}?search=${_entry!.termTr}'),
            onLongPress: _showRichTooltip,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Simple glossary link text - shows term with tooltip
class GlossaryTerm extends StatelessWidget {
  final String term;
  final String? displayText;
  final TextStyle? style;

  const GlossaryTerm({
    super.key,
    required this.term,
    this.displayText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final entry = GlossaryCache().getEntry(term);

    final defaultStyle =
        style ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.starGold,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.starGold.withValues(alpha: 0.5),
          decorationStyle: TextDecorationStyle.dotted,
        );

    return GlossaryTooltip(
      term: term,
      child: Text(displayText ?? entry?.termTr ?? term, style: defaultStyle),
    );
  }
}

/// Compact glossary badge for showing term with category icon
class GlossaryBadge extends StatelessWidget {
  final String term;
  final bool showIcon;

  const GlossaryBadge({super.key, required this.term, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    final entry = GlossaryCache().getEntry(term);

    if (entry == null) {
      return Text(term);
    }

    return GlossaryTooltip(
      term: term,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.cosmic.withValues(alpha: 0.15),
              AppColors.mystic.withValues(alpha: 0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Text(entry.category.icon, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
            ],
            Text(
              entry.termTr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.starGold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
