import 'package:deal_wise/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  
  static const String _baseUrl = 'https://accessories-eshop.runasp.net/api';
  static const String _registerEndpoint = '/auth/register';
  static const String _loginEndpoint = '/auth/login'; 

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ),
      );

 
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
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          // Common ASP.NET Core pattern: { title: 'One or more validation errors occurred.', errors: {Field: ['msg']}}
          if (data['errors'] is Map<String, dynamic>) {
            final errorsMap = data['errors'] as Map<String, dynamic>;
            final parts = <String>[];
            errorsMap.forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                parts.add(value.first.toString());
              } else if (value is String) {
                parts.add(value);
              }
            });
            if (parts.isNotEmpty) {
              message = parts.join("\n");
            }
          }
          message = message.isNotEmpty
              ? message
              : (data['message'] ?? data['error'] ?? data['title'] ?? "⚠️ Unknown error").toString();
        } else if (data is String && data.isNotEmpty) {
          message = data;
        } else {
          message = "⚠️ Unknown error";
        }
      } else {
        message = e.message ?? "⚠️ Unknown error";
      }

      throw Exception(message);
    }
  }

 
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
