import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
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
      for (final doc in products) {
        //i want to make some changes here... because i want to update the stock count of different size product
        final productId = doc.productId;
        final sizeList = doc.sizeOptions;
        final DocumentSnapshot documentSnapshot = await productRef
            .doc(productId)
            .get();
        if (documentSnapshot.exists) {
          documentSnapshot.reference.update({
            "totalStock": FieldValue.increment(-quantity),
            "sizeVariants": {},
          });
          ref.read(orderProvider.notifier).addOrder(order: orderModel);
        } else {
          log("product not found");
        }
      }
      await orderDoc.set(orderModel.toMap());
      return true;
    } catch (e) {
      log("order service error $e");
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
