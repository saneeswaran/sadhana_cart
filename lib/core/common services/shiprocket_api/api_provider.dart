import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://apiv2.shiprocket.in/v1/external/',
      headers: {'Content-Type': 'application/json'},
    ),
  );
});
