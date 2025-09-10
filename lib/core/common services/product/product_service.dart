import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

class ProductService {
  static const String products = "products";
  static final CollectionReference productRef = FirebaseFirestore.instance
      .collection(products);

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
}
