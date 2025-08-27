import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';
import 'package:sadhana_cart/core/widgets/rounded_signin_button.dart';

class SignUpMobile extends ConsumerStatefulWidget {
  const SignUpMobile({super.key});

  @override
  ConsumerState<SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends ConsumerState<SignUpMobile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Create\n your account ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: nameController,
              labelText: "Enter your name",
            ),
            CustomTextFormField(
              controller: emailController,
              labelText: "Email address",
            ),
            CustomTextFormField(
              controller: passwordController,
              labelText: "Password",
            ),
            CustomTextFormField(
              controller: confirmPasswordController,
              labelText: "Confirm password",
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomElevatedButton(
                child: const Text(
                  "Sign Up",
                  style: customElevatedButtonTextStyle,
                ),
                onPressed: () {},
              ),
            ),
            const Center(
              child: Text(
                "or continue with",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedSigninButton(
                  imagePath: AppImages.googleSvg,
                  onTap: () {},
                ),
                RoundedSigninButton(
                  imagePath: AppImages.appleSvg,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
