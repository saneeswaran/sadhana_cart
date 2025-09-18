import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/order/order_state.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/order/order_service.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState.initial());

  List<OrderModel> allOrders = [];
  List<OrderModel> filterOrder = [];

  void addOrder({required OrderModel order}) async {
    state = state.copyWith(orders: [...state.orders, order]);
  }

  void fetchCustomOrderDetails() async {
    try {
      state = state.copyWith(isLoading: true, orders: [], error: null);
      final orders = await OrderService.fetchCustomerOrderDetails();
      allOrders = orders;
      state = state.copyWith(isLoading: false, orders: orders, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), orders: []);
    }
  }

  /// Save purchased products for current user
  Future<void> savePurchasedProducts({
    required List<ProductModel> products,
    required AddressModel address,
    required String paymentMethod,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await OrderService.savePurchasedProducts(
        products: products,
        address: address,
        paymentMethod: paymentMethod,
      );

      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterOrderByStatus({required String query}) {
    if (query.toLowerCase() == 'all') {
      state = state.copyWith(orders: allOrders);
      return;
    }

    final filteredOrders = allOrders.where((order) {
      return order.orderStatus?.toLowerCase() == query.toLowerCase();
    }).toList();

    state = state.copyWith(orders: filteredOrders);
  }
}
