import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/auth/view/forgot%20password/view/forgot_password_mobile.dart';
import 'package:sadhana_cart/features/auth/view/sign%20up/view/sign_in_mobile.dart';
import 'package:sadhana_cart/features/auth/view/sign%20up/view/sign_up_mobile.dart';
import 'package:sadhana_cart/features/bottom%20nav/view/bottom_nav_bar_mobile.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/sign-in': (_) => const SignInMobile(),
    '/sign-up': (_) => const SignUpMobile(),
    '/forgot-password': (_) => const ForgotPasswordMobile(),
    '/bottom-nav': (_) => const BottomNavBarMobile(),
  };
}
