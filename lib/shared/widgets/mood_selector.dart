import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Mood tracking widget for personalization and emotional data collection
/// Enables behavioral adaptation and personalized content
enum Mood {
  happy('Mutlu', '😊', Color(0xFF4CAF50)),
  sad('Huzunlu', '😔', Color(0xFF5C6BC0)),
  anxious('Kaygili', '😰', Color(0xFFFF7043)),
  tired('Yorgun', '😴', Color(0xFF78909C)),
  thoughtful('Dusunceli', '🤔', Color(0xFF9575CD)),
  excited('Heyecanli', '🤩', Color(0xFFFFCA28)),
  calm('Huzurlu', '😌', Color(0xFF26A69A)),
  confused('Kafasi Karisik', '😵‍💫', Color(0xFFEC407A));

  final String label;
  final String emoji;
  final Color color;

  const Mood(this.label, this.emoji, this.color);
}

/// Horizontal mood selector with emoji display
class MoodSelector extends StatefulWidget {
  final Mood? selectedMood;
  final Function(Mood) onSelect;
  final String? title;
  final bool showLabels;
  final bool compact;

  const MoodSelector({
    super.key,
    this.selectedMood,
    required this.onSelect,
    this.title,
    this.showLabels = true,
    this.compact = false,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  Mood? _hoveredMood;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moods = widget.compact
        ? [Mood.happy, Mood.sad, Mood.anxious, Mood.tired, Mood.thoughtful]
        : Mood.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              widget.title!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: moods.map((mood) {
              final isSelected = widget.selectedMood == mood;
              final isHovered = _hoveredMood == mood;

              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: _MoodChip(
                  mood: mood,
                  isSelected: isSelected,
                  isHovered: isHovered,
                  showLabel: widget.showLabels,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    widget.onSelect(mood);
                  },
                  onHover: (hover) {
                    setState(() => _hoveredMood = hover ? mood : null);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MoodChip extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final bool isHovered;
  final bool showLabel;
  final VoidCallback onTap;
  final Function(bool) onHover;

  const _MoodChip({
    required this.mood,
    required this.isSelected,
    required this.isHovered,
    required this.showLabel,
    required this.onTap,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
          onEnter: (_) => onHover(true),
          onExit: (_) => onHover(false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: showLabel ? 16 : 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          mood.color.withOpacity(0.4),
                          mood.color.withOpacity(0.2),
                        ],
                      )
                    : null,
                color: isSelected
                    ? null
                    : isDark
                    ? AppColors.surfaceLight.withOpacity(isHovered ? 0.8 : 0.5)
                    : AppColors.lightSurfaceVariant.withOpacity(
                        isHovered ? 1 : 0.7,
                      ),
                borderRadius: BorderRadius.circular(showLabel ? 24 : 16),
                border: Border.all(
                  color: isSelected
                      ? mood.color
                      : isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: mood.color.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.2 : (isHovered ? 1.1 : 1.0),
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      mood.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  if (showLabel) ...[
                    const SizedBox(width: 8),
                    Text(
                      mood.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? mood.color
                            : isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
          duration: 200.ms,
        );
  }
}

/// Quick mood check card for home screen
class MoodCheckCard extends StatelessWidget {
  final Mood? currentMood;
  final Function(Mood) onMoodSelected;
  final VoidCallback? onSkip;

  const MoodCheckCard({
    super.key,
    this.currentMood,
    required this.onMoodSelected,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.mystic.withOpacity(0.15),
                  AppColors.surfaceDark.withOpacity(0.9),
                ]
              : [AppColors.mystic.withOpacity(0.1), Colors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.mystic.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.mystic.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.sentiment_satisfied_alt,
                  color: AppColors.mystic,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bugun Nasil Hissediyorsun?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ruh halin yorumlarini kisisellestirir',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (onSkip != null)
                TextButton(
                  onPressed: onSkip,
                  child: Text(
                    'Atla',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          MoodSelector(
            selectedMood: currentMood,
            onSelect: onMoodSelected,
            showLabels: false,
            compact: true,
          ),
          if (currentMood != null) ...[
            const SizedBox(height: 12),
            Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: currentMood!.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: currentMood!.color.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentMood!.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${currentMood!.label} hissediyorsun',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: currentMood!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .scale(begin: const Offset(0.9, 0.9)),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms);
  }
}

/// Mood history for patterns
class MoodHistoryItem {
  final Mood mood;
  final DateTime timestamp;
  final String? note;

  MoodHistoryItem({required this.mood, required this.timestamp, this.note});

  Map<String, dynamic> toJson() => {
    'mood': mood.name,
    'timestamp': timestamp.toIso8601String(),
    'note': note,
  };

  factory MoodHistoryItem.fromJson(Map<String, dynamic> json) =>
      MoodHistoryItem(
        mood: Mood.values.firstWhere((m) => m.name == json['mood']),
        timestamp: DateTime.parse(json['timestamp']),
        note: json['note'],
      );
}
