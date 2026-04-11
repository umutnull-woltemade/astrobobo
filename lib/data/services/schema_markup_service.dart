/// Schema.org Markup Service for Structured Data Generation
/// Generates page-specific JSON-LD markup for SEO
library;

import 'dart:convert';
import 'seo_meta_service.dart';

class SchemaMarkupService {
  static const String _baseUrl = 'https://venusone.com';
  static const String _logoUrl = '$_baseUrl/icons/Icon-512.png';
  static const String _orgName = 'Venus One';

  /// Generate JSON-LD script tag content for a given route
  static String generateSchemaMarkup(String route) {
    final meta = SeoMetaService.getMetaForRoute(route);
    final schemas = <Map<String, dynamic>>[];

    // Always add Organization schema
    schemas.add(_organizationSchema());

    // Always add WebSite schema
    schemas.add(_websiteSchema());

    // Add BreadcrumbList
    schemas.add(_breadcrumbSchema(route, meta.title));

    // Add page-specific schema based on type
    switch (meta.schemaType) {
      case SchemaType.webApplication:
        schemas.add(_webApplicationSchema(meta));
        break;
      case SchemaType.article:
        schemas.add(_articleSchema(meta));
        break;
      case SchemaType.howTo:
        schemas.add(_howToSchema(meta));
        break;
      case SchemaType.product:
        schemas.add(_productSchema(meta));
        break;
      case SchemaType.collectionPage:
        schemas.add(_collectionPageSchema(meta));
        break;
      case SchemaType.definedTermSet:
        schemas.add(_definedTermSetSchema(meta));
        break;
      case SchemaType.faqPage:
        schemas.add(_faqPageSchema(meta));
        break;
      case SchemaType.profilePage:
        schemas.add(_profilePageSchema(meta));
        break;
      case SchemaType.webPage:
        schemas.add(_webPageSchema(meta));
        break;
    }

    // Return as script tags
    return schemas
        .map(
          (s) => '<script type="application/ld+json">${jsonEncode(s)}</script>',
        )
        .join('\n');
  }

  /// Organization schema - appears on all pages
  static Map<String, dynamic> _organizationSchema() {
    return {
      '@context': 'https://schema.org',
      '@type': 'Organization',
      'name': _orgName,
      'url': _baseUrl,
      'logo': _logoUrl,
      'sameAs': [
        'https://twitter.com/venusoneapp',
        'https://instagram.com/venusoneapp',
        'https://facebook.com/venusoneapp',
      ],
      'contactPoint': {
        '@type': 'ContactPoint',
        'contactType': 'customer service',
        'availableLanguage': ['Turkish', 'English'],
      },
    };
  }

  /// WebSite schema with search action
  static Map<String, dynamic> _websiteSchema() {
    return {
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      'name': _orgName,
      'url': _baseUrl,
      'description':
          "Türkiye'nin en kapsamlı astroloji, numeroloji ve tarot uygulaması",
      'potentialAction': {
        '@type': 'SearchAction',
        'target': '$_baseUrl/search?q={search_term_string}',
        'query-input': 'required name=search_term_string',
      },
      'inLanguage': 'tr-TR',
    };
  }

  /// Breadcrumb schema
  static Map<String, dynamic> _breadcrumbSchema(String route, String title) {
    final normalizedRoute = route
        .replaceAll(RegExp(r'^/+|/+$'), '')
        .toLowerCase();
    final items = <Map<String, dynamic>>[
      {
        '@type': 'ListItem',
        'position': 1,
        'name': 'Ana Sayfa',
        'item': _baseUrl,
      },
    ];

    if (normalizedRoute.isNotEmpty && normalizedRoute != 'home') {
      items.add({
        '@type': 'ListItem',
        'position': 2,
        'name': title.split(' — ').first.split(' | ').first,
        'item': '$_baseUrl/$normalizedRoute',
      });
    }

    return {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      'itemListElement': items,
    };
  }

