import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/auth%20service/auth_service.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/helper/validation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';
import 'package:sadhana_cart/core/widgets/rounded_signin_button.dart';
import 'package:sadhana_cart/features/auth/view/forgot%20password/view/forgot_password_mobile.dart';
import 'package:sadhana_cart/features/bottom%20nav/view/bottom_nav_bar_mobile.dart';

class SignInMobile extends ConsumerStatefulWidget {
  const SignInMobile({super.key});

  @override
  ConsumerState<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends ConsumerState<SignInMobile> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loadingProvider);
    final passwordEye = ref.watch(passEyeProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: loader,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    "log into\nyour account ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: emailController,
                    labelText: "Email address",
                    validator: ValidationHelper.emailValidate(),
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    labelText: "Password",
                    validator: ValidationHelper.passwordValidate(
                      number: passwordController.text.length,
                    ),
                    obscureText: passwordEye,
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordEye ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        ref.read(passEyeProvider.notifier).state = !passwordEye;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      text: "Forgot Password?",
                      onPressed: () {
                        navigateTo(
                          context: context,
                          screen: const ForgotPasswordMobile(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomElevatedButton(
                      child: loader
                          ? const Loader()
                          : const Text(
                              "Sign In",
                              style: customElevatedButtonTextStyle,
                            ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final user = await AuthService.signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            ref: ref,
                          );
                          if (user != null && context.mounted) {
                            navigateTo(
                              context: context,
                              screen: const BottomNavBarMobile(),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const Center(
                    child: Text(
                      "or continue with",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedSigninButton(
                        imagePath: AppImages.googleSvg,
                        onTap: () {},
                      ),
                      const SizedBox(width: 30),
                      RoundedSigninButton(
                        imagePath: AppImages.appleSvg,
                        onTap: () {
                          navigateTo(
                            context: context,
                            screen: const BottomNavBarMobile(),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      CustomTextButton(
                        text: "Sign Up",
                        onPressed: () async {
                          navigateBack(context: context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
