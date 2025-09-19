import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/order/order_notifier.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/widgets/custom_outline_button.dart';

class CustomOrdersListTile extends ConsumerStatefulWidget {
  const CustomOrdersListTile({super.key});

  @override
  ConsumerState<CustomOrdersListTile> createState() =>
      _CustomOrdersListTileState();
}

class _CustomOrdersListTileState extends ConsumerState<CustomOrdersListTile> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(orderProvider.notifier).fetchCustomOrderDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = ref.watch(orderProvider);
    // if (orders.loading) {
    //   return const OrderDetailsLoader();
    // }

    // if (orders.orders.isEmpty) {
    //   return const Scaffold(
    //     body: Center(
    //       child: Text(
    //         "No orders found",
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //   );
    // }
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        //outside container
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(20),
          height: size.height * 0.3,
          width: size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            spacing: 25,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OrderID",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Date",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff777E90),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              _customText(
                title: "Tracking Number:   ",
                titleFontWeight: FontWeight.bold,
                titleColor: const Color(0xff777e90),
                value: "1234567890",
                valueColor: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customText(
                    title: "Quantity: ",
                    titleFontWeight: FontWeight.bold,
                    titleColor: const Color(0xff777e90),
                    value: "3",
                    valueColor: Colors.black,
                    valueFontWeight: FontWeight.bold,
                  ),
                  _customText(
                    title: "Subtotal:   ",
                    titleFontWeight: FontWeight.bold,
                    titleColor: const Color(0xff777e90),
                    value: "${Constants.indianCurrency} 110",
                    valueColor: Colors.black,
                    valueFontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pending",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomOutlineButton(
                    child: const Text(
                      "Details",
                      style: customOutlinedButtonStyle,
                    ),
                    onPressed: () {
                      // navigateTo(
                      //   context: context,
                      //   screen: const OrderDetailsPage(),
                      // );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _customText({
    required String title,
    Color? titleColor = Colors.black,
    double fontSize = 16,
    FontWeight? titleFontWeight = FontWeight.normal,
    required String value,
    Color? valueColor = const Color(0xff777E90),
    FontWeight? valueFontWeight = FontWeight.normal,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: fontSize,
            fontWeight: titleFontWeight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 16,
            fontWeight: valueFontWeight,
          ),
        ),
      ],
    );
  }
}
