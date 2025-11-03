import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_constants.dart';

class ResetPasswordService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> resetPassword({
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(response.data);
      }
      return {'success': true};
    } else {
      throw Exception('Reset password failed with status ${response.statusCode}');
    }
  }
}
