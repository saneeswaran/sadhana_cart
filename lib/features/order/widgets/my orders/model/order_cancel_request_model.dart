import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCancelRequestModel {
  final String requestId;
  final String orderId;
  final String userId;
  final String reason;
  final String cancelledBy;
  final Timestamp requestedAt;
  OrderCancelRequestModel({
    required this.requestId,
    required this.orderId,
    required this.userId,
    required this.reason,
    required this.cancelledBy,
    required this.requestedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'reason': reason,
      'cancelledBy': cancelledBy,
      'requestedAt': requestedAt,
    };
  }

  factory OrderCancelRequestModel.fromMap(Map<String, dynamic> map) {
    return OrderCancelRequestModel(
      requestId: map['requestId'] as String,
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      reason: map['reason'] as String,
      cancelledBy: map['cancelledBy'] as String,
      requestedAt: map['requestedAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCancelRequestModel.fromJson(String source) =>
      OrderCancelRequestModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
