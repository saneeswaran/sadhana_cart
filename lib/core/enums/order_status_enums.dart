import 'package:flutter/material.dart';

enum OrderStatusEnums { pending, processing, shipped, delivered, cancelled }

extension OrderStatusEnumsExtension on OrderStatusEnums {
  String get label {
    switch (this) {
      case OrderStatusEnums.pending:
        return "Pending";
      case OrderStatusEnums.processing:
        return "Processing";
      case OrderStatusEnums.shipped:
        return "Shipped";
      case OrderStatusEnums.delivered:
        return "Delivered";
      case OrderStatusEnums.cancelled:
        return "Cancelled";
    }
  }
}

extension OrderStatusEnumColorExtension on OrderStatusEnums {
  Color get color {
    switch (this) {
      case OrderStatusEnums.pending:
        return Colors.yellow;
      case OrderStatusEnums.processing:
        return Colors.blue;
      case OrderStatusEnums.shipped:
        return Colors.green;
      case OrderStatusEnums.delivered:
        return Colors.green;
      case OrderStatusEnums.cancelled:
        return Colors.red;
    }
  }
}
