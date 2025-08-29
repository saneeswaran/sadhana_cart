import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';

class CartNotifier extends StateNotifier<List<CartModel>> {
  CartNotifier() : super([]);
}
