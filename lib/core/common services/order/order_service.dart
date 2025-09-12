import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';
import 'package:sadhana_cart/core/common%20repo/order/order_notifier.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';

class OrderService {
  static const String userCollection = 'users';
  static const String productCollection = 'products';

  static final String currentUser = FirebaseAuth.instance.currentUser!.uid;

  // Path: /users/{currentUserId}/orders
  static final CollectionReference orderRef = FirebaseFirestore.instance
      .collection(userCollection)
      .doc(currentUser)
      .collection('orders');

  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(productCollection);

  /// Adds a new order and updates product stock
  static Future<bool> addOrder({
    required double totalAmount,
    required int phoneNumber,
    required String address,
    required double latitude,
    required double longitude,
    required String orderDate,
    required int quantity,
    required List<ProductModel> products,
    required Timestamp createdAt,
    required WidgetRef ref,
  }) async {
    try {
      log("Starting addOrder for user: $currentUser");
      log("Total Amount: $totalAmount, Products Count: ${products.length}");

      final orderDoc = orderRef.doc();

      final OrderModel orderModel = OrderModel(
        quantity: quantity,
        userId: currentUser,
        totalAmount: totalAmount,
        address: address,
        phoneNumber: phoneNumber,
        latitude: latitude,
        longitude: longitude,
        orderStatus: OrderStatusEnums.pending.label,
        orderDate: orderDate,
        orderId: orderDoc.id,
        createdAt: createdAt,
        products: products,
      );

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        log("Running Firestore transaction for order: ${orderDoc.id}");

        for (final orderedProduct in products) {
          final productId = orderedProduct.productId;

          if (productId == null || productId.isEmpty) {
            log("Invalid product ID in order.");
            throw Exception("Invalid product ID in order.");
          }

          final productRefDoc = productRef.doc(productId);
          final productSnapshot = await transaction.get(productRefDoc);

          if (!productSnapshot.exists) {
            log("Product not found in Firestore: $productId");
            throw Exception("Product not found: $productId");
          }

          final data = ProductModel.fromMap(
            productSnapshot.data() as Map<String, dynamic>,
          );

          log("Updating stock for product: $productId");

          final currentTotalStock = data.stock ?? 0;
          final List<dynamic> sizeVariants = data.sizeVariants ?? [];
          final List<SizeVariant> orderedVariants =
              orderedProduct.sizeVariants ?? [];

          final updatedVariants = sizeVariants.map((variant) {
            final variantSize = variant['size'];
            final variantColor = variant['color'];

            final matchingOrderedVariant = orderedVariants.firstWhere(
              (ordered) =>
                  ordered.size == variantSize &&
                  (ordered.color ?? '') == (variantColor ?? ''),
              orElse: () =>
                  SizeVariant(size: variantSize, color: variantColor, stock: 0),
            );

            final currentStock = variant['stock'] ?? 0;
            final stockToSubtract = matchingOrderedVariant.stock;
            final newStock = (currentStock as int) - stockToSubtract;

            if (newStock < 0) {
              log(
                "Insufficient stock for product $productId, size ${matchingOrderedVariant.size}",
              );
              throw Exception(
                "Insufficient stock for product $productId, size ${matchingOrderedVariant.size}",
              );
            }

            return {
              'size': variantSize,
              'color': variantColor,
              'stock': newStock,
            };
          }).toList();

          final totalStockToSubtract = orderedVariants.fold<int>(
            0,
            (sum, v) => sum + v.stock,
          );

          transaction.update(productRefDoc, {
            'totalStock': currentTotalStock - totalStockToSubtract,
            'sizeVariants': updatedVariants,
          });

          log(
            "Stock updated for product: $productId, New Total Stock: ${currentTotalStock - totalStockToSubtract}",
          );
        }

        // Save order document
        transaction.set(orderDoc, orderModel.toMap());
        log("Order written to Firestore document: ${orderDoc.id}");
      });

      // Update local provider
      ref.read(orderProvider.notifier).addOrder(order: orderModel);

      log(
        "Order placed successfully for user: $currentUser, Order ID: ${orderDoc.id}",
      );
      return true;
    } catch (e, stack) {
      log("Order Service Error: $e");
      log("Stack Trace: $stack");
      return false;
    }
  }

  /// Fetch orders of current user
  static Future<List<OrderModel>> fetchCustomerOrderDetails() async {
    try {
      log("Fetching orders for user: $currentUser");
      final QuerySnapshot querySnapshot = await orderRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        log("Found ${querySnapshot.docs.length} orders for user: $currentUser");
        return querySnapshot.docs
            .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        log("No orders found for user: $currentUser");
        return [];
      }
    } catch (e) {
      log("Order Service fetch error: $e");
      return [];
    }
  }
}
