import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_stepper.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
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
    super.initState();
    pageController.addListener(() {
      final newIndex = pageController.page!.round();
      if (currentIndex != newIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: CustomStepper(currentIndex: currentIndex),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView.builder(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: orderPages.length,
        itemBuilder: (context, index) => orderPages[index],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
        child: CustomElevatedButton(
          onPressed: () {
            if (currentIndex < orderPages.length - 1) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            } else {
              successSnackBar(
                message: "Order placed successfully",
                context: context,
              );
            }
          },
          child: Text(
            currentIndex < orderPages.length - 1 ? "Continue" : "Finish",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
