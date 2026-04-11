import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/reference_content.dart';
import '../../../data/services/reference_content_service.dart';
import '../../../shared/widgets/cosmic_background.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final _service = ReferenceContentService();

  List<AstrologyArticle> _articles = [];
  List<AstrologyArticle> _filteredArticles = [];
  ArticleCategory? _selectedCategory;
  AstrologyArticle? _selectedArticle;

  @override
  void initState() {
    super.initState();
    _articles = _service.getArticles();
    _filteredArticles = _articles;
  }

  void _filterArticles() {
    setState(() {
      _filteredArticles = _articles.where((article) {
        return _selectedCategory == null ||
            article.category == _selectedCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              if (_selectedArticle == null) _buildCategoryFilter(isDark),
              Expanded(
                child: _selectedArticle != null
                    ? _buildArticleDetail(isDark)
                    : _buildArticlesList(isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (_selectedArticle != null) {
                setState(() {
                  _selectedArticle = null;
                });
              } else {
                context.pop();
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          Expanded(
            child: Text(
              _selectedArticle != null ? 'Makale' : 'Makaleler & Rehberler',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(bool isDark) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
        children: [
          _buildCategoryChip(null, 'Tümü', '📚', isDark),
          ...ArticleCategory.values.map(
            (cat) => _buildCategoryChip(cat, cat.nameTr, cat.icon, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    ArticleCategory? category,
    String label,
    String icon,
    bool isDark,
  ) {
    final isSelected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(icon), const SizedBox(width: 4), Text(label)],
        ),
        onSelected: (_) {
          setState(() {
            _selectedCategory = category;
          });
          _filterArticles();
        },
        selectedColor: AppColors.mystic.withValues(alpha: 0.3),
        backgroundColor: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildArticlesList(bool isDark) {
    if (_filteredArticles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📭', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              'Makale bulunamadı',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: _filteredArticles.length,
      itemBuilder: (context, index) {
        final article = _filteredArticles[index];
        return _buildArticleCard(article, isDark);
      },
    );
  }

  Widget _buildArticleCard(AstrologyArticle article, bool isDark) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedArticle = article;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cosmic.withValues(alpha: 0.3),
                    AppColors.mystic.withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radiusLg),
                ),
              ),
              child: Center(
                child: Text(
                  article.category.icon,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mystic.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.category.nameTr,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.mystic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (article.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12, color: AppColors.gold),
                              const SizedBox(width: 4),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${article.readTimeMinutes} dk okuma',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : AppColors.textLight,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        article.author,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleDetail(bool isDark) {
    final article = _selectedArticle!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.cosmic.withValues(alpha: 0.3),
                  AppColors.mystic.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(article.category.icon),
                          const SizedBox(width: 4),
                          Text(
                            article.category.nameTr,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white : AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      child: const Text('✍️', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      article.author,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${article.readTimeMinutes} dk',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: article.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#$tag',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white70 : AppColors.textLight,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // Content
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            ),
            child: _buildMarkdownContent(article.content, isDark),
          ),

          const SizedBox(height: AppConstants.spacingXxl),
        ],
      ),
    );
  }

  Widget _buildMarkdownContent(String content, bool isDark) {
    // Simple markdown-like rendering
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      if (line.startsWith('## ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              line.substring(3),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
          ),
        );
      } else if (line.startsWith('### ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: Text(
              line.substring(4),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
            ),
          ),
        );
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(
                    color: AppColors.cosmic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    line.substring(2),
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (RegExp(r'^\d+\. ').hasMatch(line)) {
        final match = RegExp(r'^(\d+)\. (.*)').firstMatch(line);
        if (match != null) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.cosmic.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        match.group(1)!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cosmic,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: _buildFormattedText(match.group(2)!, isDark)),
                ],
              ),
            ),
          );
        }
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildFormattedText(line, isDark),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildFormattedText(String text, bool isDark) {
    // Handle bold text with **
    final spans = <TextSpan>[];
    final parts = text.split(RegExp(r'\*\*'));

    for (int i = 0; i < parts.length; i++) {
      final isBold = i % 2 == 1;
      spans.add(
        TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isDark ? Colors.white70 : AppColors.textLight,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
