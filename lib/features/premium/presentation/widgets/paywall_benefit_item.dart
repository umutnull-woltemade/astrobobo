import 'package:flutter/material.dart';

/// A single benefit item for the paywall
/// Displays a checkmark icon with benefit text
class PaywallBenefitItem extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? iconColor;

  const PaywallBenefitItem({
    super.key,
    required this.text,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: (iconColor ?? const Color(0xFFD4AF37)).withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.check_rounded,
              size: 16,
              color: iconColor ?? const Color(0xFFD4AF37),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColor ?? Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
