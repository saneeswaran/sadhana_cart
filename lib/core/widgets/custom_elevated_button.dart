import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(size.width * 0.7, size.height * 0.07),
        backgroundColor: AppColors.dartPrimaryColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

const TextStyle customElevatedButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
