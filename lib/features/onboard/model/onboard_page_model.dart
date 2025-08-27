import 'package:animate_do/animate_do.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/oboard_button.dart';
import 'package:sadhana_cart/features/auth/view/sign%20up/view/sign_up_mobile.dart';
import 'package:sadhana_cart/features/onboard/view%20model/onboard_view_model.dart';

class OnboardScreen extends ConsumerStatefulWidget {
  const OnboardScreen({super.key});

  @override
  ConsumerState<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentIndex = ref.watch(onboardDotController);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(color: Colors.white),
          Positioned(
            top: size.height * 0.50,
            child: Container(
              height: size.height * 0.50,
              width: size.width,
              color: AppColors.primaryColor,
            ),
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: onboardData.length,
            onPageChanged: (index) {
              ref.read(onboardDotController.notifier).state = index;
            },
            itemBuilder: (context, index) {
              final item = onboardData[index];
              return Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    SlideInRight(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SlideInRight(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        item['subtitle']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: size.height * 0.5,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: AppColors.onboardGreyColor,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(item['imagePath']!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 180,
            child: DotsIndicator(
              dotsCount: onboardData.length,
              position: currentIndex.toDouble(),
              decorator: const DotsDecorator(
                activeColor: Colors.white,
                color: Colors.grey,
              ),
              onTap: (index) {
                ref.read(onboardDotController.notifier).state = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Positioned(
            bottom: 100,
            child: OboardButton(
              text: currentIndex == onboardData.length - 1
                  ? "Start Shopping"
                  : "Next",
              onPressed: () {
                final currentIndex = ref.read(onboardDotController);
                if (currentIndex < onboardData.length - 1) {
                  ref.read(onboardDotController.notifier).state++;
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  navigateTo(context: context, screen: const SignUpMobile());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> onboardData = [
  {
    'title': "Discover Something New",
    'subtitle': "Special New Arrival",
    'imagePath': AppImages.onboard1,
  },
  {
    'title': "Update Your Style",
    'subtitle': "Favorite Collection",
    'imagePath': AppImages.onboard2,
  },
  {
    'title': "Explore Something New",
    'subtitle': "Relax and let us bring you something new",
    'imagePath': AppImages.onboard3,
  },
];

final List<Widget> onboardPages = [
  const OnboardScreen(),
  const OnboardScreen(),
  const OnboardScreen(),
];
