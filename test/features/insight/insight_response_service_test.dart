import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/features/insight/services/insight_response_service.dart';
import 'package:inner_cycles/features/insight/services/insight_routing_service.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';
import 'package:inner_cycles/data/services/l10n_service.dart';

void main() {
  late InsightResponseService service;

  setUpAll(() async {
    // Initialize Flutter binding
    TestWidgetsFlutterBinding.ensureInitialized();

    // Initialize L10nService for tests with English
    await L10nService.init(AppLanguage.en);
  });

  setUp(() {
    service = InsightResponseService();
  });

  group('InsightResponseService', () {
    group('Dream Reflection Responses', () {
      test('returns falling dream response for falling keywords', () {
        final response = service.generateResponse(
          userMessage: 'I had a dream about falling from a building',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        // Should be the falling dream response
        expect(
          response,
          L10nService.get('insight.responses.dream_falling', AppLanguage.en),
        );
      });

      test('returns water dream response for water keywords', () {
        final response = service.generateResponse(
          userMessage: 'I was swimming in the ocean in my dream',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.dream_water', AppLanguage.en),
        );
      });

      test('returns flying dream response for flying keywords', () {
        final response = service.generateResponse(
          userMessage: 'In my dream I was flying over mountains',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.dream_flying', AppLanguage.en),
        );
      });

      test('returns chase dream response for chase keywords', () {
        final response = service.generateResponse(
          userMessage: 'I was being chased by something scary',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.dream_chase', AppLanguage.en),
        );
      });

      test('returns teeth dream response for teeth keywords', () {
        final response = service.generateResponse(
          userMessage: 'I had a dream where my teeth were loose',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.dream_teeth', AppLanguage.en),
        );
      });

      test('returns general dream response for generic dreams', () {
        final response = service.generateResponse(
          userMessage: 'I had a strange dream last night',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        // Should be one of the general responses
        final possibleResponses = [
          L10nService.get('insight.responses.dream_general_1', AppLanguage.en),
          L10nService.get('insight.responses.dream_general_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });

      test('works with Turkish keywords', () {
        final response = service.generateResponse(
          userMessage: 'Rüyamda düşüyorum sürekli',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.tr,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.dream_falling', AppLanguage.tr),
        );
      });
    });

    group('Emotional Exploration Responses', () {
      test('returns anxiety response for anxiety keywords', () {
        final response = service.generateResponse(
          userMessage: 'I feel so anxious all the time',
          insightType: InsightType.emotionalExplore,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.emotion_anxiety', AppLanguage.en),
        );
      });

      test('returns sadness response for sad keywords', () {
        final response = service.generateResponse(
          userMessage: 'I have been feeling really sad lately',
          insightType: InsightType.emotionalExplore,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.emotion_sadness', AppLanguage.en),
        );
      });

      test('returns anger response for anger keywords', () {
        final response = service.generateResponse(
          userMessage: 'I am so angry at everything',
          insightType: InsightType.emotionalExplore,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.emotion_anger', AppLanguage.en),
        );
      });

      test('returns overwhelmed response for stress keywords', () {
        final response = service.generateResponse(
          userMessage: 'I feel completely overwhelmed with work',
          insightType: InsightType.emotionalExplore,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.emotion_overwhelmed', AppLanguage.en),
        );
      });

      test('returns general emotion response for generic feelings', () {
        final response = service.generateResponse(
          userMessage: 'I have been feeling strange lately',
          insightType: InsightType.emotionalExplore,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        expect(
          response,
          L10nService.get('insight.responses.emotion_general', AppLanguage.en),
        );
      });
    });

    group('Pattern Awareness Responses', () {
      test('returns pattern response', () {
        final response = service.generateResponse(
          userMessage: 'I keep making the same mistakes',
          insightType: InsightType.patternAwareness,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        final possibleResponses = [
          L10nService.get('insight.responses.pattern_1', AppLanguage.en),
          L10nService.get('insight.responses.pattern_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });
    });

    group('Decision Support Responses', () {
      test('returns decision response', () {
        final response = service.generateResponse(
          userMessage: 'Should I take this job offer?',
          insightType: InsightType.decisionSupport,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        final possibleResponses = [
          L10nService.get('insight.responses.decision_1', AppLanguage.en),
          L10nService.get('insight.responses.decision_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });
    });

    group('Relationship Responses', () {
      test('returns relationship response', () {
        final response = service.generateResponse(
          userMessage: 'My relationship is struggling',
          insightType: InsightType.relationshipReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        final possibleResponses = [
          L10nService.get('insight.responses.relationship_1', AppLanguage.en),
          L10nService.get('insight.responses.relationship_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });
    });

    group('Self Discovery Responses', () {
      test('returns self discovery response', () {
        final response = service.generateResponse(
          userMessage: 'Who am I really?',
          insightType: InsightType.selfDiscovery,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        final possibleResponses = [
          L10nService.get('insight.responses.self_discovery_1', AppLanguage.en),
          L10nService.get('insight.responses.self_discovery_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });
    });

    group('General Responses', () {
      test('returns general response', () {
        final response = service.generateResponse(
          userMessage: 'Hello there',
          insightType: InsightType.generalReflection,
          language: AppLanguage.en,
        );

        expect(response, isNotEmpty);
        final possibleResponses = [
          L10nService.get('insight.responses.general_1', AppLanguage.en),
          L10nService.get('insight.responses.general_2', AppLanguage.en),
        ];
        expect(possibleResponses, contains(response));
      });
    });

    group('Language Support', () {
      test('generates responses in Turkish', () {
        final response = service.generateResponse(
          userMessage: 'Garip bir rüya gördüm',
          insightType: InsightType.dreamReflection,
          language: AppLanguage.tr,
        );

        expect(response, isNotEmpty);
        expect(response.isNotEmpty, isTrue);
      });
    });
  });
}
