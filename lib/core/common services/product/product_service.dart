import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_fetch_result.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/features/rating/service/rating_service.dart';

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

      // log("Total products fetched: ${allProducts.length}");

      // Filter locally for match (case-insensitive)
      final filteredProducts = allProducts.where((product) {
        final name = product.name?.toLowerCase() ?? "";
        return name.contains(trimmedQuery);
      }).toList();

      // Log only matched products
      if (filteredProducts.isEmpty) {
        log("No products matched query '$query'");
      } else {
        for (var p in filteredProducts) {
          log("Matched product: ${p.name}");
        }
      }

      return filteredProducts;
    } catch (e, stackTrace) {
      log("ProductService fetch error: $e", stackTrace: stackTrace);
      return [];
    }
  }

  static Future<List<ProductModel>> getProductsByMoneyFilter({
    int? min,
    int? max,
    double? rating, // double rating
  }) async {
    try {
      log("Starting product filter: min=$min, max=$max, rating=$rating");

      Query query = productRef;

      if (min != null) {
        query = query.where("price", isGreaterThanOrEqualTo: min);
        log("Applying min price filter: $min");
      }

      if (max != null) {
        query = query.where("price", isLessThanOrEqualTo: max);
        log("Applying max price filter: $max");
      }

      final querySnapshot = await query.get();
      log("Products fetched from Firestore: ${querySnapshot.docs.length}");

      var products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      List<ProductModel> matchedProducts = [];

      if (rating != null) {
        log("Filtering by rating: $rating");

        // Process all ratings concurrently
        final futures = products.map((product) async {
          final avgRating = await RatingService.getAverageRating(
            productId: product.productid!,
          );

          if (avgRating >= rating && avgRating < rating + 1) {
            log(
              " Matched product: ${product.name} | Price: ${product.price} | AvgRating: $avgRating",
            );
            return product;
          } else {
            return null;
          }
        }).toList();

        final results = await Future.wait(futures);
        matchedProducts = results.whereType<ProductModel>().toList();
      } else {
        log("ℹ No rating filter applied, all products matched");
        matchedProducts = products;
      }

      log("Total matched products: ${matchedProducts.length}");
      return matchedProducts;
    } catch (e, stackTrace) {
      log("❌ ProductService fetch error: $e", stackTrace: stackTrace);
      return [];
    }
  }
}
