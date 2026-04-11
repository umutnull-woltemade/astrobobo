import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/ad_service.dart';
import '../../data/services/premium_service.dart';

/// A button that shows a rewarded ad to unlock premium content
class RewardedAdButton extends ConsumerStatefulWidget {
  final String label;
  final String rewardDescription;
  final IconData? icon;
  final VoidCallback onRewardEarned;
  final AdPlacement placement;
  final bool showIcon;

  const RewardedAdButton({
    super.key,
    required this.label,
    required this.rewardDescription,
    required this.onRewardEarned,
    this.icon,
    this.placement = AdPlacement.premiumUnlock,
    this.showIcon = true,
  });

  @override
  ConsumerState<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends ConsumerState<RewardedAdButton> {
  bool _isLoading = false;

  Future<void> _showRewardedAd() async {
    final adService = ref.read(adServiceProvider);

    // Premium users get instant access
    if (adService.isPremium) {
      widget.onRewardEarned();
      return;
    }

    // Web doesn't support ads - give free access in web
    if (kIsWeb) {
      widget.onRewardEarned();
      return;
    }

    if (!adService.isRewardedAdReady) {
      _showNoAdAvailableDialog();
      return;
    }

    setState(() => _isLoading = true);

    final shown = await adService.showRewardedAd(
      placement: widget.placement,
      onRewardEarned: () {
        widget.onRewardEarned();
      },
    );

    if (mounted) {
      setState(() => _isLoading = false);

      if (!shown) {
        _showNoAdAvailableDialog();
      }
    }
  }

  void _showNoAdAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Reklam Yüklenemedi',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Şu anda reklam mevcut değil. Lütfen daha sonra tekrar deneyin veya Premium\'a geçin.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Tamam',
              style: TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to premium subscription page
            },
            child: const Text(
              'Premium\'a Geç',
              style: TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ref.watch(isPremiumUserProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPremium
              ? [const Color(0xFFFFD700), const Color(0xFFFFA500)]
              : [const Color(0xFF6B46C1), const Color(0xFF9F7AEA)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                (isPremium ? const Color(0xFFFFD700) : const Color(0xFF6B46C1))
                    .withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _showRewardedAd,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else if (widget.showIcon) ...[
                  Icon(
                    isPremium
                        ? Icons.star
                        : (widget.icon ?? Icons.play_circle_fill),
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (!isPremium && !kIsWeb)
                      Text(
                        widget.rewardDescription,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A card that shows premium content locked behind rewarded ad
class PremiumContentCard extends ConsumerWidget {
  final String title;
  final String description;
  final Widget child;
  final VoidCallback onUnlocked;
  final bool isUnlocked;

  const PremiumContentCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    required this.onUnlocked,
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumUserProvider);

    if (isPremium || isUnlocked) {
      return child;
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF6B46C1).withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          // Blurred content preview
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black45,
                BlendMode.darken,
              ),
              child: ImageFiltered(
                imageFilter: const ColorFilter.mode(
                  Colors.black26,
                  BlendMode.overlay,
                ),
                child: AbsorbPointer(child: child),
              ),
            ),
          ),
          // Lock overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: Color(0xFFFFD700),
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RewardedAdButton(
                    label: 'Kilidi Aç',
                    rewardDescription: 'Reklam izle',
                    onRewardEarned: onUnlocked,
                    icon: Icons.lock_open,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
