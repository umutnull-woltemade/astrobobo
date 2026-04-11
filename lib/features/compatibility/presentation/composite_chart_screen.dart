import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/advanced_astrology.dart';
import '../../../data/services/advanced_astrology_service.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';

class CompositeChartScreen extends ConsumerStatefulWidget {
  const CompositeChartScreen({super.key});

  @override
  ConsumerState<CompositeChartScreen> createState() =>
      _CompositeChartScreenState();
}

class _CompositeChartScreenState extends ConsumerState<CompositeChartScreen> {
  final _partnerNameController = TextEditingController(text: 'Partner');

  ZodiacSign _partnerSun = ZodiacSign.leo;
  ZodiacSign _partnerMoon = ZodiacSign.pisces;

  CompositeChart? _chart;

  void _generateChart() {
    final userProfile = ref.read(userProfileProvider);
    if (userProfile == null) return;

    setState(() {
      _chart = AdvancedAstrologyService.generateCompositeChart(
        person1Name: userProfile.name ?? 'Sen',
        person2Name: _partnerNameController.text,
        person1Sun: userProfile.sunSign,
        person2Sun: _partnerSun,
        person1Moon: userProfile.effectiveMoonSign,
        person2Moon: _partnerMoon,
      );
    });
  }

  @override
  void dispose() {
    _partnerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userProfile = ref.watch(userProfileProvider);

    if (userProfile == null) {
      return Scaffold(
        body: CosmicBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                Text(
                  'Profil bulunamadi',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lutfen once dogum bilgilerinizi girin',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Geri Don'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
                  child: Column(
                    children: [
                      _buildUserProfileCard(isDark, userProfile),
                      const SizedBox(height: AppConstants.spacingMd),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.pink.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.favorite, color: Colors.pink),
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      _buildPartnerInputCard(isDark),
                      const SizedBox(height: AppConstants.spacingLg),
                      if (_chart != null) ...[
                        _buildCompatibilityScore(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildCompositePositions(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildRelationshipTheme(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildDynamicsCards(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildAspectsCard(isDark),
                        const SizedBox(height: AppConstants.spacingMd),
                        _buildSoulPurpose(isDark),
                        const SizedBox(height: AppConstants.spacingXxl),
                      ],
                    ],
                  ),
                ),
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
            icon: const Icon(Icons.arrow_back),
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.people, color: Colors.pink, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Kompozit Harita',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileCard(bool isDark, UserProfile userProfile) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Kisi 1 (Sen)',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 4),
              Text(
                'Profilden',
                style: TextStyle(fontSize: 11, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildInfoRow(
            isDark,
            Icons.person_outline,
            'Isim',
            userProfile.name ?? 'Kullanici',
          ),
          _buildInfoRow(
            isDark,
            Icons.wb_sunny_outlined,
            'Gunes',
            userProfile.sunSign.nameTr,
          ),
          if (userProfile.moonSign != null)
            _buildInfoRow(
              isDark,
              Icons.nightlight_outlined,
              'Ay',
              userProfile.moonSign!.nameTr,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(bool isDark, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isDark ? Colors.white54 : AppColors.textLight,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : AppColors.textLight,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : AppColors.textDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerInputCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Kisi 2 (Partner)',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextField(
            controller: _partnerNameController,
            decoration: InputDecoration(
              labelText: 'Isim',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSignDropdown(
                  'Gunes',
                  _partnerSun,
                  (sign) => setState(() => _partnerSun = sign),
                  isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSignDropdown(
                  'Ay',
                  _partnerMoon,
                  (sign) => setState(() => _partnerMoon = sign),
                  isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingXl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _generateChart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              child: const Text(
                'Kompozit Harita Olustur',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignDropdown(
    String label,
    ZodiacSign value,
    ValueChanged<ZodiacSign> onChanged,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          ),
          child: DropdownButton<ZodiacSign>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: ZodiacSign.values.map((sign) {
              return DropdownMenuItem(
                value: sign,
                child: Row(
                  children: [
                    Text(sign.symbol),
                    const SizedBox(width: 8),
                    Text(sign.nameTr),
                  ],
                ),
              );
            }).toList(),
            onChanged: (sign) {
              if (sign != null) onChanged(sign);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompatibilityScore(bool isDark) {
    final score = _chart!.overallCompatibility;
    final color = score >= 70
        ? Colors.green
        : score >= 50
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink.withValues(alpha: isDark ? 0.3 : 0.15),
            Colors.purple.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            '${_chart!.person1Name} & ${_chart!.person2Name}',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 10,
                  backgroundColor: color.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                children: [
                  Text(
                    '$score%',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text('Uyum', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompositePositions(bool isDark) {
    final positions = [
      {'label': 'Kompozit Gunes', 'sign': _chart!.compositeSun, 'icon': ''},
      {'label': 'Kompozit Ay', 'sign': _chart!.compositeMoon, 'icon': ''},
      {
        'label': 'Kompozit Yukselesi',
        'sign': _chart!.compositeAscendant,
        'icon': '',
      },
      {'label': 'Kompozit Venus', 'sign': _chart!.compositeVenus, 'icon': ''},
      {'label': 'Kompozit Mars', 'sign': _chart!.compositeMars, 'icon': ''},
    ];

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kompozit Pozisyonlar',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: positions.map((pos) {
              final sign = pos['sign'] as ZodiacSign;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceLight.withValues(alpha: 0.3)
                      : AppColors.lightSurfaceVariant,
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pos['icon'] as String,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(sign.symbol, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      sign.nameTr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRelationshipTheme(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withValues(alpha: isDark ? 0.3 : 0.15),
            Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.purple),
              const SizedBox(width: 8),
              Text(
                'Iliski Temasi',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            _chart!.relationshipTheme,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicsCards(bool isDark) {
    final dynamics = [
      {
        'title': 'Duygusal Dinamikler',
        'content': _chart!.emotionalDynamics,
        'icon': Icons.favorite,
        'color': Colors.pink,
      },
      {
        'title': 'Iletisim Tarzi',
        'content': _chart!.communicationStyle,
        'icon': Icons.chat_bubble,
        'color': Colors.blue,
      },
      {
        'title': 'Güçlü Yanlar',
        'content': _chart!.strengthsOverview,
        'icon': Icons.star,
        'color': Colors.green,
      },
      {
        'title': 'Zorluklar',
        'content': _chart!.challengesOverview,
        'icon': Icons.warning_amber,
        'color': Colors.orange,
      },
    ];

    return Column(
      children: dynamics.map((d) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceLight.withValues(alpha: 0.2)
                : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (d['color'] as Color).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      d['icon'] as IconData,
                      color: d['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    d['title'] as String,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                d['content'] as String,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAspectsCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withValues(alpha: 0.2)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Önemli Açılar',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ..._chart!.keyAspects.map((aspect) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: aspect.isHarmonious
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: aspect.isHarmonious
                      ? Colors.green.withValues(alpha: 0.3)
                      : Colors.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${aspect.planet1} ${aspect.type.symbol} ${aspect.planet2}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: aspect.isHarmonious
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          aspect.type.nameTr,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: aspect.isHarmonious
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    aspect.interpretation,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSoulPurpose(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.starGold.withValues(alpha: isDark ? 0.2 : 0.1),
            AppColors.celestialGold.withValues(alpha: isDark ? 0.2 : 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.starGold, size: 32),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Ruhsal Amac',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.starGold,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            _chart!.soulPurpose,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.6),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
