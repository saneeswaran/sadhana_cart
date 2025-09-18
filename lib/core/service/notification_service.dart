import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/admin/admin_model.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String notificationUrl =
      "https://sadhana-cart-notification.vercel.app/api/sendNotification";
  static const String admin = 'admin';
  static final CollectionReference adminRef = FirebaseFirestore.instance
      .collection(admin);
  static Future<void> sendNotification({
    required String title,
    required String message,
    required String screen,
  }) async {
    final DocumentSnapshot documentSnapshot = await adminRef.doc().get();
    if (documentSnapshot.exists) {
      final data = AdminModel.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
      );
      final adminToken = data.fcmtoken;

      http.post(
        Uri.parse(notificationUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'title': title,
          'body': message,
          'fcmtoken': adminToken,
          'screen': screen,
        }),
      );
    }
  }
}
