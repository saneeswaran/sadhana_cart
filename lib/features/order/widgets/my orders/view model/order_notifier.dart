import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/model/order_model.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/model/order_state.dart';
import 'package:sadhana_cart/features/order/widgets/my%20orders/service/order_service.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
  (ref) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState.initial());

  void fetchOrders() async {
    //for loading state
    state = state.copyWith(loading: true, orders: []);
    //fetching the data from firebase
    final data = await OrderService.fetchOrders();
    //updating the state
    state = state.copyWith(loading: false, orders: data);
  }

  void addOrder({required OrderModel order}) {
    state = state.copyWith(orders: [...state.orders, order]);
  }
}
