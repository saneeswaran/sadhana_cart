import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/constants/constants.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      width: size.width * 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 2),
            _customRowText(
              title: "Product Price",
              value: "${Constants.indianCurrency} 1000",
              valueColor: Colors.black,
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 5),
            _customRowText(
              title: "Shipping",
              value: "Freeship",
              valueColor: Colors.black,
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 8),
            _customRowText(
              title: "subtotal",
              value: "${Constants.indianCurrency} 1000",
              valueColor: Colors.black,
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  Widget _customRowText({
    required String title,
    required String value,
    Color? valueColor = Colors.black,
    Color? titleColor = Colors.grey,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
