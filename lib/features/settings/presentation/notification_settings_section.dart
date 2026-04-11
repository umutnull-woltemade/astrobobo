import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/notification_service.dart';
import '../../../data/providers/app_providers.dart';

/// Notification settings provider
final notificationSettingsProvider = FutureProvider<NotificationSettings>((
  ref,
) async {
  return NotificationService().getSettings();
});

/// Notification settings section for the settings screen
class NotificationSettingsSection extends ConsumerStatefulWidget {
  const NotificationSettingsSection({super.key});

  @override
  ConsumerState<NotificationSettingsSection> createState() =>
      _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState
    extends ConsumerState<NotificationSettingsSection> {
  final NotificationService _notificationService = NotificationService();
  bool _isInitialized = false;
  bool _permissionsGranted = false;

  // Settings state
  bool _dailyEnabled = false;
  int _dailyHour = 8;
  int _dailyMinute = 0;
  bool _moonEnabled = false;
  bool _retrogradeEnabled = false;
  bool _transitEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    _permissionsGranted = await _notificationService.areNotificationsEnabled();

    final settings = await _notificationService.getSettings();
    setState(() {
      _isInitialized = true;
      _dailyEnabled = settings.dailyHoroscopeEnabled;
      if (settings.dailyHoroscopeTimeMinutes != null) {
        _dailyHour = settings.dailyHoroscopeTimeMinutes! ~/ 60;
        _dailyMinute = settings.dailyHoroscopeTimeMinutes! % 60;
      }
      _moonEnabled = settings.moonPhaseEnabled;
      _retrogradeEnabled = settings.retrogradeAlertsEnabled;
      _transitEnabled = settings.transitAlertsEnabled;
    });
  }

  Future<void> _requestPermissions() async {
    final granted = await _notificationService.requestPermissions();
    setState(() {
      _permissionsGranted = granted;
    });
  }

  Future<void> _toggleDailyNotification(bool value) async {
    setState(() => _dailyEnabled = value);

    if (value) {
      final userProfile = ref.read(userProfileProvider);
      final sign = userProfile?.sunSign;
      if (sign != null) {
        await _notificationService.scheduleDailyHoroscope(
          sign: sign,
          hour: _dailyHour,
          minute: _dailyMinute,
        );
      }
    } else {
      await _notificationService.cancelDailyHoroscope();
    }
  }

  Future<void> _selectDailyTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _dailyHour, minute: _dailyMinute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.starGold,
              surface: AppColors.surfaceDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        _dailyHour = time.hour;
        _dailyMinute = time.minute;
      });

      if (_dailyEnabled) {
        final userProfile = ref.read(userProfileProvider);
        final sign = userProfile?.sunSign;
        if (sign != null) {
          await _notificationService.scheduleDailyHoroscope(
            sign: sign,
            hour: _dailyHour,
            minute: _dailyMinute,
          );
        }
      }
    }
  }

  Future<void> _toggleMoonNotification(bool value) async {
    setState(() => _moonEnabled = value);

    if (value) {
      await _notificationService.scheduleMoonPhaseNotifications();
    } else {
      await _notificationService.cancelMoonPhaseNotifications();
    }
  }

  Future<void> _toggleRetrogradeNotification(bool value) async {
    setState(() => _retrogradeEnabled = value);
    await _notificationService.scheduleRetrogradeAlerts(value);
  }

  Future<void> _toggleTransitNotification(bool value) async {
    setState(() => _transitEnabled = value);
    await _notificationService.setTransitAlertsEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceLight.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isDark
              ? AppColors.surfaceLight.withAlpha(30)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: AppColors.starGold,
                size: 24,
              ),
              const SizedBox(width: AppConstants.spacingSm),
              Text(
                'Bildirimler',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Permission banner if needed
          if (!_permissionsGranted) _buildPermissionBanner(context, isDark),

          if (_permissionsGranted) ...[
            // Daily horoscope notification
            _buildNotificationTile(
              context,
              isDark,
              icon: Icons.wb_sunny_outlined,
              title: 'Gunluk Burc Yorumu',
              subtitle: _dailyEnabled
                  ? 'Her gun saat ${_dailyHour.toString().padLeft(2, '0')}:${_dailyMinute.toString().padLeft(2, '0')}'
                  : 'Kapalı',
              value: _dailyEnabled,
              onChanged: _toggleDailyNotification,
              onTap: _dailyEnabled ? _selectDailyTime : null,
            ),

            const Divider(height: 24),

            // Moon phase notifications
            _buildNotificationTile(
              context,
              isDark,
              icon: Icons.nightlight_round_outlined,
              title: 'Ay Evreleri',
              subtitle: 'Yeni ay ve dolunay bildirimleri',
              value: _moonEnabled,
              onChanged: _toggleMoonNotification,
            ),

            const Divider(height: 24),

            // Retrograde alerts
            _buildNotificationTile(
              context,
              isDark,
              icon: Icons.replay,
              title: 'Retro Uyarilari',
              subtitle: 'Merkur ve diger gezegenler',
              value: _retrogradeEnabled,
              onChanged: _toggleRetrogradeNotification,
            ),

            const Divider(height: 24),

            // Transit alerts
            _buildNotificationTile(
              context,
              isDark,
              icon: Icons.route_outlined,
              title: 'Transit Uyarilari',
              subtitle: 'Onemli gezegensel transitler',
              value: _transitEnabled,
              onChanged: _toggleTransitNotification,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPermissionBanner(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.starGold.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.starGold.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.starGold, size: 20),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Text(
              'Bildirimleri alabilmek icin izin vermeniz gerekiyor.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: _requestPermissions,
            child: Text(
              'Izin Ver',
              style: TextStyle(color: AppColors.starGold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (value ? AppColors.starGold : AppColors.textMuted)
                  .withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: value ? AppColors.starGold : AppColors.textMuted,
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null && value)
            Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
          const SizedBox(width: 8),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.starGold,
          ),
        ],
      ),
    );
  }
}
