import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/app%20routes/app_routes.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/helper/main_helper.dart';
import 'package:sadhana_cart/core/service/notification_service.dart';
import 'package:sadhana_cart/features/bottom%20nav/view/bottom_nav_option.dart';
import 'package:sadhana_cart/features/onboard/view/onboard_page_mobile.dart';
import 'package:sadhana_cart/features/splash/view/splash_page_mobile.dart';

// main.dart
void main() async {
  await MainHelper.inits();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.initialize()
          .then((_) {
            log('Notifications initialized successfully');
          })
          .catchError((error) {
            log('Failed to initialize notifications: $error');
          });
    });
  }

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
