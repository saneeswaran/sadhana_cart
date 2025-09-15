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
          .orderBy("productid", descending: true)
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
      final QuerySnapshot querySnapshot = await productRef
          .limit(10)
          .orderBy('productid')
          .get();
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

  // Recommanded products (Based on the category)
  static Future<List<ProductModel>> getTopRatingProducts({
    int limit = 6,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await productRef
          .orderBy("rating", descending: true)
          .limit(limit)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        log("No top-rated products found");
        return [];
      }
    } catch (e) {
      log("ProductService getTopRatedProducts error: $e");
      return [];
    }
  }

  // static Future<List<ProductModel>> getProductByQuery({
  //   required String query,
  // }) async {
  //   try {
  //     log("Search started for query: '$query'");

  //     final trimmedQuery = query.trim();
  //     if (trimmedQuery.isEmpty) {
  //       log("Query is empty after trimming. Returning empty list.");
  //       return [];
  //     }

  //     final lowerQuery = trimmedQuery.toLowerCase();

  //     // Log the collection path and query range
  //     log("Firestore collection path: ${productRef.path}");
  //     log("Querying 'name_lower' from '$lowerQuery' to '${lowerQuery}\uf8ff'");

  //     // Optional: log all document names to see if data exists
  //     final allDocs = await productRef.get();

  //     log(
  //       "All products in collection: ${allDocs.docs.map((d) {
  //         final data = d.data() as Map<String, dynamic>?; // cast safely
  //         return data?['name'] ?? 'null';
  //       }).toList()}",
  //     );
  //     // Run the actual query
  //     final querySnapshot = await productRef
  //         .where("name_lower", isGreaterThanOrEqualTo: lowerQuery)
  //         .where("name_lower", isLessThanOrEqualTo: "$lowerQuery\uf8ff")
  //         .get();

  //     log("Number of documents fetched: ${querySnapshot.docs.length}");

  //     if (querySnapshot.docs.isNotEmpty) {
  //       final products = querySnapshot.docs
  //           .map(
  //             (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>),
  //           )
  //           .toList();

  //       log("Products returned: ${products.map((p) => p.name).toList()}");
  //       return products;
  //     } else {
  //       log("No products found for query: '$trimmedQuery'");
  //       return [];
  //     }
  //   } catch (e, stackTrace) {
  //     log("ProductService fetch error: $e", stackTrace: stackTrace);
  //     return [];
  //   }
  // }

  static Future<List<ProductModel>> getProductByQuery({
    required String query,
  }) async {
    try {
      log("Search started for query: '$query'");

      final trimmedQuery = query.trim().toLowerCase();
      if (trimmedQuery.isEmpty) {
        log("Query is empty after trimming. Returning empty list.");
        return [];
      }

      // Fetch all products
      final allDocs = await productRef.get();
      final allProducts = allDocs.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromMap(data);
      }).toList();

      // Filter locally for exact match (case-insensitive)
      final filteredProducts = allProducts.where((product) {
        final name = product.name?.toLowerCase() ?? "";
        return name.contains(trimmedQuery);
      }).toList();

      log(
        "Products matching query '$query': ${filteredProducts.map((p) => p.name).toList()}",
      );
      return filteredProducts;
    } catch (e, stackTrace) {
      log("ProductService fetch error: $e", stackTrace: stackTrace);
      return [];
    }
  }

  static Future<List<ProductModel>> getProductsByMoneyFilter({
    required int min,
    required int max,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await productRef
          .where("price", isGreaterThanOrEqualTo: min)
          .where("price", isLessThanOrEqualTo: max)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      } else {
        log("product not found");
        return [];
      }
    } catch (e) {
      log("ProductService fetch error: $e");
      return [];
    }
  }
}
