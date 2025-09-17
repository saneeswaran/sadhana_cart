import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/order/order_notifier.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_outline_button.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/view/order_details_page.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/widget/order_details_loader.dart';

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
    final orders = ref.watch(orderProvider);
    if (orders.isLoading) {
      return const OrderDetailsLoader();
    }

    if (orders.orders.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No orders found",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: orders.orders.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final order = orders.orders[index];
        final date = order.orderDate.toDate();
        final matchingColor = OrderStatusEnums.values
            .firstWhere((e) => e.label == order.orderStatus)
            .color;
        //outside container
        return GestureDetector(
          onTap: () {},
          child: Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderId!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${date.day}/${date.month}/${date.year}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
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
                      value: order.quantity.toString(),
                      valueColor: Colors.black,
                      valueFontWeight: FontWeight.bold,
                    ),
                    _customText(
                      title: "Subtotal:   ",
                      titleFontWeight: FontWeight.bold,
                      titleColor: const Color(0xff777e90),
                      value: "${Constants.indianCurrency} ${order.totalAmount}",
                      valueColor: Colors.black,
                      valueFontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderStatus!,
                      style: TextStyle(
                        color: matchingColor,
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
                        navigateTo(
                          context: context,
                          screen: OrderDetailsPage(order: order),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
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
