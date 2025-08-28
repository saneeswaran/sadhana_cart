import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/app%20routes/app_routes.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/helper/main_helper.dart';
import 'package:sadhana_cart/core/responsive/responsive_screen.dart';
import 'package:sadhana_cart/features/bottom%20nav/view/bottom_nav_option.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_mobile.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_tablet.dart';

void main() async {
  await MainHelper.inits();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sadhana Cart",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.pureWhite,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.pureWhite),
      ),
      themeMode: ThemeMode.light,
      routes: AppRoutes.routes,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const SplashPageMobile();
          } else if (snapShot.hasData) {
            return const ResponsiveScreen(
              mobileScreen: SplashPageMobile(),
              tabletScreen: SplashPageTablet(),
            );
          } else {
            return const BottomNavOption();
          }
        },
      ),
    );
  }
}
