// All Products (latest by timestamp, with pagination)
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/product/product_service.dart';

final allProductsProvider =
    StateNotifierProvider<AllProductsNotifier, List<ProductModel>>(
      (ref) => AllProductsNotifier(ref)..initializeProducts(),
    );

class AllProductsNotifier extends StateNotifier<List<ProductModel>> {
  final Ref ref;
  AllProductsNotifier(this.ref) : super([]);

  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;
  final int _limit = 10;

  void initializeProducts() async {
    state = [];
    _lastDocument = null;
    _hasMore = true;
    await fetchNextProducts();
  }

  Future<void> fetchNextProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    try {
      Query query = FirebaseFirestore.instance
          .collection(ProductService.products)
          .orderBy("timestamp", descending: true) // latest products
          .limit(_limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        final products = snapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();

        // Add new products to the existing state
        final List<ProductModel> updatedList = List.from(state);
        updatedList.addAll(products);
        state = updatedList;

        _lastDocument = snapshot.docs.last;

        if (products.length < _limit) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
    } catch (e) {
      log("AllProductsNotifier fetch error: $e");
    }

    _isLoading = false;
  }

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;
}
