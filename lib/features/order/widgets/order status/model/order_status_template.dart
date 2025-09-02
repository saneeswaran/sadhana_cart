import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';

class OrderStatusTemplate extends StatelessWidget {
  final String status;
  const OrderStatusTemplate({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          status,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            "Order $status",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (status == OrderStatusEnums.pending.label)
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(AppImages.orderPending, fit: BoxFit.contain),
              ),
            )
          else if (status == OrderStatusEnums.processing.label)
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(
                  AppImages.orderProcessing,
                  fit: BoxFit.contain,
                ),
              ),
            )
          else if (status == OrderStatusEnums.delivered.label)
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(
                  AppImages.orderDelivered,
                  fit: BoxFit.contain,
                ),
              ),
            )
          else if (status == OrderStatusEnums.shipped.label)
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(AppImages.orderShipped, fit: BoxFit.contain),
              ),
            )
          else if (status == OrderStatusEnums.cancelled.label)
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(AppImages.orderCanceled, fit: BoxFit.cover),
              ),
            )
          else
            Center(
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.5,
                child: Image.asset(
                  AppImages.orderProcessing,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
