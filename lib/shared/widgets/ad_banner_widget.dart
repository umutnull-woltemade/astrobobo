import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../data/services/ad_service.dart';
import '../../data/services/premium_service.dart';

/// A widget that displays a banner ad
/// Automatically handles loading, premium status, and web platform
class AdBannerWidget extends ConsumerStatefulWidget {
  final AdSize adSize;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  const AdBannerWidget({
    super.key,
    this.adSize = AdSize.banner,
    this.margin,
    this.backgroundColor,
  });

  @override
  ConsumerState<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends ConsumerState<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // Don't show ads on web or for premium users
    if (kIsWeb) return;

    final adService = ref.read(adServiceProvider);
    if (adService.isPremium) return;

    _bannerAd = adService.createBannerAd(
      size: widget.adSize,
      onAdLoaded: (ad) {
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
          });
        }
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        if (kDebugMode) {
          debugPrint('Banner ad failed to load: ${error.message}');
        }
      },
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumUserProvider);

    // Don't show ads on web or for premium users
    if (kIsWeb || isPremium || !_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      width: widget.adSize.width.toDouble(),
      height: widget.adSize.height.toDouble(),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

/// A compact inline banner for result screens
class InlineAdBanner extends StatelessWidget {
  const InlineAdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdBannerWidget(
      adSize: AdSize.banner,
      margin: EdgeInsets.symmetric(vertical: 16),
    );
  }
}

/// A larger banner for main screens
class LargeAdBanner extends StatelessWidget {
  const LargeAdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdBannerWidget(
      adSize: AdSize.mediumRectangle,
      margin: EdgeInsets.symmetric(vertical: 16),
    );
  }
}

/// A sticky bottom banner
class StickyBottomAdBanner extends StatelessWidget {
  final Widget child;

  const StickyBottomAdBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        const SafeArea(
          top: false,
          child: AdBannerWidget(adSize: AdSize.banner, margin: EdgeInsets.zero),
        ),
      ],
    );
  }
}
