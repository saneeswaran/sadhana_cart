import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/payment_option_tile.dart';

enum PaymentMethod { cash, online }

class SelectPaymentPage extends StatefulWidget {
  const SelectPaymentPage({super.key});

  @override
  State<SelectPaymentPage> createState() => _SelectPaymentPageState();
}

class _SelectPaymentPageState extends State<SelectPaymentPage> {
  PaymentMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Payment Method"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomElevatedButton(
          child: const Text("Continue", style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Navigate to payment or confirm order
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Selected: ${_selectedMethod == PaymentMethod.cash ? "Cash On Delivery" : "Online Payment"}",
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            PaymentOptionTile(
              title: "Cash On Delivery",
              description: "Pay when you receive your product",
              price: "\$220",
              selected: _selectedMethod == PaymentMethod.cash,
              onTap: () {
                setState(() {
                  _selectedMethod = PaymentMethod.cash;
                });
              },
            ),
            const SizedBox(height: 16),
            PaymentOptionTile(
              title: "Online Payment",
              description: "Pay now using card or UPI",
              price: "\$220",
              selected: _selectedMethod == PaymentMethod.online,
              onTap: () {
                setState(() {
                  _selectedMethod = PaymentMethod.online;
                });
              },
            ),
            const Spacer(),

            // ElevatedButton(
            //   onPressed: _selectedMethod != null
            //       ? () {
            //           // Navigate to payment or confirm order
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(
            //               content: Text(
            //                 "Selected: ${_selectedMethod == PaymentMethod.cash ? "Cash On Delivery" : "Online Payment"}",
            //               ),
            //             ),
            //           );
            //         }
            //       : null,
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(double.infinity, 50),
            //     backgroundColor: Colors.blue,
            //   ),
            //   child: const Text(
            //     "Continue",
            //     style: TextStyle(color: Colors.white, fontSize: 18),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
