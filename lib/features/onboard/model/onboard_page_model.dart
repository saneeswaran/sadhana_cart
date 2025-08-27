import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class OnboardPageModel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  const OnboardPageModel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height * 1,
            width: size.width * 1,
            color: Colors.white,
          ),
          Positioned(
            top: size.height * 0.50,
            child: Container(
              height: size.height * 0.50,
              width: size.width * 1,
              color: AppColors.primaryColor,
            ),
          ),
          Positioned(
            top: size.height * 0.10,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            height: size.height * 0.50,
            width: size.width * 0.80,
            decoration: BoxDecoration(
              color: AppColors.onboardGreyColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
