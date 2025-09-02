import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class CustomRatioButton<T> extends StatelessWidget {
  final T groupValue;
  final T value;
  final void Function(T?)? onChanged;
  const CustomRatioButton({
    super.key,
    required this.value,
    this.onChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Radio.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      groupValue: groupValue,
      focusColor: AppColors.primaryColor,
      hoverColor: AppColors.primaryColor,
      splashRadius: 0.0,
    );
  }
}
