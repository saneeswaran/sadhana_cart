import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/shipping/model/order_page_controller.dart';

class CustomStepper extends StatelessWidget {
  final int currentIndex;

  const CustomStepper({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Row(
            children: List.generate(5, (_) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade400,
                  ),
                ),
              );
            }),
          );
        } else {
          final stepIndex = index ~/ 2;
          bool isCurrent = stepIndex == currentIndex;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCurrent ? Colors.black : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(steps[stepIndex], color: Colors.white, size: 20),
          );
        }
      }),
    );
  }
}
