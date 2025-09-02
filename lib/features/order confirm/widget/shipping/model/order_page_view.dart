import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/shipping/model/order_page_controller.dart';

class OrderPageView extends StatefulWidget {
  const OrderPageView({super.key});

  @override
  State<OrderPageView> createState() => _OrderPageViewState();
}

class _OrderPageViewState extends State<OrderPageView> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      currentIndex = pageController.page!.toInt();
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: orderPages.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: pageController,
        itemBuilder: (context, index) {
          return orderPages[index];
        },
      ),
    );
  }
}
