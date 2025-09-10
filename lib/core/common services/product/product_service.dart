import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_fetch_result.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';

class ProductService {
  static const String products = "products";
  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(products);

  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<ProductFetchResult> fetchProductByPagination({
    required Ref ref,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      ref.read(loadingProvider.notifier).state = true;

      Query query = productRef
          .orderBy("productId", descending: true)
          .limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final querySnapshot = await query.get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      ref.read(loadingProvider.notifier).state = false;

      return ProductFetchResult(
        products: data,
        lastDocument: querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.last
            : null,
      );
    } catch (e) {
      log("ProductService fetch error: $e");
      ref.read(loadingProvider.notifier).state = false;
      return ProductFetchResult(products: [], lastDocument: null);
    }
  }

  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final QuerySnapshot querySnapshot = await productRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      }
      return [];
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
  }

  static Future<List<ProductModel>> getProductsByCategory({
    required String category,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await productRef
          .where("category", isEqualTo: category)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      }
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
    return [];
  }

  static Future<List<ProductModel>> getProductsBySubcategory({
    required String subcategory,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await productRef
          .where("subcategory", isEqualTo: subcategory)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      }
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
    return [];
  }

  static Future<List<ProductModel>> getProductByBrands({
    required String brand,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await productRef
          .where("brand", isEqualTo: brand)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return data;
      }
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
    return [];
  }

  //pagination

  static Future<List<ProductModel>> getFeatureProducts() async {
    try {
      final QuerySnapshot querySnapshot = await productRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        log("feature product not found");
        return [];
      }
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
  }
}
