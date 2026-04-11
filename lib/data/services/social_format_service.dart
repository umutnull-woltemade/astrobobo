import 'dart:math';
import '../models/zodiac_sign.dart';
import '../models/planet.dart';
import 'cosmic_share_content_service.dart';

/// Service for generating auto-cropped social media formats from master content
class SocialFormatService {
  static final _random = Random();

  /// Generate all social formats from master cosmic content
  static SocialFormats generateAllFormats({
    required CosmicShareContent masterContent,
    required ZodiacSign sign,
  }) {
    return SocialFormats(
      storySlides: _generateStorySlides(masterContent, sign),
      squarePost: _generateSquarePost(masterContent, sign),
      portraitPost: _generatePortraitPost(masterContent, sign),
      reelsScript: _generateReelsScript(masterContent, sign),
      videoPrompt: _generateVideoPrompt(sign),
    );
  }

  /// PART 2A: Instagram Story Version (9:16) - 6 Slides
  static List<StorySlide> _generateStorySlides(
    CosmicShareContent content,
    ZodiacSign sign,
  ) {
    return [
      // Slide 1: Hook
      StorySlide(
        slideNumber: 1,
        type: SlideType.hook,
        mainText: content.heroBlock.cosmicHeadline,
        subText: '${sign.symbol} ${sign.nameTr}',
        accent: content.heroBlock.moonPhaseEmoji,
        backgroundColor: 'cosmic_gradient_1',
      ),

      // Slide 2: Core Message 1
      StorySlide(
        slideNumber: 2,
        type: SlideType.coreMessage,
        mainText: content.microMessages.isNotEmpty
            ? content.microMessages[0]
            : content.personalMessage.emotionalCore,
        subText: null,
        accent: '✦',
        backgroundColor: 'cosmic_gradient_2',
      ),

      // Slide 3: Core Message 2
      StorySlide(
        slideNumber: 3,
        type: SlideType.coreMessage,
        mainText: content.microMessages.length > 1
            ? content.microMessages[1]
            : _extractKeyPhrase(content.personalMessage.message),
        subText: null,
        accent: '✧',
        backgroundColor: 'cosmic_gradient_3',
      ),

      // Slide 4: Core Message 3 (Planetary)
      StorySlide(
        slideNumber: 4,
        type: SlideType.coreMessage,
        mainText: content.planetaryInfluence.oneAction,
        subText:
            '${content.planetaryInfluence.planetSymbol} ${content.planetaryInfluence.dominantPlanet.nameTr}',
        accent: content.planetaryInfluence.planetSymbol,
        backgroundColor: 'cosmic_gradient_4',
      ),

      // Slide 5: Shadow & Light
      StorySlide(
        slideNumber: 5,
        type: SlideType.shadowLight,
        mainText: 'Gölgen: ${content.shadowLight.shadowChallenge}',
        subText: 'Işığın: ${content.shadowLight.lightStrength}',
        accent: '☯',
        backgroundColor: 'cosmic_gradient_5',
      ),

      // Slide 6: Soft Curiosity Ending
      StorySlide(
        slideNumber: 6,
        type: SlideType.ending,
        mainText: content.premiumCuriosity.curiosityText,
        subText: '@venusone',
        accent: '✨',
        backgroundColor: 'cosmic_gradient_6',
      ),
    ];
  }

  /// PART 2B: Instagram Square Post (1:1)
  static SocialPost _generateSquarePost(
    CosmicShareContent content,
    ZodiacSign sign,
  ) {
    final headline = content.heroBlock.cosmicHeadline;
    final bestMicro = content.microMessages.isNotEmpty
        ? content.microMessages[0]
        : content.personalMessage.emotionalCore;

    return SocialPost(
      format: PostFormat.square,
      headline: headline,
      bodyLines: [bestMicro],
      caption: _generateCaption(content, sign),
      hashtags: _generateHashtags(sign),
    );
  }

  /// PART 2B: Instagram Portrait Post (4:5)
  static SocialPost _generatePortraitPost(
    CosmicShareContent content,
    ZodiacSign sign,
  ) {
    final headline = '${sign.symbol} ${content.heroBlock.signTitle}';

    return SocialPost(
      format: PostFormat.portrait,
      headline: headline,
      bodyLines: [
        content.heroBlock.cosmicHeadline,
        content.microMessages.isNotEmpty ? content.microMessages[0] : '',
      ],
      caption: _generateCaption(content, sign),
      hashtags: _generateHashtags(sign),
    );
  }

