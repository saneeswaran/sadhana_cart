import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/widget/ordered_product_tile.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orderStatus = order.orderStatus;
    final image = OrderStatusEnums.values
        .firstWhere((e) => e.label == orderStatus)
        .image;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "OrderId",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //status container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: size.height * 0.15,
                width: size.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 0),
                    const Text(
                      "Your order is Delivered",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.3,
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //basic details
              Container(
                height: size.height * 0.3,
                width: size.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      _customText(
                        title: "Order Number",
                        titleColor: AppColor.orderStatusColor,
                        value: "${order.orderId}",
                        valueColor: Colors.black,
                      ),
                      _customText(
                        title: "tracking Number",
                        titleColor: AppColor.orderStatusColor,
                        value: "HGJKDSF878",
                        valueColor: Colors.black,
                      ),
                      _customText(
                        title: "Delivery Address: ",
                        titleColor: AppColor.orderStatusColor,
                        value: order.address,
                        valueColor: Colors.black,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const OrderedProductTile(),
            ],
          ),
        ),
      ),
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
    int? maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: fontSize,
            fontWeight: titleFontWeight,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
              color: valueColor,
              fontSize: 16,
              fontWeight: valueFontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
