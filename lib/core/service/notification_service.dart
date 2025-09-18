import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sadhana_cart/core/common%20model/admin/admin_model.dart';
import 'package:dio/dio.dart';

class NotificationService {
  static final Dio dio = Dio();

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

  // Background message handler (must be static or top-level)
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    log("Handling a background message: ${message.messageId}");
    await _showNotification(
      title: message.notification?.title ?? 'Background Notification',
      body: message.notification?.body ?? 'You have a new message',
    );
  }

  static Future<void> sendNotification({
    required String title,
    required String message,
    required String screen,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await adminRef.get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = AdminModel.fromMap(doc.data() as Map<String, dynamic>);
        final adminToken = data.fcmtoken;

        await dio.post(
          notificationUrl,
          options: Options(contentType: Headers.jsonContentType),
          data: {
            'title': title,
            'body': message,
            'fcmtoken': adminToken,
            'screen': screen,
          },
        );
        log('Notification sent successfully');
      }
    } catch (e) {
      log('Error sending notification: $e');
    }
  }

  static Future<void> initialize() async {
    try {
      // Set background message handler FIRST
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Initialize local notifications
      await _localNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
          log('Notification clicked: ${details.payload}');
        },
      );

      // Create notification channel for Android
      await _createNotificationChannel();

      // Request permissions
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );
      }

      // Foreground message handler
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Foreground message received: ${message.messageId}');
        if (message.notification != null) {
          _showNotification(
            title: message.notification!.title ?? 'New Notification',
            body: message.notification!.body ?? 'You have a new message',
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log("Notification opened: ${message.data}");
      });

      // Get FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      log("FCM Token: $token");

      // Handle token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        log("New FCM Token: $newToken");
      });
    } catch (e) {
      log('Error initializing notifications: $e');
    }
  }

  static Future<void> _createNotificationChannel() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // Must match channel ID in manifest
        'General Notifications',
        description: 'Used for general notifications',
        importance: Importance.max,
      );

      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel', // Must match channel ID
            'General Notifications',
            channelDescription: 'Used for general notifications',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
            playSound: true,
          );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      await _localNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title,
        body,
        platformDetails,
      );
      log('Local notification shown: $title');
    } catch (e) {
      log('Error showing notification: $e');
    }
  }

  // Method to get current FCM token
  static Future<String?> getFCMToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  // Method to subscribe to topics
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      log('Subscribed to topic: $topic');
    } catch (e) {
      log('Error subscribing to topic: $e');
    }
  }

  // Method to unsubscribe from topics
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      log('Unsubscribed from topic: $topic');
    } catch (e) {
      log('Error unsubscribing from topic: $e');
    }
  }
}
