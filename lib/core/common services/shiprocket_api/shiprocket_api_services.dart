import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20services/shiprocket_api/token_provider.dart';

class ShiprocketApiServices {
  final Dio dio;
  // final Ref ref;
  final WidgetRef ref;

  ShiprocketApiServices(this.dio, this.ref);

  // --- Internal: Login & get token ---
  Future<String> _login(String email, String password) async {
    final response = await dio.post(
      'auth/login',
      data: {'email': email, 'password': password},
    );

    final token = response.data['token'] as String?;
    if (token == null) throw Exception("Failed to get token");

    ref.read(tokenProvider.notifier).state = token;
    return token;
  }

  // --- Check if token is expired ---
  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload =
          json.decode(
                utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
              )
              as Map<String, dynamic>;
      final exp = payload['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      return now >= exp;
    } catch (_) {
      return true; // Treat invalid token as expired
    }
  }

  // --- Get a valid token (refresh if expired) ---
  Future<String> _getValidToken() async {
    var token = ref.read(tokenProvider);

    if (token == null || _isTokenExpired(token)) {
      // Internal Shiprocket API credentials
      const apiUserEmail = 'your_api_user_email';
      const apiUserPassword = 'your_api_user_password';
      token = await _login(apiUserEmail, apiUserPassword);
    }

    return token;
  }

  // --- Public API methods ---

  Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    final token = await _getValidToken();
    final url = 'orders/create/adhoc';

    log("=== Shiprocket CREATE ORDER ===");
    log("URL: ${dio.options.baseUrl}$url");
    log("Headers: {'Authorization': '$token'}");
    log("Body: $orderData");

    final response = await dio.post(
      url,
      data: orderData,
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjc5MzQyMzgsInNvdXJjZSI6InNyLWF1dGgtaW50IiwiZXhwIjoxNzU5MDQ0NzI3LCJqdGkiOiJLSFJjbWZVNTNVbkVSaHd4IiwiaWF0IjoxNzU4MTgwNzI3LCJpc3MiOiJodHRwczovL3NyLWF1dGguc2hpcHJvY2tldC5pbi9hdXRob3JpemUvdXNlciIsIm5iZiI6MTc1ODE4MDcyNywiY2lkIjo3NDQ5MzI2LCJ0YyI6MzYwLCJ2ZXJib3NlIjpmYWxzZSwidmVuZG9yX2lkIjowLCJ2ZW5kb3JfY29kZSI6IiJ9.Im86qhebh13mHgd089WNlMTVm-2cwSnFaqNHGQ3O2yI',
        },
        validateStatus: (_) => true, // allow all status codes for logging
      ),
    );

    log("Status Code: ${response.statusCode}");
    log("Response: ${response.data}");

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getOrders({int page = 1}) async {
    final token = await _getValidToken();
    final response = await dio.get(
      'orders',
      queryParameters: {'page': page},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as Map<String, dynamic>;
  }

  // Get all order
  Future<Map<String, dynamic>> getAllOrders() async {
    final token = await _getValidToken();

    // URL path
    // final urlPath = 'orders';
    final fullUrl = '${dio.options.baseUrl}';

    // Log full URL and token before calling
    log("📦 Calling Shiprocket API GET: $fullUrl");
    log("🔑 Using token: $token");

    try {
      final response = await dio.get(
        fullUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true, // so we can log even if status != 200
        ),
      );

      // Log status code and body
      log("✅ Orders API status code: ${response.statusCode}");
      log("📄 Orders API body: ${response.data}");

      return response.data as Map<String, dynamic>;
    } catch (e) {
      log("❌ Error calling Orders API: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> trackOrder(String orderId) async {
    final token = await _getValidToken();
    final response = await dio.get(
      'orders/track/shipment/$orderId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    final token = await _getValidToken();
    final response = await dio.post(
      'orders/cancel/$orderId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as Map<String, dynamic>;
  }
}