  /// Web Application schema for tools
  static Map<String, dynamic> _webApplicationSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'WebApplication',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'url': meta.getCanonicalUrl(_baseUrl),
      'description': meta.description,
      'applicationCategory': 'LifestyleApplication',
      'operatingSystem': 'Web, iOS, Android',
      'offers': {'@type': 'Offer', 'price': '0', 'priceCurrency': 'TRY'},
      'author': {'@type': 'Organization', 'name': _orgName},
      'inLanguage': 'tr-TR',
    };
  }

  /// Article schema for content pages
  static Map<String, dynamic> _articleSchema(PageMeta meta) {
    final now = DateTime.now().toIso8601String();
    return {
      '@context': 'https://schema.org',
      '@type': 'Article',
      'headline': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'datePublished': now,
      'dateModified': now,
      'author': {'@type': 'Organization', 'name': _orgName, 'url': _baseUrl},
      'publisher': {
        '@type': 'Organization',
        'name': _orgName,
        'logo': {'@type': 'ImageObject', 'url': _logoUrl},
      },
      'mainEntityOfPage': {
        '@type': 'WebPage',
        '@id': meta.getCanonicalUrl(_baseUrl),
      },
      'inLanguage': 'tr-TR',
    };
  }

  /// HowTo schema for ritual/guide pages
  static Map<String, dynamic> _howToSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'HowTo',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'inLanguage': 'tr-TR',
      'step': [
        {
          '@type': 'HowToStep',
          'name': 'Hazırlık',
          'text': 'Sessiz ve rahat bir ortam oluşturun.',
        },
        {
          '@type': 'HowToStep',
          'name': 'Niyet Belirleme',
          'text': 'Açık ve net niyetinizi belirleyin.',
        },
        {
          '@type': 'HowToStep',
          'name': 'Uygulama',
          'text': 'Ritüeli talimatlar doğrultusunda gerçekleştirin.',
        },
      ],
    };
  }

  /// Product schema for premium page
  static Map<String, dynamic> _productSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'Product',
      'name': 'Venus One Premium',
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'brand': {'@type': 'Brand', 'name': _orgName},
      'offers': {
        '@type': 'Offer',
        'priceCurrency': 'TRY',
        'availability': 'https://schema.org/InStock',
      },
    };
  }

  /// Collection page schema
  static Map<String, dynamic> _collectionPageSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'CollectionPage',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'inLanguage': 'tr-TR',
    };
  }

  /// Defined term set schema for glossary
  static Map<String, dynamic> _definedTermSetSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'DefinedTermSet',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'inLanguage': 'tr-TR',
    };
  }

  /// FAQ page schema
  static Map<String, dynamic> _faqPageSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'FAQPage',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'mainEntity': [],
      'inLanguage': 'tr-TR',
    };
  }

  /// Profile page schema
  static Map<String, dynamic> _profilePageSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'ProfilePage',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'inLanguage': 'tr-TR',
    };
  }

  /// Generic web page schema
  static Map<String, dynamic> _webPageSchema(PageMeta meta) {
    return {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      'name': meta.title.split(' — ').first.split(' | ').first,
      'description': meta.description,
      'url': meta.getCanonicalUrl(_baseUrl),
      'inLanguage': 'tr-TR',
    };
  }

  /// Generate FAQ schema from a list of FAQ items
  static Map<String, dynamic> generateFaqSchema(
    List<Map<String, String>> faqs,
  ) {
    return {
      '@context': 'https://schema.org',
      '@type': 'FAQPage',
      'mainEntity': faqs.map((faq) {
        return {
          '@type': 'Question',
          'name': faq['question'],
          'acceptedAnswer': {'@type': 'Answer', 'text': faq['answer']},
        };
      }).toList(),
    };
  }

  /// Generate zodiac-specific article schema
  static Map<String, dynamic> generateZodiacArticleSchema({
    required String signName,
    required String signSymbol,
    required String description,
    required String dates,
  }) {
    final now = DateTime.now().toIso8601String();
    return {
      '@context': 'https://schema.org',
      '@type': 'Article',
      'headline': '$signName Burcu $signSymbol — Günlük Burç Yorumu',
      'description': description,
      'url': '$_baseUrl/horoscope/${signName.toLowerCase()}',
      'datePublished': now,
      'dateModified': now,
      'author': {'@type': 'Organization', 'name': _orgName},
      'publisher': {
        '@type': 'Organization',
        'name': _orgName,
        'logo': {'@type': 'ImageObject', 'url': _logoUrl},
      },
      'about': {
        '@type': 'Thing',
        'name': '$signName Burcu',
        'description': '$dates tarihleri arasında doğanlar',
      },
      'inLanguage': 'tr-TR',
    };
  }
}
