import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/localization_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../data/cities/world_cities.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _nameController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedCity;
  double? _selectedLatitude;
  double? _selectedLongitude;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadCurrentProfile();
  }

  void _loadCurrentProfile() {
    final profile = ref.read(userProfileProvider);
    if (profile != null) {
      _nameController.text = profile.name ?? '';
      _selectedDate = profile.birthDate;
      if (profile.birthTime != null) {
        final parts = profile.birthTime!.split(':');
        if (parts.length >= 2) {
          _selectedTime = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }
      _selectedCity = profile.birthPlace;
      _selectedLatitude = profile.birthLatitude;
      _selectedLongitude = profile.birthLongitude;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);
    final language = ref.watch(languageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, language),
                const SizedBox(height: AppConstants.spacingXl),
                if (profile != null) ...[
                  _buildProfileHeader(context, profile, isDark),
                  const SizedBox(height: AppConstants.spacingXl),
                ],
                _buildEditSection(context, language, isDark),
                const SizedBox(height: AppConstants.spacingXl),
                if (profile != null)
                  _buildCosmicInfo(context, profile, language, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLanguage language) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (_hasChanges) {
              _showDiscardDialog(context, language);
            } else {
              context.pop();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(width: AppConstants.spacingSm),
        Text(
          _getLocalizedString('profile', language),
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.starGold),
        ),
        const Spacer(),
        if (_hasChanges)
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              _getLocalizedString('save', language),
              style: TextStyle(
                color: AppColors.auroraStart,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildProfileHeader(
    BuildContext context,
    dynamic profile,
    bool isDark,
  ) {
    final sign = profile.sunSign as ZodiacSign;
    final language = ref.watch(languageProvider);

    // Compact header with logo and zodiac sign inline
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Venus One Logo - smaller
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.starGold.withOpacity(0.3),
                AppColors.starGold.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: AppColors.starGold.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/brand/venus-logo/png/venus-logo-96.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingMd),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name ?? sign.localizedName(language),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: sign.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sign.localizedName(language),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: sign.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildEditSection(
    BuildContext context,
    AppLanguage language,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.7)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_outlined, color: AppColors.starGold, size: 20),
              const SizedBox(width: AppConstants.spacingSm),
              Text(
                _getLocalizedString('edit_info', language),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Name field
          _buildTextField(
            context,
            controller: _nameController,
            label: L10n.get('name', language),
            hint: L10n.get('your_name', language),
            icon: Icons.person_outline,
            isDark: isDark,
            onChanged: (value) => setState(() => _hasChanges = true),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Birth date
          _buildInfoField(
            context,
            label: L10n.get('birth_date', language),
            value: _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : L10n.get('select_time', language),
            icon: Icons.calendar_today_outlined,
            isDark: isDark,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Birth time
          _buildInfoField(
            context,
            label: L10n.get('birth_time', language),
            value: _selectedTime != null
                ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                : L10n.get('select_time', language),
            icon: Icons.access_time_outlined,
            isDark: isDark,
            onTap: () => _selectTime(context),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Birth place
          _buildInfoField(
            context,
            label: L10n.get('birth_place', language),
            value: _selectedCity ?? L10n.get('select_city', language),
            icon: Icons.location_on_outlined,
            isDark: isDark,
            onTap: () => _selectCity(context, language),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
            prefixIcon: Icon(
              icon,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.surfaceLight.withOpacity(0.3)
                : AppColors.lightSurfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: BorderSide(color: AppColors.auroraStart, width: 2),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildInfoField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceLight.withOpacity(0.3)
                  : AppColors.lightSurfaceVariant,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? AppColors.textMuted
                      : AppColors.lightTextMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCosmicInfo(
    BuildContext context,
    dynamic profile,
    AppLanguage language,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.7)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: AppColors.starGold, size: 20),
              const SizedBox(width: AppConstants.spacingSm),
              Text(
                L10n.get('big_three', language),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: [
              Expanded(
                child: _CosmicSignCard(
                  title: L10n.get('sun_sign', language),
                  sign: profile.sunSign,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSm),
              Expanded(
                child: _CosmicSignCard(
                  title: L10n.get('moon_sign', language),
                  sign: profile.moonSign,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSm),
              Expanded(
                child: _CosmicSignCard(
                  title: L10n.get('rising_sign', language),
                  sign: profile.risingSign,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.push(Routes.birthChart),
              icon: const Icon(Icons.public),
              label: Text(_getLocalizedString('view_full_chart', language)),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.auroraStart,
                side: BorderSide(color: AppColors.auroraStart),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Future<void> _selectDate(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.auroraStart,
              surface: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        _hasChanges = true;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(primary: AppColors.auroraStart),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
        _hasChanges = true;
      });
    }
  }

  Future<void> _selectCity(BuildContext context, AppLanguage language) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final result = await showModalBottomSheet<CityData>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String searchQuery = '';
        bool showTurkeyOnly = true;

        return StatefulBuilder(
          builder: (context, setModalState) {
            List<CityData> filteredCities;
            if (searchQuery.isEmpty) {
              filteredCities = showTurkeyOnly
                  ? WorldCities.turkishCities
                  : WorldCities.allCities;
            } else {
              filteredCities = WorldCities.search(searchQuery);
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          L10n.get('cancel', language),
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ),
                      Text(
                        L10n.get('select_city', language),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(width: 60),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: L10n.get('search_city', language),
                      hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.surfaceLight.withAlpha(30)
                          : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setModalState(() => searchQuery = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text(
                          'Türkiye',
                          style: TextStyle(
                            color: showTurkeyOnly
                                ? Colors.white
                                : (isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary),
                          ),
                        ),
                        selected: showTurkeyOnly,
                        selectedColor: colorScheme.primary,
                        backgroundColor: isDark
                            ? AppColors.surfaceLight.withAlpha(30)
                            : Colors.grey.shade200,
                        onSelected: (selected) {
                          setModalState(() => showTurkeyOnly = selected);
                        },
                      ),
                      FilterChip(
                        label: Text(
                          L10n.get('all_countries', language),
                          style: TextStyle(
                            color: !showTurkeyOnly
                                ? Colors.white
                                : (isDark
                                      ? AppColors.textSecondary
                                      : AppColors.lightTextSecondary),
                          ),
                        ),
                        selected: !showTurkeyOnly,
                        selectedColor: colorScheme.primary,
                        backgroundColor: isDark
                            ? AppColors.surfaceLight.withAlpha(30)
                            : Colors.grey.shade200,
                        onSelected: (selected) {
                          setModalState(() => showTurkeyOnly = !selected);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCities.length,
                      itemBuilder: (context, index) {
                        final city = filteredCities[index];
                        return ListTile(
                          leading: Icon(
                            Icons.location_city,
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.lightTextMuted,
                          ),
                          title: Text(
                            city.name,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          subtitle: Text(
                            city.country,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textMuted
                                  : AppColors.lightTextMuted,
                            ),
                          ),
                          onTap: () => Navigator.pop(context, city),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedCity = result.name;
        _selectedLatitude = result.lat;
        _selectedLongitude = result.lng;
        _hasChanges = true;
      });
    }
  }

  void _saveProfile() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile == null || _selectedDate == null) return;

    final timeString = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : currentProfile.birthTime;

    final updatedProfile = currentProfile.copyWith(
      name: _nameController.text.isNotEmpty ? _nameController.text : null,
      birthDate: _selectedDate,
      birthTime: timeString,
      birthPlace: _selectedCity,
      birthLatitude: _selectedLatitude,
      birthLongitude: _selectedLongitude,
    );

    ref.read(userProfileProvider.notifier).setProfile(updatedProfile);
    StorageService.saveUserProfile(updatedProfile);

    setState(() => _hasChanges = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _getLocalizedString('profile_saved', ref.read(languageProvider)),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        ),
      ),
    );
  }

  void _showDiscardDialog(BuildContext context, AppLanguage language) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        title: Text(
          _getLocalizedString('discard_changes', language),
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
        content: Text(
          _getLocalizedString('discard_changes_desc', language),
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              L10n.get('cancel', language),
              style: TextStyle(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: Text(
              _getLocalizedString('discard', language),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedString(String key, AppLanguage language) {
    final Map<String, Map<AppLanguage, String>> strings = {
      'profile': {
        AppLanguage.en: 'Profile',
        AppLanguage.tr: 'Profil',
        AppLanguage.el: 'Προφίλ',
        AppLanguage.bg: 'Профил',
        AppLanguage.ru: 'Профиль',
        AppLanguage.zh: '个人资料',
        AppLanguage.fr: 'Profil',
        AppLanguage.de: 'Profil',
        AppLanguage.es: 'Perfil',
        AppLanguage.ar: 'الملف الشخصي',
      },
      'save': {
        AppLanguage.en: 'Save',
        AppLanguage.tr: 'Kaydet',
        AppLanguage.el: 'Αποθήκευση',
        AppLanguage.bg: 'Запази',
        AppLanguage.ru: 'Сохранить',
        AppLanguage.zh: '保存',
        AppLanguage.fr: 'Enregistrer',
        AppLanguage.de: 'Speichern',
        AppLanguage.es: 'Guardar',
        AppLanguage.ar: 'حفظ',
      },
      'edit_info': {
        AppLanguage.en: 'Edit Information',
        AppLanguage.tr: 'Bilgileri Düzenle',
        AppLanguage.el: 'Επεξεργασία Πληροφοριών',
        AppLanguage.bg: 'Редактиране на Информация',
        AppLanguage.ru: 'Редактировать Информацию',
        AppLanguage.zh: '编辑信息',
        AppLanguage.fr: 'Modifier les Informations',
        AppLanguage.de: 'Informationen Bearbeiten',
        AppLanguage.es: 'Editar Información',
        AppLanguage.ar: 'تعديل المعلومات',
      },
      'view_full_chart': {
        AppLanguage.en: 'View Full Birth Chart',
        AppLanguage.tr: 'Doğum Haritasını Gör',
        AppLanguage.el: 'Δείτε Πλήρη Χάρτη Γέννησης',
        AppLanguage.bg: 'Вижте Пълната Натална Карта',
        AppLanguage.ru: 'Посмотреть Полную Натальную Карту',
        AppLanguage.zh: '查看完整出生图',
        AppLanguage.fr: 'Voir la Carte Natale Complète',
        AppLanguage.de: 'Vollständiges Geburtshoroskop Anzeigen',
        AppLanguage.es: 'Ver Carta Natal Completa',
        AppLanguage.ar: 'عرض خريطة الميلاد الكاملة',
      },
      'profile_saved': {
        AppLanguage.en: 'Profile saved successfully',
        AppLanguage.tr: 'Profil başarıyla kaydedildi',
        AppLanguage.el: 'Το προφίλ αποθηκεύτηκε επιτυχώς',
        AppLanguage.bg: 'Профилът е запазен успешно',
        AppLanguage.ru: 'Профиль успешно сохранен',
        AppLanguage.zh: '个人资料保存成功',
        AppLanguage.fr: 'Profil enregistré avec succès',
        AppLanguage.de: 'Profil erfolgreich gespeichert',
        AppLanguage.es: 'Perfil guardado con éxito',
        AppLanguage.ar: 'تم حفظ الملف الشخصي بنجاح',
      },
      'discard_changes': {
        AppLanguage.en: 'Discard Changes?',
        AppLanguage.tr: 'Değişiklikler Silinsin mi?',
        AppLanguage.el: 'Απόρριψη Αλλαγών;',
        AppLanguage.bg: 'Отхвърляне на Промените?',
        AppLanguage.ru: 'Отменить Изменения?',
        AppLanguage.zh: '放弃更改？',
        AppLanguage.fr: 'Annuler les Modifications?',
        AppLanguage.de: 'Änderungen Verwerfen?',
        AppLanguage.es: '¿Descartar Cambios?',
        AppLanguage.ar: 'تجاهل التغييرات؟',
      },
      'discard_changes_desc': {
        AppLanguage.en:
            'You have unsaved changes. Are you sure you want to leave?',
        AppLanguage.tr:
            'Kaydedilmemiş değişiklikleriniz var. Çıkmak istediğinizden emin misiniz?',
        AppLanguage.el:
            'Έχετε μη αποθηκευμένες αλλαγές. Είστε βέβαιοι ότι θέλετε να φύγετε;',
        AppLanguage.bg:
            'Имате незапазени промени. Сигурни ли сте, че искате да излезете?',
        AppLanguage.ru:
            'У вас есть несохраненные изменения. Вы уверены, что хотите выйти?',
        AppLanguage.zh: '您有未保存的更改。确定要离开吗？',
        AppLanguage.fr:
            'Vous avez des modifications non enregistrées. Êtes-vous sûr de vouloir partir?',
        AppLanguage.de:
            'Du hast ungespeicherte Änderungen. Bist du sicher, dass du gehen möchtest?',
        AppLanguage.es:
            'Tienes cambios sin guardar. ¿Seguro que quieres salir?',
        AppLanguage.ar:
            'لديك تغييرات غير محفوظة. هل أنت متأكد أنك تريد المغادرة؟',
      },
      'discard': {
        AppLanguage.en: 'Discard',
        AppLanguage.tr: 'Sil',
        AppLanguage.el: 'Απόρριψη',
        AppLanguage.bg: 'Отхвърли',
        AppLanguage.ru: 'Отменить',
        AppLanguage.zh: '放弃',
        AppLanguage.fr: 'Annuler',
        AppLanguage.de: 'Verwerfen',
        AppLanguage.es: 'Descartar',
        AppLanguage.ar: 'تجاهل',
      },
    };

    return strings[key]?[language] ?? strings[key]?[AppLanguage.en] ?? key;
  }
}

class _CosmicSignCard extends StatelessWidget {
  final String title;
  final ZodiacSign? sign;
  final bool isDark;

  const _CosmicSignCard({
    required this.title,
    required this.sign,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withOpacity(0.3)
            : AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: sign != null
            ? Border.all(color: sign!.color.withOpacity(0.3))
            : null,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 6),
          if (sign != null) ...[
            Text(
              sign!.symbol,
              style: TextStyle(fontSize: 24, color: sign!.color),
            ),
            const SizedBox(height: 4),
            Text(
              sign!.nameTr,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: sign!.color,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ] else
            Text(
              '?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
        ],
      ),
    );
  }
}
