import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';
import 'package:sadhana_cart/core/common%20repo/order/order_notifier.dart';
import 'package:sadhana_cart/core/enums/order_status_enums.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

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

  static Future<bool> addMultipleProductOrder({
    required double totalAmount,
    required String address,
    required int phoneNumber,
    required double? latitude,
    required double? longitude,
    required String orderDate,
    required int quantity,
    required List<OrderProductModel> products,
    required Timestamp createdAt,
    required WidgetRef ref,
  }) async {
    try {
      final docRef = orderRef.doc();
      final OrderModel orderModel = OrderModel(
        quantity: quantity,
        userId: currentUser,
        totalAmount: totalAmount,
        address: address,
        phoneNumber: phoneNumber,
        latitude: latitude!,
        longitude: longitude!,
        orderStatus: OrderStatusEnums.pending.label,
        orderDate: Timestamp.now(),
        orderId: docRef.id,
        createdAt: createdAt,
        products: products,
      );

      await docRef.set(orderModel.toMap());
      return true;
    } catch (e, st) {
      log("Order creation failed: $e");
      log(st.toString());
      return false;
    }
  }

  static Future<bool> addSingleOrder({
    required double totalAmount,
    required int phoneNumber,
    required String address,
    required double latitude,
    required double longitude,
    required int quantity,
    required List<OrderProductModel> products,
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
        orderDate: Timestamp.now(),
        orderId: orderDoc.id,
        createdAt: createdAt,
        products: products,
      );

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        log("Running Firestore transaction for order: ${orderDoc.id}");

        for (final orderedProduct in products) {
          final productId = orderedProduct.productid;

          if (productId.isEmpty) {
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

          // If the product does not have size variants, update the product's stock directly
          if (data.sizevariants == null || data.sizevariants!.isEmpty) {
            final currentTotalStock = data.stock ?? 0;

            if (currentTotalStock < orderedProduct.quantity) {
              log(
                "Insufficient stock for product $productId. Current stock: $currentTotalStock, Requested quantity: ${orderedProduct.quantity}",
              );
              throw Exception("Insufficient stock for product $productId");
            }

            // Update stock for the product without size variants
            transaction.update(productRefDoc, {
              'stock': currentTotalStock - orderedProduct.quantity,
            });

            log(
              "Stock updated for product: $productId, New Total Stock: ${currentTotalStock - orderedProduct.quantity}",
            );
          } else {
            // If the product has size variants, update stock for each variant
            final sizeVariants = data.sizevariants!;
            final orderedVariants = orderedProduct.sizevariants ?? [];

            final updatedVariants = sizeVariants.map((variant) {
              final variantSize = variant.size;
              final variantColor = variant.color;

              final matchingOrderedVariant = orderedVariants.firstWhere(
                (ordered) =>
                    ordered.size == variantSize &&
                    (ordered.color ?? '') == (variantColor ?? ''),
                orElse: () => SizeVariant(
                  size: variantSize,
                  color: variantColor,
                  stock: 0,
                ),
              );

              final currentStock = variant.size;
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
              (int sum, v) => sum + v.stock,
            );

            transaction.update(productRefDoc, {
              'sizevariants': updatedVariants,
              // Do not update product stock directly as size variants control the stock
            });

            log(
              "Stock updated for product: $productId, New Total Stock for variants: $sizeVariants",
            );
          }
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

  /// Save purchased products under `/users/{uid}/purchasedProducts`
  static Future<void> savePurchasedProducts({
    required List<ProductModel> products,
    required AddressModel address,
    required String paymentMethod,
  }) async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection(userCollection)
          .doc(currentUser);

      // Collection to hold purchased products
      final purchasedRef = userDocRef.collection('orders');

      for (final product in products) {
        final productId = product.productid ?? '';

        if (productId.isEmpty) {
          log("Skipping product with empty productId");
          continue;
        }

        final productDoc = purchasedRef.doc(productId);
        final snapshot = await productDoc.get();

        if (snapshot.exists) {
          // If product already exists, update quantity (increment)
          final currentData = snapshot.data() as Map<String, dynamic>;
          final currentQuantity = currentData['quantity'] ?? 0;

          await productDoc.update({
            'productId': productId,
            'quantity': currentQuantity + (product.quantity ?? 1),
            'lastPurchasedAt': FieldValue.serverTimestamp(),
            'paymentMethod': paymentMethod,
            'address': address.toMap(), // <-- save latest address used
          });

          log("Updated purchased product: $productId with new quantity");
        } else {
          // If product doesn't exist, create new entry
          await productDoc.set({
            ...product.toMap(),
            'quantity': product.quantity ?? 1,
            'firstPurchasedAt': FieldValue.serverTimestamp(),
            'lastPurchasedAt': FieldValue.serverTimestamp(),
            'paymentMethod': paymentMethod,
            'address': address.toMap(),
          });

          log("Added new purchased product: $productId");
        }
      }
    } catch (e, stack) {
      log("Error saving purchased products: $e");
      log("Stack: $stack");
    }
  }
}
