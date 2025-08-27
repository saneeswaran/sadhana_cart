import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/features/onboard/model/onboard_page_model.dart';

class OnboardPageMobile extends StatelessWidget {
  const OnboardPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardPageModel(
      title: "Something",
      subtitle: "Something",
      imagePath: AppImages.onboard1,
    );
  }
}
