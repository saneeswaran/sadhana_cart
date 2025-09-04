import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Compeleted",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width * 1,
                child: SvgPicture.asset(
                  AppImages.orderCompleted,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
