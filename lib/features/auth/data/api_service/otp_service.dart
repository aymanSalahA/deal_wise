import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class OtpService {
  final Dio _dio = Dio();

  Future<bool> validateOtp(String email, String otp) async {
    const String url = 'https://accessories-eshop.runasp.net/api/auth/validate-otp';
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'otp': otp}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("Validate OTP response: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("OTP validation error: $e");
      throw Exception('OTP validation failed');
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
    } catch (e) {
      log("Resend OTP error: $e");
      throw Exception('Failed to resend OTP');
    }
  }
}
