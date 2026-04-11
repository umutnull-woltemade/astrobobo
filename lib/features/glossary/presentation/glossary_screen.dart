import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/reference_content.dart';
import '../../../data/services/reference_content_service.dart';
import '../../../shared/widgets/cosmic_background.dart';

class GlossaryScreen extends StatefulWidget {
  final String? initialSearch;

  const GlossaryScreen({super.key, this.initialSearch});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  final _service = ReferenceContentService();
  final _searchController = TextEditingController();

  List<GlossaryEntry> _entries = [];
  List<GlossaryEntry> _filteredEntries = [];
  GlossaryCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _entries = _service.getGlossaryEntries();
    _filteredEntries = _entries;

    // If initial search is provided, apply it
    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      _searchQuery = widget.initialSearch!;
      _searchController.text = widget.initialSearch!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _filterEntries();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterEntries() {
    setState(() {
      if (_searchQuery.isEmpty && _selectedCategory == null) {
        _filteredEntries = _entries;
        return;
      }

      // Use improved search from service
      var results = _searchQuery.isNotEmpty
          ? _service.searchGlossary(_searchQuery)
          : _entries;

      // Apply category filter
      if (_selectedCategory != null) {
        results = results
            .where((e) => e.category == _selectedCategory)
            .toList();
      }

      _filteredEntries = results;
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
              _buildSearchBar(isDark),
              _buildCategoryFilter(isDark),
              Expanded(
                child: _filteredEntries.isEmpty
                    ? _buildEmptyState(isDark)
                    : _buildEntriesList(isDark),
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
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Astroloji Sözlüğü',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${_service.glossaryCount} terim',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Terim ara...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                    _filterEntries();
                  },
                )
              : null,
          filled: true,
          fillColor: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
          _filterEntries();
        },
      ),
    );
  }

  Widget _buildCategoryFilter(bool isDark) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
        children: [
          _buildCategoryChip(null, 'Tümü', '📚', isDark),
          ...GlossaryCategory.values.map(
            (cat) => _buildCategoryChip(cat, cat.nameTr, cat.icon, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    GlossaryCategory? category,
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
          _filterEntries();
        },
        selectedColor: AppColors.cosmic.withValues(alpha: 0.3),
        backgroundColor: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Sonuç bulunamadı',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Farklı bir arama terimi deneyin',
            style: TextStyle(
              color: isDark ? Colors.white60 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntriesList(bool isDark) {
    // Group by category
    final groupedEntries = <GlossaryCategory, List<GlossaryEntry>>{};
    for (final entry in _filteredEntries) {
      groupedEntries.putIfAbsent(entry.category, () => []).add(entry);
    }

    if (_selectedCategory != null) {
      // Show flat list when category is selected
      return ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        itemCount: _filteredEntries.length,
        itemBuilder: (context, index) {
          return _buildEntryCard(_filteredEntries[index], isDark);
        },
      );
    }

    // Show grouped list
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: groupedEntries.length,
      itemBuilder: (context, index) {
        final category = groupedEntries.keys.elementAt(index);
        final entries = groupedEntries[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(category.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      category.nameTr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cosmic.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entries.length}',
                      style: TextStyle(fontSize: 12, color: AppColors.cosmic),
                    ),
                  ),
                ],
              ),
            ),
            ...entries.map((entry) => _buildEntryCard(entry, isDark)),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildEntryCard(GlossaryEntry entry, bool isDark) {
    return Container(
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
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingSm,
        ),
        childrenPadding: const EdgeInsets.only(
          left: AppConstants.spacingLg,
          right: AppConstants.spacingLg,
          bottom: AppConstants.spacingLg,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.termTr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ),
                if (entry.planetInHouse != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mystic.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('🏠', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
            Text(
              entry.term,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white60 : AppColors.textLight,
              ),
            ),
            // Hint - kısa ipucu
            if (entry.hint.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '✨ ${entry.hint}',
                style: TextStyle(fontSize: 12, color: AppColors.starGold),
              ),
            ],
          ],
        ),
        trailing: Icon(
          Icons.expand_more,
          color: isDark ? Colors.white60 : AppColors.textLight,
        ),
        children: [
          // Tanım
          Text(
            entry.definition,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),

          // Derin Açıklama
          if (entry.deepExplanation != null) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cosmic.withValues(alpha: 0.1),
                    AppColors.mystic.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                border: Border.all(
                  color: AppColors.cosmic.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🔮', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(
                        'Derin Yorum',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cosmic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.deepExplanation!,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Örnek
          if (entry.example != null) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: AppColors.starGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                border: Border.all(
                  color: AppColors.starGold.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.example!,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: isDark ? Colors.white70 : AppColors.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Gezegen-Ev bilgisi
          if (entry.planetInHouse != null) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.mystic.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🏠', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    entry.planetInHouse!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mystic,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Burç yöneticisi bilgisi
          if (entry.signRuler != null) ...[
            const SizedBox(height: AppConstants.spacingSm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.starGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('👑', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    'Yönetici: ${entry.signRuler}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.celestialGold,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // İlgili terimler
          if (entry.relatedTerms.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Text(
                  'İlgili:',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : AppColors.textLight,
                  ),
                ),
                ...entry.relatedTerms.map(
                  (term) => GestureDetector(
                    onTap: () {
                      // İlgili terime tıklandığında arama yap
                      _searchController.text = term;
                      setState(() {
                        _searchQuery = term;
                        _selectedCategory = null;
                      });
                      _filterEntries();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        term,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.cosmic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Referanslar
          if (entry.references.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('📚', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        'Kaynaklar',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...entry.references.map(
                    (ref) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text(
                            ref.type == 'book'
                                ? '📖'
                                : ref.type == 'article'
                                ? '📰'
                                : ref.type == 'website'
                                ? '🌐'
                                : '📜',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${ref.title} - ${ref.author}',
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: isDark
                                    ? Colors.white60
                                    : AppColors.textLight,
                              ),
                            ),
                          ),
                        ],
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
}
