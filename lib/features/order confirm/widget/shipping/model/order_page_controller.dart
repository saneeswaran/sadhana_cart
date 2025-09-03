import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_page.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/shipping/view/shipping_page.dart';
import 'package:sadhana_cart/features/order/widgets/order%20status/view/order_status_page.dart';

final List<Widget> orderPages = const [
  ShippingPage(),
  PaymentPage(),
  OrderStatusPage(),
];

final steps = [Icons.location_on, Icons.inventory_2, Icons.check];
