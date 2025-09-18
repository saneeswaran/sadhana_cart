import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sadhana_cart/core/common%20model/admin/admin_model.dart';
import 'package:dio/dio.dart';

class NotificationService {
  static final Dio dio = Dio();
  // 1. Initialize local notifications
  static const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
  );
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

      dio.post(
        notificationUrl,
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'title': title,
          'body': message,
          'fcmtoken': adminToken,
          'screen': screen,
        },
      );
    }
  }

  static Future<void> initialize() async {
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse: (details) => details,
      onDidReceiveNotificationResponse: (details) => details,
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification opened: ${message.data}");
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      log("App launched by notification: ${initialMessage.data}");
    }
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          channelDescription: 'Used for general notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(0, title, body, platformDetails);
  }
}
