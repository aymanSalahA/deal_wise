import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_constants.dart';

class ResetPasswordService {
  final Dio _dio = Dio();

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final url = '${ApiConstants.baseUrl}reset-password';
    log('🌍 POST $url');
    log('📦 Sending: {email: $email, otp: $otp, newPassword: $newPassword}');

    final response = await _dio.post(
      url,
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    log('✅ Response status: ${response.statusCode}');
    log('✅ Response data: ${response.data}');
  }
}
