import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/common%20services/order/order_service.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/enums/payment_enum.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_controller.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_success_page.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';

class PaymentService {
  static Future<void> handlePayment({
    required BuildContext context,
    required String selectedMethod,
    required List<OrderProductModel> products,
    required int quantity,
    required WidgetRef ref,
  }) async {
    final cartNotifier = ref.watch(cartProvider.notifier);
    final totalAmount = cartNotifier.getCartTotalAmount();
    final addressState = ref.read(addressprovider);
    final AddressModel? address = addressState.addresses.isNotEmpty
        ? addressState.addresses.last
        : null;

    if (address == null) {
      showCustomSnackbar(
        context: context,
        message: "Please add an address first.",
        type: ToastType.info,
      );
      return;
    }

    if (selectedMethod == PaymentEnum.cash.label) {
      showCustomSnackbar(
        context: context,
        message: "Payment Selected: Cash On Delivery",
        type: ToastType.info,
      );

      // Add order to Firestore
      final success = await OrderService.addMultipleProductOrder(
        totalAmount: totalAmount,
        address:
            "${address.title}, ${address.streetName}, ${address.city}, ${address.state}, ${address.pinCode}",
        phoneNumber: address.phoneNumber ?? 0,
        latitude: address.lattitude,
        longitude: address.longitude,
        orderDate: DateTime.now().toString(),
        quantity: quantity,
        products: products,
        createdAt: Timestamp.now(),
        ref: ref,
      );

      if (success) {
        log("Order placed successfully (Cash On Delivery)");
        if (!context.mounted) return;
        showCustomSnackbar(
          context: context,
          message: "Order placed successfully!",
          type: ToastType.success,
        );
      } else {
        log(" Failed to place order (Cash On Delivery)");
        if (!context.mounted) return;
        showCustomSnackbar(
          context: context,
          message: "Failed to place order",
          type: ToastType.error,
        );
      }

      navigateToReplacement(
        context: context,
        screen: const PaymentSuccessPage(),
      );
    } else if (selectedMethod == PaymentEnum.online.label) {
      final acceptedTerms = ref.read(orderAcceptTerms);
      if (!acceptedTerms) {
        showCustomSnackbar(
          context: context,
          message: "Please accept Terms & Conditions",
          type: ToastType.info,
        );
        return;
      }

      final paymentController = ref.read(paymentProvider.notifier);
      paymentController.startPayment(amount: totalAmount.toDouble());
    }
  }
}
