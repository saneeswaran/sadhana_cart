import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';

class CheckoutTotalAmountContainer extends StatelessWidget {
  const CheckoutTotalAmountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      height: size.height * 0.4,
      width: size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(orderStepperPageProvider);
          return Column(
            spacing: index == 1 ? 10 : 20,
            children: [
              _price(text: "Product Price", value: "1000"),
              _customDivider(),
              _price(text: "Shipping", value: "Freeship"),
              _customDivider(),
              _price(text: "Subtotal", value: "1000"),
              _customDivider(),
            ],
          );
        },
      ),
    );
  }

  Widget _price({required String text, required String value}) {
    const TextStyle textStyle = TextStyle(
      color: Color(0xff8A8A8F),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    const TextStyle valueStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: textStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  Widget _customDivider() {
    return const Divider(color: AppColors.tileColor, thickness: 1.2);
  }
}
