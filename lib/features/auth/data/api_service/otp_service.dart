import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class OtpService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> validateOtp(String email, String otp) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/validate-otp';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'otp': otp}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("Validate OTP response: ${response.data}");
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return Map<String, dynamic>.from(response.data);
        }
        return {'success': true};
      } else {
        throw Exception('OTP validation failed with status ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("OTP validation error: $e");
      String message = 'OTP validation failed';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        } else if (data is String) {
          message = data;
        }
      }
      throw Exception(message);
    } catch (e) {
      log("OTP validation error: $e");
      throw Exception('OTP validation failed');
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String email, String otp) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/verify-email';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'otp': otp}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("Verify Email response: ${response.data}");
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return Map<String, dynamic>.from(response.data);
        }
        return {'success': true};
      } else {
        throw Exception('Verify email failed with status ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("Verify email error: $e");
      String message = 'Email verification failed';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        } else if (data is String) {
          message = data;
        }
      }
      throw Exception(message);
    } catch (e) {
      log("Verify email error: $e");
      throw Exception('Email verification failed');
    }
  }

  Future<bool> resendOtp(String email) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/resend-otp';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("Resend OTP response: ${response.data}");
      return response.statusCode == 200;
    } on DioException catch (e) {
      log("Resend OTP error: $e");
      String message = 'Failed to resend OTP';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        } else if (data is String) {
          message = data;
        }
      }
      throw Exception(message);
    } catch (e) {
      log("Resend OTP error: $e");
      throw Exception('Failed to resend OTP');
    }
  }
}
