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
  static const String orderCollection = 'orders';
  static const String productCollection = 'products';
  static final CollectionReference orderRef = FirebaseFirestore.instance
      .collection(orderCollection);

  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(productCollection);
  static final currentUser = FirebaseAuth.instance.currentUser!.uid;

  static Future<bool> addOrder({
    required double totalAmount,
    required String address,
    required int phoneNumber,
    required double latitude,
    required double longitude,
    required String orderDate,
    required int quantity,
    required List<ProductModel> products,
    required Timestamp createdAt,
    required WidgetRef ref,
  }) async {
    try {
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
        for (final orderedProduct in products) {
          final productId = orderedProduct.productId;
          final List<SizeVariant> orderedVariants = orderedProduct.sizeVariants;

          final productRefDoc = productRef.doc(productId);
          final productSnapshot = await transaction.get(productRefDoc);

          if (!productSnapshot.exists) {
            throw Exception("Product not found: $productId");
          }

          final data = ProductModel.fromMap(
            productSnapshot.data() as Map<String, dynamic>,
          );

          final currentTotalStock = data.totalStock;
          List<dynamic> sizeVariants = data.sizeVariants;

          // Update each size variant stock
          final updatedVariants = sizeVariants.map((variant) {
            final variantSize = variant['size'];
            final variantColor = variant['color'];

            final matchingOrderedVariant = orderedVariants.firstWhere(
              (ordered) =>
                  ordered.size == variantSize &&
                  (ordered.color ?? '') == (variantColor ?? ''),
            );

            final currentStock = variant['stock'] ?? 0;
            final stockToSubtract = matchingOrderedVariant.stock;

            final newStock = (currentStock as int) - stockToSubtract;

            if (newStock < 0) {
              throw Exception(
                "Insufficient stock for product $productId, size ${matchingOrderedVariant.size}",
              );
            }

            return {...variant, 'stock': newStock};
          }).toList();

          // Decrease total stock by sum of all variant quantities in this product
          final totalStockToSubtract = orderedVariants.fold<int>(
            0,
            (int sum, v) => sum + v.stock,
          );

          transaction.update(productRefDoc, {
            'totalStock': currentTotalStock - totalStockToSubtract,
            'sizeVariants': updatedVariants,
          });
        }

        // Add order to Firestore
        transaction.set(orderDoc, orderModel.toMap());
      });

      // Update provider outside the transaction
      ref.read(orderProvider.notifier).addOrder(order: orderModel);

      return true;
    } catch (e, stack) {
      log("Order Service Error: $e");
      log("Stack Trace: $stack");
      return false;
    }
  }

  static Future<List<OrderModel>> fetchCustomerOrderDetails() async {
    try {
      final QuerySnapshot querySnapshot = await orderRef
          .where("userId", isEqualTo: currentUser)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      } else {
        log("order not found");
        return [];
      }
    } catch (e) {
      log("order service error $e");
      return [];
    }
  }
}
