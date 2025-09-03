import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/custom_payment_method.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Step 1 of 3",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Payment",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(paymentMethodTitle.length, (index) {
              return Consumer(
                builder: (context, ref, child) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(orderStepperPageProvider.notifier).state = index;
                    },
                    child: CustomPaymentMethod(
                      blackImage: paymentMethodImageBlack[index],
                      whiteImage: paymentMethodImageWhite[index],
                      index: index,
                      title: paymentMethodTitle[index],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