  /// PART 2C: Reels/Shorts Video Script (15-20 sec)
  static ReelsScript _generateReelsScript(
    CosmicShareContent content,
    ZodiacSign sign,
  ) {
    return ReelsScript(
      totalDuration: 18,
      segments: [
        // 0-3s: Hook
        VideoSegment(
          startTime: 0,
          endTime: 3,
          type: SegmentType.hook,
          textOverlay: '${sign.symbol} ${sign.nameTr}',
          subtext: 'Bugün senin için...',
          animation: 'fade_zoom_in',
        ),

        // 4-7s: Build 1
        VideoSegment(
          startTime: 4,
          endTime: 7,
          type: SegmentType.build,
          textOverlay: content.heroBlock.cosmicHeadline,
          subtext: null,
          animation: 'slide_up',
        ),

        // 8-12s: Build 2 (Emotional Core)
        VideoSegment(
          startTime: 8,
          endTime: 12,
          type: SegmentType.build,
          textOverlay: content.microMessages.isNotEmpty
              ? content.microMessages[0]
              : content.personalMessage.emotionalCore,
          subtext: null,
          animation: 'typewriter',
        ),

        // 13-16s: Resolution
        VideoSegment(
          startTime: 13,
          endTime: 16,
          type: SegmentType.resolution,
          textOverlay: content.planetaryInfluence.oneAction,
          subtext: content.planetaryInfluence.planetSymbol,
          animation: 'glow_pulse',
        ),

        // 17-18s: Soft Curiosity
        VideoSegment(
          startTime: 17,
          endTime: 18,
          type: SegmentType.ending,
          textOverlay: content.premiumCuriosity.curiosityText,
          subtext: '@venusone',
          animation: 'fade_out',
        ),
      ],
    );
  }

  /// PART 3: AI Video Generation Prompt (Runway/Pika/CapCut compatible)
  static VideoGenerationPrompt _generateVideoPrompt(ZodiacSign sign) {
    return VideoGenerationPrompt(
      styleDescription: '''
Mystical cosmic atmosphere with deep purple and midnight blue gradient background.
Soft glowing stars scattered throughout.
Subtle aurora borealis effect in corners.
Golden accent particles floating slowly.
Vignette effect on edges.
Dark mode aesthetic, high contrast text safe.
''',
      motionDescription: '''
Very slow zoom in (1.02x over 5 seconds).
Gentle floating particle movement.
Soft pulsing glow on accent elements.
Smooth text fade transitions.
No jarring movements - ethereal and calm.
''',
      textAnimationStyle: '''
Text appears with soft fade + subtle scale (0.95 to 1.0).
Gold accent color for headlines (#FFD700).
White primary text (#FFFFFF).
Playfair Display for headlines.
Raleway for body text.
Safe area: 10% margin all sides for subtitles.
''',
      atmosphereNotes:
          '''
Emotional, introspective mood.
Night sky feeling without being literal.
Zodiac symbol (${sign.symbol}) as subtle watermark.
No harsh lighting or neon effects.
Premium, minimal, mystical.
''',
      dynamicTextPlaceholder: '{{DAILY_COSMIC_TEXT}}',
      safeAreaSpec: SafeAreaSpec(
        topMargin: 0.15,
        bottomMargin: 0.20,
        sideMargin: 0.10,
      ),
    );
  }

  // Helper methods
  static String _extractKeyPhrase(String message) {
    final sentences = message.split(RegExp(r'[.!?]'));
    if (sentences.isNotEmpty) {
      final shortest = sentences
          .where((s) => s.trim().length > 10 && s.trim().length < 60)
          .toList();
      if (shortest.isNotEmpty) {
        return shortest[_random.nextInt(shortest.length)].trim();
      }
    }
    return message.length > 50 ? '${message.substring(0, 47)}...' : message;
  }

