import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/order/order_state.dart';
import 'package:sadhana_cart/core/common%20services/order/order_service.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState.initial());

  void addOrder({required OrderModel order}) async {
    state = state.copyWith(orders: [...state.orders, order]);
  }

  void fetchCustomOrderDetails() async {
    try {
      state = state.copyWith(isLoading: true, orders: [], error: null);
      final orders = await OrderService.fetchCustomerOrderDetails();
      state = state.copyWith(isLoading: false, orders: orders, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), orders: []);
    }
  }
}
