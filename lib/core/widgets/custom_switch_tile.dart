import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  const CustomSwitchTile({
    super.key,
    required this.value,
    this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.switchTileColor,
      activeThumbColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.dartPrimaryColor),
      ),
    );
  }
}
