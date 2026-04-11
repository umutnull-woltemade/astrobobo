import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/content/venus_homepage_content.dart';

/// Generic content detail screen for Venus content sections.
/// Displays markdown-style content from VenusHomepageContent.
class ContentDetailScreen extends StatelessWidget {
  final String contentId;

  const ContentDetailScreen({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    final section = VenusHomepageContent.getSectionById(contentId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (section == null) {
      return _buildNotFound(context, isDark);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.deepSpace : AppColors.lightBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with back button
            SliverToBoxAdapter(child: _buildHeader(context, section, isDark)),
            // Content
            SliverToBoxAdapter(child: _buildContent(context, section, isDark)),
            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    VenusContentSection section,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF1A1A2E), AppColors.deepSpace]
              : [const Color(0xFFF5F0FF), AppColors.lightBackground],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
              size: 20,
            ),
          ),
          const SizedBox(height: 16),
          // Emoji and title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.cosmicPurple.withOpacity(0.4)
                        : AppColors.lightStarGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      section.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (section.badge != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: section.badge == 'Yeni'
                                ? AppColors.starGold.withOpacity(0.2)
                                : AppColors.cosmicPurple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            section.badge!,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: section.badge == 'Yeni'
                                  ? AppColors.starGold
                                  : (isDark
                                        ? AppColors.textSecondary
                                        : AppColors.lightTextSecondary),
                            ),
                          ),
                        ),
                      Text(
                        section.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        section.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
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
    );
  }

  Widget _buildContent(
    BuildContext context,
    VenusContentSection section,
    bool isDark,
  ) {
    // Parse markdown-style content
    final lines = section.fullContent.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      final trimmed = line.trim();

      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 12));
        continue;
      }

      // H1 header
      if (trimmed.startsWith('# ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              trimmed.substring(2),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.starGold : AppColors.lightStarGold,
              ),
            ),
          ),
        );
        continue;
      }

      // H2 header
      if (trimmed.startsWith('## ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              trimmed.substring(3),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.auroraStart
                    : AppColors.lightAuroraStart,
              ),
            ),
          ),
        );
        continue;
      }

      // H3 header
      if (trimmed.startsWith('### ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: Text(
              trimmed.substring(4),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        );
        continue;
      }

      // Bold text with **
      if (trimmed.startsWith('**') && trimmed.endsWith('**')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(
              trimmed.substring(2, trimmed.length - 2),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        );
        continue;
      }

      // List item
      if (trimmed.startsWith('- ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•  ',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark
                        ? AppColors.starGold
                        : AppColors.lightStarGold,
                  ),
                ),
                Expanded(
                  child: Text(
                    trimmed.substring(2),
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        continue;
      }

      // Numbered list item
      final numberMatch = RegExp(r'^(\d+)\. (.*)$').firstMatch(trimmed);
      if (numberMatch != null) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${numberMatch.group(1)}.  ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.starGold
                        : AppColors.lightStarGold,
                  ),
                ),
                Expanded(
                  child: Text(
                    numberMatch.group(2)!,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        continue;
      }

      // Regular paragraph
      widgets.add(
        Text(
          _parseInlineFormatting(trimmed),
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: isDark
                ? AppColors.textSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  String _parseInlineFormatting(String text) {
    // Simple cleanup - remove markdown bold/italic markers for plain text display
    return text
        .replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'\1')
        .replaceAll(RegExp(r'\*([^*]+)\*'), r'\1');
  }

  Widget _buildNotFound(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.deepSpace : AppColors.lightBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🔮', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                Text(
                  'İçerik Bulunamadı',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aradığınız içerik mevcut değil.',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Geri Dön'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? AppColors.starGold
                        : AppColors.lightStarGold,
                    foregroundColor: AppColors.deepSpace,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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
