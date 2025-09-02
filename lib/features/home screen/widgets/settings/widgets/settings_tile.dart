import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const SettingsTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(
            text,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(icon, size: 40, color: AppColors.onboardButtonColor),
        ),
        const Divider(color: AppColors.primaryColor),
      ],
    );
  }
}
