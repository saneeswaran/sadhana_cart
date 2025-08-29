import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class ProductService {
  static const String products = "products";
  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(products);

  static Future<List<ProductModel>> fetchProducts({
    required Ref ref,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      ref.read(loadingProvider.notifier).state = true;

      Query query = productRef
          .orderBy("timestamp", descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final querySnapshot = await query.get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      // Store in Hive
      for (final product in data) {
        await HiveHelper.addProducts(product: product);
      }

      ref.read(loadingProvider.notifier).state = false;

      return data;
    } catch (e) {
      log("ProductService fetch error: $e");
      ref.read(loadingProvider.notifier).state = false;
      return [];
    }
  }
}
