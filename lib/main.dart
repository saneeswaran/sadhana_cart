import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/app%20routes/app_routes.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/helper/main_helper.dart';
import 'package:sadhana_cart/features/bottom%20nav/view/bottom_nav_option.dart';
import 'package:sadhana_cart/features/onboard/view/onboard_page_mobile.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: AppColor.pureWhite,
        appBarTheme: const AppBarTheme(backgroundColor: AppColor.pureWhite),
      ),
      themeMode: ThemeMode.light,
      routes: AppRoutes.routes,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPageMobile();
          }
          if (snapshot.hasData) {
            return const BottomNavOption();
          }
          return const OnboardPageMobile();
        },
      ),
    );
  }
}
