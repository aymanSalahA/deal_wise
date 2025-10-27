import 'package:dio/dio.dart';
import '../../../../core/utils/api_constants.dart';

class ResetPasswordService {
  final Dio _dio = Dio();

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        '${ApiConstants.baseUrl}reset-password',
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      );
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }
}
