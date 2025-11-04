import 'dart:developer';
import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/login';

    try {
      final response = await _dio.post(
        url,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      log('✅ Login Request Data: {"email": "$email", "password": "$password"}');
      log('✅ Response Status Code: ${response.statusCode}');
      log('✅ Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception('Login failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('❌ DioException occurred');
      log('❌ Status Code: ${e.response?.statusCode}');
      log('❌ Error Data: ${e.response?.data}');
      log('❌ Request Data: ${e.requestOptions.data}');
      
      String message = 'Login failed';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? data['title'] ?? message;
        } else if (data is String) {
          message = data;
        }
      }
      throw Exception(message);
    } catch (e) {
      log("❌ Unexpected Error: $e");
      throw Exception('Login failed: $e');
    }
  }
}
