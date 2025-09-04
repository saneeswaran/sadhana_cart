import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/checkout_total_amount_container.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/custom_payment_method.dart';
import 'package:sadhana_cart/features/profile/widget/payment/view%20model/list_wallet_page.dart';

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
                      image: paymentMethodImage[index],
                      index: index,
                      title: paymentMethodTitle[index],
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(orderStepperPageProvider);
              if (index == 0) {
                return const SizedBox.shrink();
              } else if (index == 1) {
                return const ListWalletPage();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          const CheckoutTotalAmountContainer(),
        ],
      ),
    );
  }
}
