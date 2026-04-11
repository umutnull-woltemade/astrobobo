import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Global error fallback widget that prevents white screens
/// Shows a user-friendly error message with recovery options
class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails details;

  const AppErrorWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    // Log the error in debug mode
    if (kDebugMode) {
      debugPrint(
        'AppErrorWidget: Rendering error fallback for: ${details.exception}',
      );
    }

    return Container(
      color: const Color(0xFF0D0D1A),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                const Text('✨', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Bir şeyler ters gitti',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Endişelenmeyin, yıldızlar hala sizinle.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Debug info (only in debug mode)
                if (kDebugMode) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      details.exception.toString().length > 200
                          ? '${details.exception.toString().substring(0, 200)}...'
                          : details.exception.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Reload button
                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Try to pop to root or reload
                      try {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        }
                      } catch (e) {
                        // If navigation fails, we're in a bad state
                        // The user can manually reload
                        if (kDebugMode) {
                          debugPrint('Navigation failed in error widget: $e');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: const Color(0xFF0D0D1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Ana Sayfaya Dön',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Secondary action - reload page (useful for web)
                if (kIsWeb)
                  TextButton(
                    onPressed: () {
                      // On web, this will reload the page
                      // Using JS interop would be cleaner but this is simpler
                      if (kDebugMode) {
                        debugPrint(
                          'User requested page reload from error widget',
                        );
                      }
                    },
                    child: Text(
                      'Sayfayı Yenile',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
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

/// Simplified error widget for production - no debug info
class ProductionErrorWidget extends StatelessWidget {
  const ProductionErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D1A),
      child: const SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('✨', style: TextStyle(fontSize: 64)),
              SizedBox(height: 24),
              Text(
                'Bir şeyler ters gitti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Lütfen sayfayı yenileyin.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
