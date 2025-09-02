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
