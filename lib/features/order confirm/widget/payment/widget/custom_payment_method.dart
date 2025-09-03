import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';

class CustomPaymentMethod extends StatelessWidget {
  const CustomPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(AppImages.creditCard, fit: BoxFit.contain),
          const Text("Credit Card"),
        ],
      ),
    );
  }
}
