import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/product/product_service.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final productProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>(
      (ref) => ProductNotifier(ref)..initializeProducts(),
    );

final productByCategoryProvider = FutureProvider.autoDispose
    .family<List<ProductModel>, String>((ref, category) async {
      return await ProductService.getProductsByCategory(category: category);
    });

final productBySubcategoryProvider = FutureProvider.autoDispose
    .family<List<ProductModel>, String>((ref, subcategory) async {
      return await ProductService.getProductsBySubcategory(
        subcategory: subcategory,
      );
    });

final productByBrandProvider = FutureProvider.autoDispose
    .family<List<ProductModel>, String>((ref, brand) async {
      return await ProductService.getProductByBrands(brand: brand);
    });

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  final Ref ref;
  ProductNotifier(this.ref) : super([]);

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
          .orderBy("productId", descending: true)
          .limit(_limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        final products = snapshot.docs
            .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();

        state = [...state, ...products];
        log(state.toString());
        _lastDocument = snapshot.docs.last;

        if (products.length < _limit) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
    } catch (e) {
      log(e.toString());
    }

    _isLoading = false;
  }

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  void filterProducts({required String query}) {
    state = state
        .where(
          (e) =>
              e.name!.toLowerCase().contains(query.toLowerCase()) ||
              e.category!.toLowerCase().contains(query.toLowerCase()) ||
              e.subcategory!.toLowerCase().contains(query.toLowerCase()) ||
              e.brand!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
