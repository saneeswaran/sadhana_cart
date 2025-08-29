import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/features/cart/widget/cart_item_tile.dart';
import 'package:sadhana_cart/features/cart/widget/check_out_details.dart';

class CartPageMobile extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  const CartPageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomElevatedButton(
          child: const Text(
            "Checkout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
        ),
      ),
      appBar: appBar,
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CartItemTile(),
            Expanded(child: CheckOutDetails()),
          ],
        ),
      ),
    );
  }
}
