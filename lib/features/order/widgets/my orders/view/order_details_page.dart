import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20repo/order/order_notifier.dart';
import 'package:sadhana_cart/core/common%20services/shiprocket_api/api_provider.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';
import 'package:sadhana_cart/core/common%20services/shiprocket_api/shiprocket_api_services.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final OrderModel order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  late OrderModel order;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    order = widget.order;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    _syncOrderStatus(userId);
  }

  Future<void> _syncOrderStatus(String userId) async {
    try {
      final apiService = ShiprocketApiServices(ref.read(dioProvider), ref);

      final apiResponse = await apiService.getOrderDetails(order.orderId!);

      log("API Response: $apiResponse");

      final apiStatus = apiResponse['data']?['status']?.toString() ?? '';
      final firebaseStatus = order.orderStatus ?? 'Pending';

      log("Firebase Order Status (before update): $firebaseStatus");

      if (apiStatus.isNotEmpty && apiStatus != firebaseStatus) {
        log(
          " Status mismatch detected (API: $apiStatus vs Firebase: $firebaseStatus). "
          "Calling OrderNotifier.updateOrderStatus...",
        );

        // Convert orderId to number before passing to Firestore query
        final orderIdNumber = int.tryParse(order.orderId!) ?? 0;

        // Call centralized update method
        await ref
            .read(orderProvider.notifier)
            .updateOrderStatus(
              userId: userId,
              orderId: orderIdNumber.toString(), // still keep string in model
              apiStatus: apiStatus,
            );

        // Update local UI state
        setState(() {
          order = order.copyWith(orderStatus: apiStatus);
        });

        log("Local state updated successfully to: ${order.orderStatus}");
      } else {
        log("No update required. Status already matches.");
      }
    } catch (e, st) {
      log("Exception in _syncOrderStatus: $e");
      log("Stacktrace: $st");
    } finally {
      log("Finished");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orderStatus = order.orderStatus ?? 'Pending';

    final image = OrderStatusEnums.values
        .firstWhere(
          (e) => e.label == orderStatus,
          orElse: () => OrderStatusEnums.pending,
        )
        .image;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Status container
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: size.height * 0.15,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 0),
                          Text(
                            "Your order is $orderStatus",
                            style: const TextStyle(
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

                    // Basic details
                    Container(
                      width: size.width,
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
                          children: [
                            _customText(
                              title: "Order ID: ",
                              titleColor: AppColor.orderStatusColor,
                              value: order.orderId ?? '--',
                              valueColor: Colors.black,
                            ),
                            _customText(
                              title: "Delivery Address: ",
                              titleColor: AppColor.orderStatusColor,
                              value: order.address ?? '--',
                              valueColor: Colors.black,
                              maxLines: 3,
                            ),
                            _customText(
                              title: "Quantity: ",
                              titleColor: AppColor.orderStatusColor,
                              value: order.quantity.toString(),
                              valueColor: Colors.black,
                            ),
                            _customText(
                              title: "Total Amount: ",
                              titleColor: AppColor.orderStatusColor,
                              value:
                                  "₹ ${order.totalAmount.toStringAsFixed(2)}",
                              valueColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Products List
                    if (order.products.isNotEmpty)
                      Column(
                        children: order.products.map((product) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? '--',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Price: ₹${(product.price ?? 0).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Quantity: ${product.quantity ?? 1}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (product.sizevariants != null &&
                                    product.sizevariants!.isNotEmpty)
                                  Text(
                                    "Selected Size: ${product.sizevariants!.first.size}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    else
                      const Text("No products found"),
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
