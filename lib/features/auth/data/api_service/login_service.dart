import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/login';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("Login status: ${response.statusCode}");
      log("Response data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      log("Login error: $e");
      throw Exception('Login failed: $e');
    }
  }
}
