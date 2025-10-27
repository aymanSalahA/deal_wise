import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ForgotPasswordService {
  final Dio _dio = Dio();
  Future<void> sendResetLink(String email) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/forgot-password';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      log("Status code: ${response.statusCode}");
      log("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // ignore: avoid_log
        log("Reset link sent successfully");
      } else {
        throw Exception('Failed to send reset link');
      }
    } catch (e) {
      // ignore: avoid_log
      log("Error sending reset link: $e");
      throw Exception('Failed to send reset link');
    }
  }
}
