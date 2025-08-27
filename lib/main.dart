import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/responsive/responsive_screen.dart';
import 'package:sadhana_cart/core/themes/app_themes.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_mobile.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_tablet.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sadhana Cart",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: const ResponsiveScreen(
        mobileScreen: SplashPageMobile(),
        tabletScreen: SplashPageTablet(),
      ),
    );
  }
}
