import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/model/order_model.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/view%20model/order_notifier.dart';

class OrderService {
  static final currentUser = FirebaseAuth.instance.currentUser!.uid;

  static final CollectionReference orderRef = FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser)
      .collection("orders");

  static final CollectionReference cancelRequestRef = FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser)
      .collection("cancelRequest");

  static Future<bool> addOrder({
    required double totalAmount,
    required String address,
    required int phoneNumber,
    required double latitude,
    required double longitude,
    required String orderStatus,
    required String orderDate,
    required List<Map<String, dynamic>> products,
    required WidgetRef ref,
  }) async {
    try {
      final docRef = orderRef.doc();
      final Timestamp currentTime = Timestamp.now();
      final OrderModel orderModel = OrderModel(
        userId: currentUser,
        totalAmount: totalAmount,
        address: address,
        phoneNumber: phoneNumber,
        latitude: latitude,
        longitude: longitude,
        orderStatus: orderStatus,
        orderDate: orderDate,
        orderId: docRef.id,
        createdAt: currentTime,
        products: products,
      );
      await docRef.set(orderModel.toMap());
      ref.read(orderProvider.notifier).addOrder(order: orderModel);
      return true;
    } catch (e) {
      log("order service error $e");
      return false;
    }
  }

  //fetch

  static Future<List<OrderModel>> fetchOrders() async {
    try {
      final QuerySnapshot querySnapshot = await orderRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      }
    } catch (e) {
      log("order service error $e");
      return [];
    }
    return [];
  }
}