  static String _generateCaption(CosmicShareContent content, ZodiacSign sign) {
    return '''
${content.heroBlock.cosmicHeadline}

${content.microMessages.isNotEmpty ? content.microMessages[0] : ''}

${content.collectiveMoment.mainText}

${content.sharePrompt}
''';
  }

  static List<String> _generateHashtags(ZodiacSign sign) {
    return [
      '#${sign.name.toLowerCase()}',
      '#${sign.nameTr.toLowerCase().replaceAll(' ', '')}',
      '#astroloji',
      '#burcyorumu',
      '#kozmikenerji',
      '#gunlukburc',
      '#venusone',
      '#astrology',
      '#zodiac',
      '#horoscope',
    ];
  }
}

// ═══════════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════════

class SocialFormats {
  final List<StorySlide> storySlides;
  final SocialPost squarePost;
  final SocialPost portraitPost;
  final ReelsScript reelsScript;
  final VideoGenerationPrompt videoPrompt;

  const SocialFormats({
    required this.storySlides,
    required this.squarePost,
    required this.portraitPost,
    required this.reelsScript,
    required this.videoPrompt,
  });
}

class StorySlide {
  final int slideNumber;
  final SlideType type;
  final String mainText;
  final String? subText;
  final String accent;
  final String backgroundColor;

  const StorySlide({
    required this.slideNumber,
    required this.type,
    required this.mainText,
    this.subText,
    required this.accent,
    required this.backgroundColor,
  });
}

enum SlideType { hook, coreMessage, shadowLight, ending }

class SocialPost {
  final PostFormat format;
  final String headline;
  final List<String> bodyLines;
  final String caption;
  final List<String> hashtags;

  const SocialPost({
    required this.format,
    required this.headline,
    required this.bodyLines,
    required this.caption,
    required this.hashtags,
  });

  String get fullCaption => '$caption\n\n${hashtags.join(' ')}';
}

enum PostFormat { square, portrait }

class ReelsScript {
  final int totalDuration;
  final List<VideoSegment> segments;

  const ReelsScript({required this.totalDuration, required this.segments});

  String toReadableScript() {
    final buffer = StringBuffer();
    buffer.writeln('=== REELS SCRIPT (${totalDuration}s) ===\n');
    for (final segment in segments) {
      buffer.writeln(
        '[${segment.startTime}s - ${segment.endTime}s] ${segment.type.name.toUpperCase()}',
      );
      buffer.writeln('Text: "${segment.textOverlay}"');
      if (segment.subtext != null) {
        buffer.writeln('Subtext: "${segment.subtext}"');
      }
      buffer.writeln('Animation: ${segment.animation}');
      buffer.writeln('');
    }
    return buffer.toString();
  }
}

class VideoSegment {
  final int startTime;
  final int endTime;
  final SegmentType type;
  final String textOverlay;
  final String? subtext;
  final String animation;

  const VideoSegment({
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.textOverlay,
    this.subtext,
    required this.animation,
  });
}

enum SegmentType { hook, build, resolution, ending }

class VideoGenerationPrompt {
  final String styleDescription;
  final String motionDescription;
  final String textAnimationStyle;
  final String atmosphereNotes;
  final String dynamicTextPlaceholder;
  final SafeAreaSpec safeAreaSpec;

  const VideoGenerationPrompt({
    required this.styleDescription,
    required this.motionDescription,
    required this.textAnimationStyle,
    required this.atmosphereNotes,
    required this.dynamicTextPlaceholder,
    required this.safeAreaSpec,
  });

  String toPromptString() {
    return '''
VISUAL STYLE:
$styleDescription

MOTION:
$motionDescription

TEXT ANIMATION:
$textAnimationStyle

ATMOSPHERE:
$atmosphereNotes

DYNAMIC TEXT INSERTION POINT: $dynamicTextPlaceholder

SAFE AREA:
- Top: ${(safeAreaSpec.topMargin * 100).toInt()}%
- Bottom: ${(safeAreaSpec.bottomMargin * 100).toInt()}%
- Sides: ${(safeAreaSpec.sideMargin * 100).toInt()}%
''';
  }
}

class SafeAreaSpec {
  final double topMargin;
  final double bottomMargin;
  final double sideMargin;

  const SafeAreaSpec({
    required this.topMargin,
    required this.bottomMargin,
    required this.sideMargin,
  });
}
