import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/onboard/view/onboard_page_mobile.dart';

class SplashPageMobile extends StatelessWidget {
  const SplashPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        navigateToReplacement(
          context: context,
          screen: const OnboardPageMobile(),
        );
      }
    });
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        width: size.width * 1,
        color: AppColor.primaryColor,
      ),
    );
  }
}
