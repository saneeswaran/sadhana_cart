// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sadhana_cart/features/order/widgets/my%20orders/model/order_model.dart';

class OrderState {
  final bool loading;
  final List<OrderModel> orders;
  OrderState({required this.loading, required this.orders});

  factory OrderState.initial() {
    return OrderState(loading: false, orders: []);
  }

  OrderState copyWith({bool? loading, List<OrderModel>? orders}) {
    return OrderState(
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
    );
  }
}
