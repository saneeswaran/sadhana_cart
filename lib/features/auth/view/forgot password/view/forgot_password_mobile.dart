import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';

class ForgotPasswordMobile extends StatefulWidget {
  const ForgotPasswordMobile({super.key});

  @override
  State<ForgotPasswordMobile> createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const SizedBox(height: 50),
            const Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              "Enter email associated with your account and we will send you a link to reset your password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            CustomTextFormField(
              controller: emailController,
              labelText: "Email address",
              suffixIcon: Icon(Icons.email, color: Colors.grey.shade300),
            ),
          ],
        ),
      ),
    );
  }
}
