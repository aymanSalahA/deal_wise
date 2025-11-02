import 'package:deal_wise/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  // 🔹 رابط الـ API الأساسي
  static const String _baseUrl = 'https://accessories-eshop.runasp.net/api';
  static const String _registerEndpoint = '/auth/register';
  static const String _loginEndpoint = '/auth/login'; // ✅ أضفنا اللوجين هنا

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  // ✅ تسجيل حساب جديد
  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final requestData = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    try {
      final response = await _dio.post(
        _registerEndpoint,
        data: requestData.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          '❌ Registration failed: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      String message = "";

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        message = "⏳ Connection timeout!";
      } else if (e.response != null) {
        message =
            e.response?.data['message'] ??
            e.response?.data['error'] ??
            "⚠️ Unknown error";
      }

      throw Exception(message);
    }
  }

  // ✅ تسجيل الدخول
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        _loginEndpoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          '❌ Login failed: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      String message = "";

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        message = "⏳ Connection timeout!";
      } else if (e.response != null) {
        message =
            e.response?.data['message'] ??
            e.response?.data['error'] ??
            "⚠️ Invalid credentials";
      }

      throw Exception(message);
    }
  }
}
