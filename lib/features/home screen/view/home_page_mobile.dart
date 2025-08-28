import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_app_bar.dart';

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Sadhana cart",
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
